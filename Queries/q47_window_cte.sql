-- Q47: Window Function + CTE

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

WITH v1 AS (
    SELECT
        i_category, i_brand, s_store_name, s_company_name,
        d_year, d_moy,
        SUM(ss_sales_price) AS sum_sales,
        AVG(SUM(ss_sales_price)) OVER (
            PARTITION BY i_category, i_brand, s_store_name, s_company_name, d_year
        ) AS avg_monthly_sales,
        RANK() OVER (
            PARTITION BY i_category, i_brand, s_store_name, s_company_name
            ORDER BY d_year, d_moy
        ) AS rn
    FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
    JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM        ON ss_item_sk      = i_item_sk
    JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM    ON ss_sold_date_sk = d_date_sk
    JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE       ON ss_store_sk     = s_store_sk
    GROUP BY i_category, i_brand, s_store_name, s_company_name, d_year, d_moy
)
SELECT
    v1.i_category, v1.d_year, v1.d_moy,
    v1.avg_monthly_sales, v1.sum_sales,
    v2.sum_sales AS prev_month_sales
FROM v1
JOIN v1 v2
    ON v1.i_category   = v2.i_category
   AND v1.i_brand      = v2.i_brand
   AND v1.s_store_name = v2.s_store_name
   AND v1.rn           = v2.rn + 1
WHERE v1.d_year = 2001
  AND v1.avg_monthly_sales > 0
  AND ABS(v1.sum_sales - v1.avg_monthly_sales) / v1.avg_monthly_sales > 0.1
ORDER BY v1.sum_sales - v1.avg_monthly_sales
LIMIT 100;