 SELECT
            SOURCEDOMAIN.[Id] AS SDID
            ,SOURCEDOMAIN.[DomainLayerId] AS SDLID
            ,SOURCEDOMAIN.[Label] as SDNAME
            ,SOURCEDOMAIN.[HasViolations] AS SHasViolations
            ,SOURCEDOMAIN.[ExposeEntities] as SExposeEntities
            ,SOURCEDOMAIN.[ExposeActions] as SExposeActions
            ,SOURCEAPP.[Id] AS SAID
            ,SOURCEAPP.[name]  as SANAME
            ,SOURCEMODULE.[Id] AS SMID
            ,SOURCEMODULE.[name] as smodlabel
            ,TARGETDOMAIN.[Id] AS TDID
            ,TARGETDOMAIN.[DomainLayerId] AS TDLID
            ,TARGETDOMAIN.[Label] AS TDNAME
            ,TARGETDOMAIN.[HasViolations] as THasViolations
            ,TARGETDOMAIN.[ExposeEntities] as  TExposeEntities
            ,TARGETDOMAIN.[ExposeActions] as TExposeActions
            ,TARGETAPP.[Id] AS TAID
            ,TARGETAPP.[NAME] as TANAME
            ,TARGETMODULE.[Id] AS TMID
            ,TARGETMODULE.[name] as tmodlabel
            ,{ElementNode}.[Id] as ElementNodeId
            ,{ElementNode}.[Name]
            ,{ElementNode}.[Kind]
            ,{ReferenceKind}.[Id] AS RFKID
            ,{ReferenceKind}.[Label] as rfklabel
            ,{ModuleLayer}.[Order]  as ordera
            ,'X',
            'A',
            'B',
            'C'
        FROM
            {ApplicationReference}
            INNER JOIN {ApplicationDef} TARGETAPP ON {ApplicationReference}.[TargetApplication] = TARGETAPP.[Id]
            INNER JOIN {ModuleDef} TARGETMODULE ON TARGETAPP.[Id] = TARGETMODULE.[ApplicationDefId]
            INNER JOIN {Domain} TARGETDOMAIN ON TARGETAPP.[DomainId] = TARGETDOMAIN.[Id]
            INNER JOIN {ApplicationDef} SOURCEAPP ON {ApplicationReference}.[SourceApplication] = SOURCEAPP.[Id]
            INNER JOIN {ModuleDef} SOURCEMODULE ON SOURCEAPP.[Id] = SOURCEMODULE.[ApplicationDefId]
            INNER JOIN {ElementNode} ON TARGETMODULE.[Id] = {ElementNode}.[ModuleDefId]
            INNER JOIN {Reference} ON {ElementNode}.[Id] = {Reference}.[TargetElementNodeId]
            INNER JOIN {ModuleNode} ON {Reference}.[SourceModuleNodeId] = {ModuleNode}.[Id]
                AND {ModuleNode}.[ModuleDefId] = SOURCEMODULE.[Id]
            INNER JOIN {ReferenceKind} ON {ElementNode}.[Kind] = {ReferenceKind}.[Label]
            LEFT JOIN {Domain} SOURCEDOMAIN ON SOURCEAPP.[DomainId] = SOURCEDOMAIN.[Id]
            LEFT JOIN {ModuleLayer} ON TARGETAPP.[Layer] = {ModuleLayer}.[Id]
        WHERE
        {ReferenceKind}.[Label] = 'ServiceAPIMethod'
         and SOURCEDOMAIN.[Label] =  TARGETDOMAIN.[Label]  