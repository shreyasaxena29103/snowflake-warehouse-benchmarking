-- Q12: Window Function


USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    i_item_id,
    i_item_desc,
    i_category,
    i_class,
    i_current_price,
    SUM(ws_ext_sales_price) AS itemrevenue,
    SUM(ws_ext_sales_price) * 100 / SUM(SUM(ws_ext_sales_price))
        OVER (PARTITION BY i_class) AS revenueratio
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.WEB_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
    ON ws_item_sk = i_item_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM
    ON ws_sold_date_sk = d_date_sk
WHERE i_category IN ('Sports', 'Books', 'Home')
  AND d_date BETWEEN '2001-01-01' AND '2001-03-31'
GROUP BY i_item_id, i_item_desc, i_category, i_class, i_current_price
ORDER BY i_category, i_class, i_item_id, i_item_desc, revenueratio
LIMIT 100;