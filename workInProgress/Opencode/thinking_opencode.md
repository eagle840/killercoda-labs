# Controlling Thinking vs. Direct Code Generation in OpenCode

Two independent knobs are involved, which is why this feels muddy:

1. **Reasoning** ("thinking") — a property of the model and its variant.
2. **Tool use** — the agent loop (`read`, `grep`, `shell`, `execute`, ...).

Turning thinking down does **not** stop command-running and exploration. You have to
restrict tools separately.

## Fast switching in the TUI

| Action | Default binding |
| --- | --- |
| Cycle model variants (e.g. `#none` → `#low` → `#high`) | `ctrl+t` |
| List variants | `variant.list` (unbound by default) |
| Model picker (`provider/model#variant`) | `ctrl+x m` or `/models` |
| Cycle agents (`build` → your `writer`) | `shift+tab` |
| Show/hide thinking blocks (display only) | `session.toggle.thinking` (unbound) |

`/models` selections are per-session and do not touch config.

Variants are where "thinking off" lives: a model only offers `#none` if its catalog
metadata says it can toggle reasoning off.

## Permanent setup: a "just write the code" agent

This is the part that actually stops the command-running. Create
`~/.config/opencode/agents/writer.md` (global) or `.opencode/agents/writer.md`
(per project):

```md
---
description: Generates code directly without exploring or executing anything
mode: primary
model: anthropic/claude-sonnet-5-5#none
permissions:
  - { action: "shell", resource: "*", effect: "deny" }
  - { action: "execute", resource: "*", effect: "deny" }
  - { action: "webfetch", resource: "*", effect: "deny" }
  - { action: "websearch", resource: "*", effect: "deny" }
  - { action: "subagent", resource: "*", effect: "deny" }
  - { action: "question", resource: "*", effect: "deny" }
  - { action: "glob", resource: "*", effect: "deny" }
  - { action: "grep", resource: "*", effect: "deny" }
  - { action: "read", resource: "*", effect: "deny" }
  - { action: "edit", resource: "*", effect: "allow" }
---

Generate the requested code directly. Do not explore the repository, search for
references, run commands, or verify by execution. Return complete, ready-to-paste
code with minimal commentary.
```

Make it the default if you want it always:

```jsonc
// ~/.config/opencode/opencode.jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "writer"
}
```

### Notes on the pieces

- **Deny `execute`** matters: it removes Code Mode and any MCP tools reached only
  through it.
- **Deny `read` / `glob` / `grep`** is what kills the "let me look around first"
  loop. If you still want the agent to peek at one file, change `read` to `allow`
  and leave the search tools denied — a good middle ground.
- **Do not set `steps: 1`** to force brevity. On the final step OpenCode strips
  tools and asks for a text summary, so a 1-step agent cannot call `edit` at all.
- **Agent-level `request` overlays are not sent yet in V2.** Reasoning settings
  must go on the model or variant (`settings.reasoningEffort`, etc.), not the agent.

## If the model has no `#none` variant

Add the toggle (or define your own variant) in `opencode.jsonc`:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "providers": {
    "anthropic": {
      "models": {
        "claude-sonnet-5-5": {
          "capabilities": {
            "reasoning": {
              "supported": true,
              "toggle": true,
              "effort": ["low", "medium", "high"]
            }
          }
        }
      }
    }
  }
}
```

`toggle: true` adds a `none` variant. Alternatively define one explicitly:

```jsonc
"variants": [
  { "id": "instant", "settings": { "reasoningEffort": "low" } }
]
```

Then select `provider/model#instant`.

The exact "off" value is provider-specific; some providers support `none`, others
only `low` / `minimal`.

## Caveat

A variant only reduces reasoning where the provider honors it, and a weak or
non-coder model will still be worse at generating code than a coding model with
thinking off. If you want true completion behavior, the bigger lever is choosing a
non-reasoning coder model for this agent, with the tools denied above — then switch
back with `shift+tab` when you do want the full build agent.

## Sources

- Models / variants: <https://opencode.ai/v2/docs/models/>
- Agents: <https://opencode.ai/v2/docs/agents/>
- Permissions: <https://opencode.ai/v2/docs/permissions/>
- Keybinds: <https://opencode.ai/v2/docs/cli/keybinds/>
