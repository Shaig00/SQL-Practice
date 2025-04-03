
SELECT
    --job_title_short,
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location LIKE '%New%York%NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY 1 DESC;


-- Problem 1

SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY salary_year_avg) AS Q1,
    PERCENTILE_CONT(0.55) WITHIN GROUP (ORDER BY salary_year_avg) AS Q3,
    MAX(salary_year_avg),
    (AVG(salary_year_avg) - 1.5*STDDEV(salary_year_avg)) AS lower_std,
    (AVG(salary_year_avg) + 1.5*STDDEV(salary_year_avg)) AS upper_std
FROM job_postings_fact;

SELECT
    COUNT(*),
    CASE
        WHEN salary_year_avg < 90000 THEN 'low'
        WHEN (salary_year_avg BETWEEN 90000 AND 123500) THEN 'standard'
        WHEN salary_year_avg >= 123500 THEN 'high'
    END AS salary_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY salary_category;
-- ORDER BY salary_year_avg DESC;
