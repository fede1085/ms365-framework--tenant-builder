# 04-DEPLOYMENT — Automation & Execution Prompt

# Prepare controlled tenant deployment: [project_name]

Use Agent Mode.

This root prompt is a workflow entrypoint for AUT preparation. It does not define authority doctrine.

---

# EXECUTION STATE

Current execution state:

```text
PLAN
````

Allowed operational states:

```text id="x0h7pl"
READ_ONLY
PLAN
GENERATE
EXECUTE
```

Execution-state progression must remain HUMAN-SUPERVISED.

The system must NEVER escalate execution state automatically.

Forbidden behaviors:

* modifying framework files
* automatic deployment execution
* automatic PowerShell execution
* tenant modification without approval
* fake deployment logs
* automatic execution escalation

---

# SOURCE FOLDERS

Read framework governance and automation rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables

Read MTX operational data from:

```text
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

Framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

---

# CORE MODEL

Follow strictly:

```text id="o2z9cp"
SYS → CANONICAL → ARC → BLP → MTX → AUT
```

Current workflow scope:

```text id="xjlwm3"
MTX
→ AUT
→ CONTROLLED DEPLOYMENT
```

This prompt handles ONLY:

* AUT preparation
* deployment readiness verification
* controlled execution preparation
* deployment handoff

It must NOT:

* redesign tenant architecture
* redefine governance
* bypass validation phases
* execute deployment automatically

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
* validated MTX files
* deployment preparation
* tenant operational execution scope

Represents tenant operational state only.

---

# IMPORTANT ONTOLOGY RULE

Deployment preparation must NEVER:

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

AUT consumes validated MTX data only.
BLP is not execution input.

---

# STEP 1 — LOAD VALIDATED MTX LAYER

Load MTX files from:

```text id="y4m7vq"
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

Required files:

```text id="v7r4ml"
MTX-USERS.csv
MTX-GROUPS.csv
MTX-MAILBOXES.csv
MTX-PERMISSIONS.csv
```

Treat MTX as:

```text id="m0u4rx"
validated execution-ready operational data
```

---

# STEP 2 — VERIFY DEPLOYMENT READINESS

Verify:

* MTX integrity
* naming consistency
* ownership consistency
* permission consistency
* tenant targeting readiness
* execution readiness
* framework isolation
* ontology boundaries

Detect:

* unresolved validation conflicts
* orphan permissions
* missing ownership
* unsafe deployment assumptions
* framework contamination
* unsupported execution scope

Do NOT auto-correct unless explicitly requested.

---

# STEP 3 — CONTROLLED DEPLOYMENT PREPARATION

Prepare controlled deployment only.

Deployment must:

* remain HUMAN-SUPERVISED
* require explicit approval
* require explicit tenant targeting
* enforce DryRun first
* enforce protected-object checks
* preserve framework isolation
* avoid destructive execution by default

Do NOT:

* auto-connect to Microsoft Graph
* auto-connect to Exchange Online
* auto-run scripts
* auto-confirm execution
* assign licenses unless license assignment is explicitly implemented and approved
* treat BLP as execution input
* output non-dry-run execution before DryRun passes

---

# TENANT TARGETING REQUIREMENT

Before deployment preparation, require:

* TenantId
* TenantDomain
* EnvironmentName
* ProjectName

Required confirmation format:

```text id="u4l8mx"
Target tenant:
TenantId:
TenantDomain:
Environment:
Project:

Type YES to continue:
```

Deployment must STOP unless explicitly confirmed.

---

# APPROVED DRYRUN COMMAND

For first deployment readiness approval, output ONLY the DryRun path:

```powershell
.\Run-Project.ps1 -ProjectName "[project_name]"
```

Do NOT:

* execute automatically
* simulate execution
* generate fake logs
* invoke Deploy-Tenant.ps1 directly

`Run-Project.ps1` remains the controlled framework entry point. Treat this command as DryRun/readiness unless a separate explicit EXECUTE approval is given and the framework script contract supports non-dry-run execution.

Before any non-dry-run execution handoff:

* DryRun must complete cleanly
* protected-object checks must pass
* tenant targeting must be confirmed
* license assignment must be explicitly implemented and approved

---

# STOP-GATE RULE

After deployment preparation:

STOP.

Wait for explicit human execution approval.

Automatic continuation is forbidden.

---

# GLOBAL RULES

* Framework is STRICT READ-ONLY
* Do NOT modify framework files
* Do NOT bypass validation
* Do NOT execute automatically
* Do NOT redefine governance

Core principle:

```text id="f9u0mk"
ARC governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

Important principle:

```text id="r6p7ah"
redundancy != inconsistency
```

Do NOT simplify intentional governance redundancy.

---

# FINAL OBJECTIVE

```text id="d3m5vw"
VALIDATED MTX LAYER
→ CONTROLLED AUT PREPARATION
→ HUMAN-SUPERVISED DEPLOYMENT
```

while preserving:

* semantic governance
* ontology integrity
* operational realism
* deterministic consistency
* authority hierarchy
* framework isolation
* controlled deployment safety
