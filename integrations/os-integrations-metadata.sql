------------------------------------------------------------------------------------------------------------------------------
--Integrations metadata
------------------------------------------------------------------------------------------------------------------------------

--SOAP Consume
SELECT 	ossys_espace.name,
		OSSYS_SOAP_CONSUME.URL,
		OSSYS_SOAP_CONSUME.EFFECTIVE_URL
FROM 	OSSYS_SOAP_CONSUME INNER JOIN ossys_espace ON ossys_espace.ID = OSSYS_SOAP_CONSUME.ESPACE_ID
WHERE	OSSYS_SOAP_CONSUME.IS_ACTIVE = 1
UNION ALL
SELECT	ossys_espace.name,
		OSSYS_WEB_REFERENCE.URL,
		OSSYS_WEB_REFERENCE.EFFECTIVE_URL
FROM 	OSSYS_WEB_REFERENCE INNER JOIN ossys_espace ON ossys_espace.ID = OSSYS_WEB_REFERENCE.ESPACE_ID
WHERE  	OSSYS_WEB_REFERENCE.IS_ACTIVE = 1


--REST Consume
SELECT 	ossys_espace.name,
		OSSYS_REST_WEB_REFERENCE.URL,
		OSSYS_REST_WEB_REFERENCE.EFFECTIVE_URL
FROM 	OSSYS_REST_WEB_REFERENCE INNER JOIN ossys_espace ON ossys_espace.ID = OSSYS_REST_WEB_REFERENCE.ESPACE_ID
WHERE 	OSSYS_REST_WEB_REFERENCE.IS_ACTIVE = 1


--SOAP Exposed
SELECT 	ossys_espace.name,
		OSSYS_WEB_SERVICE.NAME AS WS_NAME
FROM	OSSYS_WEB_SERVICE INNER JOIN ossys_espace ON ossys_espace.ID = OSSYS_WEB_SERVICE.ESPACE_ID
WHERE  	OSSYS_WEB_SERVICE.IS_ACTIVE = 1

--REST Exposed
SELECT 	e.name, re.NAME, re.url, re.name, re.TRACEERRORS, re.TRACEALL
FROM 	ossys_REST_Expose re INNER JOIN ossys_espace e ON e.ID = re.ESPACE_ID
WHERE 	re.IS_ACTIVE = 1






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
