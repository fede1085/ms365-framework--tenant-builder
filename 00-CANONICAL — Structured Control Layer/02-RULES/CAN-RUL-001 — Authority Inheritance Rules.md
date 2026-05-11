---
id: "@CAN-RUL-001"
domain: "Framework Ontology"
layer: "CAN"
type: "Rule"
status: "Active"
depends_on:
  - "@SYS-MAP-004"
authority_level: 1
---

# @CAN-RUL-001 — Authority Inheritance Rules

> **Purpose:** Deterministic logic for resolving conflicts during AI context loading and generation based on `@SYS-MAP-004`.

## 1. Authority Resolution Engine

When generating files, if two sources provide conflicting guidance, the agent MUST resolve using this hierarchy:

1. **Level 1: Absolute Truth (`authority_level: 1`)**
   - Covers: `ARC-SYS-000`, `ARC-STD-*`, `SYS-MAP-*`, `CAN-*`
   - *Behavior:* Never override. Abort operation if user requests a violation.

2. **Level 2: Policy Truth (`authority_level: 2`)**
   - Covers: `ARC-GOV-*`
   - *Behavior:* Enforce policy. Exceptions require explicit user confirmation and documentation.

3. **Level 3: Structural Truth (`authority_level: 3`)**
   - Covers: `BLP-*`
   - *Behavior:* Extendable. Can be modified per instance but must not break Level 1 or 2 rules.

4. **Level 4: Instance Truth (`authority_level: 4`)**
   - Covers: `MTX-*`
   - *Behavior:* Fluid. Valid only for the specific project instance.

## 2. Inheritance Checks

- A document `D` with `authority_level: X` cannot `govern` a document with `authority_level: Y` where `Y < X`.
- Dependencies flow downwards. `MTX` depends on `BLP`, `BLP` depends on `ARC`. `ARC` does NOT depend on `MTX`.
