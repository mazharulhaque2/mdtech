create or replace PACKAGE common_dml_pkg IS
  v_pkg_name    varchar2 (30) := upper('common_dml_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  procedure prepare_custom_addr_attrib (p_state_rec in out state%rowtype,p_city_rec in out city%rowtype,p_addr_rec in out addr%rowtype);
  PROCEDURE get_addr_sn (p_addr_type in addr.addr_type_code%type,p_state_rec in state%rowtype,p_city_rec in city%rowtype,p_addr_rec in addr%rowtype,p_addr_sn out addr.addr_sn%type);
  procedure custom_addr_attrib (p_state_rec in out state%rowtype,p_city_rec in out city%rowtype,p_addr_rec in out addr%rowtype);
  PROCEDURE custom_addr_parsing_prc (p_addr_json IN varchar2,p_addr_type in varchar2,p_state_rec out state%rowtype,p_city_rec out city%rowtype,p_addr_rec out addr%rowtype,p_status_code    OUT VARCHAR2);
  PROCEDURE addr_parsing_prc(p_addr_json IN varchar2,p_state_rec out state%rowtype,p_city_rec out city%rowtype,p_addr_rec out addr%rowtype,p_status_code    OUT VARCHAR2);
  --
  PROCEDURE ins_mbr_role (p_mbr_role_rec  IN OUT  "AspNetUserRoles"%rowtype);
  PROCEDURE upd_mbr (p_mbr_rec  IN OUT  "AspNetUsers"%rowtype);
  PROCEDURE ins_mbr (p_mbr_rec  IN OUT  "AspNetUsers"%rowtype);
  PROCEDURE ins_state (p_state_rec  IN OUT  state%rowtype);
  PROCEDURE ins_city (p_city_rec  IN OUT  city%rowtype);
  PROCEDURE ins_addr (p_addr_rec  IN OUT  addr%rowtype);
  --
  PROCEDURE ins_company (p_company_rec  IN OUT  company%rowtype);
  PROCEDURE ins_patient (p_patient_rec  IN OUT  patient%rowtype);
  PROCEDURE ins_physician (p_physician_rec  IN OUT  physician%rowtype);
  PROCEDURE ins_svc_location (p_svc_location_rec  IN OUT  svc_location%rowtype);
  PROCEDURE ins_patient_medication (p_patient_medication_rec  IN OUT  patient_medication%rowtype);
  PROCEDURE ins_patient_prev_svc_remark (p_patient_prev_svc_remark_rec  IN OUT  patient_prev_svc_remark%rowtype);
  PROCEDURE ins_patient_prev_svc (p_patient_prev_svc_rec  IN OUT  patient_prev_svc%rowtype);
  PROCEDURE ins_patient_response (p_patient_response_rec  IN OUT  patient_response%rowtype);
  PROCEDURE ins_patient_history (p_patient_history_rec  IN OUT  patient_history%rowtype);
  PROCEDURE ins_provider_physician (p_provider_physician_rec  IN OUT  provider_physician%rowtype);
  PROCEDURE ins_physician_svc_location (p_physician_svc_location_rec  IN OUT  physician_svc_location%rowtype);
  PROCEDURE ins_user_svc_location (p_user_svc_location_rec  IN OUT  user_svc_location%rowtype);
  PROCEDURE ins_user_physician (p_user_physician_rec  IN OUT  user_physician%rowtype);
  PROCEDURE ins_user_company (p_user_company_rec  IN OUT  user_company%rowtype);
  PROCEDURE ins_upd_svc_result (p_svc_result_rec  IN OUT  svc_result%rowtype);
  --
  PROCEDURE ins_physician_em (p_physician_em_rec  IN OUT  physician_em%rowtype);
  PROCEDURE ins_physician_em_name (p_physician_em_name_rec  IN OUT  physician_em_name%rowtype);
  PROCEDURE ins_provider_ccm (p_provider_ccm_rec  IN OUT  provider_ccm%rowtype);
  PROCEDURE ins_provider_ccm_question (p_provider_ccm_question_rec  IN OUT  provider_ccm_question%rowtype);
  PROCEDURE ins_contact_us (p_contact_us_rec  IN OUT  contact_us%rowtype);
  PROCEDURE ins_user_login (p_user_role_id in varchar2,p_PACKAGE_NAME in varchar2,p_PROCEDURE_NAME in varchar2,p_LATITUDE in number,p_LONGITUDE in number,p_BROWSER_NAME in varchar2,p_IP_ADDR in varchar2,p_PREF_LOCALE in varchar2);
END common_dml_pkg;
/
show errors
create or replace PACKAGE BODY common_dml_pkg IS
  PROCEDURE custom_addr_parsing_prc (p_addr_json IN varchar2
                                    ,p_addr_type in varchar2
                                    ,p_state_rec out state%rowtype
                                    ,p_city_rec out city%rowtype
                                    ,p_addr_rec out addr%rowtype
                                    ,p_status_code    OUT VARCHAR2
                                     )
  as
    v_acct_name varchar2(30);
    obj json;
    l_obj json_list;
    tempdata json_value;
    --
    tempobj json;
    --
    out_obj   json := json();
  begin
    v_proc_name := upper('custom_addr_parsing_prc');
    v_err_msg := null;
    v_input_str := 'p_addr_json: '||p_addr_json;
    --
    --Insert as part of testing. Should be commented in prod env
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    obj := json(p_addr_json);
    --
    if obj.exist(p_addr_type) then
      tempdata := obj.get(p_addr_type);
      if(tempdata.is_object) then
        tempobj := json(tempdata);
        --
        p_addr_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
        --
        if tempobj.exist('ADDR_1') then
          tempdata := tempobj.get('ADDR_1');
          if tempdata is not null then
            p_addr_rec.ADDR_1 := tempdata.get_string;
          end if;
        end if;
        --
        if tempobj.exist('ADDR_2') then
          tempdata := tempobj.get('ADDR_2');
          if tempdata is not null then
            p_addr_rec.ADDR_2 := tempdata.get_string;
          end if;
        end if;
        --
        if tempobj.exist('CITY') then
          tempdata := tempobj.get('CITY');
          if tempdata is not null then
            p_city_rec.name := tempdata.get_string;
          end if;
        end if;
        --
        if tempobj.exist('STATE_CODE') then
          tempdata := tempobj.get('STATE_CODE');
          if tempdata is not null then
            p_state_rec.STATE_CODE := tempdata.get_string;
          end if;
        end if;
        --
        if tempobj.exist('COUNTRY_CODE') then
          tempdata := tempobj.get('COUNTRY_CODE');
          if tempdata is not null then
            p_state_rec.COUNTRY_CODE := tempdata.get_string;
          end if;
        end if;
        --
        if tempobj.exist('POSTAL_CODE') then
          tempdata := tempobj.get('POSTAL_CODE');
          if tempdata is not null then
            p_addr_rec.POSTAL_CODE := tempdata.get_string;
          end if;
        end if;
      end if;
    end if;
    out_obj.put('STATUS','SUCCESSFUL');
    out_obj.put('MSG','Transaction Successful.');
    p_status_code := out_obj.to_char;
  exception
    when others then
        v_err_msg := SUBSTR (SQLERRM,1,100);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
        --
        out_obj.put('STATUS','FAILED');
        out_obj.put('MSG','Transaction failed. Please contact customer support.');
        p_status_code := out_obj.to_char;
  end custom_addr_parsing_prc;  
  --
  procedure prepare_custom_addr_attrib (p_state_rec in out state%rowtype
                                       ,p_city_rec in out city%rowtype
                                       ,p_addr_rec in out addr%rowtype
                                       )
  as
  begin
    --add other valuabel information 
    p_state_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    p_city_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    p_addr_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    --
    if p_state_rec.state_code is not null then
      begin
        select name
        into p_state_rec.name
        from state
        where state_code = p_state_rec.state_code
        and country_code = p_state_rec.country_code
        ;
      exception
        when no_data_found then
          null;
      end;
    end if;
    --
    if p_addr_rec.ADDR_2 is not null then
      if p_state_rec.name is not null then
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.NAME||' '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      else --null state
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      end if;
    else --null addr_2
      if p_state_rec.name is not null then
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.NAME||' '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      else --null state
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      end if;
    end if;
  end prepare_custom_addr_attrib;
  --
  PROCEDURE get_addr_sn (p_addr_type in addr.addr_type_code%type
                        ,p_state_rec in state%rowtype
                        ,p_city_rec in city%rowtype
                        ,p_addr_rec in addr%rowtype
                        ,p_addr_sn out addr.addr_sn%type
                        )
  as
    v_state_rec     state%rowtype := p_state_rec;
    v_city_rec      city%rowtype := p_city_rec;
    v_addr_rec      addr%rowtype := p_addr_rec;  
  begin
    v_proc_name := upper('get_addr_sn');
    v_input_str := 'p_addr_type: '||p_addr_type||'-p_state_rec: '||p_state_rec.state_code||'-'||p_state_rec.country_code||'-p_city_rec: '||p_city_rec.name||'-p_addr_rec: '||p_addr_rec.addr_1||'-'||p_addr_rec.addr_2||'-'||p_addr_rec.postal_code||'-'||v_addr_rec.formatted_addr;
    --Insert as part of testing. Should be commented in prod env
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    if v_addr_rec.source_from_google_api_flag is null then
      v_addr_rec.source_from_google_api_flag := 'Y';
      v_city_rec.source_from_google_api_flag := 'Y';
      v_state_rec.source_from_google_api_flag := 'Y';
    end if;
    --
    if v_addr_rec.source_from_google_api_flag = 'N' then
      --add other valuabel custom addr information. Standard model is to have google addr api json as addr attribute. When the addr is not from google api,
      --call this proc to add other custom addr attributes and create formatted addr attrib.
      common_dml_pkg.prepare_custom_addr_attrib (v_state_rec,v_city_rec,v_addr_rec);
    end if;
    --
    begin
      select addr_sn
      into p_addr_sn
      from addr
      where addr_type_code = p_addr_type 
      and formatted_addr = upper(v_addr_rec.formatted_addr)
      ;
    exception
      when no_data_found then
        --create the addr record and return addr_sn
        --setting constant
        v_addr_rec.ADDR_TYPE_CODE := p_addr_type;
        --
        begin
          --
          --Assumption is country will be always there. If country is missing then raise and will be evaluate separately.
          --
          select state_sn
          into v_state_rec.state_sn
          from state
          where country_code = v_state_rec.country_code
          and state_code = v_state_rec.state_code
          ;
          begin
            select city_sn
            into v_city_rec.city_sn
            from city
            where state_sn = v_state_rec.state_sn
            and upper(name) = upper(v_city_rec.name)
            ;
            --create the addr
            v_addr_rec.city_sn := v_city_rec.city_sn;
            common_dml_pkg.ins_addr(v_addr_rec);
            p_addr_sn := v_addr_rec.addr_sn;
          exception
            when no_data_found then
              --
              --At this section city is not found but state is found
              --When city is not found, then create ( city, postal and address).
              --
              begin
                --SOURCE_FROM_GOOGLE_API_FLAG default is Y for state, city, postal and addr
                v_city_rec.state_sn := v_state_rec.state_sn;
                common_dml_pkg.ins_city(v_city_rec);
                --
                v_addr_rec.city_sn := v_city_rec.city_sn;
                common_dml_pkg.ins_addr(v_addr_rec);
                p_addr_sn := v_addr_rec.addr_sn;
              exception
                when others then
                  raise_application_error(-20002,sqlerrm);
              end;
          end;
        exception
          when no_data_found then
            --
            --At this section state is not found.
            --When state is not found, then create the whole hierarchy (state, city, postal and address).
            --
            begin
              common_dml_pkg.ins_state(v_state_rec);
              --
              v_city_rec.state_sn := v_state_rec.state_sn;
              common_dml_pkg.ins_city(v_city_rec);
              --
              v_addr_rec.city_sn := v_city_rec.city_sn;
              common_dml_pkg.ins_addr(v_addr_rec);
              p_addr_sn := v_addr_rec.addr_sn;
            exception
              when others then
                raise_application_error(-20001,sqlerrm);
            end;
        end;
    end;
    commit;
  exception
    when others then
        v_err_msg := SUBSTR (SQLERRM,1,1000);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
  end get_addr_sn;
  --
  --This procedure is usually called to return the required address attributes when address record is
  --not identified by Google API
  procedure custom_addr_attrib (p_state_rec in out state%rowtype
                                ,p_city_rec in out city%rowtype
                                ,p_addr_rec in out addr%rowtype
                                ) 
  is
  begin
    --add other valuabel information 
    p_state_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    p_city_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    p_addr_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    --
    if p_state_rec.state_code is not null then
      begin
        select name
        into p_state_rec.name
        from state
        where state_code = p_state_rec.state_code
        and country_code = p_state_rec.country_code
        ;
      exception
        when no_data_found then
          null;
      end;
    end if;
    --
    if p_addr_rec.ADDR_2 is not null then
      if p_state_rec.name is not null then
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.NAME||' '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      else --null state
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_addr_rec.ADDR_2||', '||p_city_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      end if;
    else --null addr_2
      if p_state_rec.name is not null then
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.NAME||' '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      else --null state
        if p_addr_rec.POSTAL_CODE is not null then
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_addr_rec.POSTAL_CODE||', '||p_state_rec.COUNTRY_CODE;
        else
          p_addr_rec.FORMATTED_ADDR := p_addr_rec.ADDR_1||', '||p_city_rec.NAME||', '||p_state_rec.COUNTRY_CODE;
        end if;
      end if;
    end if;
  end custom_addr_attrib;
  --
  PROCEDURE addr_parsing_prc(p_addr_json IN varchar2
                            ,p_state_rec out state%rowtype
                            ,p_city_rec out city%rowtype
                            ,p_addr_rec out addr%rowtype
                            ,p_status_code    OUT VARCHAR2
                             ) IS
      l_obj           json;
      l_results       json_list;
      l_tempobj       json;
      l_addr_comps    json_list;
      l_addr          json;
      l_typesarr      json_list;
      l_geom_obj      json;
      l_loc           json;
      --
      l_types         VARCHAR2(30);
      l_short_name    VARCHAR2(200);
      l_long_name     VARCHAR2(1000);
      l_loc_type      VARCHAR2(100);
  BEGIN
      v_proc_name := upper('iu_prov');
      -- Create json object from google response
      l_obj    := json(p_addr_json);
      --           
      -- The overall JSON is an array named results
      l_results := json_list(l_obj.get('results'));
      --     
      -- There is only a single element in the results array, so get the first (and last) one
      l_tempobj := json(l_results.get(1));
      --     
      -- The next level contains an array named address_components
      l_addr_comps := json_list(l_tempobj.get(1));
      --     
      -- loop through the address components and test the types array for address elements
      FOR i IN 1 .. l_addr_comps.count
      LOOP
          l_addr := json(l_addr_comps.get(i));
          --               
          l_typesarr := json_list(l_addr.get('types'));
          --     
          -- Types is not a json array, but a string array so we have to get
          -- the first element using the types[1] syntax
          l_types      := json_ext.get_string(l_addr, 'types[1]');
          l_short_name := json_ext.get_string(l_addr, 'short_name');
          l_long_name := json_ext.get_string(l_addr, 'long_name');
          --     
          CASE l_types
            WHEN 'street_number' THEN
              p_addr_rec.addr_1 := l_short_name;
            WHEN 'route' THEN
              p_addr_rec.addr_1 := p_addr_rec.addr_1||' '||l_short_name;
            WHEN 'locality' THEN
              p_city_rec.name := l_long_name;
            WHEN 'administrative_area_level_1' THEN
              p_state_rec.state_code := l_short_name;
              p_state_rec.name := l_long_name;
            WHEN 'administrative_area_level_2' THEN
              p_addr_rec.county_name := l_long_name;
            WHEN 'postal_code' THEN
              p_addr_rec.postal_code := l_short_name;
            WHEN 'country' THEN
              p_state_rec.country_code := l_short_name;
            ELSE
              NULL;
          END CASE;
      END LOOP;
      -- now get lat/lng
      l_geom_obj := json(l_tempobj.get(3));
      --
      l_loc := json_ext.get_json(l_geom_obj, 'location');
      p_addr_rec.latitude := to_char(json_ext.get_number(l_loc, 'lat'));
      p_addr_rec.longitude := to_char(json_ext.get_number(l_loc, 'lng'));
      --
      l_loc_type := json_ext.get_string(l_geom_obj, 'location_type');
      p_addr_rec.formatted_addr := json_ext.get_string(l_tempobj, 'formatted_address');
      p_addr_rec.json_addr := p_addr_json;
      --
      p_status_code := json_ext.get_string(l_obj, 'status');
  EXCEPTION
    WHEN OTHERS THEN 
      v_err_msg := SUBSTR (SQLERRM,1,1000);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,p_addr_json,null);
      RAISE_APPLICATION_ERROR(-20101,SQLERRM);
  END addr_parsing_prc;
  --
  PROCEDURE ins_mbr_role (p_mbr_role_rec  IN OUT  "AspNetUserRoles"%rowtype)
  IS
  begin
    insert into "AspNetUserRoles"
        ("UserId"
        ,"RoleId"
        )
    values
        (p_mbr_role_rec."UserId"
        ,p_mbr_role_rec."RoleId"
        ) returning USER_ROLE_ID
       into p_mbr_role_rec.USER_ROLE_ID
       ;
  end ins_mbr_role;
  --
  PROCEDURE upd_mbr (p_mbr_rec  IN OUT  "AspNetUsers"%rowtype) IS
  begin
    v_proc_name  := upper('upd_mbr');
    --PROPERTY_LOCATION_DESCR = nvl(p_property_rec.PROPERTY_LOCATION_DESCR,PROPERTY_LOCATION_DESCR)
    update "AspNetUsers"
    set    "Email" = nvl(p_mbr_rec."Email","Email")
          ,"EmailConfirmed" = decode(p_mbr_rec."EmailConfirmed",0,"EmailConfirmed",p_mbr_rec."EmailConfirmed")
          ,"PasswordHash" = nvl(p_mbr_rec."PasswordHash","PasswordHash")
          ,"SecurityStamp" = nvl(p_mbr_rec."SecurityStamp","SecurityStamp")
          ,"PhoneNumber" = nvl(p_mbr_rec."PhoneNumber","PhoneNumber")
          ,"PhoneNumberConfirmed" = decode(p_mbr_rec."PhoneNumberConfirmed",0,"PhoneNumberConfirmed",p_mbr_rec."PhoneNumberConfirmed")
          ,"TwoFactorEnabled" = decode(p_mbr_rec."TwoFactorEnabled",0,"TwoFactorEnabled",p_mbr_rec."TwoFactorEnabled")
          ,"LockoutEndDateUtc" = nvl(p_mbr_rec."LockoutEndDateUtc","LockoutEndDateUtc")
          ,"LockoutEnabled" = decode(p_mbr_rec."LockoutEnabled",0,"LockoutEnabled",p_mbr_rec."LockoutEnabled")
          ,"AccessFailedCount" = decode(p_mbr_rec."AccessFailedCount",0,"AccessFailedCount",p_mbr_rec."AccessFailedCount")
          ,"UserName" = nvl(p_mbr_rec."UserName","UserName")
          ,"PARENT_ID" = nvl(p_mbr_rec."PARENT_ID","PARENT_ID")
          ,"HOME_PHONE_NUM" = nvl(p_mbr_rec."HOME_PHONE_NUM","HOME_PHONE_NUM")
          ,"BUSINESS_PHONE_NUM" = nvl(p_mbr_rec."BUSINESS_PHONE_NUM","BUSINESS_PHONE_NUM")
          ,"FIRST_NAME" = nvl(p_mbr_rec."FIRST_NAME","FIRST_NAME")
          ,"LAST_NAME" = nvl(p_mbr_rec."LAST_NAME","LAST_NAME")
          ,"MIDDLE_NAME" = nvl(p_mbr_rec."MIDDLE_NAME","MIDDLE_NAME")
          ,"GENDER_CODE" = nvl(p_mbr_rec."GENDER_CODE","GENDER_CODE")
          ,"ABOUT_PROV" = nvl(p_mbr_rec."ABOUT_PROV","ABOUT_PROV")
          ,"BIRTH_DATE" = nvl(p_mbr_rec."BIRTH_DATE","BIRTH_DATE")
          ,"RESPONSE_RATE" = nvl(p_mbr_rec."RESPONSE_RATE","RESPONSE_RATE")
          ,"RESPONSE_TIME" = nvl(p_mbr_rec."RESPONSE_TIME","RESPONSE_TIME")
          ,"HOSTING_STORY" = nvl(p_mbr_rec."HOSTING_STORY","HOSTING_STORY")
          ,"ADDR_SN" = nvl(p_mbr_rec."ADDR_SN","ADDR_SN")
          ,"TERMS_AND_COND_ACCEPTANCE" = decode(p_mbr_rec."TERMS_AND_COND_ACCEPTANCE",0,"TERMS_AND_COND_ACCEPTANCE",p_mbr_rec."TERMS_AND_COND_ACCEPTANCE")
          ,"RECEIVE_NEWS_LETTER" = decode(p_mbr_rec."RECEIVE_NEWS_LETTER",0,"RECEIVE_NEWS_LETTER",p_mbr_rec."RECEIVE_NEWS_LETTER")
          ,"ALT_EMAIL" = nvl(p_mbr_rec."ALT_EMAIL","ALT_EMAIL")
    where "Id" = p_mbr_rec."Id"
    ;
    p_mbr_rec."Id" := p_mbr_rec."Id";
  end upd_mbr;
  --
  PROCEDURE ins_mbr (p_mbr_rec  IN OUT  "AspNetUsers"%rowtype) IS
  begin
    v_proc_name  := upper('ins_mbr');
    insert into "AspNetUsers" 
            ("Id"
            ,"Email"
            ,"EmailConfirmed"
            ,"PasswordHash"
            ,"SecurityStamp"
            ,"PhoneNumber"
            ,"PhoneNumberConfirmed"
            ,"TwoFactorEnabled"
            ,"LockoutEndDateUtc"
            ,"LockoutEnabled"
            ,"AccessFailedCount"
            ,"UserName"
            ,"PARENT_ID"
            ,"HOME_PHONE_NUM"
            ,"BUSINESS_PHONE_NUM"
            ,"FIRST_NAME"
            ,"LAST_NAME"
            ,"MIDDLE_NAME"
            ,"GENDER_CODE"
            ,"ABOUT_PROV"
            ,"BIRTH_DATE"
            ,"RESPONSE_RATE"
            ,"RESPONSE_TIME"
            ,"HOSTING_STORY"
            ,"ADDR_SN"
            ,"TERMS_AND_COND_ACCEPTANCE"
            ,"RECEIVE_NEWS_LETTER"
            ,"ALT_EMAIL"
            ,"USER_CREATED_REC_FLAG"
            )
    values  (p_mbr_rec."Id"
            ,p_mbr_rec."Email"
            ,p_mbr_rec."EmailConfirmed"
            ,p_mbr_rec."PasswordHash"
            ,p_mbr_rec."SecurityStamp"
            ,p_mbr_rec."PhoneNumber"
            ,p_mbr_rec."PhoneNumberConfirmed"
            ,p_mbr_rec."TwoFactorEnabled"
            ,p_mbr_rec."LockoutEndDateUtc"
            ,p_mbr_rec."LockoutEnabled"
            ,p_mbr_rec."AccessFailedCount"
            ,p_mbr_rec."UserName"
            ,p_mbr_rec."PARENT_ID"
            ,p_mbr_rec."HOME_PHONE_NUM"
            ,p_mbr_rec."BUSINESS_PHONE_NUM"
            ,p_mbr_rec."FIRST_NAME"
            ,p_mbr_rec."LAST_NAME"
            ,p_mbr_rec."MIDDLE_NAME"
            ,p_mbr_rec."GENDER_CODE"
            ,p_mbr_rec."ABOUT_PROV"
            ,p_mbr_rec."BIRTH_DATE"
            ,p_mbr_rec."RESPONSE_RATE"
            ,p_mbr_rec."RESPONSE_TIME"
            ,p_mbr_rec."HOSTING_STORY"
            ,p_mbr_rec."ADDR_SN"
            ,p_mbr_rec."TERMS_AND_COND_ACCEPTANCE"
            ,p_mbr_rec."RECEIVE_NEWS_LETTER"
            ,p_mbr_rec."ALT_EMAIL"
            ,p_mbr_rec."USER_CREATED_REC_FLAG"
            ) 
    ;
    p_mbr_rec."Id" := p_mbr_rec."Id";
  end ins_mbr;
  --
  PROCEDURE ins_state (p_state_rec  IN OUT  state%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_state');

      INSERT INTO state (
           STATE_SN
          ,COUNTRY_CODE
          ,STATE_CODE
          ,NAME
          ,LATITUDE
          ,LONGITUDE
          ,POPULATION
          ,ELEV_IN_M
          ,DIG_ELEV_MODEL_IN_M
          ,MODIFICATION_DATE
      ) VALUES (
           state_sng.nextval
          ,p_state_rec.COUNTRY_CODE
          ,p_state_rec.STATE_CODE
          ,p_state_rec.NAME
          ,p_state_rec.LATITUDE
          ,p_state_rec.LONGITUDE
          ,p_state_rec.POPULATION
          ,p_state_rec.ELEV_IN_M
          ,p_state_rec.DIG_ELEV_MODEL_IN_M
          ,p_state_rec.MODIFICATION_DATE
      )returning state_sn
       into p_state_rec.state_sn
      ;
      --Exception handling and commit should be handled by the 
      --calling stored proc
  END ins_state;
  --
  PROCEDURE ins_city (p_city_rec   IN OUT  city%rowtype  ) IS

  BEGIN
    v_proc_name := upper('ins_city');
      INSERT INTO city (
           CITY_SN
          ,STATE_SN
          ,LOCATION_TYPE_CODE
          ,NAME
          ,LATITUDE
          ,LONGITUDE
          ,POPULATION
          ,ELEV_IN_M
          ,DIG_ELEV_MODEL_IN_M
          ,MODIFICATION_DATE
      ) VALUES (
           city_sng.nextval
          ,p_city_rec.STATE_SN
          ,p_city_rec.LOCATION_TYPE_CODE
          ,p_city_rec.NAME
          ,p_city_rec.LATITUDE
          ,p_city_rec.LONGITUDE
          ,p_city_rec.POPULATION
          ,p_city_rec.ELEV_IN_M
          ,p_city_rec.DIG_ELEV_MODEL_IN_M
          ,p_city_rec.MODIFICATION_DATE
          )
          returning city_sn
        into p_city_rec.city_sn
        ;
      --Exception handling and commit should be handled by calling procedure.
  END ins_city;
  --
  PROCEDURE ins_addr (p_addr_rec    IN OUT  addr%rowtype  ) IS

  BEGIN
    v_proc_name  := upper('ins_addr');
      --Insert all data into table
      INSERT INTO addr (
           ADDR_SN
          ,ADDR_TYPE_CODE
          ,CITY_SN
          ,ADDR_1
          ,ADDR_2
          ,POSTAL_CODE
          ,COUNTY_NAME
          ,RECIPIENT_1
          ,RECIPIENT_2
          ,RECIPIENT_3
          ,FORMATTED_ADDR
          ,JSON_ADDR
          ,LATITUDE
          ,LONGITUDE
      ) VALUES (
           ADDR_SNG.nextval
          ,p_addr_rec.ADDR_TYPE_CODE
          ,p_addr_rec.CITY_SN
          ,p_addr_rec.ADDR_1
          ,p_addr_rec.ADDR_2
          ,p_addr_rec.POSTAL_CODE
          ,p_addr_rec.COUNTY_NAME
          ,p_addr_rec.RECIPIENT_1
          ,p_addr_rec.RECIPIENT_2
          ,p_addr_rec.RECIPIENT_3
          ,upper(p_addr_rec.FORMATTED_ADDR)
          ,p_addr_rec.JSON_ADDR
          ,p_addr_rec.LATITUDE
          ,p_addr_rec.LONGITUDE
      )returning addr_sn
        into p_addr_rec.addr_sn
      ;
  END ins_addr;
  --
  PROCEDURE ins_company (p_company_rec  IN OUT  company%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_company');
      INSERT INTO company (
           COMPANY_SN
          ,ADDR_SN
          ,NAME
          ,PHONE_NUMBER
          ,FAX_NUMBER
          ,TOLL_FREE_NUMBER
          ,WEBSITE_ADDR
          ,CONTACT_NAME
          ,created_by_user_role_id
          ,updated_by_user_role_id
      ) VALUES (
           company_sng.nextval
          ,p_company_rec.ADDR_SN
          ,p_company_rec.NAME
          ,p_company_rec.PHONE_NUMBER
          ,p_company_rec.FAX_NUMBER
          ,p_company_rec.TOLL_FREE_NUMBER
          ,p_company_rec.WEBSITE_ADDR
          ,p_company_rec.CONTACT_NAME
          ,p_company_rec.created_by_user_role_id
          ,p_company_rec.updated_by_user_role_id
      )returning company_sn
       into p_company_rec.company_sn
      ;
  END ins_company;
  --
  PROCEDURE ins_patient (p_patient_rec  IN OUT  patient%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient');
      INSERT INTO patient (
           PATIENT_SN
          ,SSN
          ,PHYSICIAN_SN
          ,MEDICARE_HIC_NUM
          ,ADDR_SN
          ,GENDER_CODE
          ,RACE_CODE
          ,ETHNICITY_CODE
          ,FIRST_NAME
          ,LAST_NAME
          ,MIDDLE_NAME
          ,CONTACT_PHONE_NUM
          ,EMAIL_ADDR
          ,SKYPE_ID
          ,BIRTH_DATE
          ,LEGAL_GUARDIAN_NAME
          ,LEGAL_GUARDIAN_PH
          ,created_by_user_role_id
          ,updated_by_user_role_id
      ) VALUES (
           patient_sng.nextval
          ,p_patient_rec.SSN
          ,p_patient_rec.PHYSICIAN_SN
          ,p_patient_rec.MEDICARE_HIC_NUM
          ,p_patient_rec.ADDR_SN
          ,p_patient_rec.GENDER_CODE
          ,p_patient_rec.RACE_CODE
          ,p_patient_rec.ETHNICITY_CODE
          ,p_patient_rec.FIRST_NAME
          ,p_patient_rec.LAST_NAME
          ,p_patient_rec.MIDDLE_NAME
          ,p_patient_rec.CONTACT_PHONE_NUM
          ,p_patient_rec.EMAIL_ADDR
          ,p_patient_rec.SKYPE_ID
          ,p_patient_rec.BIRTH_DATE
          ,p_patient_rec.LEGAL_GUARDIAN_NAME
          ,p_patient_rec.LEGAL_GUARDIAN_PH
          ,p_patient_rec.created_by_user_role_id
          ,p_patient_rec.updated_by_user_role_id
      )returning patient_sn
       into p_patient_rec.patient_sn
      ;
  END ins_patient;
  --
  PROCEDURE ins_physician (p_physician_rec  IN OUT  physician%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_physician');
      INSERT INTO physician (
           PHYSICIAN_SN
          ,license_num
          ,NPI
          ,COMPANY_SN
          ,physician_type_code
          ,TITLE
          ,SKYPE_ID
          ,created_by_user_role_id
          ,updated_by_user_role_id
          ,first_name
          ,last_name
          ,middle_name
          ,contact_phone_num
          ,email_addr
          ,DR_TYPE
        ) VALUES (
           physician_sng.nextval
          ,p_physician_rec.license_num
          ,p_physician_rec.NPI
          ,p_physician_rec.COMPANY_SN
          ,p_physician_rec.physician_type_code
          ,p_physician_rec.TITLE
          ,p_physician_rec.SKYPE_ID
          ,p_physician_rec.created_by_user_role_id
          ,p_physician_rec.updated_by_user_role_id
          ,p_physician_rec.first_name
          ,p_physician_rec.last_name
          ,p_physician_rec.middle_name
          ,p_physician_rec.contact_phone_num
          ,p_physician_rec.email_addr
          ,p_physician_rec.DR_TYPE
      )returning physician_sn
       into p_physician_rec.physician_sn
      ;
  END ins_physician;
  --
  PROCEDURE ins_svc_location (p_svc_location_rec  IN OUT  svc_location%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_svc_location');
      INSERT INTO svc_location (
           SVC_LOCATION_SN
          ,ADDR_SN
          ,NAME
          ,SVC_LOCATION_TYPE_CODE
          ,CONTACT_NAME
          ,PHONE_NUM_1
          ,PHONE_NUM_2
          ,FAX_NUM_1
          ,FAX_NUM_2
          ,EMAIL_ADDR
          ,created_by_user_role_id
          ,updated_by_user_role_id
          ,company_sn
        ) VALUES (
           svc_location_sng.nextval
          ,p_svc_location_rec.ADDR_SN
          ,p_svc_location_rec.NAME
          ,p_svc_location_rec.SVC_LOCATION_TYPE_CODE
          ,p_svc_location_rec.CONTACT_NAME
          ,p_svc_location_rec.PHONE_NUM_1
          ,p_svc_location_rec.PHONE_NUM_2
          ,p_svc_location_rec.FAX_NUM_1
          ,p_svc_location_rec.FAX_NUM_2
          ,p_svc_location_rec.EMAIL_ADDR
          ,p_svc_location_rec.created_by_user_role_id
          ,p_svc_location_rec.updated_by_user_role_id
          ,p_svc_location_rec.company_sn
        )returning svc_location_sn
       into p_svc_location_rec.svc_location_sn
      ;
  END ins_svc_location;
  --
  PROCEDURE ins_patient_medication (p_patient_medication_rec  IN OUT  patient_medication%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient_medication');
      INSERT INTO patient_medication (
           PATIENT_MEDICATION_SN
          ,PATIENT_SN
          ,NAME
          ,INGREDIENTS
          ,PURPOSE
          ,FREQUENCY_UNIT_CODE
          ,MEDICATION_CURRENT_FLAG
          ,PRESCRIBED_MED_FLAG
          ,NOTES
          ,created_by_user_role_id
          ,updated_by_user_role_id
          ,MEDICATION_QUANTITY
          ,MEDICATION_UNIT_CODE
        ) VALUES (
           patient_medication_sng.nextval
          ,p_patient_medication_rec.PATIENT_SN
          ,p_patient_medication_rec.NAME
          ,p_patient_medication_rec.INGREDIENTS
          ,p_patient_medication_rec.PURPOSE
          ,p_patient_medication_rec.FREQUENCY_UNIT_CODE
          ,nvl(p_patient_medication_rec.MEDICATION_CURRENT_FLAG,'Y')
          ,nvl(p_patient_medication_rec.PRESCRIBED_MED_FLAG,'Y')
          ,p_patient_medication_rec.NOTES
          ,p_patient_medication_rec.created_by_user_role_id
          ,p_patient_medication_rec.updated_by_user_role_id
          ,p_patient_medication_rec.MEDICATION_QUANTITY
          ,p_patient_medication_rec.MEDICATION_UNIT_CODE
        )returning patient_medication_sn
       into p_patient_medication_rec.patient_medication_sn
      ;
  END ins_patient_medication;
  --
  PROCEDURE ins_patient_prev_svc_remark (p_patient_prev_svc_remark_rec  IN OUT  patient_prev_svc_remark%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient_prev_svc_remark');
      INSERT INTO patient_prev_svc_remark (
           PATIENT_PREV_SVC_REMARK_SN
          ,PATIENT_PREV_SVC_SN
          ,REMARK_NOTE
        ) VALUES (
           patient_prev_svc_remark_sng.nextval
          ,p_patient_prev_svc_remark_rec.PATIENT_PREV_SVC_SN
          ,p_patient_prev_svc_remark_rec.REMARK_NOTE
      )returning patient_prev_svc_remark_sn
       into p_patient_prev_svc_remark_rec.patient_prev_svc_remark_sn
      ;
  END ins_patient_prev_svc_remark;
  --
  PROCEDURE ins_patient_prev_svc (p_patient_prev_svc_rec  IN OUT  patient_prev_svc%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient_prev_svc');
      INSERT INTO patient_prev_svc (
           PATIENT_PREV_SVC_SN
          ,PATIENT_SN
          ,PREV_SVC_BILLING_CODE
          ,SVC_DATE
          ,PROVIDER_PHYSICIAN_SN
          ,PHYSICIAN_SVC_LOCATION_SN
          ,created_by_user_role_id
          ,updated_by_user_role_id
          ,g0438_comp_on_diff_sys_flag
          ,SVC_HR_CODE
          ,SVC_MIN_CODE
          ,SVC_AM_PM_CODE
          ,PARENT_PATIENT_PREV_SVC_SN
          ,svc_number
          ,INSURANCE_COMPANY_CODE
        ) VALUES (
           patient_prev_svc_sng.nextval
          ,p_patient_prev_svc_rec.PATIENT_SN
          ,p_patient_prev_svc_rec.PREV_SVC_BILLING_CODE
          ,trunc(p_patient_prev_svc_rec.SVC_DATE)
          ,p_patient_prev_svc_rec.PROVIDER_PHYSICIAN_SN
          ,p_patient_prev_svc_rec.PHYSICIAN_SVC_LOCATION_SN
          ,p_patient_prev_svc_rec.created_by_user_role_id
          ,p_patient_prev_svc_rec.updated_by_user_role_id
          ,p_patient_prev_svc_rec.g0438_comp_on_diff_sys_flag
          ,p_patient_prev_svc_rec.SVC_HR_CODE
          ,p_patient_prev_svc_rec.SVC_MIN_CODE
          ,p_patient_prev_svc_rec.SVC_AM_PM_CODE
          ,p_patient_prev_svc_rec.PARENT_PATIENT_PREV_SVC_SN
          ,p_patient_prev_svc_rec.svc_number
          ,p_patient_prev_svc_rec.INSURANCE_COMPANY_CODE
      )returning patient_prev_svc_sn
       into p_patient_prev_svc_rec.patient_prev_svc_sn
      ;
  END ins_patient_prev_svc;
  --
  PROCEDURE ins_patient_response (p_patient_response_rec  IN OUT  patient_response%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient_response');
      INSERT INTO patient_response (
           PATIENT_RESPONSE_SN
          ,PATIENT_PREV_SVC_SN
          ,QUESTION_RESPONSE_CODE
        ) VALUES (
           patient_response_sng.nextval
          ,p_patient_response_rec.PATIENT_PREV_SVC_SN
          ,p_patient_response_rec.QUESTION_RESPONSE_CODE
      )returning patient_response_sn
       into p_patient_response_rec.patient_response_sn
      ;
  END ins_patient_response;
  --
  PROCEDURE ins_patient_history (p_patient_history_rec  IN OUT  patient_history%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_patient_history');
      INSERT INTO patient_history (
           PATIENT_HISTORY_SN
          ,PATIENT_SN
          ,QUESTION_RESPONSE_CODE
        ) VALUES (
           patient_history_sng.nextval
          ,p_patient_history_rec.PATIENT_SN
          ,p_patient_history_rec.QUESTION_RESPONSE_CODE
      )returning patient_history_sn
       into p_patient_history_rec.patient_history_sn
      ;
  END ins_patient_history;  
  --
  PROCEDURE ins_provider_physician (p_provider_physician_rec  IN OUT  provider_physician%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_provider_physician');
      INSERT INTO provider_physician (
           provider_physician_SN
          ,license_num
          ,NPI
          ,COMPANY_SN
          ,physician_type_code
          ,physician_user_role_id
          ,TITLE
          ,SKYPE_ID
          ,created_by_user_role_id
          ,updated_by_user_role_id
          ,first_name
          ,last_name
          ,middle_name
          ,contact_phone_num
          ,email_addr
          ,dr_type
        ) VALUES (
           provider_physician_sng.nextval
          ,p_provider_physician_rec.license_num
          ,p_provider_physician_rec.NPI
          ,p_provider_physician_rec.COMPANY_SN
          ,p_provider_physician_rec.physician_type_code
          ,p_provider_physician_rec.physician_user_role_id
          ,p_provider_physician_rec.TITLE
          ,p_provider_physician_rec.SKYPE_ID
          ,p_provider_physician_rec.created_by_user_role_id
          ,p_provider_physician_rec.updated_by_user_role_id
          ,p_provider_physician_rec.first_name
          ,p_provider_physician_rec.last_name
          ,p_provider_physician_rec.middle_name
          ,p_provider_physician_rec.contact_phone_num
          ,p_provider_physician_rec.email_addr
          ,p_provider_physician_rec.dr_type
      )returning provider_physician_sn
       into p_provider_physician_rec.provider_physician_sn
      ;
  END ins_provider_physician;
  --
  PROCEDURE ins_physician_svc_location (p_physician_svc_location_rec  IN OUT  physician_svc_location%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_physician_svc_location');
      INSERT INTO physician_svc_location (
           physician_svc_location_sn
          ,physician_sn
          ,svc_location_sn
          ,created_by_user_role_id
          ,updated_by_user_role_id
        ) VALUES (
           physician_svc_location_sng.nextval
          ,p_physician_svc_location_rec.physician_sn
          ,p_physician_svc_location_rec.svc_location_sn
          ,p_physician_svc_location_rec.created_by_user_role_id
          ,p_physician_svc_location_rec.updated_by_user_role_id
      )returning physician_svc_location_sn
       into p_physician_svc_location_rec.physician_svc_location_sn
      ;
  END ins_physician_svc_location;
  --
  PROCEDURE ins_user_svc_location (p_user_svc_location_rec  IN OUT  user_svc_location%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_user_svc_location');
      INSERT INTO user_svc_location (
           user_svc_location_sn
          ,user_role_id
          ,svc_location_sn
          ,created_by_user_role_id
          ,updated_by_user_role_id
        ) VALUES (
           user_svc_location_sng.nextval
          ,p_user_svc_location_rec.user_role_id
          ,p_user_svc_location_rec.svc_location_sn
          ,p_user_svc_location_rec.created_by_user_role_id
          ,p_user_svc_location_rec.updated_by_user_role_id
      )returning user_svc_location_sn
       into p_user_svc_location_rec.user_svc_location_sn
      ;
  END ins_user_svc_location;
  --
  PROCEDURE ins_user_company (p_user_company_rec  IN OUT  user_company%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_user_company');
      INSERT INTO user_company (
           user_company_sn
          ,user_role_id
          ,company_sn
          ,created_by_user_role_id
          ,updated_by_user_role_id
        ) VALUES (
           user_company_sng.nextval
          ,p_user_company_rec.user_role_id
          ,p_user_company_rec.company_sn
          ,p_user_company_rec.created_by_user_role_id
          ,p_user_company_rec.updated_by_user_role_id
      )returning user_company_sn
       into p_user_company_rec.user_company_sn
      ;
  END ins_user_company;
  --
  PROCEDURE ins_user_physician (p_user_physician_rec  IN OUT  user_physician%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_user_physician');
      INSERT INTO user_physician (
           user_physician_sn
          ,user_role_id
          ,physician_sn
          ,created_by_user_role_id
          ,updated_by_user_role_id
        ) VALUES (
           user_physician_sng.nextval
          ,p_user_physician_rec.user_role_id
          ,p_user_physician_rec.physician_sn
          ,p_user_physician_rec.created_by_user_role_id
          ,p_user_physician_rec.updated_by_user_role_id
      )returning user_physician_sn
       into p_user_physician_rec.user_physician_sn
      ;
  END ins_user_physician;
  --
  PROCEDURE ins_upd_svc_result (p_svc_result_rec  IN OUT  svc_result%rowtype) is
  BEGIN
      v_proc_name  := upper('ins_upd_svc_result');
      INSERT INTO svc_result (
           svc_result_sn
          ,patient_prev_svc_sn
          ,disease_code
          ,disease_level_code
          ,disease_severity_code
          ,obesity_rf_avail_flag
        ) VALUES (
           svc_result_sng.nextval
          ,p_svc_result_rec.patient_prev_svc_sn
          ,p_svc_result_rec.disease_code
          ,p_svc_result_rec.disease_level_code
          ,p_svc_result_rec.disease_severity_code
          ,p_svc_result_rec.obesity_rf_avail_flag
      )returning svc_result_sn into p_svc_result_rec.svc_result_sn
      ;
  exception
    when dup_val_on_index then
      update svc_result
      set disease_level_code = p_svc_result_rec.disease_level_code
         ,disease_severity_code = p_svc_result_rec.disease_severity_code
      where patient_prev_svc_sn = p_svc_result_rec.patient_prev_svc_sn
      and disease_code = p_svc_result_rec.disease_code
      returning svc_result_sn into p_svc_result_rec.svc_result_sn
      ;
  end ins_upd_svc_result;
  --
  PROCEDURE ins_physician_em (p_physician_em_rec  IN OUT  physician_em%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_physician_em');
      INSERT INTO physician_em (
           physician_em_sn
          ,patient_prev_svc_sn
          ,temp_in_fahrenheit
          ,SYSTOLIC_BP_IN_MM
          ,DIASTOLIC_BP_IN_MM
          ,pulse_rate_in_bpm
          ,respiratory_rate_in_bpm
          ,rhythm_ind
          ,preventative_scheduling
          ,lab_and_test_prescribed
          ,referrals_to_specialist
          ,rx_maj_dis_or_health_event
          ,RX_PREV_SVC_BILLING_CODE
          ,physician_SIGNATURE
        ) VALUES (
           physician_em_sng.nextval
          ,p_physician_em_rec.patient_prev_svc_sn
          ,p_physician_em_rec.temp_in_fahrenheit
          ,p_physician_em_rec.SYSTOLIC_BP_IN_MM
          ,p_physician_em_rec.DIASTOLIC_BP_IN_MM
          ,p_physician_em_rec.pulse_rate_in_bpm
          ,p_physician_em_rec.respiratory_rate_in_bpm
          ,p_physician_em_rec.rhythm_ind
          ,p_physician_em_rec.preventative_scheduling
          ,p_physician_em_rec.lab_and_test_prescribed
          ,p_physician_em_rec.referrals_to_specialist
          ,p_physician_em_rec.rx_maj_dis_or_health_event
          ,p_physician_em_rec.RX_PREV_SVC_BILLING_CODE
          ,p_physician_em_rec.physician_SIGNATURE
      )returning physician_em_sn
       into p_physician_em_rec.physician_em_sn
      ;
  END ins_physician_em;
  --
  PROCEDURE ins_physician_em_name (p_physician_em_name_rec  IN OUT  physician_em_name%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_physician_em_name');
      INSERT INTO physician_em_name (
           physician_em_name_sn
          ,physician_em_sn
          ,em_name_code
        ) VALUES (
           physician_em_name_sng.nextval
          ,p_physician_em_name_rec.physician_em_sn
          ,p_physician_em_name_rec.em_name_code
      )returning physician_em_name_sn
       into p_physician_em_name_rec.physician_em_name_sn
      ;
  END ins_physician_em_name;
  --
  PROCEDURE ins_provider_ccm (p_provider_ccm_rec  IN OUT  provider_ccm%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_provider_ccm');
      INSERT INTO provider_ccm (
           provider_ccm_sn
          ,patient_prev_svc_sn
          ,symptom_comment
          ,additional_notes
          ,medication_comment
          ,family_pmhx_comment
          ,rf_comment
          ,disease_comment
          ,ccm_followup_svc_date
          ,ccm_followup_svc_hr_code
          ,ccm_followup_svc_min_code
          ,ccm_followup_svc_am_pm_code
        ) VALUES (
           provider_ccm_sng.nextval
          ,p_provider_ccm_rec.patient_prev_svc_sn
          ,p_provider_ccm_rec.symptom_comment
          ,p_provider_ccm_rec.additional_notes
          ,p_provider_ccm_rec.medication_comment
          ,p_provider_ccm_rec.family_pmhx_comment
          ,p_provider_ccm_rec.rf_comment
          ,p_provider_ccm_rec.disease_comment
          ,p_provider_ccm_rec.ccm_followup_svc_date
          ,p_provider_ccm_rec.ccm_followup_svc_hr_code
          ,p_provider_ccm_rec.ccm_followup_svc_min_code
          ,p_provider_ccm_rec.ccm_followup_svc_am_pm_code
      )returning provider_ccm_sn
       into p_provider_ccm_rec.provider_ccm_sn
      ;
  END ins_provider_ccm;  
  --
  PROCEDURE ins_provider_ccm_question (p_provider_ccm_question_rec  IN OUT  provider_ccm_question%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_provider_ccm_question');
      INSERT INTO provider_ccm_question (
           provider_ccm_question_sn
          ,provider_ccm_sn
          ,ccm_question_code
        ) VALUES (
           provider_ccm_question_sng.nextval
          ,p_provider_ccm_question_rec.provider_ccm_sn
          ,p_provider_ccm_question_rec.ccm_question_code
      )returning provider_ccm_question_sn
       into p_provider_ccm_question_rec.provider_ccm_question_sn
      ;
  END ins_provider_ccm_question;
  --
  PROCEDURE ins_contact_us (p_contact_us_rec  IN OUT  contact_us%rowtype) IS

  BEGIN
      v_proc_name  := upper('ins_contact_us');
      INSERT INTO contact_us (
           CONTACT_US_SN
          ,FIRST_NAME
          ,LAST_NAME
          ,EMAIL
          ,PHONE_NUMBER
          ,SUBJECT
          ,MESSAGE
      ) VALUES (
           contact_us_sng.nextval
          ,p_contact_us_rec.FIRST_NAME
          ,p_contact_us_rec.LAST_NAME
          ,p_contact_us_rec.EMAIL
          ,p_contact_us_rec.PHONE_NUMBER
          ,p_contact_us_rec.SUBJECT
          ,p_contact_us_rec.MESSAGE
      )returning contact_us_sn
       into p_contact_us_rec.contact_us_sn
      ;
  END ins_contact_us;
  --
  PROCEDURE ins_user_login (p_user_role_id in varchar2,p_PACKAGE_NAME in varchar2,p_PROCEDURE_NAME in varchar2,p_LATITUDE in number,p_LONGITUDE in number,p_BROWSER_NAME in varchar2,p_IP_ADDR in varchar2,p_PREF_LOCALE in varchar2) IS

  BEGIN
      v_proc_name  := upper('ins_user_login');

      INSERT INTO user_login (
           USER_LOGIN_SN
          ,USER_ROLE_ID
          ,PACKAGE_NAME
          ,PROCEDURE_NAME
          ,LATITUDE
          ,LONGITUDE
          ,BROWSER_NAME
          ,IP_ADDR
          ,PREF_LOCALE
      ) VALUES (
           user_login_sng.nextval
          ,p_USER_ROLE_ID
          ,p_PACKAGE_NAME
          ,p_PROCEDURE_NAME
          ,p_LATITUDE
          ,p_LONGITUDE
          ,p_BROWSER_NAME
          ,p_IP_ADDR
          ,p_PREF_LOCALE
      );
      commit;
  END ins_user_login;
END common_dml_pkg;
/
show errors