output "sns_topic_notifications_arn" {
  description = "ARN del topic principal de notificaciones"
  value       = module.sns_topics.sns_topic_notifications_arn
}

output "sns_topic_alerts_arn" {
  description = "ARN del topic de alertas"
  value       = module.sns_topics.sns_topic_alerts_arn
}

output "notifications_queue_url" {
  description = "URL de la cola de notificaciones"
  value       = module.sqs_queues.notifications_queue_url
}

output "notifications_queue_arn" {
  description = "ARN de la cola de notificaciones"
  value       = module.sqs_queues.notifications_queue_arn
}

output "alerts_queue_url" {
  description = "URL de la cola de alertas"
  value       = module.sqs_queues.alerts_queue_url
}

output "alerts_queue_arn" {
  description = "ARN de la cola de alertas"
  value       = module.sqs_queues.alerts_queue_arn
}

output "dlq_notifications_queue_arn" {
  description = "ARN de la cola de mensajes fallidos de notificaciones"
  value       = module.sqs_queues.dlq_notifications_queue_arn
}

output "dlq_alerts_queue_arn" {
  description = "ARN de la cola de mensajes fallidos de alertas"
  value       = module.sqs_queues.dlq_alerts_queue_arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda de procesamiento"
  value       = module.lambda_function.function_name
}

output "lambda_function_arn" {
  description = "ARN de la función Lambda de procesamiento"
  value       = module.lambda_function.lambda_function_arn
}

output "lambda_iam_role_arn" {
  description = "ARN del rol IAM de la función Lambda"
  value       = module.lambda_function.lambda_function_iam_role_arn
}

output "lambda_log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}