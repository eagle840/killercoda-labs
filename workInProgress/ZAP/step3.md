# Interactive ZAP via Webswing

While automation is powerful, sometimes you need to explore vulnerabilities manually. Since Killercoda provides a terminal, we use **Webswing** to run the ZAP Desktop GUI inside your web browser.

## 1. Launch ZAP Web UI
Run the following command to start ZAP with the Webswing interface. 

`docker run --net=host -u zap -i ghcr.io/zaproxy/zaproxy:stable zap-webswing.sh`{{exec}}

Once the container is running and you see "Started", access the UI here:

{{TRAFFIC_HOST1_8080}}/zap

## 2. Understanding the Layout
The ZAP GUI is divided into several key areas:

```
##################################
# Tree window # Workspace window #
##################################
#     Information window         #
##################################
```
- **Tree Window:** Shows the "Sites" tree (all URLs discovered).
- **Workspace Window:** Where you perform scans and view request/response details.
- **Information Window:** Displays "Alerts" (vulnerabilities found), History, and Search results.

## 3. ZAP Attack Modes
At the top left of the ZAP UI, you'll see a dropdown for **Modes**. These control how much "damage" ZAP is allowed to do:

- **Safe:** No potentially harmful actions.
- **Protected:** Actions only allowed on targets in a defined "Context".
- **Standard:** The default; allows most actions.
- **Attack:** Automatically scans any new URL discovered that is in scope.

## 4. Run an Automated Scan
In the **Workspace Window**, click on the **Automated Scan** button:
1. Enter `http://localhost:3000` in the **URL to attack** field.
2. Click **Attack**.

You will see ZAP's spider crawling the site in the Tree window and alerts appearing in the Information window at the bottom.

Click **Continue** once you've explored the UI.
