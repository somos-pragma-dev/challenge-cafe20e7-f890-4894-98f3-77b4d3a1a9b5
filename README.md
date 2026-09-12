# Diseño y despliegue de la infraestructura de notificaciones en AWS

El servicio de notificaciones es un componente crítico para la comunicación con los clientes en nuestra plataforma financiera. Debe ser escalable, seguro y capaz de manejar un alto volumen de transacciones. El objetivo es liderar la iniciativa de infraestructura para este servicio, asegurando que cumpla con los requisitos de rendimiento, seguridad y disponibilidad.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura del servicio de notificaciones |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 2 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Evaluación de requerimientos y diseño inicial

**Objetivo:** Identificar los requerimientos del servicio de notificaciones y proponer un diseño inicial.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Analiza los requerimientos funcionales y no funcionales del servicio de notificaciones.
- Identifica las posibles arquitecturas y tecnologías que se pueden utilizar en AWS.
- Propon un diseño inicial que cumpla con los requerimientos identificados.

**Entregable:** Documento de diseño inicial del servicio de notificaciones en AWS.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la escalabilidad y la latencia en tu propuesta.
- Evalúa las opciones de seguridad y cumplimiento normativo.

</details>

### Fase 2: Despliegue y configuración de la infraestructura

**Objetivo:** Desplegar y configurar la infraestructura del servicio de notificaciones en AWS.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Utiliza las herramientas y servicios de AWS para desplegar la infraestructura propuesta.
- Configura los servicios para que cumplan con los requerimientos de rendimiento, seguridad y disponibilidad.
- Realiza pruebas de integración para validar el funcionamiento de la infraestructura.

**Entregable:** Infraestructura del servicio de notificaciones desplegada y configurada en AWS.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza servicios como EC2, RDS, SNS y SQS para construir la infraestructura.
- Aplica las mejores prácticas de seguridad y rendimiento en la configuración de los servicios.

</details>

### Fase 3: Optimización y monitoreo

**Objetivo:** Optimizar el rendimiento y configurar el monitoreo del servicio de notificaciones.

**Tiempo estimado:** 4 días

**Instrucciones:**

- Identifica áreas de optimización en la infraestructura desplegada.
- Aplica técnicas de optimización para mejorar el rendimiento y la eficiencia.
- Configura el monitoreo y las alertas para detectar y responder a problemas en tiempo real.

**Entregable:** Infraestructura optimizada y monitoreo configurado para el servicio de notificaciones.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza servicios como CloudWatch y X-Ray para el monitoreo y la optimización.
- Aplica técnicas de caché y balanceo de carga para mejorar el rendimiento.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la infraestructura del servicio de notificaciones y cuáles son sus componentes principales?
- **paraQueSirve**: ¿Para qué sirve la infraestructura del servicio de notificaciones y cuáles son sus beneficios?
- **comoSeUsa**: ¿Cómo se utiliza la infraestructura del servicio de notificaciones para enviar notificaciones a los clientes?
- **erroresComunes**: ¿Cuáles son los errores comunes que pueden ocurrir en la infraestructura del servicio de notificaciones y cómo se pueden prevenir?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño y despliegue de la infraestructura del servicio de notificaciones y cómo se pueden justificar?

## Criterios de Evaluacion

- Proponer un diseño inicial que cumpla con los requerimientos del servicio de notificaciones.
- Desplegar y configurar la infraestructura del servicio de notificaciones en AWS.
- Optimizar el rendimiento y configurar el monitoreo del servicio de notificaciones.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
