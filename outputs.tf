output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnets
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnets
}

output "sns_topic_arn" {
  description = "ARN del topic SNS principal de notificaciones"
  value       = aws_sns_topic.notifications.arn
}

output "sns_topic_name" {
  description = "Nombre del topic SNS principal de notificaciones"
  value       = aws_sns_topic.notifications.name
}

output "sns_notifications_dlq_arn" {
  description = "ARN del topic SNS Dead Letter Queue"
  value       = aws_sns_topic.notifications_dlq.arn
}

output "sqs_queue_url" {
  description = "URL de la cola SQS principal de notificaciones"
  value       = aws_sqs_queue.notifications_queue.url
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS principal de notificaciones"
  value       = aws_sqs_queue.notifications_queue.arn
}

output "sqs_queue_name" {
  description = "Nombre de la cola SQS principal de notificaciones"
  value       = aws_sqs_queue.notifications_queue.name
}

output "sqs_dlq_url" {
  description = "URL de la Dead Letter Queue de SQS"
  value       = aws_sqs_queue.notifications_dlq.url
}

output "sqs_dlq_arn" {
  description = "ARN de la Dead Letter Queue de SQS"
  value       = aws_sqs_queue.notifications_dlq.arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda de procesamiento de notificaciones"
  value       = aws_lambda_function.notification_processor.function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda de procesamiento de notificaciones"
  value       = aws_lambda_function.notification_processor.arn
}

output "lambda_iam_role_arn" {
  description = "ARN del rol IAM de la función Lambda"
  value       = aws_iam_role.lambda_notification_processor.arn
}

output "lambda_security_group_id" {
  description = "ID del security group de la función Lambda"
  value       = aws_security_group.lambda_notifications.id
}

output "cloudwatch_log_group_name" {
  description = "Nombre del log group de CloudWatch para Lambda"
  value       = aws_cloudwatch_log_group.notification_lambda.name
}

output "alarm_notification_errors" {
  description = "Nombre de la alarma de errores de Lambda"
  value       = aws_cloudwatch_metric_alarm.notification_errors.alarm_name
}

output "alarm_notification_latency" {
  description = "Nombre de la alarma de latencia de Lambda"
  value       = aws_cloudwatch_metric_alarm.notification_latency.alarm_name
}

output "alarm_sqs_queue_depth" {
  description = "Nombre de la alarma de profundidad de cola SQS"
  value       = aws_cloudwatch_metric_alarm.sqs_queue_depth.alarm_name
}

output "alarm_dlq_messages" {
  description = "Nombre de la alarma de mensajes en DLQ"
  value       = aws_cloudwatch_metric_alarm.dlq_messages.alarm_name
}

output "sns_subscription_id" {
  description = "ID de la suscripción SNS a SQS"
  value       = aws_sns_topic_subscription.notifications_sqs_target.id
}

output "lambda_event_source_mapping_uuid" {
  description = "UUID del mapeo de eventos de SQS a Lambda"
  value       = aws_lambda_event_source_mapping.sqs_to_lambda.uuid
}