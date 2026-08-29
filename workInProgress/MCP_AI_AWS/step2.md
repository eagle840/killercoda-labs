# Step 2: Setup Inference & MCP Environment

set up the MCP SDK, and install the MCP Inspector for debugging.

```text
Notes on FASTMCP
▄▀▀ ▄▀█ █▀▀ ▀█▀ █▀▄▀█ █▀▀ █▀█                        │                          
█▀  █▀█ ▄▄█  █  █ ▀ █ █▄▄ █▀▀                        │                          
                │                          
     FastMCP 3.4.7                               │                          
     https://gofastmcp.com                             │                          
                         │                                                                              │                          
         🖥  Server:      Hello World MCP Server, 3.4.7                 │                          
        🚀 Deploy free: https://horizon.prefect.io   
```

### 4. Install MCP Tools
Create and activate a virtual environment for your MCP tools:



# MCP Website MCP Server setup

taken from: https://modelcontextprotocol.info/docs/quickstart/server/

```bash
# Create a new directory for our project
uv init weather
cd weather

# Create virtual environment and activate it
uv venv
```{{exec}}

`source .venv/bin/activate`{{exec}}


```bash
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


WIP:
```python
if __name__ == "__main__":
    # Bind to all interfaces (0.0.0.0) on port 8080 using SSE transport
    mcp.run(transport="sse", host="0.0.0.0", port=8080)
```{{copy}}

```
if __name__ == "__main__":
    # Initialize and run the server
    mcp.run(transport='stdio')
```{{copy}}

# add the mcp server to opencode, in the `.config/opencode/opencode.json`

```
,
    "weather": {
            "type": "local",
            "command": ["uv", "run", "/root/weather/weather.py"],
            "enabled": true
        }  
```{{copy}}

And restart Opencode


---

## Notes on setting up MCP in OpenCode

Setting up Model Context Protocol (MCP) servers in OpenCode is done through your configuration file (`opencode.json` or `opencode.jsonc`). OpenCode supports both **local** and **remote** MCP servers.

---

## 1. Where to Put the Configuration File

You can place your configuration in either of two locations:

* **Global Config:** `~/.config/opencode/opencode.json` (applies across all your projects)
* **Project-Level Config:** `opencode.json` or `opencode.jsonc` in your project's root folder

---

## 2. Adding a Local MCP Server

Local MCP servers run directly on your machine as subprocesses (e.g., via `npx` or `bun`).

Set the server `type` to `"local"` and define the startup command using an array of arguments:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "my-filesystem-server": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "/path/to/folder"],
      "enabled": true,
      "environment": {
        "MY_ENV_VAR": "value"
      }
    }
  }
}

```

---

## 3. Adding a Remote MCP Server

Remote MCP servers communicate via HTTP/HTTPS endpoints. Set the `type` to `"remote"` and supply the server URL:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "my-remote-server": {
      "type": "remote",
      "url": "https://mcp.example.com/mcp",
      "enabled": true,
      "headers": {
        "Authorization": "Bearer {env:MY_API_KEY}"
      }
    }
  }
}

```

> 💡 **Tip:** Use `{env:VARIABLE_NAME}` syntax inside config values to inject environment variables securely without committing API keys or tokens into source control.

---

## 4. Useful CLI Commands for MCP

OpenCode provides terminal commands to help manage, authenticate, and troubleshoot your MCP connections:

| Command | Description |
| --- | --- |
| `opencode mcp list` | View all configured MCP servers and their authentication status. |
| `opencode mcp auth <server-name>` | Manually trigger OAuth authentication for a server. |
| `opencode mcp debug <server-name>` | Test connectivity, check headers, and debug OAuth flow. |

---

## 5. Disabling or Restricting Specific Tools

MCP tools are automatically available to OpenCode's LLM. If you want to disable specific tools globally or use wildcards to turn off groups of tools, configure the `"tools"` section:

```json
{
  "tools": {
    "my-filesystem-server": false,
    "github-*": false
  }
}

```

> ⚠️ **Token Usage Notice:** MCP servers append tool definitions to your prompt context window. Certain servers (like GitHub MCP) can add a large number of tokens, so only enable the servers you actively need.

---

Which specific MCP server (e.g., GitHub, PostgreSQL, local Filesystem) are you trying to connect to OpenCode?

---
# mcp fast

FROM: https://gofastmcp.com/getting-started/installation  (and quickstart)

```bash
uv init fasttest
cd fasttest
```{{exec}}

```bash
uv venv .venv
source .venv/bin/activate
```{{exec}}

```bash
uv add fastmcp
fastmcp version
```{{exec}}


`touch server.py`{{exec}}

```python
from fastmcp import FastMCP

mcp = FastMCP("My MCP Server")

@mcp.tool
def greet(name: str) -> str:
    return f"Hello, {name}!"

if __name__ == "__main__":
    mcp.run()
```{{copy}}

start with 

`fastmcp run server.py:mcp --transport http --port 8000 --host 0.0.0.0`{{exec}}

copy the link {{TRAFFIC_HOST1_8000}}/mcp

Note the the address is `Starting MCP server 'My MCP Server' with transport 'http' on http://0.0.0.0:8000/mcp  `

should look like:
`https://b690ef3f8729-10-244-5-66-8000.spch.r.killercoda.com/mcp`   RETURNS

```json
{"jsonrpc":"2.0","id":"server-error","error":{"code":-32600,"message":"Not Acceptable: Client must accept text/event-stream"}}```

---

FROM: https://www.npmjs.com/package/@mcp-use/inspector

(gh: https://github.com/mcp-use/mcp-use)

`npx @mcp-use/inspector`{{exec}}

open 8080

{{TRAFFIC_HOST1_8080}}

---