# CampusQA-Collection Roadmap

CampusQA-Collection is both a code collection and a teaching project. The goal is to make each method understandable, runnable, and comparable.

## Phase 1: Repository Quality

- [x] Normalize project folders.
- [x] Add runnable frontend entrypoints.
- [x] Add nginx API proxy for Docker deployments.
- [x] Add `.env.example` files.
- [x] Add README screenshots.
- [x] Add collection-level comparison docs.

## Phase 2: Real RAG Quality

- [x] Store text chunks and metadata, not only document IDs.
- [x] Add chunking by fixed window size.
- [ ] Add source citations in answers.
- [ ] Add retrieval score display in debug mode.
- [ ] Add reranking before prompt assembly.

## Phase 3: Agent And Memory

- [ ] Make agent tools versioned and testable.
- [ ] Persist LLM Wiki pages in a database.
- [ ] Persist hierarchy and hyper memory state.
- [ ] Add memory pruning and summarization.
- [ ] Add scheduled GBrain skills with audit logs.

## Phase 4: GitHub Pages Tutorial

- [x] Add static site skeleton under `docs-site/`.
- [ ] Publish with GitHub Pages.
- [ ] Add per-version walkthrough pages.
- [ ] Add visual code-diff explorer.
- [ ] Add runnable examples and sample prompts.

## Phase 5: Production Track

- [ ] Authentication and role-based access control.
- [ ] Tenant/workspace isolation.
- [ ] Observability: logs, metrics, tracing.
- [ ] CI for frontend and backend builds.
- [ ] Deployment profiles for local, staging, and production.
