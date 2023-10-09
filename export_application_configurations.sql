--Create temp table to store espaces to consider
select	app.id as ApplicationId, app.name ApplicationName, es.id as eSpaceId, es.name eSpaceName
INTO	#tmp_espaces
from	ossys_espace es inner join ossys_module mo on (mo.espace_id = es.id)
						inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
						inner join ossys_application app on (app.id = adm.application_id)
where	1 = 1
and		es.IS_ACTIVE = 1
and		app.name in ('Lease Management', 'Lease Management BandT', 'ATSecurity API', 'Finantial Services');


--Export Timer configuration
SELECT	tmp.ApplicationName, 
		tmp.ApplicationId, 
		tmp.eSpaceName, 
		tmp.eSpaceId,
		mcj.NAME AS TimerName,
		mcj.DEFAULT_SCHEDULE AS TimerDefaultSchedule,
		cjs.SCHEDULE as TimerEffectiveValue
FROM	[ossys_Meta_Cyclic_Job] AS mcj  LEFT JOIN [ossys_Cyclic_Job_Shared] cjs ON cjs.META_CYCLIC_JOB_ID = mcj.ID
										LEFT JOIN [ossys_Espace] e ON e.Id = mcj.ESPACE_ID
										INNER JOIN #tmp_espaces tmp on (tmp.eSpaceId = e.Id)
WHERE	mcj.IS_ACTIVE = 1


--Export site properties configuration
SELECT	tmp.ApplicationName, 
		tmp.ApplicationId, 
		tmp.eSpaceName, 
		tmp.eSpaceId,
		spd.ID AS SitePropertyID,
		spd.NAME AS SitePropertyName,
		spd.DEFAULT_VALUE AS DefaultValue,
		sps.PROPERTY_VALUE AS EffectiveValue,
		sps.USER_MODIFIED AS IsUserModified
FROM	[ossys_Site_Property_Definition] as spd LEFT JOIN [ossys_Site_Property_Shared] sps on sps.SITE_PROPERTY_DEFINITION_ID = spd.ID
												INNER JOIN #tmp_espaces tmp on (tmp.eSpaceId = spd.ESPACE_ID)
												
--Export Integrations configuration
SELECT	tmp.ApplicationName, 
		tmp.ApplicationId, 
		tmp.eSpaceName, 
		tmp.eSpaceId,
		s.TypeIntegration,
		s.ESPACE_ID,
		S.IntegrationName,
		S.URL
FROM	(SELECT 
			'REST'				AS TypeIntegration,
			rwr.ESPACE_ID		AS ESPACE_ID,
			rwr.NAME			AS IntegrationName,
			CASE WHEN EFFECTIVE_URL IS NULL OR REPLACE(EFFECTIVE_URL,' ','') = '' THEN URL ELSE EFFECTIVE_URL END  AS URL,
			rwr.IS_ACTIVE		AS IS_ACTIVE
		FROM [dbo].[OSSYS_REST_WEB_REFERENCE] rwr 
		WHERE rwr.IS_ACTIVE = 1
		UNION ALL
		SELECT 
			'SOAP'				AS TypeIntegration,
			wr.ESPACE_ID		AS ESPACE_ID,
			wr.NAME				AS IntegrationName,
			CASE WHEN EFFECTIVE_URL IS NULL OR REPLACE(EFFECTIVE_URL,' ','') = '' THEN URL ELSE EFFECTIVE_URL END  AS URL,
			wr.IS_ACTIVE		AS IS_ACTIVE
		FROM [dbo].[ossys_Web_Reference] wr
		WHERE wr.IS_ACTIVE = 1
		) as S INNER JOIN #tmp_espaces tmp on (tmp.eSpaceId = s.espace_id)

