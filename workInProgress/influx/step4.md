# Step 4: Cleanup

In this final step, we will tear down our infrastructure to ensure a clean environment.

### 1. Stop and Remove Containers
Navigate to the `influx` directory and run:

`docker-compose down -v`{{exec}}

*Note: The `-v` flag also removes the named volumes created for InfluxDB data, ensuring that all data generated during this lab is cleaned up.*

### 2. Verify
Check that no containers are running:

`docker-compose ps`{{exec}}
