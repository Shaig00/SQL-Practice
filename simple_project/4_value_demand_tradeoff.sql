

-- Valuing skills based on average annual salary of the job posting it appeared in.
-- Not quiet an accurate indicator of the skill value I would say
-- Count would be more optimal, as I did in previous query.

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(jobs.salary_year_avg), 0) AS skill_value,
    COUNT(jobs.job_id) AS skill_demand,
    RANK() OVER (ORDER BY AVG(jobs.salary_year_avg) DESC) AS skill_value_rank,
    RANK() OVER (ORDER BY COUNT(jobs.job_id) DESC) AS skill_demand_rank
FROM job_postings_fact AS jobs
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = jobs.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE jobs.job_title_short = 'Data Analyst'
--     AND LOWER(jobs.job_title) LIKE '%junior%'
    AND jobs.job_location LIKE '%Germany%'
    AND jobs.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
--     HAVING COUNT(jobs.job_id) >= 10
ORDER BY 4 DESC, 3 DESC;

/*
 I don't understand why Luke does this with double CTE in his tutorial.
 Seems like he doesn't know what he is doing.

 Results of the query, however, show that data analyst positions in Germany require
 sql, python, tableau, spark and excel as top 5 skills. Considering that this table is sorted
 first by prioritizing the demand, second, the average skill salary of the jobs that require that skill.

 SQL is the most optimal, as it gives a lot of opportunities to find a job, despite being at rank 28 with value.
 spark is however ranked at 7 for its value.

 Most optimal thing would be to come up with a measure for finding the harmonic balance of these skills.
 */