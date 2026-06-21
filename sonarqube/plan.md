# Plan: SonarQube Lab Improvements

This plan outlines the steps to refine and complete the SonarQube interactive lab.

## Phase 1: Cleanup & Environment Optimization
- [x] 1.1 - **Consolidate Steps**: Merge `step1.md`/`step1old.md` and `step2.md`/`step2old.md` into clean, single-source files.
- [x] 1.2 - **Remove Legacy Files**: Delete `step1old.md`, `step2old.md`, and `notes.txt` once merged.
- [x] 1.3 - **Streamline Git Setup**: Choose the most reliable Git setup method and remove redundant "short/long" versions.
- [x] 1.4 - **Clarify Requirements**: Ensure the `sysctl` command for `vm.max_map_count` is at the very beginning of Step 1.

## Phase 2: Automation
- [x] 2.1 - **Automate Scanner Setup**: Replace manual `nano` edits with `sed` or `cat` commands to configure `sonar-scanner.properties`.
- [x] 2.2 - **Download Automation**: Ensure `sonar-scanner` is downloaded and added to `PATH` automatically via executable snippets.
- [x] 2.3 - **Health Checks**: Use `curl` in a loop or a clear instruction to wait for SonarQube to be ready before proceeding.

## Phase 3: Content Completion & Verification
- [x] 3.1 - **Refine Step 2 (Analysis)**: Ensure the Python project setup is robust and the `pysonar` (or `sonar-scanner`) execution is clearly explained.
- [x] 3.2 - **Flesh out Step 3**: Add concrete instructions for creating a Quality Gate and exploring the Marketplace.
- [ ] 3.3 - **Finish Page**: Write a proper summary in `finish.md`.
- [ ] 3.4 - **Index Metadata**: Update `index.json` versioning to `v1.0.0` and ensure the description is professional.

## Phase 4: Validation
- [ ] 4.1 - **Verify UI Access**: Ensure `{{TRAFFIC_HOST1_9000}}` is used correctly.
- [ ] 4.2 - **Test Workflow**: Walk through the lab to ensure the "code smell" is correctly detected.
