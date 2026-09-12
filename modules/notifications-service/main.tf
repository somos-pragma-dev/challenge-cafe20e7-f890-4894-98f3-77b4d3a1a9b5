module "sns_topics" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  topics = {
    notifications = {
      name               = "${var.project}-${var.environment}-notifications"
      display_name       = "Main notifications topic"
      kms_master_key_id  = var.kms_key_arn
      tags               = var.common_tags
    }
    alerts = {
      name               = "${var.project}-${var.environment}-alerts"
      display_name       = "Alerts notifications topic"
      kms_master_key_id  = var.kms_key_arn
      tags               = var.common_tags
    }
  }

  subscription = {
    notifications = [
      {
        protocol  = "sqs"
        endpoint  = module.sqs_queues.notifications_queue_arn
        raw_message_delivery = true
      }
    ]
    alerts = [
      {
        protocol  = "lambda"
        endpoint  = module.lambda_function.alert_lambda_arn
      }
    ]
  }
}

module "sqs_queues" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 4.0"

  name_prefix = "${var.project}-${var.environment}-"

  queues = {
    notifications = {
      name                        = "notifications-queue"
      visibility_timeout_seconds  = 300
      max_message_size            = 262144
      message_retention_seconds   = 345600
      receive_wait_time_seconds   = 20
      redrive_policy = {
        dead_letter_target_arn = module.sqs_queues.dlq_notifications_queue_arn
        max_receive_count      = 5
      }
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
    alerts = {
      name                        = "alerts-queue"
      visibility_timeout_seconds  = 180
      max_message_size            = 262144
      message_retention_seconds   = 604800
      receive_wait_time_seconds   = 10
      redrive_policy = {
        dead_letter_target_arn = module.sqs_queues.dlq_alerts_queue_arn
        max_receive_count      = 3
      }
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
  }

  dlqs = {
    notifications = {
      name              = "notifications-dlq"
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
    alerts = {
      name              = "alerts-dlq"
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
  }

  tags = var.common_tags
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${var.project}-${var.environment}-notifications-processor"

  description = "Lambda function for processing notification events"
  runtime     = "python3.11"
  handler     = "index.lambda_handler"
  timeout     = 300
  memory_size = 256

  source_path = "${path.module}/../../lambda/notification-processor"

  environment {
    variables = {
      ENVIRONMENT = var.environment
      LOG_LEVEL   = var.log_level
      SNS_REGION  = var.aws_region
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  kms_key_arn         = var.kms_key_arn
  attach_policy       = true
  policy_name         = "${var.project}-${var.environment}-lambda-notifications-policy"

  allowed_triggers = {
    SQS = {
      service = "sqs"
      source_arn = module.sqs_queues.alerts_queue_arn
    }
    SNS = {
      service = "sns"
      source_arn = module.sns_topics.sns_topic_alerts_arn
    }
  }

  tags = var.common_tags
}

resource "aws_sns_topic_policy" "notifications_policy" {
  arn = module.sns_topics.sns_topic_notifications_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "notifications-topic-policy"
    Statement = [
      {
        Sid       = "AllowSQSQueueSubscription"
        Effect    = "Allow"
        Principal = {
          Service = "sqs.amazonaws.com"
        }
        Action    = "sns:Subscribe"
        Resource  = module.sns_topics.sns_topic_notifications_arn
        Condition = {
          StringEquals = {
            "aws:SourceAccount" : var.account_id
          }
        }
      },
      {
        Sid       = "AllowCloudWatchPublish"
        Effect    = "Allow"
        Principal = {
          Service = "logs.amazonaws.com"
        }
        Action    = ["sns:Publish", "sns:GetTopicAttributes"]
        Resource  = module.sns_topics.sns_topic_notifications_arn
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "notifications_queue_policy" {
  queue_url = module.sqs_queues.notifications_queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "notifications-queue-policy"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action    = "sqs:SendMessage"
        Resource  = module.sqs_queues.notifications_queue_arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : module.sns_topics.sns_topic_notifications_arn
          }
        }
      }
    ]
  })
}

resource "aws_kms_grant" "lambda_kms_grant" {
  name              = "${var.project}-${var.environment}-lambda-kms-grant"
  key_id            = var.kms_key_arn
  grantee_principal = module.lambda_function.lambda_function_iam_role_arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${module.lambda_function.function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}