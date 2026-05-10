# ARC-STD-007a — Naming Convention Standard Guide (Usage Guide)

### 🔵 LAYER DECLARATION
- **PRIMARY LAYER:** LAYER 1 — AI Semantic Navigation Layer
- **SECONDARY LAYER:** LAYER 4 — Tenant Operational Execution
- **ONTOLOGY OWNER:** `@SYS` / `@ARC`
- **SCOPE:** Cognitive Routing & Operational Naming Standard

---

# 1. Purpose

Define one universal naming system for folders, users, groups, files, scripts, and Microsoft 365 objects.

### Semantic Routing Role (LAYER 1)
This standard allows AI agents to navigate the framework using deterministic logic (CODE-TYPE-001). It prevents "hallucinations" by providing a strict ontology for document and object identification.

### Execution Role (LAYER 4)
This standard defines the final naming of deployable objects in the Microsoft 365 tenant, ensuring operational professionality.

Goals:
- clear
- sortable
- searchable
- professional
- automation-friendly
- scalable

---

## Core Format

CAT-SUB-001 — Human Readable Name

Examples:

BLP-ARC-STD-007 — Naming Convention Standard
OPS-GRP-003 — Warehouse Team
PRI-HIG-001 — Urgent Queue

---

## Structure Meaning

### 1. Category Prefix

Main area or domain.

Examples:

BLP = Blueprint Templates
OPS = Operations
USR = Users
GRP = Groups
PRI = Priority
ARC = Architecture
DOC = Document

---

### 2. Subtype Prefix

Object type inside category.

Examples:

DOC = Document
GRP = Group
MBX = Mailbox
HIG = High
MED = Medium
LOW = Low
DES = Design
STR = Strategy

---

### 3. Numeric Order

Use 3 digits:

001
002
003

Reason:

Correct visual sorting.

Good:

001
002
010
011

Bad:

1
10
2

Technique name:

Zero Padding

---

## Separator Rules

### Hyphen -

Use inside technical code.

Examples:

OPS-GRP-001
BLP-ARC-STD-007

Reason:

- script friendly
- URL friendly
- PowerShell friendly
- universal standard

---

### Long Dash —

Use between code and readable title.

Example:

BLP-ARC-STD-007 — Naming Convention Standard

Reason:

Separates:

- machine code part
- human title part

Improves readability.

---

## Usage by Environment

### Folders / Documents / SharePoint / OneDrive

Use full format:

CAT-SUB-001 — Name

### Users / Groups / Mailboxes

Use compact format:

OPS-GRP-001
FIN-MBX-002
USR-ADM-001

### Scripts / Code Files

Prefer:

create_users.ps1
set_group_permissions.ps1
tenant_sync.ps1

---

## Rules

- keep short
- keep consistent
- use English
- avoid random names
- one object = one purpose
- rename chaos gradually

---

## Final Principle

Left side = system logic
Right side = human clarity

Example:

ARC-DES-001 — Architecture Development Layer

This is the preferred naming standard.

---

## Naming Hierarchy

- **ARC-STD-007:** Base Standard
- **ARC-STD-007a:** Usage Guide (This document)
- **ARC-STD-007b:** Visual/Emoji Extension

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map
- ARC-STD-007 — Naming Convention Standard
- ARC-STD-007b — Naming Convention Emoji Guide