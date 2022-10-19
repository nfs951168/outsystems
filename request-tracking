
--specific request analysis
declare @request as varchar(50);

set	@request = 'b23e55b3-6ee2-4201-b29d-c32fb246186c'

select	'mobile request' as action, 
		request_key, 
		instant,  
		Espace_Name, 
		screen, 
		endpoint, 
		executed_By, 
		duration, 
		'' action_name, 
		username
from	oslog_mobile_request with (nolock)
where	1 = 1
and		Request_Key = @request
union all
select	'service action' as action, 
		Original_Request_Key, 
		instant, 
		Espace_Name, 
		'' screen, 
		endpoint, 
		Executed_by, 
		duration, 
		action_name, 
		'' username 
from	oslog_SrvAPI with (nolock)
where	Original_Request_Key = @request
union all
select	'slow_sql' as action, 
		request_key, 
		instant, 
		Espace_Name, 
		'' screen, 
		substring(message, 0, charindex(' took ', message, 0)) endpoint, 
		'' Executed_by, 
		cast(substring(message, charindex(' took ', message, 0) + 6, charindex(' ms', Message, 0) - 6 - charindex(' took ', message, 0)) as int) as duration, 
		'' action_name, 
		'' username 
from	oslog_General with (nolock)
where	1 = 1
and		Module_Name = 'SLOWSQL'
and		request_key = @request
union all
select	'integration calls' + type as action,
		Request_Key,
		instant,
		Espace_Name,
		'' screen,
		endpoint,
		Executed_by,
		duration,
		action action_name,
		'' username
from	oslog_Integration
where	1 = 1 
and		type in ('SOAP (Consume)', 'REST (Consume)')
and		request_key = @request

