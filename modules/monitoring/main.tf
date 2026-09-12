# Módulo de monitoreo para el servicio de notificaciones
# Configura CloudWatch Logs, métricas, alarmas y dashboards

locals {
  service_name = var.service_name
  environment  = var.environment
  tags = merge(var.common_tags, {
    Service = local.service_name
    Environment = local.environment
  })
}

# Grupo de logs para Lambda
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${local.service_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = local.tags
}

# Grupo de logs para API Gateway
resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name              = "/aws/apigateway/${local.service_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = local.tags
}

# Métrica personalizada: notificaciones enviadas
resource "aws_cloudwatch_metric_alarm" "notifications_sent" {
  alarm_name          = "${local.service_name}-notifications-sent"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "NotificationsSent"
  namespace           = "NotificationsService"
  period              = var.threshold_period
  statistic           = "Sum"
  threshold           = var.notifications_sent_threshold
  alarm_description   = "Alerta cuando el número de notificaciones enviadas supera el umbral"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    Service = local.service_name
    Environment = local.environment
  }
}

# Métrica personalizada: notificaciones fallidas
resource "aws_cloudwatch_metric_alarm" "notifications_failed" {
  alarm_name          = "${local.service_name}-notifications-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "NotificationsFailed"
  namespace           = "NotificationsService"
  period              = var.threshold_period
  statistic           = "Sum"
  threshold           = var.notifications_failed_threshold
  alarm_description   = "Alerta cuando el número de notificaciones fallidas supera el umbral"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    Service = local.service_name
    Environment = local.environment
  }
}

# Alarma de latencia de Lambda
resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  alarm_name          = "${local.service_name}-lambda-duration"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = var.threshold_period
  statistic           = "Maximum"
  threshold           = var.lambda_duration_threshold
  alarm_description   = "Alerta cuando la duración de Lambda supera el umbral"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

# Alarma de errores de Lambda
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${local.service_name}-lambda-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = var.threshold_period
  statistic           = "Sum"
  threshold           = var.lambda_errors_threshold
  alarm_description   = "Alerta cuando Lambda reporta errores"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

# Alarma de throttling de Lambda
resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  alarm_name          = "${local.service_name}-lambda-throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = var.threshold_period
  statistic           = "Sum"
  threshold           = var.lambda_throttles_threshold
  alarm_description   = "Alerta cuando Lambda es throlleado"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

# Alarma de invocaciones concurrentes
resource "aws_cloudwatch_metric_alarm" "lambda_concurrent_executions" {
  alarm_name          = "${local.service_name}-lambda-concurrent"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "ConcurrentExecutions"
  namespace           = "AWS/Lambda"
  period              = var.threshold_period
  statistic           = "Maximum"
  threshold           = var.lambda_concurrent_threshold
  alarm_description   = "Alerta cuando las invocaciones concurrentes superan el umbral"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

# Alarma de utilización de memoria
resource "aws_cloudwatch_metric_alarm" "lambda_memory_utilization" {
  alarm_name          = "${local.service_name}-lambda-memory-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/Lambda"
  period              = var.threshold_period
  statistic           = "Maximum"
  threshold           = var.memory_utilization_threshold
  alarm_description   = "Alerta cuando la utilización de memoria supera el 85%"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    FunctionName = var.lambda_function_name
  }
}

# Dashboard de CloudWatch para el servicio de notificaciones
resource "aws_cloudwatch_dashboard" "notifications_dashboard" {
  dashboard_name = "${local.service_name}-${local.environment}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["NotificationsService", "NotificationsSent", {"stat" = "Sum"}],
            [".", "NotificationsFailed", {"stat" = "Sum"}]
          ]
          period = 300
          stat = "Sum"
          region = var.aws_region
          title = "Notificaciones Enviadas vs Fallidas"
          annotations = {
            horizontal = [
              {
                value = var.notifications_sent_threshold
                label = "Umbral de alertas"
              }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/Lambda", "Duration", "FunctionName", var.lambda_function_name, {"stat" = "Maximum"}],
            [".", "Errors", ".", ".", {"stat" = "Sum"}],
            [".", "Throttles", ".", ".", {"stat" = "Sum"}]
          ]
          period = 300
          stat = "Maximum"
          region = var.aws_region
          title = "Métricas de Lambda"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/Lambda", "ConcurrentExecutions", "FunctionName", var.lambda_function_name, {"stat" = "Maximum"}],
            [".", "Invocations", ".", ".", {"stat" = "Sum"}]
          ]
          period = 300
          stat = "Maximum"
          region = var.aws_region
          title = "Ejecuciones Concurrentes"
        }
      },
      {
        type = "log"
        properties = {
          query = "SOURCE '${aws_cloudwatch_log_group.lambda_logs.name}' | filter @message like /ERROR/ | stats count(*) as error_count by bin(5m)"
          region = var.aws_region
          title = "Errores en Logs"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApiGateway", "Latency", "ApiName", local.service_name, {"stat" = "Maximum"}],
            [".", "IntegrationLatency", ".", ".", {"stat" = "Maximum"}]
          ]
          period = 300
          stat = "Maximum"
          region = var.aws_region
          title = "Latencia de API Gateway"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApiGateway", "Count", "ApiName", local.service_name, {"stat" = "Sum"}],
            [".", "Error4xx", ".", ".", {"stat" = "Sum"}],
            [".", "Error5xx", ".", ".", {"stat" = "Sum"}]
          ]
          period = 300
          stat = "Sum"
          region = var.aws_region
          title = "Solicitudes API Gateway"
        }
      }
    ]
  })
}

# Configuración de X-Ray para trazabilidad
resource "aws_xray_group" "notifications_group" {
  name           = "${local.service_name}-group"
  filter_expression = "service(\"${var.lambda_function_name}\")"
  tags           = local.tags
}

# Alarma de X-Ray para errores de trazas
resource "aws_cloudwatch_metric_alarm" "xray_errors" {
  alarm_name          = "${local.service_name}-xray-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.threshold_evaluation_periods
  metric_name         = "TraceSegmentError"
  namespace           = "AWS/X-Ray"
  period              = var.threshold_period
  statistic           = "Sum"
  threshold           = var.xray_errors_threshold
  alarm_description   = "Alerta cuando hay errores en trazas de X-Ray"
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    Service = var.lambda_function_name
  }
}