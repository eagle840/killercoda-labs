# Step 2: Data Ingestion

In this step, we will ingest sample USGS earthquake data into InfluxDB to create a dataset with meaningful trends suitable for time-series forecasting.

### 1. Ingest Sample Data
We will use a Flux task to automatically populate our bucket with USGS sample data.

Run the following command to create and run the task in one step:

```bash
docker-compose exec influxdb influx task create --org MyOrg --flux '
import "influxdata/influxdb/sample"

option task = {name: "earthquake-ingestion", every: 1h}

sample.data(set: "usgs")
    |> to(bucket: "BUCKET_ONE")
'
```{{exec}}

*Note: You can verify the data ingestion in the InfluxDB UI (Graph icon -> Select `earthquake` measurement).*
