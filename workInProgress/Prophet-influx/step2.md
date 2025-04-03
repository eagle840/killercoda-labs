
1. Open the prophet.ipynb in notebook


3. Install Prophet in the Jupyter notebook container:
```
!pip install fbprophet
```{{exec}}

pip install pystan
pip install pandas
pip install prophet
pip install influxdb-client

https://docs.influxdata.com/influxdb/cloud/api-guide/client-libraries/python/
https://facebook.github.io/prophet/docs/quick_start.html



To get some data from the internet and populate the InfluxDB with it, you can use the following example:

1. Download sample data from the internet:

see link above (ie https://docs.influxdata.com/influxdb/cloud/reference/sample-data/)
```
wget https://raw.githubusercontent.com/influxdata/influxdb/master/models/energy_usage/energy_usage.txt
```{{exec}}

2. Import the data into InfluxDB:
```
docker cp energy_usage.txt influxdb:/tmp
docker exec -it influxdb influx -import -path=/tmp/energy_usage.txt -precision=s
```{{exec}}

TRY

Calender Icon > Task > paste sample from  https://docs.influxdata.com/influxdb/cloud/reference/sample-data/

Now, to run Prophet against the data in InfluxDB, you can use the following steps:


# prophet quickstart

https://facebook.github.io/prophet/docs/quick_start.html

```
# Python
import pandas as pd
from prophet import Prophet
```

```
# Python
df = pd.read_csv('https://raw.githubusercontent.com/facebook/prophet/main/examples/example_wp_log_peyton_manning.csv')
df.head()
```

```
# Python
m = Prophet()
m.fit(df)
```

```
# Python
future = m.make_future_dataframe(periods=365)
future.tail()
```

```
# Python
forecast = m.predict(future)
forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()
```

```
# Python
fig1 = m.plot(forecast)
```

```
# Python
fig2 = m.plot_components(forecast)
```


WIP? Can I import that CSV into Influx and then run the code against influx?



### chatGPT

1. Connect to the Jupyter notebook container:
```
docker exec -it prophet bash
```{{exec}}

2. Start a Jupyter notebook server:
```
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root
```{{exec}}

3. In the Jupyter notebook, you can run the following Python code to load data from InfluxDB and run Prophet on it:
```python
from influxdb import InfluxDBClient
from fbprophet import Prophet

client = InfluxDBClient('localhost', 8086, 'root', 'root', 'mydb')
result = client.query('SELECT * FROM energy_usage')

df = result.raw['series'][0]['values']
df = pd.DataFrame(df, columns=['time', 'value'])

df['time'] = pd.to_datetime(df['time'])
df = df.rename(columns={'time': 'ds', 'value': 'y'})

m = Prophet()
m.fit(df)

future = m.make_future_dataframe(periods=365)
forecast = m.predict(future)
```{{exec}}

This code will load data from InfluxDB, create a Prophet model, fit the model to the data, and generate a forecast for the future time periods.

graph TD
    A[Signal] --> B[Growth/Trend]
    A --> C[Seasonal]
    A --> D[Holiday]
    A --> K[Noise]

    B --> E[Linear Growth]
    B --> F[Logistic Growth]

    C --> G[Yearly Seasonality]
    C --> H[Weekly Seasonality]
    C --> I[Daily Seasonality]

    D --> J[Holiday Effects]

    K --> L[Random Fluctuations]
