# Lab Plan: Python Package Management with `uv`

## Objective
Build a "Quick-Stats" CLI tool that fetches and displays weather data, demonstrating `uv` as a modern, fast alternative to `pip`, `poetry`, `virtualenv`, and `pipx`.

## Completed Steps
- [x] **Setup**: Automatically install `uv` (via explicit install script in `step1.md`).
- [ ] **Project Management**: Initialize the "Quick-Stats" project, manage Python versions, and virtual environments.
- [ ] **Scripting**: Implement the CLI logic in a script, using inline metadata for dependencies, and execute it with `uv run`.
- [ ] **Isolated Tools (`uvx`)**: Use `uvx ruff` to lint the project code and `uvx black` to format it.
- [ ] **Pip Compatibility**: Demonstrate `uv`'s speed by migrating a traditional `requirements.txt` to `uv.lock`.

## Planned Additions/Refinements (Step 2)
1. **Python Version Management**: Teach `uv python install <version>` and `uv python pin`.
2. **Explicit Venv**: Teach `uv venv` to create virtual environments explicitly.

## Verification
Each step will include a verification script to ensure the user correctly implemented the project components and that the `uv` environment is correctly managing the "Quick-Stats" dependencies.
