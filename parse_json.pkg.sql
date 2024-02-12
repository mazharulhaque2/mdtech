create or replace PACKAGE parse_json_pkg IS
  v_pkg_name    varchar2 (30) := upper('parse_json_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  function patient_response (p_json in varchar2) return t_question_response_code_tab PIPELINED;
  function provider_ccm_question (p_json in varchar2) return t_ccm_question_code_tab PIPELINED;
  function physician_em_name (p_json in varchar2) return t_em_name_code_tab PIPELINED;
  --function patient_prev_svc_remark (p_json in varchar2) return t_patient_prev_svc_remark_tab PIPELINED;
  --function patient_medication (p_json in varchar2) return t_patient_medication_tab PIPELINED;
  --
  procedure physician_em_schedule_parsing (p_json in varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype);
  procedure physician_em_parsing (p_json in varchar2,p_physician_em_rec OUT physician_em%rowtype);
  procedure provider_ccm_parsing (p_json in varchar2,p_provider_ccm_rec OUT provider_ccm%rowtype);
  PROCEDURE patient_parsing(p_json IN varchar2,p_patient_rec OUT patient%rowtype);
  PROCEDURE patient_prev_svc_demo_parsing(p_json IN varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype);
  procedure patient_medication_parsing (p_json in varchar2,p_patient_medication_rec OUT patient_medication%rowtype);
  procedure patient_remark_parsing (p_json in varchar2,p_patient_prev_svc_remark_rec OUT patient_prev_svc_remark%rowtype);
  PROCEDURE physician_parsing(p_json IN varchar2,p_physician_rec OUT physician%rowtype);
  PROCEDURE provider_physician_parsing(p_json IN varchar2,p_provider_physician_rec OUT provider_physician%rowtype);
  PROCEDURE provider_physician_update(p_json IN varchar2,p_provider_physician_rec OUT provider_physician%rowtype);
  PROCEDURE company_parsing(p_json IN varchar2,p_company_rec OUT company%rowtype);
  PROCEDURE user_parsing(p_json IN varchar2,p_user_rec OUT "AspNetUsers"%rowtype,p_userrole_rec OUT "AspNetUserRoles"%rowtype);
  PROCEDURE svc_location_parsing(p_json IN varchar2,p_svc_location_rec OUT svc_location%rowtype);
  PROCEDURE physician_svc_location_parsing(p_json IN varchar2,p_physician_svc_location_rec OUT physician_svc_location%rowtype);
  PROCEDURE user_svc_location_parsing(p_json IN varchar2,p_user_svc_location_rec OUT user_svc_location%rowtype);
  PROCEDURE user_company_parsing(p_json IN varchar2,p_user_company_rec OUT user_company%rowtype);
  PROCEDURE user_physician_parsing(p_json IN varchar2,p_user_physician_rec OUT user_physician%rowtype);
  PROCEDURE patient_prev_svc_parsing(p_json IN varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype);
  PROCEDURE contact_us_parsing(p_json IN varchar2,p_contact_us_rec OUT contact_us%rowtype);
  --
  procedure patient_response_parsing (p_json in varchar2,p_question_response_code_tbl out global_type_pkg.t_question_response_code_tbl);
  PROCEDURE mbr_parsing(p_mbr_json IN varchar2,p_mbr_rec   OUT "AspNetUsers"%rowtype);
  function medication_unit_code (p_medication_unit_descr in varchar2) return list_medication_unit.medication_unit_code%type;
  function frequency_unit (p_frequency_unit_descr in varchar2) return list_frequency_unit.frequency_unit_code%type;
  function frequency_unit_code (p_frequency_unit_code in varchar2) return list_frequency_unit.frequency_unit_code%type;
  function rev_frequency_unit_code (p_frequency_unit_code in varchar2) return list_frequency_unit.frequency_unit_code%type;
  PROCEDURE custom_addr_parsing_prc (p_addr_json IN varchar2
                                    ,p_state_rec out state%rowtype
                                    ,p_city_rec out city%rowtype
                                    ,p_addr_rec out addr%rowtype
                                     );
END parse_json_pkg;
/
show errors
create or replace PACKAGE BODY parse_json_pkg IS
  function frequency_unit (p_frequency_unit_descr in varchar2) return list_frequency_unit.frequency_unit_code%type
  is
    v_return list_frequency_unit.frequency_unit_code%type;
  begin
    if length(p_frequency_unit_descr) = 2 then
      return upper(p_frequency_unit_descr);
    else
      select frequency_unit_code
      into v_return
      from frequency_unit_lang
      where lower(short_descr) = lower(p_frequency_unit_descr)
      and lang_code = 'en'
      ;
      return v_return;
    end if;
  exception
    when others then return null;
  end frequency_unit;
  --
  function rev_frequency_unit_code (p_frequency_unit_code in varchar2) return list_frequency_unit.frequency_unit_code%type
  is
    v_frequency_unit_code list_frequency_unit.frequency_unit_code%type;
  begin
    if p_frequency_unit_code = '1D' then return 'D1';
    elsif p_frequency_unit_code = '2D' then return 'D2';
    elsif p_frequency_unit_code = '3D' then return 'D3';
    elsif p_frequency_unit_code = '4D' then return 'D4';
    elsif p_frequency_unit_code = '5D' then return 'D5';
    elsif p_frequency_unit_code = '6D' then return 'D6';
    elsif p_frequency_unit_code = '7D' then return 'D7';
    elsif p_frequency_unit_code = '8D' then return 'D8';
    elsif p_frequency_unit_code = '9D' then return 'D9';
    elsif p_frequency_unit_code = '10' then return 'A0';
    elsif p_frequency_unit_code = '11' then return 'A1';
    else return p_frequency_unit_code;
    end if;
  end rev_frequency_unit_code;

  function frequency_unit_code (p_frequency_unit_code in varchar2) return list_frequency_unit.frequency_unit_code%type
  is
    v_frequency_unit_code list_frequency_unit.frequency_unit_code%type;
  begin
    if p_frequency_unit_code = 'D1' then return '1D';
    elsif p_frequency_unit_code = 'D2' then return '2D';
    elsif p_frequency_unit_code = 'D3' then return '3D';
    elsif p_frequency_unit_code = 'D4' then return '4D';
    elsif p_frequency_unit_code = 'D5' then return '5D';
    elsif p_frequency_unit_code = 'D6' then return '6D';
    elsif p_frequency_unit_code = 'D7' then return '7D';
    elsif p_frequency_unit_code = 'D8' then return '8D';
    elsif p_frequency_unit_code = 'D9' then return '9D';
    elsif p_frequency_unit_code = 'A0' then return '10';
    elsif p_frequency_unit_code = 'A1' then return '11';
    else return p_frequency_unit_code;
    end if;
  end frequency_unit_code;
  --
  PROCEDURE custom_addr_parsing_prc (p_addr_json IN varchar2
                                    ,p_state_rec out state%rowtype
                                    ,p_city_rec out city%rowtype
                                    ,p_addr_rec out addr%rowtype
                                     )
  as
    obj json;
    tempdata json_value;
  begin
    v_proc_name := upper('custom_addr_parsing_prc');
    v_err_msg := null;
    v_input_str := 'p_addr_json: '||p_addr_json;
    --
    --Insert as part of testing. Should be commented in prod env
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    obj := json(p_addr_json);
    --
    p_addr_rec.SOURCE_FROM_GOOGLE_API_FLAG := 'N';
    --
    if obj.exist('ADDR_1') then
      tempdata := obj.get('ADDR_1');
      if tempdata is not null then
        p_addr_rec.ADDR_1 := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('ADDR_2') then
      tempdata := obj.get('ADDR_2');
      if tempdata is not null then
        p_addr_rec.ADDR_2 := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CITY') then
      tempdata := obj.get('CITY');
      if tempdata is not null then
        p_city_rec.name := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('STATE_CODE') then
      tempdata := obj.get('STATE_CODE');
      if tempdata is not null then
        p_state_rec.STATE_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('COUNTRY_CODE') then
      tempdata := obj.get('COUNTRY_CODE');
      if tempdata is not null then
        p_state_rec.COUNTRY_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('POSTAL_CODE') then
      tempdata := obj.get('POSTAL_CODE');
      if tempdata is not null then
        p_addr_rec.POSTAL_CODE := tempdata.get_string;
      end if;
    end if;
  exception
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
  end custom_addr_parsing_prc;
  --
  PROCEDURE svc_location_parsing(p_json IN varchar2,p_svc_location_rec OUT svc_location%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('COMPANY_SN') then
      tempdata := obj.get('COMPANY_SN');
      if tempdata is not null then
        p_svc_location_rec.COMPANY_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('NAME') then
      tempdata := obj.get('NAME');
      if tempdata is not null then
        p_svc_location_rec.NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_LOCATION_TYPE_CODE') then
      tempdata := obj.get('SVC_LOCATION_TYPE_CODE');
      if tempdata is not null then
        p_svc_location_rec.SVC_LOCATION_TYPE_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CONTACT_NAME') then
      tempdata := obj.get('CONTACT_NAME');
      if tempdata is not null then
        p_svc_location_rec.CONTACT_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHONE_NUM_1') then
      tempdata := obj.get('PHONE_NUM_1');
      if tempdata is not null then
        p_svc_location_rec.PHONE_NUM_1 := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHONE_NUM_2') then
      tempdata := obj.get('PHONE_NUM_2');
      if tempdata is not null then
        p_svc_location_rec.PHONE_NUM_2 := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FAX_NUM_1') then
      tempdata := obj.get('FAX_NUM_1');
      if tempdata is not null then
        p_svc_location_rec.FAX_NUM_1 := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FAX_NUM_2') then
      tempdata := obj.get('FAX_NUM_2');
      if tempdata is not null then
        p_svc_location_rec.FAX_NUM_2 := tempdata.get_string;
      end if;
    end if;
    if obj.exist('EMAIL_ADDR') then
      tempdata := obj.get('EMAIL_ADDR');
      if tempdata is not null then
        p_svc_location_rec.EMAIL_ADDR := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_svc_location_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;    
  end svc_location_parsing;
  --
  PROCEDURE user_parsing(p_json IN varchar2,p_user_rec OUT "AspNetUsers"%rowtype,p_userrole_rec OUT "AspNetUserRoles"%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    --p_json := '{"USER_ROLE_ID": "AA44BBXX","ROLE_ID": "AB54XcD5","COMPANY_SN": 22,"FIRST_NAME": "John","MIDDLE_NAME": null,"LAST_NAME": "Doe","PHONE": "954-999-8888","SVC_PROVIDER_FLAG": "Y"}';
    obj    := json(p_json);
    --
    if obj.exist('USER_ROLE_ID') then
      tempdata := obj.get('USER_ROLE_ID');
      if tempdata is not null then
        p_userrole_rec.USER_ROLE_ID := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('ROLE_ID') then
      tempdata := obj.get('ROLE_ID');
      if tempdata is not null then
        p_userrole_rec."RoleId" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('COMPANY_SN') then
      tempdata := obj.get('COMPANY_SN');
      if tempdata is not null then
        p_user_rec.COMPANY_SN := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_user_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('MIDDLE_NAME') then
      tempdata := obj.get('MIDDLE_NAME');
      if tempdata is not null then
        p_user_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_user_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PHONE') then
      tempdata := obj.get('PHONE');
      if tempdata is not null then
        p_user_rec."PhoneNumber" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('SVC_PROVIDER_FLAG') then
      tempdata := obj.get('SVC_PROVIDER_FLAG');
      if tempdata is not null then
        p_user_rec.SVC_PROVIDER_FLAG := tempdata.get_string;
      end if;
    end if;
  end user_parsing;
  --
  PROCEDURE company_parsing(p_json IN varchar2,p_company_rec OUT company%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('NAME') then
      tempdata := obj.get('NAME');
      if tempdata is not null then
        p_company_rec.NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CONTACT_NAME') then
      tempdata := obj.get('CONTACT_NAME');
      if tempdata is not null then
        p_company_rec.CONTACT_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHONE_NUMBER') then
      tempdata := obj.get('PHONE_NUMBER');
      if tempdata is not null then
        p_company_rec.PHONE_NUMBER := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FAX_NUMBER') then
      tempdata := obj.get('FAX_NUMBER');
      if tempdata is not null then
        p_company_rec.FAX_NUMBER := tempdata.get_string;
      end if;
    end if;
    if obj.exist('TOLL_FREE_NUMBER') then
      tempdata := obj.get('TOLL_FREE_NUMBER');
      if tempdata is not null then
        p_company_rec.TOLL_FREE_NUMBER := tempdata.get_string;
      end if;
    end if;
    if obj.exist('WEBSITE_ADDR') then
      tempdata := obj.get('WEBSITE_ADDR');
      if tempdata is not null then
        p_company_rec.WEBSITE_ADDR := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_company_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
  end company_parsing;
  --
  PROCEDURE provider_physician_parsing(p_json IN varchar2,p_provider_physician_rec OUT provider_physician%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('NPI') then
      tempdata := obj.get('NPI');
      if tempdata is not null then
        p_provider_physician_rec.NPI := tempdata.get_number;
      end if;
    end if;
    if obj.exist('LICENSE_NUM') then
      tempdata := obj.get('LICENSE_NUM');
      if tempdata is not null then
        p_provider_physician_rec.LICENSE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('TITLE') then
      tempdata := obj.get('TITLE');
      if tempdata is not null then
        p_provider_physician_rec.TITLE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHYSICIAN_TYPE_CODE') then
      tempdata := obj.get('PHYSICIAN_TYPE_CODE');
      if tempdata is not null then
        p_provider_physician_rec.PHYSICIAN_TYPE_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SKYPE_ID') then
      tempdata := obj.get('SKYPE_ID');
      if tempdata is not null then
        p_provider_physician_rec.SKYPE_ID := tempdata.get_string;
      end if;
    end if;
    if obj.exist('COMPANY_SN') then
      tempdata := obj.get('COMPANY_SN');
      if tempdata is not null then
        p_provider_physician_rec.COMPANY_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_provider_physician_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;    
    if obj.exist('PHYSICIAN_USER_ROLE_ID') then
      tempdata := obj.get('PHYSICIAN_USER_ROLE_ID');
      if tempdata is not null then
        p_provider_physician_rec.PHYSICIAN_USER_ROLE_ID := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_provider_physician_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_provider_physician_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('MIDDLE_NAME') then
      tempdata := obj.get('MIDDLE_NAME');
      if tempdata is not null then
        p_provider_physician_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CONTACT_PHONE_NUM') then
      tempdata := obj.get('CONTACT_PHONE_NUM');
      if tempdata is not null then
        p_provider_physician_rec.CONTACT_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('EMAIL_ADDR') then
      tempdata := obj.get('EMAIL_ADDR');
      if tempdata is not null then
        p_provider_physician_rec.EMAIL_ADDR := tempdata.get_string;
      end if;
    end if;    
    if obj.exist('DR_TYPE_CODE') then
      tempdata := obj.get('DR_TYPE_CODE');
      if tempdata is not null then
        p_provider_physician_rec.DR_TYPE := tempdata.get_string;
      end if;
    end if;
  end provider_physician_parsing;
  --
  PROCEDURE provider_physician_update(p_json IN varchar2,p_provider_physician_rec OUT provider_physician%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('NPI') then
      tempdata := obj.get('NPI');
      if tempdata is not null then
        p_provider_physician_rec.NPI := tempdata.get_number;
      end if;
    end if;
    if obj.exist('LICENSE_NUM') then
      tempdata := obj.get('LICENSE_NUM');
      if tempdata is not null then
        p_provider_physician_rec.LICENSE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('TITLE') then
      tempdata := obj.get('TITLE');
      if tempdata is not null then
        p_provider_physician_rec.TITLE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHYSICIAN_TYPE_CODE') then
      tempdata := obj.get('PHYSICIAN_TYPE_CODE');
      if tempdata is not null then
        p_provider_physician_rec.PHYSICIAN_TYPE_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('DR_TYPE_CODE') then
      tempdata := obj.get('DR_TYPE_CODE');
      if tempdata is not null then
        p_provider_physician_rec.DR_TYPE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_provider_physician_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;    
  end provider_physician_update;
  --
  PROCEDURE physician_parsing(p_json IN varchar2,p_physician_rec OUT physician%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('NPI') then
      tempdata := obj.get('NPI');
      if tempdata is not null then
        p_physician_rec.NPI := tempdata.get_number;
      end if;
    end if;
    if obj.exist('LICENSE_NUM') then
      tempdata := obj.get('LICENSE_NUM');
      if tempdata is not null then
        p_physician_rec.LICENSE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('TITLE') then
      tempdata := obj.get('TITLE');
      if tempdata is not null then
        p_physician_rec.TITLE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHYSICIAN_TYPE_CODE') then
      tempdata := obj.get('PHYSICIAN_TYPE_CODE');
      if tempdata is not null then
        p_physician_rec.PHYSICIAN_TYPE_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SKYPE_ID') then
      tempdata := obj.get('SKYPE_ID');
      if tempdata is not null then
        p_physician_rec.SKYPE_ID := tempdata.get_string;
      end if;
    end if;
    if obj.exist('COMPANY_SN') then
      tempdata := obj.get('COMPANY_SN');
      if tempdata is not null then
        p_physician_rec.COMPANY_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_physician_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_physician_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_physician_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('MIDDLE_NAME') then
      tempdata := obj.get('MIDDLE_NAME');
      if tempdata is not null then
        p_physician_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CONTACT_PHONE_NUM') then
      tempdata := obj.get('CONTACT_PHONE_NUM');
      if tempdata is not null then
        p_physician_rec.CONTACT_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('EMAIL_ADDR') then
      tempdata := obj.get('EMAIL_ADDR');
      if tempdata is not null then
        p_physician_rec.EMAIL_ADDR := tempdata.get_string;
      end if;
    end if;
    if obj.exist('DR_TYPE_CODE') then
      tempdata := obj.get('DR_TYPE_CODE');
      if tempdata is not null then
        p_physician_rec.DR_TYPE := tempdata.get_string;
      end if;
    end if;
  end physician_parsing;
  --
  PROCEDURE patient_parsing(p_json IN varchar2,p_patient_rec OUT patient%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('SSN') then
      tempdata := obj.get('SSN');
      if tempdata is not null then
        p_patient_rec.SSN := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHYSICIAN_SN') then
      tempdata := obj.get('PHYSICIAN_SN');
      if tempdata is not null then
        p_patient_rec.PHYSICIAN_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('MEDICARE_HIC_NUM') then
      tempdata := obj.get('MEDICARE_HIC_NUM');
      if tempdata is not null then
        p_patient_rec.MEDICARE_HIC_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('GENDER_CODE') then
      tempdata := obj.get('GENDER_CODE');
      if tempdata is not null then
        p_patient_rec.GENDER_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('RACE_CODE') then
      tempdata := obj.get('RACE_CODE');
      if tempdata is not null then
        p_patient_rec.RACE_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('ETHNICITY_CODE') then
      tempdata := obj.get('ETHNICITY_CODE');
      if tempdata is not null then
        p_patient_rec.ETHNICITY_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_patient_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_patient_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('MIDDLE_NAME') then
      tempdata := obj.get('MIDDLE_NAME');
      if tempdata is not null then
        p_patient_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CONTACT_PHONE_NUM') then
      tempdata := obj.get('CONTACT_PHONE_NUM');
      if tempdata is not null then
        p_patient_rec.CONTACT_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    if obj.exist('EMAIL_ADDR') then
      tempdata := obj.get('EMAIL_ADDR');
      if tempdata is not null then
        p_patient_rec.EMAIL_ADDR := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SKYPE_ID') then
      tempdata := obj.get('SKYPE_ID');
      if tempdata is not null then
        p_patient_rec.SKYPE_ID := tempdata.get_string;
      end if;
    end if;
    if obj.exist('BIRTH_DATE') then
      tempdata := obj.get('BIRTH_DATE');
      if tempdata is not null then
        p_patient_rec.BIRTH_DATE := to_date(substr(tempdata.get_string,1,10),'YYYY-MM-DD');
      end if;
    end if;
    if obj.exist('LEGAL_GUARDIAN_NAME') then
      tempdata := obj.get('LEGAL_GUARDIAN_NAME');
      if tempdata is not null then
        p_patient_rec.LEGAL_GUARDIAN_NAME := tempdata.get_string;
      end if;
    end if;
    if obj.exist('LEGAL_GUARDIAN_PH') then
      tempdata := obj.get('LEGAL_GUARDIAN_PH');
      if tempdata is not null then
        p_patient_rec.LEGAL_GUARDIAN_PH := tempdata.get_string;
      end if;
    end if;
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_patient_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
  end patient_parsing;
  --
  PROCEDURE patient_prev_svc_demo_parsing(p_json IN varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('PATIENT_PREV_SVC_SN') then
      tempdata := obj.get('PATIENT_PREV_SVC_SN');
      if tempdata is not null then
        p_patient_prev_svc_rec.PATIENT_PREV_SVC_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('MARITAL_STATUS_CODE') then
      tempdata := obj.get('MARITAL_STATUS_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.MARITAL_STATUS_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('WORKING_STATUS_CODE') then
      tempdata := obj.get('WORKING_STATUS_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.WORKING_STATUS_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('EDUCATION_LEVEL_CODE') then
      tempdata := obj.get('EDUCATION_LEVEL_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.EDUCATION_LEVEL_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('FINANCIAL_STATUS_CODE') then
      tempdata := obj.get('FINANCIAL_STATUS_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.FINANCIAL_STATUS_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('LIVING_STATUS_CODE') then
      tempdata := obj.get('LIVING_STATUS_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.LIVING_STATUS_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('INCOME_CODE') then
      tempdata := obj.get('INCOME_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.INCOME_CODE := tempdata.get_string;
      end if;
    end if;
    --Here input height will be entered as decimal. E.g. 5.7 means 5 feet 7 inches with max height limitation of 8.1
    --HEIGHT_IN_IN is currentl coming as number and needs to change to come as string from UI. Once that is fixed, this logic can be simplified only for string
    if obj.exist('HEIGHT_IN_IN') then
      tempdata := obj.get('HEIGHT_IN_IN');
      if tempdata.is_number then
        if tempdata is not null then
          p_patient_prev_svc_rec.HEIGHT_IN_IN := common_pkg.height_in_inch(tempdata.get_number);
        end if;
      elsif tempdata.is_string then
        if tempdata is not null then
          p_patient_prev_svc_rec.HEIGHT_IN_IN := common_pkg.height_in_inch(tempdata.get_string);
        end if;
      end if;
    end if;
    if obj.exist('WEIGHT_IN_LB') then
      tempdata := obj.get('WEIGHT_IN_LB');
      if tempdata is not null then
        p_patient_prev_svc_rec.WEIGHT_IN_LB := tempdata.get_number;
      end if;
    end if;
    if obj.exist('HDL_CHOLESTEROL_IN_MG') then
      tempdata := obj.get('HDL_CHOLESTEROL_IN_MG');
      if tempdata is not null then
        p_patient_prev_svc_rec.HDL_CHOLESTEROL_IN_MG := tempdata.get_number;
      end if;
    end if;
    if obj.exist('LDL_CHOLESTEROL_IN_MG') then
      tempdata := obj.get('LDL_CHOLESTEROL_IN_MG');
      if tempdata is not null then
        p_patient_prev_svc_rec.LDL_CHOLESTEROL_IN_MG := tempdata.get_number;
      end if;
    end if;
    if obj.exist('SYSTOLIC_BP_IN_MM') then
      tempdata := obj.get('SYSTOLIC_BP_IN_MM');
      if tempdata is not null then
        p_patient_prev_svc_rec.SYSTOLIC_BP_IN_MM := tempdata.get_number;
      end if;
    end if;
    if obj.exist('DIASTOLIC_BP_IN_MM') then
      tempdata := obj.get('DIASTOLIC_BP_IN_MM');
      if tempdata is not null then
        p_patient_prev_svc_rec.DIASTOLIC_BP_IN_MM := tempdata.get_number;
      end if;
    end if;
    if obj.exist('BLOOD_SUGAR_LEVEL_IN_MG') then
      tempdata := obj.get('BLOOD_SUGAR_LEVEL_IN_MG');
      if tempdata is not null then
        p_patient_prev_svc_rec.BLOOD_SUGAR_LEVEL_IN_MG := tempdata.get_number;
      end if;
    end if;  
    if obj.exist('SOURCE_OF_HISTORY_EMR_FLAG') then
      tempdata := obj.get('SOURCE_OF_HISTORY_EMR_FLAG');
      if tempdata is not null then
        p_patient_prev_svc_rec.SOURCE_OF_HISTORY_EMR_FLAG := tempdata.get_string;
      end if;
    end if;  
    if obj.exist('SOURCE_OF_HISTORY_PATIENT_FLAG') then
      tempdata := obj.get('SOURCE_OF_HISTORY_PATIENT_FLAG');
      if tempdata is not null then
        p_patient_prev_svc_rec.SOURCE_OF_HISTORY_PATIENT_FLAG := tempdata.get_string;
      end if;
    end if;  
    if obj.exist('SOURCE_OF_HISTORY_FAMILY_FLAG') then
      tempdata := obj.get('SOURCE_OF_HISTORY_FAMILY_FLAG');
      if tempdata is not null then
        p_patient_prev_svc_rec.SOURCE_OF_HISTORY_FAMILY_FLAG := tempdata.get_string;
      end if;
    end if;  
    if obj.exist('PATIENT_ORIENTATION_CODE') then
      tempdata := obj.get('PATIENT_ORIENTATION_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.PATIENT_ORIENTATION_CODE := tempdata.get_string;
      end if;
    end if;    
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_patient_prev_svc_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
  end patient_prev_svc_demo_parsing;
  --
  procedure patient_remark_parsing (p_json in varchar2,p_patient_prev_svc_remark_rec OUT patient_prev_svc_remark%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('REMARK_NOTE') then
      tempdata := obj.get('REMARK_NOTE');
      if tempdata is not null then
        p_patient_prev_svc_remark_rec.REMARK_NOTE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PATIENT_PREV_SVC_SN') then
      tempdata := obj.get('PATIENT_PREV_SVC_SN');
      if tempdata is not null then
        p_patient_prev_svc_remark_rec.PATIENT_PREV_SVC_SN := tempdata.get_number;
      end if;
    end if;
  end patient_remark_parsing;
  --
  function medication_unit_code (p_medication_unit_descr in varchar2) return list_medication_unit.medication_unit_code%type
  is
    v_return list_medication_unit.medication_unit_code%type;
  begin
    if length(p_medication_unit_descr) = 2 then
      return upper(p_medication_unit_descr);
    else
      select medication_unit_code
      into v_return
      from medication_unit_lang
      where lower(short_descr) = lower(p_medication_unit_descr)
      and lang_code = 'en'
      ;
      return v_return;
    end if;
  exception
    when others then return null;
  end medication_unit_code;
  --
  procedure patient_medication_parsing (p_json in varchar2,p_patient_medication_rec OUT patient_medication%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('NAME') then
      tempdata := obj.get('NAME');
      if tempdata is not null then
        p_patient_medication_rec.NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('QUANTITY') then
      tempdata := obj.get('QUANTITY');
      if tempdata is not null then
        p_patient_medication_rec.MEDICATION_QUANTITY := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('QUANTITY_UNIT_CODE') then
      tempdata := obj.get('QUANTITY_UNIT_CODE');
      if tempdata is not null then
        p_patient_medication_rec.MEDICATION_UNIT_CODE := medication_unit_code(tempdata.get_string);
      end if;
    end if;
    --
    if obj.exist('INGREDIENTS') then
      tempdata := obj.get('INGREDIENTS');
      if tempdata is not null then
        p_patient_medication_rec.INGREDIENTS := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PURPOSE') then
      tempdata := obj.get('PURPOSE');
      if tempdata is not null then
        p_patient_medication_rec.PURPOSE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('FREQUENCY_UNIT') then
      tempdata := obj.get('FREQUENCY_UNIT');
      if tempdata is not null then
        p_patient_medication_rec.FREQUENCY_UNIT_CODE := frequency_unit_code(frequency_unit(tempdata.get_string));
      end if;
    end if;
    --
    if obj.exist('NOTES') then
      tempdata := obj.get('NOTES');
      if tempdata is not null then
        p_patient_medication_rec.NOTES := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CURRENT') then
      tempdata := obj.get('CURRENT');
      if tempdata is not null then
        p_patient_medication_rec.MEDICATION_CURRENT_FLAG := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PRESCRIBED_MED_FLAG') then
      tempdata := obj.get('PRESCRIBED_MED_FLAG');
      if tempdata is not null then
        p_patient_medication_rec.PRESCRIBED_MED_FLAG := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_patient_medication_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    --
    if obj.exist('PATIENT_SN') then
      tempdata := obj.get('PATIENT_SN');
      if tempdata is not null then
        p_patient_medication_rec.PATIENT_SN := tempdata.get_number;
      end if;
    end if;
  end patient_medication_parsing;
  --
  function patient_response (p_json in varchar2) return t_question_response_code_tab PIPELINED 
  as
    obj json;
    l_obj json_list;
    l_row t_question_response_code_obj := t_question_response_code_obj(null);
  begin
    v_proc_name := upper('patient_response');
    v_err_msg := null;
    v_input_str := 'p_json: '||p_json;
    --
    --Insert as part of testing. Should be commented in prod env
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    obj := json(p_json);
    l_obj := obj.get_values;
    --l_obj := json_list(p_json);
    --
    for i in 1..json_ac.array_count(l_obj) loop
      l_row.question_response_code := json_ac.array_get(l_obj,i).get_string;
      PIPE ROW (l_row);
    end loop;
  end patient_response;
  --
  procedure physician_em_schedule_parsing (p_json in varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('PATIENT_PREV_SVC_SN') then
      tempdata := obj.get('PATIENT_PREV_SVC_SN');
      if tempdata is not null then
        p_patient_prev_svc_rec.PATIENT_PREV_SVC_SN := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('REQUEST_EM_PERF_BY_PCP_FLAG') then
      tempdata := obj.get('REQUEST_EM_PERF_BY_PCP_FLAG');
      if tempdata is not null then
        p_patient_prev_svc_rec.REQUEST_EM_PERF_BY_PCP_FLAG := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('COMMENT_WHEN_DENY_EM') then
      tempdata := obj.get('COMMENT_WHEN_DENY_EM');
      if tempdata is not null then
        p_patient_prev_svc_rec.COMMENT_WHEN_DENY_EM := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('EM_FOLLOWUP_SVC_DATE') then
      tempdata := obj.get('EM_FOLLOWUP_SVC_DATE');
      if tempdata is not null then
        p_patient_prev_svc_rec.EM_FOLLOWUP_SVC_DATE := to_date(substr(tempdata.get_string,1,10),'YYYY-MM-DD');
      end if;
    end if;
    --
    if obj.exist('EM_FOLLOWUP_SVC_HR_CODE') then
      tempdata := obj.get('EM_FOLLOWUP_SVC_HR_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.EM_FOLLOWUP_SVC_HR_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('EM_FOLLOWUP_SVC_MIN_CODE') then
      tempdata := obj.get('EM_FOLLOWUP_SVC_MIN_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.EM_FOLLOWUP_SVC_MIN_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('EM_FOLLOWUP_SVC_AM_PM_CODE') then
      tempdata := obj.get('EM_FOLLOWUP_SVC_AM_PM_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.EM_FOLLOWUP_SVC_AM_PM_CODE := tempdata.get_string;
      end if;
    end if;
  end physician_em_schedule_parsing;
  --
  procedure physician_em_parsing (p_json in varchar2,p_physician_em_rec OUT physician_em%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('PATIENT_PREV_SVC_SN') then
      tempdata := obj.get('PATIENT_PREV_SVC_SN');
      if tempdata is not null then
        p_physician_em_rec.PATIENT_PREV_SVC_SN := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('TEMP_IN_FAHRENHEIT') then
      tempdata := obj.get('TEMP_IN_FAHRENHEIT');
      if tempdata is not null then
        p_physician_em_rec.TEMP_IN_FAHRENHEIT := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('SYSTOLIC_BP_IN_MM') then
      tempdata := obj.get('SYSTOLIC_BP_IN_MM');
      if tempdata is not null then
        p_physician_em_rec.SYSTOLIC_BP_IN_MM := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('DIASTOLIC_BP_IN_MM') then
      tempdata := obj.get('DIASTOLIC_BP_IN_MM');
      if tempdata is not null then
        p_physician_em_rec.DIASTOLIC_BP_IN_MM := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('PULSE_RATE_IN_BPM') then
      tempdata := obj.get('PULSE_RATE_IN_BPM');
      if tempdata is not null then
        p_physician_em_rec.PULSE_RATE_IN_BPM := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('RESPIRATORY_RATE_IN_BPM') then
      tempdata := obj.get('RESPIRATORY_RATE_IN_BPM');
      if tempdata is not null then
        p_physician_em_rec.RESPIRATORY_RATE_IN_BPM := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('RHYTHM_IND') then
      tempdata := obj.get('RHYTHM_IND');
      if tempdata is not null then
        p_physician_em_rec.RHYTHM_IND := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PREVENTATIVE_SCHEDULING') then
      tempdata := obj.get('PREVENTATIVE_SCHEDULING');
      if tempdata is not null then
        p_physician_em_rec.PREVENTATIVE_SCHEDULING := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('LAB_AND_TEST_PRESCRIBED') then
      tempdata := obj.get('LAB_AND_TEST_PRESCRIBED');
      if tempdata is not null then
        p_physician_em_rec.LAB_AND_TEST_PRESCRIBED := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('REFERRALS_TO_SPECIALIST') then
      tempdata := obj.get('REFERRALS_TO_SPECIALIST');
      if tempdata is not null then
        p_physician_em_rec.REFERRALS_TO_SPECIALIST := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('RX_MAJ_DIS_OR_HEALTH_EVENT') then
      tempdata := obj.get('RX_MAJ_DIS_OR_HEALTH_EVENT');
      if tempdata is not null then
        p_physician_em_rec.RX_MAJ_DIS_OR_HEALTH_EVENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('RX_PREV_SVC_BILLING_CODE') then
      tempdata := obj.get('RX_PREV_SVC_BILLING_CODE');
      if tempdata is not null then
        if tempdata.get_string <> '99999' then
          p_physician_em_rec.RX_PREV_SVC_BILLING_CODE := tempdata.get_string;
        end if;
      end if;
    end if;
  end physician_em_parsing;
  --
  procedure provider_ccm_parsing (p_json in varchar2,p_provider_ccm_rec OUT provider_ccm%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('PATIENT_PREV_SVC_SN') then
      tempdata := obj.get('PATIENT_PREV_SVC_SN');
      if tempdata is not null then
        p_provider_ccm_rec.PATIENT_PREV_SVC_SN := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('SYMPTOM_COMMENT') then
      tempdata := obj.get('SYMPTOM_COMMENT');
      if tempdata is not null then
        p_provider_ccm_rec.SYMPTOM_COMMENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('MEDICATION_COMMENT') then
      tempdata := obj.get('MEDICATION_COMMENT');
      if tempdata is not null then
        p_provider_ccm_rec.MEDICATION_COMMENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('FAMILY_PMHX_COMMENT') then
      tempdata := obj.get('FAMILY_PMHX_COMMENT');
      if tempdata is not null then
        p_provider_ccm_rec.FAMILY_PMHX_COMMENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('RF_COMMENT') then
      tempdata := obj.get('RF_COMMENT');
      if tempdata is not null then
        p_provider_ccm_rec.RF_COMMENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('DISEASE_COMMENT') then
      tempdata := obj.get('DISEASE_COMMENT');
      if tempdata is not null then
        p_provider_ccm_rec.DISEASE_COMMENT := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('ADDITIONAL_NOTES') then
      tempdata := obj.get('ADDITIONAL_NOTES');
      if tempdata is not null then
        p_provider_ccm_rec.ADDITIONAL_NOTES := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CCM_FOLLOWUP_SVC_DATE') then
      tempdata := obj.get('CCM_FOLLOWUP_SVC_DATE');
      if tempdata is not null then
        p_provider_ccm_rec.CCM_FOLLOWUP_SVC_DATE := to_date(substr(tempdata.get_string,1,10),'YYYY-MM-DD');
      end if;
    end if;
    --
    if obj.exist('CCM_FOLLOWUP_SVC_HR_CODE') then
      tempdata := obj.get('CCM_FOLLOWUP_SVC_HR_CODE');
      if tempdata is not null then
        p_provider_ccm_rec.CCM_FOLLOWUP_SVC_HR_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CCM_FOLLOWUP_SVC_MIN_CODE') then
      tempdata := obj.get('CCM_FOLLOWUP_SVC_MIN_CODE');
      if tempdata is not null then
        p_provider_ccm_rec.CCM_FOLLOWUP_SVC_MIN_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('CCM_FOLLOWUP_SVC_AM_PM_CODE') then
      tempdata := obj.get('CCM_FOLLOWUP_SVC_AM_PM_CODE');
      if tempdata is not null then
        p_provider_ccm_rec.CCM_FOLLOWUP_SVC_AM_PM_CODE := tempdata.get_string;
      end if;
    end if;
  end provider_ccm_parsing;
  --
  function valid_em_name_code (p_string in nvarchar2) return boolean
  is
    l_cnt number(9);
  begin
    select count(*)
    into l_cnt
    from list_em_name
    where em_name_code = p_string
    ;
    if l_cnt = 0 then return false;
    else return true;
    end if;
  end valid_em_name_code;
  --
  function physician_em_name (p_json in varchar2) return t_em_name_code_tab PIPELINED 
  as
    obj json;
    l_obj json_list;
    l_row t_em_name_code_obj := t_em_name_code_obj(null);
    v_array_string nvarchar2(1000);
  begin
    v_proc_name := upper('physician_em_name');
    v_err_msg := null;
    v_input_str := 'p_json: '||p_json;
    --
    --Insert as part of testing. Should be commented in prod env
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    obj := json(p_json);
    l_obj := obj.get_values;
    --l_obj := json_list(p_json);
    --
    for i in 1..json_ac.array_count(l_obj) loop
      v_array_string := json_ac.array_get(l_obj,i).get_string;
      if length(v_array_string) = 6 and valid_em_name_code(v_array_string) then
        l_row.em_name_code := v_array_string;
        PIPE ROW (l_row);
      end if;
    end loop;
  end physician_em_name;
  --
  function provider_ccm_question (p_json in varchar2) return t_ccm_question_code_tab PIPELINED 
  as
    obj json;
    l_obj json_list;
    l_row t_ccm_question_code_obj := t_ccm_question_code_obj(null);
  begin
    v_proc_name := upper('provider_ccm_question');
    v_err_msg := null;
    v_input_str := 'p_json: '||p_json;
    --
    --Insert as part of testing. Should be commented in prod env
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    obj := json(p_json);
    l_obj := obj.get_values;
    --l_obj := json_list(p_json);
    --
    for i in 1..json_ac.array_count(l_obj) loop
      l_row.ccm_question_code := json_ac.array_get(l_obj,i).get_string;
      PIPE ROW (l_row);
    end loop;
  end provider_ccm_question;

--  function patient_prev_svc_remark (p_json in varchar2) return t_patient_prev_svc_remark_tab PIPELINED 
--  as
--    obj json;
--    tempdata      json_value;
--    l_obj json_list;
--    l_row t_patient_prev_svc_remark_obj := t_patient_prev_svc_remark_obj(null);
--  begin
--    v_proc_name := upper('patient_prev_svc_remark');
--    v_err_msg := null;
--    v_input_str := 'p_json: '||p_json;
--    --
--    --Insert as part of testing. Should be commented in prod env
--    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
--    l_obj := json_list(p_json);
--    --
--    for i in 1..json_ac.array_count(l_obj) loop
--      obj := json(json_ac.array_get(l_obj,i));
--      --
--      if obj.exist('REMARK_NOTE') then
--        tempdata := obj.get('REMARK_NOTE');
--        if tempdata is not null then
--          l_row.REMARK_NOTE := tempdata.get_string;
--        end if;
--      end if;
--      --
--      PIPE ROW (l_row);
--    end loop;
--  end patient_prev_svc_remark;
--  --
--  function patient_medication (p_json in varchar2) return t_patient_medication_tab PIPELINED 
--  as
--    obj json;
--    tempdata      json_value;
--    l_obj json_list;
--    l_row t_patient_medication_obj := t_patient_medication_obj(null,null,null,null,null,null,null,null);
--  begin
--    v_proc_name := upper('patient_medication');
--    v_err_msg := null;
--    v_input_str := 'p_json: '||p_json;
--    --
--    --Insert as part of testing. Should be commented in prod env
--    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
--    l_obj := json_list(p_json);
--    --
--    for i in 1..json_ac.array_count(l_obj) loop
--      obj := json(json_ac.array_get(l_obj,i));
--      --
--      if obj.exist('NAME') then
--        tempdata := obj.get('NAME');
--        if tempdata is not null then
--          l_row.NAME := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('MEDICATION_QUANTITY') then
--        tempdata := obj.get('MEDICATION_QUANTITY');
--        if tempdata is not null then
--          l_row.MEDICATION_QUANTITY := tempdata.get_number;
--        end if;
--      end if;
--      --
--      if obj.exist('MEDICATION_UNIT_CODE') then
--        tempdata := obj.get('MEDICATION_UNIT_CODE');
--        if tempdata is not null then
--          l_row.MEDICATION_UNIT_CODE := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('INGREDIENTS') then
--        tempdata := obj.get('INGREDIENTS');
--        if tempdata is not null then
--          l_row.INGREDIENTS := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('PURPOSE') then
--        tempdata := obj.get('PURPOSE');
--        if tempdata is not null then
--          l_row.PURPOSE := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('FREQUENCY_UNIT_CODE') then
--        tempdata := obj.get('FREQUENCY_UNIT_CODE');
--        if tempdata is not null then
--          l_row.FREQUENCY_UNIT_CODE := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('NOTES') then
--        tempdata := obj.get('NOTES');
--        if tempdata is not null then
--          l_row.NOTES := tempdata.get_string;
--        end if;
--      end if;
--      --
--      if obj.exist('MEDICATION_CURRENT_FLAG') then
--        tempdata := obj.get('MEDICATION_CURRENT_FLAG');
--        if tempdata is not null then
--          l_row.MEDICATION_CURRENT_FLAG := tempdata.get_string;
--        end if;
--      end if;
--      PIPE ROW (l_row);
--    end loop;
--  end patient_medication;
  --
  procedure patient_response_parsing (p_json in varchar2,p_question_response_code_tbl out global_type_pkg.t_question_response_code_tbl)
  as
    l_obj json_list;
  begin
    v_proc_name := upper('patient_response_parsing');
    v_err_msg := null;
    v_input_str := 'p_json: '||p_json;
    --
    --Insert as part of testing. Should be commented in prod env
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    l_obj := json_list(p_json);
    --
    for i in 1..json_ac.array_count(l_obj) loop
      p_question_response_code_tbl(i) := json_ac.array_get(l_obj,i).get_string;
    end loop;
  end patient_response_parsing;
  --
  PROCEDURE mbr_parsing(p_mbr_json IN varchar2,p_mbr_rec   OUT "AspNetUsers"%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_mbr_json);
    --
    if obj.exist('EMAIL') then
      tempdata := obj.get('EMAIL');
      if tempdata is not null then
        p_mbr_rec."Email" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('EMAILCONFIRMED') then
      tempdata := obj.get('EMAILCONFIRMED');
      if tempdata is not null then
        p_mbr_rec."EmailConfirmed" := nvl(tempdata.get_number,0);
      end if;        
    end if;
    --
    if obj.exist('PASSWORDHASH') then
      tempdata := obj.get('PASSWORDHASH');
      if tempdata is not null then
        p_mbr_rec."PasswordHash" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('SECURITYSTAMP') then
      tempdata := obj.get('SECURITYSTAMP');
      if tempdata is not null then
        p_mbr_rec."SecurityStamp" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PHONENUMBER') then
      tempdata := obj.get('PHONENUMBER');
      if tempdata is not null then
        p_mbr_rec."PhoneNumber" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PHONENUMBERCONFIRMED') then
      tempdata := obj.get('PHONENUMBERCONFIRMED');
      if tempdata is not null then
        p_mbr_rec."PhoneNumberConfirmed" := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('TWOFACTORENABLED') then
      tempdata := obj.get('TWOFACTORENABLED');
      if tempdata is not null then
        p_mbr_rec."TwoFactorEnabled" := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('LOCKOUTENDDATEUTC') then
      tempdata := obj.get('LOCKOUTENDDATEUTC');
      if tempdata is not null then
        p_mbr_rec."LockoutEndDateUtc" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('LOCKOUTENABLED') then
      tempdata := obj.get('LOCKOUTENABLED');
      if tempdata is not null then
        p_mbr_rec."LockoutEnabled" := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('ACCESSFAILEDCOUNT') then
      tempdata := obj.get('ACCESSFAILEDCOUNT');
      if tempdata is not null then
        p_mbr_rec."AccessFailedCount" := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('USERNAME') then
      tempdata := obj.get('USERNAME');
      if tempdata is not null then
        p_mbr_rec."UserName" := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('PARENT_ID') then
      tempdata := obj.get('PARENT_ID');
      if tempdata is not null then
        p_mbr_rec.PARENT_ID := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('HOME_PHONE_NUM') then
      tempdata := obj.get('HOME_PHONE_NUM');
      if tempdata is not null then
        p_mbr_rec.HOME_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('BUSINESS_PHONE_NUM') then
      tempdata := obj.get('BUSINESS_PHONE_NUM');
      if tempdata is not null then
        p_mbr_rec.BUSINESS_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_mbr_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_mbr_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('MIDDLE_NAME') then
      tempdata := obj.get('MIDDLE_NAME');
      if tempdata is not null then
        p_mbr_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('GENDER_CODE') then
      tempdata := obj.get('GENDER_CODE');
      if tempdata is not null then
        p_mbr_rec.GENDER_CODE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('ABOUT_PROV') then
      tempdata := obj.get('ABOUT_PROV');
      if tempdata is not null then
        p_mbr_rec.ABOUT_PROV := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('BIRTH_DATE') then
      tempdata := obj.get('BIRTH_DATE');
      if tempdata is not null then
        p_mbr_rec.BIRTH_DATE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('ADDR_SN') then
      tempdata := obj.get('ADDR_SN');
      if tempdata is not null then
        p_mbr_rec.ADDR_SN := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('RESPONSE_RATE') then
      tempdata := obj.get('RESPONSE_RATE');
      if tempdata is not null then
        p_mbr_rec.RESPONSE_RATE := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('RESPONSE_TIME') then
      tempdata := obj.get('RESPONSE_TIME');
      if tempdata is not null then
        p_mbr_rec.RESPONSE_TIME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('HOSTING_STORY') then
      tempdata := obj.get('HOSTING_STORY');
      if tempdata is not null then
        p_mbr_rec.HOSTING_STORY := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('TERMS_AND_COND_ACCEPTANCE') then
      tempdata := obj.get('TERMS_AND_COND_ACCEPTANCE');
      if tempdata is not null then    
        p_mbr_rec.TERMS_AND_COND_ACCEPTANCE := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('RECEIVE_NEWS_LETTER') then
      tempdata := obj.get('RECEIVE_NEWS_LETTER');
      if tempdata is not null then
        p_mbr_rec.RECEIVE_NEWS_LETTER := nvl(tempdata.get_number,0);
      end if;
    end if;
    --
    if obj.exist('ALT_EMAIL') then
      tempdata := obj.get('ALT_EMAIL');
      if tempdata is not null then
        p_mbr_rec.ALT_EMAIL := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('USER_CREATED_REC') then
      tempdata := obj.get('USER_CREATED_REC');
      if tempdata is not null then
        p_mbr_rec.USER_CREATED_REC_FLAG := tempdata.get_string;
      end if;
    else
      p_mbr_rec.USER_CREATED_REC_FLAG := 'Y';
    end if;
  end mbr_parsing;
  --
  PROCEDURE patient_prev_svc_parsing(p_json IN varchar2,p_patient_prev_svc_rec OUT patient_prev_svc%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_patient_prev_svc_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('PATIENT_SN') then
      tempdata := obj.get('PATIENT_SN');
      if tempdata is not null then
        p_patient_prev_svc_rec.PATIENT_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('PREV_SVC_BILLING_CODE') then
      tempdata := obj.get('PREV_SVC_BILLING_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.PREV_SVC_BILLING_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_DATE') then
      tempdata := obj.get('SVC_DATE');
      if tempdata is not null then
        p_patient_prev_svc_rec.SVC_DATE := to_date(substr(tempdata.get_string,1,10),'YYYY-MM-DD');
      end if;
    end if;
    if obj.exist('PROVIDER_PHYSICIAN_SN') then
      tempdata := obj.get('PROVIDER_PHYSICIAN_SN');
      if tempdata is not null then
        p_patient_prev_svc_rec.PROVIDER_PHYSICIAN_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('PHYSICIAN_SVC_LOCATION_SN') then
      tempdata := obj.get('PHYSICIAN_SVC_LOCATION_SN');
      if tempdata is not null then
        p_patient_prev_svc_rec.PHYSICIAN_SVC_LOCATION_SN := tempdata.get_number;
      end if;
    end if;    
    if obj.exist('G0438_COMP_ON_DIFF_SYS_FLAG') then
      tempdata := obj.get('G0438_COMP_ON_DIFF_SYS_FLAG');
      if tempdata is not null then
        p_patient_prev_svc_rec.G0438_COMP_ON_DIFF_SYS_FLAG := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_HR_CODE') then
      tempdata := obj.get('SVC_HR_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.SVC_HR_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_MIN_CODE') then
      tempdata := obj.get('SVC_MIN_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.SVC_MIN_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_AM_PM_CODE') then
      tempdata := obj.get('SVC_AM_PM_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.SVC_AM_PM_CODE := tempdata.get_string;
      end if;
    end if;
    if obj.exist('INSURANCE_COMPANY_CODE') then
      tempdata := obj.get('INSURANCE_COMPANY_CODE');
      if tempdata is not null then
        p_patient_prev_svc_rec.INSURANCE_COMPANY_CODE := tempdata.get_string;
      end if;
    end if;
  end patient_prev_svc_parsing;
  --
  PROCEDURE physician_svc_location_parsing(p_json IN varchar2,p_physician_svc_location_rec OUT physician_svc_location%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_physician_svc_location_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('PHYSICIAN_SN') then
      tempdata := obj.get('PHYSICIAN_SN');
      if tempdata is not null then
        p_physician_svc_location_rec.PHYSICIAN_SN := tempdata.get_number;
      end if;
    end if;
    if obj.exist('SVC_LOCATION_SN') then
      tempdata := obj.get('SVC_LOCATION_SN');
      if tempdata is not null then
        p_physician_svc_location_rec.SVC_LOCATION_SN := tempdata.get_number;
      end if;
    end if;
  end physician_svc_location_parsing;  
  --
  PROCEDURE user_svc_location_parsing(p_json IN varchar2,p_user_svc_location_rec OUT user_svc_location%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_user_svc_location_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('USER_ROLE_ID') then
      tempdata := obj.get('USER_ROLE_ID');
      if tempdata is not null then
        p_user_svc_location_rec.user_role_id := tempdata.get_string;
      end if;
    end if;
    if obj.exist('SVC_LOCATION_SN') then
      tempdata := obj.get('SVC_LOCATION_SN');
      if tempdata is not null then
        p_user_svc_location_rec.SVC_LOCATION_SN := tempdata.get_number;
      end if;
    end if;
  end user_svc_location_parsing;
  --
  PROCEDURE user_company_parsing(p_json IN varchar2,p_user_company_rec OUT user_company%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_user_company_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('USER_ROLE_ID') then
      tempdata := obj.get('USER_ROLE_ID');
      if tempdata is not null then
        p_user_company_rec.user_role_id := tempdata.get_string;
      end if;
    end if;
    if obj.exist('COMPANY_SN') then
      tempdata := obj.get('COMPANY_SN');
      if tempdata is not null then
        p_user_company_rec.COMPANY_SN := tempdata.get_number;
      end if;
    end if;
  end user_company_parsing;
  --
  PROCEDURE user_physician_parsing(p_json IN varchar2,p_user_physician_rec OUT user_physician%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    if obj.exist('CREATED_BY_USERNAME') then
      tempdata := obj.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        p_user_physician_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj.exist('USER_ROLE_ID') then
      tempdata := obj.get('USER_ROLE_ID');
      if tempdata is not null then
        p_user_physician_rec.user_role_id := tempdata.get_string;
      end if;
    end if;
    if obj.exist('PHYSICIAN_SN') then
      tempdata := obj.get('PHYSICIAN_SN');
      if tempdata is not null then
        p_user_physician_rec.PHYSICIAN_SN := tempdata.get_number;
      end if;
    end if;
  end user_physician_parsing;
  --
  PROCEDURE contact_us_parsing(p_json IN varchar2,p_contact_us_rec OUT contact_us%rowtype)
  as
    obj           json;
    tempdata      json_value;
  begin
    obj    := json(p_json);
    --
    if obj.exist('FIRST_NAME') then
      tempdata := obj.get('FIRST_NAME');
      if tempdata is not null then
        p_contact_us_rec.FIRST_NAME := substr(tempdata.get_string,1,50);
      end if;
    end if;
    if obj.exist('LAST_NAME') then
      tempdata := obj.get('LAST_NAME');
      if tempdata is not null then
        p_contact_us_rec.LAST_NAME := substr(tempdata.get_string,1,50);
      end if;
    end if;
    if obj.exist('EMAIL') then
      tempdata := obj.get('EMAIL');
      if tempdata is not null then
        p_contact_us_rec.EMAIL := substr(tempdata.get_string,1,100);
      end if;
    end if;
    if obj.exist('PHONE_NUMBER') then
      tempdata := obj.get('PHONE_NUMBER');
      if tempdata is not null then
        p_contact_us_rec.PHONE_NUMBER := substr(tempdata.get_string,1,20);
      end if;
    end if;
    if obj.exist('SUBJECT') then
      tempdata := obj.get('SUBJECT');
      if tempdata is not null then
        p_contact_us_rec.SUBJECT := substr(tempdata.get_string,1,100);
      end if;
    end if;
    if obj.exist('MESSAGE') then
      tempdata := obj.get('MESSAGE');
      if tempdata is not null then
        p_contact_us_rec.MESSAGE := substr(tempdata.get_string,1,2000);
      end if;
    end if;
  end contact_us_parsing;
END parse_json_pkg;
/
show errors