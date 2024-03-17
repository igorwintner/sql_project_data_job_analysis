/*
Q: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings. I also added in the comment the most in-demand skills in the Czechia, if i wanted to see,
  if it's any different from the rest of the world
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
JOIN 
    skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' 
    --AND job_postings_fact.job_country = 'Czechia'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
Here's the breakdown of the most demanded skills for data analysts in 2023
SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.
In Czechia, SQL is also in the first place, but Python is more in-demand than Excel and Power BI is also slightly more in-demand than Tableau.
*/