/*
Q: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

-- Identifies skills in high demand for Data Analyst roles
-- Use Query #3

WITH demanded_skills AS(

    SELECT 
        skills_dim.skill_id,
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
        job_postings_fact.job_title_short = 'Data Analyst' AND
        salary_year_avg	IS NOT NULL 
        --AND job_work_from_home = True AND
        --job_postings_fact.job_country = 'Czechia'
    GROUP BY 
        skills_dim.skill_id
), 

-- Skills with high average salaries for Data Analyst roles
-- Use Query #4

avg_skill_salary AS (

    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    JOIN 
        skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN
        skills_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg	IS NOT NULL AND
        job_work_from_home = 'True'
        --AND job_postings_fact.job_country = 'Czechia'
    GROUP BY 
        skills_job_dim.skill_id
)

-- Return high demand and high salaries ordered by demand count and count of at least 10.

SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_skills.demand_count,
    avg_skill_salary.avg_salary

FROM demanded_skills
JOIN avg_skill_salary
    ON demanded_skills.skill_id = avg_skill_salary.skill_id
WHERE demand_count > 10
ORDER BY 
    demand_count DESC,
    avg_salary DESC

/*
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 1840 and 1073 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued, but also widely available.
If I wanted to filter only remote jobs, the top 5 most in-demand skills are still SQL, Excel, Python, Tableau and R. But e.g. Looker is much more in-demand for remote jobs with a total demand count of 260 and for remote jobs 49.
Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
Business Intelligence and Visualization Tools: Tableau and Power BI, with demand counts of 1659 and 1044 respectively, and average salaries around $99,288 and $97,431, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.*/
