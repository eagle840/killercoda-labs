# Killercoda Scenarios Workspace Rules

This workspace contains interactive learning scenarios for the [Killercoda](https://killercoda.com/) platform.

## 1. Directory Overview & Key Files

Each top-level directory represents a distinct course or lab (e.g., Docker, Kubernetes, Apache Superset, .NET). The structure of each scenario is defined by standard files:

*   **`index.json`**: Main configuration file (title, description, difficulty, estimated time, backend environment, uilayout, step markdown mapping, and assets).
*   **`intro.md`**: Landing page showing overview and context before starting.
*   **`stepX.md`**: Step instructions containing explanations and executable commands (e.g. `` `command`{{execute}} ``).
*   **`finish.md`**: Concluding page summarizing what was learned.
*   **`assets/`**: Local directory for static files/assets uploaded to the lab environment. Assets must also be mapped in `index.json` under `details.assets.host01`.
*   **`CreatorGuide.md`**: Reference guide for scenarios, environments, and syntax in the workspace root.

## 2. Scenario Versioning Rule
*   Lab versions should be declared inside `index.json`'s `description` field in the format `(vX.Y.Z)` (e.g., `"description": "Scan a container image for cve's with trivy(v1.2)"`).

## 3. Lab Design & Planning Guidelines

All new labs and lab refactorings must adhere to the following principles:

### A. The "Learning Ladder" (Progression)
Follow a logical difficulty curve instead of introducing complex configurations immediately:
1.  **Setup:** Deploy the target components and verify they are up and running.
2.  **The "Easy Win":** Run the simplest, most automated version of the tool (e.g., basic CLI commands or one-liners).
3.  **Visual Confirmation:** Use GUI/Web interfaces (e.g., Webswing or local web page endpoints) to help the user visualize what is happening.
4.  **Professional Automation:** Complete the lab with advanced/real-world methods (e.g., daemon mode, integrations, REST APIs).

### B. Handle Platform Friction (Guardrails)
To prevent failures due to slow startup or networking:
*   **Readiness Checks:** Use loop checks (e.g., `until curl -s ...; do sleep 1; done`) to block the user or wait until services are responsive before running subsequent commands.
*   **Networking:** Avoid assumption of `localhost` mapping between host and container. Use `--net=host` when appropriate.
*   **Permissions:** Set proper file permissions (e.g., `chmod 777` on shared logs or volume mounts) to avoid access permission errors during execution.

### C. Information Preservation
Do not discard valuable technical explanations, diagrams, or helper scripts when cleaning up draft scenarios. Redistribute them logically into markdown steps or standard asset files.
