With our configuration files in place, it's time to launch the monitoring stack. We will use `docker-compose` to start all the services defined in our `docker-compose.yaml` file.

Execute the following command to start the containers in detached mode (`-d`):

```bash
docker-compose up -d
```{{exec}}

This command will pull the required Docker images and start the `influxdb`, `telegraf`, and `grafana` containers.

Once the command completes, you can verify that all containers are running correctly.

```bash
docker ps
```{{exec}}

You should see three running containers: `influxdb`, `telegraf`, and `grafana`. This confirms that our stack is up and running.

Finally, let's inspect the Telegraf logs to confirm that it's collecting and sending data.

```bash
docker logs telegraf
```{{exec}}

Look for lines in the output containing `Wrote metrics`. This message confirms that Telegraf is successfully sending the collected data to InfluxDB.