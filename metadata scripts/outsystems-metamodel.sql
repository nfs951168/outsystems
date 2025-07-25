-------------------------------------------------------------------------------------------------------------------------------------------------
--Entity physical name and logical names
-------------------------------------------------------------------------------------------------------------------------------------------------
select	en.Id, en.name,
	en.description,
	replace(d.name, '(Main)', 'outsystems') + '.dbo.' + en.PHYSICAL_TABLE_NAME as PhysicalTableName, 
	en.is_system, 
	en.data_kind, 
	es.NAME as eSpaceName, 
	app.NAME as ApplicationName, 
	d.name as DatabaseCatalog, 
	d.DataTablespace, 
	d.IndexTablespace, 
	'select top 100 * from ' + replace(d.name, '(Main)', 'outsystems') + '.dbo.' + en.PHYSICAL_TABLE_NAME + ' with (nolock) ' as physical_full_name
from	ossys_Entity en inner join ossys_espace es on (es.id = en.ESPACE_ID)
			inner join ossys_module mo on (mo.espace_id = es.id)
			inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
			left join ossys_dbcatalog d on (d.id = es.DBCatalog_Id)
where	1 = 1
--and		es.name like '%billing_cs%'
and		en.IS_ACTIVE = 1
order by 2 asc;



-------------------------------------------------------------------------------------------------------------------------------------------------
--Site Properties: Get site properties values by application

--SiteProperty_Definition: Site properties for each eSpace as defined in Service Studio. Old site properties are kept as inactive.
--Site_Property_Shared: Single tenant site property effective values.
--Site_Property: Multi-tenant site property effective values
--Espace: Espaces defined in Service Studio. Older and deleted eSpaces are kept as inactive.
--Module: An eSpace or an Extension. Used to aggregate espaces into an application
--App_Definition_Module: Modules for a specific application definition.
--Application: Applications in this environment. Old applications are kept as inactive
-------------------------------------------------------------------------------------------------------------------------------------------------
select  app.Id ApplicationID,
	app.name as ApplicationName,
        app.description as ApplicationDesc,
        es.name as eSpaceName,
        spd.name as SitepropertyName,
        spd.description as SitepropertyDesc,
        spd.default_value,
        spd.data_type,
        sps.property_value as EffectiveValue_ST, --single tenant effective value
        sp.property_value as EffectiveValue_MT -- multi tenant effective value
from    ossys_site_property_definition spd  inner join ossys_espace es on (es.id = spd.espace_id)
                                            inner join ossys_module mo on (mo.espace_id = es.id)   
                                            inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                                            inner join ossys_application app on (app.id = adm.application_id)
                                            left join ossys_site_property_shared sps on (sps.site_property_definition_id = spd.id)
                                            left join ossys_site_property sp on (sp.site_property_definition_id = sp.id)
where   spd.is_active = 1 --only active site properties
and     es.is_active = 1 --only active espaces
and	app.id not in (2,3,5,6,7) --Service center, system components, app feedback, users, EPA


------------------------------------------------------------------------------------------------------------------------------------------------
--References: Get references of given module and object
--ossys_Espace_Reference: table with all references (producers and consumers)
-------------------------------------------------------------------------------------------------------------------------------------------------
select	top (1000) 
	er.name as ObjectName,
	er.kind,
	er.[producer_name] as [producer-name],
	er.[producer_kind] as [producer-type], 
	e.[name] as [consumer-name], 
	a.NAME as [application-name]		
from	ossys_espace_reference er	inner join ossys_espace e on (e.version_id = er.consumer_version_id)
					inner join ossys_module m on (m.espace_id = e.id)
					inner join ossys_app_definition_module adm on (adm.module_id = m.id)
					inner join ossys_application a on (a.id = adm.application_id)
where	1 = 1 
and	e.is_active = 1
and	er.KIND = 'ServiceAPIMethod'




------------------------------------------------------------------------------------------------------------------------------------------------
--References: Get references of given module and object
--ossys_Espace_Reference: table with all references (producers and consumers)
-------------------------------------------------------------------------------------------------------------------------------------------------
select	top (1000) er.[producer_name] as [producer-name],
		er.[producer_kind] as [producer-type], 
		er.name as [reference-name],
		e.[name] as [consumer-name], 
		a.NAME as [application-name]		
from	ossys_espace_reference er	inner join ossys_espace e on (e.version_id = er.consumer_version_id)
									inner join ossys_module m on (m.espace_id = e.id)
									inner join ossys_app_definition_module adm on (adm.module_id = m.id)
									inner join ossys_application a on (a.id = adm.application_id)
where	1 = 1 
and	er.[producer_name] = 'ServiceCenter'
and	er.[name] like 'process'
and	e.is_active = 1



