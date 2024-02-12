create or replace TRIGGER AspNetUserRoles_BUR BEFORE UPDATE ON "AspNetUserRoles" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
  --
  if nvl(:new."RoleId",'#@%') <> nvl(:old."RoleId",'#@%') then
    history_pkg.write_history_data (:new.user_role_id
                                    ,2
                                    ,1
                                    ,:old."RoleId"
                                    ,:new."RoleId");
  end if;
END;
/
show errors
