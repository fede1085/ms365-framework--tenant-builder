# @SYS-MAP-005 — Semantic Map

> **Purpose:** Archivo central del Knowledge Graph. Define las restricciones semánticas, jerarquías, dependencias y relaciones globales para los sistemas de IA.
> **Role note:** High-level semantic map; does not override SYS-MAP-000, SYS-MAP-001, or CANONICAL contracts.

## 1. Mapa Global (Taxonomy Design)
La estructura canónica del proyecto se organiza en las siguientes ramas principales:
- `/Framework Structure`: Contiene la lógica del sistema.
- `/Blueprints`: Plantillas estructuradas y agnósticas (@BLP).
- `/Architecture`: Reglas maestras y gobernanza inmutable (@ARC, @GOV).
- `/Agents`: Definiciones de agentes de IA y sus comportamientos.
- `/Ontology`: Vocabulario canónico y modelos de datos.
- `/Workflows`: Procesos de ejecución y secuencias lógicas.
- `/Knowledge Graph Maps`: Capa de control semántico (@00-SYSTEM).

## 2. Restricciones Semánticas (Constraints)
- **Naming Conventions:** Todos los archivos deben utilizar el formato estricto `PREFIX-CATEGORY-###` (Ej: `@ARC-SYS-000`, `@BLP-TMP-002`). El prefijo define la capa.
- **Contexto:** Cada componente debe indicar claramente su capa arquitectónica (ARC, BLP, MTX, AUT) y no mezclar datos de instancia con reglas maestras.
- **Ownership:** 
  - La capa `@ARC` y `@GOV` son "Owner" de las reglas del sistema.
  - La capa `@BLP` es "Owner" de la estructura.
  - La capa `@MTX` es "Owner" de los datos reales del tenant.
- **Jerarquías:** Architecture -> Blueprint -> Matrix -> Automation. Las dependencias siempre fluyen desde arriba hacia abajo. No se permiten dependencias circulares.

## 3. Relaciones y Dependencias Globales
- **@Architecture** restringe y gobierna a **@Blueprints**.
- **@Blueprints** moldean la estructura de **@Matrix**.
- **@Matrix** alimenta directamente a **@Workflows** y automatizaciones.
- **@Agents** consumen **@Ontology** y **@Knowledge Graph Maps** para navegar y operar sin romper las reglas.

## 4. Conceptos y Entidades Centrales
- **Tenant:** Frontera organizacional en Microsoft 365.
- **Identity:** Entidades de usuario o cuentas de servicio.
- **Group:** Colecciones de seguridad o Microsoft 365.
- **Mailbox:** Recursos compartidos y delegación.
- **Blueprint:** Plantilla reutilizable y agnóstica sin datos de cliente.

---
**Enlaces del Grafo Central:**
- [Framework Ontology & Layer Model](@SYS-MAP-000 — Framework Ontology & Layer Model.md)
- [Entity Map](@SYS-ENT-001 — Entity Map.md)
- [Workflow Map](@SYS-MAP-006 — Workflow Map.md)
- [Agent Map](@SYS-AGT-001 — Agent Map.md)

**Índices y Reglas Globales (Nodos de Soporte):**
- [Master Index](@SYS-MAP-001 — Master Index.md)
- [Relations Map](@SYS-MAP-002 — Relations Map.md)
- [Canonical Vocabulary](@SYS-STD-001 — Canonical Vocabulary.md)
- [Naming System](@SYS-STD-002 — Naming System.md)
- [Authority Map](@SYS-MAP-004 — Authority Map.md)
- [Metadata Template](@SYS-TPL-001 — Metadata Template.md)
