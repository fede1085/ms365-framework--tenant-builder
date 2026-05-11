---
id: "@CAN-GRP-001"
domain: "Framework Ontology"
layer: "CAN"
type: "Graph"
status: "Active"
depends_on:
  - "@SYS-MAP-002"
  - "@SYS-MAP-005"
authority_level: 1
---

# @CAN-GRP-001 — Semantic Dependency Graph

> **Purpose:** Machine-readable relational logic based on `@SYS-MAP-002` and `@SYS-MAP-005`. Determines impact radius when updating framework files.

## 1. Graph Definitions

### Edges
- `GOVERNS`: [Source] dictates rules for [Target].
- `FEEDS`: [Source] provides structural shape to [Target].
- `INSTANTIATES`: [Target] is a specific deployed version of [Source].
- `CONSUMES`: [Source] processes [Target] as data.

## 2. Dependency Matrix

| Source Node | Edge | Target Node | Constraint |
| :--- | :--- | :--- | :--- |
| `@ARC-SYS-000` | GOVERNS | `@BLP-SYS-000` | Absolute Authority |
| `@ARC-STD-007` | GOVERNS | `@BLP-TMP-*` | Naming validation required |
| `@BLP-TMP-003` | FEEDS | `@MTX-USR-001` | MTX must match BLP columns |
| `@AUT-DOC-009` | CONSUMES | `@MTX-USR-001` | AUT cannot run without MTX |

## 3. Impact Analysis Router
If an `@ARC` file is modified, the AI must traverse the `GOVERNS` edge to flag related `@BLP` files for review.
If a `@BLP` file is modified, the AI must traverse the `FEEDS` edge to update corresponding `@MTX` schemas.
