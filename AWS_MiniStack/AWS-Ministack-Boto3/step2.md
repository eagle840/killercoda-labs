# Step 2: Python Environment Setup

Now that MiniStack is running and the AWS CLI is configured, let's set up the Python environment to work with `boto3` and `jupyterlab`.

### 1. Prepare Python Environment
We will use Python 3.12 and create a virtual environment to isolate our dependencies.

```bash
# Install Python 3.12 and venv
sudo apt install -y python3.12-venv
```{{exec}}

Now, create and activate the virtual environment:

```bash
# Create and activate the virtual environment
python3.12 -m venv venv
source venv/bin/activate
```{{exec}}

### 2. Install Dependencies
With the virtual environment active, install `boto3` and `jupyterlab`.

```bash
# Install boto3 and jupyterlab
pip install --upgrade pip
pip install boto3 jupyterlab
```{{exec}}

Once completed, you are ready to configure Jupyter Lab in the next step.
