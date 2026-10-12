# latest notes on opencode


## New V2 version

It is now in V2, where it looks like it has an API/server running on the backend

## Sessions

You can open sessions with the `opencode session` command, inc list, export, delete

## Debug

- `opencode debug paths` shows the verious paths/files it uses
- Sqllite holds session data, but don't mess with it
- to fully reset, either totally remove opencode and reinstall, or `rm -rf ~/.local/store/opencode`

## upgrade

`opencode --version`
`opencode upgrade`
but don't mix the install types (eg curl, vs apt)

## using opencode api

add a step for useing   the api, perhaps mixed in with the server

## mini interface

you can use `opencode mini` 

## opening a project

you can use `opencode ~/my-project`

## /instructions

you can create a `~/.config/opencode/commands/intructions.md` file
to run the `/instructions` in opencode

eg of instructions.md
```
---
description: print the loaded AGENTS.md instructions files
---
Print the current agent instructions. The loaded AGENTS.md files are:
!"cat ~/.config/opencode/AGENTS.md 2>dev/null; echo '=== project ===', cat AGENTS.md .opencode/AGENTS.md 2>dev/null"

```

When creating Agents consider TSEB (shaping the personality)
- Tone: formal, casual, friendly, technical
- Style: Brief, detailed, structured, conversional
- Expertise: Domain knowledge and specization
- Behavior: How to respond to queiries