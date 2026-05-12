# Operations Guide

## Local Runtime

```bash
cp .env.example .env
docker compose up -d --build
```

Open:

- Frontend: `http://localhost:3000`
- Backend health: `http://localhost:8080/actuator/health`
- Backend metrics: `http://localhost:8080/actuator/prometheus`
- MinIO console: `http://localhost:9001`

Set `OPENAI_API_KEY` in `.env` before using model-backed chat.

## Modes

| Mode | Chat endpoint | Upload endpoint | Purpose |
| --- | --- | --- | --- |
| RAG | `/api/chat` | `/api/documents` | Direct retrieval-augmented QA. |
| Agent | `/api/agent/chat` | `/api/documents` | Tool-using agent over the retrieval core. |
| LLM Wiki | `/api/wiki/chat` | `/api/wiki/upload` | Wiki-style memory over retrieved chunks. |
| GBrain | `/api/gbrain/chat` | `/api/wiki/upload` | Skill layer over wiki memory. |
| Bot Gateway | `/api/bot/{channel}/callback` | N/A | Normalized Feishu, DingTalk, and WeChat callbacks. |

## Runtime Configuration

| Variable | Purpose |
| --- | --- |
| `OPENAI_API_KEY` | OpenAI-compatible model provider key. |
| `OPENAI_CHAT_MODEL` | Chat model name. |
| `OPENAI_EMBEDDING_MODEL` | Embedding model name. |
| `FRONTEND_PORT` | Browser-facing frontend port. |
| `BACKEND_PORT` | Browser/API-facing backend port. |
| `MYSQL_ROOT_PASSWORD` | Local MySQL root password. |
| `MINIO_ROOT_USER` | Local MinIO username. |
| `MINIO_ROOT_PASSWORD` | Local MinIO password. |
| `BOT_ENABLED` | Enables the Bot gateway. Defaults to `false`. |
| `BOT_SIGNING_SECRET` | Internal HMAC secret for normalized Bot callbacks. |
| `BOT_FEISHU_ENABLED` | Enables the Feishu channel. |
| `BOT_DINGTALK_ENABLED` | Enables the DingTalk channel. |
| `BOT_WECHAT_ENABLED` | Enables the WeChat channel. |

## Bot Gateway Smoke Test

See [Bot Integration Guide](BOT-INTEGRATION.md) for signed requests. A valid callback must include `X-Bot-Timestamp` and `X-Bot-Signature`, unless the channel-specific token header is used for a trusted internal test.

```bash
curl -i http://localhost:8080/actuator/health
```

## Production Checklist

- Protect `/api/gbrain/skills/run-all` before exposing it to shared users.
- Persist wiki and skill state outside in-memory maps.
- Add source citation payloads for frontend rendering.
- Add idempotency storage for Bot message IDs before enabling platform retries.
- Add RBAC around `tenantId`, allowed modes, and document namespace.
- Add observability for retrieval latency, model latency, and tool calls.
