variable "environment" {
  description = "Nombre del ambiente de despliegue"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio para naming de recursos"
  type        = string
  default     = "notificaciones"
}

variable "notification_topic_arn" {
  description = "ARN del topic SNS para envío de alertas"
  type        = string
}

variable "alarm_notification_email" {
  description = "Email para recibir notificaciones de alarmas"
  type        = string
}

variable "lambda_function_arns" {
  description = "ARNs de las funciones Lambda a monitorear"
  type        = list(string)
  default     = []
}

variable "sqs_queue_arns" {
  description = "ARNs de las colas SQS a monitorear"
  type        = list(string)
  default     = []
}

variable "sns_topic_arns" {
  description = "ARNs de los topics SNS a monitorear"
  type        = list(string)
  default     = []
}

variable "lambda_error_threshold" {
  description = "Umbral de errores para alarma de Lambda"
  type        = number
  default     = 5
}

variable "lambda_throttle_threshold" {
  description = "Umbral de throttles para alarma de Lambda"
  type        = number
  default     = 10
}

variable "lambda_duration_threshold_ms" {
  description = "Umbral de duración en milisegundos para Lambda"
  type        = number
  default     = 5000
}

variable "sqs_queue_delay_threshold_seconds" {
  description = "Umbral de retraso en segundos para colas SQS"
  type        = number
  default     = 300
}

variable "sqs_queue_age_threshold_seconds" {
  description = "Umbral de antigüedad de mensajes en cola SQS"
  type        = number
  default     = 600
}

variable "sqs_empty_receives_threshold" {
  description = "Umbral de receives vacíos para detectar problemas"
  type        = number
  default     = 20
}

variable "sns_publish_failure_threshold" {
  description = "Umbral de fallos de publicación en SNS"
  type        = number
  default     = 3
}

variable "sns_notification_age_threshold_seconds" {
  description = "Umbral de antigüedad de notificaciones SNS"
  type        = number
  default     = 300
}

variable "alarm_evaluation_periods" {
  description = "Número de períodos de evaluación para alarmas"
  type        = number
  default     = 2
  validation {
    condition     = var.alarm_evaluation_periods >= 1 && var.alarm_evaluation_periods <= 10
    error_message = "Los períodos deben estar entre 1 y 10"
  }
}

variable "alarm_evaluation_interval_seconds" {
  description = "Intervalo de evaluación de alarmas en segundos"
  type        = number
  default     = 300
  validation {
    condition     = contains([60, 300, 900], var.alarm_evaluation_interval_seconds)
    error_message = "El intervalo debe ser 60, 300 o 900 segundos"
  }
}

variable "log_group_retention_days" {
  description = "Días de retención para grupos de logs"
  type        = number
  default     = 30
  validation {
    condition     = var.log_group_retention_days >= 1 && var.log_group_retention_days <= 365
    error_message = "La retención debe estar entre 1 y 365 días"
  }
}

variable "enable_detailed_metrics" {
  description = "Habilitar métricas detalladas a nivel de función"
  type        = bool
  default     = true
}

variable "enable_custom_metrics" {
  description = "Habilitar métricas personalizadas de aplicación"
  type        = bool
  default     = false
}

variable "dashboard_widgets" {
  description = "Configuración de widgets para Dashboard de CloudWatch"
  type = list(object({
    type       = string
    title      = string
    width      = number
    height     = number
    metrics    = list(string)
    properties = map(string)
  }))
  default = []
}

variable "enable_canary_deployment" {
  description = "Habilitar despliegue canary para funciones Lambda"
  type        = bool
  default     = false
}

variable "logs_metrics_filter_patterns" {
  description = "Patrones de filtros de métricas en logs"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de monitoreo"
  type        = map(string)
  default     = {}
}