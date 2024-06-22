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

**REVIEW** https://pypi.org/project/pip-tools/

`touch requirements.in`{{exec}}

`echo gradio/ntensorflow/ntransformers > requirements.in`{{copy}}

`pip-compile`{{exec}} # takes a while


`pip install -r requirements.txt`{{exec}}

# pipdeptree

`pip install pipdeptree`{{execute}}

`pipdeptree -h`{{execute}}



'''
import time
import dns.resolver

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
                print(f"Iteration {i+1}: Avg latency for DNS server {server} querying domain {domain} over {repetitions} repetitions: {avg_latency} seconds")
    
    if i < iterations - 1:
        print(f"Waiting for {delay_between_iterations} seconds before next iteration...")
        time.sleep(delay_between_iterations)
'''