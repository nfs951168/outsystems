------------------------------------------------------------------------------------------------------------------------------
--Gets all SOAP exposed webservices
------------------------------------------------------------------------------------------------------------------------------
select	'soap' as type, es.name, ws.name, ws.internal_access, ws.secure_connection, ws.integrated_authentication
from	ossys_Web_Service ws inner join ossys_espace es on (es.id = ws.espace_id)
where	es.is_active = 1
and		ws.is_active = 1
and		es.is_system = 0 -- exclude systems services