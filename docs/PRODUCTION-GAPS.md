# Production Readiness Status

This repository now has the minimum closure needed for a controlled staging-to-production path.

## Closed Minimum Gates

| Gate | Status |
| --- | --- |
| API authentication and RBAC | Closed with token-based `USER`/`ADMIN` roles, tenant-bound access checks, and admin-only GBrain skill execution. Replace with OIDC before broad public use. |
| Tenant isolation | Closed for document upload, RAG retrieval, Wiki lookup, Agent/GBrain execution, and Bot dispatch through normalized `tenantId`. |
| Durable Wiki and GBrain state | Closed through `wiki_pages` and `gbrain_skill_runs` JPA persistence. |
| Schema migration | Closed with Flyway baseline migration and `ddl-auto=validate`. |
| Golden QA in CI | Closed with offline golden suite validation in the CI workflow. |
| Bot idempotency and rate limit | Closed with Redis-backed duplicate suppression and fixed-window throttling. |
| Staging backup/restore and alert drill | Closed through `docs/STAGING-RUNBOOK.md` and `scripts/staging_drill.sh`. |

## Still Intentional Post-MVP Work

| Item | Why it remains |
| --- | --- |
| OAuth/OIDC login | Token RBAC is enough for a deployment gate, but not the final user identity system. |
| Agent tool traces in responses | Metrics exist; detailed trace payloads are useful but not required for the minimum gate. |
| Versioned GBrain skills | Skill run persistence exists; skill lifecycle governance can follow. |
| Rich document parsing and reranking | Retrieval is stable enough for staging; quality work remains separate. |
| Operator console | Operations are documented through scripts and metrics; a dashboard can come later. |

## Maintenance Boundary

Keep this repo focused on RAG, Wiki, Agent, and GBrain. Do not add HyperMemory aggregation here.
