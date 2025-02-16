# REMOVE

# python

`pip install applicationinsights`{{exec}}

`touch app.py`{{exec}}


add the code:

```

from flask import Flask
from applicationinsights import TelemetryClient

app = Flask(__name__)

# Initialize the Application Insights telemetry client
instrumentation_key = 'YOUR_INSTRUMENTATION_KEY'
client = TelemetryClient(instrumentation_key)

@app.route('/')
def hello_world():
    # Log a custom event when the hello_world route is called
    client.track_event('hello_world_called', {'message': 'Hello, World!'})

    return 'Hello, World!'

if __name__ == '__main__':
    app.run()

```

`python app.py`{{exec}}

In a seperate tab

`curl localhost:5000`{{exec}}
