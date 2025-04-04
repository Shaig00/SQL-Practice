
-- Find skills required by top 10 highest paying data analyst roles in Germany

-- with cte, using previous query in part 1
WITH data_analyst_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        company_dim.name AS company_name,
        salary_year_avg,
        salary_year_avg / 12 AS approx_salary_month,
        job_posted_date
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON company_dim.company_id = job_postings_fact.company_id
    WHERE job_title_short = 'Data Analyst'
      AND job_location LIKE '%Germany%'
      AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT
    DISTINCT skills_dim.skills
FROM data_analyst_jobs AS analysts
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = analysts.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id;

-- subquery test, same results

SELECT
    DISTINCT skills_dim.skills
FROM skills_dim
INNER JOIN skills_job_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE skills_job_dim.job_id IN (SELECT
                    job_id
                FROM job_postings_fact
                WHERE job_title_short = 'Data Analyst'
                  AND job_location LIKE '%Germany%'
                  AND salary_year_avg IS NOT NULL
                ORDER BY salary_year_avg DESC
                LIMIT 10);

