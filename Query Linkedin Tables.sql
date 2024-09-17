
-- explore: 
Select * -- job_id
from postings order by company_id desc, job_id asc limit 100;
-- job_id -> Skills and industries
-- skill id -> Skill name
-- industry id -> industry name
-- it would be redundant to do both industry and skill, would show ugly repeating results
-- job id -- > benefits

-- a select with multiple joins
Select distinct 
p.job_id,  p.title, p.company_name, s.skill_name, l.max_salary, l.med_salary, l.min_salary, b.benefit_type
from postings p 
left join job_skills js on p.job_id = js.job_id
left join skills s on js.skill_abr = s.skill_abr
left join salaries l on p.job_id = l.job_id
left join benefits b on p.job_id = b.job_id
where p.job_id in (
'3888029743'
'3887841033',
'3887473432',
'3887844083',
'3888030881',
'3887873304',
'3887475425',
'3887835641',
'3888033306',
'3888038022',
'3885109791',
'3887489289',
'3878072014',
'3886824700',
'3884442045',
'3886211899',
'3888036167'
)
order by p.job_id asc, s.skill_name asc, b.benefit_type asc;

-- some aggregation - do jobs which post salaries get more views and applications than jobs which do not? 

Select min(normalized_salary), max(normalized_salary), avg(normalized_salary)
from postings;
/*
# min(normalized_salary), max(normalized_salary), avg(normalized_salary)
'0', '535,600,000', '82,004.8642'
*/

Select "unlisted" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med, 
avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal,
sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications,
avg(applies) as avg_applications
from postings
where 
min_salary = 0 and med_salary = 0 and max_salary = 0
union
Select "low" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med, 
avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal,
sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications,
avg(applies) as avg_applications
from postings
where 
max_salary between 1 and 60000
and 
normalized_salary < 60000
union
Select "mid" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med, 
avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal,
sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications,
avg(applies) as avg_applications
from postings
where 
min_salary > 60000
and (max_salary < 90000 or normalized_salary < 90000)
union
Select "high" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med, 
avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal,
sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications,
avg(applies) as avg_applications
from postings
where 
min_salary >= 80000
and (max_salary >=90000 or normalized_salary >= 90000);

/*
Efficiency: 
14:44:57	Select "unlisted" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med,  avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal, sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications, avg(applies) as avg_applications from postings where  min_salary = 0 and med_salary = 0 and max_salary = 0 union Select "low" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med,  avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal, sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications, avg(applies) as avg_applications from postings where  max_salary between 1 and 60000 and  normalized_salary < 60000 union Select "mid" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med,  avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal, sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications, avg(applies) as avg_applications from postings where  min_salary > 60000 and (max_salary < 90000 or normalized_salary < 90000) union Select "high" as salary_cat, count(job_id) as jobs, avg(max_salary) as avg_max, avg(med_salary) as avg_med,  avg(min_salary) as avg_min, avg(normalized_salary) as avg_norm_sal, sum(views) as total_views, avg(views) as avg_views, sum(applies) as total_applications, avg(applies) as avg_applications from postings where  min_salary >= 80000 and (max_salary >=90000 or normalized_salary >= 90000)	
4 row(s) returned	1.281 sec / 0.000 sec
*/

/* 
output: 
# salary_cat, jobs, avg_max, avg_med, avg_min, avg_norm_sal, total_views, avg_views, total_applications, avg_applications
'unlisted', '15185', '0.0000', '0.0000', '0.0000', '0.0000', '214187', '14.1052', '23105', '1.5216'
'low', '1138', '9787.0817', '0.0000', '8080.2636', '43091.6467', '16955', '14.8989', '2507', '2.2030'
'mid', '517', '86148.1896', '0.0000', '70282.0000', '379810.8491', '15200', '29.4004', '1845', '3.5687'
'high', '1764', '182993.2971', '0.0000', '127506.2545', '620785.5028', '46121', '26.1457', '5263', '2.9836'
*/


