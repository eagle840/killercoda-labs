
## How InfluxDB Stores Data

InfluxDB is purpose-built as a Time Series Database (TSDB), meaning its storage architecture is optimized for high write speeds, high compression ratios, and fast time-range queries.

Traditional versions (powered by the **TSM storage engine**) rely on a structure conceptually similar to an LSM (Log-Structured Merge) Tree, handling data through several key components:

### 1. The Core Storage Pipeline

* **Write-Ahead Log (WAL):** When data is written, it is first appended to an on-disk WAL file. This ensures immediate durability and crash recovery without slowing down operations.
* **In-Memory Cache:** Simultaneously, the write populates an uncompressed in-memory cache organized by series key. This cache makes recent data immediately queryable.
* **TSM Files (Time-Structured Merge Tree):** When the cache fills up or hits a timeout threshold, it gets flushed to disk as a **TSM file**. TSM files are immutable, highly compressed columnar files that store actual time-series data (timestamps and field values) alongside an index partition. Over time, background compactions merge smaller TSM files into larger, optimized ones.
* **TSI (Time Series Index):** To prevent performance degradation as high-cardinality data grows (millions of unique tag combinations), InfluxDB uses an on-disk index called TSI to quickly locate measurements, tag keys, and fields.

---

## How Data is Structured (Data Model)

Data points sent to InfluxDB follow a specific paradigm built around timestamps and metadata:

* **Measurement:** The conceptual category of the data (e.g., `cpu_usage`).
* **Tag Set:** Key-value pairs that are *indexed* for fast searching (e.g., `region=us-west, host=server-01`). *High cardinality tags (like unique user IDs) should be avoided here.*
* **Field Set:** Key-value pairs containing the actual metric data that are *not* indexed (e.g., `value=45.2, idle=9.1`).
* **Timestamp:** The precise time associated with the data point.

---

## How to Interact with InfluxDB

Interacting with InfluxDB typically involves writing data via line protocols and querying it using specialized language interfaces.

### 1. Writing Data (Line Protocol)

Data is ingested primarily via HTTP POST requests using InfluxDB's text-based **Line Protocol**.

**Syntax Example:**

```text
cpu_usage,host=server-01,region=us-west idle=90.4,usage=9.6 1672531199000000000

```

* `cpu_usage` = Measurement
* `host=server-01,region=us-west` = Tags
* `idle=90.4,usage=9.6` = Fields
* `1672531199000000000` = Nanosecond timestamp (optional; InfluxDB will assign one if omitted)

You can send data using:

* **CLI:** `influx write` commands.
* **HTTP API:** Direct POST requests to `/api/v2/write`.
* **Client Libraries:** Official SDKs available for Python, Go, Node.js, C#, and more.
* **Telegraf:** An agent plugins ecosystem frequently used to pull metrics from systems and push them directly to InfluxDB.

### 2. Querying Data

Depending on your version of InfluxDB, you use different query languages:

* **Flux:** A functional data scripting and query language built specifically for querying, analyzing, and transforming time-series data.
* *Example Flux Query:*


```flux
from(bucket: "my-bucket")
  |> range(start: -1h)
  |> filter(fn: (r) => r["_measurement"] == "cpu_usage")
  |> aggregateWindow(every: 5m, fn: mean, createEmpty: false)

```


* **InfluxQL:** A SQL-like query language supported as a legacy/compatibility option for users familiar with traditional relational databases.
* *Example InfluxQL Query:*


```sql
SELECT MEAN("usage") FROM "cpu_usage" WHERE time > now() - 1h GROUP BY time(5m)

```