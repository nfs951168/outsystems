----------------------------------------------------------------------------------------------------------------------------------
--Gets last execution of a timer
--ossys_Meta_Cyclic_Job: This entity contains the definitions of Timers created in modules
--ossys_Cyclic_Job_Shared: This entity contains the information of Timers to be executed by the Scheduler Service in single-tenant modules
----------------------------------------------------------------------------------------------------------------------------------

SELECT	mcj.NAME AS TimerName,
		e.NAME AS eSpaceName,
		app.NAME AS ApplicationName,
		cjs.LAST_RUN
FROM	ossys_Meta_Cyclic_Job AS mcj	LEFT JOIN ossys_Cyclic_Job_Shared cjs ON cjs.META_CYCLIC_JOB_ID = mcj.ID
										LEFT JOIN ossys_Espace e ON e.Id = mcj.ESPACE_ID
										LEFT JOIN OSSYS_MODULE m ON m.ESPACE_ID = e.Id
										LEFT JOIN OSSYS_APP_DEFINITION_MODULE adm ON adm.MODULE_ID = m.ID
										LEFT JOIN OSSYS_APPLICATION app ON app.ID = adm.APPLICATION_ID
WHERE	mcj.IS_ACTIVE = 1
and		cjs.LAST_RUN <= DATEADD(month,-6,GETDATE())
and		e.IS_ACTIVE = 1