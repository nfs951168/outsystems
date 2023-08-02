-----------------------------------------------------------------------------------------------------
--Get all application logs into a temporary table
-----------------------------------------------------------------------------------------------------
select	*
from	ossys_espace es inner join ossys_module mo on (mo.espace_id = es.id)
						inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
where	app.name like '%%'



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
into	#RPT_OUTSYSTEMS_PERF_SLOW
from	oslog_General lg with (nolock)
where	lg.module_name = 'SLOWSQL'
and		espace_id IN (373, 374, 375, 376, 377)
and		instant > dateadd(day,-15,getdate());
 

insert into #RPT_OUTSYSTEMS_PERF_SLOW
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
from	oslog_General_previous lg with (nolock)
where	lg.module_name = 'SLOWSQL'
and		espace_id IN (373, 374, 375, 376, 377)
and		instant > dateadd(day,-15,getdate());


-----------------------------------------------------------------------------------------------------
--Get slow sql report with weight
-----------------------------------------------------------------------------------------------------
DECLARE @date_report as varchar(50);

select	@date_report = cast(min(InstDate) as varchar) + ' a ' + cast(max(InstDate) as varchar) 
from	#RPT_OUTSYSTEMS_PERF_SLOW;

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
		     when count(*) between 500 and 1000 then 1 
			 when count(*) between 1001 and 2000 then 2
			 when count(*) between 2001 and 3000 then 3
			 when count(*) between 3001 and 4000 then 5
			 when count(*) between 4001 and 5000 then 8
			 when count(*) > 5000 then 13 end
		as requests_index
	from	#RPT_OUTSYSTEMS_PERF_SLOW
	group by query, application_name, espace_name, action_name
)


select	@date_report as data_report, query, application_name, espace_name, action_name, qtd_requests, average_duration_ms, duration_index*requests_index as priority
from	req_data
order by 8 desc


