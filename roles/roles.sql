-------------------------------------------------------------------------------------------------------------------------------------------------
--ROLES: Get Roles for given user
--ossys_user_effective_role: Read-only view containing user specific roles (either direct or via user groups).
-------------------------------------------------------------------------------------------------------------------------------------------------

declare @Username varchar(100);
declare @TenantId int;
declare @UserId int;

SET		@Username = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx'

--Get Tenant
select	@TenantId = Id
from	ossys_tenant 
where	name = 'Users'

--Get User
select	@UserId = Id 
from	ossys_user
where	username = @Username
and		tenant_Id = @TenantId

--Get User Roles
 SELECT u.id, 
		u.USERNAME, 
		u.TENANT_ID, 
		u.LAST_LOGIN,
		e.Name as eSpaceName,
		ur.Role_Id,
		r.name as RoleName
 FROM   OSSYS_USER u	left join ossys_User_Effective_Role ur on (u.id = ur.USER_ID and ur.TENANT_ID = u.TENANT_ID)
						inner join ossys_Role r on (r.id = ur.role_id)
						inner join ossys_espace e on (e.id = r.ESPACE_ID)
 where  u.ID = @UserId;



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
