# @SYS-MAP-003 - Semantic Sitemap

> **Purpose:** High-level semantic navigation map to help AI systems understand project structure WITHOUT real folders.

## 1. Hierarchy
- @ROOT
  - @00-SYSTEM — Semantic Control Layer
  - @01-FRAMEWORK — Tenant Setup
    - @01-ARC — Architecture
    - @02-BLP — Blueprint Templates
    - @03-MTX — Data Matrices (Schemas)
    - @04-AUT — Automation Executables
  - @02-INSTANCES — Projects

## 2. Domains
- @DOMAIN-IDENTITY -> Flow to @MOD-USERS, @MOD-GROUPS
- @DOMAIN-COLLABORATION -> Flow to @MOD-GROUPS
- @DOMAIN-MESSAGING -> Flow to @MOD-MAILBOXES

## 3. Semantic Flows
- Conceptualization: @ARC -> @BLP
- Instantiation: @BLP -> @MTX
- Execution: @MTX -> @AUT

## 4. Architecture Flows
- Master Rules (@ARC-SYS-000) define constraints for Naming (@ARC-STD-007) and Security (@ARC-STD-014).
- Architecture directly constraints all Blueprints (@BLP-*).

## 5. Governance Flows
- Governance documents (@ARC-GOV-*) dictate the rules within the Architecture (@ARC) layer.
- Identity Governance -> @ARC-SYS-000
- License Governance -> @BLP-TMP-015

## 6. Blueprint Flows
- Blueprints (@BLP-TMP-*) act as the standardized template layer.
- They consume Architecture rules and generate the structure for Matrices (@MTX-*).

