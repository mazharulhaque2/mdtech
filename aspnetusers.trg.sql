--Trigger on 
create or replace TRIGGER ASPNETUSERS_BUR BEFORE UPDATE ON "AspNetUsers" FOR EACH ROW
BEGIN
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
  --
  if nvl(:new.ACTIVE_FLAG,'#@%') <> nvl(:old.ACTIVE_FLAG,'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,1
                                    ,:old.ACTIVE_FLAG
                                    ,:new.ACTIVE_FLAG);
  end if;
  --
  if nvl(:new.COMPANY_SN,999999999999) <> nvl(:old.COMPANY_SN,999999999999) then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,2
                                    ,:old.COMPANY_SN
                                    ,:new.COMPANY_SN);
  end if;
  --
  if nvl(:new.FIRST_NAME,'#@%') <> nvl(:old.FIRST_NAME,'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,3
                                    ,:old.FIRST_NAME
                                    ,:new.FIRST_NAME);
  end if;
  --
  if nvl(:new.LAST_NAME,'#@%') <> nvl(:old.LAST_NAME,'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,4
                                    ,:old.LAST_NAME
                                    ,:new.LAST_NAME);
  end if;
  --
  if nvl(:new.MIDDLE_NAME,'#@%') <> nvl(:old.MIDDLE_NAME,'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,5
                                    ,:old.MIDDLE_NAME
                                    ,:new.MIDDLE_NAME);
  end if;
  --
  if nvl(:new."PhoneNumber",'#@%') <> nvl(:old."PhoneNumber",'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,6
                                    ,:old."PhoneNumber"
                                    ,:new."PhoneNumber");
  end if;
  --
  if nvl(:new."PasswordHash",'#@%') <> nvl(:old."PasswordHash",'#@%') then
    history_pkg.write_history_data (:new."Id"
                                    ,1
                                    ,7
                                    ,:old."PasswordHash"
                                    ,:new."PasswordHash");
  end if;
END;
/
show errors
