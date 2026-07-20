# Directory Overview

This repository is a collection of interactive learning scenarios for the [Killercoda](https://killercoda.com/) platform. Each top-level directory represents a distinct course or lab, covering technologies ranging from Docker and Kubernetes to specific applications like Apache Superset and .NET.

The scenarios are designed to be hands-on, providing users with a live terminal and guided steps to learn a specific technology or concept.

# Key Files & Structure

The structure of each scenario is defined by a set of conventional files:

*   **`index.json`**: This is the main configuration file for a scenario. It defines the title, description, difficulty, estimated time, and the virtual environment to be used (e.g., `ubuntu`, `kubernetes-kubeadm-1node`). It also orchestrates the steps of the lab, pointing to the markdown files for the introduction, steps, and finish page.

*   **`intro.md`**: A Markdown file that serves as the landing page for the scenario, providing an overview and context.

*   **`stepX.md`**: A series of numbered Markdown files that make up the body of the lab. Each file contains instructions, explanations, and code snippets for the user to execute.

*   **`finish.md`**: The concluding page of the scenario, often summarizing what was learned or providing next steps.

*   **`.sh` / asset files**: Scenarios can include shell scripts or other asset files that can be used for setup, verification, or as part of the exercises. These are defined in the `assets` section of `index.json`.

* **assets folder** /assets directory contains files  that are uploaded into the lab. But most also be included in the index.json file,
   * eg
     ```
       "details": {
            "assets":{
            "host01": [
                {
                "file": "send.py",
                "target": "~/"
    ```

*   **`CreatorGuide.md`**: This is a key file in the root of the repository that acts as a comprehensive guide for creating and structuring these Killercoda scenarios. It details the available environments, scenario syntax, how to define executable code, and other platform features.

# Agent Behavioral Guidelines

To maintain focus and efficiency, agents MUST strictly adhere to the following scope restrictions:

*   **Default Scope:** Agents are restricted to research, file reading, and file operations exclusively within the active lab subdirectory (e.g., `workInProgress/influx/`).
*   **Exceptions:** Exploration of directories outside the active lab is prohibited unless the user provides an explicit directive authorizing the agent to do so.
*   **Context usage:** Agents must avoid searching, reading, or analyzing files in other labs unless it is necessary to fulfill a specific user request and has been authorized.

# Agent Operating Protocols

To ensure transparency and high-quality lab creation, agents must adhere to the following protocols:

## 1. Communication Protocol
*   **Thinking Transparency:** Before executing a chain of 3+ tools, the agent MUST output a concise summary of the intended strategy and the specific tools/files it plans to target.
*   **Pause Points:** For high-impact operations (e.g., deleting/renaming assets, multi-file batch updates), the agent MUST stop and request explicit user confirmation before proceeding, even if the general plan was previously approved.

## 2. Lab Validation Checklist
Agents are required to perform the following verification steps before finalizing any lab implementation:
*   **`index.json` Integrity:** Validate that all files referenced in `assets` and `steps` actually exist and have correct relative paths.
*   **Asset Bundling:** Confirm that all necessary scripts, Dockerfiles, and notebooks required for the lab build are correctly mapped in `index.json`.
*   **Standard Tags:** Verify that all code blocks use the correct `{{exec}}` or `{{copy}}` markers as defined in the `CreatorGuide.md`.

4.  The file @CreatorGuide.md contains a more detailed usage for killacoda development.
5.  Version numbering of the labs is in index.json, included in the dsscription field (eg "description""Getting started with Openfeature(v0.0.1)")