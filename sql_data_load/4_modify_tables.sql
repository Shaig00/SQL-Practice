
-- Note: Added through pgAdmin

-- \copy company_dim FROM 'C:\Users\shaik\Documents\Projects\SQL Practice\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--
-- \copy skills_dim FROM 'C:\Users\shaik\Documents\Projects\SQL Practice\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--
-- \copy job_postings_fact FROM 'C:\Users\shaik\Documents\Projects\SQL Practice\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--
-- \copy skills_job_dim FROM 'C:\Users\shaik\Documents\Projects\SQL Practice\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');



SELECT * FROM company_dim;

SELECT * FROM job_postings_fact;

SELECT * FROM skills_dim;

SELECT * FROM skills_job_dim;