
-------------------------------------------------------------------------------------------------------------------------------------------------
--Get Domains info
--
--osusr_mrn_applicationdef1: Stores the information about an OutSystems application and its violations
--osusr_mrn_domain: Defines an independent ecosystem that teams can manage at their own pace and needs
--osusr_mrn_modulelayer1: store info about the layers configured in discovery
--osusr_mrn_moduledef1: store info about an OutSystems module and its violations
-------------------------------------------------------------------------------------------------------------------------------------------------

select	md.Id,
		md.name as [module-name],
		md.ESPACEID as [espace-id],
		md.ISDELETED [module-isdeleted],
		ad.domainid as [domain-id], 
        d.label as [domain],
		ad.name as [application-name], 
		ad.description as [application-description], 
		ad.layer as [app-definition-layer], 
		ad.totalviolations as [app-definition-total-violations], 
		ad.isselected as [is-selected], 
		ad.isdeleted as [is-deleted], 
		ml.label as [module-layer]
from	osusr_mrn_moduledef1 md inner join osusr_mrn_applicationdef1 ad	on (md.applicationdefid = ad.id)
								left join  osusr_mrn_domain d on (ad.domainid = d.id)
								left join  osusr_mrn_modulelayer1 ml on  (ad.layer =  ml.id)
where	1 = 1
and		md.ISDELETED = 0
and		ml.IS_ACTIVE = 1
and		d.label = ''
order by md.NAME asc
