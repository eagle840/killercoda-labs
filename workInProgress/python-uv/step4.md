# Step 4: Lint and Format

We will now use `uvx` to execute `ruff` (for linting) and `black` (for formatting) on our project code *without* installing them into our virtual environment.

1. Lint the project:
```bash
uvx ruff check .
```{{exec}}

2. Format the code:
```bash
uvx black .
```{{exec}}
