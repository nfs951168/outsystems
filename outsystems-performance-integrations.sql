-----------------------------------------------------------------------------------------------------------------------------------------------------------
--COLLECT LOGS FROM LOG TABLES

--OSLOG_INTEGRATION_X: ONE LOG TABLE BY WEEK
-- REQUEST_KEY: AGREGATES ALL CALLS TO CONSUMED SERVICES BY THE SAME ID
-----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
INTO	#TMP_INT_LOGS
FROM	oslog_Integration_0 with (nolock);


Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_1 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_2 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_3 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_4 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_5 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_6 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_7 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_8 with (nolock);

Insert into #TMP_INT_LOGS
SELECT	Application_Name, 
		Espace_Name, 
		Instant, 
		Duration, 
		Type, 
		Endpoint, 
		Action, 
		Error_Id, 
		Executed_by, 
		Is_Expose, 
		Request_Key
FROM	oslog_Integration_9 with (nolock);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--CALUCLATE METRICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	application_name, espace_name, convert(date, lg.instant) instdate, convert(time, lg.instant) insttime, endpoint, action, duration, 
		case when error_id = '' then 0 else 1 end has_error
into	#tmp_final_logs
from	#tmp_int_logs lg;



select	application_name, 
		espace_name, 
		action, 
		count(*) as executions, 
		sum(has_error) as errors, 
		(sum(has_error) * 100) / count(*) as perc_errors,
		avg(duration) as avg_duration_ms,
		max(duration) as max_duration_ms, 
		avg(duration) * count(*) as row_weight
from	#tmp_final_logs
--where	instdate = '2021-04-05'
group by application_name, espace_name, action
order by 9 desc


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--Global statistics
-----------------------------------------------------------------------------------------------------------------------------------------------------------

declare @startDate datetime = '2022-05-22 00:00:00'
declare @endDate datetime = '2022-05-28 23:59:29'
declare @factoryName varchar(100) = ''
declare @threshold int = 3000


select	@factoryName as FactoryName, 
		convert(varchar, @startdate, 105) + ' to ' + convert(varchar, @endDate, 105) as Dates, 
		'Integrations requests' RequestType, Application_Name, count(*) as qtd_requests, SUM(case when Duration > @threshold then 1 else 0 END) as SlowRequests
from	#TMP_INT_LOGS
where	instant between @startDate and @endDate
group by application_name
