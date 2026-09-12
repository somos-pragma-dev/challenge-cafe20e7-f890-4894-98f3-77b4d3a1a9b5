# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad AWS, Tecnología AWS, Senior

### Brecha de conocimiento
Necesita fortalecer la practica de AWS

### Misión / candidato
Liderar la iniciativa de infraestructura del servicio de notificaciones

### Reto
- Tema: Infraestructura del servicio de notificaciones
- Seniority: senior-l2
- Tipo: practical
- Título: Diseño y despliegue de la infraestructura de notificaciones en AWS
- Tiempo estimado: 2 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Evaluación de requerimientos y diseño inicial — objetivo: Identificar los requerimientos del servicio de notificaciones y proponer un diseño inicial. — entregable (NO resolver): Documento de diseño inicial del servicio de notificaciones en AWS.
- Fase 2: Despliegue y configuración de la infraestructura — objetivo: Desplegar y configurar la infraestructura del servicio de notificaciones en AWS. — entregable (NO resolver): Infraestructura del servicio de notificaciones desplegada y configurada en AWS.
- Fase 3: Optimización y monitoreo — objetivo: Optimizar el rendimiento y configurar el monitoreo del servicio de notificaciones. — entregable (NO resolver): Infraestructura optimizada y monitoreo configurado para el servicio de notificaciones.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: providers.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "notificaciones-servicio"
      ManagedBy   = "Terraform"
      Owner       = "cloudops-team"
    }
  }

  iam = {
    max_session_duration = 43200
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = false
}

// Proveedor para recursos de terceros que requieren acceso a AWS
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "notificaciones-servicio"
      ManagedBy   = "Terraform"
      Owner       = "cloudops-team"
    }
  }
}

// Configuración de endpoints para comunicación privada con servicios AWS
provider "aws" {
  alias  = "private_endpoints"
  region = var.aws_region

  endpoints {
    sns        = "https://sns.${var.aws_region}.amazonaws.com"
    sqs        = "https://sqs.${var.aws_region}.amazonaws.com"
    lambda     = "https://lambda.${var.aws_region}.amazonaws.com"
    cloudwatch = "https://monitoring.${var.aws_region}.amazonaws.com"
    logs       = "https://logs.${var.aws_region}.amazonaws.com"
    kms        = "https://kms.${var.aws_region}.amazonaws.com"
  }
}

// === ARCHIVO: variables.tf ===
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

// === ARCHIVO: modules/notifications-service/variables.tf ===
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

// === ARCHIVO: modules/security/variables.tf ===
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

// === ARCHIVO: modules/monitoring/variables.tf ===
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


// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Service     = "notifications"
      Owner       = "cloudops-team"
      ManagedBy   = "Terraform"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc-${var.environment}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = var.environment == "dev"
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Type = "Networking"
  }
}

resource "aws_sns_topic" "notifications" {
  name              = "${var.project_name}-notifications-${var.environment}"
  display_name      = "Notificaciones del Sistema Financiero"
  fifo_topic        = false
  content_based_deduplication = false

  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget        = 20
        maxDelayTarget        = 20
        numRetries            = 3
        numMaxDelayRetries    = 3
        backoffFunction       = "exponential"
      }
      defaultThrottlePolicy = {
        maxReceivesPerSecond = 100
      }
    }
  })

  tags = {
    Description = "Topic principal para notificaciones del servicio financiero"
  }
}

resource "aws_sns_topic" "notifications_dlq" {
  name              = "${var.project_name}-notifications-dlq-${var.environment}"
  display_name      = "Dead Letter Queue para Notificaciones"
  fifo_topic        = false

  tags = {
    Description = "Cola de mensajes fallidos para notificaciones"
  }
}

resource "aws_sqs_queue" "notifications_queue" {
  name                       = "${var.project_name}-notifications-queue-${var.environment}"
  max_message_size           = 262144
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 300
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sns_topic.notifications_dlq.arn
    maxReceiveCount     = 5
  })

  tags = {
    Description = "Cola principal para procesamiento de notificaciones"
  }
}

resource "aws_sqs_queue" "notifications_dlq" {
  name                       = "${var.project_name}-notifications-dlq-queue-${var.environment}"
  max_message_size           = 262144
  message_retention_seconds  = 1209600
  visibility_timeout_seconds = 300

  tags = {
    Description = "Dead Letter Queue para mensajes de notificación fallidos"
  }
}

resource "aws_sns_topic_subscription" "notifications_sqs_target" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.notifications_queue.arn
  raw_message_delivery = false
  filter_policy_scope = "MessageBody"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/notification_handler.py"
  output_path = "${path.module}/lambda/notification_handler.zip"
}

