# ARC-OPS-002 — Teams Channel Strategy

## Layer: Operational Collaboration  
## Type: Architecture (Source of Truth)

---

# 1. Objective

Define how Microsoft Teams is structured to support:

- internal collaboration
- cross-department coordination
- operational workflows

---

# 2. Core Principle

```text
Teams = execution layer
````

Work happens here, not in email.

---

# 3. Team Model

## 3.1 Rule

```text
1 Department = 1 Team
```

---

## 3.2 Standard Teams

```text
MGMT Team
OPS Team
SAL Team
FIN Team
SUP Team
IT Team
```

---

## 3.3 Exception

```text
WHS (Warehouse) → NO dedicated Team
```

Reason:

```text
Operational staff = low Teams usage
Integration via OPS Team
```

---

# 4. Channel Model

## 4.1 Channel Types

| Type       | Purpose              |
| ---------- | -------------------- |
| Core       | daily work           |
| Functional | specific tasks       |
| Cross-Dept | coordination         |
| Incident   | issues / escalations |

---

## 4.2 Naming Convention

```text
CH-<TYPE>-<NAME>
```

Examples:

```text
CH-GEN-General
CH-FNC-Dispatch
CH-XD-Warehouse
CH-INC-Incidents
```

---

# 5. Standard Channel Structure

## 5.1 Mandatory Channels (ALL Teams)

```text
CH-GEN-General
CH-OPS-Internal
CH-INC-Issues
```

---

## 5.2 Functional Channels (by dept)

### OPS Team

```text
CH-FNC-Dispatch
CH-FNC-Customer-Issues
CH-XD-Warehouse
CH-INC-Delays
```

---

### SUP Team

```text
CH-FNC-Tickets
CH-FNC-Customer-Communication
```

---

### FIN Team

```text
CH-FNC-Invoicing
CH-FNC-Payments
```

---

# 6. Cross-Department Model

## 6.1 Rule

```text
NO duplicate Teams  
Use shared channels instead
```

---

## 6.2 Access Model

| Role          | Access                       |
| ------------- | ---------------------------- |
| ROLE-WHS-LEAD | OPS → CH-XD-Warehouse        |
| ROLE-SUP-LEAD | OPS → CH-FNC-Customer-Issues |
| ROLE-FIN-MGR  | SAL → CH-FNC-Invoicing       |

---

## 6.3 Principle

```text
Access follows responsibility
```

---

# 7. Private vs Shared Channels

## 7.1 Usage

| Type     | When             |
| -------- | ---------------- |
| Standard | default          |
| Private  | sensitive data   |
| Shared   | cross-department |

---

## 7.2 Rule

```text
Default = Standard  
Use Private ONLY when required
```

---

# 8. Integration with Mailboxes

## 8.1 Rule

```text
Email triggers → Teams execution
```

---

## 8.2 Example

```text
support@ receives issue
→ categorized CAT-OPS
→ notified in CH-FNC-Customer-Issues
→ handled in Teams
```

---

# 9. Ownership Model

## 9.1 Each Team has:

```text
Primary Owner
Secondary Owner
```

---

## 9.2 Each Channel:

```text
Has implicit owner via Team owner
```

---

# 10. Governance Rules

## 10.1 Restrictions

```text
No unused channels  
No duplicate channels  
No personal communication channels  
```

---

## 10.2 Lifecycle

```text
Create → Use → Archive → Delete (controlled)
```

---

# 11. Design Constraints

## 11.1 Simplicity

```text
Max 5–7 channels per Team (initial)
```

---

## 11.2 Scalability

```text
Add channels ONLY when needed
```

---

## 11.3 Visibility

```text
Work must be visible → avoid private silos
```

---

# 12. Output Impact

Feeds:

```text
BLP-OPS-001 — Teams Channels Blueprint
MTX-TEAMS.csv
MTX-CHANNELS.csv
```

---

# 13. Final Principle

```text
Teams structure = operational backbone
```

````

---

# 🧠 CLAVE

Esto que hiciste ahora:

```text
Pasaste de “usuarios y mailboxes”
→ a “cómo trabaja la empresa”
````

---

# 🚀 SIGUIENTE (recomendado)

👉 `BLP-OPS-001 — Teams Channels Blueprint`

Ahí lo bajamos a:

```text
tabla → CSV → automatizable
```