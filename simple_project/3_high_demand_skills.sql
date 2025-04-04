
-- I want to find out most frequently desired skills
-- in a junior data analyst position in Berlin, Germany
-- here we do not consider salary, as these are junior jobs, and presumably entry level


WITH ranked_skills_germany AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(jobs.job_id) AS skill_count,
        DENSE_RANK() OVER (ORDER BY COUNT(jobs.job_id) DESC) AS skill_rank
    FROM job_postings_fact AS jobs
    INNER JOIN skills_job_dim
        ON skills_job_dim.job_id = jobs.job_id
    INNER JOIN skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE jobs.job_title_short = 'Data Analyst'
      AND LOWER(jobs.job_title) LIKE '%junior%'
      AND jobs.job_location LIKE '%Germany%'
    GROUP BY skills_dim.skill_id
)
SELECT *
FROM ranked_skills_germany
WHERE skill_rank <= 10


/* Seems like SQL is desired followed by Tableau and python.
   I know SQL and python pretty well.
   My weakness: I haven't even started with Tableau
   To Do: I got to publish these results on Tableau and post it on my cv

   But seems like I cannot connect to BigQuery from Tableau, can do from Looker.
 */