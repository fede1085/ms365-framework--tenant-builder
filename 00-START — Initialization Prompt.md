# Initialize new tenant project: [project_name]

Use Agent Mode.

---

## Source Folders

Read framework rules from:

@00-SYSTEM — Semantic Control Layer
@.agents\rules  
@.agents\workflows  
@01-FRAMEWORK — Tenant Setup\01-ARC — Architecture  
@01-FRAMEWORK — Tenant Setup\02-BLP — Blueprint Templates  
@01-FRAMEWORK — Tenant Setup\04-AUT — Automation Executables  

---

## Core Model

Follow strictly:

```text
ARCH → BLP → MTX → AUT
```

- ARCH = rules  
- BLP = project blueprint  
- MTX = project CSV data  
- AUT = execution scripts  

---

## STEP 1 — Interactive Discovery

Execute interactive workflow.

### Goal

- define company  
- define departments  
- define roles  
- define users  
- define groups  
- define shared mailboxes  
- define permissions  
- define licenses  

### Rules

- Ask step by step  
- Do NOT skip phases  
- Do NOT generate CSV yet  
- Do NOT run scripts  

---

## STEP 2 — Generate Project Folder

Create:

```text
02-INSTANCES — Projects\[project_name]\
   ├── 01-ARC — Architecture
   ├── 02-BLP — Blueprint Templates
   ├── 03-MTX — Data Matrices
   └── 04-AUT — Automation Executables
```

---

## STEP 3 — Generate Blueprint

Generate project-ready BLP documents inside:

```text
02-INSTANCES — Projects\[project_name]\02-BLP — Blueprint Templates
```

Blueprint must:

- follow ARCH rules  
- define structure only (NO real data)  
- be reusable  

---

## STEP 4 — Generate Matrix

Generate execution-ready CSV files inside:

```text
02-INSTANCES — Projects\[project_name]\03-MTX — Data Matrices
```

Required files:

```text
MTX-USERS.csv
MTX-GROUPS.csv
MTX-MAILBOXES.csv
MTX-PERMISSIONS.csv
```

### Rules

- Use roles → convert to real data  
- Generate realistic emails using <domain>  
- Apply naming from ARCH  
- Apply permissions from BLP  

---

## STEP 5 — Stop Before Deployment

When ready, confirm:

```text
PROJECT READY — BLP and MTX generated
```

Then ask:

```text
Do you want to deploy this project?
```

---

## Deployment Behavior

If user says YES:

Output ONLY:

```powershell
.\Run-Project.ps1 -ProjectName "[project_name]"
```

DO NOT:

- run scripts  
- simulate execution  
- modify tenant  

---

## Global Rules

- Do NOT create real tenant changes  
- Do NOT run PowerShell  
- Do NOT skip MTX  
- Do NOT place Matrix inside framework  
- Always use Architecture as source of truth  
- Blueprint defines structure  
- Matrix defines data  
- Automation executes  

---

## Final Objective

```text
Business → Blueprint → Matrix → Ready for Deployment
```