# Automated Baseline Scanning

The fastest way to use ZAP in a CI/CD pipeline or for a quick health check is through its **Packaged Scans**. These are Python scripts that wrap ZAP's functionality into a single command.

## 1. Prepare Report Directory
By default, the ZAP Docker container runs as the `zap` user (UID 1000). To ensure ZAP can write the scan report to our host machine, we need to create a directory and grant it open permissions.

`mkdir -p $(pwd)/zap-reports && chmod 777 $(pwd)/zap-reports`{{exec}}

## 2. Run the Baseline Scan
The **Baseline Scan** (`zap-baseline.py`) runs the passive scanner against a target. It does not perform any "attacking" (active) scans, making it safe for production environments.

We will mount our `zap-reports` directory to `/zap/wrk/` inside the container. This is the conventional path ZAP uses for input/output files.

`docker run --net=host -v $(pwd)/zap-reports:/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t http://localhost:3000 -r  baseline-report.html`{{exec}}

### Key Flags used:
- `-v $(pwd)/zap-reports:/zap/wrk/:rw`: Mounts our local directory into the container.
- `-t http://localhost:3000`: Specifies the target URL (our Juice Shop).
- `-r baseline-report.html`: Tells ZAP to generate an HTML report with this name.

## 3. View the Report
Since we are in a terminal-only environment, we will use Python to serve the HTML report so you can view it in your browser.

`python3 -m http.server 8000 --directory ./zap-reports`{{exec}}

Once the server is running, open the report using the port 8000 link:

{{TRAFFIC_HOST1_8000}}/baseline-report.html

## Common CLI Options
ZAP's packaged scans support several useful flags you might want to explore later:
- `-m`: The number of minutes to spider.
- `-j`: Use the AJAX spider (useful for heavy JavaScript apps like Juice Shop).
- `-a`: Include alpha (experimental) passive scan rules.
- `-J`: Output report in JSON format.
- `-x`: Output report in XML format.

Press `CTRL+C` to stop the Python server when you are done reviewing the report, then click **Continue**.
