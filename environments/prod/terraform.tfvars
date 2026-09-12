# Configuración de producción para el servicio de notificaciones
# Este archivo contiene los valores específicos del ambiente de producción
# CUMPLE con requisitos de alta disponibilidad, seguridad y auditoría

# Configuración de red
environment               = "prod"
common_tags = {
  Environment = "prod"
  Service     = "notifications"
  Owner       = "cloudops-team"
  Project     = "financial-platform"
  CostCenter  = "engineering"
  Compliance  = "PCI-DSS"
  DataClassification = "Confidential"
}

# VPC Configuration
vpc_cidr_block           = "10.2.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
public_subnet_cidrs      = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24", "10.2.4.0/24", "10.2.5.0/24"]
private_subnet_cidrs     = ["10.2.10.0/24", "10.2.20.0/24", "10.2.30.0/24", "10.2.40.0/24", "10.2.50.0/24"]
database_subnet_cidrs    = ["10.2.100.0/24", "10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24", "10.2.104.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = false
enable_vpn               = true

# DNS Configuration
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración del servicio de notificaciones
notifications_config = {
  # SNS Topic Configuration
  sns_topic_name                    = "prod-notifications-topic"
  sns_topic_fifo                    = true
  sns_topic_content_based_deduplication = true
  sns_topic_delivery_policy         = "fifo"
  sns_topic_trace_enabled           = true
  sns_topic_subscription_confirm    = true
  
  # SQS Queue Configuration
  sqs_queue_name                    = "prod-notifications-queue"
  sqs_queue_fifo                    = true
  sqs_queue_dlq_name                = "prod-notifications-dlq"
  sqs_queue_max_message_size        = 262144
  sqs_queue_message_retention_seconds = 1209600
  sqs_queue_visibility_timeout_seconds = 1200
  sqs_queue_receive_wait_time_seconds = 20
  sqs_queue_redrive_policy_max_receive_count = 10
  sqs_queue_deduplication_scope     = "messageGroup"
  sqs_queue_fifo_throughput_limit   = "perMessageGroupId"
  
  # Lambda Function Configuration
  lambda_function_name         = "prod-notifications-processor"
  lambda_function_runtime      = "python3.11"
  lambda_function_timeout      = 300
  lambda_function_memory_size  = 2048
  lambda_function_handler      = "index.handler"
  lambda_function_description  = "Procesador de notificaciones para ambiente de producción"
  lambda_layers                = []
  lambda_function_ephemeral_storage = 10240
  
  # Dead Letter Configuration
  enable_dlq                   = true
  dlq_max_receive_count        = 10
  
  # Retry Configuration
  max_retry_attempts           = 10
  retry_delay_seconds          = 300
  exponential_backoff          = true
  
  # Rate Limiting
  enable_rate_limiting         = true
  rate_limit_requests_per_second = 10000
  burst_limit                  = 20000
  
  # Throttling
  enable_throttling            = true
  throttle_quota               = 50000
  throttle_rate_per_second     = 5000
}

# Configuración de seguridad
security_config = {
  # KMS Keys
  enable_kms_encryption        = true
  kms_key_description          = "Clave de cifrado para notificaciones producción"
  kms_key_deletion_window_days = 30
  kms_key_rotation_enabled     = true
  
  # IAM Policies - Principio de menor privilegio
  enable_restrictive_policies  = true
  allowed_aws_principals       = ["arn:aws:iam::123456789012:role/production-automation-role"]
  enforce_mfa                  = true
  
  # VPC Endpoints
  enable_vpc_endpoints         = true
  s3_vpc_endpoint_enabled      = true
  sns_vpc_endpoint_enabled     = true
  sqs_vpc_endpoint_enabled     = true
  logs_vpc_endpoint_enabled    = true
  secretsmanager_vpc_endpoint_enabled = true
  
  # Security Group
  enable_security_group        = true
  security_group_name          = "prod-notifications-sg"
  allowed_cidr_blocks          = []
  allowed_ports                = [443]
  enable_intra_security_group  = true
  
  # Logging - Cumplimiento PCI-DSS
  enable_detailed_logging      = true
  log_retention_days           = 90
  enable_cloudtrail            = true
  enable_vpc_flow_logs         = true
  flow_log_destination_type    = "cloud-watch-logs"
  
  # WAF Configuration
  enable_waf                   = true
  waf_rules = [
    "AWSManagedRulesCommonRuleSet",
    "AWSManagedRulesSQLiRuleSet",
    "AWSManagedRulesKnownBadInputsRuleSet"
  ]
}

# Configuración de monitoreo
monitoring_config = {
  # CloudWatch Metrics
  enable_metrics               = true
  metric_namespace             = "FinancialPlatform/Notifications"
  detailed_metrics_enabled     = true
  
  # Alarms - Umbrales estrictos para producción
  enable_alarms                = true
  alarm_error_threshold        = 50
  alarm_latency_threshold_ms   = 5000
  alarm_queue_depth_threshold  = 50000
  alarm_throttle_threshold     = 100
  alarm_dlq_depth_threshold    = 100
  
  # Dashboards
  enable_dashboard             = true
  dashboard_name               = "prod-notifications-dashboard"
  dashboard_refresh_interval   = 60
  
  # Logs
  enable_logging               = true
  log_level                    = "WARNING"
  log_compression              = "gzip"
  
  # Events
  enable_cloudwatch_events     = true
  enable_eventbridge           = true
  event_pattern = {
    source      = ["aws.notifications", "aws.lambda", "aws.sns", "aws.sqs"]
    detail-type = ["Notification", "Invocation", "SubscriptionConfirmation"]
  }
  
  # Synthetic Monitoring
  enable_synthetics            = true
  synthetic_check_interval     = 300
}

# Configuración de alta disponibilidad
ha_config = {
  enable_multi_az              = true
  min_size                     = 3
  max_size                     = 10
  desired_capacity             = 5
  health_check_type            = "ELB"
  health_check_grace_period    = 600
  enable_auto_scaling          = true
  scaling_metric               = "CPUUtilization"
  scaling_target_value         = 70
  scale_in_cooldown            = 300
  scale_out_cooldown           = 60
}

# Configuración de costos
cost_optimization = {
  enable_cost_monitoring       = true
  budget_alert_threshold       = 1000
  budget_alert_action          = "Alert"
  enable_s3_intelligent_tiering = true
  enable_ec2_spot_instances    = false
  enable_cost_anomaly_detection = true
  enable_reserved_instances    = true
  savings_plan_eligible        = true
}

# Configuración de recuperación ante desastres
dr_config = {
  enable_backup                = true
  backup_frequency             = "hourly"
  retention_days               = 30
  enable_cross_region_replication = true
  replication_region           = "us-west-2"
  rto_hours                    = 1
  rpo_hours                    = 0
  enable_pitr                  = true
  enable_disaster_recovery drills = true
  drill_frequency              = "quarterly"
}

# Configuración de auditoría y cumplimiento
compliance_config = {
  enable_aws_config            = true
  enable_security_hub          = true
  enable_guardduty             = true
  enable_macie                 = true
  enable_inspector             = true
  enable_audit_manager         = true
  compliance_standards         = ["PCI-DSS", "SOC2", "HIPAA"]
  enable_resource_tagging      = true
  mandatory_tags               = ["Environment", "Service", "Owner", "Compliance", "DataClassification"]
}