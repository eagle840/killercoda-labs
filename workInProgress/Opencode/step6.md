# Step 6: Defining Agents & Project Rules

In this step, we'll learn how to customize OpenCode's behavior, both for specific tasks (using **Subagents**) and for the entire project (using **Project Rules**).

### 1. Creating Specialized Subagents
Subagents are task-specific helpers defined by Markdown files. This keeps your prompts organized and modular.

1. Create the agents directory:
   ```bash
   mkdir -p .opencode/agents
   ```{{exec}}

2. Create a "reviewer" subagent:
   ```bash
   cat > .opencode/agents/reviewer.md << 'EOF'
   ---
   name: reviewer
   description: Reviews code changes for correctness and style
   tools: Read, Glob, Grep
   ---

   You are a senior code reviewer. Your goal is to review code critically,
   spotting bugs, performance issues, and ensuring style compliance.
   EOF
   ```{{exec}}

3. Use the subagent in OpenCode:
   ```text
   @reviewer Please review the changes in main.ts
   ```{{copy}}

---

### 2. Setting Project-Wide Rules (`AGENTS.md`)
While agents handle specific *tasks*, **`AGENTS.md`** establishes persistent, project-wide standards that *all* agents must follow.

1. Initialize project rules:
   ```bash
   /init
   ```{{copy}}

2. Edit `.opencode/AGENTS.md` (or just `AGENTS.md` in the root) to set constraints:
   ```markdown
   # Project Standards
   - Always use TypeScript for new files.
   - For every change, run `npm test` before finalizing.
   - Always document public APIs using TSDoc.
   ```{{copy}}

### Best Practices
- **Agents (`.opencode/agents/`)**: Use these for *who* does the task (persona, permissions, specific tools).
- **Rules (`AGENTS.md`)**: Use these for *how* the work is done (code style, testing requirements, architectural constraints).
- **Global Rules**: Use `~/.config/opencode/AGENTS.md` if you have standards that apply to *all* your projects.
