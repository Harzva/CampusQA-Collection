# Compus QA Collection

This repository is the combined Campus/Compus QA collection. It keeps the full evolution path from a base RAG demo to the final memory-enhanced system.

## Projects

| Folder | Role |
| --- | --- |
| `rag_qa` | Base RAG QA. |
| `rag_agent` | RAG QA with an agent layer. |
| `llm_wiki` | RAG + Agent + LLM Wiki memory. |
| `gbrain` | LLM Wiki plus GBrain skill concepts. |
| `hierarchy_memory` | GBrain plus hierarchy memory. |
| `hyper_memory` | Full version with hierarchy memory and hyper memory. |

## Architecture

All projects share the same basic architecture:

- Spring Boot backend for ingestion and chat APIs.
- Vue 3 frontend for upload and chat interaction.
- MySQL for document metadata.
- Redis for cache/memory infrastructure.
- MinIO for uploaded files.
- Milvus for vector storage.
- LangChain4j for embeddings, chat model calls, and agent/tool concepts.

## Run A Project

Enter one project folder and start its stack:

```bash
docker compose up -d
```

Then open:

- Frontend: `http://localhost:3000`
- Backend: `http://localhost:8080`

The projects use the same default ports, so run one at a time unless ports are changed.

## Final System

The most complete campus-oriented version is `hyper_memory`. A market-oriented standalone version is published separately as `HyperMemory`.

