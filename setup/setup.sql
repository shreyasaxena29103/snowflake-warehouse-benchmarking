-- Create database and schema
CREATE DATABASE IF NOT EXISTS benchmark;
CREATE SCHEMA IF NOT EXISTS benchmark.results;

-- Create results table
CREATE TABLE IF NOT EXISTS benchmark.results.benchmark_results (
    query_id        STRING,
    warehouse       STRING,
    scale_factor    STRING,
    duration_secs   FLOAT,
    credits_used    FLOAT,
    run_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create warehouses
CREATE WAREHOUSE IF NOT EXISTS benchmark_xs WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;
CREATE WAREHOUSE IF NOT EXISTS benchmark_s  WAREHOUSE_SIZE = 'SMALL'  AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;
CREATE WAREHOUSE IF NOT EXISTS benchmark_m  WAREHOUSE_SIZE = 'MEDIUM' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;
