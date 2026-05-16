````markdown id="m6n2xv"
# 02-VALIDATION — Blueprint Validation Prompt

# Validate tenant Blueprint layer: [project_name]

Use Agent Mode.

This root prompt is a workflow entrypoint for validation. It does not define authority doctrine.

---

# EXECUTION STATE

Current execution state:

```text
READ_ONLY
````

Allowed operational states:

```text id="l6f9qk"
READ_ONLY
PLAN
GENERATE
EXECUTE
```

Execution-state progression must remain HUMAN-SUPERVISED.

The system must NEVER escalate execution state automatically.

Forbidden behaviors:

* modifying framework files
* generating MTX automatically
* generating AUT
* deployment execution
* PowerShell execution
* tenant modification
* automatic correction without approval

---

# SOURCE FOLDERS

Read framework governance and semantic rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@.agents\rules
@.agents\workflows
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates

Validate tenant Blueprint files from:

```text id="r9v8dz"
02-INSTANCES — Projects\[project_name]\02-BLP
```

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

---

# CORE MODEL

Follow strictly:

```text id="svr0r2"
SYS → CANONICAL → ARC → BLP → MTX → AUT
```

Current workflow scope:

```text id="3iuhs2"
DOMAIN BLP
→ VALIDATION
```

This prompt handles ONLY:

* Blueprint validation
* governance validation
* semantic validation
* operational validation

It must NOT generate:

* MTX automatically
* AUT
* deployment preparation

---

# ONTOLOGY SEPARATION

Maintain strict ontology boundaries between:

## META-FRAMEWORK ONTOLOGY

Includes:

* SYS
* CANONICAL
* ARC
* semantic governance
* canonical enforcement
* framework doctrine

Represents reusable framework authority.

---

## TENANT INSTANCE ONTOLOGY

Includes:

* PRJ files
* tenant Blueprint documents
* operational structures
* workflows
* users
* groups
* permissions

Represents tenant operational state only.

---

# IMPORTANT ONTOLOGY RULE

Validation must NEVER:

* modify SYS
* modify CANONICAL
* modify ARC
* redefine governance
* redefine semantic meaning
* redefine canonical meaning

Framework governance remains external and authoritative.

Detect and prevent:

* semantic drift
* governance drift
* cross-layer contamination
* framework/tenant authority confusion

---

# STEP 1 — LOAD BLUEPRINT LAYER

Validate all tenant Blueprint documents from:

```text id="0x3v7n"
02-INSTANCES — Projects\[project_name]\02-BLP
```

Treat Blueprint documents as:

```text id="xj3d6l"
tenant operational design layer
```

Validation must remain READ_ONLY unless explicitly instructed otherwise.

---

# STEP 2 — VALIDATE BLUEPRINT CONSISTENCY

Validate:

* semantic consistency
* naming consistency
* governance consistency
* operational realism
* authority hierarchy
* collaboration logic
* ownership logic
* permission logic
* lifecycle coherence
* ontology boundaries

Detect:

* semantic contradictions
* naming drift
* governance conflicts
* unsupported assumptions
* orphan ownership
* permission inconsistencies
* operational gaps
* cross-layer contamination

---

# VALIDATION RULES

Validation must:

* preserve ontology boundaries
* preserve framework isolation
* preserve tenant isolation
* preserve deterministic consistency
* validate against SYS/CANONICAL/ARC/BLP authority and constraints

Validation must NEVER:

* redesign tenant architecture automatically
* mutate tenant runtime data
* generate MTX automatically
* generate AUT automatically
* create deployment logic

Generate findings only unless explicitly instructed to correct.

---

# OUTPUT REQUIREMENTS

Return validation findings in chat unless report-file creation is explicitly requested. Include:

* findings summary
* governance issues
* semantic issues
* naming issues
* operational issues
* ontology-boundary verification

Use severity levels:

```text id="szzv6q"
CLEAN
WARNING
CRITICAL
```

---

# STOP-GATE RULE

After validation:

STOP.

Do NOT continue automatically.

If validation status is acceptable, output:

```text id="s59z3y"
BLUEPRINT VALIDATION COMPLETE
READY FOR MTX GENERATION
```

Then ask:

```text id="mjlwm8"
Are you ready for:
03-MTX — Matrix Generation Prompt ?
```

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT skip validation
* Do NOT generate AUT
* Do NOT deploy

Core principle:

```text id="7e9c0z"
ARC governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

Important principle:

```text id="vgn62v"
redundancy != inconsistency
```

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

```text id="m5b7d2"
DOMAIN BLUEPRINT LAYER
→ VALIDATED BLUEPRINT LAYER
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