-------------------------------------------------------------------------------------------------------------------------------------------------
--Gets all forge components and their info (version)
-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT	Application.Name Name,  
		ApplicationId,  
		HasLocalChanges,  
		(CAST(ROUND(ForgeBaseVersion, 0)/1000000 as int)) Major, 
		(CAST(ROUND(ForgeBaseVersion, 0)%1000000 as int)/1000) Minor, 
		(CAST(ROUND(ForgeBaseVersion, 0)%1000 as int)) Revision, 
		ForgeBaseVersion, 
		LastSync  
FROM	OSSYS_APP_FORGE AppForge INNER JOIN OSSYS_APPLICATION Application ON (Application.ID = AppForge.ApplicationId AND Application.Is_Active=1)
WHERE	AppForge.LastSync = (SELECT Max(OSSYS_APP_FORGE.LastSync) 
							 FROM OSSYS_APP_FORGE INNER JOIN OSSYS_APPLICATION ON (OSSYS_APPLICATION.ID = OSSYS_APP_FORGE.ApplicationId AND OSSYS_APPLICATION.Is_Active=1)
							 WHERE OSSYS_APP_FORGE.ApplicationId = AppForge.ApplicationId) 
AND		Application.Name LIKE '%adoption%' 
ORDER BY Application.Name ASC



-------------------------------------------------------------------------------------------------------------------------------------------------
--get espaces physical size
-------------------------------------------------------------------------------------------------------------------------------------------------
select	es.NAME, es.VERSION_ID, Datalength(esv.oml_file) / 1024 as MB
from	ossys_Espace es inner join ossys_Espace_Version esv on (esv.id = es.version_id)
where	es.IS_ACTIVE = 1
order by 3 desc


-------------------------------------------------------------------------------------------------------------------------------------------------
--Get timers (cyclic jobs) metadata info

--ossys_meta_cyclic_job: timers metadata informatios
--Site_Property_Shared: Single tenant site property effective values.
--Espace: Espaces defined in Service Studio. Older and deleted eSpaces are kept as inactive.
--Module: An eSpace or an Extension. Used to aggregate espaces into an application
--App_Definition_Module: Modules for a specific application definition.
--Application: Applications in this environment. Old applications are kept as inactive
-------------------------------------------------------------------------------------------------------------------------------------------------
select	a.NAME as application_name,
		e.name as module_name, 
		mcj.name as timer_name, 
		mcj.timeout, 
		mcj.default_schedule, 
		mcj.is_active as timer_active,
		cjs.schedule,
		cjs.is_running_by,
		cjs.is_running_since,
		cjs.last_duration,
		cjs.last_run,
		cjs.next_run
from	ossys_meta_cyclic_job mcj with (nolock) inner join ossys_espace e with (nolock) on (e.id = mcj.espace_id)
												inner join ossys_module m with (nolock) on (m.espace_id = e.id)
												inner join ossys_app_definition_module adm with (nolock) on (adm.module_id = m.id)
												inner join ossys_application a with (nolock) on (a.id = adm.application_id)
												left join ossys_cyclic_job_shared cjs with (nolock) on (cjs.meta_cyclic_job_id = mcj.id)
where	1 = 1
and		e.is_active = 1
and		mcj.is_active = 1



-------------------------------------------------------------------------------------------------------------------------------------------------
--Entity Attributes: get entity columns (foreign keys) with delete rule = ignore
-------------------------------------------------------------------------------------------------------------------------------------------------

SELECT  es.name as ModuleName,
		en.Name as Entity,	
		ea.name as AttributeName, 
		ea.delete_rule, 
		ea.type,
		ea.ss_key,
		en_f.name as foreign_key_entity,
		en_f.Data_Kind
FROM	ossys_Entity_Attr ea	inner join ossys_entity en on (en.id = ea.entity_id)
								inner join ossys_espace es on (es.id = en.espace_id)
								inner join ossys_entity en_f on (right(ea.type, 36) = en_f.SS_KEY)
WHERE	1 = 1
AND		ea.delete_rule = 'Ignore'
AND		ea.is_active = 1
AND		es.is_active = 1
AND		en.Data_Kind <> 'staticEntity'
AND		es.IS_SYSTEM = 0
--exclude Service center and created fields
AND		ea.name not IN ('created_By', 'updatedby', 'Last_Modified_By','CreatedBy', 'Id', 'UpdateBy')
and		es.name not in ('servicecenter', 'ECT_Provider')
and		en.name not in ('MenuItem', 'MenuSubItem')
-- select only forign keys
and		len(ea.type) = 75
order by 1 asc, 2 asc
