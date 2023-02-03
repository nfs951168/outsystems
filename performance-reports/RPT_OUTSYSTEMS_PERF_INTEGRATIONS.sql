use outsystems;

declare @process_day as date;
set @process_day = '2022-11-30';

--delete all data from tables
delete from outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS where [day] >= @process_day;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | integrations
-----------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_0 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_1 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_2 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_3 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_4 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_5 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_6 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_7 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_8 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	outsystems_reporting.dbo.RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		count(1) as [requests],
		avg(duration) [avg_duration_ms], 
		min(duration) [min_duration_ms],
		max(duration) [max_duration_ms],
		SUM(case when Error_Id = '' then 0 else 1 end) as [Errors]	
FROM	oslog_Integration_9 with (nolock)
where	instant >= @process_day
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;