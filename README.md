# codex-chatgpt-web-opencodex

A small compatibility overlay for [miuuyy/codex-chatgpt-web](https://github.com/miuuyy/codex-chatgpt-web) that lets **OpenCodex remain the single Codex routing entry point** while using ChatGPT Web tiers such as `chatgpt-web/high` as an OpenCodex provider.

## Why this exists

Upstream is designed to sit directly in front of Codex:

```text
Codex → codex-chatgpt-web → ChatGPT Web / native Codex backend
```

OpenCodex users already have a router in that position. This overlay enables:

```text
Codex
  ↓
OpenCodex
  ├─ existing providers
  └─ chatgpt-web/high
       ↓
     codex-chatgpt-web --standalone
       ↓
     ChatGPT Web
```

If the ChatGPT Web service fails, other OpenCodex providers remain usable.

## What is changed

Against upstream release `v2.1.11` / commit `e2c69d54877c47aa6a34bce72e7536e1c31c9846`:

1. **Standalone mode** — runs the ChatGPT Web browser/Responses service without taking ownership of Codex routing.
2. **Localized High selection** — supports both `High` and Chinese `高`, while avoiding `Extra High` / `超高` false matches.
3. **Explicit Web Search propagation** — a Responses request declaring `web_search` triggers the real ChatGPT composer Web Search action.

No OpenCodex core source change is required.

## Why an overlay instead of a full fork?

The hard browser automation, login handling, model selection, Responses/SSE bridge and launcher remain upstream work. This repository stores only the compatibility delta instead of duplicating the full project and its large runtime dependencies.

The complete 22-file overlay is compressed, base64-encoded and split across `overlay.parts/part-*`. `apply-overlay.sh` automatically reassembles it, verifies SHA-256, and extracts it. `OVERLAY_MANIFEST.md` lists every included path.

## Apply

1. Check out the matching upstream version:

```bash
git clone https://github.com/miuuyy/codex-chatgpt-web.git
cd codex-chatgpt-web
git checkout e2c69d54877c47aa6a34bce72e7536e1c31c9846
```

2. Clone/download this compatibility repository and run:

```bash
bash apply-overlay.sh /path/to/codex-chatgpt-web
```

3. Install upstream dependencies normally, then configure standalone/browser-only mode.

The tested OpenCodex provider shape was equivalent to:

```json
{
  "adapter": "openai-responses",
  "baseUrl": "http://127.0.0.1:17841",
  "allowPrivateNetwork": true,
  "defaultModel": "chatgpt-web/high",
  "models": ["chatgpt-web/high"],
  "liveModels": false
}
```

Keep the standalone service bound to `127.0.0.1`.

## Verified locally

The original PoC verified:

- normal `Codex → OpenCodex → chatgpt-web/high` Responses streaming;
- explicit Web Search with a dated public source;
- a company-research query returning official-source evidence;
- failure isolation: stopping ChatGPT Web did not break existing OpenCodex models;
- upstream + compatibility tests passed in the tested environment.

## Maintenance rule

Do not chase upstream releases automatically. Treat the pinned upstream commit as the known-good base. Rebase only when an actual breakage or useful upstream fix justifies it.

Agents working on this repository should read `AGENTS.md` and `FORK_NOTES.md` before changing anything.

## Scope

This project intentionally does not add another router, a second `CODEX_HOME`, MCPX, DevSpace, or a custom research-agent framework.

## Upstream and license

Based on `miuuyy/codex-chatgpt-web`, MIT licensed. This repository is unofficial and is not affiliated with OpenAI, OpenCodex, or the upstream author. It must not be used to evade subscription limits or access controls.
