# ARC-DES-001 — Architecture Development Layer

## SME Logistics Office Tenant — Operational Expansion Document

---

# 1. Objective

Develop the conceptual architecture one level deeper.

This document expands the base company structure and prepares the next layers:

- departments
- groups
- users
- shared mailboxes
- roles
- naming logic
- automation-ready structure

This document is designed to be used later by Gemini / IDE / PowerShell workflows as a planning source.

---

# 2. Design Philosophy

The tenant is not modeled as a pure technical lab.

It is modeled as a small / medium logistics office company.

The tenant must represent:

- real departments
- real responsibilities
- realistic communication flows
- scalable Microsoft 365 structure
- clear identity between collaboration, operations and administration

---

# 3. Core Conceptual Layers

## Layer 1 — Identity Layer

Represents people and digital identities.

Includes:

- users
- usernames
- display names
- departments
- admin roles
- permissions

Purpose:

- define who exists
- define who belongs where
- define who can access what

---

## Layer 2 — Collaboration Layer

Represents teamwork structures.

Includes:

- Microsoft 365 Groups
- Teams
- SharePoint-connected workspaces
- internal department collaboration

Purpose:

- internal communication
- shared files
- shared planning
- department membership logic

---

## Layer 3 — Service Layer

Represents operational communication channels.

Includes:

- shared mailboxes
- departmental inboxes
- role-based service addresses
- ticket-like operational mail flows

Purpose:

- receive work
- process requests
- centralize communication
- create operational traceability

---

## Layer 4 — Governance Layer

Represents organizational control.

Includes:

- naming conventions
- folder taxonomy
- category taxonomy
- permissions review
- ownership rules
- lifecycle logic

Purpose:

- maintain order
- avoid chaos
- ensure consistency
- prepare growth

---

# 4. Minimum Department Architecture

## DEPT-Operations

### Business Function

Daily logistics execution.

### Typical Scope

- order flow
- warehouse coordination
- pickups
- deliveries
- incidents
- transport follow-up

### Microsoft 365 Representation

- Operations Team
- operations@ shared mailbox
- Operations SharePoint site
- operational folders / categories

---

## DEPT-Support

### Business Function

Client-facing support and request handling.

### Typical Scope

- client questions
- complaints
- delivery problems
- case follow-up
- escalations

### Microsoft 365 Representation

- Support Team
- support@ shared mailbox
- support workflow folders
- status and priority tags

---

## DEPT-Sales

### Business Function

Commercial communication and business growth.

### Typical Scope

- leads
- quotes
- follow-up
- pipeline
- commercial contacts

### Microsoft 365 Representation

- Sales Team
- sales@ shared mailbox
- quote / lead folder structure

---

## DEPT-Finance

### Business Function

Billing and financial administration.

### Typical Scope

- invoices
- supplier payments
- customer billing
- financial follow-up
- subscriptions / costs

### Microsoft 365 Representation

- Finance Team
- finance@ shared mailbox
- billing / invoices / archive structure

---

## DEPT-HR

### Business Function

People administration.

### Typical Scope

- onboarding
- contracts
- absences
- hiring support
- employee lifecycle

### Microsoft 365 Representation

- HR Team
- hr@ shared mailbox
- employee documentation structures

---

## DEPT-IT

### Business Function

Internal technical support and systems continuity.

### Typical Scope

- internal requests
- password issues
- access issues
- device / environment support
- M365-related support

### Microsoft 365 Representation

- IT Team
- it@ shared mailbox
- IT intake structure
- internal ticket-like folders and tags

---

## DEPT-Admin

### Business Function

Tenant administration and operational governance.

### Typical Scope

- users
- licenses
- Teams / Groups
- shared mailbox administration
- naming / structure / permissions

### Microsoft 365 Representation

- Admin Group
- admin@ shared mailbox
- admin coordination logic
- governance decisions and change handling

---

## DEPT-Warehouse

### Business Function

Physical stock management and freight handling.

### Typical Scope

- stock control
- freight loading
- picking / packing
- receiver management
- inventory audit

### Microsoft 365 Representation

- Warehouse Team
- no shared mailbox (direct communication)
- Warehouse SharePoint library

---

## DEPT-Management

### Business Function

Executive leadership and company strategy.

### Typical Scope

- executive decisions
- company strategy
- financial approval
- legal / contracts

### Microsoft 365 Representation

- no public team
- no shared mailbox
- Private Management SharePoint site

---

# 5. Role Hierarchy

## Executive / Governance

### Global Administrator

Top technical authority of the tenant.

Main role:

- oversight
- critical control
- escalations
- final approval
- governance supervision

This is not daily support.

This is strategic and critical control.

---

## Department Leads

Each department should conceptually have a lead or coordinator.

Examples:

- Operations Coordinator
- Support Coordinator
- Finance Lead
- HR Lead
- IT Lead
- Admin Lead

In a small company, one person may combine several roles.

---

## Specialists / Agents

Operational users inside departments.

Examples:

