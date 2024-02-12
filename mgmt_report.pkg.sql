create or replace PACKAGE mgmt_report_pkg IS
  v_pkg_name    varchar2 (30) := upper('mgmt_report_pkg');
  v_proc_name   varchar2(30);
  v_status      varchar2(20);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  function projected_billing_code (p_age in number,p_hic in varchar2,p_svc_type_code in varchar2,p_billing_code in varchar2) return varchar2;
  PROCEDURE patient_em_rpt (p_locale in varchar2,p_rpt_ind in varchar2,p_out OUT clob);
  PROCEDURE priviledge_report_list (p_locale in varchar2,p_priviledge_code in varchar2,p_out OUT clob);
  PROCEDURE svc_completion_rpt (p_locale in varchar2,p_svc_location_sn in svc_location.svc_location_sn%type,p_svc_code in list_prev_svc_billing.prev_svc_billing_code%type,p_begin_date in varchar2,p_end_date in varchar2,p_pmt_ind in varchar2,p_out OUT clob);
  function patient_detail_info (p_patient_sn in number) return json_list;
  function patient_services (p_patient_sn in number,p_completed_flag in varchar2) return json_list;
  function patient_counselling_services (p_patient_sn in number) return json_list;
  function rana_patient_with_obesity(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_svc_comp_dtl(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_svc_comp_summ(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_patient_with_fall_risk(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_patient_qualify_em(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_patient_with_cvd(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_patient_with_alco(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rana_patient_with_tbco(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list;
  function rlss_scheduled_services(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_upto in date) return json_list;
  function rnpi_company_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_location_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_physician_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_provider_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_patient_with_next_awv(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_438_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_439_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_ccm_scrn_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_ccm_20_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_ccm_60_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_obes_scrn_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  function rnpi_obes_cnsl_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list;
  PROCEDURE patient_inquiry(p_locale in varchar2,p_report_code in varchar2,p_patient_sn in number,p_out OUT clob);
  PROCEDURE analytical_data(p_locale in varchar2,p_user in varchar2,p_report_code in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in varchar2,p_svc_dt_end in varchar2,p_out OUT clob);
  PROCEDURE scheduled_service_data(p_locale in varchar2,p_user in varchar2,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_upto in varchar2,p_out OUT clob);
  PROCEDURE other_inquiry(p_locale in varchar2,p_user in varchar2,p_report_code in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_out OUT clob);
END mgmt_report_pkg;
/
show errors
create or replace PACKAGE BODY mgmt_report_pkg IS
  --This procedure will return data for all the reports under priviledge_code = 'RNPI'
  PROCEDURE other_inquiry(p_locale in varchar2,p_user in varchar2,p_report_code in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_out OUT clob)
  as
    obj         json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    --
    v_report_name varchar2(500);
    v_title varchar2(1000);
    v_sub_title varchar2(2000);
    v_company_sn number(11);
    v_company_name varchar2(200);
    v_svc_location_name varchar2(200);
    v_physician_name varchar2(200);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_svc_location_sn number(11);
    v_physician_sn number(11);
  begin
    v_proc_name := upper('other_inquiry');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_report_code: '||p_report_code||'-p_company_sn: '||p_company_sn||'-p_svc_location_sn: '||p_svc_location_sn||'-p_physician_sn: '||p_physician_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    v_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
    --status initialization
    v_status := 'SUCCESSFUL';
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --Company selection have data isolation built in by the user login id
    if p_report_code is null then
      v_status := 'FAILED';
      v_msg := 'Report Name Selection is required.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'Login user email is required.';
    end if;
    if p_report_code is not null then
      begin
        select short_descr
        into v_report_name
        from report_lang
        where report_code = p_report_code
        and lang_code = 'en'
        ;
      exception
        when no_data_found then v_report_name := null;
      end;
    end if;
    if p_company_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_company_sn := admin_inq_pkg.sn_when_null('COM',v_user_role_id);
    else --not null
      v_company_sn := p_company_sn;
      begin
        select name into v_company_name from company where company_sn = p_company_sn;
      exception
        when no_data_found then v_company_name := null;
      end;
    end if;
    if p_svc_location_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_svc_location_sn := admin_inq_pkg.sn_when_null('LOC',v_user_role_id);
    else --not null
      v_svc_location_sn := p_svc_location_sn;
      begin
        select name into v_svc_location_name from svc_location where svc_location_sn = p_svc_location_sn;
      exception
        when no_data_found then v_svc_location_name := null;
      end;
    end if;
    if p_physician_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_physician_sn := admin_inq_pkg.sn_when_null('PHY',v_user_role_id);
    else --not null
      v_physician_sn := p_physician_sn;
      begin
        select name into v_physician_name from physician_vw where physician_sn = p_physician_sn;
      exception
        when no_data_found then v_physician_name := null;
      end;
    end if;
    --
    v_title := v_report_name;
    v_sub_title := 'Company: '||v_company_name||' - Location: '||v_svc_location_name||' - Physician: '||v_physician_name;
    obj.put('TITLE',v_title);
    obj.put('SUB_TITLE1',v_sub_title);
    --
    if v_status = 'SUCCESSFUL' then --lets start preparing for the p_out
      if p_report_code = 'RCOM' then --List of Company
        l_obj := rnpi_company_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RLOC' then --List of Location
        l_obj := rnpi_location_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RPHY' then --List of Physician
        l_obj := rnpi_physician_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RPRO' then --List of Service Provider
        l_obj := rnpi_provider_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RPAT' then --List of Patient
        l_obj := rnpi_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RNAW' then --List of Patient with Next AWV Date
        l_obj := rnpi_patient_with_next_awv(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'R438' then --List of G0438 Patient
        l_obj := rnpi_438_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'R439' then --List of G0439 Patient
        l_obj := rnpi_439_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RCEM' then --List of EM (CCM) Patient
        l_obj := rnpi_ccm_scrn_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RCC2' then --List of CCM (20 min) Patient
        l_obj := rnpi_ccm_20_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'RCC6' then --List of CCM (60 min) Patient
        l_obj := rnpi_ccm_60_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'ROBL' then --List of Obesity Screeing Patient
        l_obj := rnpi_obes_scrn_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      elsif p_report_code = 'ROBC' then --List of Obesity Counseling Patient
        l_obj := rnpi_obes_cnsl_patient_list(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn);
      end if;
    end if;
    --
    if json_ac.array_count(l_obj) > 0 then
      v_msg := 'Data returned successfully..';
    else
      v_msg := 'No Data returned with these criteria..';
    end if;
    --
    obj.put('report_data',l_obj);
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end other_inquiry;
  --
  function rnpi_provider_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select company_sn
                    ,company_name
                    ,count(*) total_cnt
              from provider_physician_vw
              where (p_company_sn is null or company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and status = 'Active'
              group by company_sn
                      ,company_name
              order by company_name
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.company_name||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select name
                      ,phone
                      ,email
                      ,physician_type
                      ,addr
                from provider_physician_vw
                where company_sn = i.company_sn
                and status = 'Active'
                order by name
                )
      loop
        v_str2 := 'Name: '||j.name||' - '||'Address: '||j.addr||' - '||'Phone: '||j.phone||' - '||'Email: '||j.email||' - '||'Type: '||j.physician_type;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_provider_list;
  --
  function rnpi_company_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    l_obj json_list := json_list();
    v_str1      varchar2(2000);
  begin
    for i in (select name
                    ,contact_name
                    ,phone
                    ,fax
                    ,toll_free
                    ,website
                    ,addr
              from company_vw
              where status = 'Active'
              and (p_company_sn is null or company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              order by name
              )
    loop
      v_str1 := 'Name: '||i.name||' - '||'Contact: '||i.contact_name||' - '||'Phone: '||i.phone||' - '||'Fax: '||i.fax||' - '||'Toll Free: '||i.toll_free||' - '||'Website: '||i.website||' - '||'Address: '||i.addr;
      l_obj.append(v_str1);
    end loop;
    return l_obj;
  end rnpi_company_list;  
  --
  function rnpi_location_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select company_sn
                    ,company_name
                    ,count(*) total_cnt
              from svc_location_vw
              where (p_company_sn is null or company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              group by company_sn
                      ,company_name
              order by company_name
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.company_name||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select name
                      ,contact_name
                      ,phone
                      ,fax
                      ,email
                      ,svc_location_type
                      ,addr
                from svc_location_vw
                where company_sn = i.company_sn
                order by name
                )
      loop
        v_str2 := 'Name: '||j.name||' - '||'Address: '||j.addr||' - '||'Contact: '||j.contact_name||' - '||'Phone: '||j.phone||' - '||'Fax: '||j.fax||' - '||'Email: '||j.email||' - '||'Type: '||j.svc_location_type;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_location_list;
  --
  function rnpi_physician_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select company_sn
                    ,physician_company_name
                    ,count(*) total_cnt
              from physician_svc_location_vw
              where (p_company_sn is null or company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              group by company_sn
                      ,physician_company_name
              order by physician_company_name
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company_name||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select svc_location_name
                      ,svc_location_addr
                      ,svc_location_sn
                      ,count(*) total_cnt
                from physician_svc_location_vw
                where company_sn = i.company_sn
                and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
                group by svc_location_name
                        ,svc_location_addr
                        ,svc_location_sn
                order by svc_location_name
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Location: '||j.svc_location_name||' ('||j.svc_location_addr||') - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select pv.name||', '||pv.dr_type_code physician
                        ,pv.physician_type
                        ,license_num
                        ,npi
                        ,email
                        ,phone
                  from physician_svc_location_vw pslv
                      ,physician_vw pv
                  where pslv.physician_sn = pv.physician_sn
                  and pslv.svc_location_sn = j.svc_location_sn
                  order by pv.name
                  )
        loop
          v_str3 := 'Physician: '||k.physician||' ('||k.physician_type||') - License: '||k.license_num||' - '||'NPI: '||k.npi||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email;
          l_obj3.append(v_str3);
        end loop;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_physician_list;
  --
  function rnpi_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_patient_list;
  --
  function rnpi_patient_with_next_awv(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (with latest_awv_pps as
                      (select pps.patient_sn,max(pps.patient_prev_svc_sn) patient_prev_svc_sn
                      from patient_prev_svc pps
                          ,patient p
                      where pps.patient_sn = p.patient_sn 
                      and pps.prev_svc_billing_code in ('G0438','G0439')
                      and pps.svc_comp_flag = 'Y'
                      and p.physician_sn = j.physician_sn
                      group by pps.patient_sn
                      )
                  select add_months(pps.svc_perform_date,12) next_awv_date
                        ,pv.name
                        ,pv.medicare_hic_num
                        ,pv.addr
                        ,pv.gender
                        ,pv.race
                        ,pv.email
                        ,pv.phone
                        ,pv.birth_date
                        ,pv.age
                  from patient_prev_svc pps
                      ,latest_awv_pps lpps
                      ,patient_vw pv
                  where pps.patient_prev_svc_sn = lpps.patient_prev_svc_sn
                  and pps.patient_sn = pv.patient_sn
                  order by 1
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - Next AWV Date: '||k.next_awv_date||' - '||'HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_patient_with_next_awv;
  --
  function rnpi_438_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_G0438(j.physician_sn)))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_438_patient_list;
  --
  function rnpi_439_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_G0439(j.physician_sn)))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_439_patient_list;
  --
  function rnpi_ccm_scrn_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_99202(j.physician_sn)))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_ccm_scrn_patient_list;
  --
  function rnpi_ccm_20_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_ccm(j.physician_sn,'99490')))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_ccm_20_patient_list;
  --
  function rnpi_ccm_60_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_ccm(j.physician_sn,'99487')))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_ccm_60_patient_list;
  --
  function rnpi_obes_scrn_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_G0449(j.physician_sn)))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_obes_scrn_patient_list;
  --
  function rnpi_obes_cnsl_patient_list(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select physician_company_sn
                    ,physician_company
                    ,count(*) total_cnt
              from patient_vw
              where (p_company_sn is null or physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              group by physician_company_sn
                      ,physician_company
              order by physician_company
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.physician_company||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select physician_sn
                      ,physician_name||', '||dr_type_code physician
                      ,count(*) total_cnt
                from patient_vw
                where physician_company_sn = i.physician_company_sn
                and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
                group by physician_sn
                        ,physician_name||', '||dr_type_code
                order by 2
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Physician: '||j.physician||' - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select name
                        ,medicare_hic_num
                        ,addr
                        ,gender
                        ,race
                        ,email
                        ,phone
                        ,birth_date
                        ,age
                  from patient_vw
                  where physician_sn = j.physician_sn
                  and patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_G0447(j.physician_sn)))
                  order by name
                  )
        loop
          v_str3 := 'Name: '||k.name||' ('||k.gender||'/'||k.age||'yr/'||k.race||') - HIC: '||k.medicare_hic_num||' - '||'Birth Date: '||k.birth_date||' - '||'Phone: '||k.phone||' - '||'Email: '||k.email||' - '||'Address: '||k.addr;
          l_obj3.append(v_str3);
        end loop;
        if json_ac.array_count(l_obj3) = 0 then
          l_obj3.append('No Patient Found');
        end if;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rnpi_obes_cnsl_patient_list;
  --
  function projected_billing_code (p_age in number,p_hic in varchar2,p_svc_type_code in varchar2,p_billing_code in varchar2) return varchar2
  is
    v_return varchar2(5);
  begin
    if p_svc_type_code = 'AWV' then
      if report_pkg.medicare_ins_by_hic_flag(p_hic) = 'Y' then
        v_return := p_billing_code;
      else --commercial
        if p_billing_code = 'G0438' then
          if p_age between 18 and 39 then
            v_return := '99385';
          elsif p_age between 40 and 64 then
            v_return := '99386';
          else
            v_return := p_billing_code;
          end if;
        else --G0439
          if p_age between 18 and 39 then
            v_return := '99395';
          elsif p_age between 40 and 64 then
            v_return := '99396';
          else
            v_return := p_billing_code;
          end if;
        end if;
      end if;
    else
      v_return := p_billing_code;
    end if;
    return v_return;
  end projected_billing_code;
  --This procedure will return data for all the reports under priviledge_code = 'RSVC'
  PROCEDURE scheduled_service_data(p_locale in varchar2,p_user in varchar2,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_upto in varchar2,p_out OUT clob)
  as
    obj         json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    --
    v_title varchar2(1000);
    v_sub_title varchar2(2000);
    v_company_sn number(11);
    v_provider_name varchar2(200);
    v_prev_svc_billing_name varchar2(200);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_svc_dt_upto date;
  begin
    v_proc_name := upper('scheduled_service_data');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_provider_physician_sn: '||p_provider_physician_sn||'-p_prev_svc_billing_code: '||p_prev_svc_billing_code||'-p_svc_dt_upto: '||p_svc_dt_upto;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    v_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
    --status initialization
    v_status := 'SUCCESSFUL';
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    --Company selection have data isolation built in by the user login id
    if p_user is null then
      v_status := 'FAILED';
      v_msg := 'Login user email is required.';
    end if;
    --
    if p_svc_dt_upto is not null then
      v_svc_dt_upto := to_date(p_svc_dt_upto,'YYYY-MM-DD');
    end if;    
    if p_provider_physician_sn is null then
      v_company_sn := admin_inq_pkg.sn_when_null('COM',v_user_role_id);
    else
      v_company_sn := null;
      begin
        select title_code||' '||name into v_provider_name from provider_physician_vw where provider_physician_sn = p_provider_physician_sn;
      exception
        when no_data_found then v_provider_name := null;
      end;
    end if;
    if p_prev_svc_billing_code is not null then
      begin
        select short_descr into v_prev_svc_billing_name from prev_svc_billing_lang where prev_svc_billing_code = p_prev_svc_billing_code and lang_code = v_lang_code;
      exception
        when no_data_found then v_prev_svc_billing_name := null;
      end;
    end if;
    --
    v_title := 'LIST OF SCHEDULED SERVICES';
    v_sub_title := 'Interviewer: '||v_provider_name||' - Svc Name: '||v_prev_svc_billing_name;
    obj.put('TITLE',v_title);
    obj.put('SUB_TITLE1',v_sub_title);
    --
    if v_status = 'SUCCESSFUL' then --lets start preparing for the p_out
      l_obj := rlss_scheduled_services(v_user_role_id,v_company_sn,p_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_upto);
    end if;
    --
    if json_ac.array_count(l_obj) > 0 then
      v_msg := 'Data returned successfully..';
    else
      v_msg := 'No Data returned with these criteria..';
    end if;
    --
    obj.put('report_data',l_obj);
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end scheduled_service_data;  
  --
  function rlss_scheduled_services(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_upto in date) return json_list
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    l_obj3 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
    v_str3      varchar2(2000);
  begin
    for i in (select provider_physician_sn
                    ,provider_physician_company
                    ,case 
                      when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                      else provider_title||' '||provider_physician_name
                      end provider                    
                    ,count(*) total_cnt
              from pps_simplified_vw pv
              where pv.completed_flag = 'N'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_upto is null or svc_date <= p_svc_dt_upto + 1)
              group by provider_physician_sn
                      ,provider_physician_company
                      ,case 
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end                    
              order by 2
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Provider: '||i.provider||' ('||i.provider_physician_company||') - Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_physician_company_sn
                      ,pv.pat_primary_physician_company
                      ,pv.svc_location_sn
                      ,pv.svc_location_name
                      ,pv.svc_location_addr
                      ,pv.physician_sn
                      ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                      ,count(*) total_cnt
                from pps_simplified_vw pv
                where pv.completed_flag = 'N'
                and provider_physician_sn = i.provider_physician_sn
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_upto is null or svc_date <= p_svc_dt_upto + 1)
                group by pv.pat_physician_company_sn
                        ,pv.pat_primary_physician_company
                        ,pv.svc_location_sn
                        ,pv.svc_location_name
                        ,pv.svc_location_addr
                        ,pv.physician_sn
                        ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
                order by pat_primary_physician_company,svc_location_name,physician
                )
      loop
        obj2 := json(); --an empty structure
        v_str2 := 'Location: '||j.svc_location_name||' ('||j.svc_location_addr||') - Physician: '||j.physician||' ('||j.pat_primary_physician_company||') - Count: '||j.total_cnt;
        obj2.put('TITLE',v_str2);
        --
        l_obj3 := json_list();
        for k in (select pv.pat_name
                        ,pv.pat_phone
                        ,to_char(pv.svc_date,'MM/DD/YYYY') svc_date
                        ,pv.age
                        ,pat_gender
                        ,case
                          when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                          else 'Commercial'
                          end insurance_type
                        ,pv.insurance_company_name
                        ,pv.svc_type_code
                        ,pv.billing_code_descr
                  from pps_simplified_vw pv
                  where pv.completed_flag = 'N'
                  and provider_physician_sn = i.provider_physician_sn
                  and pat_physician_company_sn = j.pat_physician_company_sn
                  and svc_location_sn = j.svc_location_sn
                  and physician_sn = j.physician_sn
                  and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                  and (p_svc_dt_upto is null or svc_date <= p_svc_dt_upto + 1)
                  order by svc_type_code,billing_code_descr,pat_name,svc_date
                  )
        loop
          v_str3 := 'Patient: '||k.pat_name||' ('||k.pat_gender||'/'||k.age||'yr/'||k.pat_phone||'/'||k.insurance_company_name||') - Service Date: '||k.svc_date||' - '||'Service: '||k.billing_code_descr||' ('||k.svc_type_code||')';
          l_obj3.append(v_str3);
        end loop;
        obj2.put('TITLE_DATA',l_obj3);
        l_obj2.append(obj2.to_json_value);
      end loop;      
      obj.put('TITLE_DATA',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rlss_scheduled_services;
  --This procedure will return data for all the reports under priviledge_code = 'RANA'
  PROCEDURE analytical_data(p_locale in varchar2,p_user in varchar2,p_report_code in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in varchar2,p_svc_dt_end in varchar2,p_out OUT clob)
  as
    obj         json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    --
    v_report_name varchar2(500);
    v_title varchar2(1000);
    v_sub_title varchar2(2000);
    v_svc_dt_begin date;
    v_svc_dt_end date;
    v_company_sn number(11);
    v_company_name varchar2(200);
    v_svc_location_name varchar2(200);
    v_physician_name varchar2(200);
    v_prev_svc_billing_name varchar2(200);
    v_days_between number(11);
    v_provider_physician_sn provider_physician.provider_physician_sn%type;
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_svc_location_sn number(11);
    v_physician_sn number(11);
  begin
    v_proc_name := upper('analytical_data');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_report_code: '||p_report_code||'-p_company_sn: '||p_company_sn||'-p_svc_location_sn: '||p_svc_location_sn||'-p_physician_sn: '||p_physician_sn||'-p_prev_svc_billing_code: '||p_prev_svc_billing_code||'-p_svc_dt_begin: '||p_svc_dt_begin||'-p_svc_dt_end: '||p_svc_dt_end;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    v_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
    --status initialization
    v_status := 'SUCCESSFUL';
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    if p_svc_dt_begin is not null then
      v_svc_dt_begin := to_date(p_svc_dt_begin,'YYYY-MM-DD');
    end if;
    if p_svc_dt_end is not null then
      v_svc_dt_end := to_date(p_svc_dt_end,'YYYY-MM-DD');
    end if;    
    --Company selection have data isolation built in by the user login id
    if p_report_code is null then
      v_status := 'FAILED';
      v_msg := 'Report Name Selection is required.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'Login user email is required.';
    elsif (p_svc_dt_begin is not null and p_svc_dt_end is null) then
      v_status := 'FAILED';
      v_msg := 'Service End Date is required when Begin date is entered.';
    elsif (p_svc_dt_begin is null and p_svc_dt_end is not null) then
      v_status := 'FAILED';
      v_msg := 'Service Begin Date is required when End date is entered.';
    else
      if (p_svc_dt_begin is not null and p_svc_dt_end is not null) then
        v_days_between := v_svc_dt_end - v_svc_dt_begin;
        if v_days_between < 0 then
          v_status := 'FAILED';
          v_msg := 'Service End Date MUST BE greater than Begin Date.';
        end if;
      end if;
    end if;
    if p_report_code is not null then
      begin
        select short_descr
        into v_report_name
        from report_lang
        where report_code = p_report_code
        and lang_code = 'en'
        ;
      exception
        when no_data_found then v_report_name := null;
      end;
    end if;
    if p_company_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_company_sn := admin_inq_pkg.sn_when_null('COM',v_user_role_id);
    else --not null
      v_company_sn := p_company_sn;
      begin
        select name into v_company_name from company where company_sn = p_company_sn;
      exception
        when no_data_found then v_company_name := null;
      end;
    end if;
    if p_svc_location_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_svc_location_sn := admin_inq_pkg.sn_when_null('LOC',v_user_role_id);
    else --not null
      v_svc_location_sn := p_svc_location_sn;
      begin
        select name into v_svc_location_name from svc_location where svc_location_sn = p_svc_location_sn;
      exception
        when no_data_found then v_svc_location_name := null;
      end;
    end if;
    if p_physician_sn is null then
      --When user search patient with out location or physician drop down selection (they are optional). 
      --check if the user have any svc_location exception. If there are exception, then user can only select patient in that location
      v_physician_sn := admin_inq_pkg.sn_when_null('PHY',v_user_role_id);
    else --not null
      v_physician_sn := p_physician_sn;
      begin
        select name into v_physician_name from physician_vw where physician_sn = p_physician_sn;
      exception
        when no_data_found then v_physician_name := null;
      end;
    end if;
    if p_prev_svc_billing_code is not null then
      begin
        select short_descr into v_prev_svc_billing_name from prev_svc_billing_lang where prev_svc_billing_code = p_prev_svc_billing_code and lang_code = v_lang_code;
      exception
        when no_data_found then v_prev_svc_billing_name := null;
      end;
    end if;
    --
    v_title := v_report_name;
    v_sub_title := 'Company: '||v_company_name||' - Location: '||v_svc_location_name||' - Physician: '||v_physician_name||' - Svc Name: '||v_prev_svc_billing_name||' - Svc Date Begin: '||p_svc_dt_begin||' - Svc Date End: '||p_svc_dt_end;
    obj.put('TITLE',v_title);
    obj.put('SUB_TITLE1',v_sub_title);
    --
    if v_status = 'SUCCESSFUL' then --lets start preparing for the p_out
      begin
        --check to see if the user is a service provider role only. In that case, user can see only his/her patient information
        select pp.provider_physician_sn
        into v_provider_physician_sn
        from user_vw uv
            ,provider_physician pp
        where uv.user_role_id = pp.physician_user_role_id
        and uv.role_id = '79F450777D2E4B6AB98FECB17974FDEB' --service provider
        and uv.user_name = lower(p_user)
        ;
      exception
        when no_data_found then
          v_provider_physician_sn := null;
      end;
      --    
      if p_report_code = 'ROBS' then --Patients with Obesity
        l_obj := rana_patient_with_obesity(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RSCD' then --Service Complete Details
        l_obj := rana_svc_comp_dtl(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RSCS' then --Service Complete Summary
        l_obj := rana_svc_comp_summ(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RFAL' then --Patients with Risk of Fall
        l_obj := rana_patient_with_fall_risk(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'REMP' then --Patients Qualified for EM
        l_obj := rana_patient_qualify_em(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RCVD' then --Patients with CVD
        l_obj := rana_patient_with_cvd(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RALC' then --Patients with Alcohol Drinking Issue
        l_obj := rana_patient_with_alco(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      elsif p_report_code = 'RTBC' then --Patients with Tobacco Issue
        l_obj := rana_patient_with_tbco(v_user_role_id,v_company_sn,v_svc_location_sn,v_physician_sn,v_provider_physician_sn,p_prev_svc_billing_code,v_svc_dt_begin,v_svc_dt_end);
      end if;
      --
      if json_ac.array_count(l_obj) > 0 then
        v_msg := 'Data returned successfully..';
      else
        v_msg := 'No Data returned with these criteria..';
      end if;
    end if;
    --
    obj.put('report_data',l_obj);
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end analytical_data;
  --
  function rana_svc_comp_summ(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
              where pv.completed_flag = 'Y'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.insurance_company_name
                      ,svc_type_code
                      ,count(*) total_cnt
                from pps_simplified_vw pv
                where pv.completed_flag = 'Y'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
                group by pv.insurance_company_name
                      ,svc_type_code
                order by svc_type_code
                )
      loop
        v_str2 := j.svc_type_code||' ('||j.insurance_company_name||') - '||j.total_cnt;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_svc_comp_summ;
  --
  function rana_svc_comp_dtl(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
              where pv.completed_flag = 'Y'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                from pps_simplified_vw pv
                where pv.completed_flag = 'Y'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'HIC: '||j.pat_medicare_hic_num_full||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Billing Code: '||j.rpt_billing_code||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_svc_comp_dtl;
  --
  function rana_patient_qualify_em(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
              where pv.completed_flag = 'Y'
              and pv.qualify_for_em_followup_flag = 'Y'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                from pps_simplified_vw pv
                where pv.completed_flag = 'Y'
                and pv.qualify_for_em_followup_flag = 'Y'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_qualify_em;
  --
  function rana_patient_with_obesity(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
                  ,svc_result_vw srv
              where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
              and pv.completed_flag = 'Y'
              and pv.svc_type_code = 'AWV'
              and srv.disease_code = 'OBES'
              and srv.obesity_rf_avail_flag = 'Y'
              and srv.disease_level_code <> 'LOW'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pv.pat_bmi
                      ,pv.pat_height_in_ft
                      ,pv.pat_waist_in_in
                      ,pv.pat_weight_in_lb
                      ,pv.chronic_disease_cnt
                from pps_simplified_vw pv
                    ,svc_result_vw srv
                where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
                and pv.completed_flag = 'Y'
                and pv.svc_type_code = 'AWV'
                and srv.disease_code = 'OBES'
                and srv.obesity_rf_avail_flag = 'Y'
                and srv.disease_level_code <> 'LOW'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Name: '||j.pat_name||' - '||'Phone: '||j.pat_phone||' - '||'Service Date: '||j.svc_date||' - '||'Age: '||j.age||' - '||'BMI: '||j.pat_bmi||' - '||'Height: '||j.pat_height_in_ft||' - '||'Weight: '||j.pat_weight_in_lb||' lbs'||' - '||'Waist: '||j.pat_waist_in_in||' inches'||' - '||'Chronic Disease Count: '||j.chronic_disease_cnt;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_with_obesity;
  --
  function rana_patient_with_fall_risk(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
                  ,svc_result_vw srv
              where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
              and pv.completed_flag = 'Y'
              and pv.svc_type_code = 'AWV'
              and srv.disease_code = 'FALL'
              and srv.disease_level_code <> 'LOW'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                from pps_simplified_vw pv
                    ,svc_result_vw srv
                where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
                and pv.completed_flag = 'Y'
                and pv.svc_type_code = 'AWV'
                and srv.disease_code = 'FALL'
                and srv.disease_level_code <> 'LOW'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_with_fall_risk;
  --
  function rana_patient_with_cvd(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
                  ,svc_result_vw srv
              where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
              and pv.completed_flag = 'Y'
              and pv.svc_type_code = 'AWV'
              and srv.disease_code = 'CHDE'
              and srv.disease_level_code <> 'LOW'
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                from pps_simplified_vw pv
                    ,svc_result_vw srv
                where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
                and pv.completed_flag = 'Y'
                and pv.svc_type_code = 'AWV'
                and srv.disease_code = 'CHDE'
                and srv.disease_level_code <> 'LOW'
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_with_cvd;
  --
  function rana_patient_with_alco(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
                  ,patient_response_vw prv
              where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
              and pv.completed_flag = 'Y'
              and pv.svc_type_code = 'AWV'
              and prv.category_code = 'BEHVT'
              and prv.question_code = '1006'
              and prv.risk_factor_code is not null
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                      ,prv.response
                from pps_simplified_vw pv
                    ,patient_response_vw prv
                where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
                and pv.completed_flag = 'Y'
                and pv.svc_type_code = 'AWV'
                and prv.category_code = 'BEHVT'
                and prv.question_code = '1006'
                and prv.risk_factor_code is not null
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Response: '||j.response||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_with_alco;
  --
  function rana_patient_with_tbco(p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_provider_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in date,p_svc_dt_end in date) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
    v_str1      varchar2(2000);
    v_str2      varchar2(2000);
  begin
    for i in (select pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type physician
                    ,count(*) total_cnt
              from pps_simplified_vw pv
                  ,patient_response_vw prv
              where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
              and pv.completed_flag = 'Y'
              and pv.svc_type_code = 'AWV'
              and prv.category_code = 'BEHVT'
              and prv.question_code = '1005'
              and prv.risk_factor_code is not null
              and (p_company_sn is null or pat_physician_company_sn in (select number_code from table(admin_inq_pkg.user_role_company_sn(p_user_role_id,p_company_sn))))
              and (p_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(p_user_role_id,p_svc_location_sn))))
              and (p_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(p_user_role_id,p_physician_sn))))
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
              and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)
              group by pv.pat_physician_company_sn
                    ,pv.pat_primary_physician_company
                    ,pv.svc_location_sn
                    ,pv.svc_location_name
                    ,pv.physician_sn
                    ,pv.physician_title||' '||pv.pat_primary_physician_name||', '||pv.physician_dr_type
              order by pat_primary_physician_company,svc_location_name,physician
              )
    loop
      obj := json(); --an empty structure
      v_str1 := 'Company: '||i.pat_primary_physician_company||' - '||'Location: '||i.svc_location_name||' - '||'Physician: '||i.physician||' - '||'Count: '||i.total_cnt;
      obj.put('TITLE',v_str1);
      --
      l_obj2 := json_list();
      for j in (select pv.pat_name
                      ,pv.pat_phone
                      ,to_char(pv.svc_perform_date,'MM/DD/YYYY') svc_date
                      ,pv.age
                      ,pat_medicare_hic_num_full
                      ,pat_gender
                      ,case
                        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
                        else 'Commercial'
                        end insurance_type
                      ,pv.insurance_company_name
                      ,pv.svc_type_code
                      ,projected_billing_code(age,pat_medicare_hic_num_full,svc_type_code,prev_svc_billing_code) rpt_billing_code
                      ,case
                        when provider_dr_type is not null then provider_title||' '||provider_physician_name||', '||provider_dr_type
                        else provider_title||' '||provider_physician_name
                        end provider
                      ,prv.response
                from pps_simplified_vw pv
                    ,patient_response_vw prv
                where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
                and pv.completed_flag = 'Y'
                and pv.svc_type_code = 'AWV'
                and prv.category_code = 'BEHVT'
                and prv.question_code = '1005'
                and prv.risk_factor_code is not null
                and pat_physician_company_sn = i.pat_physician_company_sn
                and svc_location_sn = i.svc_location_sn
                and physician_sn = i.physician_sn
                and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between p_svc_dt_begin and p_svc_dt_end)                
                order by pv.svc_perform_date,pv.pat_name
                )
      loop
        v_str2 := 'Service Date: '||j.svc_date||' - '||'Name: '||j.pat_name||' - '||'Age: '||j.age||' - '||'Gender: '||j.pat_gender||' - '||'Phone: '||j.pat_phone||' - '||'Insurance: '||j.insurance_company_name||' - '||'Response: '||j.response||' - '||'Performed By: '||j.provider;
        l_obj2.append(v_str2);
      end loop;
      obj.put('TITLE_DATA',l_obj2);
      --
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end rana_patient_with_tbco;
  --This procedure will return data for all the reports under priviledge_code = 'RPTI'
  PROCEDURE patient_inquiry(p_locale in varchar2,p_report_code in varchar2,p_patient_sn in number,p_out OUT clob)
  as
    obj         json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    --
    v_pat_name varchar2(300);
    v_physician_name varchar2(300);
    v_physician_company varchar2(1000);
    v_report_name varchar2(500);
    v_title varchar2(1000);
    v_sub_title varchar2(2000);
  begin
    v_proc_name := upper('patient_inquiry');
    v_input_str := 'p_locale: '||p_locale||'-p_report_code: '||p_report_code||'-p_patient_sn: '||p_patient_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --status initialization
    v_status := 'SUCCESSFUL';
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    if p_report_code is null then
      v_status := 'FAILED';
      v_msg := 'Report Name Selection is required.';
    elsif p_patient_sn is null then
      v_status := 'FAILED';
      v_msg := 'Patient Key is required.';
    end if;
    --
    if p_patient_sn is not null then
      begin
        select name
              ,physician_name
              ,physician_company
        into v_pat_name
            ,v_physician_name
            ,v_physician_company
        from patient_vw
        where patient_sn = p_patient_sn
        ;
      exception
        when no_data_found then v_pat_name := null;
      end;
    end if;
    if p_report_code is not null then
      begin
        select short_descr
        into v_report_name
        from report_lang
        where report_code = p_report_code
        and lang_code = 'en'
        ;
      exception
        when no_data_found then v_pat_name := null;
      end;
    end if;

    v_title := v_report_name;
    v_sub_title := 'Patient: '||v_pat_name||' - Physician: '||v_physician_name||' - Physician Company: '||v_physician_company;
    obj.put('TITLE',v_title);
    obj.put('SUB_TITLE1',v_sub_title);
    --
    if v_status = 'SUCCESSFUL' then --lets start preparing for the p_out
      if p_report_code = 'RPDI' then --patient Detail Information
        l_obj := patient_detail_info(p_patient_sn);
      elsif p_report_code = 'RPSS' then --patient Scheduled Services
        l_obj := patient_services(p_patient_sn,'N');
      elsif p_report_code = 'RPCS' then --patient Completed Services
        l_obj := patient_services(p_patient_sn,'Y');
      elsif p_report_code = 'RQCS' then --patient Qualified Counselling Services
        l_obj := patient_counselling_services(p_patient_sn);
      end if;
    end if;
    --
    if json_ac.array_count(l_obj) > 0 then
      v_msg := 'Data returned successfully..';
    else
      v_msg := 'No Data returned with these criteria..';
    end if;
    --
    obj.put('report_data',l_obj);
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);      
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_inquiry;
  --
  function patient_detail_info (p_patient_sn in number) return json_list
  as
    l_obj json_list := json_list();
    --
    v_physician_name varchar2(500);
    v_PHYSICIAN_COMPANY varchar2(500);
    v_hic varchar2(100);
    v_ssn varchar2(100);
    v_addr varchar2(500);
    v_email varchar2(200);
    v_phone varchar2(50);
    v_gender varchar2(100);
    v_race varchar2(200);
    v_name varchar2(500);
    v_birth_date varchar2(50);
    v_age varchar2(10);
  begin
    select 'SSN: '||ssn 
          ,'HIC: '||medicare_hic_num
          ,'ADDRESS: '||addr
          ,'GENDER: '||gender
          ,'RACE: '||race
          ,'NAME: '||name
          ,'PHONE: '||phone
          ,'EMAIL: '||email
          ,'BIRTH_DATE: '||birth_date
          ,'AGE: '||age
          ,'PHYSICIAN NAME: '||physician_name
          ,'PHYSICIAN COMPANY: '||physician_company
    into
          v_ssn
          ,v_hic
          ,v_addr
          ,v_gender
          ,v_race
          ,v_name
          ,v_phone
          ,v_email
          ,v_birth_date
          ,v_age
          ,v_physician_name
          ,v_PHYSICIAN_COMPANY
    from patient_vw
    where patient_sn = p_patient_sn
    ;
    l_obj.append(v_name);
    l_obj.append(v_ssn);
    l_obj.append(v_hic);
    l_obj.append(v_gender);
    l_obj.append(v_race);
    l_obj.append(v_phone);
    l_obj.append(v_email);
    l_obj.append(v_birth_date);
    l_obj.append(v_age);
    l_obj.append(v_addr);
    l_obj.append(v_physician_name);
    l_obj.append(v_PHYSICIAN_COMPANY);
    --
    return l_obj;
  end patient_detail_info;
  --
  function patient_services (p_patient_sn in number,p_completed_flag in varchar2) return json_list
  as
    l_obj json_list := json_list();
  begin
    for i in (select case 
                      when p_completed_flag = 'N' then svc_date
                      else svc_perform_date
                      end svc_date
                    ,svc_type_descr
                    ,billing_code_descr
                    ,provider_title||' '||provider_physician_name provider
                    ,provider_physician_company
                    ,physician_title||' '||pat_primary_physician_name||', '||physician_dr_type physician
                    ,pat_primary_physician_company physician_company
                    ,svc_location_name
                    ,svc_location_addr
              from pps_simplified_vw 
              where completed_flag = p_completed_flag
              and patient_sn = p_patient_sn
              order by 1
              )
    loop
      l_obj.append('Service Date: '||i.svc_date||' - '||'Service: '||i.svc_type_descr||' - '||'Billing: '||i.billing_code_descr||' - '||'Provider: '||i.provider||' - '||'Provider Company: '||i.provider_physician_company||' - '||'Physician: '||i.physician||' - '||'Physician Company: '||i.physician_company||' - '||'Service Location: '||i.svc_location_name||' - '||'Location Addr: '||i.svc_location_addr);
    end loop;
    return l_obj;
  end patient_services;
  --
  function patient_counselling_services (p_patient_sn in number) return json_list
  as
    l_obj json_list := json_list();
    v_patient_prev_svc_sn number(11);
    v_ccm_flag varchar2(1);
  begin
    select max(patient_prev_svc_sn)
    into v_patient_prev_svc_sn
    from patient_prev_svc
    where patient_sn = p_patient_sn
    and prev_svc_billing_code in ('G0438','G0439')
    and svc_comp_flag = 'Y'
    ;
    if v_patient_prev_svc_sn is not null then
      select qualify_for_em_followup_flag
      into v_ccm_flag
      from patient_prev_svc
      where patient_prev_svc_sn = v_patient_prev_svc_sn
      ;
      if v_ccm_flag = 'Y' then
        l_obj.append('Chronic Care Management Counselling');
      end if;
      --
      for i in (select srv.disease_code
                      ,srv.obesity_rf_avail_flag
                      ,srv.disease_short_descr||' Counselling' disease_counselling
                from svc_result_vw srv
                where srv.patient_prev_svc_sn = v_patient_prev_svc_sn
                and srv.disease_code in ('OBES','CHDE','DIAB','ALCO','FALL')
                and srv.disease_severity_code = 'EXCBT'
                and srv.disease_level_code <> 'LOW'
                )
      loop
        if i.disease_code = 'OBES' then
          if i.obesity_rf_avail_flag = 'Y' then
            l_obj.append(i.disease_counselling);
          end if;
        else
          l_obj.append(i.disease_counselling);
        end if;
      end loop;
      --
    end if;
    return l_obj;
  end patient_counselling_services;
  --
  PROCEDURE priviledge_report_list (p_locale in varchar2,p_priviledge_code in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================
    l_obj := json_list(); --an empty list obj
    for i in (select rl.report_code
                    ,rl.short_descr
                    ,r.report_template_code
              from priviledge_report pr
                  ,list_report r
                  ,report_lang rl
              where pr.report_code = r.report_code
              and r.report_code = rl.report_code
              and rl.lang_code = v_lang_code
              and pr.priviledge_code = p_priviledge_code
              and pr.active_flag = 'Y'
              and r.active_flag = 'Y'
              and rl.active_flag = 'Y'
              order by pr.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('REPORT_CODE',i.report_code);
      obj2.put('TEMPLATE_CODE',i.report_template_code);
      obj2.put('REPORT_NAME',i.short_descr);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('priviledge_report_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end priviledge_report_list;
  --
  PROCEDURE svc_completion_rpt (p_locale in varchar2,p_svc_location_sn in svc_location.svc_location_sn%type,p_svc_code in list_prev_svc_billing.prev_svc_billing_code%type,p_begin_date in varchar2,p_end_date in varchar2,p_pmt_ind in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    --
    --
    l_obj       json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    obj2 := json(); --an empty structure
    obj2.put('TITLE','SERVICE COMPLETION REPORT');
    if p_pmt_ind = 'PP' then
      obj2.put('SUB_TITLE1','Pending Payment');
    elsif p_pmt_ind = 'PR' then
      obj2.put('SUB_TITLE1','Payment Receipt');
    elsif p_pmt_ind = 'CL' then
      obj2.put('SUB_TITLE1','Complete List');
    end if;
    obj2.put('SUB_TITLE_PP','Pending Appointment');
    obj2.put('SUB_TITLE_PR','Payment Receipt');
    obj2.put('SUB_TITLE_CL','Complete List');
    obj2.put('SUB_TITLE_BD','Start Date');
    obj2.put('SUB_TITLE_ED','End Date');
    obj2.put('SUB_TITLE_SL','Select Service Location');
    obj2.put('SUB_TITLE_ST','Select Service Type');    
    obj.put('hdr',obj2);
    --
    l_obj := json_list(); --an empty list obj
    for i in (select pat_name
              from patient_prev_svc_vw
              --where svc_location_sn = p_svc_location_sn
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.pat_name);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_data', l_obj);
    end if;
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end svc_completion_rpt;
  --
  PROCEDURE patient_em_rpt (p_locale in varchar2,p_rpt_ind in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    --
    --
    l_obj       json_list;
    v_rpt_ind   varchar2(2) := upper(p_rpt_ind);
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    obj2 := json(); --an empty structure
    if v_rpt_ind = 'PA' then
      obj2.put('TITLE','PENDING APPOINTMENT EM PATIENT LIST');
      obj2.put('SUB_TITLE','List of all the EM qualified patients whose appointment are still pending.');
    elsif v_rpt_ind = 'PC' then
      obj2.put('TITLE','PENDING SERVICE EM PATIENT LIST');
      obj2.put('SUB_TITLE','List of all the EM qualified patients whose EM Service are still pending.');
    elsif v_rpt_ind = 'EQ' then
      obj2.put('TITLE','EM PATIENT LIST');
      obj2.put('SUB_TITLE','List of all the EM qualified patients.');    
    end if;
    --
    obj2.put('SUB_TITLE_PA','Pending Appointment');
    obj2.put('SUB_TITLE_PC','Pending Completion');
    obj2.put('SUB_TITLE_EQ','EM Qualified');
    obj.put('hdr',obj2);
    --
    l_obj := json_list(); --an empty list obj
    --
    if v_rpt_ind = 'PA' then
      for i in (select svc_perform_date
                      ,chronic_disease_cnt
                      ,pat_primary_physician_name
                      ,PAT_PRIMARY_PHYSICIAN_COMPANY
                      ,provider_physician_name
                      ,provider_physician_company
                      ,physician_title
                      ,provider_title
                      ,svc_location_name
                      ,svc_location_addr
                      ,pat_medicare_hic_num
                      ,pat_gender
                      ,pat_name
                      ,pat_birth_date
                from pps_simplified_vw
                where patient_sn in (select number_code from table(common_inq_pkg.patient_qualify_for_99202(null)))
                and prev_svc_billing_code in ('G0438','G0439')
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',i.pat_name);
        obj2.put('GENDER',i.pat_gender);
        obj2.put('HIC',i.pat_medicare_hic_num);
        obj2.put('SVC_DATE',i.svc_perform_date);
        obj2.put('CHRONIC_DISEASE',i.CHRONIC_DISEASE_CNT);
        obj2.put('PHYSICIAN',i.physician_title||' '||i.pat_primary_physician_name||' ('||i.PAT_PRIMARY_PHYSICIAN_COMPANY||')');
        obj2.put('SVC_PROVIDER',i.provider_title||' '||i.provider_physician_name||' ('||i.provider_physician_company||')');
        obj2.put('SVC_LOCATION',i.svc_location_name);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    elsif v_rpt_ind = 'PC' then
      for i in (select svc_perform_date
                      ,common_inq_pkg.patient_chronic_disease_cnt(parent_patient_prev_svc_sn) chronic_disease_cnt
                      ,pat_primary_physician_name
                      ,PAT_PRIMARY_PHYSICIAN_COMPANY
                      ,provider_physician_name
                      ,provider_physician_company
                      ,physician_title
                      ,provider_title
                      ,svc_location_name
                      ,svc_location_addr
                      ,pat_medicare_hic_num
                      ,pat_gender
                      ,pat_name
                      ,pat_birth_date
                from pps_simplified_vw
                where prev_svc_billing_code in ('99202','99212')
                and completed_flag = 'N'
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',i.pat_name);
        obj2.put('GENDER',i.pat_gender);
        obj2.put('HIC',i.pat_medicare_hic_num);
        obj2.put('SVC_DATE',i.svc_perform_date);
        obj2.put('CHRONIC_DISEASE',i.CHRONIC_DISEASE_CNT);
        obj2.put('PHYSICIAN',i.physician_title||' '||i.pat_primary_physician_name||' ('||i.PAT_PRIMARY_PHYSICIAN_COMPANY||')');
        obj2.put('SVC_PROVIDER',i.provider_title||' '||i.provider_physician_name||' ('||i.provider_physician_company||')');
        obj2.put('SVC_LOCATION',i.svc_location_name);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    elsif v_rpt_ind = 'EQ' then
      for i in (select svc_perform_date
                      ,chronic_disease_cnt
                      ,pat_primary_physician_name
                      ,PAT_PRIMARY_PHYSICIAN_COMPANY
                      ,provider_physician_name
                      ,provider_physician_company
                      ,physician_title
                      ,provider_title                      
                      ,svc_location_name
                      ,svc_location_addr
                      ,pat_medicare_hic_num
                      ,pat_gender
                      ,pat_name
                      ,pat_birth_date
                from pps_simplified_vw
                where prev_svc_billing_code in ('G0438','G0439')
                and completed_flag = 'Y'
                and qualify_for_em_followup_flag = 'Y'
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',i.pat_name);
        obj2.put('GENDER',i.pat_gender);
        obj2.put('HIC',i.pat_medicare_hic_num);
        obj2.put('SVC_DATE',i.svc_perform_date);
        obj2.put('CHRONIC_DISEASE',i.CHRONIC_DISEASE_CNT);
        obj2.put('PHYSICIAN',i.physician_title||' '||i.pat_primary_physician_name||' ('||i.PAT_PRIMARY_PHYSICIAN_COMPANY||')');
        obj2.put('SVC_PROVIDER',i.provider_title||' '||i.provider_physician_name||' ('||i.provider_physician_company||')');
        obj2.put('SVC_LOCATION',i.svc_location_name);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    end if;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_data', l_obj);
    end if;
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_em_rpt;
END mgmt_report_pkg;
/
show errors