# Remaining Production Gaps

This repository is deployable as an agentic campus QA service, but it still needs the following work before being treated as a mature production system.

## P0 Before Real Users

| Gap | Impact | Recommended fix |
| --- | --- | --- |
| No user authentication | Anyone reaching the API can upload, query, or run skills. | Add OAuth/OIDC or gateway auth before public exposure. |
| No tenant-scoped document isolation | Knowledge and conversations can mix across organizations. | Add `tenantId` to documents, chunks, conversations, tools, and retrieval filters. |
| `/api/gbrain/skills/run-all` is unauthenticated | Manual skill execution can be abused. | Restrict to admin roles and add audit logs. |
| No Bot idempotency store | Platform retries can trigger duplicate tool and model calls. | Store `(channel, messageId)` in Redis or MySQL with TTL. |

## P1 Operational Hardening

| Gap | Impact | Recommended fix |
| --- | --- | --- |
| Agent tool traces are not returned | Operators cannot inspect why the agent chose a path. | Return tool name, inputs, retrieved sources, and latency. |
| Wiki/GBrain state is partly in memory | State can disappear after restarts. | Persist skill state, runs, and wiki snapshots. |
| `ddl-auto: update` | Schema changes are implicit. | Introduce Flyway/Liquibase migrations. |
| No alert rules | Metrics exist but no alert policy. | Add Prometheus alert rules for 5xx, latency, memory, and tool failures. |

## P2 Product Refinement

| Gap | Impact | Recommended fix |
| --- | --- | --- |
| No evaluation set | Agent changes can silently reduce answer quality. | Add golden campus QA and tool-routing cases. |
| No versioned skills | GBrain changes are hard to review or roll back. | Store skill version, owner, schedule, and changelog. |
| No admin console | Skill runs and index health are not visible to operators. | Add an authenticated operator dashboard later. |

## Maintenance Focus

- Keep this repo focused on RAG, Wiki, Agent, and GBrain.
- Do not add Hierarchy/Hyper aggregation here; keep that in `HyperMemory`.
- Update README screenshots whenever the workbench UI or mode list changes.
- Run `mvn -B test`, `npm run build`, and `npm audit --audit-level=moderate` before releases.
