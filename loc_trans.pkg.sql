set define off
CREATE OR REPLACE PACKAGE loc_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('loc_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  --
  procedure load_continent;
  procedure load_appsnetroles;
  procedure load_COUNTRY;
  procedure load_COUNTRY_LANG;
  procedure load_STATE;
  procedure load_CITY;
  procedure load_list_lang;
  procedure load_LIST_ERROR_SEVERITY;
  procedure load_TRANS_LANG;
  procedure load_OAuth_Clients;
  procedure load_LIST_MEASUREMENT;
  procedure load_list_location_type;
  procedure load_LIST_CURRENCY;
  procedure load_LIST_TIMEZONE;
  procedure load_POSTAL;
  procedure load_continent_alt_name;
  procedure load_COUNTRY_ALT_NAME;
  procedure upd_COUNTRY_ALT_NAME;
  
  PROCEDURE load_application_control;
  PROCEDURE load_LIST_ADDR_TYPE;
  PROCEDURE load_list_file_type;
  --
  --PROCEDURE load_LIST_APPLICATION;
  PROCEDURE load_APPLICATION_ERROR_MSG;
  PROCEDURE load_APPLICATION_EM_LANG;
  --
  PROCEDURE load_LIST_MONTH;
  PROCEDURE load_LIST_YEAR;
  PROCEDURE load_LIST_MONTH_LANG;
  PROCEDURE load_LIST_APPL_FUNCTIONALITY;
  procedure load_calendar;
  --
  PROCEDURE load_TRANS_lang (p_culture IN TRANS_LANG.CULTURE%type
                               ,p_name IN TRANS_LANG.name%type
                               ,p_value IN nvarchar2
                               );
END loc_trans_pkg;
/
SHOW ERRORS
CREATE OR REPLACE PACKAGE BODY loc_trans_pkg IS
  procedure load_calendar is
    v_day_num calendar.day_num%type;
    v_day_long_descr calendar.day_long_descr%type;
    v_day_short_descr calendar.day_short_descr%type;
    v_calendar_date calendar.calendar_date%type; 
    v_day number(2);
  begin
    v_proc_name := upper('load_calendar');
    for i in (select year_code
              from list_year
              where active_flag = 'Y'
              )
    loop
      for j in (select month_code
                      ,short_descr
                from list_month_lang
                where active_flag = 'Y'
                )
      loop
        v_day := to_number(to_char(last_day(to_date('01-'||j.short_descr||'-'||i.year_code||'','DD-MON-YYYY')),'DD'));
        --
        for k in 1..v_day loop
          v_day_num := lpad(k,2,'0');
          v_day_long_descr := to_char(to_date(v_day_num||'-'||j.short_descr||'-'||i.year_code||'','DD-MON-YYYY'),'DAY');
          v_day_short_descr := to_char(to_date(v_day_num||'-'||j.short_descr||'-'||i.year_code||'','DD-MON-YYYY'),'DY');
          v_calendar_date := to_date(v_day_num||'-'||j.short_descr||'-'||i.year_code||'','DD-MON-YYYY');
          --
          v_error_rec := i.year_code||'-'||j.month_code||'-'||v_day_num;
          begin
            insert into calendar(calendar_sn,year_code,month_code,day_num,day_long_descr,day_short_descr,calendar_date) 
            values(calendar_sng.nextval,i.year_code,j.month_code,v_day_num,v_day_long_descr,v_day_short_descr,v_calendar_date);
            commit;
          exception
            when dup_val_on_index then
              update calendar
              set day_long_descr = v_day_long_descr
                  ,day_short_descr = v_day_short_descr
                  ,calendar_date = v_calendar_date
              where year_code = i.year_code
              and month_code = j.month_code
              and day_num = v_day_num
              ;
            when others then
              v_err_msg := SUBSTR (SQLERRM,1,1000);
              common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
          end;
        end loop;
      end loop;
    end loop;
  end load_calendar;
  --
  PROCEDURE load_LIST_APPL_FUNCTIONALITY
  is 
    cursor c_Cur is
    select 'GNRL' APPL_FUNCTIONALITY_CODE,'General' descr from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE,'Assessment' descr from dual
    ;
  BEGIN
    v_proc_name := upper('load_LIST_APPL_FUNCTIONALITY');
    for i in c_Cur loop
      v_error_rec := i.APPL_FUNCTIONALITY_CODE;
      begin
        INSERT INTO LIST_APPL_FUNCTIONALITY (APPL_FUNCTIONALITY_CODE
                                  ,descr
                               )
        VALUES (i.APPL_FUNCTIONALITY_CODE
              ,i.descr
               );
      exception 
        when dup_val_on_index then
          update LIST_APPL_FUNCTIONALITY
          set descr = i.descr
          where APPL_FUNCTIONALITY_CODE = i.APPL_FUNCTIONALITY_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_LIST_APPL_FUNCTIONALITY;
  --
  PROCEDURE load_LIST_MONTH_LANG
  is 
    cursor c_Cur is
    select '01' MONTH_CODE,'en' LANG_CODE,'January' descr,'JAN' short_descr from dual union
    select '02' MONTH_CODE,'en' LANG_CODE,'February' descr,'FEB' short_descr from dual union
    select '03' MONTH_CODE,'en' LANG_CODE,'March' descr,'MAR' short_descr from dual union
    select '04' MONTH_CODE,'en' LANG_CODE,'April' descr,'APR' short_descr from dual union
    select '05' MONTH_CODE,'en' LANG_CODE,'May' descr,'MAY' short_descr from dual union
    select '06' MONTH_CODE,'en' LANG_CODE,'June' descr,'JUN' short_descr from dual union
    select '07' MONTH_CODE,'en' LANG_CODE,'July' descr,'JUL' short_descr from dual union
    select '08' MONTH_CODE,'en' LANG_CODE,'August' descr,'AUG' short_descr from dual union
    select '09' MONTH_CODE,'en' LANG_CODE,'September' descr,'SEP' short_descr from dual union
    select '10' MONTH_CODE,'en' LANG_CODE,'October' descr,'OCT' short_descr from dual union
    select '11' MONTH_CODE,'en' LANG_CODE,'November' descr,'NOV' short_descr from dual union
    select '12' MONTH_CODE,'en' LANG_CODE,'December' descr,'DEC' short_descr from dual
    ;
  BEGIN
    v_proc_name := upper('load_LIST_MONTH_LANG');
    for i in c_Cur loop
      v_error_rec := i.MONTH_CODE;
      begin
        INSERT INTO LIST_MONTH_LANG (MONTH_LANG_SN
                                    ,MONTH_CODE
                                    ,LANG_CODE
                                    ,DESCR
                                    ,short_descr
                               )
        VALUES                      (MONTH_LANG_SNG.nextval
                                    ,i.MONTH_CODE
                                    ,i.LANG_CODE
                                    ,i.DESCR
                                    ,i.short_descr
                                    );
      exception 
        when dup_val_on_index then
          update LIST_MONTH_LANG
          set DESCR = i.DESCR
              ,short_descr = i.short_descr
          where MONTH_CODE = i.MONTH_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_LIST_MONTH_LANG;
  --
  PROCEDURE load_LIST_MONTH
  is 
    cursor c_Cur is
    select '01' MONTH_CODE from dual union
    select '02' MONTH_CODE from dual union
    select '03' MONTH_CODE from dual union
    select '04' MONTH_CODE from dual union
    select '05' MONTH_CODE from dual union
    select '06' MONTH_CODE from dual union
    select '07' MONTH_CODE from dual union
    select '08' MONTH_CODE from dual union
    select '09' MONTH_CODE from dual union
    select '10' MONTH_CODE from dual union
    select '11' MONTH_CODE from dual union
    select '12' MONTH_CODE from dual
    ;
  BEGIN
    v_proc_name := upper('load_LIST_MONTH');
    for i in c_Cur loop
      v_error_rec := i.MONTH_CODE;
      begin
        INSERT INTO LIST_MONTH (MONTH_CODE
                               )
        VALUES (i.MONTH_CODE
               );
      exception 
        when dup_val_on_index then
          NULL;
--          update LIST_MONTH
--          set APPLICATION_CODE = i.APPLICATION_CODE
--          where LIST_MONTH_CODE = i.LIST_MONTH_CODE
--          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_LIST_MONTH;
  --
  PROCEDURE load_LIST_YEAR
  is 
    cursor c_Cur is
    select '2015' YEAR_CODE from dual union
    select '2016' YEAR_CODE from dual union
    select '2017' YEAR_CODE from dual union
    select '2018' YEAR_CODE from dual union
    select '2019' YEAR_CODE from dual union
    select '2020' YEAR_CODE from dual union
    select '2021' YEAR_CODE from dual union
    select '2022' YEAR_CODE from dual union
    select '2023' YEAR_CODE from dual union
    select '2024' YEAR_CODE from dual union
    select '2025' YEAR_CODE from dual union
    select '2026' YEAR_CODE from dual union
    select '2027' YEAR_CODE from dual union
    select '2028' YEAR_CODE from dual union
    select '2029' YEAR_CODE from dual union
    select '2030' YEAR_CODE from dual union
    select '2031' YEAR_CODE from dual union
    select '2032' YEAR_CODE from dual union
    select '2033' YEAR_CODE from dual union
    select '2034' YEAR_CODE from dual union
    select '2035' YEAR_CODE from dual union
    select '2036' YEAR_CODE from dual union
    select '2037' YEAR_CODE from dual union
    select '2038' YEAR_CODE from dual union
    select '2039' YEAR_CODE from dual union
    select '2040' YEAR_CODE from dual union
    select '2041' YEAR_CODE from dual union
    select '2042' YEAR_CODE from dual union
    select '2043' YEAR_CODE from dual union
    select '2044' YEAR_CODE from dual union
    select '2045' YEAR_CODE from dual union
    select '2046' YEAR_CODE from dual union
    select '2047' YEAR_CODE from dual union
    select '2048' YEAR_CODE from dual union
    select '2049' YEAR_CODE from dual union
    select '2050' YEAR_CODE from dual union
    select '2051' YEAR_CODE from dual union
    select '2052' YEAR_CODE from dual union
    select '2053' YEAR_CODE from dual union
    select '2054' YEAR_CODE from dual union
    select '2055' YEAR_CODE from dual union
    select '2056' YEAR_CODE from dual union
    select '2057' YEAR_CODE from dual union
    select '2058' YEAR_CODE from dual union
    select '2059' YEAR_CODE from dual union
    select '2060' YEAR_CODE from dual union
    select '2061' YEAR_CODE from dual union
    select '2062' YEAR_CODE from dual union
    select '2063' YEAR_CODE from dual union
    select '2064' YEAR_CODE from dual union
    select '2065' YEAR_CODE from dual union
    select '2066' YEAR_CODE from dual union
    select '2067' YEAR_CODE from dual union
    select '2068' YEAR_CODE from dual union
    select '2069' YEAR_CODE from dual union
    select '2070' YEAR_CODE from dual union
    select '2071' YEAR_CODE from dual union
    select '2072' YEAR_CODE from dual union
    select '2073' YEAR_CODE from dual union
    select '2074' YEAR_CODE from dual union
    select '2075' YEAR_CODE from dual union
    select '2076' YEAR_CODE from dual union
    select '2077' YEAR_CODE from dual union
    select '2078' YEAR_CODE from dual union
    select '2079' YEAR_CODE from dual union
    select '2080' YEAR_CODE from dual union
    select '2081' YEAR_CODE from dual union
    select '2082' YEAR_CODE from dual union
    select '2083' YEAR_CODE from dual union
    select '2084' YEAR_CODE from dual union
    select '2085' YEAR_CODE from dual union
    select '2086' YEAR_CODE from dual union
    select '2087' YEAR_CODE from dual union
    select '2088' YEAR_CODE from dual union
    select '2089' YEAR_CODE from dual union
    select '2090' YEAR_CODE from dual union
    select '2091' YEAR_CODE from dual union
    select '2092' YEAR_CODE from dual union
    select '2093' YEAR_CODE from dual union
    select '2094' YEAR_CODE from dual union
    select '2095' YEAR_CODE from dual union
    select '2096' YEAR_CODE from dual union
    select '2097' YEAR_CODE from dual union
    select '2098' YEAR_CODE from dual union
    select '2099' YEAR_CODE from dual union
    select '2100' YEAR_CODE from dual union
    select '2101' YEAR_CODE from dual union
    select '2102' YEAR_CODE from dual union
    select '2103' YEAR_CODE from dual union
    select '2104' YEAR_CODE from dual union
    select '2105' YEAR_CODE from dual union
    select '2106' YEAR_CODE from dual union
    select '2107' YEAR_CODE from dual union
    select '2108' YEAR_CODE from dual union
    select '2109' YEAR_CODE from dual union
    select '2110' YEAR_CODE from dual union
    select '2111' YEAR_CODE from dual union
    select '2112' YEAR_CODE from dual union
    select '2113' YEAR_CODE from dual union
    select '2114' YEAR_CODE from dual union
    select '2115' YEAR_CODE from dual
    ;
  BEGIN
    v_proc_name := upper('load_LIST_YEAR');
    for i in c_Cur loop
      v_error_rec := i.YEAR_CODE;
      begin
        INSERT INTO LIST_YEAR (YEAR_CODE
                               )
        VALUES (i.YEAR_CODE
               );
      exception 
        when dup_val_on_index then
          NULL;
--          update LIST_YEAR
--          set APPLICATION_CODE = i.APPLICATION_CODE
--          where LIST_YEAR_CODE = i.LIST_YEAR_CODE
--          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_LIST_YEAR;
  --
  PROCEDURE load_APPLICATION_EM_LANG
  is 
    cursor c_Cur is
    select '10001' APPLICATION_ERROR_MSG_CODE, 'System Error. Please contact customer support.' descr,null long_descr,'en' lang_code from dual union
    select '10002' APPLICATION_ERROR_MSG_CODE, 'Free trial period has expired.' descr,null long_descr,'en' lang_code from dual union
    select '10003' APPLICATION_ERROR_MSG_CODE, 'Welcome back.' descr,null long_descr,'en' lang_code from dual union
    select '10004' APPLICATION_ERROR_MSG_CODE, 'Please correct/update payment account information.' descr,null long_descr,'en' lang_code from dual union
    select '10005' APPLICATION_ERROR_MSG_CODE, 'Issue with payment account. Please contact account owner to update payment account information.' descr,null long_descr,'en' lang_code from dual union
    select '10006' APPLICATION_ERROR_MSG_CODE, 'Your are currently in Free Trial Period. Enjoy! We welcome any Feedback.' descr,null long_descr,'en' lang_code from dual union
    select '10007' APPLICATION_ERROR_MSG_CODE, 'Not a Valid User.' descr,null long_descr,'en' lang_code from dual
    ;
  BEGIN
    v_proc_name := upper('load_APPLICATION_EM_LANG');
    for i in c_Cur loop
      v_error_rec := i.APPLICATION_ERROR_MSG_CODE;
      begin
        INSERT INTO APPLICATION_ERROR_MSG_LANG (APPLICATION_ERROR_MSG_LANG_SN
                                                ,APPLICATION_ERROR_MSG_CODE
                                                ,LANG_CODE
                                                ,DESCR
                                                ,LONG_DESCR
                                           )
        VALUES (APPLICATION_ERROR_MSG_LANG_SNG.nextval
                ,i.APPLICATION_ERROR_MSG_CODE
                ,i.LANG_CODE
                ,i.DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update APPLICATION_ERROR_MSG_LANG
          set DESCR = i.DESCR
            ,LONG_DESCR = i.LONG_DESCR
          where APPLICATION_ERROR_MSG_CODE = i.APPLICATION_ERROR_MSG_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_APPLICATION_EM_LANG;
  --
  PROCEDURE load_APPLICATION_ERROR_MSG
  is 
    cursor c_Cur is
    select '10001' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10002' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10003' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10004' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10005' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10006' APPLICATION_ERROR_MSG_CODE, 'CNST' APPLICATION_CODE from dual union
    select '10007' APPLICATION_ERROR_MSG_CODE, 'CPMT' APPLICATION_CODE from dual 
    ;
  BEGIN
    v_proc_name := upper('load_APPLICATION_ERROR_MSG');
    for i in c_Cur loop
      v_error_rec := i.APPLICATION_ERROR_MSG_CODE;
      begin
        INSERT INTO APPLICATION_ERROR_MSG (APPLICATION_ERROR_MSG_CODE
                                           ,APPLICATION_CODE
                                           )
        VALUES (i.APPLICATION_ERROR_MSG_CODE
                ,i.APPLICATION_CODE
               );
      exception 
        when dup_val_on_index then
          update APPLICATION_ERROR_MSG
          set APPLICATION_CODE = i.APPLICATION_CODE
          where APPLICATION_ERROR_MSG_CODE = i.APPLICATION_ERROR_MSG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_APPLICATION_ERROR_MSG;
  --
--  PROCEDURE load_LIST_APPLICATION
--  is 
--    cursor c_Cur is
--    select CODE APPLICATION_CODE
--          ,DESCR
--          ,FILE_NAME
--          ,common_pkg.return_file_type(file_name) file_type_code
--          ,IMAGE
--    from list_application_xtl
--    ;
--  BEGIN
--    v_proc_name := upper('load_LIST_APPLICATION');
--    for i in c_Cur loop
--      v_error_rec := i.APPLICATION_CODE;
--      begin
--        INSERT INTO LIST_APPLICATION (DESCR
--                                           ,APPLICATION_CODE
--                                           ,IMAGE
--                                           ,FILE_NAME
--                                           ,FILE_TYPE_CODE
--                                           )
--        VALUES (i.DESCR
--                ,i.APPLICATION_CODE
--                ,i.IMAGE
--                ,i.FILE_NAME
--                ,i.FILE_TYPE_CODE
--               );
--      exception 
--        when dup_val_on_index then
--          update LIST_APPLICATION
--          set DESCR = i.DESCR
--             ,IMAGE = i.IMAGE
--             ,FILE_NAME = i.FILE_NAME
--             ,FILE_TYPE_CODE = i.FILE_TYPE_CODE
--          where APPLICATION_CODE = i.APPLICATION_CODE
--          ;
--        when others then
--          v_err_msg := SUBSTR (SQLERRM,1,1000);
--            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
--                                           ,v_proc_name --p_proc_name
--                                           ,'E' --p_err_severity_code
--                                           ,v_err_msg --p_err_msg
--                                           ,v_error_rec --p_notes
--                                           );
--      end;
--      if mod(c_Cur%rowcount,300) = 0 then
--        commit;
--      end if;
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END load_LIST_APPLICATION;
--  --
  PROCEDURE load_list_file_type
  is 
    cursor c_Cur is
    select 'JPEG' file_type_code, 'image/jpeg' file_content_type from dual union
    select 'JPE' file_type_code, 'image/jpeg' file_content_type from dual union
    select 'JPG' file_type_code, 'image/jpeg' file_content_type from dual union
    select 'TIFF' file_type_code, 'image/tiff' file_content_type from dual union
    select 'TIF' file_type_code, 'image/tiff' file_content_type from dual union
    select 'GIF' file_type_code, 'image/gif' file_content_type from dual union
    select 'PNG' file_type_code, 'image/png' file_content_type from dual union
    select 'BMP' file_type_code, 'image/bmp' file_content_type from dual union
    select 'PDF' file_type_code, 'application/pdf' file_content_type from dual union
    select 'CSV' file_type_code, 'text/csv' file_content_type from dual union
    select 'TXT' file_type_code, 'text/plain' file_content_type from dual union
    select 'HTM' file_type_code, 'text/html' file_content_type from dual union
    select 'HTML' file_type_code, 'text/html' file_content_type from dual union
    select 'XML' file_type_code, 'application/xml' file_content_type from dual union
    select 'MSG' file_type_code, 'application/vnd.ms-outlook' file_content_type from dual union
    select 'DOCX' file_type_code, 'Application/msword' file_content_type from dual union
    select 'DOC' file_type_code, 'Application/msword' file_content_type from dual union
    select 'XLSX' file_type_code, 'application/vnd.ms-excel' file_content_type from dual union
    select 'XLS' file_type_code, 'application/vnd.ms-excel' file_content_type from dual union
    select 'PPT' file_type_code, 'application/vnd.ms-powerpoint' file_content_type from dual union
    select 'PPTX' file_type_code, 'application/vnd.ms-powerpoint' file_content_type from dual union
    select 'XPS' file_type_code, 'application/vnd.ms-xpsdocument' file_content_type from dual union
    select 'RTF' file_type_code, 'application/rtf' file_content_type from dual union
    select 'ZIP' file_type_code, 'application/zip' file_content_type from dual
    ;
  BEGIN
    v_proc_name := upper('load_list_file_type');
    for i in c_Cur loop
      v_error_rec := i.file_type_code;
      begin
        INSERT INTO list_file_type(file_type_code
                                      ,file_content_type
                                      )
        VALUES (i.file_type_code
               ,i.file_content_type
               );
      exception 
        when dup_val_on_index then
          update list_file_type
          set file_content_type = i.file_content_type
          where file_type_code = i.file_type_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_list_file_type;
  --
  PROCEDURE load_LIST_ADDR_TYPE 
  is 
    cursor c_Cur is
    select 'BL' ADDR_TYPE_CODE, 'Billing' descr from dual
    union
    select 'VS' ADDR_TYPE_CODE, 'Visit' descr from dual
    union
    select 'PR' ADDR_TYPE_CODE, 'Personal' descr from dual
    union
    select 'ML' ADDR_TYPE_CODE, 'Mailing' descr from dual
    ;
  BEGIN
    v_proc_name := upper('load_LIST_ADDR_TYPE');
    for i in c_Cur loop
      v_error_rec := i.ADDR_TYPE_CODE;
      begin
        INSERT INTO LIST_ADDR_TYPE(ADDR_TYPE_CODE
                                      ,descr
                                      )
        VALUES (i.ADDR_TYPE_CODE
               ,i.descr
               );
      exception 
        when dup_val_on_index then
          update LIST_ADDR_TYPE
          set descr = i.descr
          where ADDR_TYPE_CODE = i.ADDR_TYPE_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20022,sqlerrm);
  END load_LIST_ADDR_TYPE;
  --
  PROCEDURE load_application_control 
  is 
    v_APPLICATION_CONTROL_SN APPLICATION_CONTROL.APPLICATION_CONTROL_SN%type;
    v_APPLICATION_NAME APPLICATION_CONTROL.APPLICATION_NAME%type;
    v_alpha_clob application_control_value.CONTROL_VALUE_CLOB%type;
  BEGIN
    v_proc_name := upper('load_application_control');
    --
    begin
      INSERT INTO application_control (APPLICATION_CONTROL_SN,APPLICATION_NAME,DESCRIPTION,EFF_DATE)
      VALUES (APPLICATION_CONTROL_SNG.nextval,'AWV','Annual Wellness Visit DATA',sysdate); 
      commit;
    exception
      when others then null;
    end;
    --
    begin
      begin
        v_APPLICATION_NAME := 'AWV';
        v_error_rec := v_APPLICATION_NAME;
        --
        select APPLICATION_CONTROL_SN
        into v_APPLICATION_CONTROL_SN
        from APPLICATION_CONTROL
        where application_name = v_APPLICATION_NAME
        ;
        INSERT INTO application_control_value (ACV_SN,APPLICATION_CONTROL_SN,CONTROL_VALUE_NAME,EFF_DATE)
        VALUES (acv_sng.nextval,v_APPLICATION_CONTROL_SN,'G0438_JSON',sysdate);
        commit;
      exception
        when dup_val_on_index then
          null;
      end;
      ----------------
      begin
        v_APPLICATION_NAME := 'AWV';
        v_error_rec := v_APPLICATION_NAME;
        --
        select APPLICATION_CONTROL_SN
        into v_APPLICATION_CONTROL_SN
        from APPLICATION_CONTROL
        where application_name = v_APPLICATION_NAME
        ;
        INSERT INTO application_control_value (ACV_SN,APPLICATION_CONTROL_SN,CONTROL_VALUE_NAME,EFF_DATE)
        VALUES (acv_sng.nextval,v_APPLICATION_CONTROL_SN,'COMMON_INFO_JSON',sysdate);
        commit;
      exception
        when dup_val_on_index then
          null;
      end;      
      --
      begin
        INSERT INTO application_control (APPLICATION_CONTROL_SN,APPLICATION_NAME,DESCRIPTION,EFF_DATE)
        VALUES (APPLICATION_CONTROL_SNG.nextval,'CCM','Chronic Care Management DATA',sysdate); 
        commit;
      exception
        when others then null;
      end;
      ----------------
      begin
        v_APPLICATION_NAME := 'CCM';
        v_error_rec := v_APPLICATION_NAME;
        --
        select APPLICATION_CONTROL_SN
        into v_APPLICATION_CONTROL_SN
        from APPLICATION_CONTROL
        where application_name = v_APPLICATION_NAME
        ;
        INSERT INTO application_control_value (ACV_SN,APPLICATION_CONTROL_SN,CONTROL_VALUE_NAME,EFF_DATE,CONTROL_VALUE_ALPHA)
        VALUES (acv_sng.nextval,v_APPLICATION_CONTROL_SN,'CONTACT_NAME',sysdate,'I APP HEALTH CORP');
        commit;
      exception
        when dup_val_on_index then
          null;
      end;
      ----------------
      begin
        v_APPLICATION_NAME := 'CCM';
        v_error_rec := v_APPLICATION_NAME;
        --
        select APPLICATION_CONTROL_SN
        into v_APPLICATION_CONTROL_SN
        from APPLICATION_CONTROL
        where application_name = v_APPLICATION_NAME
        ;
        INSERT INTO application_control_value (ACV_SN,APPLICATION_CONTROL_SN,CONTROL_VALUE_NAME,EFF_DATE,CONTROL_VALUE_ALPHA)
        VALUES (acv_sng.nextval,v_APPLICATION_CONTROL_SN,'CONTACT_PH',sysdate,'888-888-8888');
        commit;
      exception
        when dup_val_on_index then
          null;
      end;
      ----------------
      begin
        v_APPLICATION_NAME := 'CCM';
        v_error_rec := v_APPLICATION_NAME;
        --
        select APPLICATION_CONTROL_SN
        into v_APPLICATION_CONTROL_SN
        from APPLICATION_CONTROL
        where application_name = v_APPLICATION_NAME
        ;
        INSERT INTO application_control_value (ACV_SN,APPLICATION_CONTROL_SN,CONTROL_VALUE_NAME,EFF_DATE,CONTROL_VALUE_ALPHA)
        VALUES (acv_sng.nextval,v_APPLICATION_CONTROL_SN,'CONTACT_ADDR',sysdate,'10340 NW 48th CT, Coral Springs, FL 33076');
        commit;
      exception
        when dup_val_on_index then
          null;
      end;
    exception 
      when dup_val_on_index then
        null;
      when others then
        v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
    end;
    --
  exception
    when others then
      raise_application_error(-20018,sqlerrm);
  END load_application_control;
  --
  PROCEDURE load_appsnetroles is 
    cursor c_Cur is
    select 'a74f52c5-4d3a-46d9-bc22-a5eafa982849' id,'Prospective User' name,'N' service_provider_flag from dual union
    select '624B26BD08D20FECE0530100007F5ACE' id,'Inactive User' name,'N' service_provider_flag from dual union
    select '79F450777D2E4B6AB98FECB17974FDEB' id,'Service Provider' name,'Y' service_provider_flag from dual union
    select '3951E214B3F746BD924AFF39CABEA511' id,'Service Provider Lead' name,'Y' service_provider_flag from dual union
    select 'DF56C6ED00FF47AC84754BDF1517FB83' id,'Primary Provider' name,'Y' service_provider_flag from dual union
    select '22F1493D8E914982A6C5532EDBD516FE' id,'Data Entry' name,'N' service_provider_flag from dual union
    select '943DF69DD1744FA2BED92A55C2800C57' id,'Office Admin' name,'N' service_provider_flag from dual union
    select '96A384F7D6324738A4F192AD132D3B79' id,'Admin and Service Provider' name,'Y' service_provider_flag from dual union
    select 'FE10783F05FB44A2AC0FD37F1E63AD76' id,'Super Admin' name,'Y' service_provider_flag from dual
    ;
  BEGIN
    v_proc_name := upper('load_appsnetroles');
    for i in c_Cur loop
      v_error_rec := i.id||'-'||i.name;
      begin
        INSERT INTO "AspNetRoles"("Id","Name",service_provider_flag) 
        VALUES (i.id,i.name,i.service_provider_flag);
        COMMIT;
      exception 
        when dup_val_on_index then
          update "AspNetRoles"
          set "Name" = i.name
            ,service_provider_flag = i.service_provider_flag
          where "Id" = i.id
          ;
          COMMIT;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
    
      end;
      --
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  END load_appsnetroles;
  --
  PROCEDURE load_TRANS_lang (p_culture IN TRANS_LANG.CULTURE%type
                               ,p_name IN TRANS_LANG.name%type
                               ,p_value IN nvarchar2
                               )
  is 
    v_value TRANS_LANG.value%type := p_value;
  BEGIN
    v_proc_name := upper('load_TRANS_lang');
    v_error_rec := p_culture||'-'||p_name;
    begin
      INSERT INTO TRANS_LANG(NAME,VALUE,CULTURE) 
      VALUES (upper(p_name),v_value,p_culture);
      COMMIT;
    exception 
      when dup_val_on_index then
        update TRANS_LANG
        set value = v_value
        where name = upper(p_name)
        and culture = p_culture
        ;
        COMMIT;
      when others then
        v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
    end; 
  END load_TRANS_lang;
  --
  procedure upd_COUNTRY_ALT_NAME is
    cursor c_Cur is
    select CAN.COUNTRY_ALT_NAME_SN
    from country_pref_lang_vw cpl
        ,country_alt_name can
    where can.country_code = cpl.country_code
    and CAN.LANG_CODE = CPL.LANG_CODE    
    ;
    cursor c_Cur2 is
    select distinct CAN.COUNTRY_CODE
    from country_alt_name can
    where primary_lang_ind is null
    and CAN.COUNTRY_CODE not in (select distinct country_code
                                from country_alt_name
                                where primary_lang_ind = 'P'
                                )
    ;
  begin
    v_proc_name := upper('upd_COUNTRY_ALT_NAME');
    for i in c_Cur loop
      v_error_rec := i.COUNTRY_ALT_NAME_SN;
      
      update COUNTRY_ALT_NAME
      set primary_lang_ind = 'P'
      where COUNTRY_ALT_NAME_SN = i.COUNTRY_ALT_NAME_SN
      ;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
    for j in c_Cur2 loop
      update COUNTRY_ALT_NAME
      set primary_lang_ind = 'N'
      where country_code = j.country_code
      and rownum = 1
      ;
      commit;
    end loop;
    update COUNTRY_ALT_NAME
    set primary_lang_ind = 'X'
    where primary_lang_ind is null
    ;
    commit;
  exception
    when others then
      raise_application_error(-20014,sqlerrm);
  end upd_COUNTRY_ALT_NAME;
  --
  procedure load_COUNTRY_ALT_NAME is
    cursor c_Cur is
    select C.iso COUNTRY_CODE
          ,LL.LANG_CODE
          ,AN.ALTERNATE_NAME ALT_NAME
          ,decode(an.ISPREFERREDNAME,'1','Y','N') PREFERRED_NAME_FLAG
          ,decode(an.ISSHORTNAME,'1','Y','N') SHORT_NAME_FLAG
          ,decode(an.ISCOLLOQUIAL,'1','Y','N') COLLOQUIAL_FLAG
          ,decode(an.ISHISTORIC,'1','Y','N') HISTORIC_FLAG
    from country_stg c
        ,alternate_name_stg an
        ,list_lang ll
    where C.GEONAMEID = AN.GEONAMEID
    and AN.ISOLANGUAGE = LL.LANG_CODE
    ;
  begin
    v_proc_name := upper('load_COUNTRY_ALT_NAME');
    for i in c_Cur loop
      v_error_rec := i.COUNTRY_CODE||'-'||i.LANG_CODE;
      begin
        insert into COUNTRY_ALT_NAME
              (COUNTRY_ALT_NAME_SN
              ,PREFERRED_NAME_FLAG
              ,SHORT_NAME_FLAG
              ,COLLOQUIAL_FLAG
              ,HISTORIC_FLAG
              ,COUNTRY_CODE
              ,LANG_CODE
              ,ALT_NAME
              )
        values
              (COUNTRY_ALT_NAME_SNG.nextval
              ,i.PREFERRED_NAME_FLAG
              ,i.SHORT_NAME_FLAG
              ,i.COLLOQUIAL_FLAG
              ,i.HISTORIC_FLAG
              ,i.COUNTRY_CODE
              ,i.LANG_CODE
              ,i.ALT_NAME
              );
      exception
        when dup_val_on_index then
          update COUNTRY_ALT_NAME
          set PREFERRED_NAME_FLAG = i.PREFERRED_NAME_FLAG
              ,SHORT_NAME_FLAG = i.SHORT_NAME_FLAG
              ,COLLOQUIAL_FLAG = i.COLLOQUIAL_FLAG
              ,HISTORIC_FLAG = i.HISTORIC_FLAG
              ,ALT_NAME = i.ALT_NAME
          where COUNTRY_CODE = i.COUNTRY_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20014,sqlerrm);
  end load_COUNTRY_ALT_NAME;
  --
  procedure load_continent_alt_name is
    cursor c_Cur is
    select C.CONTINENT_CODE
          ,LL.LANG_CODE
          ,AN.ALTERNATE_NAME ALT_NAME
          ,decode(an.ISPREFERREDNAME,'1','Y','N') PREFERRED_NAME_FLAG
          ,decode(an.ISSHORTNAME,'1','Y','N') SHORT_NAME_FLAG
          ,decode(an.ISCOLLOQUIAL,'1','Y','N') COLLOQUIAL_FLAG
          ,decode(an.ISHISTORIC,'1','Y','N') HISTORIC_FLAG
    from continent_stg c
        ,country_city_stg cc
        ,alternate_name_stg an
        ,list_lang ll
    where C.GEONAMEID = CC.GEONAMEID
    and C.GEONAMEID = AN.GEONAMEID
    and AN.ISOLANGUAGE = LL.LANG_CODE
    ;
  begin
    v_proc_name := upper('load_continent_alt_name');
    for i in c_Cur loop
      v_error_rec := i.CONTINENT_CODE||'-'||i.LANG_CODE;
      begin
        insert into continent_alt_name
              (CONTINENT_ALT_NAME_SN
              ,PREFERRED_NAME_FLAG
              ,SHORT_NAME_FLAG
              ,COLLOQUIAL_FLAG
              ,HISTORIC_FLAG
              ,CONTINENT_CODE
              ,LANG_CODE
              ,ALT_NAME
              )
        values
              (continent_alt_name_SNG.nextval
              ,i.PREFERRED_NAME_FLAG
              ,i.SHORT_NAME_FLAG
              ,i.COLLOQUIAL_FLAG
              ,i.HISTORIC_FLAG
              ,i.CONTINENT_CODE
              ,i.LANG_CODE
              ,i.ALT_NAME
              );
      exception
        when dup_val_on_index then
          update continent_alt_name
          set PREFERRED_NAME_FLAG = i.PREFERRED_NAME_FLAG
              ,SHORT_NAME_FLAG = i.SHORT_NAME_FLAG
              ,COLLOQUIAL_FLAG = i.COLLOQUIAL_FLAG
              ,HISTORIC_FLAG = i.HISTORIC_FLAG
              ,ALT_NAME = i.ALT_NAME
          where CONTINENT_CODE = i.CONTINENT_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20013,sqlerrm);
  end load_continent_alt_name;
  --
  procedure load_POSTAL is
    cursor c_Cur is
    select CT.CITY_SN
      ,ct.name city_name
      ,st.name state_name
      ,cp.POSTAL_CODE
      ,nvl(cp.ADMIN_NAME3,ADMIN_NAME2) county_name
      ,cp.LATITUDE
      ,cp.LONGITUDE
    from country_postal_code_stg cp
        ,state st
        ,city ct
    where ST.STATE_SN = CT.STATE_SN
    and upper(ct.name) = upper(CP.PLACE_NAME)
    and st.COUNTRY_CODE = CP.COUNTRY_CODE
    and upper(st.name) = upper(nvl(CP.ADMIN_NAME1,CP.ADMIN_NAME2))
    ;
  begin
    v_proc_name := upper('load_POSTAL');
    for i in c_Cur loop
      v_error_rec := i.CITY_SN||'-'||i.POSTAL_CODE;
      begin
        insert into POSTAL
              (POSTAL_SN
              ,COUNTY_NAME
              ,LATITUDE
              ,LONGITUDE
              ,CITY_SN
              ,POSTAL_CODE
              )
        values
              (POSTAL_SNG.nextval
              ,i.COUNTY_NAME
              ,i.LATITUDE
              ,i.LONGITUDE
              ,i.CITY_SN
              ,i.POSTAL_CODE
              );
      exception
        when dup_val_on_index then
          update POSTAL
          set  COUNTY_NAME = i.COUNTY_NAME
              ,LATITUDE = i.LATITUDE
              ,LONGITUDE = i.LONGITUDE
          where CITY_SN = i.CITY_SN
          and POSTAL_CODE = i.POSTAL_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20012,sqlerrm);
  end load_POSTAL;
  --
  procedure load_LIST_TIMEZONE is
    cursor c_Cur is
    select TIME_ZONE_ID DESCR
          ,GMT_OFFSET_1_JAN_2015 GMT_OFFSET
          ,DST_OFFSET_1_JUL_2015 DST_OFFSET
          ,RAW_OFFSET_IND_OF_DST RAW_OFFSET
    from time_zone_stg
    ;
    v_num number(9) := 100;
  begin
    v_proc_name := upper('load_LIST_TIMEZONE');
    for i in c_Cur loop
      v_num := v_num + 1;
      v_error_rec := i.DESCR;
      begin
        insert into LIST_TIMEZONE
              (TIMEZONE_CODE
              ,DESCR
              ,GMT_OFFSET
              ,DST_OFFSET
              ,RAW_OFFSET
              )
        values
              (v_num
              ,i.DESCR
              ,i.GMT_OFFSET
              ,i.DST_OFFSET
              ,i.RAW_OFFSET
              );
      exception
        when dup_val_on_index then
          update LIST_TIMEZONE
          set DESCR = i.DESCR
              ,GMT_OFFSET = i.GMT_OFFSET
              ,DST_OFFSET = i.DST_OFFSET
              ,RAW_OFFSET = i.RAW_OFFSET
          where TIMEZONE_CODE = v_num
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20011,sqlerrm);
  end load_LIST_TIMEZONE;
  --
  procedure load_CITY is
    cursor c_Cur is
    select 
      cc.LATITUDE
      ,CC.LONGITUDE
      ,CC.ELEVATION ELEV_IN_M
      ,CC.DEM DIG_ELEV_MODEL_IN_M
      ,to_date(CC.MODIFICATION_DATE,'YYYY-MM-DD') MODIFICATION_DATE
      ,cc.ASCIINAME name
      ,cc.POPULATION
      ,st.state_sn
      ,st.STATE_CODE
      ,llt.LOCATION_TYPE_CODE
      ,LT.TIMEZONE_CODE
    from state st
        ,COUNTRY_city_stg cc
        ,list_location_type llt
        ,LIST_TIMEZONE lt
    where cc.country_code = st.country_code
    and cc.ADMIN1_CODE = st.state_code
    and cc.FEATURE_CLASS||'.'||cc.FEATURE_CODE = llt.LOCATION_TYPE_CODE
    and CC.time_zone = LT.DESCR
    --and st.COUNTRY_CODE = 'BD'
    ;
  begin
    v_proc_name := upper('load_CITY');
    for i in c_Cur loop
      v_error_rec := i.state_code||'-'||i.name;
        --
        begin
          insert into CITY
                (CITY_SN
                ,STATE_SN
                ,NAME
                ,LOCATION_TYPE_CODE
                ,TIMEZONE_CODE
                ,LATITUDE
                ,LONGITUDE
                ,POPULATION
                ,ELEV_IN_M
                ,DIG_ELEV_MODEL_IN_M
                ,MODIFICATION_DATE
                )
          values
                (CITY_SNG.nextval
                ,i.STATE_SN
                ,i.NAME
                ,i.LOCATION_TYPE_CODE
                ,i.TIMEZONE_CODE
                ,i.LATITUDE
                ,i.LONGITUDE
                ,i.POPULATION
                ,i.ELEV_IN_M
                ,i.DIG_ELEV_MODEL_IN_M
                ,i.MODIFICATION_DATE
                );
        exception
          when dup_val_on_index then
            update CITY
            set  LOCATION_TYPE_CODE = i.LOCATION_TYPE_CODE
                ,TIMEZONE_CODE = i.TIMEZONE_CODE
                ,LATITUDE = i.LATITUDE
                ,LONGITUDE = i.LONGITUDE
                ,POPULATION = i.POPULATION
                ,ELEV_IN_M = i.ELEV_IN_M
                ,DIG_ELEV_MODEL_IN_M = i.DIG_ELEV_MODEL_IN_M
                ,MODIFICATION_DATE = i.MODIFICATION_DATE
            where STATE_SN = i.STATE_SN
            and NAME = i.NAME
            ;
          when others then
            v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
        end;
        if mod(c_Cur%rowcount,300) = 0 then
          commit;
        end if;
      end loop;
    commit;
  exception
    when others then
      raise_application_error(-20010,sqlerrm);
  end load_CITY;
  --
  procedure load_STATE is
    cursor c_Country is
    select country_code
    from country
    --where country_code = 'US'
    ;
    cursor c_Cur (p_country_code in country.country_code%type) is
    select cc.LATITUDE
      ,CC.LONGITUDE
      ,CC.ELEVATION ELEV_IN_M
      ,CC.DEM DIG_ELEV_MODEL_IN_M
      ,to_date(CC.MODIFICATION_DATE,'YYYY-MM-DD') MODIFICATION_DATE
      ,c2.COUNTRY_CODE
      ,cc.ADMIN1_CODE state_code
      ,cc.ASCIINAME name
      ,cc.POPULATION
    from COUNTRY_city_stg cc
        ,COUNTRY_STG c1
        ,country c2
        ,hierarchy_stg h
        ,admin1_code_ascii_stg adm
    where c1.GEONAMEID = h.PARENT_ID 
    and cc.GEONAMEID = h.CHILD_ID
    and c1.iso = c2.COUNTRY_CODE
    and cc.GEONAMEID = adm.GEONAMEID
    and c1.ISO = upper(p_country_code)
    ;
    v_MEASUREMENT_CODE list_MEASUREMENT.MEASUREMENT_CODE%type;
  begin
    v_proc_name := upper('load_STATE');
    for j in c_Country loop
      for i in c_Cur (j.country_code) loop
        v_error_rec := i.country_code||'-'||i.STATE_CODE;
        --
        begin
          insert into STATE
                (STATE_SN
                ,DIG_ELEV_MODEL_IN_M
                ,MODIFICATION_DATE
                ,COUNTRY_CODE
                ,STATE_CODE
                ,NAME
                ,LATITUDE
                ,LONGITUDE
                ,POPULATION
                ,ELEV_IN_M
                )
          values
                (STATE_SNG.nextval
                ,i.DIG_ELEV_MODEL_IN_M
                ,i.MODIFICATION_DATE
                ,i.COUNTRY_CODE
                ,i.STATE_CODE
                ,i.NAME
                ,i.LATITUDE
                ,i.LONGITUDE
                ,i.POPULATION
                ,i.ELEV_IN_M
                );
        exception
          when dup_val_on_index then
            update STATE
            set DIG_ELEV_MODEL_IN_M = i.DIG_ELEV_MODEL_IN_M
                ,MODIFICATION_DATE = i.MODIFICATION_DATE
                ,NAME = i.NAME
                ,LATITUDE = i.LATITUDE
                ,LONGITUDE = i.LONGITUDE
                ,POPULATION = i.POPULATION
                ,ELEV_IN_M = i.ELEV_IN_M
            where COUNTRY_CODE = i.COUNTRY_CODE
            and STATE_CODE = i.STATE_CODE
            ;
          when others then
            v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                           ,v_proc_name --p_proc_name
                                           ,'E' --p_err_severity_code
                                           ,v_err_msg --p_err_msg
                                           ,v_error_rec --p_notes
                                           );
        end;
        if mod(c_Cur%rowcount,300) = 0 then
          commit;
        end if;
      end loop;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20008,sqlerrm);
  end load_STATE;
  --
  procedure load_COUNTRY_LANG is
    cursor c_Cur is
    select c.ISO COUNTRY_CODE
        ,c.LANGUAGES
        ,decode(REGEXP_COUNT(c.LANGUAGES,',',1,'i'),0,substr(c.LANGUAGES,1,2),c.LANGUAGES) lang_code
        ,REGEXP_COUNT(c.LANGUAGES,',',1,'i') loop_cnt
    from country_stg c
        ,country cc
    where C.iso = cc.COUNTRY_CODE
    --and Cc.COUNTRY_CODE in ('HM')
    and c.LANGUAGES is not null
    ;
    v_str varchar2(3000);
    v_lang_code varchar2(3000);
    v_pos number(9);
    v_start_pos number(9);
    v_end_pos number(9);
    v_COUNTRY_LANG COUNTRY_LANG%rowtype;
    --
    procedure ins_upd (p_COUNTRY_LANG COUNTRY_LANG%rowtype) as
    begin
            insert into COUNTRY_LANG
                    (COUNTRY_LANG_SN
                    ,PRIMARY_LANG_FLAG
                    ,COUNTRY_CODE
                    ,LANG_CODE
                    )
            values
                    (COUNTRY_LANG_SNG.nextval
                    ,p_COUNTRY_LANG.PRIMARY_LANG_FLAG
                    ,p_COUNTRY_LANG.COUNTRY_CODE
                    ,p_COUNTRY_LANG.lang_code
                    );
    exception
         when dup_val_on_index then
                update COUNTRY_LANG
                set PRIMARY_LANG_FLAG = p_COUNTRY_LANG.PRIMARY_LANG_FLAG
                where COUNTRY_CODE = p_COUNTRY_LANG.COUNTRY_CODE
                and LANG_CODE = p_COUNTRY_LANG.lang_code
                ;
          when others then
                v_err_msg := SUBSTR (SQLERRM,1,1000);
                common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                               ,v_proc_name --p_proc_name
                                               ,'E' --p_err_severity_code
                                               ,v_err_msg --p_err_msg
                                               ,v_error_rec --p_notes
                                               );
    end ins_upd;
  begin
    v_proc_name := upper('load_COUNTRY_LANG');
    for i in c_Cur loop
      v_error_rec := i.COUNTRY_CODE;
      --
      v_COUNTRY_LANG.COUNTRY_CODE := i.COUNTRY_CODE;
      --data initialization
      v_str := null;
      v_lang_code := null;
      v_start_pos := 0;
      v_end_pos := 0;
      v_pos := 1;
      --
      --find max occurance of comma by looping through 50 times. max occur should not be more than 30
      --
      if i.loop_cnt > 0 then
        for j in 1..i.loop_cnt loop
            v_start_pos := v_pos;
            v_end_pos := instr(i.LANGUAGES,',',1,j) - v_start_pos;
            v_str := substr(i.LANGUAGES,v_start_pos,v_end_pos);
            v_pos := instr(i.LANGUAGES,',',1,j) + 1;
            --dbms_output.put_line('pos: '||v_start_pos||'-'||v_end_pos||'-'||v_pos);
            --
            --check if the v_str have -. If it has "-", then it's a primary lang
            if instr(v_str,'-',1,1) > 0 then
              v_COUNTRY_LANG.PRIMARY_LANG_FLAG := 'Y';
              v_lang_code := substr(v_str,1,2);
            else --0 mean no "-"
              v_COUNTRY_LANG.PRIMARY_LANG_FLAG := 'N';
              v_lang_code := v_str; --lang code could be 3. load only 2
            end if;
            --
            if length(trim(v_lang_code)) = 2 then
              v_COUNTRY_LANG.lang_code := v_lang_code;
              ins_upd(v_COUNTRY_LANG);
            end if;
            --dbms_output.put_line('v_str: '||v_str);
            --
            if j = i.loop_cnt then
              --make additional call for last substr
              v_start_pos := v_pos;
              v_str := substr(i.LANGUAGES,v_start_pos);
              --
              if instr(v_str,'-',1,1) > 0 then
                v_COUNTRY_LANG.PRIMARY_LANG_FLAG := 'Y';
                v_lang_code := substr(v_str,1,2);
              else --0 mean no "-"
                v_COUNTRY_LANG.PRIMARY_LANG_FLAG := 'N';
                v_lang_code := v_str; --lang code could be 3. load only 2
              end if;
              --
              if length(trim(v_lang_code)) = 2 then
                v_COUNTRY_LANG.lang_code := v_lang_code;
                ins_upd(v_COUNTRY_LANG);
              end if;
              --dbms_output.put_line('v_str: '||v_str);
            end if;
            
        end loop;
      else --loop_cnt = 0
        v_COUNTRY_LANG.lang_code := i.lang_code;
        v_COUNTRY_LANG.PRIMARY_LANG_FLAG := 'Y';
        if length(trim(v_lang_code)) = 2 then
          ins_upd(v_COUNTRY_LANG);
        end if;
        --dbms_output.put_line('v_str in zero: '||i.lang_code);
      end if;
      --
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20009,sqlerrm);
  end load_COUNTRY_LANG;
  --
  procedure load_COUNTRY is
    cursor c_Cur is
    select c.ISO COUNTRY_CODE
      ,con.CONTINENT_CODE
      ,c.CURRENCY_CODE
      ,c.ISO3 COUNTRY_CODE_ISO3
      ,c.ISO_NUMERIC COUNTRY_CODE_ISO_NUMERIC
      ,c.FIPS COUNTRY_CODE_FIPS
      ,decode(c.ISO,'CD','Congo (DRC)','CG','Congo (Republic)','PS','Palestinian',c.COUNTRY) NAME
      ,c.CAPITAL CAPITAL_NAME
      ,c.AREA_SQ_KM
      ,c.POPULATION
      ,c.TLD
      ,c.CURRENCY_NAME
      ,case 
        when trim(c.PHONE) is not null and substr(c.phone,1,1) = '+' then c.phone
        when trim(c.PHONE) is not null and substr(c.phone,1,1) <> '+' then '+'||c.phone
        else trim(c.phone)
       end PHONE_COUNTRY_CODE
      ,c.POSTAL_CODE_FORMAT
      ,c.POSTAL_CODE_REGEX
      ,c.LANGUAGES
      ,c.NEIGHBOURS
      ,c.EQUIVALENT_FIPS_CODE
      ,cf.FILE_NAME_16 FLAG_IMAGE_FILE_NAME_16
      ,cf.COUNTRY_FLAG_IMAGE_16 FLAG_IMAGE_16
      ,cf.FILE_NAME_24 FLAG_IMAGE_FILE_NAME_24
      ,cf.COUNTRY_FLAG_IMAGE_24 FLAG_IMAGE_24
      ,cf.FILE_NAME_32 FLAG_IMAGE_FILE_NAME_32
      ,cf.COUNTRY_FLAG_IMAGE_32 FLAG_IMAGE_32
      ,cf.FILE_NAME_48 FLAG_IMAGE_FILE_NAME_48
      ,cf.COUNTRY_FLAG_IMAGE_48 FLAG_IMAGE_48
      ,cf.FILE_NAME_64 FLAG_IMAGE_FILE_NAME_64
      ,cf.COUNTRY_FLAG_IMAGE_64 FLAG_IMAGE_64
      ,ss.GEOJSON
      --
      ,cc.CC2 ALT_COUNTRY_CODE
      ,cc.LATITUDE
      ,CC.LONGITUDE
      ,CC.ELEVATION ELEV_IN_M
      ,CC.DEM DIG_ELEV_MODEL_IN_M
      ,to_date(CC.MODIFICATION_DATE,'YYYY-MM-DD') MODIFICATION_DATE
    from country_stg c
        ,country_city_stg cc
        ,CONTINENT con
        ,country_flag_stg cf
        ,shapes_simplified_low_stg ss
    where C.GEONAMEID = CC.GEONAMEID
    and c.CONTINENT_CODE = con.CONTINENT_CODE
    and c.iso = cf.COUNTRY_CODE(+)
    and C.GEONAMEID = ss.GEONAMEID (+)
    ;
    v_MEASUREMENT_CODE list_MEASUREMENT.MEASUREMENT_CODE%type;
  begin
    v_proc_name := upper('load_COUNTRY');
    for i in c_Cur loop
      v_error_rec := i.COUNTRY_CODE;
      --
      if i.COUNTRY_CODE = 'US' then
        v_MEASUREMENT_CODE := 'CS';
      elsif i.COUNTRY_CODE = 'BM' then
        v_MEASUREMENT_CODE := 'BS';
      elsif i.COUNTRY_CODE = 'LI' then
        v_MEASUREMENT_CODE := 'NS';
      else
        v_MEASUREMENT_CODE := 'MS';
      end if;
        
      begin
        insert into COUNTRY
              (COUNTRY_CODE
              ,CONTINENT_CODE
              ,MEASUREMENT_CODE
              ,CURRENCY_CODE
              ,COUNTRY_CODE_ISO3
              ,COUNTRY_CODE_ISO_NUMERIC
              ,COUNTRY_CODE_FIPS
              ,NAME
              ,CAPITAL_NAME
              ,AREA_SQ_KM
              ,TLD
              ,PHONE_COUNTRY_CODE
              ,POSTAL_CODE_FORMAT
              ,POSTAL_CODE_REGEX
              ,NEIGHBOURS
              ,EQUIVALENT_FIPS_CODE
              ,FLAG_IMAGE_FILE_NAME_16
              ,FLAG_IMAGE_16
              ,FLAG_IMAGE_FILE_NAME_24
              ,FLAG_IMAGE_24
              ,FLAG_IMAGE_FILE_NAME_32
              ,FLAG_IMAGE_32
              ,FLAG_IMAGE_FILE_NAME_48
              ,FLAG_IMAGE_48
              ,FLAG_IMAGE_FILE_NAME_64
              ,FLAG_IMAGE_64
              ,GEOJSON
              ,LATITUDE
              ,LONGITUDE
              ,ALT_COUNTRY_CODE
              ,POPULATION
              ,ELEV_IN_M
              ,DIG_ELEV_MODEL_IN_M
              ,MODIFICATION_DATE
              )
        values
              (i.COUNTRY_CODE
              ,i.CONTINENT_CODE
              ,v_MEASUREMENT_CODE
              ,i.CURRENCY_CODE
              ,i.COUNTRY_CODE_ISO3
              ,i.COUNTRY_CODE_ISO_NUMERIC
              ,i.COUNTRY_CODE_FIPS
              ,i.NAME
              ,i.CAPITAL_NAME
              ,i.AREA_SQ_KM
              ,i.TLD
              ,i.PHONE_COUNTRY_CODE
              ,i.POSTAL_CODE_FORMAT
              ,i.POSTAL_CODE_REGEX
              ,i.NEIGHBOURS
              ,i.EQUIVALENT_FIPS_CODE
              ,i.FLAG_IMAGE_FILE_NAME_16
              ,i.FLAG_IMAGE_16
              ,i.FLAG_IMAGE_FILE_NAME_24
              ,i.FLAG_IMAGE_24
              ,i.FLAG_IMAGE_FILE_NAME_32
              ,i.FLAG_IMAGE_32
              ,i.FLAG_IMAGE_FILE_NAME_48
              ,i.FLAG_IMAGE_48
              ,i.FLAG_IMAGE_FILE_NAME_64
              ,i.FLAG_IMAGE_64
              ,i.GEOJSON
              ,i.LATITUDE
              ,i.LONGITUDE
              ,i.ALT_COUNTRY_CODE
              ,i.POPULATION
              ,i.ELEV_IN_M
              ,i.DIG_ELEV_MODEL_IN_M
              ,i.MODIFICATION_DATE
              );
      exception
        when dup_val_on_index then
          update COUNTRY
          set CONTINENT_CODE = i.CONTINENT_CODE
              ,MEASUREMENT_CODE = v_MEASUREMENT_CODE
              ,CURRENCY_CODE = i.CURRENCY_CODE
              ,COUNTRY_CODE_ISO3 = i.COUNTRY_CODE_ISO3
              ,COUNTRY_CODE_ISO_NUMERIC = i.COUNTRY_CODE_ISO_NUMERIC
              ,COUNTRY_CODE_FIPS = i.COUNTRY_CODE_FIPS
              ,NAME = i.NAME
              ,CAPITAL_NAME = i.CAPITAL_NAME
              ,AREA_SQ_KM = i.AREA_SQ_KM
              ,TLD = i.TLD
              ,PHONE_COUNTRY_CODE = i.PHONE_COUNTRY_CODE
              ,POSTAL_CODE_FORMAT = i.POSTAL_CODE_FORMAT
              ,POSTAL_CODE_REGEX = i.POSTAL_CODE_REGEX
              ,NEIGHBOURS = i.NEIGHBOURS
              ,EQUIVALENT_FIPS_CODE = i.EQUIVALENT_FIPS_CODE
              ,FLAG_IMAGE_FILE_NAME_16 = i.FLAG_IMAGE_FILE_NAME_16
              ,FLAG_IMAGE_16 = i.FLAG_IMAGE_16
              ,FLAG_IMAGE_FILE_NAME_24 = i.FLAG_IMAGE_FILE_NAME_24
              ,FLAG_IMAGE_24 = i.FLAG_IMAGE_24
              ,FLAG_IMAGE_FILE_NAME_32 = i.FLAG_IMAGE_FILE_NAME_32
              ,FLAG_IMAGE_32 = i.FLAG_IMAGE_32
              ,FLAG_IMAGE_FILE_NAME_48 = i.FLAG_IMAGE_FILE_NAME_48
              ,FLAG_IMAGE_48 = i.FLAG_IMAGE_48
              ,FLAG_IMAGE_FILE_NAME_64 = i.FLAG_IMAGE_FILE_NAME_64
              ,FLAG_IMAGE_64 = i.FLAG_IMAGE_64
              ,GEOJSON = i.GEOJSON
              ,LATITUDE = i.LATITUDE
              ,LONGITUDE = i.LONGITUDE
              ,ALT_COUNTRY_CODE = i.ALT_COUNTRY_CODE
              ,POPULATION = i.POPULATION
              ,ELEV_IN_M = i.ELEV_IN_M
              ,DIG_ELEV_MODEL_IN_M = i.DIG_ELEV_MODEL_IN_M
              ,MODIFICATION_DATE = i.MODIFICATION_DATE
          where COUNTRY_CODE = i.COUNTRY_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    update country
    set PHONE_COUNTRY_CODE = '+1-809'
    where country_code = 'DO'
    ;
    update country
    set PHONE_COUNTRY_CODE = '+1-787'
    where country_code = 'PR'
    ;
    commit;
  exception
    when others then
      raise_application_error(-20008,sqlerrm);
  end load_COUNTRY;
  --
  procedure load_LIST_CURRENCY is
    cursor c_Cur is
    select distinct CURRENCY_CODE
          ,CURRENCY_NAME descr
          ,null HEX_SYMBOL
    from country_stg
    where CURRENCY_CODE is not null
    ;
  begin
    v_proc_name := upper('load_LIST_CURRENCY');
    for i in c_Cur loop
      v_error_rec := i.CURRENCY_CODE;
      begin
        insert into LIST_CURRENCY
              (CURRENCY_CODE
              ,DESCR
              ,HEX_SYMBOL
              )
        values
              (i.CURRENCY_CODE
              ,i.DESCR
              ,i.HEX_SYMBOL
              );
      exception
        when dup_val_on_index then
          update LIST_CURRENCY
          set DESCR = i.DESCR
              ,HEX_SYMBOL = i.HEX_SYMBOL
          where CURRENCY_CODE = i.CURRENCY_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
    --
    update list_currency
    set supported_flag = 'Y'
    where CURRENCY_CODE in ('AED','ARS','AUD','BRL','BGN','CAD','CHF','CNY','CRC','CZK','DKK','EUR','GBP','HKD','HRK'
                            ,'HUF','IDR','ILS','INR','JPY','KRW','MAD','MXN','MYR','NOK','NZD','PEN','PHP','PLN','RON','RUB','SEK','SGD','THB','TRY','TWD','UAH','USD','VND','ZAR'
                            ,'ANG','BOB','BZD','CLP','COP','GTQ','GYD','HNL','NIO','PAB','PYG','SRD','UYU','VEF')
    ;
    commit;
  exception
    when others then
      raise_application_error(-20007,sqlerrm);
  end load_LIST_CURRENCY;
  --
  procedure load_list_location_type is
    cursor c_Cur is
    select CLASS_DOT_CODE LOCATION_TYPE_CODE
          ,DESCR
          ,NAME
    from feature_code_en_stg
    ;
  begin
    v_proc_name := upper('load_list_location_type');
    for i in c_Cur loop
      v_error_rec := i.LOCATION_TYPE_CODE;
      begin
        insert into list_location_type
              (LOCATION_TYPE_CODE
              ,DESCR
              ,NAME
              )
        values
              (i.LOCATION_TYPE_CODE
              ,i.DESCR
              ,i.NAME
              );
      exception
        when dup_val_on_index then
          update list_location_type
          set DESCR = i.DESCR
             ,NAME = i.NAME
          where LOCATION_TYPE_CODE = i.LOCATION_TYPE_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20009,sqlerrm);
  end load_list_location_type;
  --
  procedure load_LIST_MEASUREMENT is
    cursor c_Cur is
    select MEASUREMENT_SYSTEM_CODE MEASUREMENT_CODE
          ,DESCR
    from measurement_system_stg
    ;
  begin
    v_proc_name := upper('load_LIST_MEASUREMENT');
    for i in c_Cur loop
      v_error_rec := i.MEASUREMENT_CODE;
      begin
        insert into LIST_MEASUREMENT
              (MEASUREMENT_CODE
              ,DESCR
              )
        values
              (i.MEASUREMENT_CODE
              ,i.DESCR
              );
      exception
        when dup_val_on_index then
          update LIST_MEASUREMENT
          set DESCR = i.DESCR
          where MEASUREMENT_CODE = i.MEASUREMENT_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20006,sqlerrm);
  end load_LIST_MEASUREMENT;
  --
  procedure load_OAuth_Clients is
    cursor c_Cur is
    select 'ngAuthApp' "Id"
            ,'9db1167d-fdd4-4432-be12-44a9eef7606b' "Secret"
            ,'Provider Join Application' "Name"
            ,'0' "ApplicationType"
            ,'true' "Active"
            ,'7500' "RefreshTokenLifeTime"
            ,'http://join.zillion.rentals' "AllowedOrigin"
    from dual;      
  begin
    v_proc_name := upper('load_OAuth_Clients');
    for i in c_Cur loop
      v_error_rec := i."Id";
      begin
        insert into "OAuth_Clients"
              ("Id"
              ,"Secret"
              ,"Name"
              ,"ApplicationType"
              ,"Active"
              ,"RefreshTokenLifeTime"
              ,"AllowedOrigin"
              )
        values
              (i."Id"
              ,i."Secret"
              ,i."Name"
              ,i."ApplicationType"
              ,i."Active"
              ,i."RefreshTokenLifeTime"
              ,i."AllowedOrigin"
              );
      exception
        when dup_val_on_index then
          update "OAuth_Clients"
          set "Secret" = i."Secret"
              ,"Name" = i."Name"
              ,"ApplicationType" = i."ApplicationType"
              ,"Active" = i."Active"
              ,"RefreshTokenLifeTime" = i."RefreshTokenLifeTime"
              ,"AllowedOrigin" = i."AllowedOrigin"
          where "Id" = i."Id"
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20005,sqlerrm);
  end load_OAuth_Clients;
  --
  procedure load_list_lang is
    cursor c_Cur is
    select ISO_639_3
          ,case 
            when length(ISO_639_2) > 3 then null
            else ISO_639_2
           end ISO_639_2
          ,case 
            when length(ISO_639_1) > 2 then null
            else ISO_639_1
           end ISO_639_1
          ,LANGUAGE_NAME
    from iso_language_stg
    where ISO_639_1 is not null
    ;
  begin
    v_proc_name := upper('load_list_lang');
    for i in c_Cur loop
      v_error_rec := i.ISO_639_3||'-'||i.ISO_639_2||'-'||i.ISO_639_1;
      begin
        insert into list_lang
              (LANG_CODE
              ,ISO_639_2
              ,ISO_639_3
              ,DESCR
              )
        values
              (i.ISO_639_1
              ,i.ISO_639_2
              ,i.ISO_639_3
              ,i.LANGUAGE_NAME
              );
      exception
        when dup_val_on_index then
          update list_lang
          set ISO_639_2 = i.ISO_639_2
              ,ISO_639_3 = i.ISO_639_3
              ,descr = i.LANGUAGE_NAME
          where lang_code = i.ISO_639_1
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    --Update supported lang flag
    update list_lang
    set supported_lang_flag = 'Y'
    where lang_code in ('en','es')
    ;
    commit;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end load_list_lang;
  --
  procedure load_trans_lang is
    cursor c_Cur is
    select 'GNRL' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'FACILITY' name,'Facilities' value, null long_value, null title_1, null title_2 from dual union
    select 'GNRL' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'DEMO' name,'New Patient Demographics' value, null long_value, null title_1, null title_2 from dual union
    --
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'WEIGHT' name,'Weight' value, 'What is your weight in pounds (kilograms)?' long_value, null title_1, null title_2 from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'HEIGHT' name,'Height' value, 'What is your height? (Choose closest value)' long_value, null title_1, null title_2 from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'CHOLESTEROL' name,'Cholesterol Level' value, 'What was your last total cholesterol level? (metric units in parentheses (mmol/L))' long_value, null title_1, null title_2 from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'BLOOD_SUGAR' name,'Blood Sugar Level' value, 'If your blood sugar level before eating was checked in the past four weeks, what was it? (metric units in parentheses (mmol/L))' long_value, null title_1, null title_2 from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'SYS_BP' name,'Systolic Blood Pressure (High Number)' value, 'What was your last blood pressure?' long_value, null title_1, null title_2 from dual union
    select 'ASSE' APPL_FUNCTIONALITY_CODE, 'en' CULTURE,'DIA_BP' name,'Diastolic Blood Pressure (Low Number)' value, 'What was your last blood pressure?' long_value, null title_1, null title_2 from dual
    --
    ;
  begin
    v_proc_name := upper('load_trans_lang');
    for i in c_Cur loop
      v_error_rec := i.CULTURE||'-'||i.NAME;
      begin
        insert into trans_lang
              (CULTURE
              ,NAME
              ,VALUE
              ,long_value
              ,title_1
              ,title_2
              ,APPL_FUNCTIONALITY_CODE
              )
        values
              (i.CULTURE
              ,i.NAME
              ,i.VALUE
              ,i.long_value
              ,i.title_1
              ,i.title_2
              ,i.APPL_FUNCTIONALITY_CODE
              );
      exception
        when dup_val_on_index then
          update trans_lang
          set VALUE = i.VALUE
             ,long_value = i.long_value
             ,title_1 = i.title_1
             ,title_2 = i.title_2
          where CULTURE = i.CULTURE
          AND NAME = i.NAME
          and APPL_FUNCTIONALITY_CODE = i.APPL_FUNCTIONALITY_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end load_trans_lang;
  --
  procedure load_LIST_ERROR_SEVERITY is
    cursor c_Cur is
    select 'E' ERROR_SEVERITY_CODE, 'Error' descr from dual
    union
    select 'W' ERROR_SEVERITY_CODE, 'Warning' descr from dual
    union
    select 'N' ERROR_SEVERITY_CODE, 'Notification' descr from dual
    ; 
  begin
    v_proc_name := upper('load_LIST_ERROR_SEVERITY');
    for i in c_Cur loop
      v_error_rec := i.ERROR_SEVERITY_CODE;
      begin
        insert into LIST_ERROR_SEVERITY
              (ERROR_SEVERITY_CODE
              ,descr
              )
        values
              (i.ERROR_SEVERITY_CODE
              ,i.descr
              );
      exception
        when dup_val_on_index then
          update LIST_ERROR_SEVERITY
          set descr = i.descr
          where ERROR_SEVERITY_CODE = i.ERROR_SEVERITY_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end load_LIST_ERROR_SEVERITY;
  --
  procedure load_continent is
    cursor c_Cur is
    select C.CONTINENT_CODE
      ,C.CONTINENT_NAME name
      ,cc.LATITUDE
      ,CC.LONGITUDE
      ,CC.POPULATION
      ,CC.ELEVATION ELEV_IN_M
      ,CC.DEM DIG_ELEV_MODEL_IN_M
      ,to_date(CC.MODIFICATION_DATE,'YYYY-MM-DD') MODIFICATION_DATE
    from continent_stg c
        ,country_city_stg cc
    where C.GEONAMEID = CC.GEONAMEID
    ;
  begin
    v_proc_name := upper('load_continent');
    for i in c_Cur loop
      v_error_rec := i.CONTINENT_CODE;
      begin
        insert into continent
              (CONTINENT_CODE
              ,NAME
              ,LATITUDE
              ,LONGITUDE
              ,POPULATION
              ,ELEV_IN_M
              ,DIG_ELEV_MODEL_IN_M
              ,MODIFICATION_DATE
              )
        values
              (i.CONTINENT_CODE
              ,i.NAME
              ,i.LATITUDE
              ,i.LONGITUDE
              ,i.POPULATION
              ,i.ELEV_IN_M
              ,i.DIG_ELEV_MODEL_IN_M
              ,i.MODIFICATION_DATE
              );
      exception
        when dup_val_on_index then
          update continent
          set  NAME = i.NAME
              ,LATITUDE = i.LATITUDE
              ,LONGITUDE = i.LONGITUDE
              ,POPULATION = i.POPULATION
              ,ELEV_IN_M = i.ELEV_IN_M
              ,DIG_ELEV_MODEL_IN_M = i.DIG_ELEV_MODEL_IN_M
              ,MODIFICATION_DATE = i.MODIFICATION_DATE
          where CONTINENT_CODE = i.CONTINENT_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name --p_package_name
                                         ,v_proc_name --p_proc_name
                                         ,'E' --p_err_severity_code
                                         ,v_err_msg --p_err_msg
                                         ,v_error_rec --p_notes
                                         );
      end;
      if mod(c_Cur%rowcount,300) = 0 then
        commit;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20002,sqlerrm);
  end load_continent;
END loc_trans_pkg;
/
SHOW ERRORS
