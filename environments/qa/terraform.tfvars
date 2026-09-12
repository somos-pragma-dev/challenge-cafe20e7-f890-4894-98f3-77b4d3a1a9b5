# Configuración de QA para el servicio de notificaciones
# Este archivo contiene los valores específicos del ambiente de QA

# Configuración de red
environment               = "qa"
common_tags = {
  Environment = "qa"
  Service     = "notifications"
  Owner       = "cloudops-team"
  Project     = "financial-platform"
  CostCenter  = "engineering"
}

# VPC Configuration
vpc_cidr_block           = "10.1.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs      = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnet_cidrs     = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
database_subnet_cidrs    = ["10.1.100.0/24", "10.1.101.0/24", "10.1.102.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = false

# DNS Configuration
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración del servicio de notificaciones
notifications_config = {
  # SNS Topic Configuration
  sns_topic_name                    = "qa-notifications-topic"
  sns_topic_fifo                    = false
  sns_topic_content_based_deduplication = false
  sns_topic_delivery_policy         = "standard"
  sns_topic_trace_enabled           = true
  
  # SQS Queue Configuration
  sqs_queue_name                    = "qa-notifications-queue"
  sqs_queue_fifo                    = false
  sqs_queue_dlq_name                = "qa-notifications-dlq"
  sqs_queue_max_message_size        = 262144
  sqs_queue_message_retention_seconds = 604800
  sqs_queue_visibility_timeout_seconds = 600
  sqs_queue_receive_wait_time_seconds = 20
  sqs_queue_redrive_policy_max_receive_count = 5
  
  # Lambda Function Configuration
  lambda_function_name         = "qa-notifications-processor"
  lambda_function_runtime      = "python3.11"
  lambda_function_timeout      = 60
  lambda_function_memory_size  = 512
  lambda_function_handler      = "index.handler"
  lambda_function_description  = "Procesador de notificaciones para ambiente QA"
  lambda_layers                = []
  
  # Dead Letter Configuration
  enable_dlq                   = true
  dlq_max_receive_count        = 5
  
  # Retry Configuration
  max_retry_attempts           = 5
  retry_delay_seconds          = 120
  exponential_backoff          = true
  
  # Rate Limiting
  enable_rate_limiting         = true
  rate_limit_requests_per_second = 500
  burst_limit                  = 1000
}

# Configuración de seguridad
security_config = {
  # KMS Keys
  enable_kms_encryption        = true
  kms_key_description          = "Clave de cifrado para notificaciones QA"
  kms_key_deletion_window_days = 10
  
  # IAM Policies
  enable_restrictive_policies  = true
  allowed_aws_principals       = ["arn:aws:iam::123456789012:role/qa-automation-role"]
  
  # VPC Endpoints
  enable_vpc_endpoints         = true
  s3_vpc_endpoint_enabled      = true
  sns_vpc_endpoint_enabled     = true
  sqs_vpc_endpoint_enabled     = true
  logs_vpc_endpoint_enabled    = true
  
  # Security Group
  enable_security_group        = true
  security_group_name          = "qa-notifications-sg"
  allowed_cidr_blocks          = ["10.1.0.0/16"]
  allowed_ports                = [443]
  
  # Logging
  enable_detailed_logging      = true
  log_retention_days           = 14
}

# Configuración de monitoreo
monitoring_config = {
  # CloudWatch Metrics
  enable_metrics               = true
  metric_namespace             = "FinancialPlatform/Notifications"
  
  # Alarms
  enable_alarms                = true
  alarm_error_threshold        = 10
  alarm_latency_threshold_ms   = 2000
  alarm_queue_depth_threshold  = 5000
  
  # Dashboards
  enable_dashboard             = true
  dashboard_name               = "qa-notifications-dashboard"
  
  # Logs
  enable_logging               = true
  log_level                    = "INFO"
  
  # Events
  enable_cloudwatch_events     = true
  event_pattern = {
    source      = ["aws.notifications"]
    detail-type = ["Notification"]
  }
}

# Configuración de alta disponibilidad
ha_config = {
  enable_multi_az              = true
  min_size                     = 2
  max_size                     = 4
  desired_capacity             = 2
  health_check_type            = "ELB"
  health_check_grace_period    = 300
}

# Configuración de costos
cost_optimization = {
  enable_cost_monitoring       = true
  budget_alert_threshold       = 200
  enable_s3_intelligent_tiering = true
  enable_ec2_spot_instances    = false
}

# Configuración de recuperación ante desastres
dr_config = {
  enable_backup                = true
  backup_frequency             = "daily"
  retention_days               = 14
  enable_cross_region_replication = false
  rto_hours                    = 2
  rpo_hours                    = 1
}