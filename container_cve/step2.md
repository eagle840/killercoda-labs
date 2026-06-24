# Step 2: Visual Confirmation (HTML Report Dashboard)

While raw terminal output is useful, teams need readable, visual reports. Trivy supports custom output templates, including rich interactive HTML dashboards.

### 1. Download the Trivy HTML Template
Download the official HTML report template provided by Aqua Security:
`wget -q https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl -O /root/project/html.tpl`{{execute}}

### 2. Generate the Visual HTML Report
Scan a Python slim image (`python:3.8-slim`) and format the output into a styled HTML file using the template:
`trivy image --format template --template "@/root/project/html.tpl" -o /root/project/report.html python:3.8-slim`{{execute}}

### 3. Start a Local HTTP Server (Port 80)
We will serve the generated report using Python's built-in HTTP server module. 

Run the server in the background and wait until it is responsive:
`python3 -m http.server 80 --directory /root/project & until curl -s http://localhost:80/report.html > /dev/null; do sleep 1; done`{{execute}}

> [!NOTE]
> The above command uses a readiness check loop (`until curl ...`) to ensure the HTTP server is fully initialized before releasing control.

### 4. Open the Visual Dashboard
Now you can view the vulnerability report! Click the link below to open the dashboard:

[View Trivy Visual Report]({{TRAFFIC_HOST1_80}}/report.html)

Take a look around the interactive report. You can see detailed CVE descriptions, affected versions, severity levels, and links to official fixes.
