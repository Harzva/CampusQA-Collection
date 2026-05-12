<h1 align="center">CampusAgent-QA</h1>

<p align="center">
  Agentic campus knowledge QA with <strong>RAG retrieval</strong>, <strong>LLM Wiki</strong>, and <strong>GBrain skills</strong>.
</p>

<p align="center">
  <img alt="Java 17" src="https://img.shields.io/badge/Java-17-007396?logo=openjdk&logoColor=white">
  <img alt="Spring Boot 3.3" src="https://img.shields.io/badge/Spring%20Boot-3.3-6DB33F?logo=springboot&logoColor=white">
  <img alt="Vue 3" src="https://img.shields.io/badge/Vue-3-42B883?logo=vuedotjs&logoColor=white">
  <img alt="Agent" src="https://img.shields.io/badge/Agent-Retrieval%20Tools-334155">
  <img alt="Docker Compose" src="https://img.shields.io/badge/Run-Docker%20Compose-2496ED?logo=docker&logoColor=white">
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> |
  <a href="docs/OPERATIONS.md">Operations</a> |
  <a href="docs/PRODUCTION-ARCHITECTURE.md">Architecture</a> |
  <a href="docs/PRODUCTION-GAPS.md">Production Gaps</a> |
  <a href="docs/MAINTENANCE.md">Maintenance</a> |
  <a href="docs/BOT-INTEGRATION.md">Bot Integration</a> |
  <a href="docs/OPEN_SOURCE_REFERENCES.md">References</a>
</p>

<p align="center">
  <img src="docs/assets/screenshots/campus-agent-dashboard.png" alt="CampusAgent-QA frontend preview" width="920">
</p>

## Architecture Framework

<p align="center">
  <img src="docs/assets/architecture/campus-agent-architecture.png" alt="CampusAgent-QA architecture framework" width="920">
</p>

> This image is an ImageGen-rendered visual architecture map. The Mermaid diagram and OpenAPI docs remain the exact engineering contract.

## Position

CampusAgent-QA is the agentic repository in the final three-repo set. It is no longer a collection of separated versions: the repo now presents one runnable application with four modes sharing the same ingestion and retrieval foundation.

| Repository | Role |
| --- | --- |
| `Harzva/CampusRAG-QA` | Baseline RAG + Wiki mode. |
| `Harzva/CampusAgent-QA` | Agent tools, Wiki memory, and GBrain skills. |
| `Harzva/HyperMemory` | Final memory-enhanced system. |

## What It Does

| Mode | Endpoint | Purpose |
| --- | --- | --- |
| RAG | `/api/chat` | Direct grounded QA over retrieved chunks. |
| Agent | `/api/agent/chat` | Uses retrieval tools instead of hardcoded FAQ answers. |
| LLM Wiki | `/api/wiki/chat` | Presents retrieved chunks as wiki-style memory. |
| GBrain | `/api/gbrain/chat` | Adds deterministic skill inspection over wiki memory. |
| Bot Gateway | `/api/bot/{channel}/callback` | Routes normalized Feishu, DingTalk, and WeChat messages. |

## Visual Walkthrough

Six README-owned screenshots show the runnable workbench across RAG, Agent, GBrain, Bot readiness, and mobile layout.

| Dashboard | RAG mode | Agent mode |
| --- | --- | --- |
| <img src="docs/assets/screenshots/campus-agent-dashboard.png" alt="CampusAgent-QA dashboard" width="300"> | <img src="docs/assets/screenshots/campus-agent-rag-mode.png" alt="CampusAgent-QA RAG mode" width="300"> | <img src="docs/assets/screenshots/campus-agent-agent-mode.png" alt="CampusAgent-QA Agent mode" width="300"> |

| GBrain conversation | Production readiness | Mobile |
| --- | --- | --- |
| <img src="docs/assets/screenshots/campus-agent-gbrain-conversation.png" alt="CampusAgent-QA GBrain conversation" width="300"> | <img src="docs/assets/screenshots/campus-agent-readiness.png" alt="CampusAgent-QA production readiness" width="300"> | <img src="docs/assets/screenshots/campus-agent-mobile.png" alt="CampusAgent-QA mobile" width="160"> |

## Architecture

```mermaid
flowchart LR
    User["Browser"] --> UI["Vue 3 Workbench"]
    Bot["Feishu / DingTalk / WeChat"] --> Gateway["Bot Gateway"]
    UI --> API["Spring Boot API"]
    Gateway --> API
    API --> RAG["RAG Service"]
    API --> Agent["Agent Service"]
    API --> Wiki["Wiki Facade"]
    API --> GBrain["GBrain Service"]
    Agent --> Retrieval["Retrieval Context Service"]
    RAG --> Retrieval
    Wiki --> Retrieval
    GBrain --> Wiki
    Retrieval --> Milvus[("Milvus vectors")]
    Retrieval --> MySQL[("MySQL chunks")]
    API --> MinIO[("MinIO files")]
    API --> Model["OpenAI-compatible models"]
```

## Quick Start

```bash
cp .env.example .env
docker compose up -d --build
```

Open:

- Frontend: `http://localhost:3000`
- Backend health: `http://localhost:8080/actuator/health`
- MinIO console: `http://localhost:9001`

Set `OPENAI_API_KEY` in `.env` before expecting model-backed answers.

## Repository Layout

```text
backend/              Spring Boot API, RAG, Agent, Wiki, and GBrain services
frontend/             Vue 3 workbench
docs/assets/          README screenshots
docs/OPERATIONS.md    Runtime and endpoint notes
docs/PRODUCTION-ARCHITECTURE.md
docs/PRODUCTION-GAPS.md
docs/MAINTENANCE.md
docs/BOT-INTEGRATION.md
docs/SCREENSHOTS.md
docs/openapi/          API contract templates
deploy/k8s/            Kubernetes deployment template
docs/PRODUCTION-REVIEW.md
SECURITY.md            Security policy and secret-handling notes
docker-compose.yml    Full local runtime stack
.env.example          Runtime configuration template
```

## Production Readiness

See [Production Review](docs/PRODUCTION-REVIEW.md) and [Production Gaps](docs/PRODUCTION-GAPS.md) for the detailed audit. The remaining production blockers are authentication, tenant isolation, GBrain admin protection, Bot idempotency, and tool-call traces.
