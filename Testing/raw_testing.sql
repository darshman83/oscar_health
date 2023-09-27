-----------------------------------------------------------------
-- CCS DQ Tests
-----------------------------------------------------------------
SELECT * FROM ccs LIMIT 1000;

-- Check Primary Key (DIAG) Uniqueness
-- Every record should be unique so these should be equal
SELECT count(DISTINCT diag) as diag_cnt, count(*) as total_cnt FROM ccs;

-- Check Primary Key (DIAG) Population
-- These should be equal
SELECT count(DIAG) as diag_not_null, count(*) as total_cnt FROM ccs;
-----------------------------------------------------------------
-- Claim Line Detail DQ Tests
-----------------------------------------------------------------
SELECT * FROM claim_line_detail LIMIT 10000;
-- Check that (member_id + date_svc + diag1) is distinct
SELECT count(DISTINCT member_id, date_svc, diag1) as d_cnt, count(*) as total_cnt FROM claim_line_detail;

--Check for Nulls for member_id
SELECT count(member_id) as mem_cnt, count(*) as total_cnt from CLAIM_LINE_DETAIL;

--Check for Nulls date_svc
SELECT count(date_svc) as ds_cnt, count(*) as total_cnt from CLAIM_LINE_DETAIL;

--Check for Nulls diag1
SELECT count(diag1) as diag_cnt, count(*) as total_cnt from CLAIM_LINE_DETAIL;

--Find dups if exist, explore reasoning
-- with dups as (SELECT member_id, date_svc, diag1, count(*) as cnt
-- FROM claim_line_detail
-- GROUP BY ALL --Works in snowflake sql dialect, might not elsewhere
-- HAVING cnt > 1
-- )

-- SELECT cd.* FROM
-- claim_line_detail cd
-- INNER JOIN dups
-- ON cd.member_id = dups.member_id
-- AND cd.date_svc = dups.date_svc
-- AND cd.diag1 = dups.diag1;

-----------------------------------------------------------------
-- Prescription Drugs DQ Tests
-----------------------------------------------------------------
SELECT * FROM prescription_drugs LIMIT 1000;
-- Check that (member_id + date_svc + ndc) is distinct as this will be PK when unioned with claim line detail
SELECT count(DISTINCT member_id, date_svc, ndc) as d_cnt, count(*) as total_cnt FROM prescription_drugs;
--Check for Nulls for member_id
SELECT count(member_id) as mem_cnt, count(*) as total_cnt from prescription_drugs;

--Check for Nulls date_svc
SELECT count(date_svc) as ds_cnt, count(*) as total_cnt from prescription_drugs;

--Check for Nulls ndc
SELECT count(ndc) as diag_cnt, count(*) as total_cnt from prescription_drugs;

-----------------------------------------------------------------


-----------------------------------------------------------------
-- Adhoc tests
-----------------------------------------------------------------

-- SELECT * FROM ccs limit 1000;

-- SELECT count(1) as row_count, count(diag) as diag_cnt, count(DISTINCT diag) as d_diag_cnt  FROM ccs;

-- SELECT * FROM claim_line_detail LIMIT 1000;

-- SELECT * FROM prescription_drugs LIMIT 1000;

-- DESCRIBE TABLE claim_line_detail;
