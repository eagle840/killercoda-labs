# Step 4: Orchestrate Agent

Now, let's extend the script to actually perform the analysis.

Add this logic to the bottom of your `agent.py`:

```python
# List and Analyze
response = s3.list_objects_v2(Bucket='file-organizer-bucket')
for obj in response.get('Contents', []):
    category = analyze_file(obj['Key'])
    print(f"File: {obj['Key']} -> Category: {category}")
```

### Run the Agent
Execute your agent:

`python3 agent.py`{{exec}}
