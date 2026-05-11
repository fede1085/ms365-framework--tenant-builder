---
id: "@CAN-SCH-002"
domain: "Framework Ontology"
layer: "CAN"
type: "Schema"
status: "Active"
depends_on:
  - "@SYS-MAP-000"
authority_level: 1
---

# @CAN-SCH-002 — Layer Ontology Schema

> **Purpose:** Formalizes the conceptual layer boundaries of `@SYS-MAP-000` into a deterministic enforcement schema.

## 1. Ontology Strict Boundaries

The system recognizes exactly four executable abstractions and two control abstractions.

### Control Abstractions
- **SYS (Semantic Control):** The declarative mapping of the system.
- **CAN (Structured Control):** The deterministic enforcement of the SYS mapping.

### Executable Abstractions
- **ARC (Architecture):** Immutable rules. *No client data allowed.*
- **BLP (Blueprint):** Reusable structures. *No client data allowed.*
- **MTX (Matrix):** Instance-specific values. *Only valid source of deployment data.*
- **AUT (Automation):** Imperative execution scripts. *Must only consume MTX.*

## 2. Abstraction Interface Schema

```json
{
  "OntologyRules": {
    "ARC": {
      "Reads": ["SYS", "CAN"],
      "Writes": [],
      "ContainsData": false
    },
    "BLP": {
      "Reads": ["ARC"],
      "Writes": [],
      "ContainsData": false
    },
    "MTX": {
      "Reads": ["BLP"],
      "Writes": [],
      "ContainsData": true
    },
    "AUT": {
      "Reads": ["MTX"],
      "Writes": ["Tenant"],
      "ContainsData": false
    }
  }
}
```

## 3. Boundary Violation Prevention
- Any `@MTX` file attempting to define a new rule violates the ontology.
- Any `@ARC` file containing real user emails violates the ontology.
- AI Agents must block and reject cross-layer data contamination.
