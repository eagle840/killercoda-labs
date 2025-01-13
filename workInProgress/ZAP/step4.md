# Step 34
In OWASP ZAP, the scan tree is a hierarchical representation of the targets that are being scanned by the tool. It organizes the URLs, parameters, and other elements that OWASP ZAP will scan for vulnerabilities during an active scan. The scan tree structure helps manage and prioritize the scanning process by defining the scope of the security testing.

Here's how the scan tree works with the concept of 'context' in OWASP ZAP:

1. **Context**: A context in OWASP ZAP represents a collection of one or more URLs that are grouped together for scanning purposes. Each context can have its own configuration settings, including authentication details, session management, and scope of scanning. By organizing URLs into contexts, you can customize the scanning behavior for different parts of the application. (default: "Default Context")



2. **Scan Tree and Context Relationship**: When you add URLs to a context in OWASP ZAP, those URLs become part of the scan tree under that specific context. The scan tree structure reflects the hierarchy of contexts and URLs that have been added for scanning. Each context in the scan tree contains the URLs and parameters that are included in that context's scope.

3. **Managing Scan Scope**: By organizing URLs into contexts and structuring them in the scan tree, you can effectively manage the scan scope in OWASP ZAP. You can add or remove URLs from contexts, adjust scanning configurations for each context, and prioritize the scanning of specific parts of the application based on the context settings.

4. **Scanning Process**: During an active scan in OWASP ZAP, the tool traverses the scan tree starting from the root context and scans the URLs and parameters within each context. The scan tree guides the scanning process, ensuring that OWASP ZAP covers all the targets specified in the contexts while following the defined scope and configurations.

Overall, the scan tree and context management in OWASP ZAP provide a structured approach to organizing and conducting security scans on web applications. By leveraging contexts and the scan tree, you can customize the scanning process, focus on specific areas of the application, and efficiently identify security vulnerabilities.


When setting up OWASP ZAP for the first time to scan a single URL like http://www.example.com, you need to configure the ZAP context, add the URL to the context, and then initiate the scan. Here's a step-by-step guide on how to do this, including the necessary curl commands:

1. **Start OWASP ZAP Docker Container**:
   First, ensure that your OWASP ZAP server is running in a Docker container. You can start the container using the following command:

   `docker run -u zap -p 8080:8080 -i ghcr.io/zaproxy/zaproxy:stable zap.sh -daemon -host 0.0.0.0 -port 8080 -config api.disablekey=true`{{execute}}

2. **Create a New Context**:
   Use the following curl command to create a new context named "Example Context":

   `curl -X POST http://localhost:8080/JSON/context/action/newContext/ -d 'contextName=Example Context'`{{execute}}

3. **Add URL to the Context**:
   Add the URL http://www.example.com to the "Example Context" using the following curl command:

   `curl -X POST http://localhost:8080/JSON/context/action/includeInContext/ -d 'contextName=Example Context&regex=http://www.example.com/.*'`{{execute}}

   **Confirm**

   `curl -X GET http://localhost:8080/JSON/context/view/context/?contextName=Example%20Context | jq`{{exec}}

   Check the response from the above command to ensure that the URL `http://www.example.com` is listed under the specified context.


4. **Start the Scan**:
   Initiate the scan on the specified URL using the following curl command:

   `curl -X POST http://localhost:8080/JSON/ascan/action/scan/ -d 'url=http://www.example.com'`{{execute}}

   WIP still getting {"code":"url_not_found","message":"URL Not Found in the Scan Tree"}

5. **Monitor Scan Progress**:
   You can monitor the scan progress by checking the scan status using the following curl command:

   `curl -X GET http://localhost:8080/JSON/ascan/view/status/`{{execute}}

6. **Retrieve Scan Results**:
   Once the scan is completed, you can retrieve the scan results using the following curl command:

   `curl -X GET http://localhost:8080/JSON/ascan/view/alerts/`{{execute}}

By following these steps and using the provided curl commands, you can configure OWASP ZAP, set up the scan for a single URL, and retrieve the scan results for analysis. This approach allows you to perform security testing on the specified URL using OWASP ZAP in a structured and automated manner.
