# Gemini CLI: Lab Planning Pointers

These pointers were developed during the refactoring of the ZAP DAST lab to ensure future labs are structured, robust, and educational.

## 1. Build a "Learning Ladder" (The Progression)
Avoid jumping straight into complex configurations. Follow a logical difficulty curve:
*   **Setup:** Deploy the target and verify it's working.
*   **The "Easy Win":** Use the simplest, most automated version of the tool (e.g., packaged one-liner scans).
*   **Visual Confirmation:** Use a GUI or Web interface (e.g., Webswing) to help the user visualize what is happening.
*   **Professional Automation:** Move to the advanced "real-world" methods (e.g., Daemon mode, REST APIs).

## 2. Anticipate "Platform Friction" (The Guardrails)
Most lab failures happen due to environmental factors like slow service startup or container networking isolation.
*   **Readiness Checks:** Always include `until` loops to wait for services to be responsive before the next step.
*   **Networking:** Be mindful of `localhost` inside containers versus the host. Use `--net=host` when appropriate.
*   **Permissions:** Ensure Docker volume mounts have the correct permissions (e.g., `chmod 777` for shared report directories).

## 3. Use "Preservation & Redistribution"
When refactoring, ensure that valuable technical insights, documentation, or useful diagrams (like ASCII art layouts) are not lost in the quest for a "cleaner" structure.
*   **Inventory:** List the "golden nuggets" of information from your draft versions.
*   **Redistribute:** Find the most logical home for each piece of information in the new structured flow.
*   **Consistency:** Standardize ports, paths, and naming across all steps to reduce cognitive load on the user.
