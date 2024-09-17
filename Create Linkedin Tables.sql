create table companies (
company_id int not null unique,
name varchar(100), 
description varchar(255),
company_size int, 
state varchar(100),
country varchar(3),
city varchar(100),
zip_code varchar(12),
address varchar(255),
url varchar(255),
PRIMARY KEY(company_id)
);

Select * from companies;

create table company_industries (
company_id int not null unique,
industry varchar(100),
primary key (company_id)
);

Select * from company_industries;

create table company_specialities (
company_id int not null unique,
speciality varchar(100),
primary key (company_id)
);

create table employee_counts (
company_id int not null unique,
employee_count int,
follower_count int,
time_recorded datetime,
primary key (company_id)
);

create table benefits (
job_id int not null,
inferred bool,
benefit_type varchar(100),
primary key (job_id)
);

create table job_industries (
job_id int not null unique,
industry_id int,
primary key (job_id)
);

create table job_skills (
job_id int not null,
skill_abr varchar(100),
constraint job_skill primary key (job_id, skill_abr)
);

create table salaries (
salary_id int not null unique,
job_id int,
max_salary int,
med_salary int,
min_salary int,
pay_period varchar (50),
currency text(10),
compensation_type varchar(100),
primary key (salary_id)
);

create table industries (
industry_id int not null unique,
industry_name varchar(255),
primary key (industry_id)
);

create table skills (
skill_abr varchar(5) not null unique,
skill_name varchar(100),
primary key (skill_abr)
);

create table postings (
job_id	int not null unique,
company_name varchar(255),
title varchar(255),
description	varchar(255),
max_salary int,
pay_period varchar(10),
location varchar(100),
company_id	int,
views	int,
med_salary	int,
min_salary	int,
formatted_work_type	varchar(20),
applies	int,
original_listed_time	datetime,
remote_allowed	bool,
job_posting_url	varchar(255),
application_url	varchar(255),
application_type	varchar(255),
expiry	datetime,
closed_time	datetime,
formatted_experience_level	varchar(100),
skills_desc	varchar(255),
listed_time	datetime,
posting_domain	varchar(255),
sponsored	bool,
work_type	varchar(20),
currency	varchar(5),
compensation_type	varchar(20),
normalized_salary	int,
zip_code	int,
fips	int,
primary key (job_id)
);
