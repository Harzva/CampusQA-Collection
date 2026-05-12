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
  <a href="#quick-start">Quick Start</a> ·
  <a href="docs/OPERATIONS.md">Operations</a> ·
  <a href="docs/PRODUCTION-REVIEW.md">Production Review</a>
</p>

<p align="center">
  <img src="docs/assets/screenshots/campus-agent-dashboard.png" alt="CampusAgent-QA frontend preview" width="920">
</p>

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

## Frontend Preview

The first screen is the actual workbench users operate: mode switch, upload flow, and streaming-ready chat panel.

<p align="center">
  <img src="docs/assets/screenshots/campus-agent-dashboard.png" alt="CampusAgent-QA workbench" width="920">
</p>

## Architecture

```mermaid
flowchart LR
    User["Browser"] --> UI["Vue 3 Workbench"]
    UI --> API["Spring Boot API"]
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
docs/PRODUCTION-REVIEW.md
docker-compose.yml    Full local runtime stack
.env.example          Runtime configuration template
```

## Production Readiness

See [Production Review](docs/PRODUCTION-REVIEW.md) for the detailed audit. The next highest-impact work is protecting skill execution, persisting Wiki/GBrain state, exposing tool-call traces, and Docker Compose smoke tests in CI.
