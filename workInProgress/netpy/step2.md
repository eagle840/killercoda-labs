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

`pip-compile`{{exec}} # takes a while


`pip install -r requirements.txt`{{exec}}

# pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}

need to check that it's sending data to es check!

need to

- set the index name with date and time 
- create a config file
- review what 'scheme' does. It errored without it
- add a web interface with streamlit (nice to have)

'''
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
'''