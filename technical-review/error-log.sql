-----------------------------------------------------------------------------------------------------
--Get all application logs into a temporary table
-----------------------------------------------------------------------------------------------------
select	app.name, es.name, es.id, es.IS_ACTIVE
from	ossys_espace es inner join ossys_module mo on (mo.espace_id = es.id)
						inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
where	app.name like ''

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | Error Logs
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		message
INTO	#RPT_OUTSYSTEMS_PERF_ERROR
from	oslog_Error with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
and		instant > dateadd(day,-15,getdate());


INSERT INTO #RPT_OUTSYSTEMS_PERF_ERROR
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		message
from	oslog_Error_previous with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
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


select	@date_report as data_report, espace_name, action_name, error_type, count(*) as QtdErrors
from	tab
group by espace_name, action_name, error_type
order by 5 desc