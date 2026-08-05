# Step 3: Build CLI

Let's write a simple CLI script `weather.py` that fetches some data using `requests`.

1. Create `weather.py` with the following content:
```python
import requests

def get_weather():
    # Simple placeholder to demonstrate functionality
    print("Fetching weather data...")
    # In a real app, you'd use an API key here
    # response = requests.get("https://api.example.com/weather")
    print("Weather: Sunny, 25°C")

if __name__ == "__main__":
    get_weather()
```{{copy}}

2. Run the script using `uv run`:
```bash
uv run weather.py
```{{exec}}
