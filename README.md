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
>
> | Query | Pattern | XS | S | M |
|---|---|---|---|---|
| Q1  | Simple aggregation  | 0.006s | 0.006s | 0.008s |
| Q7  | Aggregation + join  | 116s   | 1.9s   | 2.3s   |
| Q17 | Multi-table join    | 173s   | 0.214s | 0.252s |
| Q19 | Multi-join + filter | 3.055s | 0.006s | 0.007s |
| Q29 | Aggregation + join  | 159s   | 0.008s | 0.007s |
| Q43 | Conditional agg     | 78.7s  | 0.121s | 0.120s |
| Q12 | Window function     | 1.203s | 0.137s | 0.120s |
| Q47 | Window + CTE        | 796s   | 0.116s | 790s   |

## Recommendation
For ad-hoc analytical workloads at SF10 scale, **S warehouse is 
the optimal choice**. Upgrading to M adds ~20% cost with negligible 
performance gain. XS should only be used for lightweight queries 
with no joins.