resource "aws_lambda_function" "notification_processor" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.project_name}-notification-processor-${var.environment}"
  role            = aws_iam_role.lambda_notification_processor.arn
  handler         = "notification_handler.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime         = "python3.11"
  timeout         = 300
  memory_size     = 256

  environment {
    variables = {
      ENVIRONMENT           = var.environment
      LOG_LEVEL             = var.log_level
      SNS_TOPIC_ARN         = aws_sns_topic.notifications.arn
      DLQ_URL               = aws_sqs_queue.notifications_dlq.url
      MAX_RETRIES           = "3"
      BATCH_SIZE            = "10"
    }
  }

  vpc_config {
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [aws_security_group.lambda_notifications.id]
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_notification_processor_policy]

  tags = {
    Description = "Función Lambda para procesamiento de notificaciones"
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn  = aws_sqs_queue.notifications_queue.arn
  function_name     = aws_lambda_function.notification_processor.arn
  batch_size        = 10
  maximum_batching_window_in_seconds = 60
  enabled           = true
  retry_strategy {
    maximum_retry_attempts = 5
  }
}

resource "aws_iam_role" "lambda_notification_processor" {
  name = "${var.project_name}-lambda-notification-processor-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Description = "Rol IAM para función Lambda de procesamiento de notificaciones"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_notification_processor_policy" {
  role       = aws_iam_role.lambda_notification_processor.name
  policy_arn = aws_iam_policy.lambda_notification_processor_policy.arn
}

resource "aws_iam_policy" "lambda_notification_processor_policy" {
  name = "${var.project_name}-lambda-notification-policy-${var.environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = [
          aws_sqs_queue.notifications_queue.arn,
          aws_sqs_queue.notifications_dlq.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:ListSubscriptionsByTopic"
        ]
        Resource = aws_sns_topic.notifications.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Description = "Política de permisos para Lambda de notificaciones"
  }
}

resource "aws_security_group" "lambda_notifications" {
  name        = "${var.project_name}-lambda-notifications-${var.environment}"
  description = "Security group para función Lambda de notificaciones"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
    description = "Tráfico interno de la VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Salida a internet a través de NAT Gateway"
  }

  tags = {
    Description = "SG para Lambda de notificaciones"
  }
}

resource "aws_cloudwatch_log_group" "notification_lambda" {
  name              = "/aws/lambda/${aws_lambda_function.notification_processor.function_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Description = "Log group para Lambda de notificaciones"
  }
}

resource "aws_cloudwatch_metric_alarm" "notification_errors" {
  alarm_name          = "${var.project_name}-notification-errors-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "Alarma cuando la función Lambda de notificaciones genera errores"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    FunctionName = aws_lambda_function.notification_processor.function_name
  }

  tags = {
    Severity = "High"
  }
}

resource "aws_cloudwatch_metric_alarm" "notification_latency" {
  alarm_name          = "${var.project_name}-notification-latency-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Average"
  threshold           = var.latency_threshold_ms
  alarm_description   = "Alarma cuando la latencia de Lambda excede el umbral"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    FunctionName = aws_lambda_function.notification_processor.function_name
  }

  tags = {
    Severity = "Medium"
  }
}

resource "aws_cloudwatch_metric_alarm" "sqs_queue_depth" {
  alarm_name          = "${var.project_name}-sqs-queue-depth-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 300
  statistic           = "Maximum"
  threshold           = var.sqs_queue_depth_threshold
  alarm_description   = "Alarma cuando la cola SQS tiene muchos mensajes pendientes"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    QueueName = aws_sqs_queue.notifications_queue.name
  }

  tags = {
    Severity = "Medium"
  }
}

resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  alarm_name          = "${var.project_name}-dlq-messages-${var.environment}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "Alarma cuando hay mensajes en la Dead Letter Queue"
  alarm_actions       = [aws_sns_topic.notifications.arn]

  dimensions = {
    QueueName = aws_sqs_queue.notifications_dlq.name
  }

  tags = {
    Severity = "Critical"
  }
}

// === ARCHIVO: outputs.tf ===
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

// === ARCHIVO: backend.tf ===
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state-${var.environment}"
    key            = "notifications-service/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project_name}-terraform-lock-${var.environment}"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
    Purpose     = "State Management"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "${var.project_name}-terraform-lock-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
    Purpose     = "State Locking"
    ManagedBy   = "Terraform"
  }
}

