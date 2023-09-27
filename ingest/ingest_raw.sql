--Establish file format to be used to load csv files
CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = CSV
  FIELD_OPTIONALLY_ENCLOSED_BY='"'
  SKIP_HEADER = 1;

--Create External Stage to link to files
CREATE OR REPLACE STAGE my_s3_stage
  url='s3://oscarcasestudy/Case_Study_Datasets/'
  credentials=(aws_key_id='AKIAS2RFP5QPCPE6LXUA' aws_secret_key='gFqVazyJbUJ1LwFtq8A2e/0i4Gh+pj2W02CCWvI8')
  FILE_FORMAT = my_csv_format;

--Create landing table for ccs data
CREATE OR REPLACE TABLE ccs (
diag string,
diag_desc string,
ccs_1_desc string,
ccs_2_desc string,
ccs_3_desc string
);
-- Move data into ccs raw table
COPY INTO ccs
  FROM @my_s3_stage
  FILES = ('ccs.csv');

--Create landing table for ccs data
CREATE OR REPLACE TABLE claim_line_detail (
record_id integer,
member_id string,
date_svc date,
diag1 string
);
-- Move data into ccs raw table
COPY INTO claim_line_detail
  FROM @my_s3_stage
  FILES = ('claim_lines.csv');

  --SELECT * FROM claim_line_Detail limit 1000;


-- Create landing table for prescription drugs
CREATE OR REPLACE TABLE prescription_drugs (
record_id integer,
member_id string,
date_svc date,
ndc string,
drug_category string,
drug_group string,
drug_class string
);
--Move data into prescription drugs raw table
COPY INTO prescription_drugs
  FROM @my_s3_stage
  FILES = ('prescription_drugs.csv');

--SELECT * FROM prescription_drugs LIMIT 1000;
