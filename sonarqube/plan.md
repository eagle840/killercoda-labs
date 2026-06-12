# Plan: SonarQube Lab Improvements

This plan outlines the steps to refine and complete the SonarQube interactive lab.

## Phase 1: Cleanup & Environment Optimization
- [ ] 1.1 - **Remove Redundant Docker Setup**: Strip out `apt-get remove/install` for Docker in `step1.md` since it's pre-installed on Killercoda.
- [ ] 1.2 - **Streamline Git Setup**: Ensure the local Git server setup is concise and works reliably for the user.
- [ ] 1.3 - **Clarify Requirements**: Ensure the `sysctl` command for `vm.max_map_count` is prominently featured and explained.

## Phase 2: SonarQube & Scanner Configuration
- [ ] 2.1 - **Resolve WIP Startup**: Finalize the `docker compose` commands in `step1.md`.
- [ ] 2.2 - **Scanner Automation**: Replace the `WIP` manual `nano` edit for `sonar-scanner.properties` with a more automated approach (e.g., `sed` or `cat >>`).
- [ ] 2.3 - **Verify Path**: Ensure the `sonar-scanner` binary is correctly added to the path for subsequent steps.

## Phase 3: Analysis Workflow (Step 2)
- [ ] 3.1 - **Refine Python Project**: Ensure the Flask application setup is robust and easy to follow.
- [ ] 3.2 - **Fix WIP Profile**: Resolve the `WIP` regarding quality profiles in the scanner configuration.
- [ ] 3.3 - **Validate Code Smell**: Ensure the "pass" statement correctly triggers a code smell in SonarQube as intended.

## Phase 4: Advanced Features (Step 3)
- [ ] 4.1 - **Implement Quality Gates**: Add a step-by-step guide on creating and applying a Quality Gate in the SonarQube UI.
- [ ] 4.2 - **Plugin Exploration**: Briefly explain how to access the Marketplace and why plugins are useful.

## Phase 5: Finalization
- [ ] 5.1 - **Complete Finish Page**: Write a summary of key takeaways in `finish.md`.
- [ ] 5.2 - **Metadata Update**: Update `index.json` versioning and descriptions if necessary.
- [ ] 5.3 - **Legacy Cleanup**: Remove `step1old.md` and `step2old.md` once they are no longer needed.
