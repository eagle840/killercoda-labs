# Step 2: Python Project Setup & Code Analysis

In this step, we will set up a local Python project, initialize a local Git repository, configure SonarQube scanner properties, and perform our first code scans to detect code smells.

---

## 1. Setup Local Git and Python Project

First, let's create our project directory, initialize Git, and set up a Python virtual environment.

We use **Git** because SonarQube relies on it to extract author information (git blame) and track which code is "new" versus "overall code".

### Create Project and Initialize Git

Create the project folder and initialize a local Git repository:

```bash
mkdir -p ~/myproject
cd ~/myproject
git init
```{{exec}}

Configure Git defaults for our local workspace:

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```{{exec}}

### Create the Python Virtual Environment

Install `python3-venv` and prepare our virtual environment:

```bash
sudo apt-get update && sudo apt-get install -y python3-venv
```{{exec}}

Create and activate the environment, then install Flask:

```bash
python3 -m venv venv
source venv/bin/activate
pip install flask
```{{exec}}

---

## 2. Create and Commit Source Code

Let's write a simple Flask application.

Create the `hello.py` file:

```bash
cat << 'EOF' > hello.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
EOF
```{{exec}}

Now, commit this initial clean version to Git so SonarQube has a baseline version of our code:

```bash
git add hello.py
git commit -m "initial commit"
```{{exec}}

---

## 3. Configure and Run SonarQube Scanner

Rather than typing long, repetitive command-line flags every time we scan, the industry standard is to place a configuration file named `sonar-project.properties` in the root of our codebase.

Create the configuration file:

```bash
cat << 'EOF' > sonar-project.properties
# Unique identifier for this project in SonarQube
sonar.projectKey=pyproject

# The path to the source directories relative to this file
sonar.sources=.

# The address of our SonarQube server
sonar.host.url=http://localhost:9000

# Exclude virtual environment from scans to focus only on our code
sonar.exclusions=venv/**
EOF
```{{exec}}

### Store the Authentication Token

Run the following command, replacing `YOUR_GENERATED_TOKEN` with the secret token you copied from the SonarQube project creation screen in Step 1:

```bash
SONAR_TOKEN="YOUR_GENERATED_TOKEN"
```{{copy}}

### Run the First Scan

With our `sonar-project.properties` file in place, executing the analysis is as simple as running `sonar-scanner` and passing our token:

```bash
sonar-scanner -Dsonar.token="$SONAR_TOKEN"
```{{exec}}

This initial scan should take less than a minute. Once complete, return to your SonarQube dashboard at:

{{TRAFFIC_HOST1_9000}}

Refresh the page or click on the **pyproject** project. You will see that the Quality Gate has **Passed** with 0 Bugs, 0 Vulnerabilities, and 0 Code Smells!

---

## 4. Introduce a Code Smell and Scan Again

Now let's see static analysis in action by introducing a bad practice (a "code smell") into our Python application.

An empty `except` block is a classic Python quality issue (anti-pattern) because it swallows all errors silently, making debugging extremely difficult.

Append the following bad code block to `hello.py`:

```bash
cat << 'EOF' >> hello.py

def calculate_risk():
    try:
        result = 10 / 0
    except:
        # Empty except block is a classic code smell!
        pass
EOF
```{{exec}}

Commit the change to Git so SonarQube can classify it as "new code":

```bash
git add hello.py
git commit -m "add calculation logic"
```{{exec}}

### Scan Again

Now, re-run the scanner to analyze the new code:

```bash
sonar-scanner -Dsonar.token="$SONAR_TOKEN"
```{{exec}}

### Observe the Results

Go back to your SonarQube dashboard and refresh.
1. Look at the **New Code** tab.
2. You will see that a new **Code Smell** is detected!
3. Click on the Code Smell count to inspect the issue: SonarQube will point exactly to your empty `except` block in `hello.py` and explain why this pattern should be avoided.

---

### Note on `pysonar` (Alternative Python Wrapper)

Some Python developers use a tool called `pysonar` (installed via `pip install pysonar`). `pysonar` is a third-party Python-specific wrapper that automatically locates or downloads `sonar-scanner` and provides commands such as `pysonar -Dsonar.projectKey=...`. 

However, using the official, native `sonar-scanner` CLI is the standard language-agnostic approach recommended across general CI/CD pipelines (such as Jenkins, GitHub Actions, and GitLab CI), ensuring you can use the same scanner tool for JavaScript, Python, Java, or C# alike!
