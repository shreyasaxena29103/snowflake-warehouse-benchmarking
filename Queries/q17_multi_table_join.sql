-- Q17: Multi-Table Join
-- Pattern: 5-way join across fact and dimension tables
-- Finding: XS took 173s, S took 0.214s, M took 0.252s
-- Conclusion: S actually beats M on heavy joins — M is not justified

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    i_item_id,
    i_item_desc,
    s_state,
    COUNT(ss_quantity)            AS store_sales_quantity,
    AVG(ss_quantity)              AS avg_store_sales_quantity,
    COUNT(sr_return_quantity)     AS store_returns_quantity,
    AVG(sr_return_quantity)       AS avg_store_returns_quantity
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_RETURNS
    ON ss_customer_sk   = sr_customer_sk
   AND ss_item_sk       = sr_item_sk
   AND ss_ticket_number = sr_ticket_number
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM d1
    ON ss_sold_date_sk  = d1.d_date_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE
    ON ss_store_sk      = s_store_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
    ON ss_item_sk       = i_item_sk
WHERE d1.d_year = 2001
GROUP BY i_item_id, i_item_desc, s_state
ORDER BY i_item_id
LIMIT 100;