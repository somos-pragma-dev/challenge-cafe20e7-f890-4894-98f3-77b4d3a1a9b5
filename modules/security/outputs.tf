# Outputs del módulo de seguridad
# Expone los recursos de seguridad creados para el servicio de notificaciones

output "security_group_id" {
  description = "ID del Security Group principal del servicio de notificaciones"
  value       = aws_security_group.notifications_sg.id
}

output "security_group_arn" {
  description = "ARN del Security Group principal del servicio de notificaciones"
  value       = aws_security_group.notifications_sg.arn
}

output "security_group_name" {
  description = "Nombre del Security Group principal"
  value       = aws_security_group.notifications_sg.name
}

output "lambda_execution_policy_arn" {
  description = "ARN de la política IAM para ejecución de Lambda"
  value       = aws_iam_policy.lambda_execution.arn
}

output "lambda_execution_role_arn" {
  description = "ARN del rol IAM para ejecución de Lambda"
  value       = aws_iam_role.lambda_execution.arn
}

output "lambda_execution_role_name" {
  description = "Nombre del rol IAM para ejecución de Lambda"
  value       = aws_iam_role.lambda_execution.name
}

output "dynamodb_access_policy_arn" {
  description = "ARN de la política de acceso a DynamoDB para historial de notificaciones"
  value       = aws_iam_policy.dynamodb_access.arn
}

output "sns_publish_policy_arn" {
  description = "ARN de la política de publicación en SNS"
  value       = aws_iam_policy.sns_publish.arn
}

output "secrets_manager_access_policy_arn" {
  description = "ARN de la política de acceso a Secrets Manager"
  value       = aws_iam_policy.secrets_access.arn
}

output "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado de datos sensibles"
  value       = aws_kms_key.notifications_key.arn
}

output "kms_key_id" {
  description = "ID de la clave KMS para cifrado de datos sensibles"
  value       = aws_kms_key.notifications_key.key_id
}

output "vpc_endpoint_security_group_id" {
  description = "ID del Security Group para endpoints de VPC"
  value       = aws_security_group.vpc_endpoints_sg.id
}

output "cloudwatch_logs_policy_arn" {
  description = "ARN de la política de acceso a CloudWatch Logs"
  value       = aws_iam_policy.cloudwatch_logs.arn
}

output "xray_access_policy_arn" {
  description = "ARN de la política de acceso a X-Ray para trazabilidad"
  value       = aws_iam_policy.xray_access.arn
}

output "all_policy_arns" {
  description = "Lista de todos los ARNs de políticas IAM creadas"
  value       = [aws_iam_policy.lambda_execution.arn, aws_iam_policy.dynamodb_access.arn, aws_iam_policy.sns_publish.arn, aws_iam_policy.secrets_access.arn, aws_iam_policy.cloudwatch_logs.arn, aws_iam_policy.xray_access.arn]
}

output "all_security_group_ids" {
  description = "Lista de todos los IDs de Security Groups creados"
  value       = [aws_security_group.notifications_sg.id, aws_security_group.vpc_endpoints_sg.id]
}