Now that the stack is running, Telegraf should be collecting metrics and sending them to InfluxDB. Let's verify that the data is arriving as expected.

We can execute a command inside the `influxdb` container to query the database. The following command shows the "measurements" (which are like tables in a relational database) that Telegraf is writing to.

```bash
docker exec influxdb influx -database telegraf -execute 'SHOW MEASUREMENTS'
```{{exec}}

You should see a list of measurements like `cpu`, `disk`, `mem`, `net`, and `system`. This confirms that Telegraf is successfully collecting and storing different types of system metrics.

Next, let's query one of these measurements to see the actual data points. The following command retrieves the last 5 entries from the `cpu` measurement.

```bash
docker exec influxdb influx -database telegraf -execute 'SELECT * FROM cpu LIMIT 5'
```{{exec}}

The output will show you detailed CPU metrics with timestamps, proving that your data collection pipeline is working correctly.
