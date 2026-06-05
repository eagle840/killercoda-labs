# Congratulations!

You have successfully completed the OWASP ZAP DAST lab. You've progressed from a simple one-liner baseline scan to full programmatic control via the ZAP API.

## Summary of Learning
In this lab, you learned:
1. **Target Setup:** How to deploy and verify a vulnerable web application (Juice Shop).
2. **Packaged Scans:** Using `zap-baseline.py` for quick, non-invasive automated testing.
3. **Interactive Testing:** Navigating the ZAP GUI via Webswing and understanding scan modes.
4. **API Automation:** Controlling ZAP in **Daemon mode** and following the mandatory **Spider -> Active Scan** workflow to avoid common pitfalls.

## DAST vs. SAST: Why Both?

While this lab focused on **DAST (Dynamic Analysis)**, it's important to understand how it fits into the broader security lifecycle alongside **SAST (Static Analysis)**:

| Feature | SAST (Static) | DAST (Dynamic) |
| :--- | :--- | :--- |
| **Analyzes** | Source Code / Binaries | Running Application |
| **Stage** | Development / Build | Test / Production |
| **Best For** | Code logic, hardcoded secrets | Config issues, runtime headers |
| **View** | "Inside-out" (White-box) | "Outside-in" (Black-box) |

**Dynamic testing** excels at finding vulnerabilities that only exist when the app is running—such as missing HTTP security headers, insecure session management, and server misconfigurations—which a code scan might never see.

For the most secure application, always use a combination of both!

## Next Steps
- Explore more [ZAP Add-ons](https://www.zaproxy.org/addons/) in the marketplace.
- Integrate ZAP into your CI/CD pipelines (GitHub Actions, Jenkins, etc.).
- Practice against other targets in the [OWASP Vulnerable Web Applications Directory](https://owasp.org/www-project-vulnerable-web-applications-directory/).

Well done!
