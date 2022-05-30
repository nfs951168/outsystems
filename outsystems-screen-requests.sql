use outsystems;

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--create temp table with traditional web screen requests
-----------------------------------------------------------------------------------------------------------------------------------------------------------
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
select	'WT' as request_type,
		instant, 
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
--add mobile requests
-----------------------------------------------------------------------------------------------------------------------------------------------------------
insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_0 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_1 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_2 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_3 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_4 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_5 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_6 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_7 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_8 with (nolock);

insert into #temp_screenlog
select	'RE' as request_type,
		instant, 
		screen, 
		application_name, 
		espace_name, 
		'', 
		'', 
		duration [duration_ms], 
		0 [viewstate_kb], 
		0 [session_kb]
from	oslog_mobile_request_9 with (nolock);


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--RETURN STATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- web traditional top 20 pages with more avg duration
with req_data as (
	select	application_name, screen,  count(*) as qtd_requests, AVG(convert(bigint, duration_ms)) as average_duration_ms, max(convert(bigint, duration_ms)) max_duration_ms,
	case when AVG(convert(bigint, duration_ms)) < 500 then 0 
		     when AVG(convert(bigint, duration_ms)) between 500 and 800 then 2 
			 when AVG(convert(bigint, duration_ms)) between 801 and 1000 then 3
			 when AVG(convert(bigint, duration_ms)) between 1001 and 2000 then 5
			 when AVG(convert(bigint, duration_ms)) between 2001 and 3000 then 8
			 when AVG(convert(bigint, duration_ms)) between 3001 and 4000 then 13
			 when AVG(convert(bigint, duration_ms)) > 4000 then 21 end
		as duration_index,
		case when count(*) < 500 then 0 
		     when count(*) between 500 and 100 then 1 
			 when count(*) between 1001 and 2000 then 2
			 when count(*) between 2001 and 3000 then 3
			 when count(*) between 3001 and 4000 then 5
			 when count(*) between 4001 and 5000 then 8
			 when count(*) > 5000 then 13 end
		as requests_index
	from	#temp_screenlog
	where	Application_Name not in ('service center')
	group by application_name, screen
)


select	top 10 Application_Name, screen, qtd_requests, average_duration_ms, duration_index*requests_index
from	req_data
order by 5 desc




--top pages with more view state
select	screen, application_name, espace_name, count(*) as qtd_requests, AVG(viewstate_kb) as average_viewstate_kb, max(viewstate_kb) max_viewstate_kb, AVG(viewstate_kb) * count(*) as row_weight
from	#temp_screenlog
group by screen, application_name, espace_name
order by 7 desc
