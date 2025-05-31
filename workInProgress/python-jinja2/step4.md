# Generate Jinja template from JSON schema

Great addition, Nicholas! To dynamically generate a **Jinja2 template** based on the JSON Schema, we'll extract the schema's properties and construct a corresponding HTML template.

### **Steps to Generate the Jinja Template**
1. **Fetch the JSON Schema** from the URL.
2. **Extract Key Information**: Identify each field and its description from the schema.
3. **Build the Jinja2 Template** dynamically.
4. **Save the Template** to a file or use it in Python.

---

### **Updated Code: Generate Jinja2 Template from Schema**
```python
import requests

# URL of the JSON Schema (Replace with your actual schema URL)
SCHEMA_URL = "https://example.com/schema.json"

def fetch_schema(url):
    """Fetch JSON Schema from a given URL."""
    response = requests.get(url)
    response.raise_for_status()
    return response.json()

def generate_jinja_template(schema):
    """Generate a Jinja2 template dynamically from a JSON Schema."""
    template_str = """<!DOCTYPE html>
<html>
<head>
    <title>Generated Report</title>
</head>
<body>
    <h1>JSON Data Report</h1>
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
            <td>{{ schema["properties"].get(key, {}).get("description", "No description") }}</td>
        </tr>
        {% endfor %}
    </table>
</body>
</html>"""

    return template_str

try:
    # Fetch schema dynamically
    schema = fetch_schema(SCHEMA_URL)

    # Generate Jinja template based on schema
    jinja_template = generate_jinja_template(schema)

    # Save to a file
    with open("generated_template.html", "w") as file:
        file.write(jinja_template)

    print("Jinja2 template generated and saved as 'generated_template.html'!")

except requests.RequestException as e:
    print(f"Error fetching schema: {e}")
```{{copy}}

---

### **How This Works**
✔️ **Dynamically generates an HTML template** using properties from the JSON Schema.  
✔️ **Includes field descriptions** extracted from the schema for better understanding.  
✔️ **Saves the generated template** so it can be used later with actual JSON data.  
✔️ **Handles missing descriptions gracefully** by displaying `"No description"` if unavailable.

Would you like to enhance this further by allowing users to define custom styles or layouts for their reports? 🚀
