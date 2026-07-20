# Step 1: Set up InfluxDB & Jupyter

In this step, we will launch our infrastructure using `docker-compose`. This will start both an InfluxDB 2.x instance and a pre-configured Jupyter notebook environment.

### 1. Launch Containers
Run the following command in the `influx` directory to start the services:

`docker-compose up -d`{{exec}}

Verify that both containers are running:

`docker-compose ps`{{exec}}

### 2. Access InfluxDB
Once the containers are running, you can access the InfluxDB UI:

{{TRAFFIC_HOST1_8086}}

*   **Username:** `dbadmin`
*   **Password:** `dbadmin123`
*   **Bucket:** `BUCKET_ONE`

### 3. Verify Connectivity
You can test the connection by creating a new bucket using the Influx CLI inside the container:

`docker-compose exec influxdb influx bucket create --name test-bucket --org MyOrg`{{exec}}

`docker-compose exec influxdb influx bucket list`{{exec}}
