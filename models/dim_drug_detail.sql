--Create table for each unique combination of drug_categoy, droup_group, drug_class
--This is a 1:M relationship to an ndc code, which will be stored on the fact table
CREATE OR REPLACE TABLE dim_drug_detail as

with group_ndc as (
    SELECT DISTINCT
    drug_category,
    drug_group,
    drug_class
    FROM staging.prescription_drugs_stg
)

    ,add_key as (SELECT row_number() OVER (ORDER BY drug_category) as Drug_Detail_Key,
        * FROM group_ndc)
        
SELECT * FROM add_key;

SELECT * FROM dim_diagnosis limit 1000;
