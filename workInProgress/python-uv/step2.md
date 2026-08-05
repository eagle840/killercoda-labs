# Step 2: Initialize Project

Now that `uv` is installed, let's initialize our project.

1. Create a new directory and initialize the project:
```bash
mkdir quick-stats && cd quick-stats
uv init
```{{exec}}

2. Pin a specific Python version for the project (e.g., 3.12):
```bash
uv python pin 3.12
```{{exec}}

3. Add `requests` as a dependency:
```bash
uv add requests
```{{exec}}