resource "aws_dynamodb_table_server_side_encryption" "terraform_lock" {
  count        = var.environment != "dev" ? 1 : 0
  table_name   = aws_dynamodb_table.terraform_lock.name
  server_side_encryption = "ENABLED"
  kms_key_arn  = var.kms_key_arn
}

output "terraform_state_bucket" {
  description = "Nombre del bucket S3 para estado de Terraform"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_lock_table" {
  description = "Nombre de la tabla DynamoDB para locking de Terraform"
  value       = aws_dynamodb_table.terraform_lock.name
}


=== ARCHIVO: README.md ===
# Infraestructura del Servicio de Notificaciones - AWS

## Descripción del Proyecto

Este proyecto implementa la infraestructura como código para el servicio de notificaciones de la plataforma financiera. El diseño sigue una arquitectura modular con separación de responsabilidades, utilizando Terraform para el aprovisionamiento de recursos en AWS.

## Topología de la Infraestructura

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           AWS Account: Production                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                     VPC Principal (10.0.0.0/16)                │   │
│  │  ┌──────────────────────────────────────────────────────────┐  │   │
│  │  │  Subred Pública A (10.0.1.0/24)    │ ALB                │  │   │
│  │  │  Subred Pública C (10.0.2.0/24)    │ (Internet-facing)  │  │   │
│  │  └──────────────────────────────────────────────────────────┘  │   │
│  │  ┌──────────────────────────────────────────────────────────┐  │   │
│  │  │  Subred Privada A (10.0.10.0/24)  │ Lambda Functions    │  │   │
│  │  │  Subred Privada C (10.0.11.0/24)  │ (Notification API)  │  │   │
│  │  │  Subred Privada B (10.0.12.0/24)  │ SQS Queues          │  │   │
│  │  └──────────────────────────────────────────────────────────┘  │   │
│  │  ┌──────────────────────────────────────────────────────────┐  │   │
│  │  │  Subred Datos A (10.0.20.0/24)    │ RDS (no usado       │  │   │
│  │  │  Subred Datos C (10.0.21.0/24)    │ en este servicio)   │  │   │
│  │  └──────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    Módulos de Infraestructura                   │   │
│  ├─────────────────────────────────────────────────────────────────┤   │
│  │  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐  │   │
│  │  │ Notification     │  │ Security         │  │ Monitoring   │  │   │
│  │  │ Service Module   │  │ Module           │  │ Module       │  │   │
│  │  │                  │  │                  │  │              │  │   │
│  │  │ - SNS Topics     │  │ - IAM Roles      │  │ - CloudWatch │  │   │
│  │  │ - SQS Queues     │  │ - KMS Keys       │  │   Logs       │  │   │
│  │  │ - Lambda         │  │ - Security Groups│  │ - Alarms     │  │   │
│  │  │ - API Gateway    │  │ - WAF Rules      │  │ - Dashboards│  │   │
│  │  └──────────────────┘  └──────────────────┘  └──────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                    aws_s3_backend (Terraform State)                    │
│    State Bucket: terraform-state-${aws_account_id}                     │
│    Lock Table: terraform-locks                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

## Componentes de la Infraestructura

### Módulo de Notificaciones (notifications-service)

El módulo principal que provee la funcionalidad del servicio de notificaciones:

- **SNS Topics**: Temas para diferentes tipos de notificaciones (email, SMS, push)
- **SQS Queues**: Colas de procesamiento asíncrono con dead-letter queue
- **AWS Lambda**: Funciones serverless para procesamiento de eventos
- **API Gateway**: Endpoints REST para envío de notificaciones

### Módulo de Seguridad (security)

Capa de seguridad aplicada a todos los recursos:

- **IAM Roles**: Roles con principio de menor privilegio
- **KMS Keys**: Cifrado en reposo para datos sensibles
- **Security Groups**: Control de tráfico entre componentes
- **WAF**: Web Application Firewall para protección de API

### Módulo de Monitoreo (monitoring)

Observabilidad del servicio:

- **CloudWatch Logs**: Agregación de logs centralizada
- **CloudWatch Metrics**: Métricas personalizadas
- **CloudWatch Alarms**: Alertas proactivas con umbrales definidos
- **Dashboards**: Visualización en tiempo real del estado del servicio

## Requisitos Previos

- Terraform >= 1.5 (configurado en required_version)
- AWS CLI >= 2.0
- Credenciales de AWS configuradas con permisos apropiados
- Cuenta de AWS con acceso a los servicios mencionados

### Permisos AWS Requeridos

