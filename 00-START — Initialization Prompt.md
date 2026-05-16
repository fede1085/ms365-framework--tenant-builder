# 00-START — Initialization Prompt

# Initialize new tenant project: [project_name]

Use Agent Mode.

This root prompt is a workflow entrypoint. It does not define authority doctrine; authority comes from SYS, CANONICAL, and the framework layers referenced below.

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

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

Read priority must follow:

```text
SYS → CANONICAL → ARC → BLP → MTX → AUT → INSTANCE/TENANT
```

---

# CORE MODEL

Follow strictly:

```text
SYS → CANONICAL → ARC → BLP → MTX → AUT
```

Current workflow scope:

```text
DISCOVERY
→ PRJ-BLUEPRINT-MASTER-DOC
```

This prompt handles ONLY:

* discovery
* project initialization
* master operational blueprint generation

Do not generate tenant content directly unless the user explicitly authorizes `GENERATE`.

It must NOT generate:

* DOMAIN BLP
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
* tenant operational structure
* business logic
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

# STEP 1 — INTERACTIVE DISCOVERY

Required execution state:

```text
PLAN
```

Execute interactive business discovery workflow.

Discovery goals:

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
* do NOT generate MTX
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

Run this step only after explicit GENERATE authorization.

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
* do NOT generate DOMAIN BLP
* do NOT generate MTX
* do NOT generate AUT
* stop after MASTER generation

---

# HANDOFF RULE

After MASTER generation:

STOP.

Output:

```text
DISCOVERY COMPLETE
PRJ-BLUEPRINT-MASTER-DOC GENERATED
```

Then ask:

```text
Are you ready for:
01-GENERATION — Blueprint Generation Prompt ?
```

Do NOT continue automatically.

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT skip phases
* Do NOT generate MTX yet
* Do NOT generate AUT yet

Core principle:

```text
ARC governs BLP
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
→ Discovery
→ PRJ-BLUEPRINT-MASTER-DOC
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
