set define off
CREATE OR REPLACE PACKAGE loc_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('loc_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  --
  procedure load_appsnetroles;
  procedure load_COUNTRY;
  procedure load_STATE;
  procedure load_list_lang;
  procedure load_LIST_ERROR_SEVERITY;
  procedure load_TRANS_LANG;
  procedure load_OAuth_Clients;
  
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
    select '79F450777D2E4B6AB98FECB17974FDEB' id,'Service Provider' name,'Y' service_provider_flag from dual union
    select '3951E214B3F746BD924AFF39CABEA511' id,'Service Provider Lead' name,'Y' service_provider_flag from dual union
    select 'DF56C6ED00FF47AC84754BDF1517FB83' id,'Primary Provider' name,'N' service_provider_flag from dual union
    select '22F1493D8E914982A6C5532EDBD516FE' id,'Data Entry' name,'N' service_provider_flag from dual union
    select '943DF69DD1744FA2BED92A55C2800C57' id,'Office Admin' name,'Y' service_provider_flag from dual union
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
  procedure load_STATE is
  begin
    v_proc_name := upper('load_STATE');
      for i in (select 'US' country_code,'AK' state_code,'Alaska' name from dual union
              select 'US' country_code,'AL' state_code,'Alabama' name from dual union
              select 'US' country_code,'AR' state_code,'Arkansas' name from dual union
              select 'US' country_code,'AZ' state_code,'Arizona' name from dual union
              select 'US' country_code,'CA' state_code,'California' name from dual union
              select 'US' country_code,'CO' state_code,'Colorado' name from dual union
              select 'US' country_code,'CT' state_code,'Connecticut' name from dual union
              select 'US' country_code,'DC' state_code,'District of Columbia' name from dual union
              select 'US' country_code,'DE' state_code,'Delaware' name from dual union
              select 'US' country_code,'FL' state_code,'Florida' name from dual union
              select 'US' country_code,'GA' state_code,'Georgia' name from dual union
              select 'US' country_code,'HI' state_code,'Hawaii' name from dual union
              select 'US' country_code,'IA' state_code,'Iowa' name from dual union
              select 'US' country_code,'ID' state_code,'Idaho' name from dual union
              select 'US' country_code,'IL' state_code,'Illinois' name from dual union
              select 'US' country_code,'IN' state_code,'Indiana' name from dual union
              select 'US' country_code,'KS' state_code,'Kansas' name from dual union
              select 'US' country_code,'KY' state_code,'Kentucky' name from dual union
              select 'US' country_code,'LA' state_code,'Louisiana' name from dual union
              select 'US' country_code,'MA' state_code,'Massachusetts' name from dual union
              select 'US' country_code,'MD' state_code,'Maryland' name from dual union
              select 'US' country_code,'ME' state_code,'Maine' name from dual union
              select 'US' country_code,'MI' state_code,'Michigan' name from dual union
              select 'US' country_code,'MN' state_code,'Minnesota' name from dual union
              select 'US' country_code,'MO' state_code,'Missouri' name from dual union
              select 'US' country_code,'MS' state_code,'Mississippi' name from dual union
              select 'US' country_code,'MT' state_code,'Montana' name from dual union
              select 'US' country_code,'NC' state_code,'North Carolina' name from dual union
              select 'US' country_code,'ND' state_code,'North Dakota' name from dual union
              select 'US' country_code,'NE' state_code,'Nebraska' name from dual union
              select 'US' country_code,'NH' state_code,'New Hampshire' name from dual union
              select 'US' country_code,'NJ' state_code,'New Jersey' name from dual union
              select 'US' country_code,'NM' state_code,'New Mexico' name from dual union
              select 'US' country_code,'NV' state_code,'Nevada' name from dual union
              select 'US' country_code,'NY' state_code,'New York' name from dual union
              select 'US' country_code,'OH' state_code,'Ohio' name from dual union
              select 'US' country_code,'OK' state_code,'Oklahoma' name from dual union
              select 'US' country_code,'OR' state_code,'Oregon' name from dual union
              select 'US' country_code,'PA' state_code,'Pennsylvania' name from dual union
              select 'US' country_code,'RI' state_code,'Rhode Island' name from dual union
              select 'US' country_code,'SC' state_code,'South Carolina' name from dual union
              select 'US' country_code,'SD' state_code,'South Dakota' name from dual union
              select 'US' country_code,'TN' state_code,'Tennessee' name from dual union
              select 'US' country_code,'TX' state_code,'Texas' name from dual union
              select 'US' country_code,'UT' state_code,'Utah' name from dual union
              select 'US' country_code,'VA' state_code,'Virginia' name from dual union
              select 'US' country_code,'VT' state_code,'Vermont' name from dual union
              select 'US' country_code,'WA' state_code,'Washington' name from dual union
              select 'US' country_code,'WI' state_code,'Wisconsin' name from dual union
              select 'US' country_code,'WV' state_code,'West Virginia' name from dual union
              select 'US' country_code,'WY' state_code,'Wyoming' name from dual
              ) 
      loop
        v_error_rec := i.country_code||'-'||i.STATE_CODE;
        --
        begin
          insert into STATE
                (STATE_SN
                ,COUNTRY_CODE
                ,STATE_CODE
                ,NAME
                )
          values
                (STATE_SNG.nextval
                ,i.COUNTRY_CODE
                ,i.STATE_CODE
                ,i.NAME
                );
        exception
          when dup_val_on_index then
            update STATE
            set NAME = i.NAME
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
      end loop;
    commit;
  exception
    when others then
      raise_application_error(-20008,sqlerrm);
  end load_STATE;
  --
  procedure load_COUNTRY is
  begin
    v_proc_name := upper('load_COUNTRY');
    for i in (select 'US' country_code from dual) loop
      v_error_rec := i.COUNTRY_CODE;
      --
      begin
        insert into COUNTRY
              (COUNTRY_CODE
              )
        values
              (i.COUNTRY_CODE
              );
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
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20008,sqlerrm);
  end load_COUNTRY;
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
    select 'eng' ISO_639_3
          ,'eng' ISO_639_2
          ,'en' ISO_639_1
          ,'English' LANGUAGE_NAME
    from dual
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
  
END loc_trans_pkg;
/
SHOW ERRORS
