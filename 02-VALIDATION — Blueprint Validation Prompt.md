# 02-VAL — Blueprint Validation Prompt

## Purpose

Validate the generated Blueprint layer before Matrix generation.

This phase audits:

- semantic consistency
- governance consistency
- naming consistency
- authority integrity
- ontology boundaries
- operational realism
- permission logic
- collaboration logic
- escalation logic
- workflow coherence

The goal is to prevent semantic contamination propagation into MTX and AUT layers.

---

# EXECUTION STATE

Required execution state:

```text
READ_ONLY
```

Allowed behaviors:

- inspection
- semantic validation
- governance validation
- operational review
- ontology verification
- reporting
- consistency analysis

Forbidden behaviors:

- modifying Blueprint files
- modifying framework files
- generating MTX
- generating AUT
- deployment preparation
- deployment execution
- automatic correction
- governance redefinition

Validation must remain HUMAN-SUPERVISED.

The system must NEVER escalate automatically into:

```text
GENERATE
EXECUTE
```

---

# VALIDATION SCOPE

Audit ONLY:

- tenant Blueprint documents
- tenant operational logic
- generated BLP files

Use:

```text
@00-SYSTEM
@00-CANONICAL
@01-FRAMEWORK
```

as STRICT READ-ONLY validation references.

Do NOT modify framework architecture.

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

Validation exists between:

```text
BLP
and
MTX
```

Validation must NEVER bypass governance layers.

Validation must NEVER redefine architecture.

---

# ONTOLOGY SEPARATION

Maintain strict separation between:

## 1. META-FRAMEWORK ONTOLOGY

Includes:

- SYS
- CAN
- ARCH
- semantic governance
- canonical enforcement
- framework governance

Represents:

- framework doctrine
- semantic architecture
- authority hierarchy
- governance system

---

## 2. TENANT INSTANCE ONTOLOGY

Includes:

- PRJ documents
- generated Blueprint documents
- tenant workflows
- tenant operational logic
- ownership structures
- collaboration structures
- escalation paths

Represents:

- tenant operational state

---

# IMPORTANT ONTOLOGY RULE

Validation must verify that tenant ontology has NOT contaminated framework ontology.

Validation must detect:

- framework governance copied into tenant files as authoritative architecture
- tenant operational logic leaking into framework governance
- cross-layer contamination
- authority confusion
- semantic drift
- governance drift

Framework governance remains external and authoritative.

---

# SEMANTIC / CANONICAL RULE

Semantic governance originates from:

```text
00-SYSTEM
```

Canonical enforcement derives from:

```text
00-CANONICAL
```

Important principle:

```text
CAN derives from SYS
CAN does NOT redefine SYS
```

Validation must detect any case where:

- canonical meaning exceeds semantic meaning
- Blueprint governance contradicts semantic governance
- Blueprint logic invents unsupported authority
- operational assumptions bypass framework governance

---

# VALIDATION OBJECTIVES

Detect:

- naming drift
- authority conflicts
- operational inconsistencies
- governance gaps
- invalid ownership
- permission conflicts
- invalid escalation paths
- cross-layer contamination
- unsupported Blueprint assumptions
- semantic contradictions
- routing inconsistencies
- workflow inconsistencies
- framework/instance boundary violations

---

# VALIDATION TARGETS

Audit:

- semantic consistency
- governance consistency
- naming consistency
- ontology integrity
- authority hierarchy
- operational realism
- collaboration logic
- escalation logic
- permission logic
- lifecycle coherence
- workflow coherence

Blueprints must remain:

- semantically deterministic
- governance-aligned
- operationally realistic
- tenant-scoped
- reusable
- validation-safe

---

# OUTPUT REQUIREMENTS

Generate:

- structured validation report
- categorized findings
- severity classification
- recommended corrections
- ontology integrity verification
- governance consistency verification
- operational consistency verification

Examples:

```text
CLEAN
WARNING
CRITICAL
```

---

# SEVERITY DEFINITIONS

## CLEAN

No meaningful issue detected.

Blueprint layer is:

- semantically stable
- governance-aligned
- operationally coherent
- ready for Matrix generation

---

## WARNING

Issue exists but does NOT break:

- ontology integrity
- authority hierarchy
- operational viability
- governance consistency

Correction is recommended before MTX generation.

---

## CRITICAL

Issue may break:

- ontology boundaries
- semantic governance
- authority hierarchy
- execution safety
- operational consistency
- MTX generation reliability

CRITICAL findings must be resolved before proceeding.

---

# IMPORTANT RULES

- READ-ONLY mode
- Do NOT modify files automatically
- Do NOT generate MTX
- Do NOT generate AUT
- Do NOT expand architecture
- Do NOT create new governance models unless explicitly requested
- Do NOT simplify intentional governance redundancy

Validation exists ONLY to audit and report.

---

# IMPORTANT PRINCIPLE

```text
redundancy != inconsistency
```

Intentional governance repetition may exist for:

- routing reinforcement
- authority clarity
- ontology reinforcement
- AI operational guidance

Do NOT classify intentional governance redundancy as corruption automatically.

---

# STOP-GATE RULE

After validation:

STOP.

Wait for explicit approval before continuing into:

```text
MTX generation
```

Automatic progression is forbidden.

---

# FINAL OBJECTIVE

Ensure the Blueprint layer is:

- semantically stable
- governance-aligned
- canonically consistent
- operationally realistic
- ontology-safe
- authority-consistent
- validation-safe
- ready for Matrix generation

while preserving:

- semantic governance
- ontology integrity
- operational realism
- deterministic consistency
- authority hierarchy
- framework isolation
- controlled execution safety