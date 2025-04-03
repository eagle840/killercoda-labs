
'https://killercoda.com/ir4engineer/course/workInProgress/influx_and_faker' running first!

To set up InfluxDB and Prophet in Docker, you can use the following commands:

## 1. Pull and run InfluxDB Docker container:


WIP make this a daemon (sometimes the terminal crashes and you lose the running container)

```
docker run \
 --name influxdb2 \
 --publish 8086:8086 \
 --mount type=volume,source=influxdb2-data,target=/var/lib/influxdb2 \
 --mount type=volume,source=influxdb2-config,target=/etc/influxdb2 \
 --env DOCKER_INFLUXDB_INIT_MODE=setup \
 --env DOCKER_INFLUXDB_INIT_USERNAME=dbadmin \
 --env DOCKER_INFLUXDB_INIT_PASSWORD=dbadmin123 \
 --env DOCKER_INFLUXDB_INIT_ORG=MyOrg \
 --env DOCKER_INFLUXDB_INIT_BUCKET=BUCKET_ONE \
 influxdb:2
 ```{{exec}}


{{TRAFFIC_HOST1_8086}}


user name  `dbadmin`

password `dbadmin123`

bucket name: `BUCKET_ONE`

## Test db


https://docs.influxdata.com/influxdb/v2/get-started/write/?t=influx+CLI

`docker exec -it influxdb2 bash`{{exec}}

Inside docker:

`influx version`{{exec}}

`influx --help`{{exec}}

`influx config ls`{{exec}}

`influx server-config`{{exec}}


`influx bucket create --name get-started`{{exec}}

`influx bucket list`{{exec}}

```
influx write \
  --bucket get-started \
  --precision s "
home,room=Living\ Room temp=21.1,hum=35.9,co=0i 1641024000
home,room=Kitchen temp=21.0,hum=35.9,co=0i 1641024000
home,room=Living\ Room temp=21.4,hum=35.9,co=0i 1641027600
home,room=Kitchen temp=23.0,hum=36.2,co=0i 1641027600
home,room=Living\ Room temp=21.8,hum=36.0,co=0i 1641031200
home,room=Kitchen temp=22.7,hum=36.1,co=0i 1641031200
home,room=Living\ Room temp=22.2,hum=36.0,co=0i 1641034800
home,room=Kitchen temp=22.4,hum=36.0,co=0i 1641034800
home,room=Living\ Room temp=22.2,hum=35.9,co=0i 1641038400
home,room=Kitchen temp=22.5,hum=36.0,co=0i 1641038400
home,room=Living\ Room temp=22.4,hum=36.0,co=0i 1641042000
home,room=Kitchen temp=22.8,hum=36.5,co=1i 1641042000
home,room=Living\ Room temp=22.3,hum=36.1,co=0i 1641045600
home,room=Kitchen temp=22.8,hum=36.3,co=1i 1641045600
home,room=Living\ Room temp=22.3,hum=36.1,co=1i 1641049200
home,room=Kitchen temp=22.7,hum=36.2,co=3i 1641049200
home,room=Living\ Room temp=22.4,hum=36.0,co=4i 1641052800
home,room=Kitchen temp=22.4,hum=36.0,co=7i 1641052800
home,room=Living\ Room temp=22.6,hum=35.9,co=5i 1641056400
home,room=Kitchen temp=22.7,hum=36.0,co=9i 1641056400
home,room=Living\ Room temp=22.8,hum=36.2,co=9i 1641060000
home,room=Kitchen temp=23.3,hum=36.9,co=18i 1641060000
home,room=Living\ Room temp=22.5,hum=36.3,co=14i 1641063600
home,room=Kitchen temp=23.1,hum=36.6,co=22i 1641063600
home,room=Living\ Room temp=22.2,hum=36.4,co=17i 1641067200
home,room=Kitchen temp=22.7,hum=36.5,co=26i 1641067200
"
```{{exec}}

## query

https://docs.influxdata.com/influxdb/v2/get-started/query/?t=influx+CLI


**influx query**



```
influx query '
from(bucket: "get-started")
    |> range(start: 2022-01-01T08:00:00Z, stop: 2022-01-01T20:00:01Z)
    |> filter(fn: (r) => r._measurement == "home")
    |> filter(fn: (r) => r._field== "co" or r._field == "hum" or r._field == "temp")
'
```{{exec}}

**InfluxQL**

First enter the shell
`influx v1 shell`{{exec}}

```
SELECT co,hum,temp,room FROM "get-started".autogen.home WHERE time >= '2022-01-01T08:00:00Z' AND time <= '2022-01-01T20:00:00Z'
```{{exec}}

**ESC** and 'exit'

