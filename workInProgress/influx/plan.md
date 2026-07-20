# Lab Plan: InfluxDB & Time-Series Forecasting

**Objective:** Set up an InfluxDB instance, ingest sample time-series data, and build a forecasting pipeline using Python and Prophet within a Jupyter environment.

## Steps

1.  **Introduction (`intro.md`):** Briefly explain InfluxDB's purpose as a TSDB and the goal of the lab (forecasting time-series data).
2.  **Step 1: Setup InfluxDB (`step1.md`)**
    *   Deploy InfluxDB 2.x as a Docker container (daemonized).
    *   Configure initial bucket/org/user credentials via environment variables.
    *   Verify connectivity using CLI/HTTP.
3.  **Step 2: Data Ingestion (`step2.md`)**
    *   Use the InfluxDB CLI/API to ingest sample datasets (e.g., USGS Earthquake data) to provide meaningful trends for forecasting.
4.  **Step 3: Forecasting with Prophet (`step3.md`)**
    *   Provision a Jupyter environment (using `jupyter/datascience-notebook`).
    *   Use the `influxdb-client` to query data into a Pandas DataFrame.
    *   Train a Prophet model on the retrieved data and visualize the forecast.
5.  **Step 4: Cleanup & Conclusion (`step4.md` / `finish.md`)**
    *   Provide commands to stop containers and remove volumes.
    *   Summarize key takeaways.

## Technical Notes
*   **Container Management:** Utilize `docker-compose` for consistent lifecycle management.
*   **Environment:** Define dependencies via `Dockerfile` or `docker-compose.yml` to streamline setup.
*   **Conventions:** Ensure all code blocks use standardized `{{exec}}` and `{{copy}}` tags consistent with other project labs.
