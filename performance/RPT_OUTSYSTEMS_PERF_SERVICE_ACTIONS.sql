use outsystems;

declare @process_date as date;
set @process_date = (select dateadd(day, -2, getdate()));

print @process_date;

--delete all data from tables
delete from outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE where [day] >= @process_date;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | for web traditional 
-----------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_0 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_1 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_2 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_3 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_4 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_4 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_5 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_6 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_7 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_8 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;


INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SERVICE
select
		convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour],
		Executed_By as [server],
		application_name, 
		espace_name, 
		endpoint, 
		action_name, 
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms]
from	oslog_SrvAPI_9 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, espace_name, endpoint, action_name;
