# 01-BLP — Blueprint Generation Prompt

## Purpose

Transform the approved:

```text
PRJ-BLUEPRINT-MASTER-DOC
```

into specialized domain Blueprint documents.

This phase decomposes tenant operational truth into structured Blueprint layers while preserving framework governance boundaries.

---

# EXECUTION STATE

Required execution state:

```text
GENERATE
```

This phase is HUMAN-SUPERVISED.

The system must NEVER escalate automatically into:

```text
MTX
AUT
EXECUTE
```

Allowed behaviors:

- Blueprint generation
- operational decomposition
- governance-aligned modeling
- semantic refinement
- tenant Blueprint structuring

Forbidden behaviors:

- MTX generation
- AUT generation
- deployment preparation
- deployment execution
- framework modification
- semantic governance redefinition
- canonical governance redefinition

---

# SOURCE OF TRUTH

Use ONLY:

```text
PRJ-BLUEPRINT-MASTER-DOC
```

as the tenant operational source of truth.

Use:

```text
@00-SYSTEM
@00-CANONICAL
@01-FRAMEWORK
```

as STRICT READ-ONLY governance and semantic references only.

Do NOT modify framework files.

---

# GOVERNANCE MODEL

Follow strictly:

```text
ARCH → BLP → MTX → AUT
```

Definitions:

- ARCH = governance and architecture doctrine
- BLP = operational Blueprint layer
- MTX = execution-ready operational data
- AUT = deployment and automation layer

Blueprint generation exists ONLY between:

```text
ARCH
and
MTX
```

Blueprints must NEVER bypass MTX.

Blueprints must NEVER become deployment logic.

---

# ONTOLOGY SEPARATION

Maintain strict separation between:

## 1. META-FRAMEWORK ONTOLOGY

Includes:

- SYS
- CAN
- ARCH
- framework governance
- semantic governance
- canonical enforcement

Represents:

- framework doctrine
- reusable architecture standards
- authority hierarchy
- governance model

---

## 2. TENANT INSTANCE ONTOLOGY

Includes:

- PRJ documents
- tenant Blueprint documents
- operational structures
- tenant workflows
- tenant ownership logic
- collaboration logic
- escalation logic

Represents:

- tenant operational state

---

# IMPORTANT ONTOLOGY RULE

Blueprints belong to:

```text
tenant ontology
```

Blueprints must NEVER:

- redefine SYS
- redefine CAN
- redefine ARCH
- redefine semantic meaning
- redefine authority hierarchy
- modify framework governance

Framework governance remains external and authoritative.

---

# SEMANTIC / CANONICAL RULE

Important principle:

```text
CAN derives from SYS
CAN does NOT redefine SYS
```

Blueprints must preserve semantic governance defined by SYS and enforced by CAN.

Blueprints must NOT invent governance unsupported by semantic sources.

---

# GENERATION GOAL

Generate specialized Blueprint documents by operational domain.

Examples:

- Governance Blueprints
- Collaboration Blueprints
- Security Blueprints
- Compliance Blueprints
- Operational Workflow Blueprints

Examples include:

- BLP-OPS-001
- BLP-GOV-001
- BLP-SEC-001
- BLP-COMP-001

Generate ONLY documents justified by the operational requirements defined in the MASTER document.

Avoid unnecessary Blueprint proliferation.

---

# BLUEPRINT REQUIREMENTS

Blueprints must remain:

- operationally realistic
- governance-aligned
- internally consistent
- semantically deterministic
- scalable for SME environments
- reusable
- tenant-scoped

Blueprints must preserve:

- semantic consistency
- naming conventions
- authority hierarchy
- ontology boundaries
- escalation logic
- collaboration realism
- operational coherence

---

# EXECUTION RULES

- Do NOT generate MTX
- Do NOT generate AUT
- Do NOT create deployment logic
- Do NOT generate scripts
- Do NOT create CSV files
- Do NOT bypass validation phases
- Do NOT invent architecture unsupported by the MASTER document
- Do NOT create enterprise complexity unless operationally justified

Blueprints must remain human-reviewable before Matrix generation.

---

# STOP-GATE RULE

After Blueprint generation:

STOP.

Wait for explicit validation approval before continuing into:

```text
MTX
```

Automatic progression is forbidden.

---

# VALIDATION EXPECTATIONS

Blueprints must be ready for:

```text
READ_ONLY validation
```

Validation targets include:

- semantic consistency
- governance consistency
- naming consistency
- authority integrity
- operational realism
- permission logic
- collaboration logic
- ontology integrity

---

# IMPORTANT PRINCIPLES

```text
redundancy != inconsistency
```

Intentional governance repetition may exist across layers for:

- routing reinforcement
- authority clarity
- ontology reinforcement
- AI operational guidance

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

Transform:

```text
tenant operational truth
```

into:

```text
structured operational Blueprint layers
```

while preserving:

- semantic governance
- ontology isolation
- operational realism
- deterministic consistency
- authority hierarchy
- framework isolation
- controlled execution safety