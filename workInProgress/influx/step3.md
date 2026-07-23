# Step 3: Forecasting with Prophet

In this step, we will use Jupyter to query our ingested data and train a Prophet model.

### 1. Access Jupyter
Access the Jupyter notebook interface:

{{TRAFFIC_HOST1_8888}}

### 2. Configure the Notebook
1.  Open the `influxquickstart.ipynb` notebook from the file browser.
2.  **Authentication:** Generate an API Token in the InfluxDB UI (Load Data -> API Tokens -> Generate API Token).
3.  **Configuration:** Update the first code cell in the notebook, replacing `<my-token>` with your generated token. The `url`, `org`, and `bucket` are pre-configured for this lab.
4.  **Run:** Execute the notebook cells sequentially.

### 3. Run Forecasting
Run the cells to:
1.  Query the USGS data from InfluxDB.
2.  Format the data for Prophet.
3.  Train the model and generate a forecast.
4.  Visualize the results.
