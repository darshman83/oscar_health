--This code creates a fact table for op services from claim line detail and
-- adds all keys from dimension tables
CREATE OR REPLACE TABLE Fact_OP_Services AS

with add_keys as (
    SELECT pat.patient_key,
           dt.date_key,
           diag.diag_key,
           count(*) as Service_Count
    FROM staging.claim_line_detail_stg cd
    INNER JOIN dim_patient pat
    ON pat.member_id = cd.member_id
    INNER JOIN dim_date dt
    ON dt.date = TRIM(cd.date_svc)
    INNER JOIN dim_diagnosis diag
    ON diag.diag1 = cd.diag1
    GROUP BY ALL
)

SELECT * FROM add_keys;

--Check that record count matches staging source
SELECT (SELECT count(*) FROM fact_op_services) as op_services_cnt,  (SELECT count(*) FROM staging.claim_line_detail_stg) as staging_cnt;
