# Updated ZAP Lab Plan

## Goal
Deliver a clean, functional Killercoda lab for OWASP ZAP DAST testing against OWASP Juice Shop.

## Checklist

### Phase 1: Cleanup & Metadata
- [x] **Task 1.1: Remove Ghost Assets.** Strip RabbitMQ scripts from `index.json`.
- [x] **Task 1.2: Fix Intro.** Update `intro.md` to reflect ZAP content instead of Docker installation.
- [x] **Task 1.3: Consistency Check.** Ensure all files use port 3000 for Juice Shop and consistent volume paths.

### Phase 2: Implementation
- [x] **Task 2.1: Step 1 - Target Setup.** 
    - Pull and run Juice Shop in the background.
    - Add health check to ensure it's up before the user proceeds.
    - Brief intro to the "Vulnerable Target".
- [x] **Task 2.2: Step 2 - The Baseline Scan.**
    - Run `zap-baseline.py` via Docker.
    - Fix volume permission issues (ensure the host directory is writable by the `zap` user).
    - Serve `report.html` using `python3 -m http.server`.
- [x] **Task 2.3: Step 3 - Interactive ZAP.**
    - Launch `zap-webswing.sh`.
    - Provide instructions on accessing the Web UI via Killercoda's traffic ports.
    - Guide user to run a simple "Quick Start" scan in the UI.
- [x] **Task 2.4: Step 4 - API Automation & Daemon Mode.**
    - Launch ZAP in **Daemon mode** (`-daemon`).
    - Fix the "URL Not Found in Scan Tree" issue by implementing the **Spider -> Ascan** workflow.
    - Use `curl` to interact with the API.
    - Export report via API.

### Phase 3: Finalization
- [x] **Task 3.1: Conclusion.** Update `finish.md` with a summary of DAST vs SAST.
- [ ] **Task 3.2: Verification.** Dry run all commands to ensure they work in the Killercoda environment.

## Preservation Notes (Don't Lose These!)
- **From old Step 2:** Webswing layout, ZAP Modes (Safe/Protected/Attack), and the concept of 'Context'.
- **From old Step 3:** CLI flags (m, a, j) and report formats (r, J, x, w).
- **From old Step 4:** Detailed Context API calls and Regex inclusion rules.

