DECLARE @SQL_SERVER_START_TIME as datetime;
SET @SQL_SERVER_START_TIME = (select sqlserver_start_time from sys.dm_os_sys_info);

with usage as (
				select	ius.object_id, t.name as object_name, 
						MAX(last_user_seek) as last_user_seek, 
						MAX(last_user_scan) as last_user_scan, 
						MAX(last_user_lookup) as last_user_lookup,
						MAX(last_user_update) last_user_update
				from	sys.tables t left join sys.dm_db_index_usage_stats ius on (ius.object_id = t.object_id)
				where	ius.database_id = DB_ID()
				and		t.name like 'OSUSR%' -- only Outsystems user tables
				group by ius.object_id, t.name
)

select	object_id, 
		object_name, 
		last_user_seek, 
		last_user_scan, 
		last_user_lookup, 
		(SELECT MAX(SelectDate) from (values (last_user_scan), (last_user_lookup), (last_user_seek))alias(SelectDate)) as LastSelect,
		last_user_update as LastUpdateDate,
		e.IS_ACTIVE TableIsActive,
		e.NAME as LogicalName,
		e.Data_Kind,
		es.name as eSpaceName,
		es.IS_ACTIVE as eSpaceIsActive
from	usage u left join ossys_entity e on (e.PHYSICAL_TABLE_NAME = u.object_name)
				left join ossys_espace es on (es.id = e.espace_id)
order by 6 asc, 7 asc



