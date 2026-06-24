# Step 4: CI/CD Gates & Automation

In production environments, security scans are automated. If a developer introduces a critical vulnerability, the build pipeline must automatically fail to prevent it from reaching production.

Trivy supports build-gating using exit codes (e.g., `--exit-code 1 --severity HIGH,CRITICAL`).

### 1. View the Build Script
Let's inspect the simple build pipeline simulation script:
`cat /root/project/build.sh`{{execute}}

It runs `trivy config` and `trivy fs` scans. If either scan finds `HIGH` or `CRITICAL` issues, it returns exit code `1`, halting the build.

### 2. Run the Build Script
Make the script executable and run it:
`chmod +x /root/project/build.sh`{{execute}}

`/root/project/build.sh`{{execute}}

The build immediately fails at Step 1 (`trivy config`) because of the Dockerfile security misconfigurations!

### 3. Handle Exceptions with `.trivyignore`
Sometimes, security teams approve a specific risk or false-positive. Trivy allows ignoring specific issues using a `.trivyignore` file.

Let's tell Trivy to temporarily ignore the missing non-root user configuration check (`AVD-DS-0002`):
```bash
cat << 'EOF' > /root/project/.trivyignore
# Ignore Dockerfile USER root check
AVD-DS-0002
EOF
```{{execute}}

### 4. Run the Build Script Again
Test the build script again:
`/root/project/build.sh`{{execute}}

The Dockerfile configuration scan now **succeeds** (bypassed via `.trivyignore`). However, the build **still fails** at Step 2 because of the vulnerable packages in `package.json` (`lodash` and `express`).

In the final step, we will remediate these vulnerabilities to make the build pass!
