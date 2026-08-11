# Step 2: Setup Inference & MCP Environment

Now we will install Ollama, set up the MCP SDK, and install the MCP Inspector for debugging.

### 1. Install Ollama
Run the official installation script:

`curl -fsSL https://ollama.com/install.sh | sh`{{exec}}

### 2. Verify the Installation
Check if the service is running:

`systemctl status ollama`{{exec}}

*(Press `q` to exit the status view).*

### 3. Run the Model
Pull and run the **Qwen 2.5 0.5B** model (recommended for basic tool use):

`ollama pull qwen2.5:0.5b`{{exec}}

### 4. Install MCP Tools
Create and activate a virtual environment for your MCP tools:

`apt install - ypython3.12-venv`{{exec}}

`mkdir mcp_env; cd mcp_env`{{exec}}   
`python3 -m venv .venv`{{exec}}   
`source .venv/bin/activate`{{exec}}   

Install the MCP SDK and the MCP Inspector:

`pip install mcp`{{exec}}

### Install node/npm and MCP inspector

`curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -`{{exec}}

`apt install nodejs -y`{{exec}}


`npm install @modelcontextprotocol/inspector`{{exec}}

# MCP Website MCP Server setup

taken from: https://modelcontextprotocol.info/docs/quickstart/server/

```
# Create a new directory for our project
uv init weather
cd weather

# Create virtual environment and activate it
uv venv
source .venv/bin/activate

# Install dependencies
uv add "mcp[cli]" httpx

# Create our server file
touch weather.py
```{{exec}}
Add these to the top of your weather.py:

WIP:FastMCP doesn'st seem to work (try installing just mcp)

```
from typing import Any
import httpx
# from mcp.server.fastmcp import FastMCP
from mcp.server import MCPServer

# Initialize FastMCP server
# mcp = FastMCP("weather")
mcp = MCPServer("weather")


# Constants
NWS_API_BASE = "https://api.weather.gov"
USER_AGENT = "weather-app/1.0"
```{{copy}}

Add helper functions

```
async def make_nws_request(url: str) -> dict[str, Any] | None:
    """Make a request to the NWS API with proper error handling."""
    headers = {
        "User-Agent": USER_AGENT,
        "Accept": "application/geo+json"
    }
    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(url, headers=headers, timeout=30.0)
            response.raise_for_status()
            return response.json()
        except Exception:
            return None

def format_alert(feature: dict) -> str:
    """Format an alert feature into a readable string."""
    props = feature["properties"]
    return f"""
Event: {props.get('event', 'Unknown')}
Area: {props.get('areaDesc', 'Unknown')}
Severity: {props.get('severity', 'Unknown')}
Description: {props.get('description', 'No description available')}
Instructions: {props.get('instruction', 'No specific instructions provided')}
"""
```{{copy}}

Impliment the tools

```
@mcp.tool()
async def get_alerts(state: str) -> str:
    """Get weather alerts for a US state.

    Args:
        state: Two-letter US state code (e.g. CA, NY)
    """
    url = f"{NWS_API_BASE}/alerts/active/area/{state}"
    data = await make_nws_request(url)

    if not data or "features" not in data:
        return "Unable to fetch alerts or no alerts found."

    if not data["features"]:
        return "No active alerts for this state."

    alerts = [format_alert(feature) for feature in data["features"]]
    return "\n---\n".join(alerts)

@mcp.tool()
async def get_forecast(latitude: float, longitude: float) -> str:
    """Get weather forecast for a location.

    Args:
        latitude: Latitude of the location
        longitude: Longitude of the location
    """
    # First get the forecast grid endpoint
    points_url = f"{NWS_API_BASE}/points/{latitude},{longitude}"
    points_data = await make_nws_request(points_url)

    if not points_data:
        return "Unable to fetch forecast data for this location."

    # Get the forecast URL from the points response
    forecast_url = points_data["properties"]["forecast"]
    forecast_data = await make_nws_request(forecast_url)

    if not forecast_data:
        return "Unable to fetch detailed forecast."

    # Format the periods into a readable forecast
    periods = forecast_data["properties"]["periods"]
    forecasts = []
    for period in periods[:5]:  # Only show next 5 periods
        forecast = f"""
{period['name']}:
Temperature: {period['temperature']}°{period['temperatureUnit']}
Wind: {period['windSpeed']} {period['windDirection']}
Forecast: {period['detailedForecast']}
"""
        forecasts.append(forecast)

    return "\n---\n".join(forecasts)
```{{copy}}

and the code to run the server

```
if __name__ == "__main__":
    # Initialize and run the server
    mcp.run(transport='stdio')
```{{copy}}