### GUI

Select the 'get-started` bucket and set the custom time range to over the 2022-01-01 00:01 to 2022-01-02 00:01

Select 'home'
set Table type
click `submey

# Populate db with sample data.

WIP: would it be better to use the Air Sample data, since there would be trends (for FB prophet)?

See: https://docs.influxdata.com/influxdb/cloud/reference/sample-data/#usgs-earthquake-data

Note that we have changed the bucket name in the script below.

Lets populate the db with some data that is live.

Open the GUI, and click the calendar icon on the left.

Create a new task, and run now. You should see success in the logs.

```
import "influxdata/influxdb/sample"

option task = {name: "earthquake", every: 1h}

sample.data(set: "usgs")
    |> to(bucket: "BUCKET_ONE")

```{{copy}}

## view

Click the graph icon

select 'earthquake', the 'depth'.
select 'Table' in top left.
select 'view raw data' in center.
selecr `past 24h` in time selector
click `SUBMIT`


## 2. Pull and run Juypter


Here's how you can achieve this step by step:

### 1. Create an example notebook file
First, create a simple Jupyter notebook file on your local machine. Here's an example:

WIP you may have to chmod the dir, since jupyter is complaining about file premissions


`chmod u+w <dir>/<file>`

`touch example_notebook.ipynb`{{exec}}

Copy the code low

wip consider anaconda

#### **File: `example_notebook.ipynb`**
```json
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Simple Notes\n",
    "This is an example notebook containing simple notes."
   ]
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "!pip install pandas statsmodels scikit-learn matplotlib seaborn prophet"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "import pandas as pd\n","from prophet import Prophet"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "df = pd.read_csv('https://raw.githubusercontent.com/facebook/prophet/main/examples/example_wp_log_peyton_manning.csv')\n", "df.head()"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "m = Prophet()\n", "m.fit(df)"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "future = m.make_future_dataframe(periods=365)\n","future.tail()"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "forecast = m.predict(future)\n","forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']].tail()\n"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "fig1 = m.plot(forecast)"
   ],
   "outputs": [],
   "execution_count": null
  },
  {
   "cell_type": "code",
   "metadata": {},
   "source": [
    "fig2 = m.plot_components(forecast)"
   ],
   "outputs": [],
   "execution_count": null
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.8.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
```{{copy}}

Save this content in a file named `example_notebook.ipynb`.

---

### 2. install juypter

https://jupyter.org/

`python -V`{{exec}}

`apt install -y python3-venv`{{exec}}

`python -m venv .venv`{{exec}}

`source ./.venv/bin/activate`{{exec}}

`pip install notebook`{{exec}}

`#jupyter server list | grep -oP 'token=\K[^ ]+'`{{exec}}

`jupyter -h`{{exec}}

`jupyter notebook --allow-root --ip=0.0.0.0 `{{exec}}

Note the key in the output, needed to get into the portal

{{TRAFFIC_HOST1_8888}}

### 2. WIP Remove, or move to pythonvenv? Create a Docker volume and add the notebook

Now, create a Docker volume and copy the notebook into it.

WIP:might be quicker to start in host

Run the following commands:
```bash
# Create a Docker volume
docker volume create jupyter_volume

# Copy the notebook to the volume
docker run --rm -v jupyter_volume:/data -v "$(pwd)":/host busybox cp /host/example_notebook.ipynb /data/
```{{exec}}
This creates a volume named `jupyter_volume` and places the `example_notebook.ipynb` file in it.



### 3. Start the Jupyter notebook with the volume attached
You can now start the Jupyter notebook container with the volume mounted:

WIP why `/home/jovyan/work` ?

`docker run -it -p 8888:8888 --name prophet -v jupyter_volume:/home/jovyan/work jupyter/datascience-notebook`{{exec}}

---

### 4. Access the Jupyter notebook

When you ran the jupyter container, you will see a token output, if you can't see it, run:

`docker exec prophet jupyter server list | grep -oP 'token=\K[^ ]+'`{{exec}}

goto {{TRAFFIC_HOST1_8888}} and enter the token.



WIP:
When creating a new notebook
```
[I 2025-03-10 08:31:35.991 ServerApp] Creating new notebook in /work
[W 2025-03-10 08:31:36.042 ServerApp] 403 POST /api/contents/work?1741595495958 (10.244.4.127): Permission denied: work/Untitled.ipynb
[W 2025-03-10 08:31:36.044 ServerApp] wrote error: 'Permission denied: work/Untitled.ipynb'
```

record down the api key

enter token from

## Pull sample data

https://docs.influxdata.com/influxdb/cloud/reference/sample-data/

replace the bucket name with 'BUCKET_ONE'
