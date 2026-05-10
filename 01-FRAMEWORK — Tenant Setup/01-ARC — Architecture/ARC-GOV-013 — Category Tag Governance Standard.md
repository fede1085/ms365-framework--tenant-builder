# ARC-GOV-013 — Category Tag Governance Standard

## Purpose

Define a professional category / tag system for Outlook shared mailboxes, user mailboxes, task tracking, and operational communication.

The objective is fast visual recognition, filtering, ownership clarity, and workflow control.

---

# Core Rule

Use this format:

PREFIX-Value

Examples:

DEPT-IT
PRI-High
STAT-Open
TYPE-Request

Avoid random names.

Bad:
Urgent
Blue
Check Later
Important!!

Good:
PRI-High
STAT-Waiting Client
TYPE-Incident

---

# Master Prefix Library

## Department

DEPT-

Examples:

DEPT-Admin
DEPT-IT
DEPT-Finance
DEPT-HR
DEPT-Sales
DEPT-Support
DEPT-Operations
DEPT-Warehouse
DEPT-Management

---

## Priority

PRI-

Examples:

PRI-High
PRI-Medium
PRI-Low

---

## Status

STAT-

Examples:

STAT-Open
STAT-In Progress
STAT-Waiting Client
STAT-Waiting Internal
STAT-Resolved
STAT-Closed
STAT-Dispatched

---

## Type

TYPE-

Examples:

TYPE-Request
TYPE-Incident
TYPE-Question
TYPE-Billing
TYPE-Access
TYPE-Complaint
TYPE-Delivery

---

## Ownership

OWN-

Examples:

OWN-IT
OWN-Admin
OWN-Finance
OWN-Support
OWN-Sales
OWN-HR
OWN-Operations
OWN-Warehouse
OWN-Management

---

## Source

SRC-

Examples:

SRC-Email
SRC-Phone
SRC-Teams
SRC-Internal
SRC-Client

---

## SLA / Time

SLA-

Examples:

SLA-Today
SLA-24h
SLA-48h
SLA-ThisWeek

---

# Color Logic (Recommended)

Red       = High Priority
Orange    = Waiting / Attention
Yellow    = Medium Priority
Green     = Closed / Resolved
Blue      = In Progress
Purple    = Department
Gray      = Archived / Low Priority

---

# Example Shared Mailbox: Support@

Use:

DEPT-Support
PRI-High
STAT-Open
STAT-Waiting Client
TYPE-Incident
OWN-Support

---

# Example Shared Mailbox: Finance@

Use:

DEPT-Finance
PRI-Medium
STAT-Open
TYPE-Billing
TYPE-Invoice
OWN-Finance

---

# Governance Rules

*Note: Master governance rules and enforcement principles are centralized in ARC-SYS-000 — Architecture Control Map.*

1. Keep names short.
2. Always use prefix format.
3. One meaning per tag.
4. No duplicate concepts.
5. Review quarterly.
6. Keep language consistent.
7. Use searchable words.

---

# Scaling Model

SME:
10 to 20 categories

Medium company:
20 to 50 categories

Large operation:
50+ categories with governance owner

---

# AI Automation Use

AI can auto-tag emails by:

- sender
- keywords
- urgency
- department
- historical patterns

Examples:

invoice -> TYPE-Billing
error -> TYPE-Incident
urgent -> PRI-High

---

# Final Principle

Folders store location.

Tags store meaning.

Mailbox stores ownership.

Together they create a lightweight ticketing system inside Outlook.

---

## Related Documents

- ARC-SYS-000 — Architecture Control Map