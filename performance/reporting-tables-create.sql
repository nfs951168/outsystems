USE [outsystems_reporting]


--------------------------------------------------------------------------------------------------------------------------
--RPT_OUTSYSTEMS_PERF_ERRORS: Agregate number of errors by application
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[RPT_OUTSYSTEMS_PERF_ERRORS](
	[day] [date] NULL,
	[hour] [int] NULL,
	[Application_Name] [nvarchar](50) NULL,
	[Espace_Name] [nvarchar](50) NULL,
	[Action_Name] [nvarchar](60) NULL,
	[Entrypoint_Name] [nvarchar](60) NULL,
	[module_name] [nvarchar](15) NOT NULL,
	[requests] [int] NULL
) ON [PRIMARY]
GO



--------------------------------------------------------------------------------------------------------------------------
--RPT_OUTSYSTEMS_PERF_INTEGRATIONS: Integration statistics like calls, duration (min, max, avg), errors
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[RPT_OUTSYSTEMS_PERF_INTEGRATIONS](
	[day] [date] NULL,
	[hour] [int] NULL,
	[Server] [nvarchar](50) NULL,
	[Application_Name] [nvarchar](50) NULL,
	[Espace_Name] [nvarchar](50) NULL,
	[Endpoint] [nvarchar](1000) NULL,
	[Action] [nvarchar](100) NULL,
	[Type] [nvarchar](50) NULL,
	[requests] [int] NULL,
	[avg_duration_ms] [int] NULL,
	[min_duration_ms] [int] NULL,
	[max_duration_ms] [int] NULL,
	[Errors] [int] NULL
) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------------------------
--RPT_OUTSYSTEMS_PERF_SCREENS: Screen statistics like calls, duration (min, max, avg)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[RPT_OUTSYSTEMS_PERF_SCREENS](
	[request_type] [varchar](2) NOT NULL,
	[day] [date] NULL,
	[hour] [int] NULL,
	[server] [nvarchar](50) NULL,
	[application_name] [nvarchar](50) NULL,
	[espace_name] [nvarchar](50) NULL,
	[screen] [nvarchar](50) NULL,
	[action_name] [nvarchar](60) NULL,
	[access_mode] [nvarchar](10) NOT NULL,
	[requests] [int] NULL,
	[avg_duration_ms] [int] NULL,
	[min_duration_ms] [int] NULL,
	[max_duration_ms] [int] NULL,
	[avg_viewstate_kb] [int] NULL
) ON [PRIMARY]
GO


--------------------------------------------------------------------------------------------------------------------------
--RPT_OUTSYSTEMS_PERF_SLOWSQL: Slow SQL statistics by application (only queries > 200ms are tracked)
--                             Information gathered from General Log
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[RPT_OUTSYSTEMS_PERF_SLOWSQL](
	[day] [date] NULL,
	[hour] [int] NULL,
	[Application_Name] [nvarchar](50) NULL,
	[Espace_Name] [nvarchar](50) NULL,
	[Action_Name] [nvarchar](60) NULL,
	[Entrypoint_Name] [nvarchar](60) NULL,
	[Query] [nvarchar](2000) NULL,
	[requests] [int] NULL,
	[avg_duration_ms] [int] NULL,
	[min_duration_ms] [int] NULL,
	[max_duration_ms] [int] NULL
) ON [PRIMARY]
GO
