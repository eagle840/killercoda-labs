# Lab Plan: Python Package Management with `uv`

## Objective
Build a "Quick-Stats" CLI tool that fetches and displays weather data, demonstrating `uv` as a modern, fast alternative to `pip`, `poetry`, `virtualenv`, and `pipx`.

## Steps
1. **Setup**: Automatically install `uv` via the official standalone script in a background initialization step.
2. **Project Management**: Initialize the "Quick-Stats" project with `uv init`, pin a Python version with `uv python pin`, and add `requests` as a dependency with `uv add`.
3. **Scripting**: Implement the CLI logic in a script, using inline metadata for dependencies, and execute it with `uv run`.
4. **Isolated Tools (`uvx`)**: Use `uvx ruff` to lint the project code and `uvx black` to format it without explicit installation.
5. **Pip Compatibility**: Demonstrate `uv`'s speed by migrating a traditional `requirements.txt` to `uv.lock` using `uv pip compile` and `uv pip sync`.

## Verification
Each step will include a verification script to ensure the user correctly implemented the project components and that the `uv` environment is correctly managing the "Quick-Stats" dependencies.
