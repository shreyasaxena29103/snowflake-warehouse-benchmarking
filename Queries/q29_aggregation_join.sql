-- Q29: Aggregation + Join
-- Pattern: Item-level rollup across store sales
-- Finding: XS took 159s, S took 0.008s, M took 0.007s
-- Conclusion: S and M identical, XS completely unusable

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    i_category,
    i_class,
    SUM(ss_ext_sales_price)  AS total_extended_price,
    SUM(ss_quantity)         AS total_quantity
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
    ON ss_item_sk = i_item_sk
GROUP BY i_category, i_class
ORDER BY total_extended_price DESC;