# Outputs del módulo de monitoreo
# Expone los recursos de monitoreo configurados para el servicio de notificaciones

output "lambda_log_group_name" {
  description = "Nombre del grupo de logs de Lambda"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}

output "lambda_log_group_arn" {
  description = "ARN del grupo de logs de Lambda"
  value       = aws_cloudwatch_log_group.lambda_logs.arn
}

output "api_gateway_log_group_name" {
  description = "Nombre del grupo de logs de API Gateway"
  value       = aws_cloudwatch_log_group.api_gateway_logs.name
}

output "api_gateway_log_group_arn" {
  description = "ARN del grupo de logs de API Gateway"
  value       = aws_cloudwatch_log_group.api_gateway_logs.arn
}

output "notifications_sent_alarm_arn" {
  description = "ARN de la alarma de notificaciones enviadas"
  value       = aws_cloudwatch_metric_alarm.notifications_sent.arn
}

output "notifications_failed_alarm_arn" {
  description = "ARN de la alarma de notificaciones fallidas"
  value       = aws_cloudwatch_metric_alarm.notifications_failed.arn
}

output "lambda_duration_alarm_arn" {
  description = "ARN de la alarma de duración de Lambda"
  value       = aws_cloudwatch_metric_alarm.lambda_duration.arn
}

output "lambda_errors_alarm_arn" {
  description = "ARN de la alarma de errores de Lambda"
  value       = aws_cloudwatch_metric_alarm.lambda_errors.arn
}

output "lambda_throttles_alarm_arn" {
  description = "ARN de la alarma de throttling de Lambda"
  value       = aws_cloudwatch_metric_alarm.lambda_throttles.arn
}

output "lambda_concurrent_alarm_arn" {
  description = "ARN de la alarma de ejecuciones concurrentes"
  value       = aws_cloudwatch_metric_alarm.lambda_concurrent_executions.arn
}

output "lambda_memory_alarm_arn" {
  description = "ARN de la alarma de utilización de memoria"
  value       = aws_cloudwatch_metric_alarm.lambda_memory_utilization.arn
}

output "xray_errors_alarm_arn" {
  description = "ARN de la alarma de errores de X-Ray"
  value       = aws_cloudwatch_metric_alarm.xray_errors.arn
}

output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.notifications_dashboard.dashboard_name
}

output "dashboard_arn" {
  description = "ARN del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.notifications_dashboard.dashboard_arn
}

output "xray_group_name" {
  description = "Nombre del grupo de X-Ray"
  value       = aws_xray_group.notifications_group.name
}

output "xray_group_arn" {
  description = "ARN del grupo de X-Ray"
  value       = aws_xray_group.notifications_group.arn
}

output "all_alarm_arns" {
  description = "Lista de todos los ARNs de alarmas creadas"
  value = [
    aws_cloudwatch_metric_alarm.notifications_sent.arn,
    aws_cloudwatch_metric_alarm.notifications_failed.arn,
    aws_cloudwatch_metric_alarm.lambda_duration.arn,
    aws_cloudwatch_metric_alarm.lambda_errors.arn,
    aws_cloudwatch_metric_alarm.lambda_throttles.arn,
    aws_cloudwatch_metric_alarm.lambda_concurrent_executions.arn,
    aws_cloudwatch_metric_alarm.lambda_memory_utilization.arn,
    aws_cloudwatch_metric_alarm.xray_errors.arn
  ]
}

output "alarm_names" {
  description = "Lista de nombres de todas las alarmas"
  value = [
    aws_cloudwatch_metric_alarm.notifications_sent.alarm_name,
    aws_cloudwatch_metric_alarm.notifications_failed.alarm_name,
    aws_cloudwatch_metric_alarm.lambda_duration.alarm_name,
    aws_cloudwatch_metric_alarm.lambda_errors.alarm_name,
    aws_cloudwatch_metric_alarm.lambda_throttles.alarm_name,
    aws_cloudwatch_metric_alarm.lambda_concurrent_executions.alarm_name,
    aws_cloudwatch_metric_alarm.lambda_memory_utilization.alarm_name,
    aws_cloudwatch_metric_alarm.xray_errors.alarm_name
  ]
}