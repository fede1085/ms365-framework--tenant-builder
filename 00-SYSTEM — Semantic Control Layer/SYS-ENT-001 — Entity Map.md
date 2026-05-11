# @SYS-ENT-001 - Entity Map

> **Purpose:** Mapa de entidades. Define los objetos principales del sistema, sus límites de responsabilidad y atributos clave.

## 1. Links Importantes
- **Diccionario Central:** `@SYS-STD-001 — Canonical Vocabulary.md`
- **Definiciones de Identidad:** `@BLP-TMP-003` (User Matrix Template)

## 2. Relaciones Inmediatas
- **User (Identity):** Se relaciona con -> `Group`, `Role`, `Shared Mailbox`.
- **Group (Security/M365):** Contiene -> `User`. Otorga -> `Permissions`.
- **Shared Mailbox:** Propiedad de -> `Group` o `User`.
- **Tenant:** Entidad raíz que contiene todo lo anterior.

## 3. Referencias Útiles
- **Entidades de Sistema (IA/Arquitectura):**
  - *Blueprint:* Estructura sin estado.
  - *Matrix:* Estructura con estado (Datos reales).
- **Restricciones de Entidad:** Una entidad de tipo User NO puede ser tratada como un Group en términos de permisos delegados o roles administrativos a menos que esté documentado en la capa `@ARC`.
- **Identificadores Únicos:** Todas las entidades (físicas o lógicas) deben poder mapearse de vuelta a una convención de nomenclatura aprobada (Naming Convention).