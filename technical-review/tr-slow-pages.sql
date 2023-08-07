-----------------------------------------------------------------------------------------------------
--Get all application logs into a temporary table
-----------------------------------------------------------------------------------------------------
select	app.name, es.name, es.id, es.IS_ACTIVE
from	ossys_espace es inner join ossys_module mo on (mo.espace_id = es.id)
						inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
where	app.name like ''


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | for web traditional 
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	'WT' as request_type,
		convert(date, instant, 102) as InstDate, 
		datepart(HOUR, instant) as InstTime,
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		duration,
		viewstate_bytes/1024 [viewstate_kb]
INTO	#RPT_OUTSYSTEMS_PERF_SCREENS
from	oslog_screen with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
and		instant > dateadd(day,-15,getdate());


INSERT INTO	#RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as InstDate, 
		datepart(HOUR, instant) as InstTime,
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		duration,
		viewstate_bytes/1024 [viewstate_kb]
from	oslog_screen_previous with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
and		instant > dateadd(day,-15,getdate());


------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mobile requests
------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO	#RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as InstDate, 
		datepart(HOUR, instant) as InstTime,
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		duration,
		0 [viewstate_kb]
from	oslog_mobile_request with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
and		instant > dateadd(day,-15,getdate());


INSERT INTO	#RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as InstDate, 
		datepart(HOUR, instant) as InstTime,
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		duration,
		0 [viewstate_kb]
from	oslog_mobile_request_previous with (nolock)
where	1 = 1
and		espace_id IN (215,216,217,218,219,220,221,222,223,224,225,226,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,297,298,299,286,287,288,289,290,291,292)
and		instant > dateadd(day,-15,getdate());


-----------------------------------------------------------------------------------------------------
--Get page request report with weight
-----------------------------------------------------------------------------------------------------
DECLARE @date_report as varchar(50);

select	@date_report = cast(min(InstDate) as varchar) + ' a ' + cast(max(InstDate) as varchar) 
from	#RPT_OUTSYSTEMS_PERF_SCREENS;

with req_data as (
	select	 application_name, espace_name, screen, action_name,  
	count(*) as qtd_requests, AVG(convert(bigint, duration)) as average_duration_ms, AVG(convert(bigint, viewstate_kb)) as average_viewstate_kb, max(convert(bigint, duration)) max_duration_ms,
	case when AVG(convert(bigint, duration)) < 500 then 0 
		     when AVG(convert(bigint, duration)) between 500 and 800 then 2 
			 when AVG(convert(bigint, duration)) between 801 and 1000 then 3
			 when AVG(convert(bigint, duration)) between 1001 and 2000 then 5
			 when AVG(convert(bigint, duration)) between 2001 and 3000 then 8
			 when AVG(convert(bigint, duration)) between 3001 and 4000 then 13
			 when AVG(convert(bigint, duration)) > 4000 then 21 end
		as duration_index,
		case when count(*) < 500 then 0 
		     when count(*) between 500 and 1000 then 2 
			 when count(*) between 1001 and 2000 then 3
			 when count(*) between 2001 and 3000 then 5
			 when count(*) between 3001 and 4000 then 8
			 when count(*) between 4001 and 5000 then 13
			 when count(*) > 5000 then 21 end
		as requests_index
	from	#RPT_OUTSYSTEMS_PERF_SCREENS
	group by application_name, espace_name, screen, action_name
)


select	@date_report as data_report, application_name, espace_name, screen, action_name, qtd_requests, average_duration_ms, average_viewstate_kb, duration_index*requests_index as priority
from	req_data
order by 9 desc