El usuario o rol que ejecute Terraform necesita:
- Permisos para crear recursos en EC2, Lambda, SNS, SQS, API Gateway
- Permisos para crear y gestionar claves KMS
- Permisos para crear grupos de seguridad y roles IAM
- Permisos para CloudWatch Logs y Metrics
- Acceso al bucket S3 del backend y tabla DynamoDB para locking

## Estructura del Proyecto

```
.
├── README.md                      # Este archivo
├── providers.tf                   # Configuración de providers
├── main.tf                        # Orquestación de módulos
├── variables.tf                   # Variables globales
├── outputs.tf                     # Outputs del proyecto
├── backend.tf                     # Configuración de backend remoto
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars       # Variables para desarrollo
│   ├── qa/
│   │   └── terraform.tfvars       # Variables para QA
│   └── prod/
│       └── terraform.tfvars       # Variables para producción
└── modules/
    ├── notifications-service/     # Módulo de notificaciones
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security/                  # Módulo de seguridad
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── monitoring/                # Módulo de monitoreo
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Configuración por Ambiente

### Desarrollo (dev)
- Recursos con menor capacidad
- Logs con nivel DEBUG habilitado
- Alertas con umbrales menos estrictos

### QA
- Recursos de capacidad media
- Logs con nivel INFO
- Alertas con umbrales intermedios

### Producción (prod)
- Recursos de alta disponibilidad
- Logs con nivel WARN
- Alertas con umbrales estrictos
- Multi-AZ obligatorio

## Comandos para Despliegue

### Inicialización

```bash
# Inicializar Terraform y descargar proveedores
terraform init -backend-config=environments/dev/backend.hcl

# Validar la configuración
terraform validate

# Ver el plan de ejecución
terraform plan -var-file=environments/dev/terraform.tfvars
```

### Despliegue

```bash
# Aplicar los cambios (desarrollo)
terraform apply -var-file=environments/dev/terraform.tfvars

# Aplicar los cambios (producción)
terraform apply -var-file=environments/prod/terraform.tfvars
```

### Destrucción

```bash
# Destruir todos los recursos (usar con precaución)
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Variables Principales

| Variable | Descripción | Valores Permitidos |
|----------|-------------|-------------------|
| aws_region | Región de AWS | us-east-1, us-west-2, eu-west-1 |
| environment | Ambiente de despliegue | dev, qa, prod |
| notification_types | Tipos de notificación | [email, sms, push] |
| enable_waf | Habilitar WAF | true, false |
| log_level | Nivel de logs | DEBUG, INFO, WARN, ERROR |
| enable_deletion_protection | Protección contra eliminación | true, false |

## Outputs del Proyecto

- **vpc_id**: ID de la VPC creada
- **sns_topic_arns**: ARNs de los temas SNS configurados
- **sqs_queue_urls**: URLs de las colas SQS
- **lambda_function_arns**: ARNs de las funciones Lambda
- **api_gateway_endpoint**: Endpoint del API Gateway
- **cloudwatch_log_group**: Grupo de logs de CloudWatch
- **kms_key_arn**: ARN de la clave KMS

## Consideraciones de Seguridad

- Todas las claves KMS tienen rotación habilitada
- Los buckets S3 tienen versioning y cifrado habilitado
- Las políticas IAM siguen el principio de menor privilegio
- Los security groups no permiten tráfico entrante desde 0.0.0.0/0
- El acceso a la API está protegido por WAF en producción
- Los logs no contienen información sensible (PII)

## Optimización de Costos

- Uso de recursos serverless (Lambda, SNS, SQS) para escalar a cero
- Lifecycle rules en S3 para архивирование de logs antiguos
- CloudWatch Insights para análisis de costos de logs
- Reserved Instances si el uso es predecible

## Monitoreo y Alarmas

### Métricas Clave

- Latencia de procesamiento de notificaciones
- Tasa de errores en Lambda
- Número de mensajes en cola SQS
- Throttling de SNS
- Uso de memoria de Lambda

### Alarmas Configuradas

- **NotificationLatencyHigh**: Latencia > 5 segundos
- **NotificationErrorsHigh**: Tasa de errores > 1%
- **SQSQueueDepthHigh**: Mensajes en cola > 1000
- **LambdaThrottling**: Cualquier evento de throttling
- **KMSKeyRotationFailure**: Fallo en rotación de claves

## Recuperación ante Desastres

- **RTO**: 15 minutos
- **RPO**: 5 minutos
- Réplica multi-AZ de recursos críticos
- Backups automáticos de estado de Terraform
- Documentación de procedimientos de recuperación

## Mantenimiento

### Actualización de Terraform

