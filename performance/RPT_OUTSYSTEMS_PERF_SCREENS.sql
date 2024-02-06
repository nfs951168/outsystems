use outsystems;

declare @process_date as date;
set @process_date = (select dateadd(day, -2, getdate()));

print @process_date;

--delete all data from tables
delete from outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS where [day] >= @process_date;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | for web traditional 
-----------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_0 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_1 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_2 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_3 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_4 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_5 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_6 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_7 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_8 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'WT' as request_type,
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen, 
		action_name, 
		access_mode, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		avg(viewstate_bytes/1024) [avg_viewstate_kb]
from	oslog_screen_9 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, action_name, access_mode;




------------------------------------------------------------------------------------------------------------------------------------------------------------
--Mobile requests
------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_0 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_1 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_2 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_3 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_4 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_5 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_6 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_7 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_8 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SCREENS
select	'RE' as request_type,
		convert(date, instant, 102) as [day], 
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		screen,
		endpoint, 
		'', 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		0 [viewstate_kb]
from	oslog_mobile_request_9 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, screen, endpoint;