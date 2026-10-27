# Step 1: Install Ollama

In this step, you'll install Ollama and verify it's running.

## Install Ollama

Run the official install script:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```{{execute}}

This will install Ollama and set up a systemd service.

## Verify Installation

Check the version:

```bash
ollama --version
```{{execute}}

Check if the service is running:

```bash
systemctl status ollama --no-pager
```{{execute}}

You can also test the API directly:

```bash
curl http://localhost:11434/api/version
```{{execute}}

## Useful Commands

```bash
ollama list    # List downloaded models
ollama ps      # Show running models
```{{execute}}

**What you learned:** Installed Ollama and confirmed the OpenAI-compatible API is available at `http://localhost:11434`.
