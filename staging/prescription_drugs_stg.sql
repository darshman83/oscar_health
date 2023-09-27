-----------------------------------
-- Build Staging Table for Prescription Drugs
-----------------------------------
CREATE OR REPLACE TABLE staging.prescription_drugs_stg AS
SELECT record_id,
member_id,
date_svc,
ndc,
drug_category,
drug_group,
drug_class
FROM staging.prescription_drugs_dq 
WHERE date_null_tag = 0
AND member_id_null_tag = 0
AND ndc_null_tag = 0
AND invalid_date_tag = 0;
