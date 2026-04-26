-- Q7: Aggregation + Join

USE WAREHOUSE benchmark_xs; -- swap for benchmark_s, benchmark_m

SELECT
    cd_gender,
    cd_education_status,
    AVG(ss_sales_price)  AS avg_sales_price,
    AVG(ss_quantity)     AS avg_quantity,
    COUNT(*)             AS total_sales
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER_DEMOGRAPHICS
    ON ss_cdemo_sk = cd_demo_sk
GROUP BY cd_gender, cd_education_status
ORDER BY avg_sales_price DESC;