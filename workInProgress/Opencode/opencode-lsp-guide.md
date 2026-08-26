# OpenCode LSP Guide

## What are LSPs?

Language Server Protocol (LSP) servers provide IDE-like features to the AI agent:

- Autocomplete / code completions
- Go to definition
- Find references
- Diagnostics (errors/warnings)
- Hover info (types, documentation)

## How LSPs Work in OpenCode

- LSP servers run as **local child processes** spawned by OpenCode on your machine
- They're not remote - they run in the background alongside OpenCode
- OpenCode auto-detects which LSP to start based on file extension (e.g., `.ts` → `typescript-language-server`, `.py` → `pyright`)
- When enabled, servers start when a matching file extension is detected and requirements are met

## Built-in LSP Support

OpenCode includes built-in LSP servers for many languages:

| Language | LSP Server | Requirements |
|----------|------------|--------------|
| TypeScript/JavaScript | typescript | `typescript` in project |
| Python | pyright | `pyright` in project |
| Go | gopls | `go` command available |
| Rust | rust-analyzer | `rust-analyzer` available |
| C/C++ | clangd | Auto-installs for C/C++ projects |
| Ruby | ruby-lsp | `ruby` and `gem` available |
| And many more... | | |

## Enabling LSPs

LSPs are **disabled by default**. To enable them, add to your `opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": true
}
```

This enables all built-in LSP servers. You can also selectively enable specific ones:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": {
    "typescript": {},
    "pyright": {}
  }
}
```

To disable specific servers while keeping others enabled:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": {
    "typescript": { "disabled": true }
  }
}
```

## Verifying LSP is Active

### 1. Check the TUI Status Bar
Look at the bottom-right corner of the OpenCode TUI for an LSP indicator.

### 2. Run with Debug Logging
```bash
opencode --log-level DEBUG
```
Watch for LSP startup messages. Logs are at `~/.local/share/opencode/log/`.

### 3. Check Running Processes
```bash
ps aux | grep -E "typescript-language-server|pyright|gopls"
```

### 4. Debug Config
```bash
opencode debug config
```

## Quick Test

```bash
# Enable LSPs
echo '{"lsp": true}' > opencode.json

# Start OpenCode with debug logging
opencode --log-level DEBUG

# Open a .ts or .js file and check for LSP activity in logs
```

## Custom LSP Servers

You can add custom LSP servers:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "lsp": {
    "custom-lsp": {
      "command": ["custom-lsp-server", "--stdio"],
      "extensions": [".custom"]
    }
  }
}
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENCODE_DISABLE_LSP_DOWNLOAD` | Set to `true` to disable automatic LSP server downloads |

## Troubleshooting

- Check logs at `~/.local/share/opencode/log/`
- Ensure language dependencies are installed (e.g., `npm install typescript` for TS support)
- Some LSPs auto-install; others require manual setup
- Use `--log-level DEBUG` for detailed output

## References

- [OpenCode LSP Documentation](https://opencode.ai/docs/lsp/)
- [OpenCode Config](https://opencode.ai/docs/config/)
