# BLP-OPS-002 — Outlook Workflow Blueprint

## Layer: Operational Collaboration  
## Type: Blueprint (Implementation Template)

---

# 1. Objective

Translate the Mailbox Workflow Strategy (ARC-OPS-003) into:

```text
Actionable, repeatable, user-driven workflows inside Outlook
````

---

# 2. Scope

Applies to:

```text id="k9v3ha"
All shared mailboxes
```

Defines:

* folder structure
* categories
* Quick Actions / Quick Steps
* routing logic
* triage process

---

# 3. Mailbox Scope

| Mailbox     | Type |
| ----------- | ---- |
| support@    | BIZ  |
| operations@ | OPS  |
| warehouse@  | OPS  |
| finance@    | BIZ  |
| info@       | EXT  |

---

# 4. Folder Structure

## 4.1 Standard

```text id="2v1mfr"
01-New
02-Triage
03-In Progress
04-Waiting
05-Closed
```

---

## 4.2 Optional

```text id="t3x5ls"
06-Escalated
07-Archive
```

---

# 5. Categories (Tags)

## 5.1 Global Categories

```text id="7w2x9h"
CAT-OPS
CAT-WHS
CAT-FIN
CAT-SAL
CAT-URGENT
CAT-WAITING
```

---

## 5.2 Rule

```text id="f8u9qp"
Every email MUST have at least one category
```

---

# 6. Quick Actions / Quick Steps

## 6.1 Purpose

```text id="d2k8js"
Reduce manual routing and enforce workflow
```

---

## 6.2 Standard Actions

### Support → Operations

```text id="u6h2nf"
Name: Send to Operations

Steps:
1. Categorize → CAT-OPS
2. Forward → operations@
3. Move → 03-In Progress
```

---

### Operations → Warehouse

```text id="r4p8kc"
Name: Send to Warehouse

Steps:
1. Categorize → CAT-WHS
2. Forward → warehouse@
3. Move → 03-In Progress
```

---

### Operations → Support (Return)

```text id="x1j7bt"
Name: Return to Support

Steps:
1. Categorize → CAT-WAITING
2. Forward → support@
3. Move → 04-Waiting
```

---

### Finance → Sales

```text id="m9l3ac"
Name: Send to Sales

Steps:
1. Categorize → CAT-SAL
2. Forward → sales@
3. Move → 03-In Progress
```

---

## 6.3 Urgent Escalation

```text id="q3s8rm"
Name: Escalate Urgent

Steps:
1. Categorize → CAT-URGENT
2. Move → 06-Escalated
3. Notify via Teams
```

---

# 7. Triage Process

## 7.1 Flow

```text id="w4k6nb"
01-New → 02-Triage → Action
```

---

## 7.2 Triage Owner Responsibilities

```text id="k2f9qp"
- Categorize
- Decide next step
- Assign via action
```

---

## 7.3 Rule

```text id="n7h5js"
No email stays in 01-New
```

---

# 8. Routing Logic

## 8.1 Standard Chain

```text id="p6r3xt"
Support → Operations → Warehouse → Resolution
```

---

## 8.2 Return Chain

```text id="v9n2lb"
Warehouse → Operations → Support → Customer
```

---

# 9. Teams Integration

## 9.1 Rule

```text id="b5x1qp"
Mailbox actions must trigger Teams awareness
```

---

## 9.2 Example

```text id="t7m4kc"
Send to Operations
→ notification in OPS → CH-FNC-Customer-Issues
```

---

# 10. Ownership Model

## 10.1 Mailbox

```text id="c3v9rm"
Primary Owner → responsible
Members → execute
```

---

## 10.2 Actions

```text id="d6x2pf"
Executed by team members
```

---

# 11. Governance Rules

## 11.1 Restrictions

```text id="z8w1la"
No direct replies without categorization  
No skipping triage  
No manual forwarding without Quick Step  
```

---

## 11.2 Control

```text id="j4y8mt"
All routing must follow defined actions
```

---

# 12. Constraints

## 12.1 Simplicity

```text id="p2f7dc"
Max 5–7 Quick Steps per mailbox
```

---

## 12.2 Usability

```text id="u9k3qe"
Actions must be easy to use in daily work
```

---

## 12.3 Consistency

```text id="e6r1zt"
Same logic across all mailboxes
```

---

# 13. Output Mapping

Feeds into:

```text id="q7x2mv"
MTX-MAILBOX-FOLDERS.csv
MTX-MAILBOX-CATEGORIES.csv
MTX-MAILBOX-ACTIONS.csv
```

---

# 14. Final Principle

```text id="w3b6nt"
Outlook workflow = controlled execution layer
```

````id="kq1vmb"

---

# 🧠 LO QUE ACABÁS DE HACER

Ahora tenés:

```text
Teams → colaboración
Mail → workflow estructurado
````

👉 Esto ya es operación real de empresa

---

# 🚀 SIGUIENTE (cierra todo)

👉 `BLP-OPS-003 — Department Handoff Blueprint`

Ese va a definir:

```text id="g2c8vn"
quién pasa qué → a quién → cuándo → con qué reglas
```