Basoc use of Ngork.


I am making an Azure Web App, that creates a HTTP GET post, but I need an endpoint to send that GET request to so I can test the logic app


To create an endpoint for testing your Azure Web App's HTTP GET request, you can use a tool like RequestBin or ngrok. Here's how you can set it up:

1. RequestBin:
   - Go to https://requestbin.com/.
   - Click on "Create a RequestBin".
   - Copy the generated URL (e.g., https://requestbin.com/1abc1234) which will be your endpoint.
   - Update your Azure Web App to send the HTTP GET request to this URL.
   - You can then monitor the incoming requests on the RequestBin dashboard.

2. ngrok:
   - Download and install ngrok from https://ngrok.com/.
   - Run ngrok by executing `ngrok http 80` in your terminal (replace 80 with the port your Azure Web App is running on).
   - Copy the generated forwarding URL (e.g., https://1a2b3c4d.ngrok.io) which will be your endpoint.
   - Update your Azure Web App to send the HTTP GET request to this URL.
   - You can then monitor the incoming requests on the ngrok dashboard.

By using either RequestBin or ngrok, you can easily create a temporary endpoint to test your Azure Web App's HTTP GET request and verify the logic app's functionality.
