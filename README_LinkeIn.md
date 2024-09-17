# Project Overview: 

The purpose of this project is to demonstrate table creation and setup, data population from a source file, and querying multiple tables with aggregaion in a MySQL database. 


# Data Source: 

https://www.kaggle.com/datasets/arshkon/linkedin-job-postings

Arsh Kon <https://www.kaggle.com/arshkon> and 1 collaborator · Updated 25 days ago as of 9/12/24

# Table of contents: 

1. LI_CSV_DATA_1 ...  every source csv file except the "postings" csv. This file is too large to upload to git, you will have to pull it form the Kaggle link above. 
2. Create Linkedin Tables.sql ... set up the blank tables to receive csv data.  
3. Import Linkedin Data to Tables.sql ... populated tables with data from csv files, includes troubleshooting and alterations
4. Query Linkedin Tables.sql ... three main queries - one basic exploration with joins, one simple aggregation, one complex aggregation across multiple tables with unions. 
5. Linkedin_Select_Multiple_Joins.csv ... results of joining across tables to get clearer information on the benefits and skills on a specific set of job postings. 
6. Linkedin_aggregation_attention_by_salary ... query with unions and aggregations exploring how posted salary affects views and 

---

# Data Dictionary: 

job_postings.csv

job_id: The job ID as defined by LinkedIn (https://www.linkedin.com/jobs/view/ job_id )
company_id: Identifier for the company associated with the job posting (maps to companies.csv)
title: Job title.
description: Job description.
max_salary: Maximum salary
med_salary: Median salary
min_salary: Minimum salary
pay_period: Pay period for salary (Hourly, Monthly, Yearly)
formatted_work_type: Type of work (Fulltime, Parttime, Contract)
location: Job location
applies: Number of applications that have been submitted
original_listed_time: Original time the job was listed
remote_allowed: Whether job permits remote work
views: Number of times the job posting has been viewed
job_posting_url: URL to the job posting on a platform
application_url: URL where applications can be submitted
application_type: Type of application process (offsite, complex/simple onsite)
expiry: Expiration date or time for the job listing
closed_time: Time to close job listing
formatted_experience_level: Job experience level (entry, associate, executive, etc)
skills_desc: Description detailing required skills for job
listed_time: Time when the job was listed
posting_domain: Domain of the website with application
sponsored: Whether the job listing is sponsored or promoted.
work_type: Type of work associated with the job
currency: Currency in which the salary is provided.
compensation_type: Type of compensation for the job.
‎

job_details/benefits.csv

job_id: The job ID
type: Type of benefit provided (401K, Medical Insurance, etc)
inferred: Whether the benefit was explicitly tagged or inferred through text by LinkedIn
‎

company_details/companies.csv

company_id: The company ID as defined by LinkedIn
name: Company name
description: Company description
company_size: Company grouping based on number of employees (0 Smallest - 7 Largest)
country: Country of company headquarters.
state: State of company headquarters.
city: City of company headquarters.
zip_code: ZIP code of company's headquarters.
address: Address of company's headquarters
url: Link to company's LinkedIn page
‎

company_details/employee_counts.csv

company_id: The company ID
employee_count: Number of employees at company
follower_count: Number of company followers on LinkedIn
time_recorded: Unix time of data collection