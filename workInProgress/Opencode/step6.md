# Step 6: Defining Project-Wide Rules with `agents.md`

You can define custom behaviors for the agent at the project level.

### 1. Initialize Configuration
Generate a project-level configuration file:
```text
/init
```{{copy}}

### 2. Add Constraints
Edit the generated `agents.md` file to add custom instructions. For example, you can force the agent to always use emojis in its replies:

```markdown
Constraint: Always use emojis in your responses.
```{{copy}}
