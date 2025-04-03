
SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (SELECT company_id
                     FROM job_postings_fact
                     WHERE job_no_degree_mention = true)
ORDER BY 1;


WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    name,
    total_jobs
FROM company_job_count
LEFT JOIN company_dim
    ON company_dim.company_id = company_job_count.company_id
ORDER BY total_jobs DESC;

-- Problem 1

-- with CTE
WITH top_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_frequency
    FROM skills_job_dim
    GROUP BY skill_id
)
SELECT
    skills AS skill,
    skill_frequency
FROM top_skills
LEFT JOIN skills_dim
    ON skills_dim.skill_id = top_skills.skill_id
ORDER BY skill_frequency DESC
LIMIT 5;

-- Problem 2

WITH cte_company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    company_dim.name AS company_name,
    total_jobs AS total_jobs_posted,
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        WHEN total_jobs > 50 THEN 'Large'
    END AS size_category
FROM cte_company_job_count AS cte
LEFT JOIN company_dim
    ON cte.company_id = company_dim.company_id;


-- Tutorial Problem 6

WITH remote_analyst_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_frequency
    FROM skills_job_dim
    INNER JOIN job_postings_fact AS job_postings
        ON skills_job_dim.job_id = job_postings.job_id
    WHERE
        job_postings.job_work_from_home = TRUE
        AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT
    skills_dim.skill_id,
    skills AS skill_name,
    skill_frequency
FROM remote_analyst_skills
LEFT JOIN skills_dim -- INNER JOIN also works essentially
    ON remote_analyst_skills.skill_id = skills_dim.skill_id
ORDER BY skill_frequency DESC
LIMIT 5;









