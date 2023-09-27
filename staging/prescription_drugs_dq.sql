--Create DQ tagged table for prescription drugs
-- This will be used to track records tagged for bad data and filter
-- them out for staging table
CREATE OR REPLACE TABLE staging.prescription_drugs_dq AS
SELECT *,
CASE WHEN date_svc IS NULL
THEN 1
ELSE 0
END as date_null_tag,
CASE WHEN date_svc < date('2015-01-01')
THEN 1
ELSE 0
END AS invalid_date_tag,
CASE WHEN member_id IS NULL
THEN 1
ELSE 0
END as member_id_null_tag,
CASE WHEN ndc IS NULL
THEN 1
ELSE 0
END as ndc_null_tag,
current_timestamp() as timestamp,
1 as batch_id
FROM prescription_drugs;
