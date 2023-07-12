
declare @espaceId as int;
DECLARE @date_report as varchar(50);

select @espaceID = id from ossys_espace where name = ''

print @espaceId

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--integration statistics
-----------------------------------------------------------------------------------------------------------------------------------------------------------

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
INTO	#TMP_INTEGRATION_CALLS
FROM	oslog_Integration_0 with (nolock)
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;

INSERT INTO	#TMP_INTEGRATION_CALLS
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
where	espace_Id = @espaceId
group by convert(date, instant, 102), datepart(HOUR, instant), executed_by, application_name, Espace_Name, endpoint, Action, Type, duration;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--validations
-----------------------------------------------------------------------------------------------------------------------------------------------------------
with dates as (
	select min(Instant) as MinDate, max(instant) as MaxDate
	FROM	oslog_Integration_0 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_1 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_2 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_3 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_4 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_5 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_6 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_7 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_8 with (nolock)
	union all
	select min(Instant), max(instant)
	FROM	oslog_Integration_9 with (nolock)
)
select	min(mindate), max(maxdate)
FROM	dates;


select	*
from	#TMP_INTEGRATION_CALLS
