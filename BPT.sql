------------------------------------------------------------------------------------------------------------------------------------------------
--Process definition
--Gets process definition with same configuration as we see in Service Studio
------------------------------------------------------------------------------------------------------------------------------------------------
select	pd.Id As ProcessId,
		pd.name as Process_Name, 
		pd.label as Process_Label, 
		pd.description as Process_Description, 
		ac.name as Activity_Name, 
		ac.label Activity_Label, 
		ac.kind as Activity_Kind, 
		ak.Name as Activity_Kind,
		ac.is_active as Asctivity_IsActive, ac.*
from	ossys_bpm_process_definition pd inner join ossys_bpm_activity_definition ac on (ac.Process_Def_Id = pd.Id)
										inner join ossys_BPM_Activity_Kind ak on (ak.id = ac.Kind)
where	pd.espace_id IN (141, 140)
order by pd.name asc, ac.Display_Y asc


------------------------------------------------------------------------------------------------------------------------------------------------
--Process Execution
--Gives information about executed/executing activities
------------------------------------------------------------------------------------------------------------------------------------------------
select	top 100 pr.id as ProcessId,
		pd.Name as Process_Def_Name, 
		pr.label as Process_Label,
		pr.created as Process_Created,
		pr.STATUS_ID as Process_StatusId,
		ac.name as Activity_Name,
		ac.Created as Activity_Created,
		ac.opened as Activity_Opened,
		ac.closed as Activity_Closed,
		ac.Status_Id as Activity_StatusId,
		ast.NAME as ActivityStatus_Desc,
		ac.Inbox_Detail as Activity_InboxDetail,
		ac.Error_Count as Activity_ErrorCount,
		ac.Precedent_Activity_Id
from	ossys_bpm_process pr inner join ossys_bpm_activity ac on (ac.Process_Id = pr.id)
							 inner join ossys_bpm_process_definition pd on (pd.id = pr.process_def_id)
							 inner join ossys_BPM_Activity_Status ast on (ast.id = ac.Status_Id)
where	pd.espace_id IN (141, 140)
and		pd.id = 86
order by pr.id desc, ac.Precedent_Activity_Id asc
