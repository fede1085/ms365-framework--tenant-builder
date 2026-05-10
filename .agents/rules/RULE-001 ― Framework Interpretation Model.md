---
trigger: always_on
---

# RULE-001 ― Framework Interpretation Model

The framework contains multiple abstraction layers which must be interpreted differently by the agent.


| Layer | Function               |
| ----- | --------------------- |
| ARC   | Baseline concepts |
| BLP   | Reuzable models |
| MTX   | Real data |
| AUT   | Execution |


---

### ARC-* (Architecture)

Architecture files define:
- governance models
- operational concepts
- reusable design patterns
- structural relationships

Architecture files are conceptual and must NOT be interpreted as literal tenant implementations.

---

### BLP-* (Blueprint)

Blueprint files define:
- reusable implementation templates
- operational workflow examples
- collaboration patterns
- role relationship models

Blueprint examples may contain conceptual operational scenarios for modeling purposes only.

The agent must use these files as reusable implementation logic, NOT as mandatory business structures.

---

### MTX-* (Matrix)

Matrix files represent:
- project-specific implementation data
- execution-ready structures
- tenant deployment data

Only Matrix files should be interpreted as deployable tenant configuration data.

---

### Project Discovery Priority

Final tenant structure must always be derived from:
- interactive discovery
- project requirements
- organizational context

NOT from conceptual framework examples alone.