--1. Get Domain information
-- Generate insert statement from dev environment
select  distinct  
	'insert into #tmp_domains (domain, application) values ('''+d.label+''','''+ad.name+''')'
from    osusr_mrn_moduledef1 md 
inner join osusr_mrn_applicationdef1 ad    on (md.applicationdefid = ad.id)
left join  osusr_mrn_domain1 d on (ad.domainid = d.id)
left join  osusr_mrn_modulelayer1 ml on  (ad.layer =  ml.id)
where    1 = 1
and d.label is not null



--2. Prepare domain table in each production environment (if more than one)

--Create temporary table
create table #tmp_domains (
domain nvarchar(400) COLLATE Latin1_General_CI_AI,
application nvarchar(400) COLLATE Latin1_General_CI_AI
)

--3. Run insert statement generated on 1