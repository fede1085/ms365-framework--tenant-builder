# ARC-STD-014 — Security Baseline

## SME Logistics Tenant Blueprint

---

# 1. Purpose

Define the minimum professional security baseline for the tenant.

Goal:

Protect identities, data, admin access, devices, and daily operations without overengineering.

This document is designed for:

- SME tenants
- low complexity environments
- scalable future growth
- automation-ready deployment

---

# 2. Security Philosophy

Use:

- least privilege
- simple controls
- layered protection
- secure by default
- periodic review

Avoid:

- permanent admin rights
- shared passwords
- no MFA
- overcomplicated policies
- unused legacy access

---

# 3. Core Security Layers

| Layer | Objective |
|---|---|
| Identity | Protect accounts |
| Access | Control sign-ins |
| Admin | Protect privileged roles |
| Data | Protect company information |
| Device | Protect endpoints |
| Monitoring | Detect problems early |

---

# 4. Identity Security

## Mandatory Actions

- Enable MFA for all admins
- Enable MFA for all users (recommended phased rollout)
- Disable legacy/basic authentication
- Require strong passwords
- Enable self-service password reset

## Notes

Priority first:

1. Global Admins  
2. IT Admins  
3. Finance / HR users  
4. Everyone else

---

# 5. Admin Security

## Dedicated Admin Accounts

Admins should have:

- normal user account
- separate admin account

Example:

federico@company.com  
admin.federico@company.com

## Roles

Use role separation:

- Global Administrator
- User Administrator
- License Administrator
- Teams Administrator
- Security Administrator

Do not use Global Admin for daily work.

---

# 6. Emergency Access

## Break Glass Account

Create 1–2 emergency admin accounts.

Rules:

- very strong password
- excluded from normal MFA failures if required
- monitored
- rarely used
- securely stored credentials

---

# 7. Protected Administrator Objects

Protected administrator objects include:

- Global Administrator accounts
- breakglass accounts
- tenant owner accounts
- emergency access accounts
- currently connected automation operator accounts
- accounts explicitly listed in tenant-local protected object lists

Automation must never delete, disable, rename, recreate, password-reset, role-change, UPN-change, alias-change, license-change, remove group memberships, remove ownership, remove aliases, remove roles, or convert protected administrator objects into regular users unless a separately documented emergency override workflow exists.

Example tenant-local protected object pattern:

| DisplayName | Primary UPN | Known Aliases | Role |
|---|---|---|---|
| GLOBAL-Admin | homelab@federicomosqueira0910.onmicrosoft.com | global.admin@federicomosqueira.site; hello@federicomosqueira.site | Global Administrator |

GLOBAL-Admin is a tenant owner / protected global admin account example, not the only possible protected object.

---

# 8. Conditional Access (Recommended)

## Minimum Policies

### Policy 01

Admins require MFA always.

### Policy 02

Block legacy authentication.

### Policy 03

High-risk sign-in requires MFA.

### Policy 04

Unknown countries / impossible travel review.

---

# 9. Mail Security

## Exchange Online Baseline

- Anti-spam enabled
- Anti-phishing enabled
- Safe links if license allows
- External forwarding restricted
- Shared mailbox permissions reviewed

---

# 10. Data Protection

## Minimum Controls

- Finance access restricted
- HR access restricted
- Shared links reviewed
- Sensitive files in proper Teams / SharePoint locations

## Future Phase

- Sensitivity labels
- Retention labels
- DLP policies

---

# 11. Device Security

If using company devices:

- Intune enrollment
- screen lock
- encryption
- antivirus active
- updates enforced

If BYOD:

- mobile app protection policies

---

# 12. Monitoring & Audit

## Enable / Review

- Sign-in logs
- Audit logs
- Admin role changes
- Mailbox delegation changes
- Suspicious login alerts

Frequency:

- weekly quick review
- monthly formal review

---

# 13. Lifecycle Security

## Joiner

- user created correctly
- MFA registered
- least privilege access

## Mover

- old access removed
- new access granted

## Leaver

- block sign-in immediately
- revoke sessions
- remove licenses
- transfer mailbox/files if needed

---

# 14. Governance Rules

- No shared credentials
- No personal accounts for business data
- Every privileged role has owner
- Quarterly access review
- Remove stale guests/users
- Document exceptions

---

# 15. Security Score Target

Use Microsoft Secure Score.

Initial SME target:

- 45% minimum quickly
- 60% healthy baseline
- 75% mature tenant

---

# 16. Automation Ready Tasks

Can automate:

- MFA reports
- stale account reports
- role membership reports
- mailbox permission audits
- license/security mismatch reports

---

# 17. Priority Implementation Order

## Week 1

1. MFA admins
2. Break glass
3. Remove legacy auth
4. Role cleanup

## Week 2

5. MFA users
6. Conditional Access basic
7. Audit review

## Week 3+

8. Device controls
9. Compliance controls
10. Advanced monitoring

---

# 18. Final Principle

Security should be invisible when normal, strong when needed, and simple to maintain.

---

# 19. Next Document

BLP-TMP-015 — License Matrix
