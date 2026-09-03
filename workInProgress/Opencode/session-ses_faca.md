# AI agents vs skills configuration

**Session ID:** ses_facace02affePNMWcqZmaFCE6R
**Created:** 8/30/2026, 3:39:11 PM
**Updated:** 8/30/2026, 3:39:18 PM

---

## User

in the world of AI coding agents, what is the difference between agents and skills, and how the programmer can configure them (isn't it through config files?) Give examples

---

## Assistant (Plan · Big Pickle · 6.5s)

This is an informational question, so let me answer it directly. This is a conceptual question about AI coding agents (like opencode, Codex, Claude Code, Cursor, etc.).

## Agents vs. Skills

**Agents (or subagents)** are distinct AI personas/runtime configurations that define *who* is working and *how* it behaves*. Each agent has:
- A **role/persona** (its system prompt / instructions)
- Its own set of **tools** it's allowed to use
- Its own **model** (optional)
- Its own **permissions** (what it can and can't do)

You delegate to an agent — it's a separate worker with its own behavior. Example: a "reviewer" agent that only reads code, vs. a "coder" agent that edits files.

**Skills** are packaged *instructions + reference resources* that an agent can load on demand to perform a specific well-defined task. A skill is essentially:
- A markdown/instructions file describing how to do the task
- Often bundled with **scripts, templates, tools, or reference docs**
- Loaded ("injected") into context only when relevant — like a playbook

The key distinction: **an agent is a worker with a persistent identity**, while **a skill is a reusable capability/knowledge package you hand to a worker when needed.** Agents decide *when* to use skills.

## How they're configured

Yes — both are typically configured via **config files** (JSON/YAML/TOML + supporting folders), not code. Here's a breakdown using common conventions across tools (opencode, Claude Code, Cursor, Codex, etc.):

### Agents — config files
Defined in a config file (e.g., `opencode.json`, `.cursor/rules/`, `AGENTS.md`, or subagent folders). Example (opencode-style):

```jsonc
// opencode.json
{
  "agent": {
    "reviewer": {
      "description": "Reviews code for bugs and style",
      "prompt": "You are a senior engineer. Review the diff critically...",
      "tools": {
        "read": true,
        "bash": false
      },
      "model": "claude-sonnet"
    }
  }
}
```

Or Claude Code subagents as `.claude/agents/reviewer.md`:
```
---
name: reviewer
description: Reviews code changes for correctness
tools: Read, Glob, Grep
---

You are a senior code reviewer...
```

### Skills — config files + folders
Defined as directories containing an `SKILL.md` (instructions) plus optional supporting files. Example (opencode/skill style):

```
.skills/debug-server/
├── SKILL.md          # instructions on how to debug the server
├── checklist.md      # reference resource
└── scripts/verify.sh # bundled tool
```

`SKILL.md` frontmatter:
```
---
name: debug-server
description: Use when debugging a failing dev server
---

1. Check logs at ...
2. Run: ./scripts/verify.sh
```

The agent's own config links to skills it can load.

### Convention vs. code
- **Agents** = identity config (prompt, tools, model, permissions) → config files
- **Skills** = instruction/knowledge packages → folders with `SKILL.md` + resources
- Both belong in the project's `.config`/`.claude`/`.cursor` subfolders or the user's global config dir

The user's project config (like `AGENTS.md`) further shapes how all agents behave.

---

Since I'm in plan mode and this was a purely informational question, there's nothing to implement. Do you want me to either (a) look at opencode's specific agent/skill config format in your environment, or (b) scaffold an example agent + skill config for your project?

---

