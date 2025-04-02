# python influx client

https://pypi.org/project/influxdb-client/

https://docs.influxdata.com/influxdb/v2/api-guide/client-libraries/python/

`touch influx1.ipynb`{{exec}}

WIP code is broken

```
{
    "cells": [
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "!pip install influxdb-client\n"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "import influxdb_client\n",
                "\n",
                "from influxdb_client.client.write_api import SYNCHRONOUS\n",
                "url = \"http://localhost:8086\"\n",
                "token = \"your-token\"\n",
                "org = \"your-org\"\n",
                "bucket = \"your-bucket\"\n",
                "\n",
                "# Instantiate the client\n",
                "client = InfluxDBClient(url=url, token=token, org=org)\n",
                "\n",
                "# Write data\n",
                "write_api = client.write_api()\n",
                "point = influxdb_client.Point(\"measurement\").tag(\"location\", \"Prague\").field(\"temperature\", 25.3)\n",
                "write_api.write(bucket=bucket, org=org, record=point)\n",
                "\n",
                "# Query data\n",
                "query_api = client.query_api()\n",
                "query = 'from(bucket:\"my-bucket\") |> range(start: -10m) |> filter(fn:(r) => r._measurement == \"measurement\")'\n",
                "tables = query_api.query(query)\n",
                "\n",
                "for table in tables:\n",
                "    for record in table.records:\n",
                "        print(f\"{record['_time']} - {record.get_measurement()} {record.get_field()}={record.get_value()}\")\n"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "from influxdb_client import InfluxDBClient\n",
                "\n",
                "# Define your connection parameters\n"
            ]
        },
        {
            "cell_type": "code",
            "execution_count": null,
            "metadata": {},
            "outputs": [],
            "source": [
                "from influxdb_client import InfluxDBClient\n",
                "\n",
                "# Define your connection parameters\n"
            ]
        }
    ],
    "metadata": {},
    "nbformat": 4,
    "nbformat_minor": 4
}
```{{copy}}
