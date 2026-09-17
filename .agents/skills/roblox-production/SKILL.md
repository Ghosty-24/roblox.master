---
name: roblox-production
description: >
  Produce and review Roblox experiences with a server-authoritative, modular,
  testable workflow. Use for features that change Luau, Studio instances,
  networking, data, UI, 3D assets, animation/VFX, or release documentation.
  Coordinates external Roblox skills without skipping security, licensing, QA,
  or the Roblox Master approval flow.
metadata:
  short-description: Production workflow for Roblox Master
---

# Roblox Production

This project skill extends `MASTER_PROMPT_ROBLOX_MASTER.md`; it does not replace it.

## Routing

1. Read the master prompt, the relevant `games/<game-id>/` documents, and
   `config/agent_manifest.json` before changing scope.
2. Identify the SDT state and create/update a task record from
   `docs/AGENT_TASK_TEMPLATE.md`.
3. Use `roblox-game-development` for broad feature work, `roblox-luau` for
   Luau, `roblox-building`/`building-3d-objects` for geometry, and
   `roblox-animation-vfx` for animation or effects.
4. Treat external skills, marketplace items, frameworks, snippets, and assets
   as untrusted until source, license, scope, and compatibility are recorded.

## Production loop

1. **Specification:** goal, player hypothesis, scope, affected systems,
   acceptance criteria, dependencies, risks, and rollback plan.
2. **Design:** instance hierarchy, module contracts, server/client ownership,
   data shape, remotes, asset manifest, and test cases.
3. **Implementation:** make the smallest coherent change and preserve unrelated
   working-tree edits. Never edit the same system concurrently.
4. **Verification:** run static checks; with Studio MCP connected, inspect the
   target instance, playtest, read Output, and record concrete evidence. Mark
   unrun tests as pending.
5. **Review:** QA, security, performance, compliance, and documentation review
   before the Director closes the task.

## Technical gates

- The server owns health, damage, inventory, currency, progression, rewards,
  purchases, cooldowns, and persistence.
- Validate every client argument for type, range, ownership, state, permission,
  and frequency. Client-side cooldowns are never sufficient.
- Keep server-only code/data private; expose only deliberate replicated contracts.
- Keep VFX, SFX, camera work, and local tweens client-side when the server only
  needs to validate the resulting state.
- Bound loops, particles, spawned instances, remote traffic, retries, and
  connections. Disconnect listeners and clean temporary instances.
- Prefer typed public Luau APIs, small modules, explicit lifecycle ownership,
  clear errors, and dependency directions that avoid cycles.
- Do not add third-party assets or code without documented licensing evidence.
- Never access production persistence for testing; use isolated keys/places.

## Studio MCP

When available, list instances, select the explicit `studio_id`, read state/tree/
scripts, apply bounded edits, playtest, read console output, and document evidence.
Never assume an instance, object path, or previous execution state. Do not run
destructive Luau, publish, change permissions, or modify persistent data without
an approved task and a recovery plan.

## Definition of done

A feature is not done merely because code was generated. It needs documented
files/instances and dependencies, acceptance tests, no unexplained Output
errors/warnings, invalid-input and multi-client coverage where relevant,
performance/device consideration, asset provenance, updated docs/changelog,
and the mandatory hito report from the master prompt.

Use the master prompt response shape:

```text
ESTADO:
OBJETIVO:
DECISIONES:
TAREAS POR AGENTE:
ENTREGABLE:
CRITERIOS DE ACEPTACIÓN:
PRUEBAS Y EVIDENCIA:
RIESGOS/BLOQUEOS:
SIGUIENTE ACCIÓN:
```