```bash
# Actualizar proveedores
terraform init -upgrade

# Ver cambios en proveedores
terraform providers
```

### Rotación de Credenciales

Las credenciales de AWS deben rotarse según las políticas de seguridad de la organización. El módulo de security incluye rotación automática de claves KMS.

## Soporte y Contacto

- **Equipo de Infraestructura**: infra-notifications@empresa.com
- ** Slack**: #cloud-ops-notifications
- **Documentación adicional**: https://wiki.empresa.com/notifications-service

## Licencia

Copyright © 2024. Todos los derechos reservados.


// === ARCHIVO: modules/notifications-service/main.tf ===
module "sns_topics" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 3.0"

  topics = {
    notifications = {
      name               = "${var.project}-${var.environment}-notifications"
      display_name       = "Main notifications topic"
      kms_master_key_id  = var.kms_key_arn
      tags               = var.common_tags
    }
    alerts = {
      name               = "${var.project}-${var.environment}-alerts"
      display_name       = "Alerts notifications topic"
      kms_master_key_id  = var.kms_key_arn
      tags               = var.common_tags
    }
  }

  subscription = {
    notifications = [
      {
        protocol  = "sqs"
        endpoint  = module.sqs_queues.notifications_queue_arn
        raw_message_delivery = true
      }
    ]
    alerts = [
      {
        protocol  = "lambda"
        endpoint  = module.lambda_function.alert_lambda_arn
      }
    ]
  }
}

module "sqs_queues" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 4.0"

  name_prefix = "${var.project}-${var.environment}-"

  queues = {
    notifications = {
      name                        = "notifications-queue"
      visibility_timeout_seconds  = 300
      max_message_size            = 262144
      message_retention_seconds   = 345600
      receive_wait_time_seconds   = 20
      redrive_policy = {
        dead_letter_target_arn = module.sqs_queues.dlq_notifications_queue_arn
        max_receive_count      = 5
      }
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
    alerts = {
      name                        = "alerts-queue"
      visibility_timeout_seconds  = 180
      max_message_size            = 262144
      message_retention_seconds   = 604800
      receive_wait_time_seconds   = 10
      redrive_policy = {
        dead_letter_target_arn = module.sqs_queues.dlq_alerts_queue_arn
        max_receive_count      = 3
      }
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
  }

  dlqs = {
    notifications = {
      name              = "notifications-dlq"
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
    alerts = {
      name              = "alerts-dlq"
      kms_master_key_id = var.kms_key_arn
      tags              = var.common_tags
    }
  }

  tags = var.common_tags
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${var.project}-${var.environment}-notifications-processor"

  description = "Lambda function for processing notification events"
  runtime     = "python3.11"
  handler     = "index.lambda_handler"
  timeout     = 300
  memory_size = 256

  source_path = "${path.module}/../../lambda/notification-processor"

  environment {
    variables = {
      ENVIRONMENT = var.environment
      LOG_LEVEL   = var.log_level
      SNS_REGION  = var.aws_region
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  kms_key_arn         = var.kms_key_arn
  attach_policy       = true
  policy_name         = "${var.project}-${var.environment}-lambda-notifications-policy"

  allowed_triggers = {
    SQS = {
      service = "sqs"
      source_arn = module.sqs_queues.alerts_queue_arn
    }
    SNS = {
      service = "sns"
      source_arn = module.sns_topics.sns_topic_alerts_arn
    }
  }

  tags = var.common_tags
}

resource "aws_sns_topic_policy" "notifications_policy" {
  arn = module.sns_topics.sns_topic_notifications_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "notifications-topic-policy"
    Statement = [
      {
        Sid       = "AllowSQSQueueSubscription"
        Effect    = "Allow"
        Principal = {
          Service = "sqs.amazonaws.com"
        }
        Action    = "sns:Subscribe"
        Resource  = module.sns_topics.sns_topic_notifications_arn
        Condition = {
          StringEquals = {
            "aws:SourceAccount" : var.account_id
          }
        }
      },
      {
        Sid       = "AllowCloudWatchPublish"
        Effect    = "Allow"
        Principal = {
          Service = "logs.amazonaws.com"
        }
        Action    = ["sns:Publish", "sns:GetTopicAttributes"]
        Resource  = module.sns_topics.sns_topic_notifications_arn
      }
    ]
  })
}

resource "aws_sqs_queue_policy" "notifications_queue_policy" {
  queue_url = module.sqs_queues.notifications_queue_url

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "notifications-queue-policy"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action    = "sqs:SendMessage"
        Resource  = module.sqs_queues.notifications_queue_arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" : module.sns_topics.sns_topic_notifications_arn
          }
        }
      }
    ]
  })
}

