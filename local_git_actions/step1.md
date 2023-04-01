
# Initial Setup

Doc: https://killercoda.com/creators

github: https://github.com/killercoda

`apt update`{{exec}}

`apt install -y tree jq`{{exec}}



## Install Act

https://github.com/nektos/act



`curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash`{{exec}}

`cp ./bin/act /usr/bin/`{{exec}}

# Setup a simple github Action

`mkdir -p  /root/actone/.github/workflows/`{{exec}}

`nano /root/actone/.github/workflows/learn-github-actions.yml`{{exec}}


```
name: learn-github-actions
run-name: ${{ github.actor }} is learning GitHub Actions
on: [push]
jobs:
  check-bats-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '14'
      - run: npm install -g bats
      - run: bats -v

```{{copy}}


`act`{{exec}}

When running act for the first time, it will ask you to choose image to be used as default. It will save that information to ~/.actrc  - for now select the 'medium' image

`cat ~/.actrc `{{exec}}

`act -l`{{exec}}

`act -j check-bats-version`{{exec}}  - run the tests

`act -g`{{exec}}




## A more advanced Github Action

`git clone https://github.com/cplee/github-actions-demo.git`{{exec}}


WIP: the following takes to long to run

`cd github-actions-demo/`{{exec}}

`cat .github/workflows/main.yml`{{exec}}

`tree -a`{{exec}}


`act`{{exec}}

`act -l`{{exec}}

`act -j test`{{exec}}  - run the tests

`cd ~`{{exec}}

## Another repo

`git clone https://github.com/morrisseycode/exploringactions`{{exec}}

`cd exploringactions`{{exec}}

`ls ./.github/workflows/`{{exec}}

`act`{{exec}}


```
# List all actions for all events:
act -l

# List the actions for a specific event:
act workflow_dispatch -l

# List the actions for a specific job:
act -j test -l

# Run the default (`push`) event:
act

# Run a specific event:
act pull_request

# Run a specific job:
act -j test

# Collect artifacts to the /tmp/artifacts folder:
act --artifact-server-path /tmp/artifacts

# Run a job in a specific workflow (useful if you have duplicate job names)
act -j lint -W .github/workflows/checks.yml

# Run in dry-run mode:
act -n

# Enable verbose-logging (can be used with any of the above commands)
act -v
```

# Show a graphical version

act -g
