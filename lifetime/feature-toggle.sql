-------------------------------------------------------------------------------------------------------------------------------------------------
--Get feature toggle entity physical name
-------------------------------------------------------------------------------------------------------------------------------------------------
select	en.Id, en.name, 
	en.PHYSICAL_TABLE_NAME, 
	en.is_system, en.data_kind, 
	es.NAME as eSpaceName, 
	app.NAME as ApplicationName, 
	d.name as DatabaseCatalog, 
	d.DataTablespace, 
	d.IndexTablespace, 
	'select top 100 * from ' + replace(d.name, '(Main)', 'outsystems') + '.dbo.' + en.PHYSICAL_TABLE_NAME + ' with (nolock) ' as physical_full_name
from	ossys_Entity en inner join ossys_espace es on (es.id = en.ESPACE_ID)
			inner join ossys_module mo on (mo.espace_id = es.id)
			inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
			left join ossys_dbcatalog d on (d.id = es.DBCatalog_Id)
where	1 = 1
--and		es.name like '%FeatureToggleManagement_CS%'
and		es.name like '%featuretoggle%'
and		en.IS_ACTIVE = 1;


-------------------------------------------------------------------------------------------------------------------------------------------------
--Get env keys
-------------------------------------------------------------------------------------------------------------------------------------------------
select	name, host typeId, Uid 
from	OSLTM_ENVIRONMENT with (nolock)
where	isActive = 1


	
----------------------------------------------------------------------------------------------------------------------------
--Feature toggle enabled in prod by age
----------------------------------------------------------------------------------------------------------------------------
declare @devEnvKey varchar(50);
declare @qaEnvKey varchar(50);
declare @prodEnvKey varchar(50);

set @devEnvKey = '98fa5fca-b005-4f45-94b8-b791c73709e1';
set @qaEnvKey = '275f2b13-ce91-4e55-b36b-9b38f8698a33';
set @prodEnvKey = '3e638077-422b-4ec4-a208-c4ce44df42e7';


--Calculate status date from audit tables
with ToggleStatusDate as (
			select	featureToggleId, AUDITTYPEID, CHANGEDESCRIPTION, CREATEDON, RANK() over (partition by featureToggleId order by CREATEDON desc) as rnk
			from	OSUSR_s65_FeatureToggleAudit
			where	1=1
			and		environmentKey = @prodEnvKey --getdate from prod environment
			and		AUDITTYPEID IN ('DEACTIVATION', 'ACTIVATION')
),
--Calculate CanaryRelease date from audit tables
ToggleCanaryDate as (
			select	featureToggleId, AUDITTYPEID, CHANGEDESCRIPTION, CREATEDON, RANK() over (partition by featureToggleId order by CREATEDON desc) as rnk
			from	OSUSR_s65_FeatureToggleAudit
			where	1=1
			and		environmentKey = @prodEnvKey --getdate from prod environment		
			and		AUDITTYPEID = 'CONFIGURATIONUPDATE' -- choose only configuration updates
			and		CHANGEDESCRIPTION like '%restricted%'
),
DevToggles as (
			select	FEATURETOGGLEID, isOn as DEV_Activated, ISCONDITIONALON as DEV_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration
			where	ENVIRONMENTKEY = @devEnvKey
),
QaToggles as (
			select	FEATURETOGGLEID, isOn as QA_Activated, ISCONDITIONALON as QA_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration
			where	ENVIRONMENTKEY = @qaEnvKey
),
ProdToggles as (
			select	FEATURETOGGLEID, isOn as PROD_Activated, ISCONDITIONALON as PROD_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration
			where	ENVIRONMENTKEY = @prodEnvKey
) 

select	ft.[KEY] as FeatureToggleKey, 
		ft.name, 
		ft.ISUNDERDEVELOPMENT, 
		mt.REASON,
		mt.DESCRIPTION,
		mt.owner,
		mt.USERSTORYURL,
		--STRING_AGG(tag.name, ',') as TAGS,
		dev.DEV_activated,
		dev.DEV_CanaryRelease,
		qa.QA_Activated,
		qa.QA_CanaryRelease,
		prod.PROD_Activated,
		prod.PROD_CanaryRelease,
		ts.CREATEDON as Prod_ActivatedDate,
		CASE WHEN prod.PROD_CanaryRelease=0 THEN '' ELSE tcd.CREATEDON END as Prod_CanaryReleaseDate
from	OSUSR_s65_FeatureToggle ft  inner join DevToggles dev on (dev.FEATURETOGGLEID = ft.[KEY])
									left join QaToggles qa on (qa.FEATURETOGGLEID = ft.[KEY])
									left join ProdToggles prod on (prod.FEATURETOGGLEID = ft.[KEY])
									left join OSUSR_s65_FeatureToggleMetadata mt on (mt.featureToggleId = ft.[KEY])
									left join OSUSR_s65_FeatureToggleTag ftt on (ftt.featuretoggleID = ft.[KEY])
									left join OSUSR_s65_Tag tag on (tag.id = ftt.tagid)
									left join ToggleStatusDate ts on (ts.FEATURETOGGLEID = ft.[KEY] and ts.rnk = 1)
									left join ToggleCanaryDate tcd on  (tcd.FEATURETOGGLEID = ft.[KEY] and tcd.rnk = 1)
where	ft.ISACTIVE = 1 --only active feature toggles
group by ft.[KEY], 
		ft.name, 
		ft.ISUNDERDEVELOPMENT, 
		mt.REASON,
		mt.DESCRIPTION,
		mt.owner,
		mt.USERSTORYURL,
		dev.DEV_activated,
		dev.DEV_CanaryRelease,
		qa.QA_Activated,
		qa.QA_CanaryRelease,
		prod.PROD_Activated,
		prod.PROD_CanaryRelease,
		ts.CREATEDON,
		CASE WHEN prod.PROD_CanaryRelease=0 THEN '' ELSE tcd.CREATEDON END
;




