````markdown id="e7d4nm"
# 01-GENERATION — Blueprint Generation Prompt

# Generate tenant Blueprint layer: [project_name]

Use Agent Mode.

This root prompt is a workflow entrypoint for BLP generation. It does not define authority doctrine.

---

# EXECUTION STATE

Current execution state:

```text
GENERATE
````

Allowed operational states:

```text id="6l9jcb"
READ_ONLY
PLAN
GENERATE
EXECUTE
```

Execution-state progression must remain HUMAN-SUPERVISED.

The system must NEVER escalate execution state automatically.

Forbidden behaviors:

* modifying framework files
* generating MTX
* generating AUT
* deployment execution
* PowerShell execution
* tenant modification
* automatic progression into deployment phases

---

# SOURCE FOLDERS

Read framework governance and semantic rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@.agents\rules
@.agents\workflows
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates

Read tenant operational source from:

```text id="7h77o2"
02-INSTANCES — Projects\[project_name]\02-BLP\PRJ-BLUEPRINT-MASTER-DOC.md
```

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

---

# CORE MODEL

Follow strictly:

```text id="2mw9c2"
SYS → CANONICAL → ARC → BLP → MTX → AUT
```

Current workflow scope:

```text id="y1zzyz"
PRJ-BLUEPRINT-MASTER-DOC
→ DOMAIN BLP
```

This prompt handles ONLY:

* Blueprint generation
* operational decomposition
* domain Blueprint creation

Blueprint output is tenant design/template content only. It is not runtime MTX and is not direct AUT input.

It must NOT generate:

* MTX
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
* users
* groups
* permissions
* workflows

Represents tenant operational state only.

---

# IMPORTANT ONTOLOGY RULE

Blueprint generation must NEVER:

* modify SYS
* modify CANONICAL
* modify ARC
* redefine governance
* redefine semantic meaning
* redefine canonical meaning

Framework governance remains external and authoritative.

Prevent:

* semantic drift
* governance drift
* cross-layer contamination
* framework/tenant authority confusion

---

# STEP 1 — LOAD MASTER OPERATIONAL SOURCE

Required source:

```text id="yjqz5m"
PRJ-BLUEPRINT-MASTER-DOC.md
```

Treat MASTER as:

```text"
tenant operational source of truth
```

Generate Blueprint layers ONLY from validated tenant operational logic.

Do NOT invent unsupported business complexity.

---

# STEP 2 — GENERATE DOMAIN BLUEPRINT LAYER

Generate specialized Blueprint documents inside:

```text id="hm1gyh"
02-INSTANCES — Projects\[project_name]\02-BLP
```

Generate ONLY operationally justified Blueprint domains.

Examples:

* Governance Blueprints
* Collaboration Blueprints
* Security Blueprints
* Compliance Blueprints
* Operational Workflow Blueprints

Do NOT force unnecessary enterprise complexity.

---

# BLUEPRINT RULES

Blueprints must:

* follow ARC rules
* preserve semantic consistency
* preserve naming conventions
* preserve ontology boundaries
* preserve authority hierarchy
* remain tenant-scoped
* remain operationally realistic

Blueprints must NEVER:

* redefine framework governance
* redefine semantic authority
* generate MTX automatically
* generate AUT automatically
* create deployment logic
* act as runtime execution input

---

# REQUIRED OUTPUTS

Generate tenant-scoped Blueprint files derived from MASTER logic.

Examples may include:

```text id="x6q5ow"
BLP-GOV-001
BLP-OPS-001
BLP-SEC-001
BLP-COMP-001
```

Only generate files justified by tenant operational requirements.

---

# STOP-GATE RULE

After Blueprint generation:

STOP.

Do NOT continue automatically.

Output:

```text id="jlwmhq"
BLUEPRINT GENERATION COMPLETE
DOMAIN BLP GENERATED
```

Then ask:

```text
Are you ready for:
02-VALIDATION — Blueprint Validation Prompt ?
```

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT generate MTX yet
* Do NOT generate AUT yet
* Do NOT skip validation phase

Core principle:

```text id="sjlwmr"
ARC governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

Important principle:

```text id="5ig3n5"
redundancy != inconsistency
```

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

```text
PRJ-BLUEPRINT-MASTER-DOC
→ DOMAIN BLUEPRINT LAYER
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
