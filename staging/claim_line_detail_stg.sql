--Create staging table to be used by downstream modeling into prod
-- Removes all records tagged for bad data and updates diag1 by removing "." character
CREATE OR REPLACE TABLE staging.claim_line_detail_stg AS
SELECT
DISTINCT
member_id,
date_svc,
TRIM(REPLACE(diag1, '.')) as diag1 --This is done to join with CCS table
FROM staging.claim_line_detail_dq
WHERE date_null_tag = 0
AND member_id_null_tag = 0
AND diag1_null_tag = 0
AND invalid_date_tag = 0;

-- Test to ensure grain is distinct and date_svc is fully populated
SELECT count(date_svc) as date_cnt, count(DISTINCT member_id, date_svc, diag1) as d_cnt, count(*) as total_cnt FROM staging.claim_line_detail_stg;

--SELECT * FROM staging.claim_line_detail_stg LIMIT 1000;



--Find dups if exist, explore reasoning
-- with dups as (SELECT member_id, date_svc, diag1, count(*) as cnt
-- FROM staging.claim_line_detail_stg 
-- GROUP BY ALL --Works in snowflake sql dialect, might not elsewhere
-- HAVING cnt > 1
-- )

-- SELECT cd.* FROM
-- staging.claim_line_detail_stg cd
-- INNER JOIN dups
-- ON cd.member_id = dups.member_id
-- AND COALESCE(cd.date_svc,'9999-01-01') = COALESCE(dups.date_svc,'9999-01-01')
-- AND cd.diag1 = dups.diag1;
