--Trigger on 
create or replace TRIGGER ASPNETUSERS_BUR
     BEFORE UPDATE ON "AspNetUsers" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
--  if :new."EmailConfirmed" = 1 and :old.eff_date is null then
--    :new.eff_date := sysdate;
--  end if;
  --
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
show errors
--
create or replace TRIGGER ASPNETUSERS_AIR
     AFTER INSERT ON "AspNetUsers" FOR EACH ROW
BEGIN
  insert into "AspNetUserRoles" ("UserId","RoleId") values (:new."Id",'a74f52c5-4d3a-46d9-bc22-a5eafa982849'); 
END;
/
show error

----Trigger on 
--
--create or replace TRIGGER ASPNETUSERS_AIR
--     AFTER INSERT ON "AspNetUsers" FOR EACH ROW
--BEGIN
--  mbr_trans_pkg.v_global_user_name := :new."UserName";
--  mbr_trans_pkg.v_global_role_name := :new.USER_ROLE;
--END;
--/
--show error
----
--create or replace TRIGGER ASPNETUSERS_AIS
--     AFTER INSERT ON "AspNetUsers" 
--BEGIN
--  mbr_trans_pkg.create_mbr_role;
--END;
--/
--show errors
--
--create or replace TRIGGER MBR_PMT_METHOD_BUR
--     BEFORE UPDATE ON MBR_PMT_METHOD FOR EACH ROW
--BEGIN
--   --to capture the update time and updated by during any update on the table
--   :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
--   :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
   --
--   history_pkg.write_history_data (TO_CHAR (:new.WHS_BRANCH_SEQ_NUM)
--                                  ,30
--                                  ,1
--                                  ,:old.LAWSON_BILL_TO_CUSTOMER
--                                  ,:new.LAWSON_BILL_TO_CUSTOMER);
--        --
--       history_pkg.write_history_data (TO_CHAR (:new.WHS_BRANCH_SEQ_NUM)
--                                  ,30
--                                  ,2
--                                  ,:old.LAWSON_SHIP_TO_CUSTOMER
--                                  ,:new.LAWSON_SHIP_TO_CUSTOMER);
--       --                                  
--       history_pkg.write_history_data (TO_CHAR (:new.WHS_BRANCH_SEQ_NUM)
--                                  ,30
--                                  ,3
--                                  ,:old.UPDATED_BY
--                                  ,:new.UPDATED_BY);      
--       --
--       history_pkg.write_history_data (TO_CHAR (:new.WHS_BRANCH_SEQ_NUM)
--                                  ,30
--                                  ,4
--                                  ,:old.STORE_ACCT_NUM
--                                  ,:new.STORE_ACCT_NUM);
--END;
--/
--show errors