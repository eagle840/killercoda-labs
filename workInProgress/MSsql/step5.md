Perfect, Nicholas. Here's a Markdown-ready **Killercoda lab page** you can drop in as your fifth module. It focuses on simulating **page splits** using `OStress` against a SQL Server container running locally via Docker. I’ve kept it structured, hands-on, and aligned with your learning style.

"I think you need to break this off into a new performance lab"

---

## 🧪 Page 5: Simulating Page Splits with OStress

### 🧭 Objective
Use **OStress** to simulate high-concurrency inserts into a SQL Server table with a clustered GUID index, triggering **page splits** and observing fragmentation.

---

### 🛠️ Step 1: Create the Test Table

Connect to your SQL Server container using `sqlcmd` or Azure Data Studio, then run:

```sql
CREATE TABLE PageSplitTest (
    Id UNIQUEIDENTIFIER PRIMARY KEY CLUSTERED,
    Data NVARCHAR(100)
);
```{{exec}}

This sets up a table with a clustered index on a **random GUID**, which is prone to page splits.

---

### 🧵 Step 2: Prepare the Insert Script

Create a file named `insert.sql` with the following content:

```sql
INSERT INTO PageSplitTest (Id, Data)
VALUES (NEWID(), 'Simulated load');
```{{exec}}

This will be executed repeatedly by OStress.

---

### 🚀 Step 3: Run OStress  (remove)

Use the RML Utilities (installed locally) to simulate concurrent inserts:

```bash
ostress -Slocalhost -dmaster -Uyour_user -Pyour_password -iinsert.sql -n50 -r1000
```{{exec}}

- `-n50`: 50 concurrent threads  
- `-r1000`: Each thread runs the insert 1000 times  
- Adjust `-S`, `-d`, `-U`, `-P` to match your local Docker SQL Server setup

### Step 3: Run sqlcmd


```bash
sqlcmd  -Q "
-- Step 1: Create test table with narrow clustered index
IF OBJECT_ID('dbo.PageSplitTest') IS NOT NULL DROP TABLE dbo.PageSplitTest;
CREATE TABLE dbo.PageSplitTest (
    ID INT NOT NULL,
    Payload CHAR(4000) NULL,
    CONSTRAINT PK_PageSplitTest PRIMARY KEY CLUSTERED (ID)
);

-- Step 2: Insert initial sequential rows
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO dbo.PageSplitTest (ID, Payload) VALUES (@i, REPLICATE('X', 4000));
    SET @i += 1;
END

-- Step 3: Force page splits by inserting rows between existing keys
SET @i = 1;
WHILE @i <= 999
BEGIN
    INSERT INTO dbo.PageSplitTest (ID, Payload) VALUES (@i + 0.5, REPLICATE('Y', 4000));
    SET @i += 1;
END
"

```bash
sqlcmd -S localhost -U sa -P YourPassword -d YourDatabase -Q "
-- Step 1: Create test table with narrow clustered index
IF OBJECT_ID('dbo.PageSplitTest') IS NOT NULL DROP TABLE dbo.PageSplitTest;
CREATE TABLE dbo.PageSplitTest (
    ID INT NOT NULL,
    Payload CHAR(4000) NULL,
    CONSTRAINT PK_PageSplitTest PRIMARY KEY CLUSTERED (ID)
);

-- Step 2: Insert initial sequential rows
DECLARE @i INT = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO dbo.PageSplitTest (ID, Payload) VALUES (@i, REPLICATE('X', 4000));
    SET @i += 1;
END

-- Step 3: Force page splits by inserting rows between existing keys
SET @i = 1;
WHILE @i <= 999
BEGIN
    INSERT INTO dbo.PageSplitTest (ID, Payload) VALUES (@i + 0.5, REPLICATE('Y', 4000));
    SET @i += 1;
END
"
```{{exec}}

What This Does
- Step 1 creates a table with a clustered index on ID.
- Step 2 fills pages with large payloads in sequential order.
- Step 3 inserts rows between existing keys (1.5, 2.5, etc.), triggering page splits due to mid-page insertions.


---

### 🔍 Step 4: Monitor Page Splits

Run this query to inspect fragmentation:

```sql
SELECT * 
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('PageSplitTest'), NULL, NULL, 'DETAILED');
```{{exec}}

Or track live operational stats:

```sql
SELECT * 
FROM sys.dm_db_index_operational_stats(DB_ID(), OBJECT_ID('PageSplitTest'), NULL, NULL);
```{{exec}}

Look for high values in `page_split_count` and `avg_fragmentation_in_percent`.

---

### 🧠 Optional Exploration

- Rebuild the index with a lower fill factor:
  ```sql
  ALTER INDEX PK__PageSplitTest__Id ON PageSplitTest
  REBUILD WITH (FILLFACTOR = 80);
  ```{{exec}}
- Switch to `NEWSEQUENTIALID()` to reduce splits:
  ```sql
  ALTER TABLE PageSplitTest
  ADD SeqId UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID();
  ```{{exec}}

---

### ✅ Outcome

By the end of this page, you’ll have:
- Triggered real page splits using OStress  
- Measured fragmentation impact  
- Explored mitigation strategies like fill factor and sequential keys  

---

Let me know if you'd like a companion Markdown snippet for your blog or a sixth page that dives into compression or index rebuild strategies.
