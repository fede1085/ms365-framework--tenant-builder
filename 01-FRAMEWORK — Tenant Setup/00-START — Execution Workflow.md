# Execution Workflow - Tenant Automation Usage

## 1. Abstraction Layers

The framework uses a strict semantic abstraction model:
- **ARC (Architecture):** Conceptual baselines and governance standards.
- **BLP (Blueprint Templates):** Reusable, safe, generic schemas and matrices.
- **MTX (Data Matrices):** Real, instantiated project data (e.g., CSVs).
- **AUT (Automation Executables):** Scripts and execution logic.

---

## 2. Generate Project

* Talk to AI (Framework)
* Define company (interactive)
* AI generates:

```text
/02-INSTANCES — Projects/0X-PROJ — Name/
   ├── 01-ARC — Architecture/
   ├── 02-BLP — Blueprint Templates/
   ├── 03-MTX — Data Matrices/ (CSV files)
   └── 04-AUT — Automation Executables/
```

---

## 3. Review

* Check Matrix files inside `/03-MTX — Data Matrices/`:

  * MTX-USERS.csv
  * MTX-GROUPS.csv
  * MTX-MAILBOXES.csv
  * MTX-PERMISSIONS.csv

---

## 4. Deploy

Navigate to `/04-AUT — Automation Executables/` and run:

```powershell
.\Run-Project.ps1
```

---

## 5. Flow

```text
AI → generates MTX from BLP templates
Run-Project → selects project MTX
Deploy-Tenant → creates tenant objects
```

---

## Notes

* Default = DRY-RUN (safe)
* Confirm before EXECUTE
* Do NOT run Deploy-Tenant directly
* All data comes from /03-MTX — Data Matrices

---

## Rule

```text
ARC = Core Logic & Rules
BLP = Reusable Templates
MTX = Real Instance Data
AUT = Execution Scripts
```
