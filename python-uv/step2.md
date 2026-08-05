# Step 2: Initialize Project

Now that `uv` is installed, let's initialize our project with more control.

1. Create the project directory:
```bash
mkdir quick-stats && cd quick-stats
```{{exec}}

2. Install a specific Python version:
```bash
uv python install 3.12
```{{exec}}

3. Create a virtual environment explicitly:
```bash
uv venv --python 3.12
```{{exec}}

4. Pin the Python version for the project:
```bash
uv python pin 3.12
```{{exec}}

5. Initialize the project and add `requests` as a dependency:
```bash
uv init
uv add requests
```{{exec}}
