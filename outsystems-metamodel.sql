-------------------------------------------------------------------------------------------------------------------------------------------------
--Entity physical name and logical names
-------------------------------------------------------------------------------------------------------------------------------------------------
select	en.Id, en.name, 
	en.PHYSICAL_TABLE_NAME, 
	en.is_system, en.data_kind, 
	es.NAME as eSpaceName, 
	app.NAME as ApplicationName, 
	d.name as DatabaseCatalog, 
	d.DataTablespace, 
	d.IndexTablespace, d.name + '.dbo.' + en.PHYSICAL_TABLE_NAME as physical_full_name
from	ossys_Entity en inner join ossys_espace es on (es.id = en.ESPACE_ID)
			inner join ossys_module mo on (mo.espace_id = es.id)
			inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
			left join ossys_dbcatalog d on (d.id = es.DBCatalog_Id)
where	es.name like '%billing_cs%'
and		en.IS_ACTIVE = 1;


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
select  app.name as ApplicationName,
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
and     app.name = 'xxxxxxx'


-------------------------------------------------------------------------------------------------------------------------------------------------
--ROLES: Get Roles for given user
--ossys_user_effective_role: Read-only view containing user specific roles (either direct or via user groups).
-------------------------------------------------------------------------------------------------------------------------------------------------
 SELECT u.id, 
	u.USERNAME, 
	u.TENANT_ID, 
	u.LAST_LOGIN,
	ur.Role_Id,
	r.name as RoleName
 FROM   OSSYS_USER u left join ossys_User_Effective_Role ur on (u.id = ur.USER_ID and ur.TENANT_ID = u.TENANT_ID)
		     inner join ossys_Role r on (r.id = ur.role_id)
 where  u.ID = 3996;


-------------------------------------------------------------------------------------------------------------------------------------------------
--ROLES: User role direct assign or via group

--ossys_user_effective_role: Read-only view containing user specific roles (either direct or via user groups).
-------------------------------------------------------------------------------------------------------------------------------------------------
--direct roles assigned
SELECT	UR.USER_ID [USERID],
		U.USERNAME,
		UR.ROLE_ID [ROLEID],
		R.NAME  [ROLENAME],
		R.ESPACE_ID [ESPACE_ID],
		A.NAME [APP_NAME],
		E.NAME [MODULE_NAME]
FROM	[OSSYS_USER_ROLE] UR INNER JOIN [OSSYS_ROLE] R ON (R.ID = UR.ROLE_ID)
							 LEFT JOIN OSSYS_ESPACE E ON E.ID = R.ESPACE_ID
							 LEFT JOIN OSSYS_MODULE M ON M.ESPACE_ID = E.ID
							 LEFT JOIN OSSYS_APP_DEFINITION_MODULE ADM ON M.ID = ADM.MODULE_ID
							 LEFT JOIN OSSYS_APPLICATION A ON A.ID = ADM.APPLICATION_ID
							 INNER JOIN  OSSYS_USER U ON (U.ID = UR.USER_ID)
WHERE	A.IS_ACTIVE = 1
AND		R.IS_ACTIVE = 1
AND		U.IS_ACTIVE = 1;


--roles assigned by group assignment
SELECT	GU.USER_ID [USERID], 
		U.USERNAME,
		R.ID [ROLEID],
		R.NAME [ROLENAME],
		R.ESPACE_ID [ESPACE_ID],
		A.NAME [APP_NAME],
		E.NAME [MODULE_NAME]
FROM	[OSSYS_GROUP_ROLE] GR INNER JOIN [OSSYS_ROLE] R ON R.ID = GR.ROLE_ID
							  INNER JOIN [OSSYS_GROUP_USER] GU ON GU.GROUP_ID = GR.GROUP_ID
							  LEFT JOIN OSSYS_ESPACE E ON E.ID = R.ESPACE_ID
							  LEFT JOIN OSSYS_MODULE M ON M.ESPACE_ID = E.ID
							  LEFT JOIN OSSYS_APP_DEFINITION_MODULE ADM ON M.ID = ADM.MODULE_ID
							  LEFT JOIN OSSYS_APPLICATION A ON A.ID = ADM.APPLICATION_ID
							  INNER JOIN OSSYS_USER U ON (U.ID = GU.USER_ID)
WHERE	A.IS_ACTIVE = 1
AND		R.IS_ACTIVE = 1
AND		U.IS_ACTIVE = 1


 ------------------------------------------------------------------------------------------------------------------------------------------------
--Integrations: Get consumed web services information
-------------------------------------------------------------------------------------------------------------------------------------------------
 
--SOAP Integrations
select  app.name as ApplicationName, es.name as ModuleName, wr.Is_Active, wr.name as IntegrationName, wr.url as DefaultURL, wr.Effective_URL as Effective_URL
from    ossys_web_reference wr  inner join ossys_espace es on (es.Id = wr.espace_id)
                                inner join ossys_module mo on (mo.espace_id = es.id)
                                inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                                inner join ossys_application app on (app.id = adm.application_id)
where   wr.is_active = 1
and     es.Is_Active = 1
--and     (wr.effective_url like '%dev%' or (wr.url like '%dev%' and wr.effective_url is null))
union all
--REST Integrations
select  app.name as ApplicationName, es.name as ModuleName, wr.Is_Active, wr.name as IntegrationName, wr.url as DefaultURL, wr.Effective_URL as Effective_URL
from    ossys_rest_web_reference wr inner join ossys_espace es on (es.Id = wr.espace_id)
                                    inner join ossys_module mo on (mo.espace_id = es.id)
                                    inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                                    inner join ossys_application app on (app.id = adm.application_id)
where   wr.is_active = 1
and     es.Is_Active = 1
--and     (wr.effective_url like '%dev%' or (wr.url like '%dev%' and wr.effective_url is null))


 ------------------------------------------------------------------------------------------------------------------------------------------------
--References: Get references of given module and object
--ossys_Espace_Reference: table with all references (producers and consumers)
-------------------------------------------------------------------------------------------------------------------------------------------------
select	top (1000) er.[producer_name] as [producer-name],
		er.[producer_kind] as [producer-type], 
		e.[name] as [consumer-name], 
		a.NAME as [application-name],
		count(1) as [references-count]
from	ossys_espace_reference er	inner join ossys_espace e on (e.version_id = er.consumer_version_id)
									inner join ossys_module m on (m.espace_id = e.id)
									inner join ossys_app_definition_module adm on (adm.module_id = m.id)
									inner join ossys_application a on (a.id = adm.application_id)
where	er.[producer_name] = 'outsystemsui'
and	er.[name] like 'deprecated%'
and	e.is_active = 1
group by er.[producer_name], er.[producer_kind], e.[name], a.NAME


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
