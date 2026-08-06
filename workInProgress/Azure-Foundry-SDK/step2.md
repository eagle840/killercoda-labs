# Step 2: Exploring Azure Foundry via Jupyter Lab

Now that our environment is set up, let's explore the Azure Foundry SDK using Jupyter Lab.

### 1. Launch Jupyter Lab
Ensure your virtual environment is still active, then launch Jupyter Lab:

```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```{{exec}}

*Note: Access the Jupyter interface through the provided port access in your browser.*
{{TRAFFIC_HOST1_8888}}

### 2. Initialize the Azure Foundry Client
In a new Jupyter notebook, we will initialize the Azure Foundry project client. 

```python
import os
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

# Initialize the client using environment variables
# Ensure these were set in the previous step or export them in the notebook
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    subscription_id=os.environ.get("AZURE_SUBSCRIPTION_ID"),
    resource_group_name=os.environ.get("AZURE_RESOURCE_GROUP"),
    project_name=os.environ.get("AZURE_PROJECT_NAME"),
)

print(f"Successfully initialized client for project: {project_client.project_name}")
```

### 3. Basic Operation: Verify Connection
Let's verify the connection by fetching details about the project.

```python
# Fetch and print project details
project_details = project_client.get_project()
print(f"Project ID: {project_details.id}")
print(f"Project Location: {project_details.location}")
```

In the next step, we will use this client to build a standalone web application with Streamlit.
