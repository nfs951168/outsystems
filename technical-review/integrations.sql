-----------------------------------------------------------------------------------------------------
--Get all application logs into a temporary table
-----------------------------------------------------------------------------------------------------
select	app.name, es.name, es.id, es.IS_ACTIVE
from	ossys_espace es inner join ossys_module mo on (mo.espace_id = es.id)
						inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
where	app.name like ''


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--performance statistics | integrations
-----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		duration,
		error_id
INTO	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS
FROM	oslog_Integration with (nolock)
where	espace_id IN (385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416)
and		instant > dateadd(day,-15,getdate());



INSERT INTO	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS
SELECT	convert(date, instant, 102) as [day],
		datepart(HOUR, instant) as [hour], 
		Executed_by as [Server],
		Application_Name, 
		Espace_Name, 
		Endpoint, 
		Action, 
		Type,
		duration,
		error_id
FROM	oslog_Integration_previous with (nolock)
where	espace_id IN (385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416)
and		instant > dateadd(day,-15,getdate());



-----------------------------------------------------------------------------------------------------------------------------------------------------------
--integration analysis
-----------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @date_report as varchar(50);

select	@date_report = cast(min(day) as varchar) + ' a ' + cast(max(day) as varchar) 
from	#RPT_OUTSYSTEMS_PERF_INTEGRATIONS;



with req_data as (
	select	espace_name, type, action,  count(*) as qtd_requests, AVG(convert(bigint, duration)) as average_duration_ms, max(convert(bigint, duration)) max_duration_ms,
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
	group by espace_name, type, action
)


select	@date_report as data_report, espace_name, type, action, qtd_requests, average_duration_ms, qtd_errors, duration_index*requests_index as priority
from	req_data
order by 8 desc