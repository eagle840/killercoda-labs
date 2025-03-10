
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





## 2. Pull and run Juypter


Here's how you can achieve this step by step:

### 1. Create an example notebook file
First, create a simple Jupyter notebook file on your local machine. Here's an example:

WIP you may have to chmod the dir, since jupyter is complaining about file premissions


`chmod u+w <dir>/<file>`

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

### 2. Create a Docker volume and add the notebook

Now, create a Docker volume and copy the notebook into it.



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
