# Step 8: Configuring LSPs

Language Server Protocol (LSP) servers provide IDE-like features to the AI agent, such as autocompletion, go-to-definition, and diagnostics.

### 1. Enable LSPs
LSPs are disabled by default. You can enable them by adding a configuration file.

Create `opencode.json`:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": true
}
```{{copy}}

### 2. Verify LSP Activity
You can check if the LSP is active by running OpenCode with debug logging:

```bash
opencode --log-level DEBUG
```{{exec}}

Watch the logs for LSP startup messages, or check running processes:
```bash
ps aux | grep -E "typescript-language-server|pyright|gopls"
```{{exec}}

For more details, you can always run:
```bash
opencode debug config
```{{exec}}
