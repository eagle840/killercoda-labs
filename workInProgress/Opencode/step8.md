# Step 8: Configuring LSPs

Language Server Protocol (LSP) servers bring IDE-like capabilities—such as autocompletion, Go-to-Definition, and diagnostics—directly to your AI agent.

### 1. Understanding LSP Behavior
- **Local Processes:** LSP servers run as background child processes spawned by OpenCode. They are not remote; they run locally alongside your agent.
- **Auto-Detection:** OpenCode detects which LSP to start based on file extensions.

### 2. Enabling LSPs
LSPs are disabled by default. Add them to your `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": true
}
```{{copy}}

*Tip: You can selectively enable or disable specific servers in the `lsp` object in `opencode.json`.*

### 3. Verification
1. **TUI Status Bar:** Look for the LSP indicator in the bottom-right corner of the OpenCode TUI.
2. **Process Check:** Run the following to see if the server is running:
   ```bash
   ps aux | grep -E "typescript-language-server|pyright|gopls"
   ```{{exec}}
3. **Config Check:** Use this to verify current LSP configuration:
   ```bash
   opencode debug config
   ```{{exec}}

### 4. Best Practices & Troubleshooting
- **Install Dependencies:** Always ensure language-specific dependencies are installed in your project (e.g., `npm install typescript` for TypeScript support, or having `go` installed for `gopls`).
- **Use Debug Mode:** If LSPs fail to start, launch OpenCode with debug logging for detailed output:
   ```bash
   opencode --log-level DEBUG
   ```{{exec}}
- **Check Logs:** Inspect detailed logs if issues persist: `~/.local/share/opencode/log/`.
- **Control Downloads:** To prevent automatic LSP server downloads, set this environment variable:
   `OPENCODE_DISABLE_LSP_DOWNLOAD=true`
