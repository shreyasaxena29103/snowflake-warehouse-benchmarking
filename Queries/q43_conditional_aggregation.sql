-- Q43: Conditional Aggregation
-- Pattern: CASE WHEN pivoting across day of week
-- Finding: XS took 78.7s, S took 0.121s, M took 0.120s
-- Conclusion: S and M identical, pivot logic doesn't benefit from extra compute

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    s_store_name,
    s_store_id,
    SUM(CASE WHEN d_day_name = 'Sunday'    THEN ss_sales_price ELSE 0 END) AS sun_sales,
    SUM(CASE WHEN d_day_name = 'Monday'    THEN ss_sales_price ELSE 0 END) AS mon_sales,
    SUM(CASE WHEN d_day_name = 'Tuesday'   THEN ss_sales_price ELSE 0 END) AS tue_sales,
    SUM(CASE WHEN d_day_name = 'Wednesday' THEN ss_sales_price ELSE 0 END) AS wed_sales,
    SUM(CASE WHEN d_day_name = 'Thursday'  THEN ss_sales_price ELSE 0 END) AS thu_sales,
    SUM(CASE WHEN d_day_name = 'Friday'    THEN ss_sales_price ELSE 0 END) AS fri_sales,
    SUM(CASE WHEN d_day_name = 'Saturday'  THEN ss_sales_price ELSE 0 END) AS sat_sales
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM
    ON ss_sold_date_sk = d_date_sk
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE
    ON ss_store_sk = s_store_sk
WHERE d_year = 2001
GROUP BY s_store_name, s_store_id
ORDER BY s_store_name, s_store_id
LIMIT 100;