# Production Review

## Current Position

CampusAgent-QA is the agentic product in the three-repository set. It combines the RAG baseline with an agent endpoint, Wiki memory, and GBrain skill inspection.

## Improvements Applied

| Area | Change |
| --- | --- |
| Repository shape | Created a single-product CampusAgent-QA directory instead of using the old multi-version collection. |
| Product scope | README and UI now describe one Agent QA application, not a tutorial collection. |
| Frontend | Replaced the demo-like screen with a cleaner workbench layout and product-specific mode list. |
| Agent behavior | Removed hardcoded FAQ answers; the agent now relies on retrieval tools for knowledge answers. |
| GBrain | Replaced placeholder console skills with deterministic inspection skills and structured names. |
| Documentation | Added operations notes, architecture map, and production checklist. |
| CI | Added GitHub Actions jobs for frontend build and backend Maven tests. |
| Bot integration | Added a disabled-by-default Bot gateway for Feishu, DingTalk, and WeChat adapters. |
| Observability | Added Prometheus metrics exposure and graceful shutdown settings. |

## Highest-Impact Next Work

| Priority | Work | Why |
| --- | --- | --- |
| P0 | Protect `/api/gbrain/skills/run-all` | Manual skill execution must be authenticated. |
| P1 | Persist Wiki and GBrain state | In-memory state is not enough for production. |
| P1 | Add tool-call trace output | Operators need to see which tools the agent used. |
| P1 | Add Bot idempotency storage | Prevents duplicate platform retries from creating duplicate model calls. |
| P2 | Add versioned skill definitions | Skills need lifecycle, owner, schedule, and audit fields. |
| P2 | Expand CI with Docker Compose smoke tests | Verifies the whole runtime, not only builds. |

## Known Tradeoffs

- This repository intentionally stops before HyperMemory; hierarchy and hyper aggregation live in `Harzva/HyperMemory`.
- The current runtime still uses MySQL, Milvus, MinIO, and Redis for the Docker demo.
- The backend sends one completed SSE event; the frontend can consume streaming chunks once the model layer is upgraded.
