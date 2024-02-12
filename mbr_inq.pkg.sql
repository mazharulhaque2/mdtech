CREATE OR REPLACE PACKAGE mbr_inq_pkg IS
  v_pkg_name    varchar2 (30) := upper('mbr_inq_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  --
  PROCEDURE get_user(p_username IN "AspNetUsers"."UserName"%type
                    ,p_password IN "AspNetUsers"."PasswordHash"%type
                    ,p_role IN "AspNetRoles"."Name"%type
                    ,p_out  OUT SYS_REFCURSOR
                    ); 
  function user_role_id_by_username (p_username IN "AspNetUsers"."UserName"%type) return "AspNetUserRoles".User_Role_ID%type;
  function role_id_by_username (p_username IN "AspNetUsers"."UserName"%type) return "AspNetRoles"."Id"%type;
  function user_id_by_username(p_username IN "AspNetUsers"."UserName"%type) return "AspNetUsers"."Id"%type;
  function get_user_role_id (p_username IN "AspNetUsers"."UserName"%type
                            ,p_role IN "AspNetRoles"."Name"%type
                            ) return "AspNetUserRoles".User_Role_ID%type
                            ;
  function get_user_parent_id (p_username IN "AspNetUsers"."UserName"%type
                            ) return "AspNetUsers".parent_id%type
                            ;
  function get_user_parent_username (p_username IN "AspNetUsers"."UserName"%type
                            ) return "AspNetUsers"."UserName"%type
                            ;
  function get_user_parent_role_id (p_username IN "AspNetUsers"."UserName"%type
                            ,p_role IN "AspNetRoles"."Name"%type
                            ) return "AspNetUserRoles".User_Role_ID%type
                            ;
  function get_user_email (p_user_role_id in "AspNetUserRoles".User_Role_ID%type) return "AspNetUsers"."Email"%type;
  function get_user_name (p_user_role_id in "AspNetUserRoles".User_Role_ID%type) return "AspNetUsers"."UserName"%type;
END mbr_inq_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY mbr_inq_pkg IS
  function get_user_email (p_user_role_id in "AspNetUserRoles".User_Role_ID%type
                           ) return "AspNetUsers"."Email"%type
  is
    v_email "AspNetUsers"."Email"%type;
  begin
    select u."Email"
    into v_email
    from "AspNetUsers" u
         ,"AspNetUserRoles" ur
    where ur."UserId" = u."Id"
    and ur.user_role_id = p_user_role_id
    ;
    return v_email;
  exception
    when others then
      return null;
  end get_user_email;
  --
  function get_user_name (p_user_role_id in "AspNetUserRoles".User_Role_ID%type) return "AspNetUsers"."UserName"%type
  is
    v_user_name "AspNetUsers"."UserName"%type;
  begin
    select u."UserName"
    into v_user_name
    from "AspNetUsers" u
         ,"AspNetUserRoles" ur
    where ur."UserId" = u."Id"
    and ur.user_role_id = p_user_role_id
    ;
    return v_user_name;
  exception
    when others then
      return null;
  end get_user_name;  
  --
  function get_user_parent_role_id (p_username IN "AspNetUsers"."UserName"%type
                            ,p_role IN "AspNetRoles"."Name"%type
                            ) return "AspNetUserRoles".User_Role_ID%type
  is
  begin
    return get_user_role_id(get_user_parent_username(p_username),p_role);
  exception
    when others then
      return null;
  end get_user_parent_role_id;
  --
  function get_user_parent_username (p_username IN "AspNetUsers"."UserName"%type
                            ) return "AspNetUsers"."UserName"%type
  is
    v_parent_username "AspNetUsers"."UserName"%type;
  begin
    select "UserName"
    into v_parent_username
    from (SELECT "Id",PARENT_ID,"UserName"
          FROM "AspNetUsers"
          where active_flag = 'Y'
          start with upper("UserName") = upper(p_username)
          CONNECT BY prior PARENT_ID = "Id" 
         )
    where parent_id is null
    ;
    return v_parent_username;
  exception
    when others then
      return null;
  end get_user_parent_username;
  --
  function get_user_parent_id (p_username IN "AspNetUsers"."UserName"%type
                            ) return "AspNetUsers".parent_id%type
  is
    v_parent_id "AspNetUsers".parent_id%type;
  begin
    select "Id"
    into v_parent_id
    from (SELECT "Id",PARENT_ID
          FROM "AspNetUsers"
          where active_flag = 'Y'
          start with upper("UserName") = upper(p_username)
          CONNECT BY prior PARENT_ID = "Id" 
         )
    where parent_id is null
    ;
    return v_parent_id;
  exception
    when others then
      return null;
  end get_user_parent_id;
  --
  function get_user_role_id (p_username IN "AspNetUsers"."UserName"%type
                            ,p_role IN "AspNetRoles"."Name"%type
                            ) return "AspNetUserRoles".User_Role_ID%type
  is
    v_User_Role_ID "AspNetUserRoles".User_Role_ID%type;
  begin
    select ur.User_Role_ID
    into v_User_Role_ID
    from "AspNetUsers" u
          ,"AspNetRoles" r
          ,"AspNetUserRoles" ur
    where ur."UserId" = u."Id"
    and ur."RoleId" = r."Id"
    and upper("UserName") = upper(p_username)
    and upper(r."Name") = upper(p_role)
    ;
    return v_User_Role_ID;
  exception
    when no_data_found then
      return null;
    when others then
      raise_application_error(-20001,sqlerrm);
  end get_user_role_id;
  --
  function role_id_by_username (p_username IN "AspNetUsers"."UserName"%type) return "AspNetRoles"."Id"%type
  is
    v_Role_ID "AspNetRoles"."Id"%type;
  begin
    select ur."RoleId"
    into v_Role_ID
    from "AspNetUsers" u
          ,"AspNetRoles" r
          ,"AspNetUserRoles" ur
    where ur."UserId" = u."Id"
    and ur."RoleId" = r."Id"
    and upper("UserName") = upper(p_username)
    ;
    return v_Role_ID;
  exception
    when no_data_found then
      return null;
    when others then
      raise_application_error(-20001,sqlerrm);
  end role_id_by_username;
  --
  function user_id_by_username(p_username IN "AspNetUsers"."UserName"%type) return "AspNetUsers"."Id"%type
  is
    v_user_id "AspNetUsers"."Id"%type;
  begin
    select "Id"
    into v_user_id
    from "AspNetUsers"
    where upper("UserName") = upper(p_username)
    ;
    return v_user_id;
  exception
    when no_data_found then
      return null;
    when others then
      raise_application_error(-20001,sqlerrm);
  end user_id_by_username;
  --
  function user_role_id_by_username (p_username IN "AspNetUsers"."UserName"%type) return "AspNetUserRoles".User_Role_ID%type
  is
    v_User_Role_ID "AspNetUserRoles".User_Role_ID%type;
  begin
    select ur.User_Role_ID
    into v_User_Role_ID
    from "AspNetUsers" u
          ,"AspNetRoles" r
          ,"AspNetUserRoles" ur
    where ur."UserId" = u."Id"
    and ur."RoleId" = r."Id"
    and upper("UserName") = upper(p_username)
    ;
    return v_User_Role_ID;
  exception
    when no_data_found then
      return null;
    when others then
      raise_application_error(-20001,sqlerrm);
  end user_role_id_by_username;
  --
  PROCEDURE get_user(p_username IN "AspNetUsers"."UserName"%type
                    ,p_password IN "AspNetUsers"."PasswordHash"%type
                    ,p_role IN "AspNetRoles"."Name"%type
                    ,p_out  OUT SYS_REFCURSOR
                    ) IS
    BEGIN
      open p_out for
      select     u."Id"
                ,u."Email"
                ,u."EmailConfirmed"
                ,u."PasswordHash"
                ,u."SecurityStamp"
                ,u."PhoneNumber"
                ,u."PhoneNumberConfirmed"
                ,u."TwoFactorEnabled"
                ,u."LockoutEndDateUtc"
                ,u."LockoutEnabled"
                ,u."AccessFailedCount"
                ,u."UserName"
                ,r."Name" role_name
      from "AspNetUsers" u
          ,"AspNetRoles" r
          ,"AspNetUserRoles" ur
      where ur."UserId" = u."Id"
      and ur."RoleId" = r."Id"
      and upper("UserName") = upper(p_username)
      and "PasswordHash" = p_password
      and upper(r."Name") = upper(p_role)
      ;
    END get_user;
END mbr_inq_pkg;
/
SHOW ERRORS;