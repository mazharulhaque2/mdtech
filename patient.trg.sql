create or replace TRIGGER PATIENT_BUR BEFORE UPDATE ON PATIENT FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
  --
  if nvl(:new.ADDR_SN,999999999999) <> nvl(:old.ADDR_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,1
                                    ,:old.ADDR_SN
                                    ,:new.ADDR_SN);
  end if;
  --
  if nvl(:new.BIRTH_DATE,'31-DEC-9999') <> nvl(:old.BIRTH_DATE,'31-DEC-9999') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,2
                                    ,:old.BIRTH_DATE
                                    ,:new.BIRTH_DATE);
  end if;
  --
  if nvl(:new.CONTACT_PHONE_NUM,'#@%') <> nvl(:old.CONTACT_PHONE_NUM,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,3
                                    ,:old.CONTACT_PHONE_NUM
                                    ,:new.CONTACT_PHONE_NUM);
  end if;
  --
  if nvl(:new.EMAIL_ADDR,'#@%') <> nvl(:old.EMAIL_ADDR,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,4
                                    ,:old.EMAIL_ADDR
                                    ,:new.EMAIL_ADDR);
  end if;
  --
  if nvl(:new.FIRST_NAME,'#@%') <> nvl(:old.FIRST_NAME,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,5
                                    ,:old.FIRST_NAME
                                    ,:new.FIRST_NAME);
  end if;
  --
  if nvl(:new.GENDER_CODE,'#@%') <> nvl(:old.GENDER_CODE,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,6
                                    ,:old.GENDER_CODE
                                    ,:new.GENDER_CODE);
  end if;
  --
  if nvl(:new.LAST_NAME,'#@%') <> nvl(:old.LAST_NAME,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,7
                                    ,:old.LAST_NAME
                                    ,:new.LAST_NAME);
  end if;
  --
  if nvl(:new.MEDICARE_HIC_NUM,'#@%') <> nvl(:old.MEDICARE_HIC_NUM,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,8
                                    ,:old.MEDICARE_HIC_NUM
                                    ,:new.MEDICARE_HIC_NUM);
  end if;
  --
  if nvl(:new.MIDDLE_NAME,'#@%') <> nvl(:old.MIDDLE_NAME,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,9
                                    ,:old.MIDDLE_NAME
                                    ,:new.MIDDLE_NAME);
  end if;
  --
  if nvl(:new.OLD_SYSTEM_FLAG,'#@%') <> nvl(:old.OLD_SYSTEM_FLAG,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,10
                                    ,:old.OLD_SYSTEM_FLAG
                                    ,:new.OLD_SYSTEM_FLAG);
  end if;
  --
  if nvl(:new.PHYSICIAN_SN,999999999999) <> nvl(:old.PHYSICIAN_SN,999999999999) then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,11
                                    ,:old.PHYSICIAN_SN
                                    ,:new.PHYSICIAN_SN);
  end if;
  --
  if nvl(:new.RACE_CODE,'#@%') <> nvl(:old.RACE_CODE,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,12
                                    ,:old.RACE_CODE
                                    ,:new.RACE_CODE);
  end if;
  --
  if nvl(:new.SSN,'#@%') <> nvl(:old.SSN,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,13
                                    ,:old.SSN
                                    ,:new.SSN);
  end if;
  --
  if nvl(:new.UPDATED_BY_USER_ROLE_ID,'#@%') <> nvl(:old.UPDATED_BY_USER_ROLE_ID,'#@%') then
    history_pkg.write_history_data (to_char(:new.patient_sn)
                                    ,3
                                    ,14
                                    ,:old.UPDATED_BY_USER_ROLE_ID
                                    ,:new.UPDATED_BY_USER_ROLE_ID);
  end if;
END;
/
show errors
        