
--------------------------------------------------------------------------------------------------------------------------------------
--Gathers statistics about every developer, from the OSSYS_DEVELOPER_OPERATION
--1CP, RUN, SS_Modify, SS_Browse, SC_Browse 
--------------------------------------------------------------------------------------------------------------------------------------


use outsystems;

DECLARE @mindate as DATETIME
DECLARE @maxdate as DATETIME
DECLARE @username as NVARCHAR(150)

SET @mindate = '2021-06-01';
SET @maxdate = '2021-06-30';
SET @username = '%fernandes%';


with devops as (
--modules information
SELECT	OSSYS_USER.[Name] [UserName],
		OSSYS_ESPACE.[Name],
		OSSYS_REPORT_SU.[OMLComplexity] [SUs],
		COUNT(1) ops,
		dateadd(hour, datediff(hour, 0, OSSYS_Developer_Operation.[DateTime]), 0) instant
FROM OSSYS_APPLICATION	INNER JOIN OSSYS_APP_DEFINITION_MODULE ON OSSYS_APP_DEFINITION_MODULE.[Application_Id] = OSSYS_APPLICATION.[Id]
						INNER JOIN OSSYS_Module ON OSSYS_Module.[Id] = OSSYS_APP_DEFINITION_MODULE.[Module_Id]
						INNER JOIN OSSYS_ESPACE ON OSSYS_ESPACE.[Id] = OSSYS_Module.[Espace_Id]
						INNER JOIN OSSYS_ESPACE_VERSION ON OSSYS_ESPACE_VERSION.[Id] = OSSYS_ESPACE.[Version_Id]
						INNER JOIN OSSYS_REPORT_SU ON OSSYS_REPORT_SU.[EspaceId] = OSSYS_ESPACE.[Id]
						LEFT JOIN OSSYS_Developer_Operation ON (OSSYS_Developer_Operation.[ESpace_Id] = OSSYS_ESPACE.[Id] 
																AND OSSYS_Developer_Operation.[Operation_Type] < 5
																AND OSSYS_Developer_Operation.[DateTime] between @mindate and @maxdate)
						LEFT JOIN OSSYS_USER ON OSSYS_USER.[Id] = OSSYS_Developer_Operation.[User_Id]
WHERE	OSSYS_APPLICATION.[Is_Active] = 1
AND		OSSYS_ESPACE.[Is_Active] = 1
AND		OSSYS_USER.[Name] like @username
AND		OSSYS_USER.[Id] IS NOT NULL
GROUP BY OSSYS_USER.[Name],
		 OSSYS_ESPACE.[Name],
		 OSSYS_REPORT_SU.[OMLComplexity],
		 dateadd(hour, datediff(hour, 0, OSSYS_Developer_Operation.[DateTime]), 0)
--extensions information
UNION ALL
SELECT	OSSYS_USER.[Name],
		OSSYS_EXTENSION.[Name],
		0,
		COUNT(1),
		dateadd(hour, datediff(hour, 0, OSSYS_Developer_Operation.[DateTime]), 0) AS instant 
FROM OSSYS_APPLICATION
						INNER JOIN OSSYS_APP_DEFINITION_MODULE ON OSSYS_APP_DEFINITION_MODULE.[Application_Id] = OSSYS_APPLICATION.[Id]
						INNER JOIN OSSYS_Module ON OSSYS_Module.[Id] = OSSYS_APP_DEFINITION_MODULE.[Module_Id]
						INNER JOIN OSSYS_EXTENSION ON OSSYS_EXTENSION.[Id] = OSSYS_Module.[Espace_Id]
						INNER JOIN OSSYS_EXTENSION_VERSION ON OSSYS_EXTENSION_VERSION.[Id] = OSSYS_EXTENSION.[Version_Id]
						LEFT JOIN OSSYS_Developer_Operation ON OSSYS_Developer_Operation.[Extension_Id] = OSSYS_EXTENSION.[Id]
														AND OSSYS_Developer_Operation.[Operation_Type] < 5
														AND OSSYS_Developer_Operation.[DateTime] between @mindate and @maxdate
						LEFT JOIN OSSYS_USER ON OSSYS_USER.[Id] = OSSYS_Developer_Operation.[User_Id]
WHERE OSSYS_APPLICATION.[Is_Active] = 1
AND OSSYS_EXTENSION.[Is_Active] = 1
AND OSSYS_USER.[Name] like @username
AND OSSYS_USER.[Id] IS NOT NULL
GROUP BY OSSYS_USER.[Name],
    OSSYS_EXTENSION.[Name],
    dateadd(hour, datediff(hour, 0, OSSYS_Developer_Operation.[DateTime]), 0)

),
devops_f as(
SELECT	[UserName],
		[Name],
		[SUs],
		instant,
		CONVERT(date, instant) InstantDay,
		ops * 1.0 / sum(ops) over  (partition by   [UserName],  instant ) hourtotal,
		ops,
		sum(ops) over  (partition by  [UserName], instant   ) opsHour
FROM devops
)


SELECT
		UserName,
		InstantDay,
		MIN(DATEPART(HOUR,instant)) "Login",
		MAX(DATEPART(HOUR,instant)) "Logout",
		ROUND(SUM(hourTotal),0) HoursWorked,
		SUM(ops) TotalOps,
		AVG(opsHour) AVGOpsHour,
		NULL AS DaysHorked,
		DATEADD(MONTH, DATEDIFF(MONTH, 0, InstantDay), 0) AS MonthDate,
		NULL AS AVGHoursPerDay
FROM devops_f
GROUP BY [UserName], InstantDay
--Create total row for the user
UNION ALL
SELECT
		UserName,
		NULL as InstantDay,
		NULL "Login",
		NULL "Logout",
		ROUND(SUM(hourTotal),0) HoursWorked,
		SUM(ops) TotalOps,
		AVG(opsHour) AVGOpsHour,
		COUNT(DISTINCT InstantDay) AS DaysHorked,
		DATEADD(MONTH, DATEDIFF(MONTH, 0, InstantDay), 0) AS MonthDate,
		ROUND(ROUND(SUM(hourTotal),0)/COUNT(DISTINCT InstantDay),2) AS AVGHoursPerDay
FROM devops_f
GROUP BY [UserName], DATEADD(MONTH, DATEDIFF(MONTH, 0, InstantDay), 0)
ORDER BY [UserName], InstantDay ASC ,MonthDate ASC

