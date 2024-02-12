set define off
CREATE OR REPLACE PACKAGE list_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('list_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  --
  PROCEDURE load_categ_condition;
  PROCEDURE load_prev_svc_type;
  PROCEDURE load_prev_svc_type_lang;
  PROCEDURE load_billing_type;
  PROCEDURE load_billing_type_lang;
  PROCEDURE load_prev_svc_billing;
  PROCEDURE load_prev_svc_billing_lang;
  PROCEDURE load_question_score_type;
  PROCEDURE load_question_categ_grp;
  PROCEDURE load_question_categ_grp_lang;
  PROCEDURE load_question_categ;
  PROCEDURE load_question;
  PROCEDURE load_svc_bq_categ;
  PROCEDURE load_response;
  function qtn_sn (v_qcc in varchar2,v_qc in varchar2) return number;
  function get_categ_qrc (v_question_categ_code in list_question_categ.question_categ_code%type) return question_response.question_response_code%type;
  PROCEDURE load_question_response;
  PROCEDURE load_question_sub_categ;
  PROCEDURE load_ethnicity;
  PROCEDURE load_income;
  PROCEDURE load_race;
  PROCEDURE load_working_status;
  PROCEDURE load_gender;
  PROCEDURE load_education_level;
  PROCEDURE load_marital_status;
  PROCEDURE load_financial_status;
  PROCEDURE load_living_status;
  PROCEDURE load_physician_type;
  PROCEDURE load_svc_location_type;
  PROCEDURE load_frequency_unit;
  PROCEDURE load_categ_score_eval;
  --
  PROCEDURE load_height;
  PROCEDURE load_weight;
  PROCEDURE load_systolic_bp;
  PROCEDURE load_diastolic_bp;
  PROCEDURE load_blood_sugar_level;
  PROCEDURE load_cholesterol;
  --
  PROCEDURE load_priviledge_type;
  PROCEDURE load_priviledge;
  PROCEDURE load_ui;
  PROCEDURE load_roles_priviledge;
  PROCEDURE load_priviledge_ui;
END list_trans_pkg;
/
SHOW ERRORS
CREATE OR REPLACE PACKAGE BODY list_trans_pkg IS
  PROCEDURE load_priviledge_type
  is 
  BEGIN
    v_proc_name := upper('load_priviledge_type');
    for i in (select 'USI' priviledge_type_code,1 order_num,'en' lang_code,'Transactional' short_descr,null long_descr from dual union
              select 'RPT' priviledge_type_code,2 order_num,'en' lang_code,'Report' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.priviledge_type_code;
      begin
        INSERT INTO list_priviledge_type (priviledge_type_code
                                        )
        VALUES (i.priviledge_type_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.priviledge_type_code||'-'||i.lang_code;
      begin
        INSERT INTO priviledge_type_lang (priviledge_type_lang_sn
                                        ,priviledge_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (priviledge_type_lang_sng.nextval
                ,i.priviledge_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update priviledge_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where priviledge_type_code = i.priviledge_type_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_priviledge_type;
  --
  PROCEDURE load_priviledge
  is 
  BEGIN
    v_proc_name := upper('load_priviledge');
    for i in (select 'PUSR' priviledge_code,1 order_num,'USI' priviledge_type_code,'en' lang_code,'Prospective User' short_descr,'prospective-user' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'PSVC' priviledge_code,2 order_num,'USI' priviledge_type_code,'en' lang_code,'Preventive Service' short_descr,'preventive-service' href,'Y' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'REMK' priviledge_code,3 order_num,'USI' priviledge_type_code,'en' lang_code,'Remarks' short_descr,'remarks' href,'Y' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'DENT' priviledge_code,4 order_num,'USI' priviledge_type_code,'en' lang_code,'Physician Data Entry' short_descr,'physician-data-entry' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'DENB' priviledge_code,5 order_num,'USI' priviledge_type_code,'en' lang_code,'Beneficiary Data Entry' short_descr,'beneficiary-data-entry' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'SCHE' priviledge_code,6 order_num,'USI' priviledge_type_code,'en' lang_code,'Scheduling' short_descr,'scheduling' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'RBEN' priviledge_code,7 order_num,'RPT' priviledge_type_code,'en' lang_code,'Beneficiary Report' short_descr,'beneficiary-report' href,'N' client_only_priviledge_flag,'Y' common_priviledge_flag,null long_descr from dual union
              select 'RMGM' priviledge_code,8 order_num,'RPT' priviledge_type_code,'en' lang_code,'Management Report' short_descr,'management-report' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'UMGM' priviledge_code,9 order_num,'USI' priviledge_type_code,'en' lang_code,'User Management' short_descr,'user-management' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual
              )
    loop
      v_error_rec := i.priviledge_code;
      begin
        INSERT INTO list_priviledge (priviledge_code
                                    ,priviledge_type_code
                                    ,client_only_priviledge_flag
                                    ,common_priviledge_flag
                                    ,href
                                    )
        VALUES (i.priviledge_code
               ,i.priviledge_type_code
               ,i.client_only_priviledge_flag
               ,i.common_priviledge_flag
               ,i.href
               );
      exception 
        when dup_val_on_index then
          update list_priviledge
          set priviledge_type_code = i.priviledge_type_code
              ,client_only_priviledge_flag = i.client_only_priviledge_flag
              ,common_priviledge_flag = i.common_priviledge_flag
              ,href = i.href
          where priviledge_code = i.priviledge_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.priviledge_code||'-'||i.lang_code;
      begin
        INSERT INTO priviledge_lang (priviledge_lang_sn
                                        ,priviledge_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (priviledge_lang_SNG.nextval
                ,i.priviledge_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update priviledge_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where priviledge_code = i.priviledge_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_priviledge;
  --
  PROCEDURE load_roles_priviledge
  is 
  BEGIN
    v_proc_name := upper('load_roles_priviledge');
    for i in (select 'PUSR' priviledge_code,'a74f52c5-4d3a-46d9-bc22-a5eafa982849' role_id,'Prospective User' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'79F450777D2E4B6AB98FECB17974FDEB' role_id,'Service Provider/Preventive Service' short_descr,null long_descr from dual union
              select 'REMK' priviledge_code,'79F450777D2E4B6AB98FECB17974FDEB' role_id,'Service Provider/Remark' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Preventive Service' short_descr,null long_descr from dual union
              select 'REMK' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Remark' short_descr,null long_descr from dual union
              select 'SCHE' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Scheduling' short_descr,null long_descr from dual union
              --
              select 'RBEN' priviledge_code,'DF56C6ED00FF47AC84754BDF1517FB83' role_id,'Primary Provider/Beneficiary Report' short_descr,null long_descr from dual union
              --
              select 'DENT' priviledge_code,'22F1493D8E914982A6C5532EDBD516FE' role_id,'Data Entry/Physician' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'22F1493D8E914982A6C5532EDBD516FE' role_id,'Data Entry/Beneficiary' short_descr,null long_descr from dual union
              --
              select 'SCHE' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Scheduling' short_descr,null long_descr from dual union
              select 'DENT' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Data Entry Physician' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Data Entry Beneficiary' short_descr,null long_descr from dual union
              select 'RPTN' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Beneficiary Report' short_descr,null long_descr from dual union
              select 'RMGM' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Management Report' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Preventive Service' short_descr,null long_descr from dual union
              select 'REMK' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Preventive Service' short_descr,null long_descr from dual union
              select 'UMGM' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Preventive Service' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Preventive Service' short_descr,null long_descr from dual union
              select 'RMGM' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Preventive Service' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Preventive Service' short_descr,null long_descr from dual union
              select 'REMK' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Remark' short_descr,null long_descr from dual union
              select 'UMGM' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/User Management' short_descr,null long_descr from dual union
              select 'SCHE' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Scheduling' short_descr,null long_descr from dual union
              select 'DENT' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Data Entry Physician' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Data Entry Beneficiary' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Beneficiary Report' short_descr,null long_descr from dual union
              select 'RMGM' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Management Report' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.priviledge_code||'-'||i.role_id;
      begin
        INSERT INTO roles_priviledge (roles_priviledge_sn
                                              ,priviledge_code
                                              ,role_id
                                              )
        VALUES (roles_priviledge_sng.nextval
               ,i.priviledge_code
               ,i.role_id
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_roles_priviledge;
  --
  PROCEDURE load_ui
  is 
  BEGIN
    v_proc_name := upper('load_ui');
    for i in (select 'PSVC' ui_code,1 order_num,'en' lang_code,'Service Questionnaire' short_descr,'service-questionnaire' href,null long_descr from dual union
              --
              select 'REMK' ui_code,1 order_num,'en' lang_code,'Service Remarks' short_descr,'service-remarks' href,null long_descr from dual union
              --
              select 'PHYC' ui_code,6 order_num,'en' lang_code,'Physician Company' short_descr,'physician-company' href,null long_descr from dual union
              select 'PPHY' ui_code,7 order_num,'en' lang_code,'Primary Physician' short_descr,'primary-physician' href,null long_descr from dual union
              select 'SPHY' ui_code,8 order_num,'en' lang_code,'Service Provider' short_descr,'service-provider' href,null long_descr from dual union
              select 'SVCL' ui_code,9 order_num,'en' lang_code,'Service Location' short_descr,'service-location' href,null long_descr from dual union
              select 'PSVL' ui_code,10 order_num,'en' lang_code,'Physician Service Location' short_descr,'physician-service-location' href,null long_descr from dual union
              select 'BENE' ui_code,11 order_num,'en' lang_code,'Beneficiary Demographics' short_descr,'beneficiary-demographics' href,null long_descr from dual union
              select 'BMED' ui_code,4 order_num,'en' lang_code,'Beneficiary Medication' short_descr,'beneficiary-medication' href,null long_descr from dual union
              select 'BMHX' ui_code,4 order_num,'en' lang_code,'Beneficiary Medical History' short_descr,'beneficiary-med-history' href,null long_descr from dual union
              select 'BPHX' ui_code,4 order_num,'en' lang_code,'Beneficiary Past Medical History' short_descr,'beneficiary-past-med-history' href,null long_descr from dual union
              select 'BFHX' ui_code,4 order_num,'en' lang_code,'Beneficiary Family Medical History' short_descr,'beneficiary-family-med-history' href,null long_descr from dual union
              --
              select 'SCHE' ui_code,12 order_num,'en' lang_code,'Service Scheduling' short_descr,'service-scheduling' href,null long_descr from dual union
              --
              select 'RAMT' ui_code,1 order_num,'en' lang_code,'New User Role Assignment' short_descr,'new-user-role-assignment' href,null long_descr from dual union
              select 'UMGM' ui_code,2 order_num,'en' lang_code,'Existing User Management' short_descr,'existing-user-management' href,null long_descr from dual union
              select 'PMGM' ui_code,3 order_num,'en' lang_code,'Roles Priviledge Management' short_descr,'roles-priviledge-management' href,null long_descr from dual union
              --
              select 'RBEN' ui_code,1 order_num,'en' lang_code,'Beneficiary Report' short_descr,'beneficiary-report' href,null long_descr from dual union
              select 'RMGM' ui_code,2 order_num,'en' lang_code,'Management Report' short_descr,'management-report' href,null long_descr from dual
              )
    loop
      v_error_rec := i.ui_code;
      begin
        INSERT INTO list_ui (ui_code
                            ,href
                                        )
        VALUES (i.ui_code
              ,i.href
               );
      exception 
        when dup_val_on_index then
          update list_ui
          set href = i.href
          where ui_code = i.ui_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.ui_code||'-'||i.lang_code;
      begin
        INSERT INTO ui_lang (ui_lang_sn
                                        ,ui_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (ui_lang_SNG.nextval
                ,i.ui_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update ui_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where ui_code = i.ui_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_ui;  
  --
  PROCEDURE load_priviledge_ui
  is 
  BEGIN
    v_proc_name := upper('load_priviledge_ui');
    for i in (select 'PSVC' ui_code,'PSVC' priviledge_code,1 order_num,'Beneficiary Preventive Service (Questionnaire)' ui_descr,'Provide Service for assigned Patients' privledge_descr from dual union
              --
              select 'REMK' ui_code,'REMK' priviledge_code,1 order_num,'Service Provider Remarks' ui_descr,'Add any needed remarks to assigned Patient record' privledge_descr from dual union
              --
              select 'PHYC' ui_code,'DENT' priviledge_code,1 order_num,'Physician Company' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'PPHY' ui_code,'DENT' priviledge_code,2 order_num,'Primary Physician Record' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'SPHY' ui_code,'DENT' priviledge_code,3 order_num,'Service Provider Physician Record' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'SVCL' ui_code,'DENT' priviledge_code,4 order_num,'Service Location Record' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'PSVL' ui_code,'DENT' priviledge_code,5 order_num,'Physician Service Location Record' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              --
              select 'BENE' ui_code,'DENB' priviledge_code,1 order_num,'Beneficiary Record' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'BMED' ui_code,'DENB' priviledge_code,2 order_num,'Beneficiary Medication' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'BMHX' ui_code,'DENB' priviledge_code,3 order_num,'Beneficiary Medical History' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'BPHX' ui_code,'DENB' priviledge_code,4 order_num,'Beneficiary Past Medical History' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              select 'BFHX' ui_code,'DENB' priviledge_code,5 order_num,'Beneficiary Family Medical History' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              --
              select 'SCHE' ui_code,'SCHE' priviledge_code,8 order_num,'Beneficiary Preventive Service Scheduling' ui_descr,'Enter Patient, Primary Provider and Service Location information' privledge_descr from dual union
              --
              select 'RAMT' ui_code,'UMGM' priviledge_code,1 order_num,'New User Role Assignment' ui_descr,'Approve/Inactive an User' privledge_descr from dual union
              select 'UMGM' ui_code,'UMGM' priviledge_code,2 order_num,'Existing User Management' ui_descr,'Approve/Inactive an User' privledge_descr from dual union
              select 'PMGM' ui_code,'UMGM' priviledge_code,3 order_num,'Roles Priviledge Management' ui_descr,'Approve/Inactive an User' privledge_descr from dual union
              --
              select 'RBEN' ui_code,'RBEN' priviledge_code,1 order_num,'Beneficiary Report' ui_descr,'Beneficiary Report' privledge_descr from dual union
              select 'RMGM' ui_code,'RMGM' priviledge_code,2 order_num,'Management Report' ui_descr,'Management Report' privledge_descr from dual
              )
    loop
      v_error_rec := i.ui_code||'-'||i.priviledge_code;
      begin
        INSERT INTO priviledge_ui (priviledge_ui_sn
                                              ,ui_code
                                              ,priviledge_code
                                              ,order_num
                                              )
        VALUES (priviledge_ui_sng.nextval
               ,i.ui_code
               ,i.priviledge_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update priviledge_ui
          set order_num = i.order_num
          where ui_code = i.ui_code
          and priviledge_code = i.priviledge_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_priviledge_ui;
  --
  PROCEDURE load_cholesterol
  is 
  BEGIN
    v_proc_name := upper('load_cholesterol');
    for i in (select '100' cholesterol_code,1 order_num,'en' lang_code,'Less than 100 (2.60)' short_descr,null long_descr from dual union
              select '130' cholesterol_code,2 order_num,'en' lang_code,'101-130 (2.61-3.38)' short_descr,null long_descr from dual union
              select '160' cholesterol_code,3 order_num,'en' lang_code,'131-160 (3.39-4.15)' short_descr,null long_descr from dual union
              select '180' cholesterol_code,4 order_num,'en' lang_code,'161-180 (4.16-4.65)' short_descr,null long_descr from dual union
              select '200' cholesterol_code,5 order_num,'en' lang_code,'181-200 (4.66-5.19)' short_descr,null long_descr from dual union
              select '220' cholesterol_code,6 order_num,'en' lang_code,'201-220 (5.20-5.70)' short_descr,null long_descr from dual union
              select '240' cholesterol_code,7 order_num,'en' lang_code,'221-240 (5.71-6.20)' short_descr,null long_descr from dual union
              select '241' cholesterol_code,8 order_num,'en' lang_code,'Over 240 (6.20)' short_descr,null long_descr from dual union
              select '111' cholesterol_code,9 order_num,'en' lang_code,'I don''t know' short_descr,null long_descr from dual union
              select '222' cholesterol_code,10 order_num,'en' lang_code,'It was normal, but I do not remember the exact number' short_descr,null long_descr from dual union
              select '333' cholesterol_code,11 order_num,'en' lang_code,'It was high (abnormal), but I do not remember the exact number' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.cholesterol_code;
      begin
        INSERT INTO list_cholesterol (cholesterol_code
                              ,order_num
                                        )
        VALUES (i.cholesterol_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_cholesterol
          set order_num = i.order_num
          where cholesterol_code = i.cholesterol_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.cholesterol_code||'-'||i.lang_code;
      begin
        INSERT INTO cholesterol_lang (cholesterol_lang_sn
                                        ,cholesterol_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (cholesterol_lang_SNG.nextval
                ,i.cholesterol_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update cholesterol_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where cholesterol_code = i.cholesterol_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_cholesterol;
  --
  PROCEDURE load_blood_sugar_level
  is 
  BEGIN
    v_proc_name := upper('load_blood_sugar_level');
    for i in (select '100' blood_sugar_level_code,1 order_num,'en' lang_code,'Less than 100 (5.60)' short_descr,null long_descr from dual union
              select '120' blood_sugar_level_code,2 order_num,'en' lang_code,'101-120 (5.61-6.70)' short_descr,null long_descr from dual union
              select '140' blood_sugar_level_code,3 order_num,'en' lang_code,'121-140 (6.71-7.80)' short_descr,null long_descr from dual union
              select '160' blood_sugar_level_code,4 order_num,'en' lang_code,'141-160 (7.81-8.90)' short_descr,null long_descr from dual union
              select '180' blood_sugar_level_code,5 order_num,'en' lang_code,'161-180 (8.91-10.00)' short_descr,null long_descr from dual union
              select '200' blood_sugar_level_code,6 order_num,'en' lang_code,'181-200 (10.01-11.10)' short_descr,null long_descr from dual union
              select '250' blood_sugar_level_code,7 order_num,'en' lang_code,'201-250 (11.11-13.90)' short_descr,null long_descr from dual union
              select '251' blood_sugar_level_code,8 order_num,'en' lang_code,'Over 250 (13.90)' short_descr,null long_descr from dual union
              select '111' blood_sugar_level_code,9 order_num,'en' lang_code,'I don''t know' short_descr,null long_descr from dual union
              select '222' blood_sugar_level_code,10 order_num,'en' lang_code,'It was normal, but I do not remember the exact number' short_descr,null long_descr from dual union
              select '333' blood_sugar_level_code,11 order_num,'en' lang_code,'It was high (abnormal), but I do not remember the exact number' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.blood_sugar_level_code;
      begin
        INSERT INTO list_blood_sugar_level (blood_sugar_level_code
                              ,order_num
                                        )
        VALUES (i.blood_sugar_level_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_blood_sugar_level
          set order_num = i.order_num
          where blood_sugar_level_code = i.blood_sugar_level_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.blood_sugar_level_code||'-'||i.lang_code;
      begin
        INSERT INTO blood_sugar_level_lang (blood_sugar_level_lang_sn
                                        ,blood_sugar_level_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (blood_sugar_level_lang_SNG.nextval
                ,i.blood_sugar_level_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update blood_sugar_level_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where blood_sugar_level_code = i.blood_sugar_level_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_blood_sugar_level;
  --
  PROCEDURE load_diastolic_bp
  is 
  BEGIN
    v_proc_name := upper('load_diastolic_bp');
    for i in (select '060' diastolic_bp_code,1 order_num,'en' lang_code,'Less than 60' short_descr,null long_descr from dual union
              select '070' diastolic_bp_code,2 order_num,'en' lang_code,'60-70' short_descr,null long_descr from dual union
              select '080' diastolic_bp_code,3 order_num,'en' lang_code,'71-80' short_descr,null long_descr from dual union
              select '090' diastolic_bp_code,4 order_num,'en' lang_code,'81-90' short_descr,null long_descr from dual union
              select '100' diastolic_bp_code,5 order_num,'en' lang_code,'91-100' short_descr,null long_descr from dual union
              select '110' diastolic_bp_code,6 order_num,'en' lang_code,'101-110' short_descr,null long_descr from dual union
              select '111' diastolic_bp_code,7 order_num,'en' lang_code,'Over 110' short_descr,null long_descr from dual union
              select '222' diastolic_bp_code,8 order_num,'en' lang_code,'I don''t know' short_descr,null long_descr from dual union
              select '333' diastolic_bp_code,9 order_num,'en' lang_code,'It was normal, but I do not remember the exact number' short_descr,null long_descr from dual union
              select '444' diastolic_bp_code,10 order_num,'en' lang_code,'It was high (abnormal), but I do not remember the exact number' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.diastolic_bp_code;
      begin
        INSERT INTO list_diastolic_bp (diastolic_bp_code
                              ,order_num
                                        )
        VALUES (i.diastolic_bp_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_diastolic_bp
          set order_num = i.order_num
          where diastolic_bp_code = i.diastolic_bp_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.diastolic_bp_code||'-'||i.lang_code;
      begin
        INSERT INTO diastolic_bp_lang (diastolic_bp_lang_sn
                                        ,diastolic_bp_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (diastolic_bp_lang_SNG.nextval
                ,i.diastolic_bp_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update diastolic_bp_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where diastolic_bp_code = i.diastolic_bp_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_diastolic_bp;
  --
  PROCEDURE load_systolic_bp
  is 
  BEGIN
    v_proc_name := upper('load_systolic_bp');
    for i in (select '100' systolic_bp_code,1 order_num,'en' lang_code,'Under 100' short_descr,null long_descr from dual union
              select '120' systolic_bp_code,2 order_num,'en' lang_code,'100-120' short_descr,null long_descr from dual union
              select '130' systolic_bp_code,3 order_num,'en' lang_code,'121-130' short_descr,null long_descr from dual union
              select '140' systolic_bp_code,4 order_num,'en' lang_code,'131-140' short_descr,null long_descr from dual union
              select '150' systolic_bp_code,5 order_num,'en' lang_code,'141-150' short_descr,null long_descr from dual union
              select '160' systolic_bp_code,6 order_num,'en' lang_code,'151-160' short_descr,null long_descr from dual union
              select '170' systolic_bp_code,7 order_num,'en' lang_code,'161-170' short_descr,null long_descr from dual union
              select '171' systolic_bp_code,8 order_num,'en' lang_code,'Over 170' short_descr,null long_descr from dual union
              select '111' systolic_bp_code,9 order_num,'en' lang_code,'I don''t know' short_descr,null long_descr from dual union
              select '222' systolic_bp_code,10 order_num,'en' lang_code,'It was normal, but I do not remember the exact number' short_descr,null long_descr from dual union
              select '333' systolic_bp_code,11 order_num,'en' lang_code,'It was high (abnormal), but I do not remember the exact number' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.systolic_bp_code;
      begin
        INSERT INTO list_systolic_bp (systolic_bp_code
                              ,order_num
                                        )
        VALUES (i.systolic_bp_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_systolic_bp
          set order_num = i.order_num
          where systolic_bp_code = i.systolic_bp_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.systolic_bp_code||'-'||i.lang_code;
      begin
        INSERT INTO systolic_bp_lang (systolic_bp_lang_sn
                                        ,systolic_bp_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (systolic_bp_lang_SNG.nextval
                ,i.systolic_bp_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update systolic_bp_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where systolic_bp_code = i.systolic_bp_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_systolic_bp;
  --
  PROCEDURE load_weight
  is 
  BEGIN
    v_proc_name := upper('load_weight');
    for i in (select '100' weight_code,1 order_num,'en' lang_code,'less than 100 (45)' short_descr,null long_descr from dual union
              select '120' weight_code,2 order_num,'en' lang_code,'100-120 (45-55)' short_descr,null long_descr from dual union
              select '140' weight_code,3 order_num,'en' lang_code,'121-140 (56-64)' short_descr,null long_descr from dual union
              select '160' weight_code,4 order_num,'en' lang_code,'141-160 (65-73)' short_descr,null long_descr from dual union
              select '180' weight_code,5 order_num,'en' lang_code,'161-180 (74-82)' short_descr,null long_descr from dual union
              select '200' weight_code,6 order_num,'en' lang_code,'181-200 (83-91)' short_descr,null long_descr from dual union
              select '220' weight_code,7 order_num,'en' lang_code,'201-220 (92-100)' short_descr,null long_descr from dual union
              select '240' weight_code,8 order_num,'en' lang_code,'221-240 (101-109)' short_descr,null long_descr from dual union
              select '260' weight_code,9 order_num,'en' lang_code,'241-260 (110-118)' short_descr,null long_descr from dual union
              select '280' weight_code,10 order_num,'en' lang_code,'261-280 (119-127)' short_descr,null long_descr from dual union
              select '300' weight_code,11 order_num,'en' lang_code,'281-300 (128-136)' short_descr,null long_descr from dual union
              select '301' weight_code,12 order_num,'en' lang_code,'301 or more (136)' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.weight_code;
      begin
        INSERT INTO list_weight (weight_code
                              ,order_num
                                        )
        VALUES (i.weight_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_weight
          set order_num = i.order_num
          where weight_code = i.weight_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.weight_code||'-'||i.lang_code;
      begin
        INSERT INTO weight_lang (weight_lang_sn
                                        ,weight_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (weight_lang_SNG.nextval
                ,i.weight_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update weight_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where weight_code = i.weight_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_weight;
  --
  PROCEDURE load_height
  is 
  BEGIN
    v_proc_name := upper('load_height');
    for i in (select '57' height_code,1 order_num,'en' lang_code,'57 inches (145 cm, 4''9'''')' short_descr,null long_descr from dual union
              select '59' height_code,2 order_num,'en' lang_code,'59 inches (150 cm, 4''11'''')' short_descr,null long_descr from dual union
              select '61' height_code,3 order_num,'en' lang_code,'61 inches (155 cm, 5''1'''')' short_descr,null long_descr from dual union
              select '63' height_code,4 order_num,'en' lang_code,'63 inches (160 cm, 5''3'''')' short_descr,null long_descr from dual union
              select '65' height_code,5 order_num,'en' lang_code,'65 inches (165 cm, 5''5'''')' short_descr,null long_descr from dual union
              select '67' height_code,6 order_num,'en' lang_code,'67 inches (170 cm, 5''7'''')' short_descr,null long_descr from dual union
              select '69' height_code,7 order_num,'en' lang_code,'69 inches (175 cm, 5''9'''')' short_descr,null long_descr from dual union
              select '71' height_code,8 order_num,'en' lang_code,'71 inches (180 cm, 5''11'''')' short_descr,null long_descr from dual union
              select '73' height_code,9 order_num,'en' lang_code,'73 inches (185 cm, 6''1'''')' short_descr,null long_descr from dual union
              select '75' height_code,10 order_num,'en' lang_code,'75 inches (191 cm, 6''3'''')' short_descr,null long_descr from dual union
              select '77' height_code,11 order_num,'en' lang_code,'77 inches (196 cm, 6''5'''')' short_descr,null long_descr from dual union
              select '79' height_code,12 order_num,'en' lang_code,'79 inches (201 cm, 6''7'''')' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.height_code;
      begin
        INSERT INTO list_height (height_code
                              ,order_num
                                        )
        VALUES (i.height_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_height
          set order_num = i.order_num
          where height_code = i.height_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.height_code||'-'||i.lang_code;
      begin
        INSERT INTO height_lang (height_lang_sn
                                        ,height_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (height_lang_SNG.nextval
                ,i.height_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update height_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where height_code = i.height_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_height;
  --
  PROCEDURE load_categ_score_eval
  is 
  BEGIN
    v_proc_name := upper('load_categ_score_eval');
    for i in (select '1001' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1002' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,6 SCORE_RANGE_END,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1003' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,7 SCORE_RANGE_BEGIN,10 SCORE_RANGE_END,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1004' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,11 SCORE_RANGE_BEGIN,13 SCORE_RANGE_END,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1005' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,14 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1006' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1007' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,4 SCORE_RANGE_BEGIN,5 SCORE_RANGE_END,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1008' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,6 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1009' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,8 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1010' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1011' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1012' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,8 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1013' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,12 SCORE_RANGE_END,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1014' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,13 SCORE_RANGE_BEGIN,16 SCORE_RANGE_END,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1015' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,17 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1016' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'EML' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1017' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'EML' QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,1 SCORE_RANGE_END,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1018' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'EML' QUESTION_SUB_CATEG_CODE,2 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1019' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'EML' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1020' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'SCL' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1021' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'SCL' QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,1 SCORE_RANGE_END,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1022' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'SCL' QUESTION_SUB_CATEG_CODE,2 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1023' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,'SCL' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1024' categ_score_eval_code,'en' lang_code,'FRLTY' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1025' categ_score_eval_code,'en' lang_code,'FRLTY' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,4 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Vulnerable' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1026' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,1 SCORE_RANGE_END,'Patient is very dependent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1027' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,2 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'Patient need Moderate Assistance for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1028' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,4 SCORE_RANGE_BEGIN,5 SCORE_RANGE_END,'Patient need Minimum Assistance for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1029' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,6 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Patient is Independent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1030' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'Patient is very dependent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1031' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,5 SCORE_RANGE_END,'Patient need Moderate Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1032' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,6 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'Patient need Minimum Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1033' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,8 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Patient is Independent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1030' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MLE' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'Patient is very dependent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1031' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MLE' QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'Patient need Moderate Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1032' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MLE' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'Patient need Minimum Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1033' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MLE' QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'Patient is Independent' short_descr,'N' trigger_further_categ_flag,null long_descr from dual
              )
    loop
      v_error_rec := i.categ_score_eval_code;
      begin
        INSERT INTO categ_score_eval (categ_score_eval_code
                                      ,QUESTION_CATEG_CODE
                                      ,QUESTION_SUB_CATEG_CODE
                                      ,SCORE_RANGE_BEGIN
                                      ,SCORE_RANGE_END
                                      ,trigger_further_categ_flag
                                        )
        VALUES (i.categ_score_eval_code
                ,i.QUESTION_CATEG_CODE
                ,i.QUESTION_SUB_CATEG_CODE
                ,i.SCORE_RANGE_BEGIN
                ,i.SCORE_RANGE_END
                ,i.trigger_further_categ_flag
               );
      exception 
        when dup_val_on_index then
          update categ_score_eval
          set SCORE_RANGE_END = i.SCORE_RANGE_END
             ,trigger_further_categ_flag = i.trigger_further_categ_flag
          where QUESTION_CATEG_CODE = i.QUESTION_CATEG_CODE
          and QUESTION_SUB_CATEG_CODE = i.QUESTION_SUB_CATEG_CODE
          and SCORE_RANGE_BEGIN = i.SCORE_RANGE_BEGIN
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.categ_score_eval_code||'-'||i.lang_code;
      begin
        INSERT INTO categ_score_eval_lang (categ_score_eval_lang_sn
                                        ,categ_score_eval_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (categ_score_eval_lang_SNG.nextval
                ,i.categ_score_eval_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update categ_score_eval_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where categ_score_eval_code = i.categ_score_eval_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_categ_score_eval;
  --
  PROCEDURE load_frequency_unit
  is 
  BEGIN
    v_proc_name := upper('load_frequency_unit');
    for i in (select '1D' frequency_unit_code,'en' lang_code,'1/day' short_descr,null long_descr from dual union
              select '2D' frequency_unit_code,'en' lang_code,'2/day' short_descr,null long_descr from dual union
              select '3D' frequency_unit_code,'en' lang_code,'3/day' short_descr,null long_descr from dual union
              select '4D' frequency_unit_code,'en' lang_code,'4/day' short_descr,null long_descr from dual union
              select '5D' frequency_unit_code,'en' lang_code,'5/day' short_descr,null long_descr from dual union
              select '6D' frequency_unit_code,'en' lang_code,'6/day' short_descr,null long_descr from dual union
              select '7D' frequency_unit_code,'en' lang_code,'7/day' short_descr,null long_descr from dual union
              select '8D' frequency_unit_code,'en' lang_code,'8/day' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.frequency_unit_code;
      begin
        INSERT INTO list_frequency_unit (frequency_unit_code
                                        )
        VALUES (i.frequency_unit_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.frequency_unit_code||'-'||i.lang_code;
      begin
        INSERT INTO frequency_unit_lang (frequency_unit_lang_sn
                                        ,frequency_unit_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (frequency_unit_lang_SNG.nextval
                ,i.frequency_unit_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update frequency_unit_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where frequency_unit_code = i.frequency_unit_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_frequency_unit;
  --
  PROCEDURE load_svc_location_type
  is 
  BEGIN
    v_proc_name := upper('load_svc_location_type');
    for i in (select 'INLC' svc_location_type_code,1 order_num,'en' lang_code,'Independent Living Communities (Retirement Communities)' short_descr,null long_descr from dual union
              select 'ASLF' svc_location_type_code,2 order_num,'en' lang_code,'Assisted Living Facilities (Personal Care Home)' short_descr,null long_descr from dual union
              select 'NUHM' svc_location_type_code,3 order_num,'en' lang_code,'Nursing Homes (Long Term Care Facility)' short_descr,null long_descr from dual union
              select 'RCHM' svc_location_type_code,4 order_num,'en' lang_code,'Residential Care Homes' short_descr,null long_descr from dual union
              select 'MECR' svc_location_type_code,5 order_num,'en' lang_code,'Memory Care (Alzheimer''s Care)' short_descr,null long_descr from dual union
              select 'RSCR' svc_location_type_code,6 order_num,'en' lang_code,'Respite Care (Adult Day Care)' short_descr,null long_descr from dual union
              select 'HMCR' svc_location_type_code,7 order_num,'en' lang_code,'Home Care (Home Health Care)' short_descr,null long_descr from dual union
              select 'DROF' svc_location_type_code,8 order_num,'en' lang_code,'Doctors Office' short_descr,null long_descr from dual union
              select 'URCR' svc_location_type_code,9 order_num,'en' lang_code,'Urgent Care' short_descr,null long_descr from dual union
              select 'HOSP' svc_location_type_code,10 order_num,'en' lang_code,'Hospital' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.svc_location_type_code;
      begin
        INSERT INTO list_svc_location_type (svc_location_type_code
                                        ,order_num
                                        )
        VALUES (i.svc_location_type_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_svc_location_type
          set order_num = i.order_num
          where svc_location_type_code = i.svc_location_type_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.svc_location_type_code||'-'||i.lang_code;
      begin
        INSERT INTO svc_location_type_lang (svc_location_type_lang_sn
                                        ,svc_location_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (svc_location_type_lang_SNG.nextval
                ,i.svc_location_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update svc_location_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where svc_location_type_code = i.svc_location_type_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_svc_location_type;
  --
  PROCEDURE load_physician_type
  is 
  BEGIN
    v_proc_name := upper('load_physician_type');
    for i in (select 'PHY' physician_type_code,1 order_num,'en' lang_code,'Physician (a doctor of medicine or osteopathy)' short_descr,null long_descr from dual union
              select 'PHA' physician_type_code,2 order_num,'en' lang_code,'Physician Assistant' short_descr,null long_descr from dual union
              select 'NUP' physician_type_code,3 order_num,'en' lang_code,'Nurse Practitioner' short_descr,null long_descr from dual union
              select 'NUM' physician_type_code,4 order_num,'en' lang_code,'Certified Nurse Midwives' short_descr,null long_descr from dual union
              select 'NUS' physician_type_code,5 order_num,'en' lang_code,'Certified Clinical Nurse Specialist' short_descr,null long_descr from dual union
              select 'IMP' physician_type_code,6 order_num,'en' lang_code,'Independent Medical Professional (a health educator, registered dietitian, nutrition professional, or other licensed practitioner)' short_descr,null long_descr from dual union
              select 'SMP' physician_type_code,7 order_num,'en' lang_code,'Supervised Medical Professional (a health educator, registered dietitian, nutrition professional, or other licensed practitioner who are working under the direct supervision of a physician)' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.physician_type_code;
      begin
        INSERT INTO list_physician_type (physician_type_code
                                        ,order_num
                                        )
        VALUES (i.physician_type_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_physician_type
          set order_num = i.order_num
          where physician_type_code = i.physician_type_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.physician_type_code||'-'||i.lang_code;
      begin
        INSERT INTO physician_type_lang (physician_type_lang_sn
                                        ,physician_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (physician_type_lang_SNG.nextval
                ,i.physician_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update physician_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where physician_type_code = i.physician_type_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_physician_type;
  --
  PROCEDURE load_living_status
  is 
  BEGIN
    v_proc_name := upper('load_living_status');
    for i in (select 'WTSP' living_status_code,1 order_num,'en' lang_code,'With Spouse' short_descr,null long_descr from dual union
              select 'WTRL' living_status_code,2 order_num,'en' lang_code,'With Relatives' short_descr,null long_descr from dual union
              select 'ALON' living_status_code,3 order_num,'en' lang_code,'Alone' short_descr,null long_descr from dual union
              select 'ILHF' living_status_code,4 order_num,'en' lang_code,'In Independent Living Housing Facility' short_descr,null long_descr from dual union
              select 'ADLT' living_status_code,5 order_num,'en' lang_code,'In Adult Living' short_descr,null long_descr from dual union
              select 'EXCF' living_status_code,6 order_num,'en' lang_code,'In an Extended Care Facility' short_descr,null long_descr from dual union
              select 'NURH' living_status_code,7 order_num,'en' lang_code,'in a Nursing Home' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.living_status_code;
      begin
        INSERT INTO list_living_status (living_status_code
                                        ,order_num
                                        )
        VALUES (i.living_status_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_living_status
          set order_num = i.order_num
          where living_status_code = i.living_status_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.living_status_code||'-'||i.lang_code;
      begin
        INSERT INTO living_status_lang (living_status_lang_sn
                                        ,living_status_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (living_status_lang_SNG.nextval
                ,i.living_status_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update living_status_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where living_status_code = i.living_status_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_living_status;
  --
  PROCEDURE load_financial_status
  is 
  BEGIN
    v_proc_name := upper('load_financial_status');
    for i in (select 'ONSS' financial_status_code,1 order_num,'en' lang_code,'On Social Security' short_descr,null long_descr from dual union
              select 'ONFA' financial_status_code,2 order_num,'en' lang_code,'On Family Assistance' short_descr,null long_descr from dual union
              select 'ONWI' financial_status_code,3 order_num,'en' lang_code,'On Working Income' short_descr,null long_descr from dual union
              select 'ONRF' financial_status_code,4 order_num,'en' lang_code,'On Retirement Funds' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.financial_status_code;
      begin
        INSERT INTO list_financial_status (financial_status_code
                                          ,order_num
                                        )
        VALUES (i.financial_status_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_financial_status
          set order_num = i.order_num
          where financial_status_code = i.financial_status_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.financial_status_code||'-'||i.lang_code;
      begin
        INSERT INTO financial_status_lang (financial_status_lang_sn
                                        ,financial_status_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (financial_status_lang_SNG.nextval
                ,i.financial_status_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update financial_status_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where financial_status_code = i.financial_status_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_financial_status;
  --
  PROCEDURE load_marital_status
  is 
  BEGIN
    v_proc_name := upper('load_marital_status');
    for i in (select 'MRD' marital_status_code,1 order_num,'en' lang_code,'Married' short_descr,null long_descr from dual union
              select 'WTD' marital_status_code,2 order_num,'en' lang_code,'Widowed' short_descr,null long_descr from dual union
              select 'SEP' marital_status_code,4 order_num,'en' lang_code,'Separated' short_descr,null long_descr from dual union
              select 'DIV' marital_status_code,3 order_num,'en' lang_code,'Divorced' short_descr,null long_descr from dual union
              select 'LCL' marital_status_code,5 order_num,'en' lang_code,'Living common law' short_descr,null long_descr from dual union
              select 'SGL' marital_status_code,6 order_num,'en' lang_code,'Single' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.marital_status_code;
      begin
        INSERT INTO list_marital_status (marital_status_code
                                        ,order_num
                                        )
        VALUES (i.marital_status_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_marital_status
          set order_num = i.order_num
          where marital_status_code = i.marital_status_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.marital_status_code||'-'||i.lang_code;
      begin
        INSERT INTO marital_status_lang (marital_status_lang_sn
                                        ,marital_status_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (marital_status_lang_SNG.nextval
                ,i.marital_status_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update marital_status_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where marital_status_code = i.marital_status_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_marital_status;
  --
  PROCEDURE load_education_level
  is 
  BEGIN
    v_proc_name := upper('load_education_level');
    for i in (select 'NONE' education_level_code,5 order_num,'en' lang_code,'None' short_descr,null long_descr from dual union
              select 'PSCH' education_level_code,3 order_num,'en' lang_code,'Primary School' short_descr,null long_descr from dual union
              select 'HSCH' education_level_code,2 order_num,'en' lang_code,'High School' short_descr,null long_descr from dual union
              select 'CLGE' education_level_code,1 order_num,'en' lang_code,'College' short_descr,null long_descr from dual union
              select 'UNIV' education_level_code,4 order_num,'en' lang_code,'University' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.education_level_code;
      begin
        INSERT INTO list_education_level (education_level_code
                                        ,order_num
                                        )
        VALUES (i.education_level_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_education_level
          set order_num = i.order_num
          where education_level_code = i.education_level_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.education_level_code||'-'||i.lang_code;
      begin
        INSERT INTO education_level_lang (education_level_lang_sn
                                        ,education_level_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (education_level_lang_SNG.nextval
                ,i.education_level_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update education_level_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where education_level_code = i.education_level_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_education_level;
  --
  PROCEDURE load_working_status
  is 
  BEGIN
    v_proc_name := upper('load_working_status');
    for i in (select 'EMP' working_status_code,4 order_num,'en' lang_code,'Employed' short_descr,null long_descr from dual union
              select 'STD' working_status_code,3 order_num,'en' lang_code,'Student' short_descr,null long_descr from dual union
              select 'UEM' working_status_code,2 order_num,'en' lang_code,'Unemployed' short_descr,null long_descr from dual union
              select 'RET' working_status_code,1 order_num,'en' lang_code,'Retired' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.working_status_code;
      begin
        INSERT INTO list_working_status (working_status_code
                                        ,order_num
                                        )
        VALUES (i.working_status_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_working_status
          set order_num = i.order_num
          where working_status_code = i.working_status_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.working_status_code||'-'||i.lang_code;
      begin
        INSERT INTO working_status_lang (working_status_lang_sn
                                        ,working_status_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (working_status_lang_SNG.nextval
                ,i.working_status_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update working_status_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where working_status_code = i.working_status_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_working_status;
  --
  PROCEDURE load_gender
  is 
  BEGIN
    v_proc_name := upper('load_gender');
    for i in (select 'MAL' gender_code,1 order_num,'en' lang_code,'Male' short_descr,null long_descr from dual union
              select 'FEM' gender_code,2 order_num,'en' lang_code,'Female' short_descr,null long_descr from dual union
              select 'OTR' gender_code,3 order_num,'en' lang_code,'Other' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.gender_code;
      begin
        INSERT INTO list_gender (gender_code
                                ,order_num
                                        )
        VALUES (i.gender_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_gender
          set order_num = i.order_num
          where gender_code = i.gender_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.gender_code||'-'||i.lang_code;
      begin
        INSERT INTO gender_lang (gender_lang_sn
                                        ,gender_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (gender_lang_SNG.nextval
                ,i.gender_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update gender_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where gender_code = i.gender_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_gender;
  --
  PROCEDURE load_race
  is 
  BEGIN
    v_proc_name := upper('load_race');
    for i in (select 'AIAN' race_code,4 order_num,'en' lang_code,'American Indian or Alaska Native' short_descr,null long_descr from dual union
              select 'ASIN' race_code,3 order_num,'en' lang_code,'Asian' short_descr,null long_descr from dual union
              select 'BLAK' race_code,2 order_num,'en' lang_code,'Black or African American' short_descr,null long_descr from dual union
              select 'NHPI' race_code,5 order_num,'en' lang_code,'Native Hawaiian or Other Pacific Islander' short_descr,null long_descr from dual union
              select 'WHTE' race_code,1 order_num,'en' lang_code,'White' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.race_code;
      begin
        INSERT INTO list_race (race_code
                              ,order_num
                                        )
        VALUES (i.race_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_race
          set order_num = i.order_num
          where race_code = i.race_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.race_code||'-'||i.lang_code;
      begin
        INSERT INTO race_lang (race_lang_sn
                                        ,race_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (race_lang_SNG.nextval
                ,i.race_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update race_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where race_code = i.race_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_race;
  --
  PROCEDURE load_income
  is 
  BEGIN
    v_proc_name := upper('load_income');
    for i in (select '0020' income_code,1 order_num,'en' lang_code,'Between 0 and 20K' short_descr,null long_descr from dual union
              select '2040' income_code,2 order_num,'en' lang_code,'Between 20 and 40K' short_descr,null long_descr from dual union
              select '4060' income_code,3 order_num,'en' lang_code,'Between 40 and 60K' short_descr,null long_descr from dual union
              select '6080' income_code,4 order_num,'en' lang_code,'Between 60 and 80K' short_descr,null long_descr from dual union
              select '8000' income_code,5 order_num,'en' lang_code,'Above 80K' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.income_code;
      begin
        INSERT INTO list_income (income_code
                                ,order_num
                                        )
        VALUES (i.income_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_income
          set order_num = i.order_num
          where income_code = i.income_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.income_code||'-'||i.lang_code;
      begin
        INSERT INTO income_lang (income_lang_sn
                                        ,income_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (income_lang_SNG.nextval
                ,i.income_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update income_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where income_code = i.income_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_income;
  --
  PROCEDURE load_ethnicity
  is 
  BEGIN
    v_proc_name := upper('load_ethnicity');
    for i in (select 'HISP' ethnicity_code,2 order_num,'en' lang_code,'Hispanic or Latino' short_descr,null long_descr from dual union
              select 'NHIS' ethnicity_code,1 order_num,'en' lang_code,'Not Hispanic or Latino' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.ethnicity_code;
      begin
        INSERT INTO list_ethnicity (ethnicity_code
                                   ,order_num
                                        )
        VALUES (i.ethnicity_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_ethnicity
          set order_num = i.order_num
          where ethnicity_code = i.ethnicity_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.ethnicity_code||'-'||i.lang_code;
      begin
        INSERT INTO ethnicity_lang (ethnicity_lang_sn
                                        ,ethnicity_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (ethnicity_lang_SNG.nextval
                ,i.ethnicity_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update ethnicity_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where ethnicity_code = i.ethnicity_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_ethnicity;
  --
  PROCEDURE load_question_sub_categ
  is 
  BEGIN
    v_proc_name := upper('load_question_sub_categ');
    for i in (select 'DEP' question_sub_categ_code,'PSYSD' question_categ_code,'en' lang_code,'Depression' short_descr,null long_descr from dual union
              select 'ANX' question_sub_categ_code,'PSYSD' question_categ_code,'en' lang_code,'Anxiety' short_descr,null long_descr from dual union
              select 'STR' question_sub_categ_code,'PSYSD' question_categ_code,'en' lang_code,'Stress' short_descr,null long_descr from dual union
              select 'SCL' question_sub_categ_code,'LONLS' question_categ_code,'en' lang_code,'Social Loneliness' short_descr,null long_descr from dual union
              select 'EML' question_sub_categ_code,'LONLS' question_categ_code,'en' lang_code,'Emotional Loneliness' short_descr,null long_descr from dual union
              select 'MLE' question_sub_categ_code,'IADLB' question_categ_code,'en' lang_code,'Emotional Loneliness' short_descr,null long_descr from dual union
              select 'FEM' question_sub_categ_code,'IADLB' question_categ_code,'en' lang_code,'Emotional Loneliness' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.question_sub_categ_code;
      begin
        INSERT INTO list_question_sub_categ (question_sub_categ_code
                                        ,question_categ_code
                                        )
        VALUES (i.question_sub_categ_code
                ,i.question_categ_code
               );
      exception 
        when dup_val_on_index then
          update list_question_sub_categ
          set question_categ_code = i.question_categ_code
          where question_sub_categ_code = i.question_sub_categ_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.question_sub_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO question_sub_categ_lang (question_sub_categ_lang_sn
                                        ,question_sub_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (question_sub_categ_lang_SNG.nextval
                ,i.question_sub_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update question_sub_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where question_sub_categ_code = i.question_sub_categ_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_sub_categ;
  --
  PROCEDURE load_prev_svc_type 
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_type');
    for i in (select 'AWV' prev_svc_type_code from dual union
              select 'CCM' prev_svc_type_code from dual
              )
    loop
      v_error_rec := i.prev_svc_type_code;
      begin
        INSERT INTO list_prev_svc_type(prev_svc_type_code
                                      )
        VALUES (i.prev_svc_type_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_prev_svc_type;
  --
  PROCEDURE load_categ_condition
  is 
  BEGIN
    v_proc_name := upper('load_categ_condition');
    for i in (select 'CR' categ_condition_code,'Category Response' descr from dual union
              select 'QR' categ_condition_code,'Question Response' descr from dual
              )
    loop
      v_error_rec := i.categ_condition_code;
      begin
        INSERT INTO list_categ_condition (categ_condition_code
                                        ,descr
                                        )
        VALUES (i.categ_condition_code
                ,i.descr
               );
      exception 
        when dup_val_on_index then
          update list_categ_condition
          set DESCR = i.DESCR
          where categ_condition_code = i.categ_condition_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_categ_condition;
  --
  PROCEDURE load_prev_svc_type_lang
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_type_lang');
    for i in (select 'AWV' prev_svc_type_code,'en' lang_code,'Annual Wellness Visit' short_descr,null long_descr from dual union
              select 'CCM' prev_svc_type_code,'en' lang_code,'Chronic Care Management' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.PREV_SVC_TYPE_CODE||'-'||i.lang_code;
      begin
        INSERT INTO prev_svc_type_lang (prev_svc_type_lang_SN
                                        ,PREV_SVC_TYPE_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (prev_svc_type_lang_SNG.nextval
                ,i.PREV_SVC_TYPE_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update prev_svc_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where PREV_SVC_TYPE_CODE = i.PREV_SVC_TYPE_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_prev_svc_type_lang;
  --
  PROCEDURE load_billing_type
  is 
  BEGIN
    v_proc_name := upper('load_billing_type');
    for i in (select 'HCPCS' billing_type_code from dual union
              select 'CPT' billing_type_code from dual
              )
    loop
      v_error_rec := i.billing_type_code;
      begin
        INSERT INTO list_billing_type(billing_type_code
                                      )
        VALUES (i.billing_type_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_billing_type;
  --
  PROCEDURE load_billing_type_lang
  is 
  BEGIN
    v_proc_name := upper('load_billing_type_lang');
    for i in (select 'HCPCS' billing_type_code,'en' lang_code,'Healthcare Common Procedure Coding System' short_descr,null long_descr from dual union
                select 'CPT' billing_type_code,'en' lang_code,'Current Procedural Terminology' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.billing_type_CODE||'-'||i.lang_code;
      begin
        INSERT INTO billing_type_lang (billing_type_lang_SN
                                        ,billing_type_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (billing_type_lang_SNG.nextval
                ,i.billing_type_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update billing_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where billing_type_CODE = i.billing_type_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_billing_type_lang;
  --
  PROCEDURE load_prev_svc_billing 
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_billing');
    for i in (select 'G0438' prev_svc_billing_code,'AWV' prev_svc_type_code,'HCPCS' billing_type_code from dual union
              select 'G0439' prev_svc_billing_code,'AWV' prev_svc_type_code,'HCPCS' billing_type_code from dual union
              select '99490' prev_svc_billing_code,'CCM' prev_svc_type_code,'CPT' billing_type_code from dual
              )
    loop
      v_error_rec := i.prev_svc_billing_code;
      begin
        INSERT INTO list_prev_svc_billing (prev_svc_billing_code
                                          ,prev_svc_type_code
                                          ,billing_type_code
                                          )
                                  VALUES  (i.prev_svc_billing_code
                                          ,i.prev_svc_type_code
                                          ,i.billing_type_code
                                          );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_prev_svc_billing;
  --
  PROCEDURE load_prev_svc_billing_lang
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_billing_lang');
    for i in (select 'G0438' prev_svc_billing_code,'en' lang_code,'Annual Wellness Visit, Initial' short_descr,'Annual wellness visit; includes a personalized prevention plan of service (PPPS), initial visit' long_descr from dual union
              select 'G0439' prev_svc_billing_code,'en' lang_code,'Annual Wellness Visit, Subsequent' short_descr,'Annual wellness visit, includes a personalized prevention plan of service (PPPS), subsequent visit' long_descr from dual
              )
    loop
      v_error_rec := i.PREV_svc_billing_CODE||'-'||i.lang_code;
      begin
        INSERT INTO prev_svc_billing_lang (prev_svc_billing_lang_SN
                                        ,PREV_svc_billing_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (prev_svc_billing_lang_SNG.nextval
                ,i.PREV_svc_billing_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update prev_svc_billing_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where PREV_svc_billing_CODE = i.PREV_svc_billing_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_prev_svc_billing_lang;
  --
  PROCEDURE load_question_score_type
  is 
  BEGIN
    v_proc_name := upper('load_question_score_type');
      for i in (select 'SC' question_score_type_code,'Score' descr from dual union
                select 'NS' question_score_type_code,'No Score' descr from dual union
                select 'RF' question_score_type_code,'Risk Factor' descr from dual
                )
    loop
      v_error_rec := i.question_score_type_code;
      begin
        INSERT INTO list_question_score_type(question_score_type_code
                                            ,descr
                                      )
        VALUES (i.question_score_type_code
                ,i.descr
               );
      exception 
        when dup_val_on_index then
          update list_question_score_type
          set descr = i.descr
          where question_score_type_code = i.question_score_type_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_score_type;
  --
  PROCEDURE load_response
  is
  BEGIN
    v_proc_name := upper('load_response');
    for i in (select 'YES' response_code,'en' lang_code,'Yes' short_descr,null long_descr from dual union
              select 'NOO' response_code,'en' lang_code,'No' short_descr,null long_descr from dual union
              select 'IDK' response_code,'en' lang_code,'Don''t Know' short_descr,null long_descr from dual union
              select 'NVR' response_code,'en' lang_code,'Never' short_descr,null long_descr from dual union
              select 'SMT' response_code,'en' lang_code,'Sometimes' short_descr,null long_descr from dual union
              select 'OFT' response_code,'en' lang_code,'Often' short_descr,null long_descr from dual union
              select 'AAL' response_code,'en' lang_code,'Almost Always' short_descr,null long_descr from dual union
              select 'NDI' response_code,'en' lang_code,'No Difficulty' short_descr,null long_descr from dual union
              select 'ALD' response_code,'en' lang_code,'A little Difficulty' short_descr,null long_descr from dual union
              select 'SMD' response_code,'en' lang_code,'Some Difficulty' short_descr,null long_descr from dual union
              select 'ATD' response_code,'en' lang_code,'A Lot of Difficulty' short_descr,null long_descr from dual union
              select 'UTD' response_code,'en' lang_code,'Unable to do' short_descr,null long_descr from dual union
              select 'POR' response_code,'en' lang_code,'Poor' short_descr,null long_descr from dual union
              select 'FIR' response_code,'en' lang_code,'Fair' short_descr,null long_descr from dual union
              select 'GOD' response_code,'en' lang_code,'Good' short_descr,null long_descr from dual union
              select 'VGD' response_code,'en' lang_code,'Very Good' short_descr,null long_descr from dual union
              select 'EXC' response_code,'en' lang_code,'Excellent' short_descr,null long_descr from dual union
              select 'LFM' response_code,'en' lang_code,'Last Few Months' short_descr,null long_descr from dual union
              select 'LFY' response_code,'en' lang_code,'Last Few Years' short_descr,null long_descr from dual union
              select 'ALW' response_code,'en' lang_code,'Always' short_descr,null long_descr from dual union
              select 'CBX' response_code,'en' lang_code,'Check Box' short_descr,null long_descr from dual union
              select 'RBT' response_code,'en' lang_code,'Radio Button' short_descr,null long_descr from dual union
              select 'RLY' response_code,'en' lang_code,'Rarely' short_descr,null long_descr from dual union
              select 'B78' response_code,'en' lang_code,'Between 75 and 84' short_descr,null long_descr from dual union
              select 'G85' response_code,'en' lang_code,'>= 85' short_descr,null long_descr from dual union
              select 'DET' response_code,'en' lang_code,'Data Entry' short_descr,null long_descr from dual union
              select 'NOP' response_code,'en' lang_code,'No Problem' short_descr,null long_descr from dual union
              select 'MIP' response_code,'en' lang_code,'Minor Problem' short_descr,null long_descr from dual union
              select 'MOP' response_code,'en' lang_code,'Moderate Problem' short_descr,null long_descr from dual union
              select 'SEP' response_code,'en' lang_code,'Serious Problem' short_descr,null long_descr from dual union
              select 'FNC' response_code,'en' lang_code,'Functional' short_descr,null long_descr from dual union
              select 'COG' response_code,'en' lang_code,'Cognitive' short_descr,null long_descr from dual union
              select 'MND' response_code,'en' lang_code,'Mental Disorder' short_descr,null long_descr from dual union
              select 'MOL' response_code,'en' lang_code,'More or Less' short_descr,null long_descr from dual union
              select 'DND' response_code,'en' lang_code,'Don''t Do' short_descr,null long_descr from dual union
              --ADL
              --Bathing
              select 'ABI' response_code,'en' lang_code,'Bathes self completely (with exception of needs help in bathing only a single part of the body such as the back, genital area or disabled extremity)' short_descr,null long_descr from dual union
              select 'ABD' response_code,'en' lang_code,'Need help with bathing (more than one part of the body, getting in or out of the tub or shower) or requires total bathing' short_descr,null long_descr from dual union
              --Dressing
              select 'ADI' response_code,'en' lang_code,'Get clothes from closets and drawers and puts on clothes and outer garments complete with fasteners (may have help tying shoes)' short_descr,null long_descr from dual union
              select 'ADD' response_code,'en' lang_code,'Needs help with dressing self or needs to be completely dressed.' short_descr,null long_descr from dual union
              --Toileting
              select 'ATI' response_code,'en' lang_code,'Goes to toilet, gets on and off, arranges clothes, cleans genital area without help.' short_descr,null long_descr from dual union
              select 'ATD' response_code,'en' lang_code,'Needs help transferring to the toilet, cleaning self or uses bedpan or commode.' short_descr,null long_descr from dual union
              --Transferring
              select 'ARI' response_code,'en' lang_code,'Moves in and out of bed or chair unassisted (mechanical transfer aids are acceptable)' short_descr,null long_descr from dual union
              select 'ARD' response_code,'en' lang_code,'Needs help in moving from bed to chair or requires a complete transfer.' short_descr,null long_descr from dual union
              --Continence
              select 'ACI' response_code,'en' lang_code,'Exercises complete self-control over urination and defecation.' short_descr,null long_descr from dual union
              select 'ACD' response_code,'en' lang_code,'Is partially or totally incontinent of bowel or bladder' short_descr,null long_descr from dual union
              --Feeding
              select 'AFI' response_code,'en' lang_code,'Gets food from plate into mouth without help (preparation of food may be done by another person)' short_descr,null long_descr from dual union
              select 'AFD' response_code,'en' lang_code,'Needs partial or total help with feeding or requires parenteral feeding.' short_descr,null long_descr from dual union
              --IADL
              --Ability to use telephone
              select 'IT1' response_code,'en' lang_code,'Operates telephone on own initiative-looks up and dials numbers, etc.' short_descr,null long_descr from dual union
              select 'IT2' response_code,'en' lang_code,'Dials a few well-known numbers' short_descr,null long_descr from dual union
              select 'IT3' response_code,'en' lang_code,'Answers telephone but does not dial' short_descr,null long_descr from dual union
              select 'IT4' response_code,'en' lang_code,'Does not use telephone at all' short_descr,null long_descr from dual union
              --Laundry
              select 'IL1' response_code,'en' lang_code,'Does personal laundry completely' short_descr,null long_descr from dual union
              select 'IL2' response_code,'en' lang_code,'Launders small items-rinses stockings, etc.' short_descr,null long_descr from dual union
              select 'IL3' response_code,'en' lang_code,'All laundry must be done by others' short_descr,null long_descr from dual union
              --shopping
              select 'IS1' response_code,'en' lang_code,'Takes care of all shopping needs independently' short_descr,null long_descr from dual union
              select 'IS2' response_code,'en' lang_code,'Shops independently for small purchases' short_descr,null long_descr from dual union
              select 'IS3' response_code,'en' lang_code,'Needs to be accompanied on any shopping trip' short_descr,null long_descr from dual union
              select 'IS4' response_code,'en' lang_code,'Completely unable to shop' short_descr,null long_descr from dual union
              --Travelling
              select 'IR1' response_code,'en' lang_code,'Travels independently on public transportation or drives own car' short_descr,null long_descr from dual union
              select 'IR2' response_code,'en' lang_code,'Arranges own travel via taxi, but does not otherwise use public transportation' short_descr,null long_descr from dual union
              select 'IR3' response_code,'en' lang_code,'Travels on public transportation when accompanied by another' short_descr,null long_descr from dual union
              select 'IR4' response_code,'en' lang_code,'Travel limited to taxi or automobile with assistance of another' short_descr,null long_descr from dual union
              select 'IR5' response_code,'en' lang_code,'Does not travel at all' short_descr,null long_descr from dual union
              --Food
              select 'IF1' response_code,'en' lang_code,'Plans, prepares and serves adequate meals independently' short_descr,null long_descr from dual union
              select 'IF2' response_code,'en' lang_code,'Prepares adequate meals if supplied with ingredients' short_descr,null long_descr from dual union
              select 'IF3' response_code,'en' lang_code,'Heats, serves and prepares meals, or prepares meals, or prepares meals but does not maintain adequate diet' short_descr,null long_descr from dual union
              select 'IF4' response_code,'en' lang_code,'Needs to have meals prepared and served' short_descr,null long_descr from dual union
              --Medication
              select 'IM1' response_code,'en' lang_code,'Is responsible for taking medication in correct dosages at correct time' short_descr,null long_descr from dual union
              select 'IM2' response_code,'en' lang_code,'Takes responsibility if medication is prepared in advance in separate dosage' short_descr,null long_descr from dual union
              select 'IM3' response_code,'en' lang_code,'Is not capable of dispensing own medication' short_descr,null long_descr from dual union
              --Housekeeping
              select 'IH1' response_code,'en' lang_code,'Maintains house alone or with occasional assistance (e.g. "heavy work domestic help")' short_descr,null long_descr from dual union
              select 'IH2' response_code,'en' lang_code,'Performs light daily tasks such as dish washing, bed making' short_descr,null long_descr from dual union
              select 'IH3' response_code,'en' lang_code,'Performs light daily tasks but cannot maintain acceptable level of cleanliness' short_descr,null long_descr from dual union
              select 'IH4' response_code,'en' lang_code,'Needs help with all home maintenance tasks' short_descr,null long_descr from dual union
              select 'IH5' response_code,'en' lang_code,'Does not participate in any housekeeping tasks' short_descr,null long_descr from dual union
              --Financial
              select 'II1' response_code,'en' lang_code,'Manages financial matters independently (budgets, writes checks, pays rent, bills, goes to bank), collects and keeps track of income' short_descr,null long_descr from dual union
              select 'II2' response_code,'en' lang_code,'Manages day-to-day purchases, but needs help with banking, major purchases, etc.' short_descr,null long_descr from dual union
              select 'II3' response_code,'en' lang_code,'Incapable of handling money' short_descr,null long_descr from dual union
              --
              select 'MHE' response_code,'en' lang_code,'Major Health Event' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.response_code;
      begin
        INSERT INTO list_response (response_code                                        
                                        )
                                VALUES (i.response_code
                                        );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.response_CODE||'-'||i.lang_code;
      begin
        INSERT INTO response_lang (response_lang_SN
                                        ,response_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (response_lang_SNG.nextval
                ,i.response_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update response_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where response_CODE = i.response_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_response;
  --
  PROCEDURE load_question_categ_grp 
  is 
  BEGIN
    v_proc_name := upper('load_question_categ_grp');
    for i in (select '101' question_categ_grp_code,2 order_num from dual union
              select '102' question_categ_grp_code,3 order_num from dual union
              select '103' question_categ_grp_code,4 order_num from dual union
              select '104' question_categ_grp_code,5 order_num from dual union
              select '105' question_categ_grp_code,6 order_num from dual
              )
    loop
      v_error_rec := i.question_categ_grp_code;
      begin
        INSERT INTO list_question_categ_grp(question_categ_grp_code
                                      ,order_num
                                      )
        VALUES (i.question_categ_grp_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_question_categ_grp
          set order_num = i.order_num
          where question_categ_grp_code = i.question_categ_grp_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_categ_grp;
  --
  PROCEDURE load_question_categ_grp_lang
  is 
  BEGIN
    v_proc_name := upper('load_question_categ_grp_lang');
    for i in (select '101' question_categ_grp_code,'en' lang_code,'Section I(HRA-P)' short_descr,'HEALTH RISK ASSESSMENT PLUS' long_descr from dual union
              select '102' question_categ_grp_code,'en' lang_code,'Section II(AWV)' short_descr,'ANNUAL WELLNESS VISIT - HISTORY' long_descr from dual union
              select '103' question_categ_grp_code,'en' lang_code,'Section III(AWV)' short_descr,'ANNUAL WELLNESS VISIT - MOOD DISORDERS TEST' long_descr from dual union
              select '104' question_categ_grp_code,'en' lang_code,'Section IV(AWV)' short_descr,'ANNUAL WELLNESS VISIT - FALL RISK FACTORS & HOME SAFETY TEST' long_descr from dual union
              select '105' question_categ_grp_code,'en' lang_code,'Section V(AWV)' short_descr,'ANNUAL WELLNESS VISIT - ADDITIONAL RISK FACTORS TEST' long_descr from dual
              )
    loop
      v_error_rec := i.question_categ_grp_CODE||'-'||i.lang_code;
      begin
        INSERT INTO question_categ_grp_lang (question_categ_grp_lang_SN
                                        ,question_categ_grp_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (question_categ_grp_lang_SNG.nextval
                ,i.question_categ_grp_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update question_categ_grp_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where question_categ_grp_CODE = i.question_categ_grp_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_categ_grp_lang;
  --
  PROCEDURE load_question_categ
  is
    cursor c_Cur is
    select 'BMEDH' question_categ_code,1 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'BENEFICIARY MEDICAL HISTORY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HSLFA' question_categ_code,2 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEALTH SELF-ASSESSMENT' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HSLF2' question_categ_code,3 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Have you had any of the following limitations:' short_descr,null long_descr,'Y' conditional_categ_flag,'QR' categ_condition_code,'Yes response to the question- Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks? - in Health Self Assessment Category' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'HSLFA' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'PSYSD' question_categ_code,4 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PSYCHO SOCIAL DISORDER' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'Y' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'ANXIT' question_categ_code,5 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'ANXIETY TEST' short_descr,null long_descr,'Y' conditional_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Anxiety in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'GERDS' question_categ_code,6 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'GERIATRIC DEPRESSION SCALE' short_descr,null long_descr,'Y' conditional_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Depression in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HRSTS' question_categ_code,7 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HOLMES & RAHE STRESS SCALE' short_descr,null long_descr,'Y' conditional_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Stess in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'SLFHQ' question_categ_code,8 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'SELF-HARMLESS QUIZ' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'LONLS' question_categ_code,9 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'LONELINESS' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'Y' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'FRLTY' question_categ_code,10 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FRAILTY TEST' short_descr,null long_descr,'Y' conditional_categ_flag,'CR' categ_condition_code,'If the interviewee is >= 75 yrs old' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'LONLS' parent_question_categ_code,'Y' child_categ_avail_flag from dual union
    select 'FRLT1' question_categ_code,11 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'How much difficulty, on average, do you have with the following physical activities:' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'FRLTY' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'FRLT2' question_categ_code,12 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Because of your health or a physical condition, do you have any difficulty:' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'FRLTY' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'BEHVT' question_categ_code,13 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'BEHAVIORAL TEST' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'ADLBF' question_categ_code,14 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'ADL LEVEL OF BENEFICIARY FUNCTIONALITY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'BATIN' question_categ_code,15 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Bathing' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'DRSIN' question_categ_code,16 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Dressing' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'TOIIN' question_categ_code,17 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Toileting' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'TRNIN' question_categ_code,18 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Transferring' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'CONCE' question_categ_code,19 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Continence(holding back bodily functions)' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'FEDIN' question_categ_code,20 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Feeding' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'ADLBF' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'IADLB' question_categ_code,21 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'IADL LEVEL OF BENEFICIARY FUNCTIONALITY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'ABLUT' question_categ_code,22 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Ability to Use Telephone' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'LNDRY' question_categ_code,23 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Laundry' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'SHPIN' question_categ_code,24 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Shopping' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'TRVIN' question_categ_code,25 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Traveling' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'FDPRP' question_categ_code,26 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Food Preparation' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'MEDRS' question_categ_code,27 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Medication responsibilities' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'HKPIN' question_categ_code,28 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Housekeeping' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
--    select 'FINRS' question_categ_code,29 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Financial responsibilities' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'IADLB' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --------------------------------
    select 'BNPMH' question_categ_code,30 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'BENEFICIARY PAST MEDICAL HISTORY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag from dual union
    select 'HSURA' question_categ_code,31 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF SURGERY/ALLERGY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HVACN' question_categ_code,32 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF VACCINATION' short_descr,'Have you been vaccinated as per schedule for the prevention of:' long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HVART' question_categ_code,33 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF VARIOUS TEST' short_descr,'Have you undergone any of the following tests:' long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'FHNMR' question_categ_code,34 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FAMILY HX. OF GENETIC NON MODIFIABLE RISK FACTOR (FATHER, MOTHER & SIBLING)' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'P6MSC' question_categ_code,35 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PAST 6 MONTHS SYMPTOMS CHECK' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag from dual union
    select 'HENMT' question_categ_code,36 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEAD, EARS, NOSE MOUTH & THROAT SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'MUSCS' question_categ_code,37 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MUSCULOSKELETAL SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'CLHTS' question_categ_code,38 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'CHEST, LUNGS AND HEART SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'NEPYS' question_categ_code,39 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'NEUROLOGICAL & PSYCHOLOGIC SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'MOODD' question_categ_code,40 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MOOD DISORDER' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'103'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag from dual union
    select 'MOOD1' question_categ_code,41 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Has there ever been a period of time when you were not your usual self and...' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'103'  question_categ_grp_code,'MOODD' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'FALLR' question_categ_code,42 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FALL RISK TEST' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HOMES' question_categ_code,43 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HOME SAFETY' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'DIZZI' question_categ_code,44 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'DIZZINESS RISK FACTOR TEST' short_descr,null long_descr,'Y' conditional_categ_flag,'QR' categ_condition_code,'Yes response to the question- During morning or evening hours do you feel any dizziness? - in Fall Risk Factor and Safety Category' categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,'FALLR' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'HHISQ' question_categ_code,45 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEARING HANDICAP INVENTORY SCREENING QUESTIONNAIRE TEST' short_descr,null long_descr,'Y' conditional_categ_flag,'QR' categ_condition_code,'Yes response to the question- Do you suffer from hearing loss? - in Fall Risk Factor and Safety Category' categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,'FALLR' parent_question_categ_code,'N' child_categ_avail_flag from dual union
    --
    select 'COGND' question_categ_code,46 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'COGNITIVE DECLINING' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'105'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual union
    select 'MEDCP' question_categ_code,47 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MEDICATION COMPLIANCE' short_descr,null long_descr,'N' conditional_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'105'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag from dual
    order by order_num asc
    ;
  BEGIN
    v_proc_name := upper('load_question_categ');
    for i in c_Cur
    loop
      v_error_rec := i.question_categ_code;
      begin
        INSERT INTO list_question_categ (question_categ_code
                                        ,QUESTION_SCORE_TYPE_CODE
                                        ,QUESTION_CATEG_GRP_CODE
                                        ,conditional_categ_flag
                                        ,parent_question_categ_code
                                        ,child_categ_avail_flag
                                        ,trigger_further_categ_flag
                                        ,categ_condition_code
                                        ,categ_condition_descr
                                        )
                                VALUES (i.question_categ_code
                                        ,i.QUESTION_SCORE_TYPE_CODE
                                        ,i.QUESTION_CATEG_GRP_CODE
                                        ,i.conditional_categ_flag
                                        ,i.parent_question_categ_code
                                        ,i.child_categ_avail_flag
                                        ,i.trigger_further_categ_flag
                                        ,i.categ_condition_code
                                        ,i.categ_condition_descr
                                        );
      exception 
        when dup_val_on_index then
          update list_question_categ
          set QUESTION_SCORE_TYPE_CODE = i.QUESTION_SCORE_TYPE_CODE
              ,conditional_categ_flag = i.conditional_categ_flag
              ,parent_question_categ_code = i.parent_question_categ_code
              ,QUESTION_CATEG_GRP_CODE = i.QUESTION_CATEG_GRP_CODE
              ,child_categ_avail_flag = i.child_categ_avail_flag
              ,trigger_further_categ_flag = i.trigger_further_categ_flag
              ,categ_condition_code = i.categ_condition_code
              ,categ_condition_descr = i.categ_condition_descr
          where question_categ_code = i.question_categ_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    --
    for i in c_Cur loop
      v_error_rec := i.question_categ_CODE||'-'||i.lang_code;
      begin
        INSERT INTO question_categ_lang (question_categ_lang_SN
                                        ,question_categ_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (question_categ_lang_SNG.nextval
                ,i.question_categ_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update question_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where question_categ_CODE = i.question_categ_CODE
          and LANG_CODE = i.LANG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_categ;
  --
  PROCEDURE load_svc_bq_categ
  is 
  BEGIN
    v_proc_name := upper('load_svc_bq_categ');
    for i in (select 'G0438' PREV_SVC_BILLING_CODE, 'BMEDH' question_categ_code,1 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HSLFA' question_categ_code,2 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HSLF2' question_categ_code,3 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'PSYSD' question_categ_code,4 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'ANXIT' question_categ_code,5 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'GERDS' question_categ_code,6 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HRSTS' question_categ_code,7 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'SLFHQ' question_categ_code,8 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'LONLS' question_categ_code,9 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLTY' question_categ_code,10 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLT1' question_categ_code,11 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLT2' question_categ_code,12 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'BEHVT' question_categ_code,13 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'ADLBF' question_categ_code,14 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'BATIN' question_categ_code,15 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'DRSIN' question_categ_code,16 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'TOIIN' question_categ_code,17 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'TRNIN' question_categ_code,18 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'CONCE' question_categ_code,19 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'FEDIN' question_categ_code,20 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'IADLB' question_categ_code,21 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'ABLUT' question_categ_code,22 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'LNDRY' question_categ_code,23 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'SHPIN' question_categ_code,24 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'TRVIN' question_categ_code,25 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'FDPRP' question_categ_code,26 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'MEDRS' question_categ_code,27 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'HKPIN' question_categ_code,28 order_num from dual union
--              select 'G0438' PREV_SVC_BILLING_CODE, 'FINRS' question_categ_code,29 order_num from dual union
              --------------------------------
              select 'G0438' PREV_SVC_BILLING_CODE, 'BNPMH' question_categ_code,30 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HSURA' question_categ_code,31 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HVACN' question_categ_code,32 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HVART' question_categ_code,33 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'FHNMR' question_categ_code,34 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'P6MSC' question_categ_code,35 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HENMT' question_categ_code,36 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MUSCS' question_categ_code,37 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'CLHTS' question_categ_code,38 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'NEPYS' question_categ_code,39 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'MOODD' question_categ_code,40 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MOOD1' question_categ_code,41 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'FALLR' question_categ_code,42 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HOMES' question_categ_code,43 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'DIZZI' question_categ_code,44 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HHISQ' question_categ_code,45 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'COGND' question_categ_code,46 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MEDCP' question_categ_code,47 order_num from dual
              )
    loop
      v_error_rec := i.PREV_SVC_BILLING_CODE||'-'||i.question_categ_code;
      begin
        INSERT INTO svc_billing_question_categ  (SVC_BILLING_QUESTION_CATEG_SN
                                                ,PREV_SVC_BILLING_CODE
                                                ,QUESTION_CATEG_CODE
                                                ,ORDER_NUM
                                                )
        VALUES                                  (SVC_BILLING_QUESTION_CATEG_SNG.nextval
                                                ,i.PREV_SVC_BILLING_CODE
                                                ,i.QUESTION_CATEG_CODE
                                                ,i.ORDER_NUM
                                                );
      exception 
        when dup_val_on_index then
          update svc_billing_question_categ
          set order_num = i.order_num
          where PREV_SVC_BILLING_CODE = i.PREV_SVC_BILLING_CODE
          and QUESTION_CATEG_CODE = i.QUESTION_CATEG_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_svc_bq_categ;
  --
  function qtn_sn (v_qcc in varchar2
                  ,v_qc in varchar2) return number 
  is 
    v_return number; 
  begin 
    select question_sn 
    into v_return 
    from question 
    where question_categ_code = v_qcc 
    and question_code = v_qc
    ;
    return v_return;
  exception
    when others then
      return null;
  end qtn_sn;
  --
  function get_categ_qrc (v_question_categ_code in list_question_categ.question_categ_code%type) return question_response.question_response_code%type 
  is
    v_return question_response.question_response_code%type;
  begin
    if v_question_categ_code = 'BMEDH' then v_return := '100000';
    elsif v_question_categ_code = 'HSLFA' then v_return := '100200';
    elsif v_question_categ_code = 'PSYSD' then v_return := '100400';
    elsif v_question_categ_code = 'ANXIT' then v_return := '100600';
    elsif v_question_categ_code = 'SLFHQ' then v_return := '100800';
    elsif v_question_categ_code = 'GERDS' then v_return := '101000';
    elsif v_question_categ_code = 'HRSTS' then v_return := '101200';
    elsif v_question_categ_code = 'LONLS' then v_return := '101400';
    elsif v_question_categ_code = 'FRLTY' then v_return := '101600';
    elsif v_question_categ_code = 'BEHVT' then v_return := '101800';
    --
    elsif v_question_categ_code = 'ADLBF' then v_return := '102000';
--    elsif v_question_categ_code = 'BATIN' then v_return := '102200';
--    elsif v_question_categ_code = 'DRSIN' then v_return := '102400';
--    elsif v_question_categ_code = 'TOIIN' then v_return := '102600';
--    elsif v_question_categ_code = 'TRNIN' then v_return := '102800';
--    elsif v_question_categ_code = 'CONCE' then v_return := '103000';
--    elsif v_question_categ_code = 'FEDIN' then v_return := '103200';
    --
    elsif v_question_categ_code = 'IADLB' then v_return := '103400';
--    elsif v_question_categ_code = 'ABLUT' then v_return := '103600';
--    elsif v_question_categ_code = 'LNDRY' then v_return := '103800';
--    elsif v_question_categ_code = 'SHPIN' then v_return := '104000';
--    elsif v_question_categ_code = 'TRVIN' then v_return := '104200';
--    elsif v_question_categ_code = 'FDPRP' then v_return := '104400';
--    elsif v_question_categ_code = 'MEDRS' then v_return := '104600';
--    elsif v_question_categ_code = 'HKPIN' then v_return := '104800';
--    elsif v_question_categ_code = 'FINRS' then v_return := '105000';
    --------------------------------
    elsif v_question_categ_code = 'BNPMH' then v_return := '105200';
    elsif v_question_categ_code = 'HSURA' then v_return := '105400';
    elsif v_question_categ_code = 'HVACN' then v_return := '105600';
    elsif v_question_categ_code = 'HVART' then v_return := '105800';
    --
    elsif v_question_categ_code = 'FHNMR' then v_return := '106000';
    --
    elsif v_question_categ_code = 'P6MSC' then v_return := '106200';
    elsif v_question_categ_code = 'HENMT' then v_return := '106400';
    elsif v_question_categ_code = 'MUSCS' then v_return := '106600';
    elsif v_question_categ_code = 'CLHTS' then v_return := '106800';
    elsif v_question_categ_code = 'NEPYS' then v_return := '107000';
    --
    elsif v_question_categ_code = 'MOODD' then v_return := '107200';
    --
    elsif v_question_categ_code = 'FALLR' then v_return := '107400';
    elsif v_question_categ_code = 'DIZZI' then v_return := '107600';
    elsif v_question_categ_code = 'HHISQ' then v_return := '107800';
    elsif v_question_categ_code = 'HOMES' then v_return := '108000';
    --
    elsif v_question_categ_code = 'COGND' then v_return := '108200';
    elsif v_question_categ_code = 'HSLF2' then v_return := '108400';
    elsif v_question_categ_code = 'FRLT1' then v_return := '108600';
    elsif v_question_categ_code = 'FRLT2' then v_return := '108800';
    elsif v_question_categ_code = 'MOOD1' then v_return := '109000';
    elsif v_question_categ_code = 'MEDCP' then v_return := '109200';
    else  v_return := null;
    end if;
    return v_return;
  end get_categ_qrc;
  --
  PROCEDURE load_question
  is
    v_parent_question_sn question.parent_question_sn%type;
    v_question_categ_code list_question_categ.question_categ_code%type;
    v_question_sn question.question_sn%type;
  BEGIN
    v_proc_name := upper('load_question');
    for i in (select 'BMEDH' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have any disability?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Mark appropriately' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a Hx of Heart Disease?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a Hx of irregular Heart beat?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a Hx of cancer?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any COPD or Emphysema Hx?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Stroke or CVA Hx?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1008' question_code,8 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any after residual limitation?' short_descr,null long_descr,'1007' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any injury/Fall that required ER or Hospitalization?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Did you recently noticed any functional limitations i.e. during your daily activities?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Alzheimer Hx?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Did you recently noticed any declining of your cognitive skill?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you been diagnosed of Diabetes?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Chronic Kidney Disease?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1015' question_code,15 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you on Dialysis?' short_descr,null long_descr,'1014' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Hx of Pneumonia or influenza?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Major Blood Disorder?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any Chronic Liver Disease?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you suffer of High Blood Pressure or Pulmonary HTN?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have Hx of HIV or any Immunosuppressive Disorder?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a Hx of Parkinson?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1022' question_code,22 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you been Diagnosed of Depression?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1023' question_code,23 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you take prescription Medication?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1024' question_code,24 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you take your meds as your Dr. prescribed?' short_descr,null long_descr,'1023' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1025' question_code,25 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you take supplements?' short_descr,null long_descr,'1023' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLFA' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,'STR' question_sub_categ_code,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,'ANX' question_sub_categ_code,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,'DEP' question_sub_categ_code,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'ANXIT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Can you say what triggers your feeling anxious?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Excessively worries?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Fear of a fall?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Fear to die?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Don''t know?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'SLFHQ' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you been having any though about harming yourself?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you basically satisfied with your life?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel that your life is empty?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get bored often?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you in a good mood most of the time?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel happy most of the time?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you often feel helpless?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel full of energy?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HRSTS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Death of spouse?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Divorce?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Marital separation?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Death of close family member?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Personal injury or illness?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Jail term?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Marriage?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Job loss or termination?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Marital reconciliation?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Retirement?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Illness of a close family member?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Sex difficulties?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Gain of new family member?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Business readjustment?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in financial status?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Death of a close friend?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Increase in the instances of arguments with spouse?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Difficulty to pay a Large mortgage or loan?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Foreclosure of mortgage or loan?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change of responsibilities at work?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Son or daughter leaving home?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1022' question_code,22 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Trouble with in- laws?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1023' question_code,23 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Legal problems?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1024' question_code,24 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Spouse begin or stop working?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1025' question_code,25 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Revision of personal habits?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1026' question_code,26 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in living conditions?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1027' question_code,27 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Trouble at work?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1028' question_code,28 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in works hours or conditions?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1029' question_code,29 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change of Residence?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1030' question_code,30 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in recreation?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1031' question_code,31 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in Church activities?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1032' question_code,32 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in Social activities?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1033' question_code,33 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Changes in sleeping habits?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1034' question_code,34 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Change in eating habits?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1035' question_code,35 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Vacation?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,'EML' question_sub_categ_code,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,'SCL' question_sub_categ_code,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,'EML' question_sub_categ_code,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,'SCL' question_sub_categ_code,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,'EML' question_sub_categ_code,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,'SCL' question_sub_categ_code,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'FRLTY' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Age' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLTY' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get help with shopping?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,3 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1001' parent_question_code,'DND' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,5 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get help with managing money?' short_descr,null long_descr,'1004' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1006' question_code,6 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1004' parent_question_code,'DND' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1008' question_code,8 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get help with walking?' short_descr,null long_descr,'1007' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1009' question_code,9 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1007' parent_question_code,'DND' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1011' question_code,11 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get help with light housework?' short_descr,null long_descr,'1010' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1012' question_code,12 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1010' parent_question_code,'DND' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1014' question_code,14 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you get help with bathing or showering?' short_descr,null long_descr,'1013' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1015' question_code,15 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1013' parent_question_code,'DND' triggered_response_code,'QTN' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,3 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'do you take BP medication(s)?' short_descr,null long_descr,'1002' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,4 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you believe Your BP is under control?' short_descr,null long_descr,'1002' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,5 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you or your Dr recently checked your blood sugar?' short_descr,null long_descr,'1002' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,7 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you take Diabetes medication?' short_descr,null long_descr,'1006' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1008' question_code,8 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'is your Blood sugar under control?' short_descr,null long_descr,'1006' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,10 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'does your cholesterol was high?' short_descr,null long_descr,'1009' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,11 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'do you take med(s) to control your Cholesterol?' short_descr,null long_descr,'1009' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,12 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does Your Cholesterol still high?' short_descr,null long_descr,'1009' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you currently smoke?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,15 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you interested to quit smoking' short_descr,null long_descr,'1014' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,17 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you drink more than 6 alcohol drinks per week?' short_descr,null long_descr,'1016' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,18 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you interested in quitting?' short_descr,null long_descr,'1016' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1020' question_code,20 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'have you been diagnosed of sleep apnea?' short_descr,null long_descr,'1019' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you overweight?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,22 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1023' question_code,23 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,24 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'do you sit most of the day?' short_descr,null long_descr,'1023' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1025' question_code,25 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1026' question_code,26 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1027' question_code,27 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1028' question_code,28 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1029' question_code,29 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1030' question_code,30 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1031' question_code,31 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1032' question_code,32 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1033' question_code,33 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1034' question_code,34 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1035' question_code,35 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you follow the USDA recommended vaccination program for people in your age group? Example Flu and pneumonia vaccines?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'ADLBF' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Bathing' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Dressing' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Toileting' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Transferring' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Continence' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Feeding' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'IADLB' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Ability to Use Telephone' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Laundry' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Shopping' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Travelling' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Food Preparation' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Medication Responsibilities' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Housekeeping' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Financial Responsibilities' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'how many times?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1004' question_code,4 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'how many days?' short_descr,null long_descr,'1003' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1007' question_code,7 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you currently taking any allergy medication?' short_descr,null long_descr,'1006' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              --
              select 'HVACN' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'HepB (3 doses. Needed for adults who didn''t get these vaccines when they were children)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Influenza (Get a flu vaccine every year)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Pneumonia (1 or 2 doses). There are two different types of pneumococcal vaccines. Talk with your healthcare professional to find out if one or both pneumococcal vaccines are recommended for you.' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Herpes Zoster / Shingles (1 dose. You should get the zoster vaccine even if you''ve had shingles before.)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HVART' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Colonoscopy (Screening should start at 50 and continue until age 75. Flexible sigmoidoscopy (5y), Screening colonoscopy (10y) & Barium enema.)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Blood Glucose tests, Example: FBS, A1C (A blood glucose test is recommended by the American Diabetes Association every three years. However, other tests (glucose tol. test and fasting blood sugar)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Lipid Panel (Once every five years in adults ages 20 and over.)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Mammography Annually (female age 40 or over)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Pap Smear (Every 24 months except high risk)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Hemocult (Screening should start at 50 and continue until age 75. Fecal occult blood test (annual)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'EKG (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Abdominal Aortic Screening, Example: Ultrasound (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Bone Density (Age 65 & older, biennial)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'DM Management (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Eye Exam (Adults aged 19 to 64 should have an eye exam at least every two years)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Hearing test (Have one at least once in your adult life)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Prostate Exam Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'PSA Test Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Rectal Exam (Annually)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Pelvic Exam (Annually)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Genetic Disorder' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HENMT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Blurred Vision' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Ringing of Ears' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Hearing Difficulties' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Mouth Sores' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Loss or Change in Taste' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Headaches' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Dizziness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Fever' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'MUSCS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Joint Pain' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Joint Swelling' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Low Back Pain' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Other Muscle Pain' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Neck Pain' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Muscle Weakness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'CLHTS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Chest Pain' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Shortness of Breath' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Wheezing, Asthma' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Irregular Heart rhythmic' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'NEPYS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Depression' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Insomnia' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Nervousness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Tiredness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Anxious' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Trouble Thinking' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Skin Related symptoms' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Easy Bruising' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Hives, Welts, wafts, moles' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Itching' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Rash' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Numbness' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Gastrointestinal symptoms' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Loss of Appetite' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Nausea' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Heartburn' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Indigestion' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Belching' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Pain discomfort' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Liver Problems' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1022' question_code,22 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Diarrhea often' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1023' question_code,23 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Constipation' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1024' question_code,24 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Vomiting' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1025' question_code,25 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'MOOD1' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were so irritable that you shouted at people or started fights or arguments?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you felt much more self-confident than usual?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you got much less sleep than usual and found you didn''t really miss it?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were much more talkative or spoke much faster than usual?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...thoughts raced through your head or you couldn’t slow your mind down?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were so easily distracted by things around you that you had trouble concentrating or staying on track?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you had much more energy than usual?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were much more active or did many more things than usual?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were much more social or outgoing than usual, for example, you telephoned friends in the middle of the night?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you were much more interested in sex than usual?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...you did things that were unusual for you or that other people might have thought were excessive, foolish, or risky?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'...spending money got you or your family into trouble?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOODD' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOODD' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'How much of a problem did any of these cause you – like being unable to work; having family, money or legal troubles; getting into arguments or fights?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOODD' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MOODD' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'FALLR' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Because the FALL did you need to go to an ER?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you taking More than 2 prescribing Meds?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you suffer from hearing loss?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you believe you have any balance problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'DIZZI' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you afraid to leave home w/o having someone accompanying due to of your dizziness?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does bending make you dizzier?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'HOMES' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose??' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'COGND' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Was the clinician or interviewer able to notice the beneficiary slow pace while was approached to assist to the AWV interview' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              --
              select 'MEDCP' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Are you taking any prescribed Medication?' short_descr,null long_descr,null parent_question_code,null triggered_response_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'How many prescribed Medications are you currently taken?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,3 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,4 order_num,'Y' conditional_question_flag,null question_sub_categ_code,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,'1001' parent_question_code,'YES' triggered_response_code,'QTN' query_type from dual
              --
              order by question_categ_code,order_num asc
              )
    loop
      if i.query_type = 'QTN' then
        if i.parent_question_code is not null then
          v_question_categ_code := i.question_categ_code;
          v_parent_question_sn := qtn_sn(v_question_categ_code,i.parent_question_code);
        else
          v_parent_question_sn := null;
        end if;
        --
        begin
          INSERT INTO question  (QUESTION_SN
                                ,QUESTION_CATEG_CODE
                                ,QUESTION_CODE
                                ,question_sub_categ_code
                                ,ORDER_NUM
                                ,CONDITIONAL_QUESTION_FLAG
                                ,PARENT_QUESTION_SN
                                ,triggered_response_code
                                )
                        VALUES (QUESTION_SNG.nextval
                                ,i.QUESTION_CATEG_CODE
                                ,i.QUESTION_CODE
                                ,i.question_sub_categ_code
                                ,i.ORDER_NUM
                                ,i.CONDITIONAL_QUESTION_FLAG
                                ,v_parent_question_sn
                                ,i.triggered_response_code
                                );
        exception 
          when dup_val_on_index then
            update question
            set ORDER_NUM = i.ORDER_NUM
                ,CONDITIONAL_QUESTION_FLAG = i.CONDITIONAL_QUESTION_FLAG
                ,PARENT_QUESTION_SN = v_parent_question_sn
                ,question_sub_categ_code = i.question_sub_categ_code
                ,triggered_response_code = i.triggered_response_code
            where QUESTION_CATEG_CODE = i.QUESTION_CATEG_CODE
            and question_code = i.question_code
            ;
          when others then
            v_error_rec := i.question_categ_code||'-'||i.question_code;
            v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
        end;
        begin
          v_question_sn := qtn_sn(i.question_categ_code,i.question_code);
          INSERT INTO question_lang (question_lang_SN
                                          ,question_sn
                                          ,LANG_CODE
                                          ,SHORT_DESCR
                                          ,LONG_DESCR
                                          )
          VALUES (question_lang_SNG.nextval
                  ,v_question_sn
                  ,i.LANG_CODE
                  ,i.SHORT_DESCR
                  ,i.LONG_DESCR
                 );
        exception 
          when dup_val_on_index then
            update question_lang
            set SHORT_DESCR = i.SHORT_DESCR
                ,LONG_DESCR = i.LONG_DESCR
            where question_sn = v_question_sn
            and LANG_CODE = i.LANG_CODE
            ;
          when others then
            v_error_rec := i.question_categ_code||'-'||i.question_code||'-'||i.lang_code;
            v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
        end;
      elsif i.query_type = 'SCR' then
        --for score
        null;
      end if;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question;
  --
  PROCEDURE load_question_response
  is
    v_question_sn question.question_sn%type;
    v_question_response_code question_response.question_response_code%type;
    v_question_categ_code list_question_categ.question_categ_code%type := '99999';
  BEGIN
    v_proc_name := upper('load_question_response');
    for i in (select 'BMEDH' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of Heart Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of irregular Heart beat?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of cancer?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any COPD or Emphysema Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Stroke or CVA Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Any after residual limitation?' short_descr,null long_descr,'1007' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any injury/Fall that required ER or Hospitalization?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently noticed any functional limitations i.e. during your daily activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Alzheimer Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently noticed any declining of your cognitive skill?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been diagnosed of Diabetes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Chronic Kidney Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you on Dialysis?' short_descr,null long_descr,'1014' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1016' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Hx of Pneumonia or influenza?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1017' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Major Blood Disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1018' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Chronic Liver Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1019' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer of High Blood Pressure or Pulmonary HTN?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1020' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have Hx of HIV or any Immunosuppressive Disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1021' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of Parkinson?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1022' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Diagnosed of Depression?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1023' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take prescription Medication?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1024' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take your meds as your Dr. prescribed?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1025' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take supplements?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of Heart Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of irregular Heart beat?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of cancer?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any COPD or Emphysema Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Stroke or CVA Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Any after residual limitation?' short_descr,null long_descr,'1007' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any injury/Fall that required ER or Hospitalization?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently noticed any functional limitations i.e. during your daily activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Alzheimer Hx?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently noticed any declining of your cognitive skill?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been diagnosed of Diabetes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1014' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Chronic Kidney Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1015' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you on Dialysis?' short_descr,null long_descr,'1014' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1016' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Hx of Pneumonia or influenza?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1017' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Major Blood Disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1018' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any Chronic Liver Disease?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1019' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer of High Blood Pressure or Pulmonary HTN?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1020' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have Hx of HIV or any Immunosuppressive Disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1021' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a Hx of Parkinson?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1022' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Diagnosed of Depression?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1023' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take prescription Medication?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1024' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take your meds as your Dr. prescribed?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1025' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take supplements?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1002' question_code,1 order_num,'FNC' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Mark appropriately' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,2 order_num,'COG' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Mark appropriately' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,3 order_num,'MND' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Mark appropriately' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,4 order_num,'MHE' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Mark appropriately' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++1
              select 'HSLFA' question_categ_code,'1001' question_code,1 order_num,'POR' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,2 order_num,'FIR' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,3 order_num,'GOD' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,4 order_num,'VGD' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,5 order_num,'EXC' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1002' question_code,1 order_num,'LFM' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,2 order_num,'LFY' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,3 order_num,'ALW' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'HSLF2' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'PSYSD' question_categ_code,'1001' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,1 order_num,'NVR' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,2 order_num,'SMT' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,3 order_num,'OFT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,4 order_num,'AAL' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'ANXIT' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you say what triggers your feeling anxious?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Excessively worries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear of a fall?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear to die?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Don''t know?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'ANXIT' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you say what triggers your feeling anxious?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Excessively worries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear of a fall?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear to die?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Don''t know?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'SLFHQ' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been having any though about harming yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'SLFHQ' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been having any though about harming yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you basically satisfied with your life?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your life is empty?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get bored often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you in a good mood most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel happy most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you often feel helpless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel full of energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you basically satisfied with your life?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your life is empty?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get bored often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,1 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you in a good mood most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,1 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel happy most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you often feel helpless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,1 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,1 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel full of energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HRSTS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,100 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of spouse?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,73 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Divorce?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,65 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marital separation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,63 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of close family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,53 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Personal injury or illness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,50 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Jail term?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,50 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marriage?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,47 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Job loss or termination?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,45 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marital reconciliation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,45 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Retirement?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,44 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Illness of a close family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Sex difficulties?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gain of new family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Business readjustment?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,38 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in financial status?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1016' question_code,1 order_num,'CBX' response_code,37 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of a close friend?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1017' question_code,1 order_num,'CBX' response_code,35 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Increase in the instances of arguments with spouse?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1018' question_code,1 order_num,'CBX' response_code,31 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Difficulty to pay a Large mortgage or loan?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1019' question_code,1 order_num,'CBX' response_code,30 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Foreclosure of mortgage or loan?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1020' question_code,1 order_num,'CBX' response_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change of responsibilities at work?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1021' question_code,1 order_num,'CBX' response_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Son or daughter leaving home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1022' question_code,1 order_num,'CBX' response_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble with in- laws?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1023' question_code,1 order_num,'CBX' response_code,28 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Legal problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1024' question_code,1 order_num,'CBX' response_code,26 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Spouse begin or stop working?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1025' question_code,1 order_num,'CBX' response_code,24 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Revision of personal habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1026' question_code,1 order_num,'CBX' response_code,24 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in living conditions?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1027' question_code,1 order_num,'CBX' response_code,23 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble at work?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1028' question_code,1 order_num,'CBX' response_code,20 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in works hours or conditions?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1029' question_code,1 order_num,'CBX' response_code,20 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change of Residence?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1030' question_code,1 order_num,'CBX' response_code,19 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in recreation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1031' question_code,1 order_num,'CBX' response_code,19 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in Church activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1032' question_code,1 order_num,'CBX' response_code,18 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in Social activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1033' question_code,1 order_num,'CBX' response_code,16 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Changes in sleeping habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1034' question_code,1 order_num,'CBX' response_code,15 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in eating habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1035' question_code,1 order_num,'CBX' response_code,13 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Vacation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'LONLS' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,2 order_num,'MOL' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,3 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,3 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,3 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,3 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,3 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,3 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'FRLTY' question_categ_code,'1001' question_code,1 order_num,'B78' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Age' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,2 order_num,'G85' response_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Age' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FRLTY' question_categ_code,'1002' question_code,1 order_num,'POR' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1002' question_code,2 order_num,'FIR' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1002' question_code,3 order_num,'GOD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1002' question_code,4 order_num,'VGD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1002' question_code,5 order_num,'EXC' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --+++++++++++++++++++
              select 'FRLT1' question_categ_code,'1001' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,1 order_num,'NDI' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,2 order_num,'ALD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,3 order_num,'SMD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,4 order_num,'ATD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,5 order_num,'UTD' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --+++++++++++++++++++++
              select 'FRLT2' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,3 order_num,'DND' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with shopping?' short_descr,null long_descr,'1001' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with shopping?' short_descr,null long_descr,'1001' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1001' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1001' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,3 order_num,'DND' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with managing money?' short_descr,null long_descr,'1004' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with managing money?' short_descr,null long_descr,'1004' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1004' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1004' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1007' question_code,3 order_num,'DND' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with walking?' short_descr,null long_descr,'1007' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with walking?' short_descr,null long_descr,'1007' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1007' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1007' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1010' question_code,3 order_num,'DND' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with light housework?' short_descr,null long_descr,'1010' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with light housework?' short_descr,null long_descr,'1010' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1010' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1010' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1013' question_code,3 order_num,'DND' response_code,0 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with bathing or showering?' short_descr,null long_descr,'1013' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1014' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you get help with bathing or showering?' short_descr,null long_descr,'1013' parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1013' parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1015' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is that because of your health?' short_descr,null long_descr,'1013' parent_question_code,'QTN' query_type from dual union
              --++++++++++++++++++
              select 'BEHVT' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take BP medication(s)?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you believe Your BP is under control?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you or your Dr recently checked your blood sugar?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take Diabetes medication?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'is your Blood sugar under control?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'does your cholesterol was high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take med(s) to control your Cholesterol?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does Your Cholesterol still high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you currently smoke?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested to quit smoking' short_descr,null long_descr,'1014' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you drink more than 6 alcohol drinks per week?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in quitting?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1020' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'have you been diagnosed of sleep apnea?' short_descr,null long_descr,'1019' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you overweight?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1023' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you sit most of the day?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1025' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1026' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1027' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1028' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1029' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1030' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1031' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1032' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1033' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1034' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1035' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you follow the USDA recommended vaccination program for people in your age group? Example Flu and pneumonia vaccines?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take BP medication(s)?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you believe Your BP is under control?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you or your Dr recently checked your blood sugar?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take Diabetes medication?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'is your Blood sugar under control?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'does your cholesterol was high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take med(s) to control your Cholesterol?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does Your Cholesterol still high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you currently smoke?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested to quit smoking' short_descr,null long_descr,'1014' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you drink more than 6 alcohol drinks per week?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in quitting?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1020' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'have you been diagnosed of sleep apnea?' short_descr,null long_descr,'1019' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you overweight?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1023' question_code,2 order_num,'NOO' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you sit most of the day?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1025' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1026' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1027' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1028' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1029' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1030' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1031' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1032' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1033' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1034' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1035' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you follow the USDA recommended vaccination program for people in your age group? Example Flu and pneumonia vaccines?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1001' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take BP medication(s)?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you believe Your BP is under control?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you or your Dr recently checked your blood sugar?' short_descr,null long_descr,'1002' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you take Diabetes medication?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1008' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'is your Blood sugar under control?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'does your cholesterol was high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you take med(s) to control your Cholesterol?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does Your Cholesterol still high?' short_descr,null long_descr,'1009' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you currently smoke?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested to quit smoking' short_descr,null long_descr,'1014' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you drink more than 6 alcohol drinks per week?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in quitting?' short_descr,null long_descr,'1016' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1020' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'have you been diagnosed of sleep apnea?' short_descr,null long_descr,'1019' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you overweight?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1023' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'do you sit most of the day?' short_descr,null long_descr,'1023' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1025' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1026' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1027' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1028' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1029' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1030' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1031' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1032' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1033' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1034' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1035' question_code,3 order_num,'IDK' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you follow the USDA recommended vaccination program for people in your age group? Example Flu and pneumonia vaccines?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'ADLBF' question_categ_code,'1001' question_code,1 order_num,'ABI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Bathes self completely (with exception of needs help in bathing only a single part of the body such as the back, genital area or disabled extremity)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1001' question_code,2 order_num,'ABD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Need help with bathing (more than one part of the body, getting in or out of the tub or shower) or requires total bathing' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,1 order_num,'ADI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Get clothes from closets and drawers and puts on clothes and outer garments complete with fasteners (may have help tying shoes)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,2 order_num,'ADD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help with dressing self or needs to be completely dressed.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,1 order_num,'ATI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Goes to toilet, gets on and off, arranges clothes, cleans genital area without help.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,2 order_num,'ATD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help transferring to the toilet, cleaning self or uses bedpan or commode.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,1 order_num,'ARI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Moves in and out of bed or chair unassisted (mechanical transfer aids are acceptable)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,2 order_num,'ARD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help in moving from bed to chair or requires a complete transfer.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,1 order_num,'ACI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Exercises complete self-control over urination and defecation.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,2 order_num,'ACD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is partially or totally incontinent of bowel or bladder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,1 order_num,'AFI' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gets food from plate into mouth without help (preparation of food may be done by another person)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,2 order_num,'AFD' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs partial or total help with feeding or requires parenteral feeding.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1001' question_code,1 order_num,'IT1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Operates telephone on own initiative (looks up and dials numbers, etc.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,2 order_num,'IT2' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dials a few well-known numbers' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,3 order_num,'IT3' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Answers telephone but does not dial' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,4 order_num,'IT4' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not use telephone at all' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1002' question_code,1 order_num,'IL1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does personal laundry completely' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,2 order_num,'IL2' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Launders small items (rinses stockings, etc.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,3 order_num,'IL3' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'All laundry must be done by others' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1003' question_code,1 order_num,'IS1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Takes care of all shopping needs independently' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,2 order_num,'IS2' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Shops independently for small purchases' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,3 order_num,'IS3' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs to be accompanied on any shopping trip' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,4 order_num,'IS4' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Completely unable to shop' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1004' question_code,1 order_num,'IR1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travels independently on public transportation or drives own car' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,2 order_num,'IR2' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Arranges own travel via taxi, but does not otherwise use public transportation' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,3 order_num,'IR3' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travels on public transportation when accompanied by another' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,4 order_num,'IR4' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travel limited to taxi or automobile with assistance of another' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,5 order_num,'IR5' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not travel at all' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1005' question_code,1 order_num,'IF1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Plans, prepares and serves adequate meals independently' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,2 order_num,'IF2' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Prepares adequate meals if supplied with ingredients' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,3 order_num,'IF3' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heats, serves and prepares meals, or prepares meals, or prepares meals but does not maintain adequate diet' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,4 order_num,'IF4' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs to have meals prepared and served' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1006' question_code,1 order_num,'IM1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is responsible for taking medication in correct dosages at correct time' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,2 order_num,'IM2' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Takes responsibility if medication is prepared in advance in separate dosage' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,3 order_num,'IM3' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is not capable of dispensing own medication' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1007' question_code,1 order_num,'IH1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Maintains house alone or with occasional assistance (e.g. "heavy work domestic help")' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,2 order_num,'IH2' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Performs light daily tasks such as dish washing, bed making' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,3 order_num,'IH3' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Performs light daily tasks but cannot maintain acceptable level of cleanliness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,4 order_num,'IH4' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help with all home maintenance tasks' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,5 order_num,'IH5' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not participate in any housekeeping tasks' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1008' question_code,1 order_num,'II1' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Manages financial matters independently (budgets, writes checks, pays rent, bills, goes to bank), collects and keeps track of income' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,2 order_num,'II2' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Manages day-to- day purchases, but needs help with banking, major purchases, etc.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,3 order_num,'II3' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Incapable of handling money' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HSURA' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1002' question_code,1 order_num,'DET' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'how many times?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1004' question_code,1 order_num,'DET' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'how many days?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1007' question_code,1 order_num,'DET' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you currently taking any allergy medication?' short_descr,null long_descr,'1006' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HVACN' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'HepB (3 doses. Needed for adults who didn''t get these vaccines when they were children)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Influenza (Get a flu vaccine every year)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pneumonia (1 or 2 doses). There are two different types of pneumococcal vaccines. Talk with your healthcare professional to find out if one or both pneumococcal vaccines are recommended for you.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Herpes Zoster / Shingles (1 dose. You should get the zoster vaccine even if you''ve had shingles before.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HVART' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colonoscopy (Screening should start at 50 and continue until age 75. Flexible sigmoidoscopy (5y), Screening colonoscopy (10y) & Barium enema.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Blood Glucose tests, Example: FBS, A1C (A blood glucose test is recommended by the American Diabetes Association every three years. However, other tests (glucose tol. test and fasting blood sugar)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Lipid Panel (Once every five years in adults ages 20 and over.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Mammography Annually (female age 40 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pap Smear (Every 24 months except high risk)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hemocult (Screening should start at 50 and continue until age 75. Fecal occult blood test (annual)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'EKG (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Abdominal Aortic Screening, Example: Ultrasound (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Bone Density (Age 65 & older, biennial)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'DM Management (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Eye Exam (Adults aged 19 to 64 should have an eye exam at least every two years)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hearing test (Have one at least once in your adult life)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Prostate Exam Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'PSA Test Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Rectal Exam (Annually)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1016' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pelvic Exam (Annually)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'FHNMR' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Genetic Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HENMT' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Blurred Vision' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Ringing of Ears' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hearing Difficulties' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Mouth Sores' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Loss or Change in Taste' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Headaches' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dizziness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fever' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MUSCS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Joint Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Joint Swelling' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Low Back Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Other Muscle Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Neck Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Muscle Weakness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'CLHTS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chest Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Shortness of Breath' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Wheezing, Asthma' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Irregular Heart rhythmic' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'NEPYS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Insomnia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Nervousness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Tiredness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Anxious' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble Thinking' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Skin Related symptoms' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Easy Bruising' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hives, Welts, wafts, moles' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Itching' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Rash' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Numbness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gastrointestinal symptoms' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Loss of Appetite' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1016' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Nausea' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1017' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heartburn' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1018' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Indigestion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1019' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Belching' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1020' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pain discomfort' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1021' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Problems' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1022' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diarrhea often' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1023' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Constipation' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1024' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Vomiting' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1025' question_code,1 order_num,'CBX' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MOOD1' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you so irritable that you shouted at people or started fights or arguments?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you felt more confident than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you gotten a lot less sleep than usual and found you didn&#39;t really miss it?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more talkative than usual or spoken a tot faster?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been experiencing racing thoughts for prolonged hours and have not been able to slow your mind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you gotten easily distracted or absent minded lately affecting your ability to complete tasks or cause you to make dangerous mistakes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more energetic than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more uninhibited than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more social or outgoing than usual, Example: You telephoned friends in the middle of the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been feeling compulsive desire to have sex?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been doing things that are unusual for you or that other people thought were excessive, foolish, or risky?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been on a shopping spree spending an excessive amount of money that got you or your family into trouble?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'MOOD1' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Were you so irritable that you shouted at people or started fights or arguments?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt more confident than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you gotten a lot less sleep than usual and found you didn&#39;t really miss it?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more talkative than usual or spoken a tot faster?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing racing thoughts for prolonged hours and have not been able to slow your mind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you gotten easily distracted or absent minded lately affecting your ability to complete tasks or cause you to make dangerous mistakes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more energetic than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more uninhibited than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more social or outgoing than usual, Example: You telephoned friends in the middle of the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling compulsive desire to have sex?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been doing things that are unusual for you or that other people thought were excessive, foolish, or risky?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been on a shopping spree spending an excessive amount of money that got you or your family into trouble?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have any of your blood relatives, children, siblings, parents, grandparents, aunts, uncles, had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'MOODD' question_categ_code,'1002' question_code,1 order_num,'NOP' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1002' question_code,2 order_num,'MIP' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1002' question_code,3 order_num,'MOP' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOODD' question_categ_code,'1002' question_code,4 order_num,'SEP' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'FALLR' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Because the FALL did you need to go to an ER?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you taking More than 2 prescribing Meds?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'DIZZI' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'HHISQ' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from hearing loss?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you believe you have any balance problem?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FALLR' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Because the FALL did you need to go to an ER?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you taking More than 2 prescribing Meds?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from hearing loss?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you believe you have any balance problem?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'DIZZI' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,5 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,5 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,5 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you afraid to leave home w/o having someone accompanying due to of your dizziness?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,5 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,5 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does bending make you dizzier?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              --
              select 'DIZZI' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you afraid to leave home w/o having someone accompanying due to of your dizziness?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does bending make you dizzier?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HHISQ' question_categ_code,'1001' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,1 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,2 order_num,'SMT' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,3 order_num,'YES' response_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HOMES' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose??' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HOMES' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose??' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'COGND' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Was the clinician or interviewer able to notice the beneficiary slow pace while was approached to assist to the AWV interview' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'COGND' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Was the clinician or interviewer able to notice the beneficiary slow pace while was approached to assist to the AWV interview' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MEDCP' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you taking any prescribed Medication?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              --
              select 'MEDCP' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you taking any prescribed Medication?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual union
              --
              select 'MEDCP' question_categ_code,'1002' question_code,1 order_num,'DET' response_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'How many prescribed Medications are you currently taken?' short_descr,null long_descr,'1001' parent_question_code,'RSP' query_type from dual
              --
              order by question_categ_code,question_code,order_num
              )
    loop
      v_error_rec := i.question_categ_code||'-'||i.question_code||'-'||i.response_code;
      v_question_sn := qtn_sn(i.question_categ_code,i.question_code);
      --
      if v_question_categ_code <> i.question_categ_code then
        v_question_response_code := get_categ_qrc(i.question_categ_code);
      end if;
      --
      v_question_response_code := v_question_response_code + 1;
      v_question_categ_code := i.question_categ_code;
      --
      begin
        INSERT INTO question_response (QUESTION_RESPONSE_CODE
                                      ,QUESTION_SN
                                      ,RESPONSE_CODE
                                      ,SCORE_VALUE
                                      ,order_num
                                      ,trigger_further_question_flag
                                      ,trigger_further_categ_flag
                                      ,triggered_question_categ_code
                                      )
                                VALUES(v_question_response_code
                                      ,v_question_sn
                                      ,i.RESPONSE_CODE
                                      ,i.SCORE_VALUE
                                      ,i.order_num
                                      ,i.trigger_further_question_flag
                                      ,i.trigger_further_categ_flag
                                      ,i.triggered_question_categ_code
                                      );
      exception 
        when dup_val_on_index then
          update question_response
          set score_value = i.score_value
              ,order_num = i.order_num
              ,trigger_further_question_flag = i.trigger_further_question_flag
              ,trigger_further_categ_flag = i.trigger_further_categ_flag
              ,triggered_question_categ_code = i.triggered_question_categ_code
          where QUESTION_SN = v_QUESTION_SN
          and RESPONSE_CODE = i.RESPONSE_CODE
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_response;
END list_trans_pkg;
/
SHOW ERRORS
