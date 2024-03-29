use outsystems;

declare @process_date as date;
set @process_date = (select dateadd(day, -2, getdate()));

print @process_date;

--delete all data from tables
delete from outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS where [day] >= @process_date;



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | errors
-----------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_0 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_1 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_2 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_3 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_4 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_5 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_6 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_7 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_8 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;

INSERT INTO outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_ERRORS
select	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Application_Name,
		Espace_Name,
		Action_Name,
		Entrypoint_Name,
		module_name,
		count(1) as [requests]
from	oslog_Error_9 with (nolock)
where	instant >= @process_date
group by convert(date, instant, 102), datepart(HOUR, instant), Application_Name, espace_Name, Action_Name, Entrypoint_Name, module_name;
