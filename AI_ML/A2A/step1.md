# Setup Environment

In this step you will install all the dependencies needed for the lab: **uv** (Python package manager), **opencode**, the **A2A Python SDK**, and **opencode-a2a**. We will also start opencode early so the free model downloads in the background while you write agent code.

## 1. Install uv

`curl -LsSf https://astral.sh/uv/install.sh | sh`{{exec}}

`source $HOME/.local/bin/env`{{exec}}

## 2. Install opencode

`curl -fsSL https://opencode.ai/install | bash`{{exec}}


```bash
source ~/.bashrc
```{{exec}}

Select a **free model** when prompted, then exit opencode with `Ctrl+C`.

**Note:** Starting opencode now lets it download the model in the background while you build your agents in the next steps.

## 3. Create the Project Directory

```bash
mkdir -p ~/a2a-lab && cd ~/a2a-lab
```{{exec}}

## 4. Create Python Virtual Environment

```bash
uv venv && source .venv/bin/activate
```{{exec}}

## 5. Install the A2A SDK

```bash
uv pip install "a2a-sdk[http-server]" uvicorn httpx
```{{exec}}

## 6. Verify the Installation

```bash
python -c "import a2a; print('A2A SDK imported successfully')"
```{{exec}}

You should see `A2A SDK imported successfully`.

## 7. Install opencode-a2a

```bash
uv tool install opencode-a2a
```{{exec}}

## 8. Check Starter Files

The starter directory contains reference implementations. You can peek at them during the lab, but the best learning comes from writing the code yourself.

```bash
ls -la ~/a2a-lab/starter/
```{{exec}}

Click **Continue** once all installations complete without errors.
