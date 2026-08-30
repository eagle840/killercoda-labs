# Step 6: Defining Project-Wide Rules with `agents.md`

### 1. Understanding Agents
Agents (or subagents) are distinct AI personas/runtime configurations that define *who* is working and *how* the agent behaves. Each agent has:
- A **role/persona** (system prompt)
- Its own set of **tools**
- Its own **model** (optional)
- Its own **permissions**

In this step, we configure project-level rules using `agents.md` to define these behaviors for our project.

### 2. Initialize Configuration
Generate a project-level configuration file:

Lets move into the `my-app`folder (project)

```text
!cd my-app
```{{copy}}

WIP: looks like you need to exit Opencode, change folder, and relauch opencode


```text
/init
```{{copy}}

### 3. Add Constraints
Edit the generated `agents.md` file to add custom instructions. For example, you can force the agent to always use emojis in its replies:

```markdown
Constraint: Always use emojis in your responses.
```{{copy}}
