--This code creates a table that creates a record for every diag1 code that any member had
-- and its corresponding CCS dimensions. If missing from CCS, its populated with 'Missing in CCS File'
CREATE OR REPLACE TABLE dim_diagnosis AS
with d_group as (
    SELECT DISTINCT diag1
    FROM staging.claim_line_detail_stg
)
    ,join_ccs as (
    SELECT 
    row_number() OVER (ORDER BY diag1) as Diag_Key,
    cd.diag1,
    COALESCE(ccs.ccs_1_desc, 'Missing in CCS File') as ccs_1_desc,
    COALESCE(ccs.ccs_2_desc, 'Missing in CCS File') as ccs_2_desc,
    COALESCE(ccs.ccs_3_desc, 'Missing in CCS File') as ccs_3_desc
    FROM d_group cd
    LEFT JOIN staging.ccs_stg ccs
    ON TRIM(cd.diag1) = TRIM(ccs.diag)
    )

    SELECT * FROM join_ccs;
