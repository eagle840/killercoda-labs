

## Lab : DAST (Dynamic Application Security Testing)

**The Tool:** **OWASP ZAP (ZED Attack Proxy)** > ZAP is the gold standard for open-source DAST. Since Killercoda is terminal-based, you will use the **ZAP CLI** or the **ZAP Docker container** to run a baseline scan against a locally running mock application.

### Lab Structure

* **Scenario:** A vulnerable web application (like *OWASP Juice Shop* or a simple Python Flask app) is already running in the background on `localhost:5000`.
* **Step 1: Launch the DAST Scan:** The user triggers an automated ZAP baseline scan via Docker against the running app.
```bash
docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://localhost:5000 -r report.html

```


* **Step 2: Inspect the Report:** Serve the `report.html` file using a simple Python HTTP server so the user can view it via Killercoda’s built-in web preview feature.
* **Step 3: Understand the Difference:** Clear instructions explaining *why* ZAP found things SAST couldn't (like missing HTTP security headers or cookie flags that only appear when the app is actively running).



Would you like me to help you write the specific step-by-step markdown content or the `background.sh` setup script for one of these specific labs?