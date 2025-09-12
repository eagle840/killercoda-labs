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

*   **`CreatorGuide.md`**: This is a key file in the root of the repository that acts as a comprehensive guide for creating and structuring these Killercoda scenarios. It details the available environments, scenario syntax, how to define executable code, and other platform features.

# Usage

The contents of this repository are used by the Killercoda platform. To use or develop these scenarios:

1.  A GitHub repository containing scenarios like this one is linked to a Killercoda creator profile.
2.  When a user starts a scenario, Killercoda reads the `index.json` and the associated markdown files to build the interactive lab environment.
3.  Updates to the scenarios are made by pushing changes to the linked GitHub repository branch.
