How to extract

Connect to environment using a db management tool (e.g. sql management studio, sql developer, sql plus, toad, etc)
Run query 1, export as excel, don’t forget to include headers (column names).  Save file as Applications__Nodes_Network<yyyymmdd>.xlsx 
Run query 2, export as excel, don’t forget to include headers (column names). Save file as Applications__Dependencies_Edges_Weighted_Network<yyyymmdd>.xlsx 



============ Query 1 (list of nodes - the applications)====

-- File: export as  Applications__Nodes_Network<yyyymmdd>.xlsx including headers



select APP.ID, APP.NAME as label, APP.DESCRIPTION, APP.LAYER, APP.FANIN, APP.FANOUT, ISSELECTED, ISNULL(sum(mnode.EFFORT),0) as EFFORT, ISNULL(sum(mnode.AOS),0) as AOS
from OSUSR_mrn_ApplicationDef app left join OSUSR_MRN_MODULENODE mnode on app.ID = mnode.APPLICATIONDEFID
group by APP.ID, APP.NAME , APP.DESCRIPTION, APP.LAYER, APP.FANIN, APP.FANOUT, ISSELECTED



CAUTION: check the excel file for the column “app.description”. In some cases the app description contains newlines and other html non-escaped characters, resulting in a badly structured excel file.


=====Query 2 (list of edges - the dependencies) =======

--  File: Applications__Dependencies_Edges_Weighted_Network<yyyymmdd>.xlsx 


/* ======================================= */        



       
        /* Get the latest snapshot and store it in a var */

       declare  @LastSnapshot integer = ( select max(id) from OSUSR_MRN_SNAPSHOT)

       select appdef.Id as Source, 
                 appdefdes.ID as Target,
                appdef.NAME + '--->'  +  appdefdes.NAME as Label,
                    count(1) as Weight
             from OSUSR_MRN_APPLICATIONDEF appdef
       inner join OSUSR_MRN_MODULEDEF moddef on appdef.ID = moddef.APPLICATIONDEFID
       inner join OSUSR_MRN_modulenode modnode on moddef.ID =  modnode.MODULEDEFID
                    and modnode.SNAPSHOTID = @LastSnapshot
       inner join OSUSR_MRN_REFERENCE ref on  modnode.ID = ref.SOURCEMODULENODEID
                    and ref.SNAPSHOTID = @LastSnapshot
       inner join osusr_mrn_elementnode enode on ref.TARGETELEMENTNODEID = enode.id
                    and enode.SNAPSHOTID = @LastSnapshot
       inner join OSUSR_MRN_MODULEDEF moddefdes on enode.MODULEDEFID = moddefdes.ID
       inner join OSUSR_MRN_APPLICATIONDEF appdefdes on moddefdes.APPLICATIONDEFID = appdefdes.ID
       --and appdef.id = 3165
       group by appdef.Id, appdefdes.ID ,appdef.NAME + '--->' + appdefdes.NAME