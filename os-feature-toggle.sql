----------------------------------------------------------------------------------------------------------------------------
--Feature toggle enabled in prod by age
----------------------------------------------------------------------------------------------------------------------------
declare @devEnvKey varchar(50);
declare @qaEnvKey varchar(50);
declare @prodEnvKey varchar(50);

set @devEnvKey = '6d3e0b55-8a34-49a6-8142-d7a0347ad1c3';
set @qaEnvKey = '0cedda6b-24ad-49e7-8d8d-649217fb88ed';
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
),
DevToggles as (
			select	FEATURETOGGLEID, isOn as DEV_Activated, ISCONDITIONALON as DEV_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration1
			where	ENVIRONMENTKEY = @devEnvKey
),
QaToggles as (
			select	FEATURETOGGLEID, isOn as QA_Activated, ISCONDITIONALON as QA_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration1
			where	ENVIRONMENTKEY = @qaEnvKey
),
ProdToggles as (
			select	FEATURETOGGLEID, isOn as PROD_Activated, ISCONDITIONALON as PROD_CanaryRelease
			from	OSUSR_s65_FeatureToggleConfiguration1
			where	ENVIRONMENTKEY = @prodEnvKey
) 

select	ft.[KEY] as FeatureToggleKey, 
		ft.name, 
		ft.ISUNDERDEVELOPMENT, 
		mt.REASON,
		mt.DESCRIPTION,
		mt.owner,
		mt.USERSTORYURL,
		STRING_AGG(tag.name, ',') as TAGS,
		dev.DEV_activated,
		dev.DEV_CanaryRelease,
		qa.QA_Activated,
		qa.QA_CanaryRelease,
		prod.PROD_Activated,
		prod.PROD_CanaryRelease,
		ts.CREATEDON as Prod_ActivatedDate,
		CASE WHEN prod.PROD_CanaryRelease=0 THEN '' ELSE tcd.CREATEDON END as Prod_CanaryReleaseDate
from	OSUSR_s65_FeatureToggle1 ft inner join DevToggles dev on (dev.FEATURETOGGLEID = ft.[KEY])
									left join QaToggles qa on (qa.FEATURETOGGLEID = ft.[KEY])
									left join ProdToggles prod on (prod.FEATURETOGGLEID = ft.[KEY])
									left join OSUSR_s65_FeatureToggleMetadata1 mt on (mt.featureToggleId = ft.[KEY])
									left join OSUSR_s65_FeatureToggleTag1 ftt on (ftt.featuretoggleID = ft.[KEY])
									left join OSUSR_s65_Tag1 tag on (tag.id = ftt.tagid)
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




