terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Service     = "notifications"
      Owner       = "cloudops-team"
      ManagedBy   = "Terraform"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc-${var.environment}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = var.environment == "dev"
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Type = "Networking"
  }
}

resource "aws_sns_topic" "notifications" {
  name              = "${var.project_name}-notifications-${var.environment}"
  display_name      = "Notificaciones del Sistema Financiero"
  fifo_topic        = false
  content_based_deduplication = false

  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget        = 20
        maxDelayTarget        = 20
        numRetries            = 3
        numMaxDelayRetries    = 3
        backoffFunction       = "exponential"
      }
      defaultThrottlePolicy = {
        maxReceivesPerSecond = 100
      }
    }
  })

  tags = {
    Description = "Topic principal para notificaciones del servicio financiero"
  }
}

resource "aws_sns_topic" "notifications_dlq" {
  name              = "${var.project_name}-notifications-dlq-${var.environment}"
  display_name      = "Dead Letter Queue para Notificaciones"
  fifo_topic        = false

  tags = {
    Description = "Cola de mensajes fallidos para notificaciones"
  }
}

resource "aws_sqs_queue" "notifications_queue" {
  name                       = "${var.project_name}-notifications-queue-${var.environment}"
  max_message_size           = 262144
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 300
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sns_topic.notifications_dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Description = "Cola principal para procesamiento de notificaciones"
  }
}

resource "aws_sqs_queue" "notifications_dlq" {
  name                       = "${var.project_name}-notifications-dlq-queue-${var.environment}"
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  visibility_timeout_seconds = 300

  tags = {
    Description = "Dead Letter Queue para mensajes de notificación fallidos"
  }
}

resource "aws_sns_topic_subscription" "notifications_sqs_target" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notifications_queue.arn
  raw_message_delivery = false
  filter_policy_scope = "MessageBody"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/notification_handler.py"
  output_path = "${path.module}/lambda/notification_handler.zip"
}

resource "aws_lambda_function" "notification_processor" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.project_name}-notification-processor-${var.environment}"
  role            = aws_iam_role.lambda_notification_processor.arn
  handler         = "notification_handler.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime         = "python3.11"
  timeout         = 300
  memory_size     = 256

  environment {
    variables = {
      ENVIRONMENT           = var.environment
      LOG_LEVEL             = var.log_level
      SNS_TOPIC_ARN         = aws_sns_topic.notifications.arn
      DLQ_URL               = aws_sqs_queue.notifications_dlq.url
      MAX_RETRIES           = "3"
      BATCH_SIZE            = "10"
    }
  }

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.lambda_notifications.id]
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_notification_processor_policy]

  tags = {
    Description = "Función Lambda para procesamiento de notificaciones"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn  = aws_sqs_queue.notifications_queue.arn
  function_name     = aws_lambda_function.notification_processor.arn
  batch_size        = 10
  maximum_batching_window_in_seconds = 60
  enabled           = true
  retry_strategy {
    maximum_retry_attempts = 5
  }
}

resource "aws_iam_role" "lambda_notification_processor" {
  name = "${var.project_name}-lambda-notification-processor-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Description = "Rol IAM para función Lambda de procesamiento de notificaciones"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_notification_processor_policy" {
  role       = aws_iam_role.lambda_notification_processor.name
  policy_arn = aws_iam_policy.lambda_notification_processor_policy.arn
}

resource "aws_iam_policy" "lambda_notification_processor_policy" {
  name = "${var.project_name}-lambda-notification-policy-${var.environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = [
          aws_sqs_queue.notifications_queue.arn,
          aws_sqs_queue.notifications_dlq.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:ListSubscriptionsByTopic"
        ]
        Resource = aws_sns_topic.notifications.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Description = "Política de permisos para Lambda de notificaciones"
  }
}

resource "aws_security_group" "lambda_notifications" {
  name        = "${var.project_name}-lambda-notifications-${var.environment}"
  description = "Security group para función Lambda de notificaciones"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Tráfico interno de la VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida a internet a través de NAT Gateway"
  }

  tags = {
    Description = "SG para Lambda de notificaciones"
  }
}

resource "aws_cloudwatch_log_group" "notification_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.notification_processor.function_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Description = "Log group para Lambda de notificaciones"
  }
}

resource "aws_cloudwatch_metric_alarm" "notification_errors" {
  alarm_name          = "${var.project_name}-notification-errors-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "Alarma cuando la función Lambda de notificaciones genera errores"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    FunctionName = aws_lambda_function.notification_processor.function_name
  }

  tags = {
    Severity = "High"
  }
}

resource "aws_cloudwatch_metric_alarm" "notification_latency" {
  alarm_name          = "${var.project_name}-notification-latency-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Average"
  threshold           = var.latency_threshold_ms
  alarm_description   = "Alarma cuando la latencia de Lambda excede el umbral"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    FunctionName = aws_lambda_function.notification_processor.function_name
  }

  tags = {
    Severity = "Medium"
  }
}

resource "aws_cloudwatch_metric_alarm" "sqs_queue_depth" {
  alarm_name          = "${var.project_name}-sqs-queue-depth-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 300
  statistic           = "Maximum"
  threshold           = var.sqs_queue_depth_threshold
  alarm_description   = "Alarma cuando la cola SQS tiene muchos mensajes pendientes"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    QueueName = aws_sqs_queue.notifications_queue.name
  }

  tags = {
    Severity = "Medium"
  }
}

resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  alarm_name          = "${var.project_name}-dlq-messages-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "Alarma cuando hay mensajes en la Dead Letter Queue"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    QueueName = aws_sqs_queue.notifications_dlq.name
  }

  tags = {
    Severity = "Critical"
  }
}