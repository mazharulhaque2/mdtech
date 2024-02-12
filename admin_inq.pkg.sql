CREATE OR REPLACE PACKAGE admin_inq_pkg IS
  v_pkg_name    varchar2 (30) := upper('admin_inq_pkg');
  v_proc_name   varchar2(30);
  v_status      varchar2(20);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  function user_role_company_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number) return t_number_tab PIPELINED;
  function user_role_physician_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_physician_sn in number) return t_number_tab PIPELINED;
  function user_role_svc_location_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_svc_location_sn in number) return t_number_tab PIPELINED;
  function sn_when_null(p_table_code in varchar2,p_user_role_id in "AspNetUserRoles".user_role_id%type) return number;
  function patient_hx_response(p_patient_sn in number,p_categ_code in varchar2) return json_list;
  PROCEDURE patient_record_edit_data (p_locale in varchar2,p_patient_sn in number,p_out OUT clob);
  PROCEDURE company_record_edit_data (p_locale in varchar2,p_company_sn in number,p_out OUT clob);
  PROCEDURE user_record_edit_data(p_locale in varchar2,p_email in varchar2,p_out OUT clob);
  PROCEDURE patient_list(p_locale in varchar2,p_hic in varchar2,p_ssn in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_out OUT clob);
  PROCEDURE rpt_patient_list(p_locale in varchar2,p_user in varchar2,p_hic in varchar2,p_ssn in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in varchar2,p_svc_dt_end in varchar2,p_out OUT clob);
  PROCEDURE user_list(p_locale in varchar2,p_email in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_out OUT clob);
  PROCEDURE patient_hx_qnr_template_data(p_locale in varchar2,p_patient_sn in number,p_out OUT clob);
