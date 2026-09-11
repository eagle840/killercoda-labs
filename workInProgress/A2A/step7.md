# Wire Up opencode via A2A

Now connect **opencode** to the A2A ecosystem using `opencode-a2a`. This turns opencode into an AI-powered A2A server — it can receive A2A requests and use its LLM to process them.

## 1. Make Sure opencode Is Configured

If you haven't already, run opencode to select a free model and configure it:

`opencode`{{exec}}

Select a free model using `/models`, then exit with `Ctrl+C`.

## 2. Start opencode as a Server

Open a **new terminal tab** and start opencode in server mode:

```bash
opencode serve --hostname 127.0.0.1 --port 4096
```{{exec interrupt}}

**Note:** opencode should start and begin listening on port 4096. You'll see log output confirming the server is ready.

## 3. Start opencode-a2a

Open **another new terminal tab** and start the A2A adapter:

```bash
DEMO_BEARER_TOKEN="$(python3 -c 'import secrets; print(secrets.token_hex(24))')"
A2A_STATIC_AUTH_CREDENTIALS='[{"scheme":"bearer","token":"'\"${DEMO_BEARER_TOKEN}\"'","principal":"automation"}]' \
OPENCODE_BASE_URL=http://127.0.0.1:4096 \
A2A_TASK_STORE_DATABASE_URL=sqlite+aiosqlite:///./opencode-a2a.db \
A2A_HOST=127.0.0.1 \
A2A_PORT=8000 \
A2A_PUBLIC_URL=http://127.0.0.1:8000 \
OPENCODE_WORKSPACE_ROOT=$HOME/a2a-lab \
opencode-a2a serve
```{{exec interrupt}}

**Note:** The `DEMO_BEARER_TOKEN` is generated fresh each time for security. The key environment variables are:

| Variable | Purpose |
|---|---|
| `OPENCODE_BASE_URL` | Where opencode server is running |
| `A2A_HOST` / `A2A_PORT` | Bind address for the A2A adapter |
| `A2A_PUBLIC_URL` | Public URL advertised in the Agent Card |
| `A2A_TASK_STORE_DATABASE_URL` | SQLite database for task persistence |
| `OPENCODE_WORKSPACE_ROOT` | Working directory for opencode |

## 4. Verify opencode-a2a Is Running

Back in the **original terminal tab**, check the opencode-a2a Agent Card:

```bash
curl -s http://127.0.0.1:8000/.well-known/agent-card.json | python -m json.tool
```{{exec}}

You should see an Agent Card with the name "opencode" or similar, and skills that reflect opencode's capabilities.

## 5. All Services Running

At this point you should have **four** services running across your terminal tabs:

| Service | Port | Terminal Tab |
|---|---|---|
| Currency Converter (Agent A) | 9000 | Tab 2 |
| Tax Calculator (Agent B) | 9001 | Tab 3 |
| opencode server | 4096 | Tab 4 |
| opencode-a2a adapter | 8000 | Tab 5 |

Click **Continue** once all four services are running and verified.
