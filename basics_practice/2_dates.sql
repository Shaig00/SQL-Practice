SELECT job_posted_date
FROM job_postings_fact
LIMIT 100;

SELECT
    '2025-03-28'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact
LIMIT 5;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM job_postings_fact
LIMIT 5;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year,
    ROW_NUMBER() OVER (ORDER BY COUNT(job_id) DESC) AS ranking
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY year, month;

-- To do: Problem Set 6 (comes just before problem 6)

-- Problem 1

SELECT
    job_schedule_type,
    AVG(salary_hour_avg) AS hourly_avg ,
    AVG(salary_year_avg) AS yearly_avg
FROM job_postings_fact
WHERE job_posted_date::DATE >= '2023-06-01'
GROUP BY job_schedule_type
HAVING NOT (AVG(salary_hour_avg) IS NULL
    AND AVG(salary_year_avg) IS NULL);

-- Problem 2

SELECT
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')) AS month,
    COUNT(*) AS jobs_posted
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY month;

-- Problem 3

SELECT
    DISTINCT cdi.name AS company_name
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cdi
    ON cdi.company_id = jpf.company_id
WHERE job_health_insurance IS TRUE
    AND (EXTRACT(MONTH FROM jpf.job_posted_date) BETWEEN 4 AND 6);

-- Problem 6

CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;



