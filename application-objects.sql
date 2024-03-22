
--Get AO's by application
select	app.name as ApplicationName, e.name as eSpacename, e.id as eSpaceId, o.Espace_Version_Id, o.obj_kind, o.Obj_Count
from	ossys_espace_object_count o with (nolock)	inner join ossys_espace_version ev with (nolock) on (ev.id = o.espace_version_id)
													inner join ossys_espace e with (nolock) on (e.VERSION_ID = ev.id)
													inner join ossys_module mo with (nolock) on (mo.espace_id = e.id)
													inner join ossys_app_definition_module adm with (nolock) on (adm.module_id = mo.id)
													inner join ossys_application app with (nolock) on (app.id = adm.application_id)
where	e.IS_ACTIVE = 1
and		e.IS_SYSTEM = 0
and		o.Obj_Count > 0