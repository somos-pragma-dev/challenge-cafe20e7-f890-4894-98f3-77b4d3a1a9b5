variable "environment" {
  description = "Nombre del ambiente de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod"
  }
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "La región debe tener el formato válido de AWS (ej: us-east-1)"
  }
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal del servicio de notificaciones"
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El CIDR debe ser un bloque válido (ej: 10.0.0.0/16)"
  }
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para la región seleccionada"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Bloques CIDR para subredes de base de datos"
  type        = list(string)
}

variable "service_name" {
  description = "Nombre base del servicio para naming de recursos"
  type        = string
  default     = "notificaciones"
}

variable "cost_center" {
  description = "Centro de costo para facturación"
  type        = string
}

variable "business_unit" {
  description = "Unidad de negocio responsable del servicio"
  type        = string
}

variable "contact_email" {
  description = "Email de contacto para alertas y notificaciones operativas"
  type        = string
  validation {
    condition     = can(regex("@", var.contact_email))
    error_message = "Debe proporcionar un email válido"
  }
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación de recursos críticos"
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Habilitar VPC Flow Logs para auditoría de tráfico"
  type        = bool
  default     = true
}

variable "retention_days" {
  description = "Días de retención para logs de CloudWatch"
  type        = number
  validation {
    condition     = var.retention_days >= 1 && var.retention_days <= 365
    error_message = "La retención debe estar entre 1 y 365 días"
  }
}

variable "enable_cross_account_access" {
  description = "Permitir acceso desde cuentas AWS secundarias"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso a la VPC"
  type        = list(string)
  default     = []
}

variable "kms_key_administrators" {
  description = "ARNs de IAM roles que tendrán permisos de administración sobre la clave KMS"
  type        = list(string)
}

variable "kms_key_users" {
  description = "ARNs de IAM roles que tendrán permisos de uso de la clave KMS"
  type        = list(string)
}

variable "alarm_notification_email" {
  description = "Email para recibir notificaciones de alarmas"
  type        = string
}

variable "enable_waf" {
  description = "Habilitar Web Application Firewall"
  type        = bool
  default     = false
}

variable "waf_ip_set" {
  description = "Conjunto de IPs para reglas de WAF"
  type        = list(string)
  default     = []
}