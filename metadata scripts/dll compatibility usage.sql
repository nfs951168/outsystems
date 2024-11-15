SELECT REPDLLEXT.Filename DLL, ossys_Extension.Name EXTENSION FROM	
    (SELECT ossys_Extension_Dependency.Filename, ossys_Extension_Dependency.Extension_Id FROM		
        (SELECT Filename FROM
            (SELECT Filename, Extension_Id FROM
            ossys_Extension_Dependency
            JOIN ossys_Extension on ossys_Extension_Dependency.Extension_Id = ossys_Extension.Id
            WHERE Filename LIKE '%.dll'
            AND ossys_Extension.IS_ACTIVE = 1
            AND ossys_Extension.Name NOT IN 
			('OMLProcessor', 'IntegrationStudio', 'DeviceDetectionWithWURFL',
            'SAPDevServiceExtension', 'RESTDevServiceExtension',
            'SOAPDevServiceExtension', 'SCBootstrap', 'UsersSecurity')
            GROUP BY Filename, Extension_Id) DLLEXT
        GROUP BY Filename
        HAVING count(*) > 1) REPDLL
    JOIN ossys_Extension_Dependency on ossys_Extension_Dependency.Filename = REPDLL.Filename
    GROUP BY ossys_Extension_Dependency.Filename, ossys_Extension_Dependency.Extension_Id) REPDLLEXT
LEFT JOIN ossys_Extension on REPDLLEXT.Extension_Id = ossys_Extension.Id
where ossys_Extension.IS_ACTIVE = 1
order by DLL