use outsystems;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--DROP SCRIPTS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE #temp_screenlog;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--CREATE TEMPTABLE WITH SCREEN DATA
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	instant, 
		screen, 
		application_name, 
		espace_name, 
		action_name, 
		access_mode, 
		duration [duration_ms], 
		viewstate_bytes/8 [viewstate_kb], 
		session_bytes/8 [session_kb]
INTO	#temp_screenlog
from	oslog_screen_previous;



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RETURN STATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- top pages with more duration
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(duration_ms) as average_duration_ms, max(duration_ms) max_duration_ms
from	#temp_screenlog
group by screen, application_name, espace_name
order by 5 desc


--top pages with more view state
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(viewstate_kb) as average_viewstate_kb, max(viewstate_kb) max_viewstate_kb
from	#temp_screenlog
group by screen, application_name, espace_name
order by 5 desc
