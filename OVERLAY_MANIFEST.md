# Overlay manifest

Baseline: `miuuyy/codex-chatgpt-web` `v2.1.11` / `e2c69d54877c47aa6a34bce72e7536e1c31c9846`

The compatibility bundle contains exactly these 22 replacement files:

```text
launcher/electron/main.cjs
launcher/electron/runtime-supervisor.cjs
launcher/electron/runtime.cjs
launcher/src/App.tsx
launcher/src/types.ts
scripts/start-launcher.ts
src/cli.ts
src/config.ts
src/setup.ts
src/chatgpt-session.ts
src/adapters/chatgpt-web/browser-worker.ts
src/adapters/chatgpt-web/browser-helper-main.ts
src/adapters/chatgpt-web/index.ts
src/adapters/chatgpt-web/launcher-helper-client.ts
src/responses/parser.ts
src/responses/schema.ts
src/types.ts
launcher/tests/runtime-host.test.cjs
tests/setup-lifecycle.test.ts
tests/chatgpt-session.test.ts
tests/responses-lite-tools.test.ts
tests/browser-worker-contract.test.ts
```

Decoded `overlay.tar.gz` SHA-256:

```text
3320d57827b1b3e5429380a9d9ed1f95bc307e1b62b253be94d10b7aa3cbfa58
```

Stored `overlay.tar.gz.b64` SHA-256:

```text
316952ac0d8a93fda47a2c056be7be62d45e47f49bfb8998424190ddb98563d0
```