resource "aws_kms_grant" "lambda_kms_grant" {
  name              = "${var.project}-${var.environment}-lambda-kms-grant"
  key_id            = var.kms_key_arn
  grantee_principal = module.lambda_function.lambda_function_iam_role_arn
  operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${module.lambda_function.function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}

// === ARCHIVO: modules/notifications-service/outputs.tf ===
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

// === ARCHIVO: modules/security/main.tf ===
resource "aws_kms_key" "main" {
  description             = "Clave KMS principal para cifrado de datos en ${var.environment}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${var.project}-${var.environment}-kms-key-policy"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow Lambda to use the key"
        Effect = "Allow"
        Principal = {
          AWS = var.lambda_role_arn
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid = "Allow CloudWatch to use the key for log encryption"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:DescribeKey",
          "kms:GenerateDataKey*"
        ]
        Resource = "*"
        Condition = {
          ArnEquals = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:${var.aws_region}:${var.account_id}:*"
          }
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/${var.project}-${var.environment}-main"
  target_key_id = aws_kms_key.main.key_id
}

resource "aws_iam_policy" "notifications_policy" {
  name        = "${var.project}-${var.environment}-notifications-policy"
  description = "Política IAM para el servicio de notificaciones con principio de menor privilegio"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowSNSPublish"
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:ListSubscriptionsByTopic"
        ]
        Resource = var.sns_topic_arns
      },
      {
        Sid = "AllowSQSOperations"
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = var.sqs_queue_arns
      },
      {
        Sid = "AllowLambdaInvocation"
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction",
          "lambda:GetFunctionConfiguration"
        ]
        Resource = var.lambda_function_arns
      },
      {
        Sid = "AllowCloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.project}-${var.environment}*:*"
      },
      {
        Sid = "AllowKMSEncryption"
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]
        Resource = aws_kms_key.main.arn
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role" "notifications_role" {
  name = "${var.project}-${var.environment}-notifications-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "lambda.amazonaws.com",
            "ecs-tasks.amazonaws.com"
          ]
        }
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" : var.allowed_regions
          }
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "notifications_attach" {
  role       = aws_iam_role.notifications_role.name
  policy_arn = aws_iam_policy.notifications_policy.arn
}

resource "aws_security_group" "notifications" {
  name        = "${var.project}-${var.environment}-notifications-sg"
  description = "Security group para el servicio de notificaciones"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description     = "HTTPS desde ALB"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = [var.vpc_cidr]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self            = false
    }
  ]

  egress = [
    {
      description     = "Salida a Internet via NAT"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = [var.vpc_cidr]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self            = false
    },
    {
      description     = "Salida a AWS Services"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["10.0.0.0/8"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self            = false
    }
  ]

  tags = var.common_tags
}

resource "aws_security_group" "lambda" {
  name        = "${var.project}-${var.environment}-lambda-sg"
  description = "Security group para funciones Lambda en VPC"
  vpc_id      = var.vpc_id

  egress = [
    {
      description     = "Salida a internet via NAT Gateway"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self            = false
    },
    {
      description     = "Acceso a SQS"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = [var.vpc_cidr]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self            = false
    }
  ]

  tags = var.common_tags
}

