# System Info

lets figure out what system we're running on

Here’s a small Python script that gathers several indicators of a system’s compute resources:

- CPU: Logical and physical core count
- CPU Frequency
- Total Memory & Available Memory
- Total Disk & Free Disk
- GPU info (optional, if nvidia-smi present)
- OS & Python version

This script uses the psutil and platform modules. GPU info (if available) is fetched via nvidia-smi.

`pip install psutil`{{exec}}

`touch sys_summary.py`{{exec}}

and run

`python sys_summary.py`{{exec}}

copy the following into:

```
import os
import platform
import psutil
import shutil
import subprocess
import sys

def bytes2human(n):
    # Converts bytes to a readable format
    symbols = ('B', 'KB', 'MB', 'GB', 'TB', 'PB')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i * 10)
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = float(n) / prefix[s]
            return '%.1f %s' % (value, s)
    return "%s B" % n

def get_gpu_info():
    try:
        result = subprocess.check_output(
            "nvidia-smi --query-gpu=name,memory.total,memory.free --format=csv,noheader,nounits",
            shell=True
        ).decode().strip()
        if result:
            gpus = []
            for line in result.split('\n'):
                name, total, free = [x.strip() for x in line.split(',')]
                gpus.append({
                    'Name': name,
                    'Memory Total': f'{total} MB',
                    'Memory Free': f'{free} MB'
                })
            return gpus
    except Exception:
        return None

def main():
    print("System Summary")
    print("="*40)

    # CPU Info
    print(f"Physical CPUs (cores): {psutil.cpu_count(logical=False)}")
    print(f"Logical CPUs (threads): {psutil.cpu_count(logical=True)}")
    freq = psutil.cpu_freq()
    if freq:
        print(f"CPU Frequency: {freq.current:.2f} MHz")
    print(f"CPU Usage: {psutil.cpu_percent(interval=1)}%")

    # Memory Info
    vm = psutil.virtual_memory()
    print(f"Memory Total: {bytes2human(vm.total)}")
    print(f"Memory Available: {bytes2human(vm.available)}")

    # Disk Info (root partition)
    root_usage = shutil.disk_usage(os.path.abspath(os.sep))
    print(f"Disk Total: {bytes2human(root_usage.total)}")
    print(f"Disk Used: {bytes2human(root_usage.used)}")
    print(f"Disk Free: {bytes2human(root_usage.free)}")

    # GPU Info
    gpus = get_gpu_info()
    if gpus:
        print("\nGPU(s):")
        for i, gpu in enumerate(gpus):
            print(f"  GPU {i}: {gpu['Name']} ({gpu['Memory Free']} free of {gpu['Memory Total']})")
    else:
        print("\nGPU(s): None detected or nvidia-smi not available.")

    # System & Python Info
    print("\nSystem:", platform.platform())
    print("Python:", sys.version.split()[0])

if __name__ == '__main__':
    main()
```{{copy}}


# linting

## pylint

`pip install pylint`{{execute}}

`pylint`{{execute}}



## flake8

`pip install flake8`{{execute}}

`flake8`{{execute}}


# Environment Variables

There are three main ways to store environment variables: memory, in code, and in a file.

---

## 🧠 1. In Memory

You can set environment variables dynamically within your Python program using the `os.environ` dictionary:

```python
import os
value = os.environ["varix"] # to pull it from the working O/S environment OR:
value = os.getenv["varix"] 
os.environ['API_KEY'] = 'my-secret-key' # to set it in the programs working environment
```

These variables exist only during the lifetime of the program and are accessible using `os.getenv('API_KEY')`.

---

## 🖊️ 2. In Code (Hardcoded)

Though possible, hardcoding configuration variables directly in source code is discouraged:

```python
API_KEY = 'my-secret-key'
```

🔒 **Why avoid this?** Hardcoding secrets increases the risk of accidental exposure, especially when code is shared or committed to version control.

---

## 📄 3. In a File (`.env`)

A `.env` file stores environment variables in key-value format:

```
API_KEY=my-secret-key
DEBUG=True
```

This file is typically excluded from version control for security. To load its contents into your Python environment:

```python
from dotenv import load_dotenv, find_dotenv
import os

load_dotenv(find_dotenv())  # Searches for and loads the .env file
api_key = os.getenv('API_KEY')
```

---

