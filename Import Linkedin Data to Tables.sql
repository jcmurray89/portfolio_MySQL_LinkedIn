select @@secure_file_priv;
/*
'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\'
*/

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/companies.csv'
into table companies
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table companies 
modify column description varchar(10000);

alter table companies
modify column zip_code varchar(100);

alter table companies 
modify column city varchar(1000);

/*
edited the data for this one: 
15:39:28	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/companies.csv' into table companies fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	Error Code: 1366. Incorrect integer value: '' for column 'company_size' at row 1943	0.204 sec
cell was blank
*/

-- Select * from companies limit 10; confirmed nothing has imported yet after error no fear of duplicate data

/*
16:04:05	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/companies.csv' into table companies fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	24473 row(s) affected Records: 24473  Deleted: 0  Skipped: 0  Warnings: 0	0.844 sec

*/

Select * from companies limit 10;

-- BENEFITS table:
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/benefits.csv'
into table benefits
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table benefits 
modify column job_id varchar(12);

alter table benefits 
drop Primary Key,
Add primary key (job_id, benefit_type);

Select * from benefits limit 10;

-- Company industries: 
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/company_industries.csv'
into table company_industries
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table company_industries
modify column industry varchar(100);

alter table company_industries
drop primary key,
add primary key (company_id, industry);

Select * from company_industries limit 10;

/*
Problem was text contained commas. 
I removed them all with find and replace

Also removed duplicates
*/

-- company specialties table: 
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/company_specialities.csv'
into table company_specialities
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- noticed spelling error on table name: "company_specialities" vs "specialties"

alter table company_specialities
drop primary key,
#add column cs_id int not null auto_increment,
add primary key (cs_id);

alter table company_specialities
modify column company_id int;

alter table company_specialities
drop column company_id,
add column company_id int;

-- data too long for "speciality" 100 chars

alter table company_specialities
modify column speciality varchar(5000);

select * from company_specialities limit 10;

/*
I thought the above ^ would fid the duplicate key errors, but I get this: 
09:17:22	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/company_specialities.csv' into table company_specialities fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	Error Code: 1261. Row 1 doesn't contain data for all columns	0.000 sec

Going back to plan 1: add an id in the csv. 

Order matters: 
09:21:53	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/company_specialities.csv' into table company_specialities fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	Error Code: 1366. Incorrect integer value: 'window replacement ' for column 'cs_id' at row 1	0.000 sec

Issue persisted, would not allow uplicate company_id even after modifying column and creating a separate index.
 Dropped index manually through MySQL options. Ran: 
09:31:39	DROP INDEX `company_id` ON `linkedin`.`company_specialities`	OK	0.000 sec

*/

-- employee counts table: 
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee_counts.csv'
into table employee_counts
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- time data bad

alter table employee_counts
modify column time_recorded int;

-- we actualy need a unique id of company + time because there are some with data tracked over time. 

alter table employee_counts 
drop primary key,
add primary key (company_id, time_recorded);

drop index company_id on employee_counts;

-- removed 101 duplicates by time + company from the csv. 

select * from employee_counts limit 10;

-- Industries table:
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/industries.csv'
into table industries
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table industries
modify column industry_name varchar(500);
-- also removed commas from the csv

Select * from industries limit 10;

-- job_industries table: 

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_industries.csv'
into table job_industries
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table job_industries
modify column job_id varchar(15);

drop index job_id on job_industries;

alter table job_industries
drop primary key,
add primary key (job_id, industry_id);

select * from job_industries limit 10;

/*
09:46:59	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_industries.csv' into table job_industries fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	
Error Code: 1264. Out of range value for column 'job_id' at row 1	0.000 sec

executing complex key plan for good duplicate data. 
*/

-- job_skills table:

-- we are getting smarter, I anticipate the same problem for job_skills as job_industries
-- There is no "index" other than the pimrary key, do nothing to drop there. 

alter table job_skills
drop primary key,
add primary key (job_id, skill_abr);

alter table job_skills
modify column job_id varchar(15);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/job_skills.csv'
into table job_skills
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from job_skills limit 10;

-- salaries table: 

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/salaries.csv'
into table salaries
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- "job id" is consistently too large for an int. 

alter table salaries
modify column job_id varchar(20);

-- also filled in blanks with 0 because of "incorrect integer value" error
-- need to support decimals
alter table salaries
modify column max_salary float,
modify column med_salary float,
modify column min_salary float;

select * from salaries limit 10;

-- Skills table: 

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/skills.csv'
into table skills
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- it just worked correctly the first time?

select * from skills limit 10;

-- ^ yes it did!

-- The big one: The Postings Table: 

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postings.csv'
into table postings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table postings
modify column description longtext;

-- can't read codified datetime:
alter table postings
modify column original_listed_time bigint,
modify column expiry bigint,
modify column closed_time bigint,
modify column listed_time bigint;

alter table postings
modify column skills_desc longtext;

alter table postings 
modify column job_id varchar(20);

alter table postings
modify column application_url longtext;

/*
Timing out?

10:29:12	load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postings.csv' into table postings fields terminated by ',' enclosed by '"' lines terminated by '\n' ignore 1 rows	
Error Code: 2013. Lost connection to MySQL server during query	30.015 sec

https://dev.mysql.com/doc/refman/8.4/en/server-system-variables.html#sysvar_net_read_timeout

123,850 ROWS

REDUCED DOWN TO 20,000
*/

set session wait_timeout = 99999;

-- Issue persists ^ 

set session net_read_timeout = 99999;

set session net_retry_count = 99999;

-- success with a smaller file. Need to research whether a personal PC is capable of this, which other settings may help. 
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postings_smaller.csv'
into table postings
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

Select * from postings limit 10;
