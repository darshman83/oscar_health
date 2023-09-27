--Create pharmacy fact table and add all associated
-- dimension keys
CREATE OR REPLACE TABLE Fact_Pharmacy AS

with add_keys as (
    SELECT pat.patient_key,
           dt.date_key,
           COALESCE(drug.drug_detail_key,0) as drug_detail_key,
           ndc,
           count(*) as Script_Count
    FROM staging.prescription_drugs_stg cd
    INNER JOIN dim_patient pat
    ON pat.member_id = cd.member_id
    INNER JOIN dim_date dt
    ON dt.date = cd.date_svc
    INNER JOIN dim_drug_detail drug
    ON drug.drug_category = cd.drug_category
    AND drug.drug_class = cd.drug_class
    AND drug.drug_group = cd.drug_group
    GROUP BY ALL
)

SELECT * FROM add_keys;
