variable "environment" {
  description = "Nombre del ambiente de despliegue"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio de notificaciones"
  type        = string
  default     = "notificaciones"
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el servicio"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subredes privadas para despliegue de Lambda"
  type        = list(string)
}

variable "security_group_ids" {
  description = "IDs de los grupos de seguridad aplicables al servicio"
  type        = list(string)
}

variable "email_subscribers" {
  description = "Lista de emails suscritos para recibir notificaciones"
  type        = list(string)
  default     = []
}

variable "sms_subscribers" {
  description = "Lista de números de teléfono suscritos para SMS"
  type        = list(string)
  default     = []
}

variable "message_retention_days" {
  description = "Días de retención de mensajes en el topic SNS"
  type        = number
  default     = 3
  validation {
    condition     = var.message_retention_days >= 1 && var.message_retention_days <= 365
    error_message = "La retención debe estar entre 1 y 365 días"
  }
}

variable "message_delivery_retry_policy" {
  description = "Política de reintentos para entrega de mensajes fallida"
  type = object({
    retry_delay_seconds     = number
    max_retry_attempts      = number
  })
  default = {
    retry_delay_seconds  = 20
    max_retry_attempts   = 3
  }
}

variable "dead_letter_queue_enabled" {
  description = "Habilitar cola de mensajes fallidos"
  type        = bool
  default     = true
}

variable "dlq_max_receive_count" {
  description = "Número máximo de recepciones antes de enviar a DLQ"
  type        = number
  default     = 5
  validation {
    condition     = var.dlq_max_receive_count >= 1 && var.dlq_max_receive_count <= 100
    error_message = "El conteo máximo debe estar entre 1 y 100"
  }
}

variable "lambda_timeout" {
  description = "Timeout en segundos para funciones Lambda"
  type        = number
  default     = 30
  validation {
    condition     = var.lambda_timeout >= 1 && var.lambda_timeout <= 900
    error_message = "El timeout debe estar entre 1 y 900 segundos"
  }
}

variable "lambda_memory_size" {
  description = "Memoria en MB para funciones Lambda"
  type        = number
  default     = 256
  validation {
    condition     = var.lambda_memory_size >= 128 && var.lambda_memory_size <= 10240
    error_message = "La memoria debe estar entre 128 y 10240 MB"
  }
}

variable "lambda_concurrent_execution_limit" {
  description = "Límite de ejecuciones concurrentes de Lambda"
  type        = number
  default     = 100
}

variable "sqs_queue_name_prefix" {
  description = "Prefijo para nombres de colas SQS"
  type        = string
  default     = "notificaciones"
}

variable "sqs_message_retention_seconds" {
  description = "Retención de mensajes en segundos para colas SQS"
  type        = number
  default     = 345600
  validation {
    condition     = var.sqs_message_retention_seconds >= 60 && var.sqs_message_retention_seconds <= 1209600
    error_message = "La retención debe estar entre 60 y 1209600 segundos"
  }
}

variable "sqs_visibility_timeout_seconds" {
  description = "Timeout de visibilidad para colas SQS"
  type        = number
  default     = 300
  validation {
    condition     = var.sqs_visibility_timeout_seconds >= 0 && var.sqs_visibility_timeout_seconds <= 43200
    error_message = "El timeout debe estar entre 0 y 43200 segundos"
  }
}

variable "fifo_topic_enabled" {
  description = "Habilitar topic SNS FIFO para ordenamiento de mensajes"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Habilitar deduplicación basada en contenido para topics FIFO"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado de mensajes"
  type        = string
  default     = ""
}

variable "enable_message_filtering" {
  description = "Habilitar filtrado de mensajes en suscripciones"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas personalizadas para los recursos del servicio"
  type        = map(string)
  default     = {}
}