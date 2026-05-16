---
description: Generates project-specific Microsoft 365 tenant blueprint documents from PRJ-BLUEPRINT-MASTER-DOC.md and the CORE framework templates.
---

# WKFW-002 — Microsoft 365 Tenant Automation Blueprint

## Purpose

Interactive workflow for structured Microsoft 365 tenant generation for SMEs.

Transforms:

Business → Blueprint → Matrix → Automation

Core model:

SYS → CANONICAL → ARC → BLP → MTX → AUT → INSTANCE/TENANT

- SYS defines semantic meta-framework control
- CANONICAL defines schemas, rules, routing, and graph constraints
- ARC defines tenant architecture doctrine and rules
- BLP defines reusable tenant blueprint/template structure
- MTX defines execution-ready data
- AUT executes validated MTX only

The workflow MUST preserve ontology separation and framework isolation.
Root prompts are workflow entrypoints, not authority doctrine.

---

# Execution State Model

Allowed states:

- READ_ONLY → inspection and validation only
- PLAN → discovery and planning
- GENERATE → BLP and MTX generation
- EXECUTE → external execution only

Default state:

READ_ONLY

Execution must remain HUMAN-SUPERVISED.

The workflow must NEVER:

- auto-execute deployment
- auto-escalate execution state
- modify framework governance
- redefine semantic meaning

---

# Official Prompt Workflow

```text
00-START — Initialization Prompt
    ↓
01-GENERATION — Blueprint Generation Prompt
    ↓
02-VALIDATION — Blueprint Validation Prompt
    ↓
03-MTX — Matrix Generation Prompt
    ↓
04-AUT-DEPLOYMENT — Controlled Execution Prompt
```

Each phase must STOP after completion.

Automatic progression is forbidden.

---

# Workflow Scope

## 00-START
Generates:

- project structure
- business discovery
- PRJ-BLUEPRINT-MASTER-DOC.md

---

## 01-GENERATION
Generates:

- DOMAIN BLP documents
- governance-aligned Blueprint structures

---

## 02-VALIDATION
Validates:

- Blueprint consistency
- governance integrity
- ontology boundaries
- naming consistency
- operational realism

---

## 03-MTX
Generates:

- MTX-USERS.csv
- MTX-GROUPS.csv
- MTX-MAILBOXES.csv
- MTX-PERMISSIONS.csv

Optional:

- MTX-LICENSES.csv
- MTX-CHANNELS.csv
- MTX-OWNERSHIP.csv
- MTX-LIFECYCLE.csv

---

## 04-AUT-DEPLOYMENT
Handles:

- deployment readiness
- AUT preparation
- controlled deployment handoff

Deployment must remain HUMAN-SUPERVISED.

---

# Ontology Separation

## Framework Ontology

Includes:

- SYS
- CAN
- ARCH
- semantic governance
- canonical enforcement
- framework doctrine

Framework sources are STRICT READ-ONLY.
CANONICAL sources constrain this workflow but do not become tenant implementation content.

---

## Tenant Ontology

Includes:

- PRJ files
- BLP documents
- MTX files
- users
- groups
- mailboxes
- permissions
- operational workflows

Represents tenant operational state only.

---

# Critical Boundary Rules

The workflow must NEVER:

- modify SYS
- modify CAN
- modify ARCH
- redefine governance
- redefine semantic meaning
- redefine canonical meaning
- inject tenant logic into framework doctrine

Prevent:

- semantic drift
- governance drift
- cross-layer contamination
- framework/tenant authority confusion

---

# Matrix Output Location

```text
02-INSTANCES — Projects/<PROJECT_NAME>/03-MTX — Data Matrices/
```

Required MTX files:

```text
MTX-USERS.csv
MTX-GROUPS.csv
MTX-MAILBOXES.csv
MTX-PERMISSIONS.csv
```

---

# Matrix Rules

- use sequential IDs
- map Blueprint roles into operational rows
- preserve naming consistency
- preserve ownership consistency
- preserve operational realism
- preserve authority hierarchy

Example:

```text
ROLE-OPS-LEAD
→
ops.lead@<domain>
```

---

# Security Rules

- admin mailboxes → NO SendAs
- customer-facing mailboxes → SendAs allowed
- protected users → no automatic assignment

Do NOT:

- execute scripts
- simulate deployment
- generate fake logs

---

# Interactive Flow

1. Business discovery
2. Departments
3. Users
4. Groups
5. Mailboxes
6. Governance
7. Validation
8. MTX generation
9. AUT preparation

---

# Validation Rules

Validate:

- naming consistency
- ownership consistency
- permission logic
- operational realism
- ontology boundaries

Detect:

- duplicates
- orphan ownership
- governance conflicts
- unsupported assumptions
- cross-layer contamination

If validation fails:

STOP and request correction.

---

# Deployment Rules

Deployment belongs ONLY to:

```text
04-AUT-DEPLOYMENT — Controlled Execution Prompt
```

Approved command:

```powershell
.\Run-Project.ps1 -ProjectName "<PROJECT_NAME>"
```

Do NOT:

- execute automatically
- simulate deployment
- bypass validation
- invoke Deploy-Tenant.ps1 directly
- use BLP as direct runtime input

---

# Final Principles

```text
ARCH governs BLP
BLP informs MTX
MTX feeds AUT
AUT never redefines architecture
```

```text
redundancy != inconsistency
```

The tenant represents operational business reality.

The framework governs how that reality is structured safely.
