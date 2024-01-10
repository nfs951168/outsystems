

SELECT 
	'Pipeline2' AS Pipeline, --pipeline identification
	mcj.NAME AS TimerName,
	e.NAME AS eSpaceName,
	app.NAME AS ApplicationName,
	t.domain AS Domain,
	cjs.LAST_RUN
FROM [dbo].[ossys_Meta_Cyclic_Job] AS mcj
LEFT JOIN [dbo].[ossys_Cyclic_Job_Shared] cjs ON cjs.META_CYCLIC_JOB_ID = mcj.ID
LEFT JOIN [dbo].[ossys_Espace] e ON e.Id = mcj.ESPACE_ID
LEFT JOIN [dbo].[OSSYS_MODULE] m ON m.ESPACE_ID = e.Id
LEFT JOIN [dbo].[OSSYS_APP_DEFINITION_MODULE] adm ON adm.MODULE_ID = m.ID
LEFT JOIN [dbo].[OSSYS_APPLICATION] app ON app.ID = adm.APPLICATION_ID
LEFT JOIN #tmp_domains t on t.application = app.NAME
WHERE
	mcj.IS_ACTIVE = 1
	and cjs.LAST_RUN <= DATEADD(month,-6,GETDATE())
	and e.IS_ACTIVE = 1