# Lab Plan: Python Package Management with `uv`

## Objective
Build a "Quick-Stats" CLI tool that fetches and displays weather data, demonstrating `uv` as a modern, fast alternative to `pip`, `poetry`, `virtualenv`, and `pipx`.

## Completed Steps
- [x] **Setup**: Automatically install `uv` (via explicit install script in `step1.md`).
- [x] **Project Management**: Initialize the "Quick-Stats" project, manage Python versions, and virtual environments.
- [x] **Scripting**: Implement the CLI logic in a script, using inline metadata for dependencies, and execute it with `uv run`.
- [x] **Isolated Tools (`uvx`)**: Use `uvx ruff` to lint the project code and `uvx black` to format it.
- [x] **Pip Compatibility**: Demonstrate `uv`'s speed by migrating a traditional `requirements.txt` to `uv.lock`.
- [ ] **Build and Publish**: Build the project and understand how to publish to PyPI/TestPyPI.

## Verification
Each step will include a verification script to ensure the user correctly implemented the project components and that the `uv` environment is correctly managing the "Quick-Stats" dependencies.

