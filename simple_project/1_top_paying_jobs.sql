
/*
 Question 1: top-paying data analyst jobs in Germany?
 - top 10 highest paying remote data analyst jobs in Germany
 - remove nulls
 */
SELECT
    job_id,
    job_title,
    job_title_short,
    job_location,
    job_schedule_type,
    company_dim.name AS company_name,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location LIKE '%Germany%'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

