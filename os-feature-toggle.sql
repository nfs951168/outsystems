-------------------------------------------------------------------------------------------------------------------------------------------------
--Entity physical name and logical names
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



----------------------------------------------------------------------------------------------------------------------------
--Feature toggle enabled in prod by age
----------------------------------------------------------------------------------------------------------------------------
declare @prodEnvKey varchar(50);

set @prodEnvKey = 'a5c43709-deec-4521-ab22-56f604153784';


--Calculate status date from audit tables
with ToggleStatusDate as (
			select	featureToggleId, AUDITTYPEID, CHANGEDESCRIPTION, CREATEDON, RANK() over (partition by featureToggleId order by CREATEDON desc) as rnk
			from	OSUSR_s65_FeatureToggleAudit1
			where	1=1
			and		environmentKey = @prodEnvKey --getdate from prod environment
			and		AUDITTYPEID IN ('DEACTIVATION', 'ACTIVATION')
),
--Calculate CanaryRelease date from audit tables
ToggleCanaryDate as (
			select	featureToggleId, AUDITTYPEID, CHANGEDESCRIPTION, CREATEDON, RANK() over (partition by featureToggleId order by CREATEDON desc) as rnk
			from	OSUSR_s65_FeatureToggleAudit1
			where	1=1
			and		environmentKey = @prodEnvKey --getdate from prod environment		
			and		AUDITTYPEID = 'CONFIGURATIONUPDATE' -- choose only configuration updates
			and		CHANGEDESCRIPTION like '%restricted%'
)

select	ft.[KEY] as FeatureToggleKey, 
		ft.name, 
		ft.ISUNDERDEVELOPMENT, 
		mt.REASON,
		mt.DESCRIPTION,
		mt.PredictedActivationDate,
		mt.owner,
		mt.USERSTORYURL,
		STRING_AGG(tag.name, ',') as TAGS,
		env.name as Environment_Name, 
		ftc.ison as Environment_IsOn, 
		ts.CREATEDON as Environment_StatusDate,
		ftc.ISCONDITIONALON as Environment_CanaryRelease,
		tcd.CREATEDON as Environment_CanaryReleaseDate
from	OSUSR_s65_FeatureToggle1 ft inner join OSUSR_s65_FeatureToggleConfiguration1 ftc on (ftc.FEATURETOGGLEID = ft.[KEY])
									inner join OSLTM_ENVIRONMENT env on (env.uid = ftc.ENVIRONMENTKEY)
									inner join OSUSR_s65_FeatureToggleMetadata1 mt on (mt.featureToggleId = ft.[KEY])
									left join OSUSR_s65_FeatureToggleTag1 ftt on (ftt.featuretoggleID = ft.[KEY])
									left join OSUSR_s65_Tag1 tag on (tag.id = ftt.tagid)
									left join ToggleStatusDate ts on (ts.FEATURETOGGLEID = ft.[KEY] and ts.rnk = 1)
									left join ToggleCanaryDate tcd on  (tcd.FEATURETOGGLEID = ft.[KEY] and tcd.rnk = 1)
where	ft.ISACTIVE = 1 --only active feature toggles
and		ft.ISUNDERDEVELOPMENT = 0 --feature toggle that are in production mode
and		env.uid = @prodEnvKey
group by ft.[KEY], 
		ft.name, 
		ft.ISUNDERDEVELOPMENT, 
		mt.REASON,
		mt.DESCRIPTION,
		mt.PredictedActivationDate,
		mt.owner,
		mt.USERSTORYURL,
		env.name, 
		ftc.ison, 
		ts.CREATEDON,
		ftc.ISCONDITIONALON,
		tcd.CREATEDON
;






----------------------------------------------------------------------------------------------------------------------------
--Playground
----------------------------------------------------------------------------------------------------------------------------

select * from OSLTM_ENVIRONMENT

select * from OSUSR_s65_FeatureToggleMetadata1


select * from OSUSR_s65_FeatureToggleAuditDetail1




select	featureToggleId, AUDITTYPEID, CHANGEDESCRIPTION, CREATEDON, RANK() over (partition by featureToggleId order by CREATEDON desc) as rnk
from	OSUSR_s65_FeatureToggleAudit1
where	1=1
and		environmentKey =  'a5c43709-deec-4521-ab22-56f604153784'
and		AUDITTYPEID = 'CONFIGURATIONUPDATE' -- choose only configuration updates
and		CHANGEDESCRIPTION like '%restricted%'
and		FEATURETOGGLEID = ''


select	FEATURETOGGLEID, max(CREATEDON) as ActivationDate
from	OSUSR_s65_FeatureToggleAudit1
where	FEATURETOGGLEID = ''
and		environmentKey = 'a5c43709-deec-4521-ab22-56f604153784'
and		audittypeID = 'ACTIVATION'
group by FEATURETOGGLEID




