STEP 1

That sounds like a solid plan, Nicholas! Here’s a **rough outline** of how you can structure this functionality:

---

### **1. Accept JSON Input**
- Allow users to send a JSON object via an HTTP request.
- Validate the input to ensure it's well-formed.
- Optionally allow users to upload JSON files instead of raw text.

---

### **2. Validate JSON Against a JSON Schema**
- Require users to provide a **JSON Schema** that defines the expected structure.
- Use the `jsonschema` Python library to validate the JSON object against the schema.
- Return detailed validation errors if mismatches occur.

Example using `jsonschema`:
```python
from jsonschema import validate, ValidationError

# Sample Schema
schema = {
    "type": "object",
    "properties": {
        "name": {"type": "string", "description": "User's full name"},
        "age": {"type": "integer", "description": "User's age"},
        "email": {"type": "string", "description": "Email address"}
    },
    "required": ["name", "age"]
}

# Sample JSON object
json_data = {
    "name": "Nicholas",
    "age": 30,
    "email": "nicholas@example.com"
}

# Validate JSON
try:
    validate(instance=json_data, schema=schema)
    print("JSON is valid!")
except ValidationError as e:
    print(f"JSON validation error: {e}")
```{{copy}}

---

### **3. Generate HTML Report**
- Extract the JSON keys and their corresponding **descriptions** from the JSON Schema.
- Create an HTML document that displays the JSON object **side by side** with descriptions.

Using **Jinja2** to format:
```html
<table border="1">
    <tr>
        <th>Field</th>
        <th>Value</th>
        <th>Description</th>
    </tr>
    {% for key, value in json_data.items() %}
        <tr>
            <td>{{ key }}</td>
            <td>{{ value }}</td>
            <td>{{ schema["properties"][key]["description"] }}</td>
        </tr>
    {% endfor %}
</table>
```{{copy}}

---

### **4. Save or Deliver the HTML Report**
- Optionally **store the report** in Azure Blob Storage for future retrieval.
- Provide users with an option to **download the report** directly.
- If integrated with Azure Functions, return the HTML as an HTTP response.

---

### **Potential Enhancements**
- **Error Highlighting**: Show invalid fields in **red** in the report.
- **JSON Diff View**: Display differences between user input and the expected schema.
- **Export as PDF**: Convert HTML reports into PDF using `weasyprint` or similar libraries.

Would you like help writing a full example with Azure integration?  
Your project is shaping up to be really useful for validating structured data dynamically!


---

# STEP 2


Great observation, Nicholas! Instead of hardcoding the schema, we can dynamically **fetch** it from a URL. Here’s how to update the code to retrieve the JSON Schema from a remote location using the `requests` module.

---

### **Updated Code: Fetch Schema from URL**
```python
import requests
from jsonschema import validate, ValidationError

# URL of the JSON Schema (replace this with your actual schema URL)
SCHEMA_URL = "https://example.com/schema.json"

def fetch_schema(url):
    """Fetch JSON Schema from the provided URL."""
    response = requests.get(url)
    response.raise_for_status()  # Raise an error if request fails
    return response.json()

# Sample JSON object to validate
json_data = {
    "name": "Nicholas",
    "age": 30,
    "email": "nicholas@example.com"
}

try:
    # Fetch schema dynamically
    schema = fetch_schema(SCHEMA_URL)

    # Validate JSON against the schema
    validate(instance=json_data, schema=schema)
    print("JSON is valid!")
except ValidationError as e:
    print(f"JSON validation error: {e}")
except requests.RequestException as e:
    print(f"Error fetching schema: {e}")
```{{copy}}

---

### **Why This Works Well**
- **Pulls Schema Dynamically**: Instead of embedding the schema in the script, it retrieves it from an external URL.
- **Handles Errors Properly**: Uses `requests.raise_for_status()` to catch issues like missing schema or bad responses.
- **More Flexible**: Allows users to specify different schema URLs based on their needs.

Would you like to integrate caching so the schema isn't fetched on every request? That could speed things up for repeated validations.


# Step three

No problem, Nicholas! Here's the updated version that **fetches the JSON Schema from a URL** but **loads the JSON data from a local file**.

### **Updated Code**
```python
import json
import requests
from jsonschema import validate, ValidationError

# URL of the JSON Schema (replace with your actual schema URL)
SCHEMA_URL = "https://example.com/schema.json"

# Path to the local JSON file
JSON_FILE_PATH = "data.json"

def fetch_schema(url):
    """Fetch JSON Schema from the provided URL."""
    response = requests.get(url)
    response.raise_for_status()  # Raise an error if request fails
    return response.json()

def load_json_from_file(file_path):
    """Load JSON data from a local file."""
    try:
        with open(file_path, "r") as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"Error: JSON file '{file_path}' not found.")
        return None
    except json.JSONDecodeError:
        print(f"Error: JSON file '{file_path}' is not valid.")
        return None

try:
    # Fetch schema dynamically
    schema = fetch_schema(SCHEMA_URL)

    # Load JSON data from local file
    json_data = load_json_from_file(JSON_FILE_PATH)

    if json_data:
        # Validate JSON against the schema
        validate(instance=json_data, schema=schema)
        print("JSON is valid!")
    else:
        print("Skipping validation due to JSON loading error.")
        
except ValidationError as e:
    print(f"JSON validation error: {e}")
except requests.RequestException as e:
    print(f"Error fetching schema: {e}")
```{{copy}}

---

### **Changes & Improvements**
✅ **Loads JSON from a file** (`data.json`) instead of hardcoding it in Python.  
✅ **Handles file errors**, such as missing or invalid JSON files.  
✅ **Still pulls the schema from a URL**, keeping it flexible.  
✅ **Gracefully handles validation errors**, so it's easy to debug.

Would you like to expand this by **generating an HTML report** showing validation results?  
That way, users can see structured validation feedback in a browser! 🚀  

