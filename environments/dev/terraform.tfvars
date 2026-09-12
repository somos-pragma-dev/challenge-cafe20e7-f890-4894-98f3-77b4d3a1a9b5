# Configuración de desarrollo para el servicio de notificaciones
# Este archivo contiene los valores específicos del ambiente de desarrollo

# Configuración de red
environment               = "dev"
common_tags = {
  Environment = "dev"
  Service     = "notifications"
  Owner       = "cloudops-team"
  Project     = "financial-platform"
  CostCenter  = "engineering"
}

# VPC Configuration
vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs    = ["10.0.100.0/24", "10.0.101.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = true

# DNS Configuration
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración del servicio de notificaciones
notifications_config = {
  # SNS Topic Configuration
  sns_topic_name                    = "dev-notifications-topic"
  sns_topic_fifo                    = false
  sns_topic_content_based_deduplication = false
  sns_topic_delivery_policy         = "standard"
  sns_topic_trace_enabled           = true
  
  # SQS Queue Configuration
  sqs_queue_name                    = "dev-notifications-queue"
  sqs_queue_fifo                    = false
  sqs_queue_dlq_name                = "dev-notifications-dlq"
  sqs_queue_max_message_size        = 262144
  sqs_queue_message_retention_seconds = 345600
  sqs_queue_visibility_timeout_seconds = 300
  sqs_queue_receive_wait_time_seconds = 0
  sqs_queue_redrive_policy_max_receive_count = 3
  
  # Lambda Function Configuration
  lambda_function_name         = "dev-notifications-processor"
  lambda_function_runtime      = "python3.11"
  lambda_function_timeout      = 30
  lambda_function_memory_size  = 256
  lambda_function_handler      = "index.handler"
  lambda_function_description  = "Procesador de notificaciones para ambiente de desarrollo"
  lambda_layers                = []
  
  # Dead Letter Configuration
  enable_dlq                   = true
  dlq_max_receive_count        = 3
  
  # Retry Configuration
  max_retry_attempts           = 3
  retry_delay_seconds          = 60
  exponential_backoff          = true
  
  # Rate Limiting
  enable_rate_limiting         = false
  rate_limit_requests_per_second = 100
  burst_limit                  = 200
}

# Configuración de seguridad
security_config = {
  # KMS Keys
  enable_kms_encryption        = true
  kms_key_description          = "Clave de cifrado para notificaciones dev"
  kms_key_deletion_window_days = 7
  
  # IAM Policies
  enable_restrictive_policies  = false
  allowed_aws_principals       = []
  
  # VPC Endpoints
  enable_vpc_endpoints         = true
  s3_vpc_endpoint_enabled      = true
  sns_vpc_endpoint_enabled     = true
  sqs_vpc_endpoint_enabled     = true
  logs_vpc_endpoint_enabled    = true
  
  # Security Group
  enable_security_group        = true
  security_group_name          = "dev-notifications-sg"
  allowed_cidr_blocks          = ["10.0.0.0/16"]
  allowed_ports                = [443, 80]
  
  # Logging
  enable_detailed_logging      = true
  log_retention_days           = 7
}

# Configuración de monitoreo
monitoring_config = {
  # CloudWatch Metrics
  enable_metrics               = true
  metric_namespace             = "FinancialPlatform/Notifications"
  
  # Alarms
  enable_alarms                = true
  alarm_error_threshold        = 5
  alarm_latency_threshold_ms   = 1000
  alarm_queue_depth_threshold  = 1000
  
  # Dashboards
  enable_dashboard             = true
  dashboard_name               = "dev-notifications-dashboard"
  
  # Logs
  enable_logging               = true
  log_level                    = "DEBUG"
  
  # Events
  enable_cloudwatch_events     = true
  event_pattern = {
    source      = ["aws.notifications"]
    detail-type = ["Notification"]
  }
}

# Configuración de alta disponibilidad
ha_config = {
  enable_multi_az              = false
  min_size                     = 1
  max_size                     = 2
  desired_capacity             = 1
  health_check_type            = "ELB"
  health_check_grace_period    = 300
}

# Configuración de costos
cost_optimization = {
  enable_cost_monitoring       = true
  budget_alert_threshold       = 50
  enable_s3_intelligent_tiering = false
  enable_ec2_spot_instances    = false
}

# Configuración de recuperación ante desastres
dr_config = {
  enable_backup                = false
  backup_frequency             = "daily"
  retention_days               = 7
  enable_cross_region_replication = false
  rto_hours                    = 4
  rpo_hours                    = 1
}