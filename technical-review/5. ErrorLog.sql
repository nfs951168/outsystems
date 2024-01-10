-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Error Logs
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		espace_id,
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		message
INTO	#RPT_OUTSYSTEMS_PERF_ERROR
from	oslog_Error with (nolock)
where	1 = 1
and		instant > dateadd(day,-15,getdate());


INSERT INTO #RPT_OUTSYSTEMS_PERF_ERROR
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		espace_id,
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		message
from	oslog_Error_previous with (nolock)
where	1 = 1
and		instant > dateadd(day,-15,getdate());


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--error analysis
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @date_report as varchar(50);

select	@date_report = cast(min(day) as varchar) + ' a ' + cast(max(day) as varchar) 
from	#RPT_OUTSYSTEMS_PERF_ERROR;

with tab as (
	select	*,
			case 
				when message like '%Load timeout for modules: %' THEN '[ErrorScreen] Load timeout for modules' 
				when message like 'Failed to handle request: %' THEN 'Failed to handle request' 
				when message like '%Script error for %' THEN '[ErrorScreen] Script error for' 
				when message like 'A fatal error has occurred. Please contact OutSystems support: %' THEN 'A fatal error has occurred. Please contact OutSystems support' 
				when message like 'Failed to store downloaded resource %' THEN 'Failed to store downloaded resource' 
				when message like 'Could not get InputStream while trying to get cache resource: %' THEN 'Could not get InputStream while trying to get cache resource' 
				when message like 'Failed to load cache manifest: %' THEN 'Failed to load cache manifest' 
				when message like 'Checksum failed for file %' THEN 'Checksum failed for file' 
				when message like 'Failed to download resource %' THEN 'Failed to download resource'
				when message like 'Upgrade failed - rolling back to previous application version%' THEN 'Upgrade failed - rolling back to previous application version'
				ELSE message
			END ERROR_TYPE
	from	#RPT_OUTSYSTEMS_PERF_ERROR
)


select	@date_report as data_report, t.domain, espace_name, action_name, error_type, count(*) as QtdErrors
from	tab as l	LEFT JOIN [dbo].[OSSYS_MODULE] m ON m.ESPACE_ID = l.espace_id
					LEFT JOIN [dbo].[OSSYS_APP_DEFINITION_MODULE] adm ON adm.MODULE_ID = m.ID
					LEFT JOIN [dbo].[OSSYS_APPLICATION] app ON app.ID = adm.APPLICATION_ID
					LEFT JOIN #tmp_domains t on t.application = app.NAME
group by t.domain, espace_name, action_name, error_type
order by 6 desc




