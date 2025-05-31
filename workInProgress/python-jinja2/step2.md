Below is a complete Katacoda lab markdown page that walks users through setting up the Python script to render HTML from JSON using Jinja2. You can copy this content into your Katacoda scenario configuration.

---

# Render HTML from JSON using Jinja2

Welcome to this lab, where you'll learn how to use the [Jinja2](https://palletsprojects.com/p/jinja/) templating engine in Python to transform JSON data into a dynamic HTML document. This lab demonstrates how to install Jinja2, create a Python script with a Jinja2 template, and generate an HTML file that you can preview in your browser.

---

## Objectives

- Install Jinja2 via pip.
- Create a Python script that uses a Jinja2 template.
- Render a sample JSON dataset into an HTML file.
- View the generated HTML output.

---

## Step 1: Install Jinja2

First, make sure you have [Python 3](https://www.python.org/) installed in your Katacoda environment. Then, open your terminal and run:

```bash
pip install jinja2
```{{exec}}

This command installs Jinja2, the templating engine we'll use to generate HTML from JSON.

---

## Step 2: Create the Python Script

Next, create a new file named `render_html.py` by using your favorite text editor (e.g., `nano`, `vim`, or the built-in editor in your environment).

`touch render_html.py`{{exec}}

Paste the following code into `render_html.py`:

```python
from jinja2 import Template

# Sample JSON data
data = {
    "name": "Nicholas",
    "role": "Developer",
    "projects": [
        {"title": "Azure Function App", "status": "In Progress"},
        {"title": "AI Chatbot", "status": "Completed"}
    ]
}

# Jinja2 template string
template_str = """<!DOCTYPE html>
<html>
<head>
    <title>Project Status</title>
</head>
<body>
    <h1>Hello, {{ name }}!</h1>
    <h2>Your Role: {{ role }}</h2>
    <h3>Projects:</h3>
    <ul>
        {% for project in projects %}
            <li>{{ project.title }} - {{ project.status }}</li>
        {% endfor %}
    </ul>
</body>
</html>"""

# Render the HTML using Jinja2
template = Template(template_str)
html_output = template.render(data)

# Save the HTML to output.html
with open("output.html", "w") as file:
    file.write(html_output)

print("HTML file generated successfully: output.html")
```{{copy}}

This script does the following:

- Defines a JSON-like data structure.
- Sets up a Jinja2 template with placeholders and a loop to iterate over projects.
- Renders the template with the given data.
- Writes the rendered HTML page to an `output.html` file.

---

## Step 3: Run the Script

Return to your terminal and run the script by executing:

```bash
python render_html.py
```{{exec}}

You should see a message confirming that `output.html` has been generated.

---

## Step 4: View the Output

Now, to view your rendered HTML, open the `output.html` file in a web browser. You can list the file with:

```bash
ls -l output.html
```{{exec}}

If your Katacoda environment supports web preview, you can click on or navigate to the preview link to see your HTML page beautifully rendered.

`python -m http.server 8000`{{exec}}

For example, the rendered page should greet you with:

- A headline saying "Hello, Nicholas!"
- Your role as "Developer".
- A list of your projects along with their status.

The rendered HTML directly reflects the JSON values you defined in your Python script.

---

## Summary

In this lab, you've learned how to:

- Install Jinja2 using pip.
- Use a Jinja2 template to dynamically generate HTML.
- Integrate JSON data into a templated HTML document.
- Save and view the generated HTML file.

This is a foundational step that can be extended further. Imagine integrating this into an Azure Function App to process API requests or storing the HTML output in Azure Blob Storage for distributed web applications.

Happy coding, and feel free to experiment with the template to suit your own projects!

---

Would you like to explore further enhancements, such as adding CSS to style your HTML or integrating this with Azure Blob Storage for automated outputs?