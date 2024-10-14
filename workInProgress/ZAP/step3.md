# Step 3



When setting up OWASP ZAP for the first time to scan a single URL like http://www.example.com, you need to configure the ZAP context, add the URL to the context, and then initiate the scan. Here's a step-by-step guide on how to do this, including the necessary curl commands:

1. **Start OWASP ZAP Docker Container**:
   First, ensure that your OWASP ZAP server is running in a Docker container. You can start the container using the following command:
   ```bash
   docker run -u zap -p 8080:8080 -i owasp/zap2docker-stable zap.sh -daemon -host 0.0.0.0 -port 8080 -config api.disablekey=true
   ```{{execute}}

2. **Create a New Context**:
   Use the following curl command to create a new context named "Example Context":
   ```bash
   curl -X POST http://localhost:8080/JSON/context/action/newContext/ -d 'contextName=Example Context'
   ```{{execute}}

3. **Add URL to the Context**:
   Add the URL http://www.example.com to the "Example Context" using the following curl command:
   ```bash
   curl -X POST http://localhost:8080/JSON/context/action/includeInContext/ -d 'contextName=Example Context&regex=http://www.example.com/.*'
   ```{{execute}}

4. **Start the Scan**:
   Initiate the scan on the specified URL using the following curl command:
   ```bash
   curl -X POST http://localhost:8080/JSON/ascan/action/scan/ -d 'url=http://www.example.com'
   ```{{execute}}

5. **Monitor Scan Progress**:
   You can monitor the scan progress by checking the scan status using the following curl command:
   ```bash
   curl -X GET http://localhost:8080/JSON/ascan/view/status/
   ```{{execute}}

6. **Retrieve Scan Results**:
   Once the scan is completed, you can retrieve the scan results using the following curl command:
   ```bash
   curl -X GET http://localhost:8080/JSON/ascan/view/alerts/
   ```{{execute}}

By following these steps and using the provided curl commands, you can configure OWASP ZAP, set up the scan for a single URL, and retrieve the scan results for analysis. This approach allows you to perform security testing on the specified URL using OWASP ZAP in a structured and automated manner.
