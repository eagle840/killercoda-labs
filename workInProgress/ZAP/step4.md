# ZAP API Automation & Daemon Mode

In a fully automated CI/CD pipeline, you won't use a GUI or even the simplified packaged scripts. You will interact directly with the **ZAP REST API**.

## 1. Start ZAP in Daemon Mode
**Daemon mode** runs ZAP in the background without a UI. We must configure it to allow API connections from our host.

```
docker run -d --net=host --name zap-daemon -u zap ghcr.io/zaproxy/zaproxy:stable zap.sh \
 -daemon -host 0.0.0.0 -port 8080 \
 -config api.disablekey=true \
 -config api.addrs.addr.name=.* \
 -config api.addrs.addr.regex=true
```{{exec}}

## 2. Wait for ZAP to Initialize
ZAP is a Java application and can be resource-intensive during startup. Run this command to wait until the ZAP API is fully ready:

`until $(curl --output /dev/null --silent --head --fail http://localhost:8080); do printf '.'; sleep 5; done && echo "ZAP API is READY!"`{{exec}}

Once you see "ZAP API is READY!", you can proceed with the automation.

Check the ZAP version to confirm:

`curl -s http://localhost:8080/JSON/core/view/version/ | jq`{{exec}}

## 3. The "Scan Tree" Workflow
The most common mistake with the ZAP API is trying to "Active Scan" a URL that ZAP hasn't seen yet. ZAP will return a `url_not_found` error. 

To fix this, you must follow this sequence: **Context Setup -> Spider -> Active Scan**.

### A. Create a Context
A **Context** groups related URLs together. Let's create one for Juice Shop.

`curl -s "http://localhost:8080/JSON/context/action/newContext/?contextName=JuiceShop" | jq`{{exec}}

Include our target in this context using a Regex:

`curl -s "http://localhost:8080/JSON/context/action/includeInContext/?contextName=JuiceShop&regex=http://localhost:3000/.*" | jq`{{exec}}

### B. The Spider (Required)
The Spider crawls the application to discover its structure and populate the **Scan Tree**.

`curl -s "http://localhost:8080/JSON/spider/action/scan/?url=http://localhost:3000&contextName=JuiceShop" | jq`{{exec}}

Monitor the spider status (wait for it to reach 100):

`curl -s "http://localhost:8080/JSON/spider/view/status/" | jq`{{exec}}

### C. The Active Scan
Now that the Scan Tree is populated, we can trigger the Active Scan (the "Attack" phase).

`curl -s "http://localhost:8080/JSON/ascan/action/scan/?url=http://localhost:3000&contextName=JuiceShop" | jq`{{exec}}

Monitor the attack progress:

`curl -s "http://localhost:8080/JSON/ascan/view/status/" | jq`{{exec}}

## 3. Retrieve Results
Once the scan reaches 100%, you can pull the alerts in JSON format:

`curl -s "http://localhost:8080/JSON/core/view/alerts/?baseurl=http://localhost:3000" | jq`{{exec}}

Or generate a full HTML report:

`curl -s "http://localhost:8080/OTHER/core/other/htmlreport/" -o zap_api_report.html`{{exec}}

You can serve this report using the Python method we learned in Step 2 if you wish to view the results of your automated run.

Click **Continue** to finish the lab.
