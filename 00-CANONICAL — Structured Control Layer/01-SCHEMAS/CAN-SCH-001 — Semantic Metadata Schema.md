---
id: "@CAN-SCH-001"
domain: "Framework Ontology"
layer: "CAN"
type: "Schema"
status: "Active"
depends_on:
  - "@SYS-TPL-001"
  - "@SYS-MAP-000"
authority_level: 1
---

# @CAN-SCH-001 — Semantic Metadata Schema

> **Purpose:** Deterministic validation schema for the framework's metadata template. This canonical schema enforces the structure defined in `@SYS-TPL-001` to ensure AI agents parse document identity consistently.

## 1. Schema Definition (YAML Frontmatter)

Every document in the framework MUST adhere to this strict key-value schema:

```yaml
type: object
properties:
  id:
    type: string
    pattern: "^@[A-Z]{3}-[A-Z]{3}-[0-9]{3}$"
    description: "Strict canonical identifier."
  domain:
    type: string
    enum: ["Identity", "Collaboration", "Messaging", "Devices", "Security", "Framework Ontology", "Operations"]
  layer:
    type: string
    enum: ["ARC", "BLP", "MTX", "AUT", "SYS", "CAN"]
  type:
    type: string
    enum: ["Index", "Rule", "Template", "Matrix", "Script", "Schema", "Graph", "Router", "Map", "Standard", "Governance"]
  status:
    type: string
    enum: ["Draft", "Active", "Deprecated"]
  depends_on:
    type: array
    items:
      type: string
      pattern: "^@[A-Z]{3}-[A-Z]{3}-[0-9]{3}$"
  feeds:
    type: array
    items:
      type: string
      pattern: "^@[A-Z]{3}-[A-Z]{3}-[0-9]{3}$"
  related_to:
    type: array
    items:
      type: string
      pattern: "^@[A-Z]{3}-[A-Z]{3}-[0-9]{3}$"
  governed_by:
    type: array
    items:
      type: string
      pattern: "^@[A-Z]{3}-[A-Z]{3}-[0-9]{3}$"
  tags:
    type: array
    items:
      type: string
  authority_level:
    type: integer
    enum: [1, 2, 3, 4]
required:
  - id
  - layer
  - type
  - authority_level
```

## 2. Enforcement Rules

1. **Validation:** No AI agent may process a file that lacks a compliant metadata header.
2. **Immutability:** The `id` must exactly match the filename prefix.
3. **No Drift:** Custom fields are explicitly forbidden in the core framework layers (`ARC`, `SYS`, `CAN`).
