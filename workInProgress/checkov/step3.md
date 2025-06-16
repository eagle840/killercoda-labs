# github actions


https://github.com/bridgecrewio/checkov-action

VS cahtgpt

'need to change that for the files that have been pushed and PR'ed'


```yaml
name: Checkov Azure ARM Template

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  checkov:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Get changed files
      id: get_changed_files
      run: echo "::set-output name=files::$(git diff --name-only ${{ github.event.before }} ${{ github.sha }} | grep '\.json$')"

    - name: Run Checkov
      uses: bridgecrewio/checkov-action@master
      with:
        args: ${{ steps.get_changed_files.outputs.files }} --framework azure_arm --summary
```
