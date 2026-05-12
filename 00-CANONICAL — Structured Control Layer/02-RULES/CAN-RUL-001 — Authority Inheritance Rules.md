---
id: "@CAN-RUL-001"
domain: "Framework Ontology"
layer: "CAN"
type: "Rule"
status: "Active"
depends_on:
  - "@SYS-MAP-004"
authority_level: 1
authority_note: "CAN inherits authority_level 1 by delegation from SYS-MAP-004. CAN does NOT independently originate authority. CAN is the enforcement layer of SYS governance."
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

## 3. CAN Layer Authority Declaration

The `CAN` layer is assigned `authority_level: 1` by **delegation from `@SYS-MAP-004`**, not by independent assertion.

- `@SYS-MAP-004` defines the AI Resolution Hierarchy: `ARC > BLP > MTX > AUT`.
- `SYS` documents (LAYER 1 in `@SYS-MAP-000`) own the `@` reference system and semantic routing.
- `CAN` documents **enforce** SYS governance deterministically.
- If an AI agent resolves authority conflicts using `@SYS-MAP-004`, the `CAN` layer resolves at the same level as `ARC` **because** CAN enforces ARC rules.
- `CAN` must NEVER redefine, relax, or contradict the rules it enforces from `@SYS-MAP-004`.
