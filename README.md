# Introduction
📊 Explore opportunities in the data job market! This project delves 💸 into well-paying positions for data analysts, highlighting 🔥 sought-after skills and 📈 areas where high demand aligns with lucrative salaries in the field of data analytics.

🔎  SQL queries can be found via this 🔗: [project_sql folder](/project_sql/)

# Background
As a newbie data analyst, I wanted to know what are the optimal skills to have or 📚 learn. At the same time which of those skills are well paid and which ones we should 
🧠 focus on.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these well-paid jobs?
3. What are the most in-demand skills for data analysts?
4. What skills are linked to higher earning potential?
5. What are the most optimal skills to learn?

# Tech Stack
- **SQL:** Serving as the foundation of my analysis, enabling me to query the database and uncover vital insights. Specifically, I used **PostgreSQL** database management system, where I inserted the data into the database and the rest of the queries were done in **Visual Studio Code** connected to the database.

- **Tableau:** Tool I used for simple visualizations of files I exported from VS Code.

- **Git & GitHub:** Ability to share the project with others, but also easily manageable versions of my code.

# The Analysis
Every query in this project was focused on exploring distinct facets of the data analyst job market. Here is my method for addressing each question:

### 1. What are the top-paying data analyst jobs?
```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name

FROM 
    job_postings_fact

LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL 

    /*OR job_title_short = 'Data Analyst' AND
    job_location LIKE '%Prague%' OR
    job_location LIKE '%Brno%'
    If I Wanted to filter out only jobs located in Czechia later*/

ORDER BY salary_year_avg DESC
LIMIT 10 
```
Here is the analysis of the leading data analyst positions in 2023:

**Varied Salary Spectrum:** The top 10 highest-paying data analyst roles range from $184,000 to $650,000, showcasing considerable earning potential within the industry.

**Diverse Employers:** Noteworthy companies such as SmartAsset, Meta, and AT&T are among those offering lucrative salaries, demonstrating a wide interest across diverse sectors.

![Top-paying Data Analyst Roles](<images/Sheet 1.png>)
*Bar chart visualizing top 10 Data Analyst jobs with the highest average salary in 2023. Chart was made with Tableau from a file I exported from VS Code*

### 2. What skills are required for these well-paid jobs?
```sql
WITH top_paying_jobs AS (

    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL 
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
JOIN 
    skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
```

Here is the analysis of the most sought-after skills for data analysts in 2023: 

As indicated by job postings **SQL** takes the lead with the highest count of **8**.

**Python** closely follows with a substantial count of **7**.

**Tableau** is also in high demand, with a noteworthy count of **6**.

Other skills such as **R, Snowflake, Pandas, and Excel** exhibit varying levels of demand.

![alt text](<images/Sheet 2.png>)
*Bar chart visualizing count of the top 10 most occurred skills for Data Analyst in 2023. Chart was made with Tableau from a file I exported from VS Code*

### 3. What are the most in-demand skills for data analysts?
Discover the top 5 most in-demand skills for Data Analysts across all job postings. I also added a filter to the comment, if I wanted to see only jobs in Czechia later.  
```sql
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
```
Here is the breakdown of the most sought-after skills for data analysts in 2023:

| Skills    | Demand Count |
|-----------|--------------|
| sql       | 92628        |
| excel     | 67031        |
| python    | 57326        |
| tableau   | 46554        |
| power bi  | 39468        |

*Table displaying the demand for the primary 5 skills in job postings for data analysts*

| Skills    | Demand Count Czechia |
|-----------|-----------------------|
| sql       | 528                   |
| python    | 298                   |
| excel     | 275                   |
| power bi  | 234                   |
| tableau   | 209                   |

*Table displaying the demand for the primary 5 skills in job postings for data analysts in Czechia*

**SQL** and **Excel** continue to be crucial, underscoring the importance of solid foundational skills in data manipulation and spreadsheet usage.

Programming languages and Visualization Tools such as **Python, Tableau**, and **Power BI** are vital, indicating a growing necessity for technical abilities in data visualization and decision-making support.

In the Czechia, **SQL** remains at the forefront, with **Python** surpassing **Excel** in demand, and **Power BI** slightly edging out **Tableau** in popularity.

### 4. What skills are linked to higher earning potential?
Examine the average salary linked to individual skills within Data Analyst roles aids in pinpointing the most lucrative skills to develop or enhance. Unfortunately no data was available for Czechia located jobs.
```sql
SELECT 
    skills,
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
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```
Here is an analysis of the outcomes concerning the most lucrative skills for Data Analysts:

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table displaying the average salary for the top 10 highest-paying skills among data analysts*

