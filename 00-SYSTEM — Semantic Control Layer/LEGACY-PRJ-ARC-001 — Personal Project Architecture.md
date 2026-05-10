# PRJ-ARC-001 — Personal Project Architecture

## Objective

Define a clean and scalable local structure to manage:

- Architecture (rules)
- Blueprint (templates)
- Matrix (data)
- Automation (execution)
- Projects (instances)

This becomes your **tenant factory system**.

---

## Core Model

```text
ARCH → BLP → MTX → AUT
```

- ARCH = rules / standards
- BLP = reusable templates
- MTX = execution data (CSV)
- AUT = scripts (deployment)

---

## Folder Structure (FINAL)

```text
M365-Tenant-Forge/
│
├── .agents                         ← AI engine (rules + workflows)
│
├── 01-FRWK — Tenant Automatic Setup
│   ├── 001-DOCS — ARCHITECTURE
│   ├── 002-DOCS — BLUEPRINT
│   ├── 003-DOCS — MATRIX (templates only)
│   ├── 004-DOCS — AUTOMATION (scripts)
│   └── 007-DOCS — SYSTEM
│
├── 02-PRJ — Projects
│   └── PRJ-XXX
│       ├── 002-BLP
│       ├── 003-MTX
│       └── 099-LOGS
│
└── README.md
```

---

## Key Rule

```text
Framework = logic
Project = data
```

---

## Execution Flow

```text
1. AI → builds Blueprint
2. AI → generates MTX (CSV)
3. Run-Project.ps1 → selects project
4. Deploy-Tenant.ps1 → executes
```

---

## Daily Usage

- Design → ARCH / BLP
- Generate → MTX (AI)
- Execute → Run-Project
- Audit → compare tenant vs MTX

---

## Important

- NEVER mix MTX inside framework
- NEVER run Deploy directly
- ALWAYS use Run-Project