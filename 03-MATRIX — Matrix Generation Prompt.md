# 03-MTX — Matrix Generation Prompt

# Generate tenant Matrix layer: [project_name]

Use Agent Mode.

This root prompt is a workflow entrypoint for MTX generation. It does not define authority doctrine.

---

# EXECUTION STATE

Current execution state:

```text
GENERATE
````

Allowed operational states:

```text id="x8a2wc"
READ_ONLY
PLAN
GENERATE
EXECUTE
```

Execution-state progression must remain HUMAN-SUPERVISED.

The system must NEVER escalate execution state automatically.

Forbidden behaviors:

* modifying framework files
* generating AUT automatically
* deployment execution
* PowerShell execution
* tenant modification
* automatic deployment progression

---

# SOURCE FOLDERS

Read framework governance and semantic rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@.agents\rules
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates

Read validated Blueprint layer from:

```text
02-INSTANCES — Projects\[project_name]\02-BLP
```

Generate MTX files inside:

```text id="3f5j6l"
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

---

# CORE MODEL

Follow strictly:

```text id="mjlwm1"
SYS → CANONICAL → ARC → BLP → MTX → AUT
```

Current workflow scope:

```text id="m0e5xb"
VALIDATED BLP
→ MTX
```

This prompt handles ONLY:

* MTX generation
* operational data transformation
* execution-ready CSV generation

It must NOT generate:

* AUT
* deployment preparation
* deployment execution

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
* MTX files
* operational data
* users
* groups
* mailboxes
* permissions

Represents tenant operational state only.

---

# IMPORTANT ONTOLOGY RULE

MTX generation must NEVER:

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

MTX operationalizes Blueprint logic only.
Blueprints are design intent, not runtime input. MTX is the concrete runtime tenant data layer.

---

# STEP 1 — LOAD VALIDATED BLUEPRINT LAYER

Load Blueprint documents from:

```text id="t9k5zv"
02-INSTANCES — Projects\[project_name]\02-BLP
```

Treat Blueprint layer as:

```text id="b0v2mx"
validated tenant operational design source
```

Generate operational MTX data ONLY from validated Blueprint logic.
Distinguish semantic IDs from runtime identifiers: semantic IDs describe framework references; runtime identifiers identify concrete tenant objects.

---

# STEP 2 — GENERATE MATRIX LAYER

Generate execution-ready CSV files inside:

```text
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

**Required files:**

* MTX-USERS.csv
* MTX-GROUPS.csv
* MTX-MAILBOXES.csv
* MTX-PERMISSIONS.csv


**Optional files:**

* MTX-LICENSES.csv
* MTX-CHANNELS.csv
* MTX-OWNERSHIP.csv
* MTX-LIFECYCLE.csv

---

# EXECUTION SCHEMA AUTHORITY

Execution-ready CSV schemas are governed by:

@01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables

Authoritative schema references:

- AUT-DOC-009 — Users CSV Schema.md
- AUT-DOC-010 — Permissions CSV Schema.md
- AUT-DOC-011 — Full Tenant Build Script.md

IMPORTANT:

Blueprints define tenant operational logic.

AUT documents define execution-ready CSV structure and operational schema contracts.

MTX generation must:

- generate operational data from validated Blueprint logic
- use AUT schema contracts as authoritative CSV structure
- preserve deterministic column consistency with AUT runtime expectations

MTX must NEVER invent alternative execution schemas or column names.

---

# MATRIX RULES

MTX generation must:

* apply naming from ARC
* apply governance from BLP
* apply ownership logic from MASTER
* preserve authority hierarchy
* preserve operational realism
* preserve tenant isolation

MTX defines:

```text id="w1s0te"
execution-ready operational data
```

MTX must NEVER redefine governance.

---

# REQUIRED VALIDATION DURING GENERATION

Detect:

* duplicate users
* duplicate groups
* orphan ownership
* invalid naming
* invalid permissions
* missing departments
* inconsistent relationships

Do NOT auto-correct unless explicitly requested.

---

# STOP-GATE RULE

After MTX generation:

STOP.

Do NOT continue automatically.

Output:

```text id="l0q6hz"
MTX GENERATION COMPLETE
READY FOR AUT PREPARATION
```

Then ask:

```text id="a6z3mf"
Are you ready for:
04-AUT-DEPLOYMENT — Controlled Execution Prompt ?
```

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT generate AUT automatically
* Do NOT deploy
* Do NOT execute PowerShell

Core principle:

```text id="b7w4oj"
ARC governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

Important principle:

```text id="d5f1gw"
redundancy != inconsistency
```

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

```text"
VALIDATED BLUEPRINT LAYER
→ EXECUTION-READY MTX LAYER
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
