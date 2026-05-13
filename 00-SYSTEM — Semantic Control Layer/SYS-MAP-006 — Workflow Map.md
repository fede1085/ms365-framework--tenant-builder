# @SYS-MAP-006 — Workflow Map

> **Purpose:** Mapa de flujos de trabajo. Define cómo interactúan los procesos lógicos y de ejecución dentro del framework.

## 1. Links Importantes
- **Master Execution Workflow:** `@00-START — Execution Workflow.md` (in 01-FRAMEWORK)
- **Tenant Initialization:** `@00-START — Initialization Prompt.md` (in Root)

## 2. Relaciones Inmediatas
- **Depende de:** `@SYS-MAP-005 — Semantic Map.md` (Para restricciones lógicas).
- **Alimenta a:** La capa `/Agents` (Para automatización de las tareas).
- **Gobernado por:** La capa `/Architecture` y los documentos `@ARC`.

## 3. Referencias Útiles
- **Official Prompt Workflow:**
  
  ```text
  00-START — Initialization Prompt
      ↓
  01-GENERATION — Blueprint Generation Prompt
      ↓
  02-VALIDATION — Blueprint Validation Prompt
      ↓
  03-MTX — Matrix Generation Prompt
      ↓
  04-AUT-DEPLOYMENT — Controlled Execution Prompt

Operational Flow:

DISCOVERY
→ PRJ-BLUEPRINT-MASTER-DOC
→ DOMAIN BLP
→ VALIDATED BLP
→ MTX
→ AUT

Workflow Principle:

ARCH → BLP → MTX → AUT
Each prompt phase must STOP after completion and require explicit human approval before continuing into the next orchestration phase.

- **Protección de Datos:** Los workflows nunca deben sobrescribir los archivos de la capa Architecture. Modifican únicamente la capa Matrix (@MTX) durante el despliegue.
- Para la creación de nuevos flujos, consultar siempre las convenciones de nombres y reglas en `/Ontology` y `/Architecture`.
