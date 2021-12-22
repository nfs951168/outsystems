use outsystems;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--DROP SCRIPTS
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE #temp_screenlog;


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--create temp table with traditional web screen requests
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--previous week
select	instant, 
		screen, 
		application_name, 
		espace_name, 
		action_name, 
		access_mode, 
		duration [duration_ms], 
		viewstate_bytes/1024 [viewstate_kb], 
		session_bytes/1024 [session_kb]
INTO	#temp_screenlog 
from	oslog_screen_previous with (nolock);

--current week
insert into #temp_screenlog
select	instant, 
		screen, 
		application_name, 
		espace_name, 
		action_name, 
		access_mode, 
		duration [duration_ms], 
		viewstate_bytes/1024 [viewstate_kb], 
		session_bytes/1024 [session_kb]
from	oslog_screen with (nolock);


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RETURN STATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- top pages with more duration
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(duration_ms) as average_duration_ms, max(duration_ms) max_duration_ms, AVG(duration_ms) * count(*) as row_weight
from	#temp_screenlog
group by screen, application_name, espace_name
order by 7 desc


--top pages with more view state
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(viewstate_kb) as average_viewstate_kb, max(viewstate_kb) max_viewstate_kb, AVG(viewstate_kb) * count(*) as row_weight
from	#temp_screenlog
group by screen, application_name, espace_name
order by 7 desc
