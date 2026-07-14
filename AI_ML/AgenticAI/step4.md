# Step 4: Orchestrate Agent

Now, let's complete the script to perform the analysis and tag the files.

### Orchestration Logic
This final step executes the core agent workflow:
1. **Lists** all files currently in your S3 bucket.
2. **Iterates** through each file.
3. **Invokes** the `analyze_file` function (defined in Step 3) to trigger the LLM inference and determine the file's category.
4. **Tags** the S3 object with the category returned by the AI, completing the automation loop.

Update your `agent.py` script by adding the following logic:

```python
# List, Analyze, and Tag
response = s3.list_objects_v2(Bucket='file-organizer-bucket')
for obj in response.get('Contents', []):
    category = analyze_file(obj['Key'])
    print(f"File: {obj['Key']} -> Category: {category}")
    tag_file(obj['Key'], category)
    print(f"Tagged {obj['Key']} with Category={category}")
```

### Run the Agent
Execute your agent:

`python3 agent.py`{{exec}}

### Verify Tags
Check that the files were correctly tagged in S3:

`awslocal s3api get-object-tagging --bucket file-organizer-bucket --key test.txt`{{exec}}
`awslocal s3api get-object-tagging --bucket file-organizer-bucket --key photo.jpg`{{exec}}
