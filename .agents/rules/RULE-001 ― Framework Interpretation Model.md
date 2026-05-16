---
trigger: always_on
---

# RULE-001 ― Framework Interpretation Model

The framework contains multiple abstraction layers which must be interpreted differently by the agent.

`.agents` defines operational agent behavior only. It does not redefine semantic doctrine, canonical contracts, or tenant architecture.

Authority order:

SYS → CANONICAL → ARC → BLP → MTX → AUT → INSTANCE/TENANT


| Layer | Function               |
| ----- | --------------------- |
| SYS   | Semantic meta-framework control |
| CANONICAL | Structured schemas, rules, routing, and graph constraints |
| ARC   | Tenant architecture doctrine |
| BLP   | Reusable models |
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

The agent must use these files as reusable tenant design patterns, NOT as mandatory business structures or runtime input.

---

### MTX-* (Matrix)

Matrix files represent:
- project-specific implementation data
- execution-ready structures
- tenant deployment data

Only Matrix files should be interpreted as deployable tenant configuration data.

AUT must execute validated MTX data only. BLP must never be used as direct runtime input.

---

### Project Discovery Priority

Final tenant structure must always be derived from:
- interactive discovery
- project requirements
- organizational context

NOT from conceptual framework examples alone.
