use outsystems;

declare @process_day as date;
set @process_day = '2022-11-30';

--delete all data from tables
delete from outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL where [day] >= @process_day;



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | slow queries
-----------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_0 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_1 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_2 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_3 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_4 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_5 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_6 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_7 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_8 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_SLOWSQL
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		count(*) as [requests],
		avg(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [avg_duration_ms],
		min(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [min_duration_ms],
		max(cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int)) as [max_duration_ms]
from	oslog_General_9 with (nolock)
where	module_name = 'SLOWSQL'
and		instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, Espace_Name, Action_Name, Entrypoint_Name, substring(message, 0, charindex(' took ', message, 0));

