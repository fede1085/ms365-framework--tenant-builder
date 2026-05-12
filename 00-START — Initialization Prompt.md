# Initialize new tenant project: [project_name]

Use Agent Mode.

---

## Source Folders

Read framework governance and semantic rules from:

@00-SYSTEM — Semantic Control Layer
@00-CANONICAL — Structured Control Layer
@.agents\rules
@.agents\workflows
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates
@01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables

All framework sources are STRICT READ-ONLY.

Do NOT modify framework files.

---

## Core Model

Follow strictly:

ARCH → BLP → MTX → AUT

Definitions:

- ARCH = governance and architecture rules
- BLP = operational blueprint layer
- MTX = execution-ready tenant data
- AUT = deployment and automation layer

Additional orchestration flow:

DISCOVERY
→ PRJ-BLUEPRINT-MASTER-DOC
→ DOMAIN BLP
→ VALIDATION
→ MTX
→ VALIDATION
→ AUT

---

## Ontology Separation

Maintain strict ontology boundaries between:

1. Framework ontology
   - system governance
   - semantic control
   - canonical enforcement
   - architecture standards

2. Tenant ontology
   - tenant operational structure
   - tenant business logic
   - tenant users/groups/mailboxes
   - tenant operational workflows

Framework ontology is READ-ONLY during tenant generation.

Tenant generation must NEVER modify framework governance.

---

## STEP 1 — Interactive Discovery

Execute interactive business discovery workflow.

### Goal

Define:

- company structure
- departments
- operational workflows
- collaboration logic
- user roles
- users
- groups
- shared mailboxes
- permissions
- ownership
- escalation paths
- licenses
- governance needs
- security posture

---

## Discovery Rules

- Ask step-by-step
- Do NOT skip phases
- Prioritize operational realism
- Do NOT infer enterprise complexity unless required
- Do NOT generate CSV yet
- Do NOT generate AUT
- Do NOT run scripts
- Do NOT deploy anything

Focus on:

how the organization actually operates

NOT only technical structure.

---

## STEP 2 — Generate Project Structure

Create:

02-INSTANCES — Projects\[project_name]\

   ├── 01-DISCOVERY
   ├── 02-BLP
   ├── 03-MTX
   └── 04-AUT

---

## STEP 3 — Generate MASTER Operational Blueprint

Generate:

PRJ-BLUEPRINT-MASTER-DOC.md

inside:

02-INSTANCES — Projects\[project_name]\02-BLP

---

## MASTER Document Purpose

This document becomes:

the operational source of truth
for the tenant instance.

The MASTER document must consolidate:

- organizational structure
- departments
- operational relationships
- user roles
- collaboration patterns
- Teams operational behavior
- mailbox ownership
- escalation logic
- lifecycle logic
- governance requirements
- security posture
- operational handoffs

---

## MASTER Rules

- The MASTER document belongs to tenant ontology only
- Do NOT modify framework architecture
- Do NOT generate MTX yet
- Do NOT generate AUT yet
- Do NOT create deployment logic
- Do NOT continue automatically

Stop after MASTER generation.

Wait for validation approval.

---

## STEP 4 — Generate Domain Blueprint Layer

ONLY after approval.

Generate specialized Blueprint documents from:

PRJ-BLUEPRINT-MASTER-DOC

Examples:

- Governance Blueprints
- Collaboration Blueprints
- Security Blueprints
- Compliance Blueprints
- Operational Workflow Blueprints

Generate inside:

02-INSTANCES — Projects\[project_name]\02-BLP

---

## Blueprint Rules

Blueprints must:

- follow ARCH rules
- preserve semantic consistency
- preserve naming conventions
- preserve ontology boundaries
- preserve authority hierarchy
- remain operationally realistic
- remain reusable

Do NOT generate MTX yet.

Stop after Blueprint generation.

Wait for validation approval.

---

## STEP 5 — Validation Phase

Audit generated Blueprint layer.

Validation targets:

- semantic consistency
- naming consistency
- governance consistency
- operational realism
- authority integrity
- permission logic
- escalation logic
- collaboration logic
- ontology boundaries

Detect:

- naming drift
- authority conflicts
- governance gaps
- unsupported assumptions
- permission conflicts
- semantic contradictions
- operational inconsistencies

Generate validation report only.

READ-ONLY mode.

Do NOT auto-correct unless explicitly requested.

---

## STEP 6 — Generate Matrix Layer

ONLY after Blueprint validation approval.

Generate execution-ready CSV files inside:

02-INSTANCES — Projects\[project_name]\03-MTX

Required files:

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

## Matrix Rules

- Use roles → convert into operational data
- Generate realistic naming
- Apply naming from ARCH
- Apply governance from BLP
- Apply permissions from BLP
- Apply ownership logic from MASTER

MTX defines operational data only.

No deployment execution yet.

---

## STEP 7 — Stop Before Deployment

When ready, confirm:

PROJECT READY — BLP and MTX generated

Then ask:

Do you want to deploy this project?

---

## Deployment Behavior

If user says YES:

Output ONLY:

.\Run-Project.ps1 -ProjectName "[project_name]"

DO NOT:

- run scripts
- simulate deployment
- modify tenant
- execute PowerShell
- generate fake execution logs

---

## Global Rules

- Framework is READ-ONLY
- Do NOT modify framework files
- Do NOT skip validation phases
- Do NOT skip MTX layer
- Do NOT place tenant Matrix inside framework
- Architecture governs Blueprint
- Blueprint informs Matrix
- Matrix feeds Automation
- Automation must never redefine architecture

---

## Final Objective

Business
→ Operational Blueprint
→ Governance Validation
→ Matrix Generation
→ Deployment Preparation

while preserving:

- semantic governance
- ontology integrity
- operational realism
- deterministic consistency