

## Lab : SCA (Software Composition Analysis)

**The Tool:** **OWASP Dependency-Check** or **Trivy**

> *Note on Choice:* Since Dependabot is tied to GitHub's ecosystem and Black Duck is commercial, **Trivy** (by Aqua Security) or **OWASP Dependency-Check** are your best open-source CLI alternatives. Trivy is highly recommended for labs because it is incredibly fast and scans `package.json`, `Gemfile.lock`, `Pipfile`, etc., instantly.

### Lab Structure

* **Scenario:** A developer wants to push an app to production, but the `package.json` file is using an ancient, vulnerable version of a popular library (like `lodash` or `express`).
* **Step 1: Scan Dependencies:** The user runs Trivy against the project directory.
```bash
trivy fs .

```


* **Step 2: Hunt the CVEs:** The user reviews the output table displaying the CVE identifiers, severity levels (Critical/High), and whether a fixed version exists.
* **Step 3: Remediate:** The user updates the vulnerable package in the package file, runs `npm install` (or equivalent), and rescans to verify the critical vulnerabilities are gone.

