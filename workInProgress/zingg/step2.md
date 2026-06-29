# Evaluation & Visualization

In this step we will **inspect the matching results** produced by Zingg and build a quick dashboard to explore them.

## 1. View the raw CSV with pandas
```python
import pandas as pd

# Path to the Zingg output (produced in Step 1)
csv_path = "/tmp/zinggOutput/part-00000"

df = pd.read_csv(csv_path)
print(df.head())
```

### What you’ll see
The CSV contains the original record IDs plus three Zingg‑added columns:
- `z_minScore` – lowest similarity score for the pair
- `z_maxScore` – highest similarity score for the pair
- `z_cluster` – cluster identifier for matched groups

## 2. Simple analysis
```python
# Sort by cluster to view groups of similar entities
clusters = df.sort_values("z_cluster")
print(clusters[["z_cluster", "z_minScore", "z_maxScore"].drop_duplicates().head())
```

## 3. Interactive dashboard with Streamlit
Create a file **`app.py`**:
```python
import streamlit as st
import pandas as pd

st.title("Zingg Matching Results")
csv_path = "/tmp/zinggOutput/part-00000"

df = pd.read_csv(csv_path)

st.dataframe(df)

# Add a filter by cluster
cluster = st.slider("Cluster", min_value=int(df["z_cluster"].min()), max_value=int(df["z_cluster"].max()))
st.dataframe(df[df["z_cluster"] == cluster])
```
Run it:
```bash
pip install streamlit
streamlit run app.py &
```
Then open the provided URL (usually `http://localhost:8501`).

## 4. Visual reference
Below is a mock‑up of the dashboard you’ll get after running the Streamlit app.

![Zingg Dashboard](file:///home/nicholas/.gemini/antigravity-cli/brain/deee2534-3005-40f9-8275-7e0432b3a56b/zingg_result_dashboard_1782577051480.jpg)

---
Once you are happy with the results, proceed to the **Finish** step to clean up.

