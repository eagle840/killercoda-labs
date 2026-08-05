# Step 4: Lint and Format

We will now use `uvx` to execute `ruff` (for linting) and `black` (for formatting) on our project code.

### What is `uvx`?
`uvx` is a command-line tool provided by `uv` designed for **ad-hoc tool execution**. It allows you to run Python packages as standalone tools without explicitly installing them into your project's virtual environment. It handles the ephemeral environment creation and cleanup automatically, making it the perfect replacement for `pipx`.

1. Lint the project with `ruff`:
```bash
uvx ruff check .
```{{exec}}

2. Format the code with `black`:
```bash
uvx black .
```{{exec}}
