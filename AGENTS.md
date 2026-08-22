# Agent maintenance note

This repository is intentionally a thin compatibility overlay.

Rules for future maintenance:
- Fix only observed breakage.
- Do not expand into a second router or agent framework.
- Keep OpenCodex as the single Codex routing entry point.
- Prefer the smallest compatibility change against upstream.
- Do not update the upstream baseline unless there is a concrete need.
- Preserve standalone failure isolation: ChatGPT Web failure must not break other OpenCodex providers.
