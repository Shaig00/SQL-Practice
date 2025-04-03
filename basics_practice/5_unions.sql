
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;



WITH Q1_job_postings AS (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
SELECT
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM Q1_job_postings
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC;