END admin_inq_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY admin_inq_pkg IS
  function patient_hx_response(p_patient_sn in number,p_categ_code in varchar2) return json_list
  as
    l_obj json_list := json_list();
  begin
    for i in (select question_response_code
              from patient_history_vw
              where patient_sn = p_patient_sn
              and category_code = p_categ_code
              and question_code <> '1099'
              )
    loop
      l_obj.append(i.question_response_code);
    end loop;
    return l_obj;
  end patient_hx_response;
  --
  function medication (p_lang_code in varchar2,p_patient_sn in number) return json_list
  as
    obj         json;
    l_obj json_list := json_list();
  begin
    for i in (select PATIENT_MEDICATION_SN
                    ,name
                    ,quantity
                    ,quantity_unit_code
                    ,quantity_unit
                    ,ingredients
                    ,purpose
                    ,parse_json_pkg.rev_frequency_unit_code(frequency_unit) frequency_unit
                    ,frequency
                    ,medication_current_flag
                    ,PRESCRIBED_MED_FLAG
                    ,notes
                    ,created_by
                    ,updated_by
                    ,status
              from patient_medication_vw
              where patient_sn = p_patient_sn
              and frequency_lang_code = p_lang_code
              and medication_unit_lang_code = p_lang_code
              )
    loop
      obj := json(); --an empty structure
      obj.put('PATIENT_MEDICATION_SN',i.patient_medication_sn);
      obj.put('NAME',i.name);
      obj.put('QUANTITY',i.quantity);
      obj.put('QUANTITY_UNIT',i.quantity_unit);
      obj.put('QUANTITY_UNIT_CODE',i.quantity_unit_code);
      obj.put('INGREDIENTS',i.ingredients);
      obj.put('PURPOSE',i.purpose);
      obj.put('FREQUENCY',i.frequency);
      obj.put('FREQUENCY_UNIT',i.frequency_unit);
      obj.put('CURRENT',i.medication_current_flag);
      obj.put('PRESCRIBED_MED_FLAG',i.PRESCRIBED_MED_FLAG);
      obj.put('NOTES',i.notes);
      --Append obj to the list
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end medication;
  --
  function patient_medication(p_lang_code in varchar2,p_patient_sn in number) return json
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','Please add all the Medication of this patient');
    obj2.put('TAB_NAME','Meds');
    obj.put('label',obj2);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Dosage');
    obj2.put('TH3','Medication Unit');
    obj2.put('TH4','Purpose');
    obj2.put('TH5','Frequency');
    obj2.put('TH6','Notes');
    obj2.put('TH7','Current?');
    obj2.put('TH8','Prescribed?');
    obj.put('th_label',obj2);
    --=======================medication
    obj.put('medication',medication(p_lang_code,p_patient_sn));
    --=======================return
    return obj;
  end patient_medication;
  --
  function patient_hx_qnr(p_lang_code in varchar2,p_patient_sn in number,p_gender_code in varchar2,p_categ_code in varchar2,v_title in varchar2,v_tab_name in varchar2) return json
  as
    obj         json;
    obj2        json;
    l_obj json_list := json_list();
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj2.put('TAB_NAME',v_tab_name);
    obj2.put('CATEG_CODE',p_categ_code);
    obj.put('label',obj2);
    --=======================question
    obj.put('question',qnr_inq_pkg.hx_qnr_by_categ(p_lang_code,p_categ_code,p_gender_code));
    --=======================response
    obj.put('response',patient_hx_response(p_patient_sn,p_categ_code));
    --=======================return
    return obj;
  end patient_hx_qnr;
  --
  PROCEDURE patient_hx_qnr_template_data(p_locale in varchar2,p_patient_sn in number,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_sn
                    ,medicare_hic_num
                    ,ssn
                    ,gender
                    ,gender_code
                    ,name
                    ,birth_date
                    ,age
                    ,physician_name||', '||physician_dr_type physician_name
                    ,physician_company
              from patient_vw
              where patient_sn = p_patient_sn
              )
    loop
      obj.put('TITLE','PATIENT MEDICATION AND HISTORY DATA MANAGEMENT');
      obj.put('SUB_TITLE1',i.name||' ('||i.age||' y/o, '||i.gender||'), HIC: '||i.medicare_hic_num||' - '||'Physician: '||i.physician_name||' ('||i.physician_company||')');
      obj.put('SUB_TITLE2','PLEASE SELECT APPROPRIATE TAB TO MANAGE MEDICATION AND HISTORY DATA');
      obj.put('PATIENT_SN',i.patient_sn);
      obj.put('patient_medication',patient_medication(v_lang_code,i.patient_sn));
      obj.put('patient_medical_hx',patient_hx_qnr(v_lang_code,i.patient_sn,i.gender_code,'BMEDH','Please select appropriate Past Medical Hx of this patient','Medical Hx'));
      obj.put('patient_surgery_hx',patient_hx_qnr(v_lang_code,i.patient_sn,i.gender_code,'HSURA','Please select appropriate Surgery/Allergy Hx of this patient','Surgery'));
      obj.put('patient_vaccination_hx',patient_hx_qnr(v_lang_code,i.patient_sn,i.gender_code,'HVACN','Please select appropriate Vaccination Hx of this patient','Vaccination'));
      obj.put('patient_text_hx',patient_hx_qnr(v_lang_code,i.patient_sn,i.gender_code,'HVART','Please select appropriate Medical Test Hx of this patient','Test'));
      obj.put('patient_family_hx',patient_hx_qnr(v_lang_code,i.patient_sn,i.gender_code,'FHNMR','Please select appropriate Family Hx of this patient','Family Hx'));
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_hx_qnr_template_data;

  --This function is used in the reports where user are allowed to search with null values of company, location and physician sn.
  --The function will return the appropriate sn value for company, location and physician when user pass null in the input parametere.
  --The function evaluates whether user is an ITHEALTH employee. If the user is not an ITH employee then the function evaluate exception
  --tables (user_company, user_svc_location and user_physician).
  --Table codes are 'COM' = company, 'LOC' = svc_location and 'PHY' = physician.
  --This function will return null,-9999 or default sn
  function sn_when_null(p_table_code in varchar2,p_user_role_id in "AspNetUserRoles".user_role_id%type) return number
  is
    v_cnt pls_integer;
    v_return_sn number(11);
    v_ithealth_comp_flag varchar2(1);
    v_company_sn number(11);
  begin
    --first get the exception count
    if p_table_code = 'COM' then
      select count(*)
      into v_cnt
      from user_company
      where user_role_id = p_user_role_id
      and active_flag = 'Y'
      ;
    elsif p_table_code = 'LOC' then
      select count(*)
      into v_cnt
      from user_svc_location
      where user_role_id = p_user_role_id
      and active_flag = 'Y'
      ;
    elsif p_table_code = 'PHY' then
      select count(*)
      into v_cnt
      from user_physician
      where user_role_id = p_user_role_id
      and active_flag = 'Y'
      ;    
    end if;
    --Now evaluate the count and return value
    if p_table_code = 'COM' then
      select ithealth_company_flag
            ,company_sn
      into v_ithealth_comp_flag
          ,v_company_sn
      from user_vw
      where user_role_id = p_user_role_id
      ;
      if v_ithealth_comp_flag = 'Y' then --user is an ITH employee
        if v_cnt = 0 then v_return_sn := null; --user is allowed to search any company
        else v_return_sn := -9999; --exception available. user is allowed to search default plus exception companies
        end if;
      else --non ITH employee
        if v_cnt = 0 then v_return_sn := v_company_sn; --return user default company_sn
        else v_return_sn := -9999; --exception available. user is allowed to search default plus exception companies
        end if;
      end if;
    elsif p_table_code in ('LOC','PHY') then
      if v_cnt = 0 then v_return_sn := null; --user is allowed to search any location/physician under the return company in the COM logic above
      else v_return_sn := -9999; --exception available. user is allowed to search only exception location/physician
      end if;
    end if;
    return v_return_sn;
  end sn_when_null;
  --user_demo
  function user_demo(p_first_name in varchar2,p_middle_name in varchar2,p_last_name in varchar2,p_phone in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Demographic');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('FIRST_NAME','First Name:');
    obj2.put('MIDDLE_NAME','Middle Name:');
    obj2.put('LAST_NAME','Last Name:');
    obj2.put('PHONE','Phone:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('FIRST_NAME',p_first_name);
    obj2.put('MIDDLE_NAME',p_middle_name);
    obj2.put('LAST_NAME',p_last_name);
    obj2.put('PHONE',p_phone);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end user_demo;
  --user_role
  function user_role(p_role_id in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','User Role');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('ROLE','Role:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('ROLE',p_role_id);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end user_role;
  --user_is_a_prov
  function user_is_a_prov(p_prov_flag in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Is A Provider');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('PROV_FLAG','User Is A Provider?:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PROV_FLAG',p_prov_flag);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end user_is_a_prov;
  --user_status
  function user_status(p_status_flag in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','User Status');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('STATUS','Active?:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('STATUS',p_status_flag);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end user_status;

  --company_demo
  function company_demo(p_name in varchar2,p_contact_name in varchar2,p_phone in varchar2,p_fax in varchar2,p_toll_free in varchar2,p_website in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Demographic');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('NAME','Company Name:');
    obj2.put('CONTACT_NAME','Contact Name:');
    obj2.put('PHONE_NUMBER','Phone:');
    obj2.put('FAX_NUMBER','Fax:');
    obj2.put('TOLL_FREE_NUMBER','Toll Free:');
    obj2.put('WEBSITE_ADDR','Website:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('NAME',p_name);
    obj2.put('CONTACT_NAME',p_contact_name);
    obj2.put('PHONE_NUMBER',p_phone);
    obj2.put('FAX_NUMBER',p_fax);
    obj2.put('TOLL_FREE_NUMBER',p_toll_free);
    obj2.put('WEBSITE_ADDR',p_website);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end company_demo;
  --patient_demo
  function patient_demo (p_medicare_hic_num in varchar2,p_ssn in varchar2,p_first_name in varchar2,p_middle_name in varchar2,p_last_name in varchar2,p_gender_code in varchar2,p_dob in varchar2,p_email in varchar2,p_phone in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Demographic');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('HIC','HIC:');
    obj2.put('SSN','SSN:');
    obj2.put('FIRST_NAME','First Name:');
    obj2.put('MIDDLE_NAME','Middle Name:');
    obj2.put('LAST_NAME','Last Name:');
    obj2.put('GENDER','Gender:');
    obj2.put('DOB','Birth Date:');
    obj2.put('EMAIL','Email Address:');
    obj2.put('PHONE','Phone:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('HIC',p_medicare_hic_num);
    obj2.put('SSN',p_ssn);
    obj2.put('FIRST_NAME',p_first_name);
    obj2.put('MIDDLE_NAME',p_middle_name);
    obj2.put('LAST_NAME',p_last_name);
    obj2.put('GENDER',p_gender_code);
    obj2.put('DOB',p_dob);
    obj2.put('EMAIL',p_email);
    obj2.put('PHONE',p_phone);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end patient_demo;
  --addr_rec
  function addr_rec (p_addr_1 in varchar2,p_addr_2 in varchar2,p_city_name in varchar2,p_state_code in varchar2,p_postal_code in varchar2,p_country_code in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Address');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('ADDR_1','Address 1:');
    obj2.put('ADDR_2','Address 2:');
    obj2.put('CITY','City:');
    obj2.put('STATE','State:');
    obj2.put('ZIP','Zip:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('ADDR_1',p_addr_1);
    obj2.put('ADDR_2',p_addr_2);
    obj2.put('CITY',p_city_name);
    obj2.put('STATE_CODE',p_state_code);
    obj2.put('POSTAL_CODE',p_postal_code);
    obj2.put('COUNTRY_CODE',p_country_code);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end addr_rec;
  --patient_physician
  function patient_physician(p_physician_name in varchar2,p_physician_company in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Physician');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('NAME','Name:');
    obj2.put('COMPANY','Company:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('NAME',p_physician_name);
    obj2.put('COMPANY',p_physician_company);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end patient_physician;
  --
  function patient_service_list (p_lang_code in varchar2,p_patient_sn in number) return json_list
  is
    l_obj json_list := json_list();
    obj json;
  begin              
    for i in (select pstl.prev_svc_type_code||' ('||psbl.short_descr||' - '||psbl.prev_svc_billing_code||')' descr
                    ,to_char(pps.svc_perform_date,'MM/DD/YYYY') svc_date
                    ,pps.patient_prev_svc_sn
              from patient_prev_svc pps
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
                  ,list_prev_svc_type pst
                  ,prev_svc_type_lang pstl
              where pps.prev_svc_billing_code = psb.prev_svc_billing_code
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = p_lang_code
              and psb.prev_svc_type_code = pst.prev_svc_type_code
              and pst.prev_svc_type_code = pstl.prev_svc_type_code
              and pstl.lang_code = p_lang_code
              and pps.patient_sn = p_patient_sn
              and pps.svc_comp_flag = 'Y'
              --
              and pps.active_flag = 'Y'
              and psb.active_flag = 'Y'
              and psbl.active_flag = 'Y'
              and pst.active_flag = 'Y'
              and pstl.active_flag = 'Y'
              )
    loop
      obj := json();
      obj.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj.put('NAME',i.descr);
      obj.put('DATE',i.svc_date);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end patient_service_list;
  --patient_service
  function patient_service(p_lang_code in varchar2,p_patient_sn in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Completed Svc Reprocess');
    obj.put('SUB_TITLE1','COMPLETED SERVICE LIST');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Date');
    obj.put('th_label',obj2);    
    --=======================patient_service_list
    obj.put('patient_service_list',patient_service_list(p_lang_code,p_patient_sn));
    --===================================== end of json building
    return obj;
  end patient_service;
  --
  function patient_pending_service_list (p_lang_code in varchar2,p_patient_sn in number) return json_list
  is
    l_obj json_list := json_list();
    obj json;
  begin              
    for i in (select pstl.prev_svc_type_code||' ('||psbl.short_descr||' - '||psbl.prev_svc_billing_code||')' descr
                    ,to_char(nvl(pps.svc_perform_date,pps.svc_date),'MM/DD/YYYY') svc_date
                    ,pps.patient_prev_svc_sn
              from patient_prev_svc pps
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
                  ,list_prev_svc_type pst
                  ,prev_svc_type_lang pstl
              where pps.prev_svc_billing_code = psb.prev_svc_billing_code
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = p_lang_code
              and psb.prev_svc_type_code = pst.prev_svc_type_code
              and pst.prev_svc_type_code = pstl.prev_svc_type_code
              and pstl.lang_code = p_lang_code
              and pps.patient_sn = p_patient_sn
              and pps.svc_comp_flag = 'N'
              and pps.prev_svc_billing_code in ('99202','99212','99487','99490') --EM and CCM
              --
              and pps.active_flag = 'Y'
              and psb.active_flag = 'Y'
              and psbl.active_flag = 'Y'
              and pst.active_flag = 'Y'
              and pstl.active_flag = 'Y'
              )
    loop
      obj := json();
      obj.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj.put('NAME',i.descr);
      obj.put('DATE',i.svc_date);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end patient_pending_service_list;
  --patient_pending_service
  function patient_pending_service(p_lang_code in varchar2,p_patient_sn in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Pending Svc Reprocess');
    obj.put('SUB_TITLE1','PENDING SERVICE LIST');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Date');
    obj.put('th_label',obj2);    
    --=======================patient_service_list
    obj.put('patient_pending_service_list',patient_pending_service_list(p_lang_code,p_patient_sn));
    --===================================== end of json building
    return obj;
  end patient_pending_service;
  --
  PROCEDURE patient_record_edit_data(p_locale in varchar2,p_patient_sn in number,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_sn
                    ,medicare_hic_num
                    ,ssn
                    ,gender
                    ,gender_code
                    ,name
                    ,first_name
                    ,middle_name
                    ,last_name
                    ,phone
                    ,email
                    ,to_char(birth_date_date,'YYYY-MM-DD') dob
                    ,addr_1
                    ,addr_2
                    ,city_name
                    ,state_code
                    ,state_name
                    ,postal_code
                    ,country_code
                    ,physician_name||', '||physician_dr_type physician_name
                    ,physician_company
              from patient_vw
              where patient_sn = p_patient_sn
              )
    loop
      obj.put('TITLE',i.name);
      obj.put('SUB_TITLE1','Current Physician: '||i.physician_name);
      obj.put('patient_demo',patient_demo(i.medicare_hic_num,i.ssn,i.first_name,i.middle_name,i.last_name,i.gender_code,i.dob,i.email,i.phone));
      obj.put('patient_addr',addr_rec(i.addr_1,i.addr_2,i.city_name,i.state_code,i.postal_code,i.country_code));
      obj.put('patient_physician',patient_physician(i.physician_name,i.physician_company));
      obj.put('patient_service',patient_service(v_lang_code,p_patient_sn));
      obj.put('patient_pending_service',patient_pending_service(v_lang_code,p_patient_sn));
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_record_edit_data;
  --
  PROCEDURE company_record_edit_data(p_locale in varchar2,p_company_sn in number,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select company_sn
                    ,name
                    ,contact_name
                    ,phone
                    ,fax
                    ,toll_free
                    ,website
                    ,addr
                    ,addr_1
                    ,addr_2
                    ,city_name
                    ,state_code
                    ,state_name
                    ,postal_code
                    ,country_code
              from company_vw
              where company_sn = p_company_sn
              and status = 'Active'
              )
    loop
      obj.put('TITLE',i.name);
      obj.put('SUB_TITLE1',i.addr);
      obj.put('company_demo',company_demo(i.name,i.contact_name,i.phone,i.fax,i.toll_free,i.website));
      obj.put('company_addr',addr_rec(i.addr_1,i.addr_2,i.city_name,i.state_code,i.postal_code,i.country_code));
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end company_record_edit_data;
  --
  PROCEDURE user_record_edit_data(p_locale in varchar2,p_email in varchar2,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select user_id
                    ,user_name
                    ,name
                    ,company_name
                    ,first_name
                    ,middle_name
                    ,last_name
                    ,phone
                    ,role_id
                    ,role_name
                    ,user_is_a_provider_flag
                    ,user_role_active_flag
                    ,addr
                    ,addr_1
                    ,addr_2
                    ,city_name
                    ,state_code
                    ,state_name
                    ,postal_code
                    ,country_code
              from user_vw
              where user_name = lower(p_email)
              )
    loop
      obj.put('TITLE',i.name);
      obj.put('SUB_TITLE1',i.user_name||' - '||i.company_name);
      obj.put('user_demo',user_demo(i.first_name,i.middle_name,i.last_name,i.phone));
      obj.put('user_addr',addr_rec(i.addr_1,i.addr_2,i.city_name,i.state_code,i.postal_code,i.country_code));
      obj.put('user_role',user_role(i.role_id));
      obj.put('user_is_a_prov',user_is_a_prov(i.user_is_a_provider_flag));
      obj.put('user_status',user_status(i.user_role_active_flag));
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end user_record_edit_data;
  --
  PROCEDURE patient_list(p_locale in varchar2,p_hic in varchar2,p_ssn in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_out OUT clob)
  is
    obj         json;
    obj2        json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_sub_title varchar2(1000);
    v_company_name varchar2(200);
    v_svc_location_name varchar2(200);
    v_physician_name varchar2(200);
  begin
    v_proc_name := upper('patient_list');
    v_input_str := 'p_locale: '||p_locale||'-p_hic: '||p_hic||'-p_ssn: '||p_ssn||'-p_last_name: '||p_last_name||'-p_first_name: '||p_first_name||'-p_company_sn: '||p_company_sn||'-p_svc_location_sn: '||p_svc_location_sn||'-p_physician_sn: '||p_physician_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    obj.put('TITLE','PATIENT LIST');
    if p_company_sn is not null then
      begin
        select name into v_company_name from company where company_sn = p_company_sn;
      exception
        when no_data_found then v_company_name := null;
      end;
    end if;
    if p_svc_location_sn is not null then
      begin
        select name into v_svc_location_name from svc_location where svc_location_sn = p_svc_location_sn;
      exception
        when no_data_found then v_svc_location_name := null;
      end;
    end if;
    if p_physician_sn is not null then
      begin
        select name into v_physician_name from physician_vw where physician_sn = p_physician_sn;
      exception
        when no_data_found then v_physician_name := null;
      end;
    end if;
    --
    v_sub_title := 'HIC: '||p_hic||' - SSN: '||p_ssn||' - Last Name: '||p_last_name||' - First Name: '||p_first_name||' - Company: '||v_company_name||' - Location: '||v_svc_location_name||' - Physician: '||v_physician_name;
    --
    obj.put('SUB_TITLE1',v_sub_title);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','DOB');
    obj2.put('TH3','Physician');
    obj2.put('TH4','Meds & Hx');
    obj.put('th_label',obj2);
    --
    if p_hic is not null or p_ssn is not null or p_last_name is not null or p_first_name is not null or p_company_sn is not null or p_svc_location_sn is not null or p_physician_sn is not null then
      for i in (select patient_sn
                      ,medicare_hic_num
                      ,ssn
                      ,gender
                      ,gender_code
                      ,name
                      ,first_name
                      ,middle_name
                      ,last_name
                      ,to_char(birth_date_date,'YYYY-MM-DD') dob
                      ,physician_name||', '||physician_dr_type physician_name
                from patient_vw
                where (p_hic is null or medicare_hic_num = p_hic)
                and (p_ssn is null or ssn = p_ssn)
                and (p_last_name is null or upper(last_name) like '%'||upper(p_last_name)||'%')
                and (p_first_name is null or upper(first_name) like '%'||upper(p_first_name)||'%')
                and (p_company_sn is null or physician_company_sn = p_company_sn)
                and (p_svc_location_sn is null or physician_sn in (select physician_sn from physician_svc_location where svc_location_sn = p_svc_location_sn))
                and (p_physician_sn is null or physician_sn = p_physician_sn)
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('PATIENT_SN',i.patient_sn);
        obj2.put('NAME',i.name);
        obj2.put('DOB',i.dob);
        obj2.put('PHYSICIAN',i.physician_name);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    end if;
    obj.put('patient_list',l_obj);
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_list;
  --
  PROCEDURE user_list(p_locale in varchar2,p_email in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_out OUT clob)
  is
    obj         json;
    obj2        json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_sub_title varchar2(1000);
    v_company_name varchar2(200);
  begin
    v_proc_name := upper('user_list');
    v_input_str := 'p_locale: '||p_locale||'-p_email: '||p_email||'-p_last_name: '||p_last_name||'-p_first_name: '||p_first_name||'-p_company_sn: '||p_company_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    obj.put('TITLE','USER LIST');
    if p_company_sn is not null then
      begin
        select name into v_company_name from company where company_sn = p_company_sn;
      exception
        when no_data_found then v_company_name := null;
      end;
    end if;
    --
    v_sub_title := 'EMAIL: '||p_email||' - Last Name: '||p_last_name||' - First Name: '||p_first_name||' - Company: '||v_company_name;
    --
    obj.put('SUB_TITLE1',v_sub_title);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Email');
    obj2.put('TH3','Company');
    obj.put('th_label',obj2);
    --
    if p_email is not null or p_last_name is not null or p_first_name is not null or p_company_sn is not null then
      for i in (select user_id
                      ,user_name
                      ,name
                      ,company_name
                from user_vw
                where role_id not in ('96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76','a74f52c5-4d3a-46d9-bc22-a5eafa982849')
                and (p_email is null or user_name like '%'||lower(p_email)||'%')
                and (p_last_name is null or upper(last_name) like '%'||upper(p_last_name)||'%')
                and (p_first_name is null or upper(first_name) like '%'||upper(p_first_name)||'%')
                and (p_company_sn is null or company_sn = p_company_sn)
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('EMAIL',i.user_name);
        obj2.put('NAME',i.name);
        obj2.put('COMPANY_NAME',i.company_name);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    end if;
    obj.put('user_list',l_obj);
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end user_list;
  --
  --For NON ITH user, this function is providing exception physician data. Instead of all the physician, user can only 
  --handle physician return by this function.
  --
  function user_role_company_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_company_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_company_sn');
    v_err_msg := null;
    --
    if p_company_sn = -9999 then --user have exception in user_company
      for i in (select company_sn
                from user_company
                where user_role_id = p_user_role_id
                and active_flag = 'Y'
                union --append the user default company
                select company_sn
                from user_vw 
                where user_role_id = p_user_role_id
                )
      loop
        l_row.number_code := i.company_sn;
        PIPE ROW (l_row);
      end loop;
    else --no exception, just return user input
      l_row.number_code := p_company_sn;
      PIPE ROW (l_row);
    end if;
  end user_role_company_sn;  
  --
  --For NON ITH user, this function is providing exception physician data. Instead of all the physician, user can only 
  --handle physician return by this function.
  --
  function user_role_svc_location_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_svc_location_sn in number) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_svc_location_sn');
    v_err_msg := null;
    --
    if p_svc_location_sn = -9999 then --user have exception in user_svc_location
      for i in (select svc_location_sn
                from user_svc_location
                where user_role_id = p_user_role_id
                and active_flag = 'Y'
                )
      loop
        l_row.number_code := i.svc_location_sn;
        PIPE ROW (l_row);
      end loop;
    else --no exception, just return user input
      l_row.number_code := p_svc_location_sn;
      PIPE ROW (l_row);
    end if;
  end user_role_svc_location_sn;
  --
  --For NON ITH user, this function is providing exception physician data. Instead of all the physician, user can only 
  --handle physician return by this function.
  --
  function user_role_physician_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_physician_sn in number) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_physician_sn');
    v_err_msg := null;
    --
    if p_physician_sn = -9999 then --user have exception in user_physician
      for i in (select physician_sn
                from user_physician
                where user_role_id = p_user_role_id
                and active_flag = 'Y'
                )
      loop
        l_row.number_code := i.physician_sn;
        PIPE ROW (l_row);
      end loop;
    else --no exception, just return user input
      l_row.number_code := p_physician_sn;
      PIPE ROW (l_row);
    end if;
  end user_role_physician_sn;  
  --
  PROCEDURE rpt_patient_list(p_locale in varchar2,p_user in varchar2,p_hic in varchar2,p_ssn in varchar2,p_last_name in varchar2,p_first_name in varchar2,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_prev_svc_billing_code in varchar2,p_svc_dt_begin in varchar2,p_svc_dt_end in varchar2,p_out OUT clob)
  is
    obj         json;
    obj2        json;
    l_obj       json_list := json_list();
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_sub_title varchar2(2000);
    v_company_name varchar2(200);
    v_svc_location_name varchar2(200);
    v_physician_name varchar2(200);
    v_prev_svc_billing_name varchar2(200);
    v_svc_dt_begin date;
    v_svc_dt_end date;
    v_days_between number(11);
    v_provider_physician_sn provider_physician.provider_physician_sn%type;
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_svc_location_sn number(11);
    v_physician_sn number(11);
  begin
    v_proc_name := upper('rpt_patient_list');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_hic: '||p_hic||'-p_ssn: '||p_ssn||'-p_last_name: '||p_last_name||'-p_first_name: '||p_first_name||'-p_company_sn: '||p_company_sn||'-p_svc_location_sn: '||p_svc_location_sn||'-p_physician_sn: '||p_physician_sn||'-p_prev_svc_billing_code: '||p_prev_svc_billing_code||'-p_svc_dt_begin: '||p_svc_dt_begin||'-p_svc_dt_end: '||p_svc_dt_end;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --user login tracking
    v_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
    common_dml_pkg.ins_user_login(v_user_role_id,v_pkg_name,v_proc_name,null,null,null,null,null);
    --
    --Check for the input validation rules:
    --1)Only Company Selection is required
    --
    --status initialization
    v_status := 'SUCCESSFUL';
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    obj.put('TITLE','PATIENT LIST');
    --
    if p_svc_dt_begin is not null then
      v_svc_dt_begin := to_date(p_svc_dt_begin,'YYYY-MM-DD');
    end if;
    if p_svc_dt_end is not null then
      v_svc_dt_end := to_date(p_svc_dt_end,'YYYY-MM-DD');
    end if;
    --Company selection have data isolation built in by the user login id
    if p_company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Company Selection is required.';
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
    if p_company_sn is not null then
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
    v_sub_title := 'HIC: '||p_hic||' - SSN: '||p_ssn||' - Last Name: '||p_last_name||' - First Name: '||p_first_name||' - Company: '||v_company_name||' - Location: '||v_svc_location_name||' - Physician: '||v_physician_name||' - Svc Name: '||v_prev_svc_billing_name||' - Svc Date Begin: '||p_svc_dt_begin||' - Svc Date End: '||p_svc_dt_end;
    --
    obj.put('SUB_TITLE1',v_sub_title);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','DOB');
    obj2.put('TH3','Physician');
    obj2.put('TH4','Physician Company');
    obj2.put('TH5','Meds');
    obj.put('th_label',obj2);
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
      for i in (select distinct patient_sn
                      ,pat_medicare_hic_num_full
                      ,pat_name
                      ,birth_date
                      ,pat_primary_physician_name||', '||physician_dr_type physician_name
                      ,PAT_PRIMARY_PHYSICIAN_COMPANY
                from pps_simplified_vw
                where completed_flag = 'Y' 
                and pat_physician_company_sn = p_company_sn
                and (p_hic is null or pat_medicare_hic_num_full = p_hic)
                and (p_ssn is null or pat_ssn = p_ssn)
                and (p_last_name is null or upper(pat_last_name) like '%'||upper(p_last_name)||'%')
                and (p_first_name is null or upper(pat_first_name) like '%'||upper(p_first_name)||'%')
                and (v_svc_location_sn is null or svc_location_sn in (select number_code from table(admin_inq_pkg.user_role_svc_location_sn(v_user_role_id,v_svc_location_sn))))
                and (v_physician_sn is null or physician_sn in (select number_code from table(admin_inq_pkg.user_role_physician_sn(v_user_role_id,v_physician_sn))))
                and (v_provider_physician_sn is null or provider_physician_sn = v_provider_physician_sn)
                and (p_prev_svc_billing_code is null or prev_svc_billing_code = p_prev_svc_billing_code)
                and (p_svc_dt_begin is null or svc_perform_date between v_svc_dt_begin and v_svc_dt_end)
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('PATIENT_SN',i.patient_sn);
        obj2.put('NAME',i.pat_name);
        obj2.put('DOB',i.birth_date);
        obj2.put('PHYSICIAN',i.physician_name);
        obj2.put('PHYSICIAN_COMPANY',i.PAT_PRIMARY_PHYSICIAN_COMPANY);
        --Append the object to the list
        l_obj.append(obj2.to_json_value);
      end loop;
    end if;
    if json_ac.array_count(l_obj) > 0 then
      v_msg := 'Patient data returned successfully..';
    else
      v_msg := 'No patient data returned with these criteria..';
    end if;
    --
    obj.put('patient_list',l_obj);
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end rpt_patient_list;  
END admin_inq_pkg;
/
SHOW ERRORS;