- OPS-Agent
- SUPPORT-Agent
- SALES-Rep
- FINANCE-Analyst
- HR-Specialist
- DEV-Engineer
- ADMIN-Users
- ADMIN-License
- ADMIN-Teams

---

# 6. Naming Standard — Base Rules

## 6.1 Department Prefixes

```
DEPT-Operations
DEPT-Warehouse
DEPT-Support
DEPT-Sales
DEPT-Finance
DEPT-HR
DEPT-IT
DEPT-Admin
DEPT-Management
```

---

## 6.2 User Display Names

```
OPS-Karina Mosqueira
SUPPORT-Anna Smith
SALES-Chris Walker
FINANCE-Eva Morgan
HR-Nina Brooks
IT-Pablo Novoa
ADMIN-Federico Mosqueira
MGMT-Lucas Bennett
```

Format:

```
PREFIX-FirstName LastName
```

---

## 6.3 Shared Mailboxes

```
operations@
support@
sales@
finance@
hr@
it@
admin@
billing@
info@
```

Rule:

- short
- functional
- no "shared" in the address
- no "team" in the address

---

## 6.4 Group Names

```
Operations Team
Warehouse Team
Support Team
Sales Team
Finance Team
HR Team
IT Team
Admin Group
```

Rule:

- use Team when collaborative team
- use Group when non-Team collaborative structure
- keep human-readable names

---

# 7. Shared Mailbox Conceptual Model

A shared mailbox is not the same as a group.

## Group

Used for:

- collaboration
- files
- Planner
- SharePoint
- internal teamwork

## Shared Mailbox

Used for:

- incoming work
- outgoing departmental mail
- operational communication
- service handling
- shared inbox workflow

---

# 8. Shared Mailbox Minimum Architecture

## support@

External operational inbox.

Suggested structure:

```
00-INBOX
01-REQUESTS
02-ISSUES
03-WAITING CLIENT
04-RESOLVED
99-ARCHIVE
```

---

## it@

Internal operational inbox.

Suggested structure:

```
00-INBOX
01-NEW
02-IN PROGRESS
03-WAITING USER
04-WAITING VENDOR
05-RESOLVED
99-ARCHIVE
```

---

## finance@

Administrative financial inbox.

Suggested structure:

```
00-INBOX
01-INVOICES IN
02-INVOICES OUT
03-PAYMENTS
04-WAITING
99-ARCHIVE
```

---

## admin@

Administrative control inbox.

Suggested structure:

```
00-INBOX
01-USERS
02-LICENSES
03-TEAMS-GROUPS
04-PERMISSIONS
05-WAITING
99-ARCHIVE
```

---

# 9. Tag / Category Taxonomy

Categories should represent metadata, not storage.

## Priority

```
PRI-HIGH
PRI-MEDIUM
PRI-LOW
```

## Status

```
STAT-OPEN
STAT-INPROGRESS
STAT-WAITING
STAT-CLOSED
```

## Department Routing

```
DEPT-Operations
DEPT-Warehouse
DEPT-Support
DEPT-Sales
DEPT-Finance
DEPT-HR
DEPT-IT
DEPT-Admin
DEPT-Management
```

Rule:

- folders = where work sits
- tags = what state work is in

---

# 10. Minimum Ownership Model

Each shared mailbox must have:

## Full Access

Users who can operate the mailbox.

## Send As

Users who can communicate as the department.

## Mailbox Owner (conceptual)

Lead responsible for process quality.

Example:

### support@

- mailbox owner: Support Lead
- agents: support staff
- global admin: optional oversight

### admin@

- mailbox owner: Global Admin / Admin Lead
- members: admin specialists

---

# 11. Minimum Governance Rules

## Naming

All names must follow standard format.

## Ownership

Every mailbox and group must have at least one owner.

## Scope

Each mailbox must serve one clear purpose.

## Separation

Do not mix:

- admin controls
- client support
- collaboration groups
- shared service inboxes

## Review

Permissions must be reviewed periodically.

---

# 12. Practical SME Logic

This company is small / medium.

That means:

- one user may wear multiple hats
- some departments may have only 1–2 users
- the same licensed user may administratively access many mailboxes
- structure still needs to be separated conceptually

This is realistic.

---

# 13. Automation Readiness

This architecture is intentionally prepared for automation.

Next automation layers can generate:

- users
- display names
- UPNs
- groups
- memberships
- shared mailboxes
- mailbox permissions
- Send As permissions
- aliases
- base folders
- governance notes

---

# 14. Next Documents To Generate

After this document, the logical sequence is:

## BLP-TMP-002

Department matrix

## BLP-TMP-003

User matrix

## BLP-TMP-004

Group matrix

## BLP-TMP-005

Shared mailbox matrix

## BLP-TMP-006

Permission matrix

## ARC-STD-007

Naming convention standard

## AUT-DOC-008

Automation script blueprint

---

# 15. Final Concept

This tenant should represent an SME logistics office where:

- each department has a clear role
- each user has a structured identity
- collaboration and service are separated
- governance supports growth
- automation can build the environment reliably

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map