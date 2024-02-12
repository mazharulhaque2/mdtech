create or replace TRIGGER PATIENT_PREV_SVC_BUR BEFORE UPDATE ON PATIENT_PREV_SVC FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
  --
  if nvl(:new.G0438_COMP_ON_DIFF_SYS_FLAG,'#@%') <> nvl(:old.G0438_COMP_ON_DIFF_SYS_FLAG,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,1
                                    ,:old.G0438_COMP_ON_DIFF_SYS_FLAG
                                    ,:new.G0438_COMP_ON_DIFF_SYS_FLAG);
  end if;
  --
  if nvl(:new.PARENT_PATIENT_PREV_SVC_SN,999999999999) <> nvl(:old.PARENT_PATIENT_PREV_SVC_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,2
                                    ,:old.PARENT_PATIENT_PREV_SVC_SN
                                    ,:new.PARENT_PATIENT_PREV_SVC_SN);
  end if;
  --
  if nvl(:new.PATIENT_SN,999999999999) <> nvl(:old.PATIENT_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,3
                                    ,:old.PATIENT_SN
                                    ,:new.PATIENT_SN);
  end if;
  --
  if nvl(:new.PHYSICIAN_SVC_LOCATION_SN,999999999999) <> nvl(:old.PHYSICIAN_SVC_LOCATION_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,4
                                    ,:old.PHYSICIAN_SVC_LOCATION_SN
                                    ,:new.PHYSICIAN_SVC_LOCATION_SN);
  end if;
  --
  if nvl(:new.PROVIDER_PHYSICIAN_SN,999999999999) <> nvl(:old.PROVIDER_PHYSICIAN_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,5
                                    ,:old.PROVIDER_PHYSICIAN_SN
                                    ,:new.PROVIDER_PHYSICIAN_SN);
  end if;
  --
  if nvl(:new.UPDATED_BY_USER_ROLE_ID,'#@%') <> nvl(:old.UPDATED_BY_USER_ROLE_ID,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_prev_svc_sn)
                                    ,4
                                    ,6
                                    ,:old.UPDATED_BY_USER_ROLE_ID
                                    ,:new.UPDATED_BY_USER_ROLE_ID);
  end if;
END;
/
show errors
        