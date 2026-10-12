# Step 2

Replace this placeholder with the next task for the vLLM lab.

A common candidate: set up a Python virtual environment, then install vLLM and inspect the installed version.

## Create a Python virtual environment

Always install vLLM inside an isolated virtual environment, never into the system
Python:

```bash
sudo apt update && sudo apt install -y python3-venv
```{{exec}}

```bash
mkdir vllm-lab && cd vllm-lab
```{{exec}}

```bash
python3 -m venv .venv
```{{exec}}

```bash
source .venv/bin/activate
```{{exec}}

Confirm you are now using the venv's interpreter:

```bash
which python && python -V
```{{exec}}

## Install vLLM

With the environment active, install vLLM and check the version:

```bash
pip install --upgrade pip
```{{exec}}

```bash
pip install  vllm
```{{exec}}

```bash
# pip install --quiet vllm
```{{exec}}

```bash
python -c "import vllm; print(vllm.__version__)"
```{{exec}}

**What you learned:** how to isolate a Python environment with `venv` and pin the
expected vLLM version for this lab.