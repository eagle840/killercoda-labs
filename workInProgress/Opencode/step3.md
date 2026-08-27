# Step 3: Project Scaffolding & Customizing Reasoning Effort

Now we will scaffold a new project and learn how to control the AI's reasoning depth.

### 1. Scaffold an Application
Ask the agent to create a basic application:
```text
Scaffold a simple NestJS server application. Create it in a my-app folder.
```{{copy}}

During execution you'll be prompted to allow Opencode to write files

### 2. Control the Agent
* **Interrupting the agent**: If the agent is doing something you want to stop, quickly double-press the `Escape` key.
* **Adjusting reasoning**: Use the `/variance` command to set reasoning depth. (only available on some models)
  ```text
  /variance high
  ```{{copy}}
Try testing the difference in response quality when you switch between `low` and `high` variance.

In OpenCode, the built-in **`/thinking`** command is used to **toggle reasoning blocks** on or off in your chat interface.

### What it does:

* **Shows/Hides Thought Processes:** When enabled, it allows you to see the internal step-by-step reasoning or "thinking" process that models (especially advanced reasoning models) go through before generating their final response or writing code.
* **Debugging & Transparency:** It helps you understand *why* the AI agent made certain decisions or structured its code in a specific way by letting you inspect its inner monologue.

### Related Controls:

Depending on your setup or model configuration, you can also adjust thinking or reasoning depth using variant levels (such as switching between low, medium, or high thinking budgets).
