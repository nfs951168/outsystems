use Outsystems;

-----------------------------------------------------------------------------------------------------
--1: Get all application logs into a temporary table
--Warning: To be more performant should filter oslog_general tables by espace_ID
-----------------------------------------------------------------------------------------------------

--Get log from view with last week
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InsTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		--ltrim(replace(left(lg.message, patindex ('%[0-9]%', lg.message)-6), 'Query', '')) as Query,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
into	#TMP_PERFORMANCE_LOGS
from	oslog_General_0 lg with (nolock)
where	lg.module_name = 'SLOWSQL';
 

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_1 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_2 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_3 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_4 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_5 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_6 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_7 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_8 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

insert into #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InstTime,
		lg.Instant,
		lg.Application_Name,
		lg.Espace_Name,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		substring(message, 0, charindex(' took ', message, 0)) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration
from	oslog_General_9 lg with (nolock)
where	lg.module_name = 'SLOWSQL';

-----------------------------------------------------------------------------------------------------
--2. Remove most expensive duration and less expensive duration from the analysis, by query and day
-----------------------------------------------------------------------------------------------------
with perf_logs as (
select	#TMP_PERFORMANCE_LOGS.*,
		rank() over (partition by InstDate, Query order by duration desc) MAX_DURATION_RNK,
		rank() over (partition by InstDate, Query order by duration asc) MIN_DURATION_RNK
from #TMP_PERFORMANCE_LOGS
)
 
 
SELECT *
INTO #TMP_PERFORMANCE_LOGS_FINAL
FROM perf_logs
WHERE (MIN_DURATION_RNK > 1 AND MAX_DURATION_RNK > 1)
 

 
-----------------------------------------------------------------------------------------------------
--3: Get most expensive queries
-----------------------------------------------------------------------------------------------------
 
 --Get most relevant queries to be analysed
with req_data as (
	select	query, application_name, espace_name, action_name,  count(*) as qtd_requests, AVG(convert(bigint, duration)) as average_duration_ms, max(convert(bigint, duration)) max_duration_ms,
	case when AVG(convert(bigint, duration)) < 500 then 0 
		     when AVG(convert(bigint, duration)) between 500 and 800 then 2 
			 when AVG(convert(bigint, duration)) between 801 and 1000 then 3
			 when AVG(convert(bigint, duration)) between 1001 and 2000 then 5
			 when AVG(convert(bigint, duration)) between 2001 and 3000 then 8
			 when AVG(convert(bigint, duration)) between 3001 and 4000 then 13
			 when AVG(convert(bigint, duration)) > 4000 then 21 end
		as duration_index,
		case when count(*) < 500 then 0 
		     when count(*) between 500 and 100 then 1 
			 when count(*) between 1001 and 2000 then 2
			 when count(*) between 2001 and 3000 then 3
			 when count(*) between 3001 and 4000 then 5
			 when count(*) between 4001 and 5000 then 8
			 when count(*) > 5000 then 13 end
		as requests_index
	from	#TMP_PERFORMANCE_LOGS_FINAL
	group by query, application_name, espace_name, action_name
)


select	top 20 query, application_name, espace_name, action_name, qtd_requests, average_duration_ms, duration_index*requests_index as priority
from	req_data
order by 7 desc

-----------------------------------------------------------------------------------------------------
--4: Get most executed queries
-----------------------------------------------------------------------------------------------------
select query, count(*)
from #TMP_PERFORMANCE_LOGS_FINAL
where InstDate = '2020-05-18'
group by query
order by 2 desc
 

 -----------------------------------------------------------------------------------------------------
--5: get raw data to analisys
-----------------------------------------------------------------------------------------------------
select instDate, datepart(hour, InsTime) Time_Hour, Espace_Name, Action_Name, Query, duration
from	#TMP_PERFORMANCE_LOGS_FINAL
where	1 = 1
and InstDate >= '2021-12-01'
 
-----------------------------------------------------------------------------------------------------
--6: specific queries
-----------------------------------------------------------------------------------------------------
select min(instant), max(instant)
from #TMP_PERFORMANCE_LOGS
where 1 = 1
and		periodType = 'CW'
and		query = 'GetDataToSync.GetVendas_Objectivos_Categorias.GetVendasPontoVenda.List '
--and InstDate = '2020-05-18'
order by duration desc



--date in analysis
select min(instDate), max(instDate) from #TMP_PERFORMANCE_LOGS_FINAL
