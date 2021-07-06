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
SELECT	APPLICATION_NAME, 
		ESPACE_NAME, 
		INSTANT, 
		DURATION, 
		TYPE, 
		ENDPOINT, ACTION, 
		ERROR_ID, 
		EXECUTED_BY, 
		IS_EXPOSE, 
		REQUEST_KEY
INTO	#TMP_INT_LOGS
FROM	oslog_Integration_Previous;



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--CALUCLATE METRICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT	APPLICATION_NAME, ESPACE_NAME, CONVERT(DATE, LG.INSTANT) INSTDATE, CONVERT(TIME, LG.INSTANT) INSTTIME, ENDPOINT, ACTION, DURATION, 
		CASE WHEN ERROR_ID = '' THEN 0 ELSE 1 END HAS_ERROR
INTO	#TMP_FINAL_LOGS
FROM	#TMP_INT_LOGS LG;



SELECT	APPLICATION_NAME, 
		ESPACE_NAME, 
		ACTION, 
		COUNT(*) AS EXECUTIONS, 
		SUM(HAS_ERROR) AS ERRORS, 
		(SUM(HAS_ERROR) * 100) / COUNT(*) AS PERC_ERRORS,
		MAX(DURATION) AS MAX_DURATION_MS, 
		AVG(duration) AS AVG_DURATION_MS
FROM	#TMP_FINAL_LOGS
--WHERE	INSTDATE = '2021-04-05'
GROUP BY APPLICATION_NAME, ESPACE_NAME, ACTION
ORDER BY 8 desc


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

