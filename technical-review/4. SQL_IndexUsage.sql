
----------------------------------------------------------------------------------------------------------------------------------------
--Index statistics | Unused indexes  since last sql server start (select sqlserver_start_time from sys.dm_os_sys_info)
--  NumOfSeeks: indicates the number of times the index is used to find a specific row (retrieves selective rows from the table)
--  NumOfScans: shows the number of times the leaf pages of the index are scanned (Index scan means it retrieves all the rows from the table)
--  NumOfLookups: indicates the number of times a Clustered index is used by the Non-clustered index to fetch the full row (used in joins)
--  NumOfUpdates: shows the number of times the index data is modified

--Analyze results
--   All zero values mean that the table is not used, or the SQL Server service restarted recently.
--   An index with zero or small number of seeks, scans or lookups and large number of updates is a useless index and should be removed, after verifying with the system owner, as the main purpose of adding the index is speeding up the read operations.
--   An index that is scanned heavily with zero or small number of seeks means that the index is badly used and should be replaced with more optimal one.
--   An index with large number of Lookups means that we need to optimize the index by adding the frequently looked up columns to the existing index non-key columns using the INCLUDE clause.
--   A table with a very large number of Scans indicates that SELECT * queries are heavily used, retrieving more columns than what is required, or the index statistics should be updated.
--   A Clustered index with large number of Scans means that a new Non-clustered index should be created to cover a non-covered query.
--   Dates with NULL values mean that this action has not occurred yet.
--   Large scans are OK in small tables.
--   Your index is not here, then no action is performed on that index yet.
----------------------------------------------------------------------------------------------------------------------------------------
DECLARE @SQL_SERVER_START_TIME as datetime;
SET @SQL_SERVER_START_TIME = (select sqlserver_start_time from sys.dm_os_sys_info);

SELECT  @SQL_SERVER_START_TIME as SQL_SERVER_START_TIME,
		OBJECT_NAME(IX.OBJECT_ID) Table_Name
	   ,IX.name AS Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
	   ,IXUS.user_seeks AS NumOfSeeks
	   ,IXUS.user_scans AS NumOfScans
	   ,IXUS.user_lookups AS NumOfLookups
	   ,IXUS.user_updates AS NumOfUpdates
	   ,IXUS.last_user_seek AS LastSeek
	   ,IXUS.last_user_scan AS LastScan
	   ,IXUS.last_user_lookup AS LastLookup
	   ,IXUS.last_user_update AS LastUpdate
FROM sys.indexes IX INNER JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id AND IXUS.OBJECT_ID = IX.OBJECT_ID
					INNER JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE OBJECTPROPERTY(IX.OBJECT_ID,'IsUserTable') = 1
AND		ix.is_primary_key = 0 --excludes primary key constraints
and		ix.is_unique = 0 --exclude unique constraintrs
and		ixus.user_updates > 0 --indexes that where updated
and		ixus.user_lookups = 0
and		ixus.user_scans = 0
and		ixus.user_seeks = 0
GROUP BY OBJECT_NAME(IX.OBJECT_ID) ,IX.name ,IX.type_desc ,IXUS.user_seeks ,IXUS.user_scans ,IXUS.user_lookups,IXUS.user_updates ,IXUS.last_user_seek ,IXUS.last_user_scan ,IXUS.last_user_lookup ,IXUS.last_user_update
order by IXUS.user_updates desc