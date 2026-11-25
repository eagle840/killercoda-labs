# Step 1: Install uv and Create the Project

In this step you will install `uv` and create the Python project that the rest of the lab uses.

## Check the environment

First, confirm how much CPU, memory, and disk space this lab has:

```bash
nproc
free -h
df -h /
```{{exec}}

Ollama needs enough free memory to hold TinyLlama. The lab runs on the 4 GB environment for that reason.

## Install uv

`uv` is a fast, single-binary Python package and project manager. It can install Python itself, create virtual environments, and resolve dependencies.

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
```{{exec}}

Verify the installation:

```bash
uv --version
```{{exec}}

## Create the project

Create a project called `gradio-lab`, pin it to Python 3.12, and add the two libraries used in this lab:

```bash
cd ~
uv init gradio-lab --python 3.12
cd gradio-lab
uv add gradio openai
```{{exec}}

`uv add` does several things at once:

- Resolves the Python version configured by `uv init` and creates or updates `.venv`.
- Adds `gradio` and `openai` to `pyproject.toml`.
- Writes exact versions to `uv.lock` so the environment can be recreated later.

Take a look at the generated files:

```bash
pwd
ls -la
cat pyproject.toml
```{{exec}}

Confirm that Python and the dependencies are available inside the project environment:

```bash
uv run python --version
uv run python -c "import gradio, openai; print('gradio', gradio.__version__); print('openai', openai.__version__)"
```{{exec}}

## Why uv instead of pip?

- `uv run <command>` executes inside the project environment, so you never forget to activate `.venv`.
- `uv add <package>` records the dependency instead of installing it ad hoc.
- `uv sync` recreates the environment from `pyproject.toml` and `uv.lock` on any machine.

If you ever need to rebuild the environment from scratch, run:

```bash
uv sync
```{{copy}}

You now have a reproducible project. Move on to build the first Gradio app.
