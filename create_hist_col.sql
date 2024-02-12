--================================================"AspNetUsers"
begin
  for i in (select upper(column_name) column_name
                  ,decode(data_type,'VARCHAR2','VC','NVARCHAR2','VC','CHAR','VC','NUMBER','NU','DATE','DT','RAW','VC') data_type
            from dba_tab_columns
            where table_name = ('AspNetUsers') 
            and column_name in ('PasswordHash','PhoneNumber','FIRST_NAME','LAST_NAME','MIDDLE_NAME','ACTIVE_FLAG','COMPANY_SN')
            order by column_name
            )
  loop
    common_pkg.turn_on_hist_prc('ASPNETUSERS',i.column_name,i.data_type,'Y');
  end loop;
  commit;
end;
/
--================================================"AspNetUserRoles"
begin
  for i in (select upper(column_name) column_name
                  ,decode(data_type,'VARCHAR2','VC','NVARCHAR2','VC','CHAR','VC','NUMBER','NU','DATE','DT','RAW','VC') data_type
            from dba_tab_columns
            where table_name = ('AspNetUserRoles') 
            and column_name in ('RoleId')
            order by column_name
            )
  loop
    common_pkg.turn_on_hist_prc('ASPNETUSERROLES',i.column_name,i.data_type,'Y');
  end loop;
  commit;
end;
/

--================================================PATIENT
begin
  for i in (select column_name
                  ,decode(data_type,'RAW','VC','VARCHAR2','VC','NVARCHAR2','VC','CHAR','VC','NUMBER','NU','DATE','DT') data_type
            from dba_tab_columns
            where table_name = upper('PATIENT') 
            and column_name in ('SSN','PHYSICIAN_SN','UPDATED_BY_USER_ROLE_ID','MEDICARE_HIC_NUM','ADDR_SN','GENDER_CODE','RACE_CODE','FIRST_NAME','LAST_NAME','MIDDLE_NAME','CONTACT_PHONE_NUM','EMAIL_ADDR','BIRTH_DATE','OLD_SYSTEM_FLAG')
            order by column_name
            )
  loop
    common_pkg.turn_on_hist_prc('PATIENT',i.column_name,i.data_type,'Y');
  end loop;
  commit;
end;
/
----================================================PATIENT_PREV_SVC
begin
  for i in (select column_name
                  ,decode(data_type,'RAW','VC','VARCHAR2','VC','NVARCHAR2','VC','CHAR','VC','NUMBER','NU','DATE','DT') data_type
            from dba_tab_columns
            where table_name = upper('PATIENT_PREV_SVC') 
            and column_name in ('UPDATED_BY_USER_ROLE_ID','PATIENT_SN','PROVIDER_PHYSICIAN_SN','PHYSICIAN_SVC_LOCATION_SN','G0438_COMP_ON_DIFF_SYS_FLAG','PARENT_PATIENT_PREV_SVC_SN')
            order by column_name
            )
  loop
    common_pkg.turn_on_hist_prc('PATIENT_PREV_SVC',i.column_name,i.data_type,'Y');
  end loop;
  commit;
end;
/