resource "aws_iam_policy" "vpc_endpoint_policy" {
  name        = "${var.project}-${var.environment}-vpc-endpoint-policy"
  description = "Política para acceso a servicios AWS desde VPC endpoints"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arns
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:GetTopicAttributes"
        ]
        Resource = var.sns_topic_arns
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = var.lambda_function_arns
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_kms_key" "logs_key" {
  description             = "Clave KMS para cifrado de logs de CloudWatch"
  deletion_window_in_days = 7
  enable_key_rotation     = false

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "${var.project}-${var.environment}-logs-kms-policy"
    Statement = [
      {
        Sid = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action = "kms:*"
        Resource = "*"
      },
      {
        Sid = "Allow CloudWatch Logs to use the key"
        Effect = "Allow"
        Principal = {
          Service = "logs.${var.aws_region}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:DescribeKey*",
          "kms:GenerateDataKey*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.common_tags
}

resource "aws_kms_alias" "logs_alias" {
  name          = "alias/${var.project}-${var.environment}-logs"
  target_key_id = aws_kms_key.logs_key.key_id
}


// === ARCHIVO: modules/security/outputs.tf ===
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

// === ARCHIVO: modules/monitoring/main.tf ===
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

# === ARCHIVO: modules/monitoring/outputs.tf ===
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

// === ARCHIVO: environments/dev/terraform.tfvars ===
# Configuración de desarrollo para el servicio de notificaciones
# Este archivo contiene los valores específicos del ambiente de desarrollo

# Configuración de red
environment               = "dev"
common_tags = {
  Environment = "dev"
  Service     = "notifications"
  Owner       = "cloudops-team"
  Project     = "financial-platform"
  CostCenter  = "engineering"
}

# VPC Configuration
vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs    = ["10.0.100.0/24", "10.0.101.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = true

# DNS Configuration
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración del servicio de notificaciones
notifications_config = {
  # SNS Topic Configuration
  sns_topic_name                    = "dev-notifications-topic"
  sns_topic_fifo                    = false
  sns_topic_content_based_deduplication = false
  sns_topic_delivery_policy         = "standard"
  sns_topic_trace_enabled           = true
  
  # SQS Queue Configuration
  sqs_queue_name                    = "dev-notifications-queue"
  sqs_queue_fifo                    = false
  sqs_queue_dlq_name                = "dev-notifications-dlq"
  sqs_queue_max_message_size        = 262144
  sqs_queue_message_retention_seconds = 345600
  sqs_queue_visibility_timeout_seconds = 300
  sqs_queue_receive_wait_time_seconds = 0
  sqs_queue_redrive_policy_max_receive_count = 3
  
  # Lambda Function Configuration
  lambda_function_name         = "dev-notifications-processor"
  lambda_function_runtime      = "python3.11"
  lambda_function_timeout      = 30
  lambda_function_memory_size  = 256
  lambda_function_handler      = "index.handler"
  lambda_function_description  = "Procesador de notificaciones para ambiente de desarrollo"
  lambda_layers                = []
  
  # Dead Letter Configuration
  enable_dlq                   = true
  dlq_max_receive_count        = 3
  
  # Retry Configuration
  max_retry_attempts           = 3
  retry_delay_seconds          = 60
  exponential_backoff          = true
  
  # Rate Limiting
  enable_rate_limiting         = false
  rate_limit_requests_per_second = 100
  burst_limit                  = 200
}

# Configuración de seguridad
security_config = {
  # KMS Keys
  enable_kms_encryption        = true
  kms_key_description          = "Clave de cifrado para notificaciones dev"
  kms_key_deletion_window_days = 7
  
  # IAM Policies
  enable_restrictive_policies  = false
  allowed_aws_principals       = []
  
  # VPC Endpoints
  enable_vpc_endpoints         = true
  s3_vpc_endpoint_enabled      = true
  sns_vpc_endpoint_enabled     = true
  sqs_vpc_endpoint_enabled     = true
  logs_vpc_endpoint_enabled    = true
  
  # Security Group
  enable_security_group        = true
  security_group_name          = "dev-notifications-sg"
  allowed_cidr_blocks          = ["10.0.0.0/16"]
  allowed_ports                = [443, 80]
  
  # Logging
  enable_detailed_logging      = true
  log_retention_days           = 7
}

# Configuración de monitoreo
monitoring_config = {
  # CloudWatch Metrics
  enable_metrics               = true
  metric_namespace             = "FinancialPlatform/Notifications"
  
  # Alarms
  enable_alarms                = true
  alarm_error_threshold        = 5
  alarm_latency_threshold_ms   = 1000
  alarm_queue_depth_threshold  = 1000
  
  # Dashboards
  enable_dashboard             = true
  dashboard_name               = "dev-notifications-dashboard"
  
  # Logs
  enable_logging               = true
  log_level                    = "DEBUG"
  
  # Events
  enable_cloudwatch_events     = true
  event_pattern = {
    source      = ["aws.notifications"]
    detail-type = ["Notification"]
  }
}

# Configuración de alta disponibilidad
ha_config = {
  enable_multi_az              = false
  min_size                     = 1
  max_size                     = 2
  desired_capacity             = 1
  health_check_type            = "ELB"
  health_check_grace_period    = 300
}

# Configuración de costos
cost_optimization = {
  enable_cost_monitoring       = true
  budget_alert_threshold       = 50
  enable_s3_intelligent_tiering = false
  enable_ec2_spot_instances    = false
}

# Configuración de recuperación ante desastres
dr_config = {
  enable_backup                = false
  backup_frequency             = "daily"
  retention_days               = 7
  enable_cross_region_replication = false
  rto_hours                    = 4
  rpo_hours                    = 1
}

// === ARCHIVO: environments/qa/terraform.tfvars ===
# Configuración de QA para el servicio de notificaciones
# Este archivo contiene los valores específicos del ambiente de QA

# Configuración de red
environment               = "qa"
common_tags = {
  Environment = "qa"
  Service     = "notifications"
  Owner       = "cloudops-team"
  Project     = "financial-platform"
  CostCenter  = "engineering"
}

# VPC Configuration
vpc_cidr_block           = "10.1.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs      = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnet_cidrs     = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
database_subnet_cidrs    = ["10.1.100.0/24", "10.1.101.0/24", "10.1.102.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = false

# DNS Configuration
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración del servicio de notificaciones
notifications_config = {
  # SNS Topic Configuration
  sns_topic_name                    = "qa-notifications-topic"
  sns_topic_fifo                    = false
  sns_topic_content_based_deduplication = false
  sns_topic_delivery_policy         = "standard"
  sns_topic_trace_enabled           = true
  
  # SQS Queue Configuration
  sqs_queue_name                    = "qa-notifications-queue"
  sqs_queue_fifo                    = false
  sqs_queue_dlq_name                = "qa-notifications-dlq"
  sqs_queue_max_message_size        = 262144
  sqs_queue_message_retention_seconds = 604800
  sqs_queue_visibility_timeout_seconds = 600
  sqs_queue_receive_wait_time_seconds = 20
  sqs_queue_redrive_policy_max_receive_count = 5
  
  # Lambda Function Configuration
  lambda_function_name         = "qa-notifications-processor"
  lambda_function_runtime      = "python3.11"
  lambda_function_timeout      = 60
  lambda_function_memory_size  = 512
  lambda_function_handler      = "index.handler"
  lambda_function_description  = "Procesador de notificaciones para ambiente QA"
  lambda_layers                = []
  
  # Dead Letter Configuration
  enable_dlq                   = true
  dlq_max_receive_count        = 5
  
  # Retry Configuration
  max_retry_attempts           = 5
  retry_delay_seconds          = 120
  exponential_backoff          = true
  
  # Rate Limiting
  enable_rate_limiting         = true
  rate_limit_requests_per_second = 500
  burst_limit                  = 1000
}

# Configuración de seguridad
security_config = {
  # KMS Keys
  enable_kms_encryption        = true
  kms_key_description          = "Clave de cifrado para notificaciones QA"
  kms_key_deletion_window_days = 10
  
  # IAM Policies
  enable_restrictive_policies  = true
  allowed_aws_principals       = ["arn:aws:iam::123456789012:role/qa-automation-role"]
  
  # VPC Endpoints
  enable_vpc_endpoints         = true
  s3_vpc_endpoint_enabled      = true
  sns_vpc_endpoint_enabled     = true
  sqs_vpc_endpoint_enabled     = true
  logs_vpc_endpoint_enabled    = true
  
  # Security Group
  enable_security_group        = true
  security_group_name          = "qa-notifications-sg"
  allowed_cidr_blocks          = ["10.1.0.0/16"]
  allowed_ports                = [443]
  
  # Logging
  enable_detailed_logging      = true
  log_retention_days           = 14
}

# Configuración de monitoreo
monitoring_config = {
  # CloudWatch Metrics
  enable_metrics               = true
  metric_namespace             = "FinancialPlatform/Notifications"
  
  # Alarms
  enable_alarms                = true
  alarm_error_threshold        = 10
  alarm_latency_threshold_ms   = 2000
  alarm_queue_depth_threshold  = 5000
  
  # Dashboards
  enable_dashboard             = true
  dashboard_name               = "qa-notifications-dashboard"
  
  # Logs
  enable_logging               = true
  log_level                    = "INFO"
  
  # Events
  enable_cloudwatch_events     = true
  event_pattern = {
    source      = ["aws.notifications"]
    detail-type = ["Notification"]
  }
}

# Configuración de alta disponibilidad
ha_config = {
  enable_multi_az              = true
  min_size                     = 2
  max_size                     = 4
  desired_capacity             = 2
  health_check_type            = "ELB"
  health_check_grace_period    = 300
}

# Configuración de costos
cost_optimization = {
  enable_cost_monitoring       = true
  budget_alert_threshold       = 200
  enable_s3_intelligent_tiering = true
  enable_ec2_spot_instances    = false
}

# Configuración de recuperación ante desastres
dr_config = {
  enable_backup                = true
  backup_frequency             = "daily"
  retention_days               = 14
  enable_cross_region_replication = false
  rto_hours                    = 2
  rpo_hours                    = 1
}

// === ARCHIVO: environments/prod/terraform.tfvars ===
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

```
