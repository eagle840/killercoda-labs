I have analyzed the OpenCode video tutorial and created a comprehensive, ready-to-use step-by-step guide formatted in Markdown. You can easily integrate these steps directly into your Killercoda lab to help users comprehensively explore OpenCode's advanced features.

The generated file **`killercoda-opencode-lab.md`** has been published to your Studio panel and contains the following lab steps:

*   **Step 1: Launch OpenCode and Connect a Free Model** – Teaches users how to run the `opencode` command, initiate a `/connect` session, choose the **OpenCode Zen** tier, and select a free model like **deepc4 flash free**.
*   **Step 2: Project Scaffolding & Customizing Reasoning Effort** – Walks through scaffolding a server application (such as NestJS), using a double-click of the `Escape` key to interrupt the agent mid-task, and adjusting model reasoning depths (from low to extreme high) with `/variance`.
*   **Step 3: Plan Mode vs. Build Mode & Parallel Sessions** – Guides users through switching from Build Mode to **Plan Mode** using `Shift + Tab` to safely review architectural changes, utilizing `/new` to initiate clean contexts, and managing parallel workflows via the `sessions` switcher command.
*   **Step 4: Timeline Rollbacks, Sharing, and Exporting** – Explains how to inspect history with `/timeline` to undo changes or fork a new session branch, export chats to Markdown via `export`, and generate shareable HTML URLs with `/share` and `unshare`.
*   **Step 5: Defining Project-Wide Rules with `agents.md`** – Teaches the use of `/init` to generate a project-level configuration file, and adding custom behavioral constraints (such as forcing the agent to always use emojis in its replies).
*   **Step 6: Installing Custom Skills from Skills.sh** – Introduces the concept of skills (SOPs/workflows), installing them from `skills.sh` directly within the active CLI, confirming permission prompts, and triggering them via `/skills` after a quick application restart.

The interactive terminal commands and clear prompt examples in this document are fully structured so that your Killercoda users can explore OpenCode's free model capabilities on their own!

🔧 Would you like me to add a step to this lab that demonstrates how to configure and run local offline models inside OpenCode?