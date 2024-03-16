COPY company_dim
FROM 'C:\Users\uzivatel\Desktop\projekty\sql_project_data_job_analysis\csv_files\company_dim.csv'
DELIMITER ',' CSV HEADER;

COPY skills_dim
FROM 'C:\Users\uzivatel\Desktop\projekty\sql_project_data_job_analysis\csv_files\skills_dim.csv'
DELIMITER ',' CSV HEADER;

COPY job_postings_fact
FROM 'C:\Users\uzivatel\Desktop\projekty\sql_project_data_job_analysis\csv_files\job_postings_fact.csv'
DELIMITER ',' CSV HEADER;

COPY skills_job_dim
FROM 'C:\Users\uzivatel\Desktop\projekty\sql_project_data_job_analysis\csv_files\skills_job_dim.csv'
DELIMITER ',' CSV HEADER;
