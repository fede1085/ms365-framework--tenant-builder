# @SYS-AGT-001 - Agent Map

> **Purpose:** Mapa de agentes. Define las capacidades, límites operacionales y áreas de responsabilidad de la IA dentro del framework.

## 1. Links Importantes
- **Global Orchestrator Profile:** `C:\Users\fede\.gemini\GEMINI.md`
- **Agent Rules:** `@.agents/rules`

## 2. Relaciones Inmediatas
- **Depende de:** `@SYS-MAP-005 — Semantic Map.md` (Como fuente de verdad para entender la estructura global).
- **Opera sobre:** `@01-FRAMEWORK` y `@02-INSTANCES` para asistir en la instanciación de matrices.
- **Restringido por:** `@ARC` (Los agentes no pueden modificar la arquitectura central sin autorización explícita).

## 3. Referencias Útiles
- **Modos Operativos:**
  - *Personal Admin:* Gestión de facturas, tareas, etc.
  - *M365 Architect:* Despliegue de tenants, estructuración de Entra ID.
  - *AI Builder:* Generación de herramientas y automatizaciones internas.
- **Responsabilidad de Agente:** Leer el contexto (`@SYS-MAP-005 — Semantic Map.md` y KIs) ANTES de ejecutar o modificar estructuras de carpetas. Los agentes deben usar siempre los prefijos correctos (ARC, BLP, MTX, AUT) al generar nuevos documentos.
