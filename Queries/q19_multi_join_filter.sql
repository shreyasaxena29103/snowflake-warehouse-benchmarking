-- Q19: Multi-Join + Filter
-- Pattern: 5-way join with selective WHERE filters
-- Finding: XS took 3.055s, S took 0.006s, M took 0.007s
-- Conclusion: Filters reduce data volume enough that S and M are identical

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    i_brand_id,
    i_brand,
    i_manufact_id,
    i_manufact,
    SUM(ss_ext_sales_price) AS ext_price
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
    ON ss_item_sk   = i_item_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
    ON ss_customer_sk = c_customer_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER_ADDRESS
    ON c_current_addr_sk = ca_address_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM
    ON ss_sold_date_sk = d_date_sk
WHERE i_manager_id = 8
  AND d_moy        = 11
  AND d_year       = 2001
GROUP BY i_brand_id, i_brand, i_manufact_id, i_manufact
ORDER BY ext_price DESC
LIMIT 100;