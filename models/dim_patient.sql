--Creates table of unique patient ids
--This will be used as a shared dimension between fact_op_Services and fact_pharmacy
CREATE OR REPLACE TABLE dim_patient AS

with group_patients as (
    SELECT DISTINCT member_id
    FROM staging.claim_line_detail_stg
    UNION
    SELECT DISTINCT member_id
    FROM staging.prescription_drugs_stg
)

   ,add_key as (SELECT row_number() OVER (ORDER BY member_id) as patient_key,
   *
   FROM group_patients)

   SELECT * FROM add_key;
