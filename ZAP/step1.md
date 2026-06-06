# Setting Up the Vulnerable Target

To perform Dynamic Application Security Testing (DAST), we first need a running application to test. In this lab, we will use the **OWASP Juice Shop**, which is arguably the most modern and sophisticated insecure web application.

## 1. Install Utilities
First, let's install `jq`, a lightweight and flexible command-line JSON processor. We'll use this later to parse ZAP API responses.

`apt update && apt install jq -y`{{exec}}

## 2. Deploy OWASP Juice Shop
We will run Juice Shop as a background Docker container.

`docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop`{{exec}}

## 3. Wait for Initialization
Juice Shop is a Node.js application and takes a few moments to start up. Run the following command to wait until the service is responsive:

`until $(curl --output /dev/null --silent --head --fail http://localhost:3000); do printf '.'; sleep 5; done && echo "Juice Shop is UP!"`{{exec}}

Once you see "Juice Shop is UP!", you can view the application here: {{TRAFFIC_HOST1_3000}}

## 4. Pre-pull ZAP Image
While Juice Shop is starting, let's pull the OWASP ZAP Docker image so it's ready for the next step.

`docker pull ghcr.io/zaproxy/zaproxy:stable`{{exec}}

Click **Continue** once Juice Shop is ready.
