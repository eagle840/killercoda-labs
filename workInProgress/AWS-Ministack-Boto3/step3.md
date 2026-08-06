# Step 3: Jupyter Lab and Boto3

Now we will launch Jupyter Lab and use `boto3` to interact with MiniStack.

### 1. Launch Jupyter Lab
Ensure your virtual environment is still active, then launch Jupyter Lab:

```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```{{exec}}

copy the key in the output, you'll need it to log into juypter

*Note: In the Killercoda environment, you will be able to access the Jupyter interface through the provided port access.*

{{TRAFFIC_HOST1_8888}}

### 2. Connect Boto3 to MiniStack
In a new Jupyter notebook, create a client that points to your local MiniStack endpoint instead of the real AWS.

```python
import boto3

# Initialize S3 client pointing to MiniStack
s3 = boto3.client(
    's3',
    endpoint_url='http://localhost:4566',
    aws_access_key_id='test',
    aws_secret_access_key='test',
    region_name='us-east-1'
)

# List buckets to confirm connection
response = s3.list_buckets()
print(response['Buckets'])
```

### 3. Documentation
Refer to the [official Boto3 documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) for detailed API references to expand your exercises.
