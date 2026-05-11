---
id: "@CAN-RUL-002"
domain: "Framework Ontology"
layer: "CAN"
type: "Rule"
status: "Active"
depends_on:
  - "@SYS-STD-002"
authority_level: 1
---

# @CAN-RUL-002 — Canonical Naming Enforcement

> **Purpose:** Deterministic execution rules for verifying the Naming System (`@SYS-STD-002`).

## 1. RegEx Validation

All files within the Framework boundary MUST pass this validation:

```regex
^(CAN|SYS|ARC|BLP|MTX|AUT)-(SYS|MAP|SCH|RUL|CMP|GRP|RTE|STD|GOV|TMP|USR|GRP|MBX|PRM|DOC|NAM|SEC|OPS)-[0-9]{3} — [A-Za-z0-9\s\-\&]+\.(md|json|csv|ps1)$
```

## 2. Sub-folder Routing Constraints

- `PREFIX == CAN` -> Must be routed to `00-CANONICAL — Structured Control Layer`
- `PREFIX == SYS` -> Must be routed to `00-SYSTEM — Semantic Control Layer`
- `PREFIX == ARC` -> Must be routed to `01-FRAMEWORK — Tenant Setup\01-ARC — Architecture`
- `PREFIX == BLP` -> Must be routed to `01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates`
- `PREFIX == MTX` -> Must be routed to `02-INSTANCES — Projects`
- `PREFIX == AUT` -> Must be routed to `01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables`

## 3. Disallowed Terminology

During generation, replace banned terms with Canonical Vocabulary (`@SYS-STD-001`):

- **Banned:** "Group email" -> **Canonical:** "Shared Mailbox"
- **Banned:** "Team mailbox" -> **Canonical:** "Shared Mailbox"
- **Banned:** "Account Permissions" -> **Canonical:** "Role" (if business function) or "Permissions" (if technical).