**Robust Demand for Big Data & ML Skills:** Analysts proficient in big data technologies (such as PySpark, Couchbase), machine learning tools (like DataRobot, Jupyter), and Python libraries (such as Pandas, NumPy) command top salaries, highlighting the industry's emphasis on data processing and predictive modeling capabilities.

**Expertise in Software Development & Deployment:** Understanding of development and deployment tools (such as GitLab, Airflow) indicates a valuable overlap between data analysis and engineering.

**Mastery of Cloud Computing:** Knowledge of cloud and data engineering tools (like Elasticsearch, Databricks, GCP) underscores the rising significance of cloud-based analytics environments, suggesting that proficiency in cloud technologies significantly enhances earning potential within the data analytics field.

### 5. What are the most optimal skills to learn?
Identify skills highly sought after and associated with above-average salaries in Data Analyst positions, focusing on remote roles with specified pay scales.

```sql
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
        --AND job_work_from_home = True
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
```
Here is an analysis of the most advantageous skills for Data Analysts in 2023:

|Skill ID|Skills         |Demand Count|Average Salary|
|--------|---------------|------------|----------|
|0       |sql            |3083        |97237     |
|181     |excel          |2143        |87288     |
|1       |python         |1840        |101397    |
|182     |tableau        |1659        |99288     |
|5       |r              |1073        |100499    |
|183     |power bi       |1044        |97431     |
|188     |word           |527         |82576     |
|196     |powerpoint     |524         |88701     |
|7       |sas            |500         |98902     |
|61      |sql server     |336         |97786     |

*Table displaying the most optimal skills for data analyst sorted by the demand count*

|Skill ID|Skills    |Demand Count|Average Salary|
|--------|----------|------------|----------|
|0       |sql       |398         |97237     |
|181     |excel     |256         |87288     |
|1       |python    |236         |101397    |
|182     |tableau   |230         |99288     |
|5       |r         |148         |100499    |
|183     |power bi  |110         |97431     |
|7       |sas       |63          |98902     |
|196     |powerpoint|58          |88701     |
|185     |looker    |49          |103795    |
|80      |snowflake |37          |112948    |

*Table displaying the most optimal skills for data analyst sorted by the demand count (remote jobs)*


**High-Demand Programming Languages:** Python and R are standout languages, with demand counts of 1840 and 1073 respectively. Despite their popularity, average salaries hover around $101,397 for Python and $100,499 for R, indicating their widespread value and availability in the market.

**Remote positions:** The top 5 most sought-after skills for remain SQL, Excel, Python, Tableau, and R. However, Looker exhibits notably higher demand for remote jobs with a total count of 260 and 49, respectively, for remote jobs specifically.

**Cloud Tools and Technologies:** Proficiency in specialized platforms such as Snowflake, Azure, AWS is in high demand with relatively lucrative average salaries, underscoring the increasing significance of cloud platforms in data analysis.

**Business Intelligence and Visualization Tools:** Tableau and Power BI, with demand counts of 1659 and 1044 respectively, boast average salaries around $99,288 and $97,431, emphasizing the crucial role of data visualization and BI in extracting actionable insights from data.

**Database Technologies:** The need for skills in both traditional and NoSQL databases (such as Oracle or SQL Server) remains strong, with average salaries ranging from $97,786 to $104,534, reflecting the ongoing demand for expertise in data storage, retrieval, and management.

# What I Learned
**🔍 Skillful Query Crafting:** Perfected the techniques of advanced SQL, expertly combining tables and wielding WITH clauses for agile temporary table handling.

**📊 Data Summarization:** Developed a strong rapport with GROUP BY, transforming functions such as COUNT() and AVG() into invaluable tools for data synthesis.

**🔮 Analytical Mastery:** Enhanced my ability to solve real-world problem, translating inquiries into actionable, enlightening SQL queries.

# Conclusions
1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!

2. **Skills required for Top-Paying Jobs**: Well-paid data analyst positions demand an advanced mastery of SQL, indicating its pivotal role in securing a top-tier salary.

3. **Most In-Demand Skills**: SQL stands out as the most sought-after skill in the data analyst job market, underscoring its indispensable nature for job seekers.

4. **Skills linked to Higher Salaries**: Specialized skills like Bitbucket and GitLab are linked to the highest average salaries, highlighting the value placed on niche expertise.

5. **Most Optimal Skills to Learn**: SQL takes the lead in demand and salary offerings, with a high average salary, making it one of the most advantageous skills for data analysts to acquire.
