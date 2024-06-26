-------------------------------------------------------------------------------------------------------------------------------------------------
--Entity physical name and logical names
-------------------------------------------------------------------------------------------------------------------------------------------------
select	en.Id, en.name,
	en.description,
	replace(d.name, '(Main)', 'OSPRD4') + '.dbo.' + en.PHYSICAL_TABLE_NAME as PhysicalTableName, 
	en.is_system, 
	en.data_kind, 
	es.NAME as eSpaceName, 
	app.NAME as ApplicationName, 
	d.name as DatabaseCatalog, 
	d.DataTablespace, 
	d.IndexTablespace, 
	'select top 100 * from ' + replace(d.name, '(Main)', 'OSPRD4') + '.dbo.' + en.PHYSICAL_TABLE_NAME + ' with (nolock) ' as physical_full_name
from	ossys_Entity en inner join ossys_espace es on (es.id = en.ESPACE_ID)
			inner join ossys_module mo on (mo.espace_id = es.id)
			inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
			left join ossys_dbcatalog d on (d.id = es.DBCatalog_Id)
where	1 = 1
and		es.name like '%serviceCenter%'
and		en.description like '%analytics%'
and		en.IS_ACTIVE = 1
order by 2 asc;



-----------------------------------------------------------------------------------------------------------------------------------------------
--1. Get Domain information from dev environment
-----------------------------------------------------------------------------------------------------------------------------------------------

select  distinct  
	'insert into #tmp_domains (domain, application) values ('''+d.label+''','''+ad.name+''')'
from    osusr_mrn_moduledef1 md 
inner join osusr_mrn_applicationdef1 ad    on (md.applicationdefid = ad.id)
left join  osusr_mrn_domain1 d on (ad.domainid = d.id)
left join  osusr_mrn_modulelayer1 ml on  (ad.layer =  ml.id)
where    1 = 1
and d.label is not null



-----------------------------------------------------------------------------------------------------------------------------------------------
--2. Create domain table in each production environment (if more than one)
-----------------------------------------------------------------------------------------------------------------------------------------------
create table #tmp_domains (
domain nvarchar(400) COLLATE Latin1_General_CI_AI,
application nvarchar(400) COLLATE Latin1_General_CI_AI
)

--Execute insert statements


-----------------------------------------------------------------------------------------------------------------------------------------------
--3. Get Application Objects by domain
-----------------------------------------------------------------------------------------------------------------------------------------------
with AO as (
			select	es.id, es.name as ModuleName, app.name as ApplicationName, do.domain, su.OMLCOMPLEXITY as ApplicationObjects
			from	OSSYS_REPORT_SU su inner join ossys_espace es on (es.id = su.espaceid)
										left join ossys_module mo on (mo.espace_id = es.id)
										left join ossys_app_definition_module adm on (adm.module_id = mo.id)
										left join ossys_application app on (app.id = adm.application_id)
										left join #tmp_domains do on (do.application = app.name)
			where	es.is_active = 1
			and		is_system = 0
			--and		app.name = 'CTT - Correios de Portugal'
)

select	ApplicationName, domain, sum(applicationObjects) as ApplicationObjects
from	AO
group by ApplicationName, domain
order by 1 desc


