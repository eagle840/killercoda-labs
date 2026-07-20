# Step 3: Forecasting with Prophet

In this step, we will use Jupyter to query our ingested data and train a Prophet model.

### 1. Access Jupyter
Access the Jupyter notebook interface:

{{TRAFFIC_HOST1_8888}}

### 2. Configure the Notebook
1.  Open the `influxquickstart.ipynb` notebook from the file browser.
2.  Follow the instructions in the notebook cells.
3.  **Authentication:** You will need to generate an API Token in the InfluxDB UI (Load Data -> API Tokens -> Generate API Token) and enter it into the notebook where prompted (`<my-token>`).
4.  **Dependencies:** Note that `influxdb-client` and `prophet` are already pre-installed in the Jupyter container, so you can skip the installation cells.

### 3. Run Forecasting
Run the cells to:
1.  Query the USGS data from InfluxDB.
2.  Format the data for Prophet.
3.  Train the model and generate a forecast.
4.  Visualize the results.
