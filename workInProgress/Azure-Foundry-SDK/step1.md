# Step 1: Environment Setup

In this step, we will prepare your environment by setting up a Python virtual environment and installing the necessary packages, including the Azure Foundry SDK.

### 1. Create and Activate Virtual Environment
We will use Python 3.12 and create a virtual environment to ensure our dependencies are isolated.

```bash
# Update package list and install venv
sudo apt update && sudo apt install -y python3.12-venv
```{{exec}}

```bash
# Create the virtual environment and activate
python3.12 -m venv venv
source venv/bin/activate
```{{exec}}

### 2. Install Dependencies
With the virtual environment active, install the `azure-ai-projects` SDK along with `jupyterlab` and `streamlit` for the upcoming steps.

```bash
# Upgrade pip
pip install --upgrade pip

# Install Azure Foundry SDK, Jupyter, and Streamlit
pip install azure-ai-projects jupyterlab streamlit
```{{exec}}

### 3. Authentication Configuration
To interact with Azure Foundry services, you would typically need to configure your environment variables. 
*(Note: In a production scenario, you would set these properly. For this lab, we will mock these in the next steps).*

```bash
# Example of setting up placeholders for your Azure credentials
export AZURE_SUBSCRIPTION_ID="your-subscription-id"
export AZURE_RESOURCE_GROUP="your-resource-group"
export AZURE_PROJECT_NAME="your-project-name"
```{{exec}}

Once this is complete, you are ready to explore Azure Foundry in the next step!
