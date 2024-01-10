
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | integrations
-----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		espace_id,
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		duration,
		error_id
INTO	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS
FROM	oslog_Integration with (nolock)
where	1 = 1
and		instant > dateadd(day,-15,getdate());



INSERT INTO	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		espace_id,
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		duration,
		error_id
FROM	oslog_Integration_previous with (nolock)
where	1 = 1
and		instant > dateadd(day,-15,getdate());



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--integration analysis
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @date_report as varchar(50);

select	@date_report = cast(min(day) as varchar) + ' a ' + cast(max(day) as varchar) 
from	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS;



with req_data as (
	select	espace_id, espace_name, type, action,  count(*) as qtd_requests, AVG(convert(bigint, duration)) as average_duration_ms, max(convert(bigint, duration)) max_duration_ms,
	SUM(CASE WHEN error_id = '' THEN 0 ELSE 1 END) AS qtd_errors,
	case when AVG(convert(bigint, duration)) < 500 then 0 
		     when AVG(convert(bigint, duration)) between 500 and 800 then 2 
			 when AVG(convert(bigint, duration)) between 801 and 1000 then 3
			 when AVG(convert(bigint, duration)) between 1001 and 2000 then 5
			 when AVG(convert(bigint, duration)) between 2001 and 3000 then 8
			 when AVG(convert(bigint, duration)) between 3001 and 4000 then 13
			 when AVG(convert(bigint, duration)) > 4000 then 21 end
		as duration_index,
		case when count(*) < 500 then 0 
		     when count(*) between 500 and 1000 then 2 
			 when count(*) between 1001 and 2000 then 3
			 when count(*) between 2001 and 3000 then 5
			 when count(*) between 3001 and 4000 then 8
			 when count(*) between 4001 and 5000 then 13
			 when count(*) > 5000 then 21 end
		as requests_index
	from	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS
	group by espace_id, espace_name, type, action
)


select	@date_report as data_report, t.domain, espace_name, type, action, qtd_requests, average_duration_ms, qtd_errors, duration_index*requests_index as priority
from	req_data as l	LEFT JOIN [dbo].[OSSYS_MODULE] m ON m.ESPACE_ID = l.espace_id
						LEFT JOIN [dbo].[OSSYS_APP_DEFINITION_MODULE] adm ON adm.MODULE_ID = m.ID
						LEFT JOIN [dbo].[OSSYS_APPLICATION] app ON app.ID = adm.APPLICATION_ID
						LEFT JOIN #tmp_domains t on t.application = app.NAME
order by 9 desc






