The final step is to visualize our metrics in Grafana. Grafana provides a powerful and flexible way to create dashboards.

First, access the Grafana web interface. Click on the **Grafana** tab next to the terminal.
-   Login with the username `admin` and password `admin`. You can skip changing the password.

Next, we need to connect Grafana to our InfluxDB database.
1.  Click the **gear icon** on the left sidebar to go to **Configuration > Data Sources**.
2.  Click **Add data source**.
3.  Select **InfluxDB** from the list.
4.  Configure the data source with the following settings:
    -   **Name**: `InfluxDB`
    -   **URL**: `http://influxdb:8086`
    -   **Database**: `telegraf`
    -   **User**: `admin`
    -   **Password**: `adminpass`
5.  Click **Save & Test**. You should see a green checkmark indicating the connection is successful.

Now, let's create a simple dashboard panel.
1.  Click the **+ icon** on the left sidebar and select **Dashboard**.
2.  Click **Add new panel**.
3.  In the query editor at the bottom, make sure your `InfluxDB` data source is selected.
4.  Construct a query to display CPU usage. You can use the UI to select the measurement and fields:
    -   FROM: `default` > `cpu`
    -   SELECT: `field(usage_idle)` `mean()`
    -   GROUP BY: `time($__interval)` `fill(null)`
5.  The panel at the top will update to show a graph of the idle CPU usage over time.

Feel free to explore and add more panels to your dashboard to visualize other metrics like memory or disk usage.
