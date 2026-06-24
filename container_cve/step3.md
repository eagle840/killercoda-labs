# Step 3: SCA & Configuration Scan

Trivy isn't just for built container images. It can also perform **Software Composition Analysis (SCA)** to scan source code dependencies, and audit configuration files like Dockerfiles for security misconfigurations.

We have pre-loaded a mock project in `/root/project` for you to inspect.

### 1. Switch to the Project Directory
Navigate to the directory containing our project files:
`cd /root/project`{{execute}}

### 2. Software Composition Analysis (SCA)
Look at the project's dependencies defined in the package manager file:
`cat package.json`{{execute}}

It uses older versions of `lodash` (`4.17.15`) and `express` (`4.15.2`). Let's run a filesystem scan to detect vulnerable libraries:
`trivy fs .`{{execute}}

Notice the output: Trivy identifies vulnerable packages, lists their corresponding CVE identifiers, and shows the fixed versions available.

### 3. Dockerfile Configuration Scan
Now, look at the project's container specification:
`cat Dockerfile`{{execute}}

It uses an outdated Ubuntu image (`ubuntu:18.04`) and explicitly configures container processes to run as `USER root`.

Audit this configuration file for security vulnerabilities:
`trivy config .`{{execute}}

You will see several misconfigurations flagged, such as:
* **`AVD-DS-0002` (or KSV012):** Dockerfile has no `USER` specified or explicitly runs as root.
* **`AVD-DS-0001` (or KSV013):** Outdated base image risks.

In the next step, we will integrate these checks into an automated build pipeline!
