### Scenario 1
Data arrives daily as files. Analysts need fast BI.
Choice: Lakehouse + Direct Lake
Reason: Avoid import refresh, low latency, Delta support

### Scenario 2
Data refreshes on demand as one large size file like 10PB and no transformation, analysts need BI with daily refresh only
Choice: Mirroring + Delta Lake
Reason: clean data replication, Avoid import refresh, low latency, Delta support

### Scenario 3
Data refreshes incrementaly asa new records available as files, analysts need realtime and option to manipulate data (add calculated columns)
Choice: Copy job + Lakehouse  + Import Mode PBI
Reason: incremental update of data, data manipulation at Analyst's end


### Scenario 4
Data refreshes incrementaly asa new records available (near real time) as files, then light transform data then analysts need fast, no code / low code BI
Choice: Eventstream + Eventhouse  + Direct Lake
Reason:  incremental update of data in real time, Avoid import refresh, low latency, Delta support


### Scenario 5
Data refreshes in batches as several 1000 files, then complex transformation on data then analysts need fast, no code / low code BI
Choice:  Pipeline + Notebooks + Direct Lake
Reason: Orchestration of data movement, high capacity to transform the data, Avoid import refresh, low latency, Delta support
