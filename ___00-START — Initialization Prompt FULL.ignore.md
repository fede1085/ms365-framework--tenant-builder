````markdown
# Initialize new tenant project: [project_name]

Use Agent Mode.

---

# EXECUTION STATE

Current execution state:

```text
READ_ONLY
````

Allowed operational states:

```text
READ_ONLY
PLAN
GENERATE
EXECUTE
```

Execution-state progression must remain HUMAN-SUPERVISED.

The system must NEVER escalate execution state automatically.

Forbidden in READ_ONLY:

* modifying framework files
* deployment execution
* PowerShell execution
* tenant modification
* automatic execution progression

---

# SOURCE FOLDERS

Read framework governance and semantic rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@.agents\rules
@.agents\workflows
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates
@01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

Read priority must follow:

```text
SYS → CAN → ARC → BLP → MTX → AUT
```

As defined in:

```text
SYS-GOV-001 — Read First
```

---

# CORE MODEL

Follow strictly:

```text
ARCH → BLP → MTX → AUT
```

Definitions:

* ARCH = governance and architecture doctrine
* BLP = operational blueprint layer
* MTX = execution-ready operational data
* AUT = deployment and automation layer

Approved workflow:

```text
DISCOVERY
→ PRJ-BLUEPRINT-MASTER-DOC
→ DOMAIN BLP
→ VALIDATION
→ MTX
→ VALIDATION
→ AUT
```

Each phase requires explicit approval before continuation.

---

# ONTOLOGY SEPARATION

Maintain strict ontology boundaries between:

## META-FRAMEWORK ONTOLOGY

Includes:

* SYS
* CAN
* ARCH
* semantic governance
* canonical enforcement
* routing logic
* framework doctrine

Represents reusable framework authority.

---

## TENANT INSTANCE ONTOLOGY

Includes:

* PRJ files
* tenant operational structure
* generated BLP documents
* MTX files
* users
* groups
* mailboxes
* permissions
* operational workflows

Represents tenant operational state only.

---

# IMPORTANT ONTOLOGY RULE

Tenant generation must NEVER:

* modify SYS
* modify CAN
* modify ARCH
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

# SEMANTIC / CANONICAL GOVERNANCE

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

Canonical files must NEVER invent governance or ontology not declared in semantic source files.

---

# STEP 1 — INTERACTIVE DISCOVERY

Required execution state:

```text
PLAN
```

Execute interactive business discovery workflow.

Discovery goal:

* company structure
* departments
* operational workflows
* collaboration logic
* user roles
* ownership
* permissions
* escalation paths
* licenses
* governance needs
* security posture

Discovery rules:

* ask step-by-step
* prioritize operational realism
* do NOT infer enterprise complexity unless required
* do NOT generate MTX yet
* do NOT generate AUT
* do NOT deploy

Focus on:

```text
how the organization actually operates
```

---

# STEP 2 — GENERATE PROJECT STRUCTURE

Required execution state:

```text
GENERATE
```

Create:

```text
02-INSTANCES — Projects\[project_name]\
    ├── 01-DISCOVERY — Discovery
    ├── 02-BLP — Blueprint Templates
    ├── 03-MTX — Data Matrices
    └── 04-AUT — Automation Executables
```

Do NOT generate framework authority folders inside tenant projects.

Forbidden inside tenant instances:

```text
00-SYSTEM
00-CANONICAL
01-ARC
```

---

# STEP 3 — GENERATE MASTER OPERATIONAL BLUEPRINT

Generate:

```text
PRJ-BLUEPRINT-MASTER-DOC.md
```

inside:

```text
02-INSTANCES — Projects\[project_name]\02-BLP
```

Purpose:

```text
tenant operational source of truth
```

This document consolidates:

* organizational structure
* departments
* operational relationships
* collaboration patterns
* ownership logic
* lifecycle logic
* governance requirements
* security posture

Rules:

* MASTER belongs to tenant ontology only
* do NOT generate MTX yet
* do NOT generate AUT yet
* stop after MASTER generation

Wait for explicit continuation approval.

---

# STEP 4 — GENERATE DOMAIN BLUEPRINT LAYER

Required execution state:

```text
GENERATE
```

ONLY after approval.

Generate specialized Blueprint documents from:

```text
PRJ-BLUEPRINT-MASTER-DOC
```

Examples:

* Governance
* Collaboration
* Security
* Compliance
* Operational Workflows

Generate inside:

```text
02-INSTANCES — Projects\[project_name]\02-BLP
```

Blueprints must:

* follow ARCH rules
* preserve semantic consistency
* preserve naming conventions
* preserve ontology boundaries
* remain tenant-scoped

Blueprints must NEVER:

* redefine framework governance
* redefine semantic authority
* generate MTX automatically
* generate AUT automatically

Stop after Blueprint generation.

---

# STEP 5 — VALIDATION PHASE

Required execution state:

```text
READ_ONLY
```

Audit Blueprint layer.

Validate:

* semantic consistency
* naming consistency
* governance consistency
* operational realism
* ontology boundaries
* authority integrity

Detect:

* semantic drift
* naming drift
* governance conflicts
* unsupported assumptions
* cross-layer contamination

Generate validation report only.

Do NOT auto-correct unless explicitly requested.

---

# STEP 6 — GENERATE MATRIX LAYER

Required execution state:

```text
GENERATE
```

ONLY after Blueprint validation approval.

Generate MTX files inside:

```text
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

Required:

* MTX-USERS.csv
* MTX-GROUPS.csv
* MTX-MAILBOXES.csv
* MTX-PERMISSIONS.csv

Optional:

* MTX-LICENSES.csv
* MTX-CHANNELS.csv
* MTX-OWNERSHIP.csv
* MTX-LIFECYCLE.csv

Rules:

* MTX operationalizes BLP logic
* apply naming from ARCH
* apply governance from BLP
* apply ownership from MASTER
* MTX defines operational data only
* MTX must NEVER redefine governance

No deployment execution yet.

---

# STEP 7 — EXECUTION HANDOFF

Required execution state:

```text
PLAN
```

When MTX generation completes, STOP.

Output:

```text
PROJECT READY — BLP and MTX generated
```

Then instruct the user to continue with:

```text
04-AUT-DEPLOYMENT — Controlled Execution Prompt
```

Do NOT execute deployment automatically.

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT skip validation phases
* Do NOT skip MTX layer
* Do NOT place tenant MTX inside framework folders

Core principle:

```text
ARCH governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

Important principle:

```text
redundancy != inconsistency
```

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

```text
Business
→ Operational Blueprint
→ Governance Validation
→ Matrix Generation
→ Controlled Deployment Preparation
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
* controlled execution safety