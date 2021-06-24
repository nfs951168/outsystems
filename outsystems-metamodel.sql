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
	d.IndexTablespace
from	ossys_Entity en inner join ossys_espace es on (es.id = en.ESPACE_ID)
			inner join ossys_module mo on (mo.espace_id = es.id)
			inner join ossys_app_definition_module adm on (adm.module_id = mo.id)
                        inner join ossys_application app on (app.id = adm.application_id)
			left join ossys_dbcatalog d on (d.id = es.DBCatalog_Id)
where	en.name like '%timesheet%'
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
and     app.name = 'Delta Mobile Backoffice Core'


-------------------------------------------------------------------------------------------------------------------------------------------------
--Users: Get users active with number of roles associated

--ossys_user_effective_role: Read-only view containing user specific roles (either direct or via user groups).
-------------------------------------------------------------------------------------------------------------------------------------------------
 SELECT usr.id, usr.USERNAME, usr.TENANT_ID, usr.LAST_LOGIN, count(usrl.role_id) as Roles
 FROM   OSSYS_USER usr left join ossys_User_Effective_Role usrl on (usr.id = usrl.USER_ID and usr.TENANT_ID = usrl.TENANT_ID)
 where  usr.IS_ACTIVE = 1
 and    usr.TENANT_ID = 12
 group by usr.id, usr.USERNAME, usr.TENANT_ID, usr.LAST_LOGIN
 order by usr.username asc



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
