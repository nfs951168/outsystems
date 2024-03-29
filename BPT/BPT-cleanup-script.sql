DECLARE @totalProcessToDelete as integer
DECLARE @maxRecords as integer
DECLARE @numDeletedProcesses AS INT
DECLARE @historyDays AS INT
  
set @totalProcessToDelete = 1 -- to enter at least once in the general loop 
set @maxRecords = 10000
set @historyDays = 7 WHILE @totalProcessToDelete > 0 BEGIN -- Get all top processes that meet the cleanup criteria 
  
SELECT OSSYS_BPM_PROCESS.ID AS ProcId INTO #TopProcessIds 
FROM OSSYS_BPM_PROCESS
    INNER JOIN OSSYS_BPM_PROCESS_STATUS status ON STATUS_ID = status.ID
WHERE status.IS_TERMINAL = 1 -- Closed, aborted, etc. 
    AND PARENT_PROCESS_ID IS NULL -- Is top process 
    --last_modified IS NOT NULL and last_modified <> '1900-01-01 00:00:00' and last_modified < getdate() - 30 
    AND last_modified < getdate() - @historyDays -- Not changed in the last historyDays days 
    --AND last_modified < CAST('2022-11-01' AS datetime) 
;
set @totalProcessToDelete = @@ROWCOUNT PRINT 'Got ' + CONVERT(VARCHAR, @totalProcessToDelete) + ' top processes remaining that meet the criteria';
-- Get @maxRecords processes whose top process can be cleaned up 
SELECT TOP (@maxRecords) ID as ProcId INTO #ProcessIdsToCleanup 
FROM OSSYS_BPM_PROCESS
WHERE TOP_PROCESS_ID IN (
        SELECT ProcId
        FROM #TopProcessIds) 
;
PRINT 'Got ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' processes to delete';
-- Cleanup all references to activities of processes that will be deleted 
UPDATE OSSYS_BPM_PROCESS
SET PARENT_ACTIVITY_ID = NULL
WHERE PARENT_ACTIVITY_ID IN (
        SELECT ID
        FROM OSSYS_BPM_ACTIVITY
        WHERE PROCESS_ID IN (
                SELECT ProcId
                FROM #ProcessIdsToCleanup) 
            );
PRINT 'Deleted ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' references to OSSYS_BPM_ACTIVITY from the processes being deleted';
-- Until there are no more processes to delete (out of the initial set) remove sub-processes with no sub-processes 
SET @numDeletedProcesses = 1 -- Guarantee at least 1 iteration 
    WHILE @numDeletedProcesses > 0 BEGIN
DELETE FROM OSSYS_BPM_PROCESS
WHERE PARENT_PROCESS_ID IS NOT NULL -- Not a top process 
    AND ID IN (
        SELECT ProcId
        FROM #ProcessIdsToCleanup) -- One of the processes to cleanup 
            AND ID NOT IN (
                -- Not a parent of any other process 
                SELECT DISTINCT PARENT_PROCESS_ID
                FROM OSSYS_BPM_PROCESS
                WHERE PARENT_PROCESS_ID IS NOT NULL
            );
SET @numDeletedProcesses = @@ROWCOUNT;
PRINT 'Deleted ' + CONVERT(VARCHAR, @numDeletedProcesses) + ' processes with no sub-processes';
END;
-- At this point, all sub-processes in the list to delete were deleted 
-- But the table may still contain sub-processes of top processes in the list to delete (e.g. top process with more than @maxRecords sub-processes) 
-- Now we delete only @maxRecords top processes from those that already have no sub-processes (at all) 
-- Get @maxRecords top-processes from the initial list that we can delete 
SELECT TOP (@maxRecords) ProcId INTO #TopProcessIdsToCleanup 
FROM #TopProcessIds 
WHERE ProcId NOT IN (
        SELECT DISTINCT TOP_PROCESS_ID
        FROM OSSYS_BPM_PROCESS
        WHERE PARENT_PROCESS_ID IS NOT NULL
    );
PRINT 'Got ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' top processes with no sub-processes';
-- Cleanup circular dependencies to those processes via top_process_id 
UPDATE OSSYS_BPM_PROCESS
SET TOP_PROCESS_ID = NULL
WHERE ID IN (
        SELECT ProcId
        FROM #TopProcessIdsToCleanup); 
            PRINT 'Deleted ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' references to OSSYS_BPM_PROCESS from the top processes being deleted';
-- Finally, delete all those top processes 
DELETE FROM OSSYS_BPM_PROCESS
WHERE ID IN (
        SELECT ProcId
        FROM #TopProcessIdsToCleanup); 
            PRINT 'Deleted ' + CONVERT(VARCHAR, @@ROWCOUNT) + ' top processes with no sub-processes';
drop table #ProcessIdsToCleanup; 
drop table #TopProcessIds; 
drop table #TopProcessIdsToCleanup; 
END;
