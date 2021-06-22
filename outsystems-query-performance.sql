use OutsystemsProd_Log;
 
-----------------------------------------------------------------------------------------------------
--1: Get all application logs into a temporary table
-----------------------------------------------------------------------------------------------------
 
select	app.Id as AppId, app.Name as ApplicationName, app.DESCRIPTION as AppDescription, esp.Id as EspaceId, esp.Name as EspaceName
INTO	#TMP_ESPACES
from	outsystems_prod.dbo.OSSYS_APP_DEFINITION_MODULE dm inner join outsystems_prod.dbo.OSSYS_APPLICATION app on (dm.APPLICATION_ID = app.ID)
									   inner join outsystems_prod.dbo.ossys_module mo on (mo.id = dm.module_Id)
									   inner join outsystems_prod.dbo.ossys_Espace esp on (esp.id = mo.espace_id);
 

--Get log from view with last week
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InsTime,
		lg.Instant,
		app.AppId,
		app.ApplicationName,
		app.espaceId,
		app.EspaceName,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		ltrim(replace(left(lg.message, patindex ('%[0-9]%', lg.message)-6), 'Query', '')) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration,
		--cast(substring (replace(RIGHT(lg.message,15), 'ms', ''), patindex ('%[0-9]%', replace(RIGHT(lg.message,15), 'ms', '')), 10) as int) duration,
		'LW' as PeriodType
into	#TMP_PERFORMANCE_LOGS
from	oslog_General_previous lg with (nolock) inner join #TMP_ESPACES app on (app.EspaceId = lg.espace_id)
where	lg.module_name = 'SLOWSQL';
 
--Get logs from current week
INSERT INTO #TMP_PERFORMANCE_LOGS
select	convert(date, lg.instant) InstDate,
		convert(time, lg.instant) InsTime,
		lg.Instant,
		app.AppId,
		app.ApplicationName,
		app.espaceId,
		app.EspaceName,
		lg.Message,
		lg.Action_Name,
		lg.Entrypoint_Name,
		ltrim(replace(left(lg.message, patindex ('%[0-9]%', lg.message)-6), 'Query', '')) as Query,
		cast(substring(lg.message, charindex(' took ', lg.message, 0) + 6, charindex(' ms', lg.Message, 0) - 6 - charindex(' took ', lg.message, 0)) as int) duration,
		--cast(substring (replace(RIGHT(lg.message,15), 'ms', ''), patindex ('%[0-9]%', replace(RIGHT(lg.message,15), 'ms', '')), 10) as int) duration,
		'CW' as PeriodType
from	oslog_General lg with (nolock) inner join #TMP_ESPACES app on (app.EspaceId = lg.espace_id)
where	lg.module_name = 'SLOWSQL';
 
 select * from #TMP_PERFORMANCE_LOGS where query = 'Get_Activities.Get_ActivityQuestion.List'
 select top 100 * from oslog_General where action_name = 'Get_Activities'
 select * from Outsystems_Prod.dbo.ossys_Espace where id = 114
 

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
select InstDate, ApplicationName, eSpaceName, Query, count(*) as Executions, AVG(duration) as AverageDuration_ms, max(duration) as MaxDuration_ms
from #TMP_PERFORMANCE_LOGS_FINAL
where	1 = 1
--where InsTime between '7:00:00' and '21:00:00'
and InstDate >= '2021-03-10'
--and		periodType = 'CW'
group by InstDate, ApplicationName, eSpacename, Query
)
 
select *
from performance
where AverageDuration_ms > 1000
order by AverageDuration_ms desc
 
-----------------------------------------------------------------------------------------------------
--4: Get most executed queries
-----------------------------------------------------------------------------------------------------
select query, count(*)
from #TMP_PERFORMANCE_LOGS_FINAL
where InstDate = '2020-05-18'
group by query
order by 2 desc
 
 
 
-----------------------------------------------------------------------------------------------------
--5: specific queries
-----------------------------------------------------------------------------------------------------
select min(instant), max(instant)
from #TMP_PERFORMANCE_LOGS
where 1 = 1
and		periodType = 'CW'
and		query = 'GetDataToSync.GetVendas_Objectivos_Categorias.GetVendasPontoVenda.List '
--and InstDate = '2020-05-18'
order by duration desc
