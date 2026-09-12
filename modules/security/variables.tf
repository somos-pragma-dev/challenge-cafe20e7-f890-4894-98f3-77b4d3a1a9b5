variable "environment" {
  description = "Nombre del ambiente de despliegue"
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio para naming de recursos"
  type        = string
  default     = "notificaciones"
}

variable "vpc_id" {
  description = "ID de la VPC donde se aplicarán las políticas de seguridad"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN de la clave KMS para cifrado de recursos"
  type        = string
}

variable "kms_key_administrators" {
  description = "ARNs de IAM roles con permisos de administración de KMS"
  type        = list(string)
}

variable "kms_key_users" {
  description = "ARNs de IAM roles con permisos de uso de KMS"
  type        = list(string)
}

variable "enable_secrets_manager" {
  description = "Habilitar AWS Secrets Manager para gestión de secrets"
  type        = bool
  default     = true
}

variable "secret_names" {
  description = "Nombres de los secrets a crear en Secrets Manager"
  type        = list(string)
  default     = []
}

variable "enable_waf" {
  description = "Habilitar Web Application Firewall"
  type        = bool
  default     = false
}

variable "waf_scope" {
  description = "Alcance del WAF (CLOUDFRONT o REGIONAL)"
  type        = string
  default     = "REGIONAL"
  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.waf_scope)
    error_message = "El alcance debe ser CLOUDFRONT o REGIONAL"
  }
}

variable "waf_ip_set" {
  description = "Lista de IPs para bloquear en WAF"
  type        = list(string)
  default     = []
}

variable "waf_geo_match" {
  description = "Países a bloquear por coincidencia geográfica"
  type        = list(string)
  default     = []
}

variable "waf_rate_based_rule_limit" {
  description = "Límite de requests por 5 minutos para reglas rate-based"
  type        = number
  default     = 2000
  validation {
    condition     = var.waf_rate_based_rule_limit >= 100 && var.waf_rate_based_rule_limit <= 2000000
    error_message = "El límite debe estar entre 100 y 2000000"
  }
}

variable "enable_ddos_protection" {
  description = "Habilitar protección DDoS mediante AWS Shield"
  type        = bool
  default     = false
}

variable "security_group_name" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "notificaciones-sg"
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceso inbound"
  type        = list(string)
  default     = []
}

variable "allowed_security_groups" {
  description = "IDs de grupos de seguridad permitidos para acceso inbound"
  type        = list(string)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "Bloques CIDR para tráfico saliente"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_flow_logs" {
  description = "Habilitar Flow Logs para el grupo de seguridad"
  type        = bool
  default     = false
}

variable "iam_role_name" {
  description = "Nombre del rol IAM para el servicio"
  type        = string
  default     = "notificaciones-lambda-role"
}

variable "iam_policy_actions" {
  description = "Acciones permitidas en la política IAM"
  type        = list(string)
  validation {
    condition     = !contains(var.iam_policy_actions, "*")
    error_message = "No se permiten acciones comodín sin justificación"
  }
}

variable "iam_resource_arns" {
  description = "ARNs de recursos sobre los que se permiten las acciones"
  type        = list(string)
}

variable "enable_guardduty" {
  description = "Habilitar Amazon GuardDuty para detección de amenazas"
  type        = bool
  default     = false
}

variable "enable_securityhub" {
  description = "Habilitar AWS Security Hub para gestión de seguridad"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de seguridad"
  type        = map(string)
  default     = {}
}