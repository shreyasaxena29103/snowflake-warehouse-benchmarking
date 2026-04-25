# snowflake-warehouse-benchmarking

## Problem
Snowflake warehouse costs double with each size increase (XS→S→M).
This project measures whether that cost increase is justified across
different query patterns using TPC-DS SF10 data.

## Methodology
- Dataset: TPC-DS SF10 (SNOWFLAKE_SAMPLE_DATA)
- Warehouses tested: XS, S, M
- Query patterns: Simple aggregation, multi-table joins, window functions
- Metric: Execution time (seconds) and credits consumed per query

## Key Finding
> A Small (S) warehouse delivers 95% of Medium (M) performance 
> at half the cost. XS collapses on any query involving joins 
> or window functions.
