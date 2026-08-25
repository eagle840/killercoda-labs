# Step 3: Project Scaffolding & Customizing Reasoning Effort

Now we will scaffold a new project and learn how to control the AI's reasoning depth.

### 1. Scaffold an Application
Ask the agent to create a basic application:
```text
Scaffold a simple NestJS server application.
```{{copy}}

### 2. Control the Agent
* **Interrupting the agent**: If the agent is doing something you want to stop, quickly double-press the `Escape` key.
* **Adjusting reasoning**: Use the `/variance` command to set reasoning depth.
  ```text
  /variance high
  ```{{copy}}
Try testing the difference in response quality when you switch between `low` and `high` variance.
