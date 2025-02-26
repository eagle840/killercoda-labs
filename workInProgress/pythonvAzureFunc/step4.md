# Advanced

see: https://techcommunity.microsoft.com/blog/azurecompute/azure-functions-v2-python-programming-model/3665168

## v1 vs v2

## Blue prints

# Triggere and Bindings

v1 vs v2

We've already covered http

function.json is not needed  since it's definifions are in the python program. Other  langauges made need it.



https://learn.microsoft.com/en-gb/azure/azure-functions/functions-triggers-bindings?tabs=isolated-process%2Cnode-v4%2Cpython-v2&pivots=programming-language-python

### checking for methods (methods=["GET","POST")

method = req.method

But you should really use a function for each method

### changing routes

@app.route(route="widgets/{id:int?})".... # ? makes it optional

to pull: item_id = req.route_params.get('id')

# Authorization Levels


# Durable Functions (statefull)

## PUll data from new file storage account queue

## send data to blob

## ideas:

gpt:I need to come up with an example python function app that uses Azure Storage Queue and Azure Store Blob. Give me some ideas, keep them every high level

answer@
Here are some high-level ideas for a Python Azure Function app that uses Azure Storage Queue and Azure Blob Storage:

1. Image Processing Pipeline:
   - Trigger: Azure Storage Queue
   - Action: Retrieve messages from the queue containing image URLs.
   - Process: Download the images from the URLs and perform image processing tasks (e.g., resizing, watermarking).
   - Output: Store the processed images in Azure Blob Storage.

2. File Transfer Service:
   - Trigger: Azure Blob Storage (new file uploaded)
   - Action: Monitor a specific container in Azure Blob Storage for new files.
   - Process: Transfer the files to a different storage account or location.
   - Output: Log transfer status and store transferred files in another container.

3. Data Archiving System:
   - Trigger: Timer Trigger (e.g., daily)
   - Action: Retrieve data files from Azure Blob Storage based on a schedule.
   - Process: Compress the data files and archive them for long-term storage.
   - Output: Store the archived files in a separate container in Azure Blob Storage.

4. IoT Data Processing:
   - Trigger: Azure Storage Queue (messages from IoT devices)
   - Action: Receive messages from the queue containing IoT sensor data.
   - Process: Analyze the sensor data and extract insights or perform real-time processing.
   - Output: Store the processed data or results in Azure Blob Storage for further analysis.

5. Backup and Restore Service:
   - Trigger: HTTP Trigger (API endpoint)
   - Action: Receive requests to backup or restore data.
   - Process: Backup data from Azure Blob Storage to another storage account or restore data from a backup.
   - Output: Provide status updates and logs for backup and restore operations.

These are just a few examples of how you can leverage Azure Storage Queue and Azure Blob Storage in a Python Azure Function app. You can customize and expand upon these ideas based on your specific requirements and use cases.
