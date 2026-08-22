# Fork notes

## Baseline

- Upstream: `miuuyy/codex-chatgpt-web`
- Baseline release: `v2.1.11`
- Baseline commit recorded by the local PoC: `e2c69d54877c47aa6a34bce72e7536e1c31c9846`

## Purpose

Allow `codex-chatgpt-web` to run as a loopback Responses provider below OpenCodex without claiming Codex's `openai_base_url`.

## Local PoC delta

The verified PoC recorded 22 changed files relative to its baseline (`+383/-41`): 17 production files and 5 tests. The changes are concentrated in:

- standalone lifecycle/launcher handling;
- localized High selection;
- explicit Web Search request propagation and browser selection;
- regression tests for those behaviors.

The intention of this public repository is to keep those changes narrowly scoped and avoid unrelated product expansion.

## Maintenance policy

- Follow upstream only when needed for a real compatibility or security issue.
- Prefer upstreamable, small changes over adding fork-only features.
- A ChatGPT Web failure must not interfere with other OpenCodex providers.
- Keep the local Responses service on loopback unless authentication is deliberately added.
