-- Q1: Simple Aggregation
-- Pattern: Single join + GROUP BY
-- Finding: No performance difference across XS/S/M

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    c_customer_id,
    SUM(ss_net_paid) AS total_net_paid
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
    ON ss_customer_sk = c_customer_sk
GROUP BY c_customer_id
ORDER BY total_net_paid DESC
LIMIT 100;