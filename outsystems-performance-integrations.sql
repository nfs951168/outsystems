-----------------------------------------------------------------------------------------------------------------------------------------------------------
--SCRIPT TO DROP TEMP TABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE #TMP_INT_LOGS;
DROP TABLE #TMP_FINAL_LOGS;

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
FROM	oslog_Integration_Previous;



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
--Other scripts
-----------------------------------------------------------------------------------------------------------------------------------------------------------


select	Request_Key, COUNT(*)
FROM	#TMP_INT_LOGS
GROUP BY REQUEST_KEY 
HAVING COUNT(*) > 1

select	*
from	#TMP_INT_LOGS
WHERE	request_key = '6c4f0db2-10f0-44f6-b356-e52c63bbc41e'

