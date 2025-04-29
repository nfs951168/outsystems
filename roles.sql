-------------------------------------------------------------------------------------------------------------------------------------------------
--ROLES: Get Roles for given user
--ossys_user_effective_role: Read-only view containing user specific roles (either direct or via user groups).
-------------------------------------------------------------------------------------------------------------------------------------------------

declare @Username varchar(100);
declare @TenantId int;
declare @UserId int;

SET		@Username = 'nuno.felixfernandes@ageas.pt'

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
