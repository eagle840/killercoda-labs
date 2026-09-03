# Step 7: Creating and Using Custom Skills

### 1. Understanding Skills
Skills are reusable instruction packages that agents can load on demand. Each skill is a folder containing a `SKILL.md` file with:
- **YAML frontmatter** (name and description)
- **Markdown instructions** (what the skill does and when to use it)

Skills are placed in `.opencode/skills/<name>/SKILL.md` for project-local use, or `~/.config/opencode/skills/<name>/SKILL.md` for global use.

---

### 2. Create a Skill from Scratch

Let's build a **System Health Check** skill that inspects your environment for common issues.

First, create the skill directory:

```bash
mkdir -p .opencode/skills/system-health-check
```{{exec}}

Now create the `SKILL.md` file:

```bash
cat > .opencode/skills/system-health-check/SKILL.md << 'EOF'
---
name: system-health-check
description: Check system health including disk, memory, Docker, and Python environment
---

## What I do
- Check disk usage and flag volumes over 80% used
- Check memory usage and flag if available memory is low
- Verify Docker daemon is running and list running containers
- Verify Python version and check for common tools
- Report any issues found

## How to run me
1. Run `df -h /` to check disk usage
2. Run `free -h` to check memory
3. Run `docker ps` to list running containers
4. Run `python3 --version` to verify Python
5. Summarize findings in a clear report

## When to use me
Use this skill when setting up a new environment or troubleshooting system issues.
EOF
```{{exec}}

Verify the file was created:

```bash
cat .opencode/skills/system-health-check/SKILL.md
```{{exec}}

---

### 3. Trigger the Skill

Open OpenCode (or restart if already running), then list available skills:

```text
/skills
```{{copy}}

You should see `system-health-check` in the list. Select it to load the skill.

---

### 4. Run the Health Check

With the skill loaded, ask the agent to perform the check:

```text
Run the system health check
```{{copy}}

The agent will follow the skill's instructions and produce a report like:

```
System Health Report:
- Disk: 45% used (OK)
- Memory: 2.1GB available (OK)
- Docker: running, 0 containers
- Python: 3.12.3 (OK)
All checks passed.
```

---

### 5. Skill Format Reference

Every `SKILL.md` follows this structure:

```markdown
---
name: skill-name-here
description: Short description for the agent to decide when to load this skill
---

## What I do
- Bullet points describing capabilities

## When to use me
- Description of trigger conditions
```

**Rules:**
- `name`: lowercase alphanumeric with single hyphens (e.g., `my-skill`)
- `description`: 1-1024 characters
- The folder name must match the skill name
- Skills are discovered automatically from `.opencode/skills/`
