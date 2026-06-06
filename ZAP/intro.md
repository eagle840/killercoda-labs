# Introduction to Dynamic Application Security Testing (DAST) with OWASP ZAP

Welcome to this hands-on lab on Dynamic Application Security Testing! In this scenario, you will learn how to use **OWASP ZAP (Zed Attack Proxy)**, a world-class open-source tool for finding vulnerabilities in web applications.

Unlike Static Analysis (SAST), which looks at source code, **DAST** tests the application while it is running. This allows it to find issues that only appear at runtime, such as misconfigured headers, insecure cookies, and complex injection vulnerabilities.

### What you will do:
1. **Deploy a Target:** Launch the OWASP Juice Shop, an intentionally insecure web application.
2. **Baseline Scanning:** Perform a quick automated scan using ZAP's Docker-packaged scripts.
3. **Interactive Testing:** Use the ZAP Web UI (via Webswing) to explore alerts.
4. **API Automation:** Learn how to control ZAP programmatically using its REST API.

Let's get started by setting up our vulnerable target!
