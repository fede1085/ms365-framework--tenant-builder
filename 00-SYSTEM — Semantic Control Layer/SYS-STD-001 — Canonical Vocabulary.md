# @SYS-STD-001 - Canonical Vocabulary

> **Purpose:** Unified terminology system to prevent semantic drift, normalize duplicated meanings, synonyms, and ambiguous terminology.

## A-Z Terminology

### A
- **Account:** Refers strictly to the Entra ID object (User). Do not use for Mailboxes or generic access.
- **Architecture (@ARC):** The foundational rule-set. Never contains specific client data.

### B
- **Blueprint (@BLP):** Standardized, reusable templates. Connects architecture to specific project matrices.

### G
- **Group:** Especificamente un Entra ID Security Group o Microsoft 365 Group. Evitar el uso de "team" o "department" cuando se refiere al objeto técnico.

### I
- **Instance:** A specific, deployed project or tenant setup (e.g., within `@02-INSTANCES`).

### M
- **Matrix (@MTX):** Data tables containing specific tenant values (Users, Groups, Permissions) intended for automation ingestion.
- **Member:** A user object that belongs to a Group.

### O
- **Owner:** A user object that has administrative control over a Group or Mailbox. Distinct from a generic "Manager".

### P
- **Permissions:** Technical access rights (e.g., Read, Write, FullAccess, SendAs). Do not confuse with Role.

### R
- **Role:** A business function (e.g., "Warehouse Manager"). A Role dictates Permissions but is not a Permission itself.

### S
- **Shared Mailbox:** An Exchange Online object without a standalone login, accessed via delegation. Do not call it a "Group email".

### T
- **Tenant:** The specific Microsoft 365 organization boundary.
- **Template:** A reusable pattern. Use Blueprint (@BLP) for structural templates and @METADATA_TEMPLATE for file headers.
