------------------------------------------------------------------------------------------------------------------------------
--Gets all SOAP exposed webservices
------------------------------------------------------------------------------------------------------------------------------
select	'soap' as type, es.name, ws.name, ws.internal_access, ws.secure_connection, ws.integrated_authentication
from	ossys_Web_Service ws inner join ossys_espace es on (es.id = ws.espace_id)
where	es.is_active = 1
and		ws.is_active = 1
and		es.is_system = 0 -- exclude systems services




------------------------------------------------------------------------------------------------------------------------------------------------
--Get consumed web services information
-------------------------------------------------------------------------------------------------------------------------------------------------
 
DECLARE @webServiceName AS VARCHAR(100);

SET @webServiceName = 'CandidateTest';

WITH cte_integrations AS (
	SELECT	'REST' AS IntegrationType, name as IntegrationName, ESPACE_ID, [URL], EFFECTIVE_URL, IS_ACTIVE, SS_KEY
	FROM	OSSYS_REST_WEB_REFERENCE
	WHERE	effective_url LIKE '%' + @webServiceName + '%' OR	(ISNULL(effective_url, '') = '' AND [URL] LIKE '%' + @webServiceName + '%')
	UNION ALL
	SELECT	'SOAP' AS IntegrationType, name as IntegrationName, ESPACE_ID, [URL], EFFECTIVE_URL, IS_ACTIVE, SS_KEY
	FROM	ossys_web_reference
	WHERE	effective_url LIKE '%' + @webServiceName + '%' OR	(ISNULL(effective_url, '') = '' AND [URL] LIKE '%' + @webServiceName + '%')
)


SELECT	wr.IntegrationType,
		wr.IntegrationName,
		app.name as ConsumerApplication,
		es.NAME as ConsumerModule,
		wr.URL, 
		wr.EFFECTIVE_URL,
		wr.IS_ACTIVE IntegrationStatus
FROM	cte_integrations wr inner join ossys_espace es on (es.Id = wr.espace_id)
                            inner join ossys_module mo on (mo.espace_id = es.id)
                            inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                            inner join ossys_application app on (app.id = adm.application_id)

WHERE	1 = 1
--active webreferences
and		wr.IS_ACTIVE = 1; 