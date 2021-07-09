--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Returns size and rows of each user table in database

--sys.tables: list each user table in current SQL Server Database
--sys.indexes: Contains a row per index or heap of a tabular object, such as a table, view, or table-valued function
--sys.partitions: has the partitions of all tables and the number of rows
--sys_allocation_units: Number of pages of each allocation unit (each allocation page is 8KB)
--sys.schemas: identifies the schema of each table
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

with ostab as (
select	en.physical_table_name [physical-table-name], 
		es.name [module-name], 
		es.is_active [module-status], 
		app.name [application-name], 
		app.is_active [application-status] 
from	outsystems.dbo.ossys_Entity en	inner join outsystems.dbo.ossys_espace es on (es.id = en.ESPACE_ID)
										inner join outsystems.dbo.ossys_module mo on (mo.espace_id = es.id)
										inner join outsystems.dbo.ossys_app_definition_module adm on (adm.module_id = mo.id)
										inner join outsystems.dbo.ossys_application app on (app.id = adm.application_id)
),
sqltab as (
select	T.Name as [table-name],
		s.name as [schema],
		p.rows,
		SUM(au.total_pages) * 8 [reserved-space-kb],
		CAST(ROUND(((SUM(au.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS [reserved-space-mb],
		SUM(au.used_pages) * 8 AS [used-space-kb], 
		CAST(ROUND(((SUM(au.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS [used-space-mb], 
		(SUM(au.total_pages) - SUM(au.used_pages)) * 8 AS [unused-space-kb],
		CAST(ROUND(((SUM(au.total_pages) - SUM(au.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS [unused-space-mb] 
from	sys.tables T	inner join sys.indexes I on (i.object_id = t.object_id)
						inner join sys.partitions P on (p.object_id = i.object_id and p.index_id = p.index_id)
						inner join sys.allocation_units au on (au.container_id = p.partition_id)
						left join sys.schemas s on (s.schema_id = t.schema_id)
group by t.name, s.name, p.rows)

--sql information mixed with outsystems modules and applications
select	sqltab.[table-name], 
		sqltab.rows,
		sqltab.[reserved-space-mb],
		sqltab.[unused-space-mb],
		sqltab.[used-space-mb],
		ostab.[module-name],
		ostab.[application-name]
from	sqltab left join ostab on (ostab.[physical-table-name] collate Latin1_General_CI_AI = sqltab.[table-name] collate Latin1_General_CI_AI)
