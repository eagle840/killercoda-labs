# Step 3: Building a Standalone AI App with Streamlit

Now we will create a simple, standalone web application using **Streamlit** that integrates the Azure Foundry SDK.

### 1. Create the Streamlit Application
Create a file named `app.py` in your workspace. This file will serve as the entry point for your AI-powered web app.

```python
import streamlit as st
import os
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

st.title("Azure Foundry AI Assistant")

# Initialize client (simplified for this example)
@st.cache_resource
def get_client():
    return AIProjectClient(
        credential=DefaultAzureCredential(),
        subscription_id=os.environ.get("AZURE_SUBSCRIPTION_ID"),
        resource_group_name=os.environ.get("AZURE_RESOURCE_GROUP"),
        project_name=os.environ.get("AZURE_PROJECT_NAME"),
    )

project_client = get_client()

# App UI
user_input = st.text_input("Ask your AI assistant:")
if user_input:
    st.write(f"You asked: {user_input}")
    # In a real scenario, you would call your model here via project_client
    st.write("Assistant: This is a placeholder for your AI model response.")
```

### 2. Run the Application
Ensure your virtual environment is active, then run the application using Streamlit:

```bash
streamlit run app.py --server.port 8501
```{{exec}}

*Note: Access the Streamlit interface through the provided port access.*
{{TRAFFIC_HOST1_8501}}

You have now built a standalone AI application that leverages the Azure Foundry SDK!
