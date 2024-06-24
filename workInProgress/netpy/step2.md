# python


## Run First

`sudo apt update`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}


## Gradio

https://www.gradio.app/guides/quickstart

`mkdir gradio`{{exec}}

`cd gradio`{{exec}}

## clean python install

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install pip-tools`{{exec}}

`touch requirements.in`{{exec}}

```
dnspython
elasticsearch
```{{copy}}

`pip-compile`{{exec}}


`pip install -r requirements.txt`{{exec}}

# pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}

need to check that it's sending data to es check!

## For following, need to

- set the index name with date and time
- create a config file
- review what 'scheme' does. It errored without it
- add a web interface with streamlit (nice to have)

`touch dnsapp.py`{{exec}}

```
import time
import dns.resolver
from elasticsearch import Elasticsearch

# Initialize Elasticsearch client
es = Elasticsearch([{'host': 'localhost', 'port': 9200, 'scheme': 'http'}])  # Update with your Elasticsearch host, port, and scheme

def test_dns_latency(server, domain, repetitions):
    resolver = dns.resolver.Resolver()
    resolver.nameservers = [server]

    total_latency = 0
    for _ in range(repetitions):
        start_time = time.time()
        try:
            resolver.query(domain)
            latency = time.time() - start_time
            total_latency += latency
        except dns.exception.DNSException as e:
            print(f"Error querying DNS server {server} for domain {domain}: {e}")
            return None

    avg_latency = total_latency / repetitions
    return avg_latency

dns_servers = ['8.8.8.8', '1.1.1.1']  # Add more DNS servers to test
domains = ['example.com', 'google.com', 'amazon.com']  # Add more domain names to test
repetitions = 3  # Number of repetitions for each query
iterations = 5  # Number of iterations
delay_between_iterations = 10  # Delay in seconds between iterations

for i in range(iterations):
    for server in dns_servers:
        for domain in domains:
            avg_latency = test_dns_latency(server, domain, repetitions)
            if avg_latency is not None:
                # Send data to Elasticsearch with properly formatted timestamp
                doc = {
                    '@timestamp': time.strftime('%Y-%m-%dT%H:%M:%S', time.gmtime()),
                    'server': server,
                    'domain': domain,
                    'avg_latency': avg_latency
                }
                es.index(index='dns_latency2', body=doc)
                print(f"Iteration {i+1}: Avg latency for DNS server {server} querying domain {domain} over {repetitions} repetitions: {avg_latency} seconds")

    if i < iterations - 1:
        print(f"Waiting for {delay_between_iterations} seconds before next iteration...")
        time.sleep(delay_between_iterations)
```{{cope}}

run the aoo

`python dnsapp.py`{{exec}}

Connect to Kibana


{{TRAFFIC_HOST1_5601}}

And index the data




# follow ups


Here are some additional suggestions to enhance the DNS latency testing program and make it more robust and versatile:

1. **Error Handling**: Implement more robust error handling to gracefully handle exceptions that may occur during DNS queries or Elasticsearch indexing. This can include logging errors, retrying failed queries, and providing informative error messages.

2. **Logging**: Integrate a logging framework (e.g., Python's built-in `logging` module) to log important events, errors, and debugging information. This can help in troubleshooting and monitoring the program's execution.

3. **Configuration Options**: Add configuration options to the script, allowing users to specify parameters such as DNS servers, domain names, repetitions, iterations, delay between iterations, Elasticsearch host, port, and other settings through a configuration file or command-line arguments.

4. **Performance Metrics**: Include additional performance metrics such as jitter calculation, packet loss detection, and response time distribution analysis to provide a more comprehensive view of DNS server performance.

5. **Data Visualization**: Integrate a data visualization library (e.g., Matplotlib or Plotly) to generate graphs and visualizations of DNS latency data over time. This can help in identifying trends and patterns in the data.

6. **Alerting**: Implement an alerting mechanism to notify administrators when DNS latency exceeds predefined thresholds or when errors occur frequently. This can be achieved using email alerts, Slack notifications, or integration with monitoring tools.

7. **Parallel Processing**: Consider implementing parallel processing or asynchronous requests to improve the efficiency of DNS queries and Elasticsearch indexing, especially when testing multiple DNS servers and domains simultaneously.

8. **Unit Testing**: Write unit tests to validate the functionality of critical components of the program, ensuring that it behaves as expected and remains stable across code changes.

9. **Documentation**: Provide comprehensive documentation for the program, including instructions on how to set it up, configure parameters, and interpret the results. This can help users understand and use the program effectively.

By incorporating these suggestions, you can create a more robust and feature-rich DNS latency testing program that provides valuable insights into the performance of DNS servers and facilitates effective monitoring and troubleshooting.

## dashboard


To create a Kibana dashboard for the DNS latency data indexed in Elasticsearch, you can follow these steps to visualize and analyze the data effectively:

1. **Create an Index Pattern**:
   - In Kibana, go to Management > Index Patterns.
   - Click on "Create index pattern" and enter the index pattern name (e.g., `dns_latency*`).
   - Select the timestamp field as the Time Filter field to ensure time-based filtering in visualizations.

2. **Create Visualizations**:
   - Go to Visualize in Kibana and create visualizations based on the DNS latency data. Some suggested visualizations include:
     - Line chart showing average latency over time.
     - Data table displaying latency values for each DNS server and domain.
     - Bar chart showing latency distribution across different domains.
     - Pie chart illustrating latency distribution by DNS server.

3. **Build a Dashboard**:
   - Once you have created the visualizations, go to Dashboard in Kibana.
   - Click on "Create dashboard" and add the visualizations you created to the dashboard layout.
   - Arrange the visualizations to provide a comprehensive view of the DNS latency data.

4. **Add Filters and Interactivity**:
   - Utilize filters in the dashboard to allow users to drill down into specific DNS servers, domains, or time ranges.
   - Add date range filters to enable users to select custom time periods for analysis.

5. **Save and Share the Dashboard**:
   - Save the dashboard in Kibana to access it later or share it with other team members.
   - You can also export the dashboard as a PDF or PNG for reporting purposes.

By following these steps, you can create a Kibana dashboard that provides insights into the DNS latency data collected and indexed in Elasticsearch. Customizing the visualizations and dashboard layout based on your specific requirements will help in monitoring and analyzing the performance of DNS servers effectively.
