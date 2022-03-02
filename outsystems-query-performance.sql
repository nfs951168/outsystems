use Outsystems;

-----------------------------------------------------------------------------------------------------
--1: Get all application logs into a temporary table
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
--3: Manage SlowSql logs
-----------------------------------------------------------------------------------------------------
 
with performance as (
select Application_Name, eSpace_Name, Query, count(1) as Executions, AVG(duration) as AverageDuration_ms, max(duration) as MaxDuration_ms, AVG(duration) * count(*) as row_weight
from #TMP_PERFORMANCE_LOGS_FINAL
where	1 = 1
--where InsTime between '7:00:00' and '21:00:00'
--and InstDate >= '2021-12-01'
group by application_Name, eSpace_name, Query
)
 
select application_name, espace_name, query, executions, averageduration_ms, maxduration_ms, row_weight
from	performance
order by row_weight desc


--Extraction by day and hour
select	Query, Application_Name, Espace_Name, InstDate as 'Day', datepart(hour, instant) as 'Hour', count(1) Executions, avg(duration) AverageDuration_ms
from	#TMP_PERFORMANCE_LOGS_FINAL
group by Query, Application_Name, Espace_Name, InstDate, datepart(hour, instant)
order by 1, 4, 5


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
