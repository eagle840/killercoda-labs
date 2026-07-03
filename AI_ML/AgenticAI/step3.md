# Step 3: Prepare Agent Code

We need a Python script to bridge S3 and the LLM. 

Create a file named `agent.py`:

```python
import boto3
import ollama
import json

# Setup MiniStack connection
s3 = boto3.client('s3', 
                  endpoint_url='http://localhost:4566',
                  aws_access_key_id='test',
                  aws_secret_access_key='test',
                  region_name='us-east-1')

def analyze_file(filename):
    prompt = f"Categorize this file as 'text', 'image', or 'other' based on its name: {filename}. Return ONLY the category name."
    response = ollama.chat(model='qwen2.5:0.5b', messages=[{'role': 'user', 'content': prompt}])
    return response['message']['content'].strip()

# Create dummy files
with open('test.txt', 'w') as f: f.write('hello')
with open('photo.jpg', 'w') as f: f.write('data')

# Upload to S3
s3.upload_file('test.txt', 'file-organizer-bucket', 'test.txt')
s3.upload_file('photo.jpg', 'file-organizer-bucket', 'photo.jpg')

print("Files uploaded. Ready for analysis.")
```

### Setup Python Environment
Create and activate a virtual environment to manage dependencies cleanly:

`python3 -m venv venv`{{exec}}
`source venv/bin/activate`{{exec}}

Now, install `boto3` and `ollama` libraries:
`pip install boto3 ollama`{{exec}}
