use outsystems;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--create temp table with traditional web screen requests
-----------------------------------------------------------------------------------------------------------------------------------------------------------
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
from	oslog_screen_0 with (nolock);

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
from	oslog_screen_1 with (nolock);


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
from	oslog_screen_2 with (nolock);


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
from	oslog_screen_3 with (nolock);


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
from	oslog_screen_4 with (nolock);


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
from	oslog_screen_5 with (nolock);

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
from	oslog_screen_6 with (nolock);

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
from	oslog_screen_7 with (nolock);


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
from	oslog_screen_8 with (nolock);


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
from	oslog_screen_9 with (nolock);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RETURN STATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- top pages with more duration
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(convert(bigint, duration_ms)) as average_duration_ms, max(convert(bigint, duration_ms)) max_duration_ms
from	#temp_screenlog
where	screen like '%timesheet%'
group by screen, application_name, espace_name
order by 5 desc


select	*
from	#temp_screenlog

--top pages with more view state
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(viewstate_kb) as average_viewstate_kb, max(viewstate_kb) max_viewstate_kb, AVG(viewstate_kb) * count(*) as row_weight
from	#temp_screenlog
group by screen, application_name, espace_name
order by 7 desc
