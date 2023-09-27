--This code creates a date dimension table based on the date range available in the data
-- The combine_services_stg is a unioned version of prescription drugs and claim line detail
-- It was originally used to create the unified fact table but I later changed then model and didnt
-- have time to update this!
SET min_date = (SELECT min(date_svc)
                FROM staging.combine_services_stg);
                
SET max_date = (SELECT max(date_svc)
                FROM staging.combine_services_stg);

CREATE OR REPLACE temp table date_range(days int) as
SELECT datediff('day', $min_date, $max_date + 1) as date_range;

SELECT * FROM date_range;

CREATE OR REPLACE TABLE Dim_Date (
Date_Key int,
Date date,
Year Integer,
Quarter Integer,
Month integer,
Month_Name String,
Week int,
day integer,
day_name string)
AS
with all_dates as (
SELECT dateadd(Day, SEQ4(), $min_date) as date_seq
FROM TABLE(GENERATOR(ROWCOUNT=> (SELECT MAX(days) FROM date_range)))
)
SELECT 
row_number() OVER (ORDER BY date_seq) as date_key,
date_seq as date,
YEAR(date_seq) as year,
QUARTER(date_seq) as quarter,
MONTH(date_seq) as month,
MONTHNAME(date_seq) as month_name,
WEEK(date_seq) as week,
DAY(date_seq) as day,
DAYNAME(date_seq) as day_name
FROM all_dates;

SELECT max(date) as max_dt, min(date) as min_dt FROM dim_date;
