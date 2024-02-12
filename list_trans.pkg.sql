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
  PROCEDURE load_question_response (p_ins_upd_ind in varchar2);
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
  PROCEDURE load_medication_unit;
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
  -----------
  PROCEDURE load_disease_type;
  PROCEDURE load_disease_categ;
  PROCEDURE load_disease;
  PROCEDURE load_risk_factor_categ;
  PROCEDURE load_risk_factor;
  PROCEDURE load_severity;
  PROCEDURE load_disease_severity;
  PROCEDURE load_disease_level;  
  PROCEDURE load_disease_risk_factor;
  --
  PROCEDURE load_symptom_categ;
  PROCEDURE load_symptom;
  PROCEDURE load_disease_symptom;
  --
  PROCEDURE load_em_categ_grp;
  PROCEDURE load_em_categ;
  PROCEDURE load_em_name;
  PROCEDURE load_ccm_question_categ;
  PROCEDURE load_ccm_question;
  PROCEDURE load_am_pm;
  PROCEDURE load_min;
  PROCEDURE load_hr;
  PROCEDURE load_svc_rpt_type;
  PROCEDURE load_prev_plan;
  PROCEDURE load_risk_factor_prev_plan;
  PROCEDURE load_disease_prev_plan;
  PROCEDURE load_patient_orientation;
  PROCEDURE load_remark_categ_grp;
  PROCEDURE load_rf_counseling_categ;
  PROCEDURE load_missing_goals_reason;
  PROCEDURE load_rf_missing_goals_reason;
  PROCEDURE load_dr_type;
  PROCEDURE load_report_template;
  PROCEDURE load_report;
  PROCEDURE load_priviledge_report;
  PROCEDURE load_insurance_company;
END list_trans_pkg;
/
SHOW ERRORS
CREATE OR REPLACE PACKAGE BODY list_trans_pkg IS
  PROCEDURE load_insurance_company
  is 
  BEGIN
    v_proc_name := upper('load_insurance_company');
    for i in (select 'MEDB' insurance_company_code,1 order_num,'Medicare (Part B)' name,null website,null phone_num,null fax_num from dual union
              select 'MADV' insurance_company_code,2 order_num,'Medicare (Advantage)' name,null website,null phone_num,null fax_num from dual union
              select 'BCBF' insurance_company_code,3 order_num,'Blue Cross & Blue Shield Of Florida (Florida Blue)' name,null website,null phone_num,null fax_num from dual union
              select 'UNTI' insurance_company_code,4 order_num,'Unitedhealthcare Insurance Company' name,null website,null phone_num,null fax_num from dual union
              select 'CGNA' insurance_company_code,5 order_num,'CIGNA' name,null website,null phone_num,null fax_num from dual union
              select 'HUMM' insurance_company_code,6 order_num,'Humana Medical Plan' name,null website,null phone_num,null fax_num from dual union
              select 'AETH' insurance_company_code,7 order_num,'Aetna Health' name,null website,null phone_num,null fax_num from dual union
              select 'AVMD' insurance_company_code,8 order_num,'Avmed' name,null website,null phone_num,null fax_num from dual union
              select 'UNTF' insurance_company_code,9 order_num,'Unitedhealthcare Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'CLTF' insurance_company_code,10 order_num,'Celtic Insurance Company' name,null website,null phone_num,null fax_num from dual union
              select 'WELF' insurance_company_code,11 order_num,'Wellcare Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'CARE' insurance_company_code,12 order_num,'Careplus Health Plans' name,null website,null phone_num,null fax_num from dual union
              select 'CGIC' insurance_company_code,13 order_num,'Connecticut General Life Insurance Company' name,null website,null phone_num,null fax_num from dual union
              select 'COVF' insurance_company_code,14 order_num,'Coventry Health Care Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'HUMI' insurance_company_code,15 order_num,'Humana Insurance Company' name,null website,null phone_num,null fax_num from dual union
              select 'CPTL' insurance_company_code,16 order_num,'Capital Health Plan' name,null website,null phone_num,null fax_num from dual union
              select 'HSPF' insurance_company_code,17 order_num,'Healthspring Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'AETL' insurance_company_code,18 order_num,'Aetna Life Insurance' name,null website,null phone_num,null fax_num from dual union
              select 'AMEF' insurance_company_code,19 order_num,'Amerigroup Florida' name,null website,null phone_num,null fax_num from dual union
              select 'PCPC' insurance_company_code,20 order_num,'Preferred Care Partners' name,null website,null phone_num,null fax_num from dual union
              select 'FREH' insurance_company_code,21 order_num,'Freedom Health' name,null website,null phone_num,null fax_num from dual union
              select 'FREL' insurance_company_code,22 order_num,'Freedom Life Insurance Company of America' name,null website,null phone_num,null fax_num from dual union
              select 'UNIV' insurance_company_code,23 order_num,'Universal Health Care' name,null website,null phone_num,null fax_num from dual union
              select 'MDCA' insurance_company_code,24 order_num,'Medica Healthcare Plans' name,null website,null phone_num,null fax_num from dual union
              select 'SSHP' insurance_company_code,25 order_num,'Sunshine State Health Plan' name,null website,null phone_num,null fax_num from dual union
              select 'HOPT' insurance_company_code,26 order_num,'Health Options' name,null website,null phone_num,null fax_num from dual union
              select 'NHPC' insurance_company_code,27 order_num,'Neighborhood Health Partnership' name,null website,null phone_num,null fax_num from dual union
              select 'COVS' insurance_company_code,28 order_num,'Coventry Summit Health Plan' name,null website,null phone_num,null fax_num from dual union
              select 'HFHP' insurance_company_code,29 order_num,'Health First Health Plans' name,null website,null phone_num,null fax_num from dual union
              select 'HESF' insurance_company_code,30 order_num,'Healthease Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'GRIC' insurance_company_code,31 order_num,'Golden Rule Insurance' name,null website,null phone_num,null fax_num from dual union
              select 'MLIC' insurance_company_code,32 order_num,'Metropolitan Life Insurance' name,null website,null phone_num,null fax_num from dual union
              select 'FHCP' insurance_company_code,33 order_num,'Florida Health Care Plan' name,null website,null phone_num,null fax_num from dual union
              select 'ALIC' insurance_company_code,34 order_num,'American Family Life Assurance Co. Of Columbus' name,null website,null phone_num,null fax_num from dual union
              select 'CHPF' insurance_company_code,35 order_num,'Coventry Health Plan Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'HUMH' insurance_company_code,36 order_num,'Humana Health Ins. Co. Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'PHTD' insurance_company_code,37 order_num,'The Public Health Trust Of Dade County' name,null website,null phone_num,null fax_num from dual union
              select 'MHLF' insurance_company_code,38 order_num,'Molina Healthcare Of Florida' name,null website,null phone_num,null fax_num from dual union
              select 'ACND' insurance_company_code,39 order_num,'Accendo Insurance' name,null website,null phone_num,null fax_num from dual union
              select 'PUPI' insurance_company_code,40 order_num,'Physicians United Plan' name,null website,null phone_num,null fax_num from dual union
              select 'OTHR' insurance_company_code,41 order_num,'Other (Not In The List)' name,null website,null phone_num,null fax_num from dual
              )
    loop
      v_error_rec := i.insurance_company_code;
      begin
        INSERT INTO insurance_company (insurance_company_code
                                      ,order_num
                                      ,name
                                      ,website
                                      ,phone_num
                                      ,fax_num
                                      )
        VALUES                        (i.insurance_company_code
                                      ,i.order_num
                                      ,i.name
                                      ,i.website
                                      ,i.phone_num
                                      ,i.fax_num        
                                      );
      exception
        when dup_val_on_index then
          update insurance_company
          set order_num = i.order_num
             ,name = i.name
             ,website = i.website
             ,phone_num = i.phone_num
             ,fax_num = i.fax_num
          where insurance_company_code = i.insurance_company_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20027,sqlerrm);
  END load_insurance_company;
  --
  PROCEDURE load_priviledge_report
  is 
  BEGIN
    v_proc_name := upper('load_priviledge_report');
    for i in (select 'RSCD' report_code,'RANA' priviledge_code,1 order_num,'Y' active_flag,'Service Complete Details' report_descr,'Analytical' privledge_descr from dual union
              select 'RSCS' report_code,'RANA' priviledge_code,2 order_num,'Y' active_flag,'Service Complete Summary' report_descr,'Analytical' privledge_descr from dual union
              select 'ROBS' report_code,'RANA' priviledge_code,3 order_num,'Y' active_flag,'Patients with Obesity' report_descr,'Analytical' privledge_descr from dual union
              select 'REMP' report_code,'RANA' priviledge_code,4 order_num,'Y' active_flag,'Patients Qualified for EM' report_descr,'Analytical' privledge_descr from dual union
              select 'ROBD' report_code,'RANA' priviledge_code,5 order_num,'N' active_flag,'Patients with Obesity and Diabetes' report_descr,'Analytical' privledge_descr from dual union
              select 'RFAL' report_code,'RANA' priviledge_code,6 order_num,'Y' active_flag,'Patients with Risk of Fall' report_descr,'Analytical' privledge_descr from dual union
              select 'RCVD' report_code,'RANA' priviledge_code,7 order_num,'Y' active_flag,'Patients with CVD' report_descr,'Analytical' privledge_descr from dual union
              select 'RALC' report_code,'RANA' priviledge_code,8 order_num,'Y' active_flag,'Patients with Alcohol Drinking Issue' report_descr,'Analytical' privledge_descr from dual union
              select 'RTBC' report_code,'RANA' priviledge_code,9 order_num,'Y' active_flag,'Patients with Tobacco Issue' report_descr,'Analytical' privledge_descr from dual union
              --
              select 'RCOM' report_code,'RNPI' priviledge_code,1 order_num,'Y' active_flag,'List of Company' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RLOC' report_code,'RNPI' priviledge_code,2 order_num,'Y' active_flag,'List of Location' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RPHY' report_code,'RNPI' priviledge_code,3 order_num,'Y' active_flag,'List of Physician' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RPRO' report_code,'RNPI' priviledge_code,4 order_num,'Y' active_flag,'List of Service Provider' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RPAT' report_code,'RNPI' priviledge_code,5 order_num,'Y' active_flag,'List of Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RNAW' report_code,'RNPI' priviledge_code,6 order_num,'Y' active_flag,'List of Patient with Next AWV Date' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'R438' report_code,'RNPI' priviledge_code,7 order_num,'Y' active_flag,'List of G0438 Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'R439' report_code,'RNPI' priviledge_code,8 order_num,'Y' active_flag,'List of G0439 Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RCEM' report_code,'RNPI' priviledge_code,9 order_num,'Y' active_flag,'List of EM (CCM) Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RCC2' report_code,'RNPI' priviledge_code,10 order_num,'Y' active_flag,'List of CCM (20 min) Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'RCC6' report_code,'RNPI' priviledge_code,11 order_num,'Y' active_flag,'List of CCM (60 min) Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'ROBL' report_code,'RNPI' priviledge_code,12 order_num,'Y' active_flag,'List of Obesity Screeing Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              select 'ROBC' report_code,'RNPI' priviledge_code,13 order_num,'Y' active_flag,'List of Obesity Counseling Patient' report_descr,'Other Inquiry' privledge_descr from dual union
              --
              select 'RPCS' report_code,'RPTI' priviledge_code,1 order_num,'Y' active_flag,'Completed Services' report_descr,'Patient Inquiry' privledge_descr from dual union
              select 'RPDI' report_code,'RPTI' priviledge_code,2 order_num,'Y' active_flag,'Detail Information' report_descr,'Patient Inquiry' privledge_descr from dual union
              select 'RQCS' report_code,'RPTI' priviledge_code,3 order_num,'Y' active_flag,'Qualified Counselling Services' report_descr,'Patient Inquiry' privledge_descr from dual union
              select 'RPSS' report_code,'RPTI' priviledge_code,4 order_num,'Y' active_flag,'Scheduled Services' report_descr,'Patient Inquiry' privledge_descr from dual union
              --
              select 'RLSS' report_code,'RSVC' priviledge_code,1 order_num,'Y' active_flag,'List of Scheduled Services' report_descr,'Scheduled Services' privledge_descr from dual
              )
    loop
      v_error_rec := i.report_code||'-'||i.priviledge_code;
      begin
        INSERT INTO priviledge_report (priviledge_report_sn
                                              ,report_code
                                              ,priviledge_code
                                              ,order_num
                                              ,active_flag
                                              )
        VALUES (priviledge_report_sng.nextval
               ,i.report_code
               ,i.priviledge_code
               ,i.order_num
               ,i.active_flag
               );
      exception 
        when dup_val_on_index then
          update priviledge_report
          set order_num = i.order_num
              ,active_flag = i.active_flag
          where report_code = i.report_code
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
  END load_priviledge_report;
  --
  PROCEDURE load_report
  is 
  BEGIN
    v_proc_name := upper('load_report');
    for i in (select 'RSCD' report_code,'en' lang_code,'Service Complete Details' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RSCS' report_code,'en' lang_code,'Service Complete Summary' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'ROBS' report_code,'en' lang_code,'Patients with Obesity' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'REMP' report_code,'en' lang_code,'Patients Qualified for EM' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'ROBD' report_code,'en' lang_code,'Patients with Obesity and Diabetes' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RFAL' report_code,'en' lang_code,'Patients with Risk of Fall' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RCVD' report_code,'en' lang_code,'Patients with CVD' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RALC' report_code,'en' lang_code,'Patients with Alcohol Drinking Issue' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RTBC' report_code,'en' lang_code,'Patients with Tobacco Issue' short_descr,null long_descr,'T002' report_template_code from dual union
              --
              select 'RCOM' report_code,'en' lang_code,'List of Company' short_descr,null long_descr,'T001' report_template_code from dual union
              select 'RLOC' report_code,'en' lang_code,'List of Location' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RPHY' report_code,'en' lang_code,'List of Physician' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'RPRO' report_code,'en' lang_code,'List of Service Provider' short_descr,null long_descr,'T002' report_template_code from dual union
              select 'RPAT' report_code,'en' lang_code,'List of Patient' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'RNAW' report_code,'en' lang_code,'List of Patient with Next AWV Date' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'R438' report_code,'en' lang_code,'List of G0438 Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'R439' report_code,'en' lang_code,'List of G0439 Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'RCEM' report_code,'en' lang_code,'List of EM (CCM) Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'RCC2' report_code,'en' lang_code,'List of CCM (20 min) Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'RCC6' report_code,'en' lang_code,'List of CCM (60 min) Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'ROBL' report_code,'en' lang_code,'List of Obesity Screeing Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              select 'ROBC' report_code,'en' lang_code,'List of Obesity Counseling Patient (Pending Appt)' short_descr,null long_descr,'T003' report_template_code from dual union
              --
              select 'RPCS' report_code,'en' lang_code,'Completed Services' short_descr,null long_descr,'T001' report_template_code from dual union
              select 'RPDI' report_code,'en' lang_code,'Detail Information' short_descr,null long_descr,'T001' report_template_code from dual union
              select 'RQCS' report_code,'en' lang_code,'Qualified Counselling Services' short_descr,null long_descr,'T001' report_template_code from dual union
              select 'RPSS' report_code,'en' lang_code,'Scheduled Services' short_descr,null long_descr,'T001' report_template_code from dual union
              select 'RLSS' report_code,'en' lang_code,'List of Scheduled Services' short_descr,null long_descr,'T003' report_template_code from dual
              )
    loop
      v_error_rec := i.report_code;
      begin
        INSERT INTO list_report (report_code
                            ,report_template_code
                                        )
        VALUES (i.report_code
              ,i.report_template_code
               );
      exception 
        when dup_val_on_index then
          update list_report
          set report_template_code = i.report_template_code
          where report_code = i.report_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.report_code||'-'||i.lang_code;
      begin
        INSERT INTO report_lang (report_lang_sn
                                        ,report_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (report_lang_SNG.nextval
                ,i.report_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update report_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where report_code = i.report_code
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
  END load_report;  
  --
  PROCEDURE load_report_template
  is 
  BEGIN
    v_proc_name := upper('load_report_template');
    for i in (select 'T001' report_template_code,'en' lang_code,'Level 1' short_descr,'List items where non of the items have any child items' long_descr from dual union
              select 'T002' report_template_code,'en' lang_code,'Level 2' short_descr,'Two level list items where top list item will have 1 to many childs' long_descr from dual union
              select 'T003' report_template_code,'en' lang_code,'Level 3' short_descr,'Three level list items where top list item will have 1 to many childs and 2nd level item will have 1 to many childs too' long_descr from dual union
              select 'T004' report_template_code,'en' lang_code,'Level 4' short_descr,'Four level list items where top list item will have 1 to many childs, 2nd level item will have 1 to many childs and 3rd level item will have 1 to many childs too' long_descr from dual
              )
    loop
      v_error_rec := i.report_template_code;
      begin
        INSERT INTO list_report_template (report_template_code
                                        )
        VALUES (i.report_template_code
               );
      exception
        when dup_val_on_index then null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.report_template_code||'-'||i.lang_code;
      begin
        INSERT INTO report_template_lang (report_template_lang_sn
                                        ,report_template_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (report_template_lang_sng.nextval
                ,i.report_template_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update report_template_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where report_template_code = i.report_template_code
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
      raise_application_error(-20027,sqlerrm);
  END load_report_template;
  --
  PROCEDURE load_dr_type
  is 
  BEGIN
    v_proc_name := upper('load_dr_type');
    for i in (select 'DO' dr_type_code,'en' lang_code,'Doctor of Osteopathic Medicine' short_descr,'Osteopathic Doctor' long_descr from dual union
              select 'MD' dr_type_code,'en' lang_code,'Doctor of Medicine' short_descr,'Allopathic Doctor' long_descr from dual
              )
    loop
      v_error_rec := i.dr_type_code;
      begin
        INSERT INTO list_dr_type (dr_type_code
                                        )
        VALUES (i.dr_type_code
               );
      exception
        when dup_val_on_index then null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.dr_type_code||'-'||i.lang_code;
      begin
        INSERT INTO dr_type_lang (dr_type_lang_sn
                                        ,dr_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (dr_type_lang_sng.nextval
                ,i.dr_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update dr_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where dr_type_code = i.dr_type_code
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
      raise_application_error(-20027,sqlerrm);
  END load_dr_type;
  --
  PROCEDURE load_rf_missing_goals_reason
  is 
  BEGIN
    v_proc_name := upper('load_rf_missing_goals_reason');
    for i in (select '101' rf_missing_goals_reason_code,'OBES' risk_factor_code,'1001' missing_goals_reason_code,1 order_num from dual union
              select '102' rf_missing_goals_reason_code,'OBES' risk_factor_code,'1002' missing_goals_reason_code,2 order_num from dual union
              select '103' rf_missing_goals_reason_code,'OBES' risk_factor_code,'1003' missing_goals_reason_code,3 order_num from dual union
              select '104' rf_missing_goals_reason_code,'OBES' risk_factor_code,'1004' missing_goals_reason_code,4 order_num from dual union
              select '105' rf_missing_goals_reason_code,'OBES' risk_factor_code,'1005' missing_goals_reason_code,5 order_num from dual
              )
    loop
      v_error_rec := i.risk_factor_code||'-'||i.missing_goals_reason_code;
      begin
        INSERT INTO rf_missing_goals_reason (rf_missing_goals_reason_code
                                          ,risk_factor_code
                                          ,missing_goals_reason_code
                                          ,order_num
                                          )
        VALUES  (i.rf_missing_goals_reason_code
                ,i.risk_factor_code
                ,i.missing_goals_reason_code
                ,i.order_num
                );
      exception 
        when dup_val_on_index then
          update rf_missing_goals_reason
          set order_num = i.order_num
          where risk_factor_code = i.risk_factor_code
          and missing_goals_reason_code = i.missing_goals_reason_code
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
  END load_rf_missing_goals_reason;
  --
  PROCEDURE load_missing_goals_reason
  is 
  BEGIN
    v_proc_name := upper('load_missing_goals_reason');
    for i in (select '1001' missing_goals_reason_code,'en' lang_code,'Lack of Motivation' short_descr,'Lack of Motivation' rpt_descr,null long_descr from dual union
              select '1002' missing_goals_reason_code,'en' lang_code,'Did not change wrong nutrition habit' short_descr,'No changes of wrong nutrition habit' rpt_descr,null long_descr from dual union
              select '1003' missing_goals_reason_code,'en' lang_code,'Didn''t followed your Physical Activity Plan' short_descr,'Didn''t followed Physical Activity Plan' rpt_descr,null long_descr from dual union
              select '1004' missing_goals_reason_code,'en' lang_code,'Any Disease uncontrolled' short_descr,'Uncontrolled Disease' rpt_descr,null long_descr from dual union
              select '1005' missing_goals_reason_code,'en' lang_code,'Other reason' short_descr,'Other reason' rpt_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.missing_goals_reason_code;
      begin
        INSERT INTO list_missing_goals_reason (missing_goals_reason_code
                                        )
        VALUES (i.missing_goals_reason_code
               );
      exception
        when dup_val_on_index then null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.missing_goals_reason_code||'-'||i.lang_code;
      begin
        INSERT INTO missing_goals_reason_lang (missing_goals_reason_lang_sn
                                        ,missing_goals_reason_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        ,rpt_descr
                                        )
        VALUES (missing_goals_reason_lang_sng.nextval
                ,i.missing_goals_reason_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
                ,i.rpt_descr
               );
      exception 
        when dup_val_on_index then
          update missing_goals_reason_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
              ,rpt_descr = i.rpt_descr
          where missing_goals_reason_code = i.missing_goals_reason_code
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
      raise_application_error(-20027,sqlerrm);
  END load_missing_goals_reason;
  --
  PROCEDURE load_rf_counseling_categ
  is 
  BEGIN
    v_proc_name := upper('load_rf_counseling_categ');
    for i in (select 'MEDRX' rf_counseling_categ_code,'en' lang_code,'Primary Physician' counseling_by,'Med Rx' short_descr,'Rx review & Med allergy test if necessary' long_descr from dual union
              select 'NUTRI' rf_counseling_categ_code,'en' lang_code,'Dietician Counseling' counseling_by,'Wrong Nutrition' short_descr,'Written Nutrition Program given to Patient' long_descr from dual union
              select 'INACT' rf_counseling_categ_code,'en' lang_code,'Skilled Pt or Trainer' counseling_by,'Physical Inactivity' short_descr,'Activity Live training & Home Exercise Plan' long_descr from dual union
              select 'DISEU' rf_counseling_categ_code,'en' lang_code,'Physician EM Assessment' counseling_by,'Disease Uncontrolled' short_descr,'Furthermore Patient may qualify for CCM' long_descr from dual union
              select 'MOTIV' rf_counseling_categ_code,'en' lang_code,'Primary Physician' counseling_by,'Motivational Attitude' short_descr,'Motivational perspective of weight loss explained to patient' long_descr from dual union
              select 'BEHAV' rf_counseling_categ_code,'en' lang_code,'Smoking, Alcohol, DNA' counseling_by,'Behavioral Changes' short_descr,'Physician appropriate counseling Referral' long_descr from dual
              )
    loop
      v_error_rec := i.rf_counseling_categ_code;
      begin
        INSERT INTO list_rf_counseling_categ (rf_counseling_categ_code
                                        )
        VALUES (i.rf_counseling_categ_code
               );
      exception 
        when dup_val_on_index then null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.rf_counseling_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO rf_counseling_categ_lang (rf_counseling_categ_lang_sn
                                        ,rf_counseling_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        ,counseling_by
                                        )
        VALUES (rf_counseling_categ_lang_sng.nextval
                ,i.rf_counseling_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
                ,i.counseling_by
               );
      exception 
        when dup_val_on_index then
          update rf_counseling_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
              ,counseling_by = i.counseling_by
          where rf_counseling_categ_code = i.rf_counseling_categ_code
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
  END load_rf_counseling_categ;
  --
  PROCEDURE load_remark_categ_grp
  is 
  BEGIN
    v_proc_name := upper('load_remark_categ_grp');
    for i in (select 'ADVC' remark_categ_grp_code,'en' lang_code,'Behavior Change Advice' short_descr,'Clear, specific, and personalized behavior change advice, including information about personal health harms and benefits' long_descr from dual union
              select 'GOAL' remark_categ_grp_code,'en' lang_code,'Treatment Goals and Methods' short_descr,'Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior' long_descr from dual union
              select 'TRET' remark_categ_grp_code,'en' lang_code,'Recommended Medical Treatment' short_descr,'To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments' long_descr from dual union
              select 'RFRL' remark_categ_grp_code,'en' lang_code,'Recommended Referral' short_descr,'Referral to more intensive or specialized treatment' long_descr from dual union
              select 'NOTE' remark_categ_grp_code,'en' lang_code,'Additional Notes' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.remark_categ_grp_code;
      begin
        INSERT INTO list_remark_categ_grp (remark_categ_grp_code
                                        )
        VALUES (i.remark_categ_grp_code
               );
      exception 
        when dup_val_on_index then null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.remark_categ_grp_code||'-'||i.lang_code;
      begin
        INSERT INTO remark_categ_grp_lang (remark_categ_grp_lang_sn
                                        ,remark_categ_grp_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (remark_categ_grp_lang_sng.nextval
                ,i.remark_categ_grp_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update remark_categ_grp_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where remark_categ_grp_code = i.remark_categ_grp_code
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
  END load_remark_categ_grp;
  --
  PROCEDURE load_risk_factor_prev_plan
  is 
  BEGIN
    v_proc_name := upper('load_risk_factor_prev_plan');
    for i in (select 'AGEE' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'AGEE' risk_factor_code,'PACT' prev_plan_code,2 order_num from dual union
              select 'AGEE' risk_factor_code,'HYPC' prev_plan_code,3 order_num from dual union
              select 'AGEE' risk_factor_code,'WHTM' prev_plan_code,4 order_num from dual union
              --
              select 'FMHX' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'FMHX' risk_factor_code,'TBCO' prev_plan_code,2 order_num from dual union
              select 'FMHX' risk_factor_code,'PACT' prev_plan_code,3 order_num from dual union
              select 'FMHX' risk_factor_code,'WHTM' prev_plan_code,4 order_num from dual union
              select 'FMHX' risk_factor_code,'PHYC' prev_plan_code,5 order_num from dual union
              select 'FMHX' risk_factor_code,'CHOC' prev_plan_code,6 order_num from dual union
              select 'FMHX' risk_factor_code,'DIAC' prev_plan_code,7 order_num from dual union
              --
              select 'ALCO' risk_factor_code,'ALCO' prev_plan_code,1 order_num from dual union
              --
              select 'ANXT' risk_factor_code,'PMED' prev_plan_code,1 order_num from dual union
              select 'ANXT' risk_factor_code,'SOCL' prev_plan_code,2 order_num from dual union
              select 'ANXT' risk_factor_code,'CONS' prev_plan_code,3 order_num from dual union
              select 'ANXT' risk_factor_code,'PSYC' prev_plan_code,4 order_num from dual union
              select 'ANXT' risk_factor_code,'ASPT' prev_plan_code,5 order_num from dual union
              --
              select 'COPD' risk_factor_code,'CONS' prev_plan_code,1 order_num from dual union
              select 'COPD' risk_factor_code,'PMED' prev_plan_code,2 order_num from dual union
              --
              select 'DEPR' risk_factor_code,'PMED' prev_plan_code,1 order_num from dual union
              select 'DEPR' risk_factor_code,'SOCL' prev_plan_code,2 order_num from dual union
              select 'DEPR' risk_factor_code,'CONS' prev_plan_code,3 order_num from dual union
              select 'DEPR' risk_factor_code,'PSYC' prev_plan_code,4 order_num from dual union
              select 'DEPR' risk_factor_code,'ASPT' prev_plan_code,5 order_num from dual union
              --
              select 'DIAB' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'DIAB' risk_factor_code,'PMED' prev_plan_code,2 order_num from dual union
              select 'DIAB' risk_factor_code,'PACT' prev_plan_code,3 order_num from dual union
              select 'DIAB' risk_factor_code,'CONS' prev_plan_code,4 order_num from dual union
              select 'DIAB' risk_factor_code,'DIAC' prev_plan_code,5 order_num from dual union
              --
              select 'HBPR' risk_factor_code,'PMED' prev_plan_code,1 order_num from dual union
              select 'HBPR' risk_factor_code,'CONS' prev_plan_code,2 order_num from dual union
              select 'HBPR' risk_factor_code,'HYPC' prev_plan_code,3 order_num from dual union
              --
              select 'HCHO' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'HCHO' risk_factor_code,'PMED' prev_plan_code,2 order_num from dual union
              select 'HCHO' risk_factor_code,'PACT' prev_plan_code,3 order_num from dual union
              select 'HCHO' risk_factor_code,'CONS' prev_plan_code,4 order_num from dual union
              select 'HCHO' risk_factor_code,'CHOC' prev_plan_code,5 order_num from dual union
              --
              select 'OBES' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'OBES' risk_factor_code,'PACT' prev_plan_code,2 order_num from dual union
              select 'OBES' risk_factor_code,'WHTM' prev_plan_code,3 order_num from dual union
              --
              select 'RACE' risk_factor_code,'HDET' prev_plan_code,1 order_num from dual union
              select 'RACE' risk_factor_code,'PACT' prev_plan_code,2 order_num from dual union
              select 'RACE' risk_factor_code,'HYPC' prev_plan_code,3 order_num from dual union
              select 'RACE' risk_factor_code,'WHTM' prev_plan_code,4 order_num from dual union
              --
              select 'STRS' risk_factor_code,'PACT' prev_plan_code,1 order_num from dual union
              --
              select 'TBCO' risk_factor_code,'7501' prev_plan_code,1 order_num from dual union
              select 'TBCO' risk_factor_code,'7502' prev_plan_code,2 order_num from dual union
              select 'TBCO' risk_factor_code,'7503' prev_plan_code,3 order_num from dual union
              select 'TBCO' risk_factor_code,'7504' prev_plan_code,4 order_num from dual union
              select 'TBCO' risk_factor_code,'7505' prev_plan_code,5 order_num from dual union
              select 'TBCO' risk_factor_code,'7506' prev_plan_code,6 order_num from dual union
              select 'TBCO' risk_factor_code,'7507' prev_plan_code,7 order_num from dual union
              select 'TBCO' risk_factor_code,'7508' prev_plan_code,8 order_num from dual union
              select 'TBCO' risk_factor_code,'7509' prev_plan_code,9 order_num from dual union
              --
              select 'ALCO' risk_factor_code,'7601' prev_plan_code,1 order_num from dual union
              --
              select 'INAC' risk_factor_code,'7701' prev_plan_code,1 order_num from dual union
              select 'INAC' risk_factor_code,'7702' prev_plan_code,2 order_num from dual union
              select 'INAC' risk_factor_code,'7703' prev_plan_code,3 order_num from dual union
              select 'INAC' risk_factor_code,'7704' prev_plan_code,4 order_num from dual union
              select 'INAC' risk_factor_code,'7705' prev_plan_code,5 order_num from dual union
              select 'INAC' risk_factor_code,'7706' prev_plan_code,6 order_num from dual union
              select 'INAC' risk_factor_code,'7707' prev_plan_code,7 order_num from dual union
              select 'INAC' risk_factor_code,'7708' prev_plan_code,8 order_num from dual union
              select 'INAC' risk_factor_code,'7709' prev_plan_code,9 order_num from dual union
              select 'INAC' risk_factor_code,'7710' prev_plan_code,10 order_num from dual union
              select 'INAC' risk_factor_code,'7711' prev_plan_code,11 order_num from dual union
              select 'INAC' risk_factor_code,'7712' prev_plan_code,12 order_num from dual union
              --
              select 'DIET' risk_factor_code,'7801' prev_plan_code,1 order_num from dual union
              select 'DIET' risk_factor_code,'7802' prev_plan_code,2 order_num from dual union
              select 'DIET' risk_factor_code,'7803' prev_plan_code,3 order_num from dual union
              select 'DIET' risk_factor_code,'7804' prev_plan_code,4 order_num from dual union
              select 'DIET' risk_factor_code,'7805' prev_plan_code,5 order_num from dual union
              select 'DIET' risk_factor_code,'7806' prev_plan_code,6 order_num from dual union
              --
              select 'WATR' risk_factor_code,'7901' prev_plan_code,1 order_num from dual union
              select 'WATR' risk_factor_code,'7902' prev_plan_code,2 order_num from dual union
              --
              select 'SLEP' risk_factor_code,'8101' prev_plan_code,1 order_num from dual union
              select 'SLEP' risk_factor_code,'8102' prev_plan_code,2 order_num from dual union
              select 'SLEP' risk_factor_code,'8103' prev_plan_code,3 order_num from dual union
              select 'SLEP' risk_factor_code,'8104' prev_plan_code,4 order_num from dual union
              select 'SLEP' risk_factor_code,'8105' prev_plan_code,5 order_num from dual union
              select 'SLEP' risk_factor_code,'8106' prev_plan_code,6 order_num from dual union
              select 'SLEP' risk_factor_code,'8107' prev_plan_code,7 order_num from dual union
              select 'SLEP' risk_factor_code,'8108' prev_plan_code,8 order_num from dual union
              select 'SLEP' risk_factor_code,'8109' prev_plan_code,9 order_num from dual union
              select 'SLEP' risk_factor_code,'8110' prev_plan_code,10 order_num from dual union
              select 'SLEP' risk_factor_code,'8111' prev_plan_code,11 order_num from dual union
              select 'SLEP' risk_factor_code,'8112' prev_plan_code,12 order_num from dual union
              --
              select 'DISA' risk_factor_code,'8301' prev_plan_code,1 order_num from dual union
              select 'DISA' risk_factor_code,'8302' prev_plan_code,2 order_num from dual union
              select 'DISA' risk_factor_code,'8303' prev_plan_code,3 order_num from dual union
              select 'DISA' risk_factor_code,'8304' prev_plan_code,4 order_num from dual union
              select 'DISA' risk_factor_code,'8305' prev_plan_code,5 order_num from dual union
              select 'DISA' risk_factor_code,'8306' prev_plan_code,6 order_num from dual union
              select 'DISA' risk_factor_code,'8307' prev_plan_code,7 order_num from dual union
              select 'DISA' risk_factor_code,'8308' prev_plan_code,8 order_num from dual union
              select 'DISA' risk_factor_code,'8309' prev_plan_code,9 order_num from dual union
              select 'DISA' risk_factor_code,'8310' prev_plan_code,10 order_num from dual union
              select 'DISA' risk_factor_code,'8311' prev_plan_code,11 order_num from dual union
              select 'DISA' risk_factor_code,'8312' prev_plan_code,12 order_num from dual union
              select 'DISA' risk_factor_code,'8313' prev_plan_code,13 order_num from dual union
              select 'DISA' risk_factor_code,'8314' prev_plan_code,14 order_num from dual
              )
    loop
      v_error_rec := i.risk_factor_code||'-'||i.prev_plan_code;
      begin
        INSERT INTO risk_factor_prev_plan (risk_factor_prev_plan_sn
                                          ,risk_factor_code
                                          ,prev_plan_code
                                          ,order_num
                                          )
        VALUES  (risk_factor_prev_plan_sng.nextval
                ,i.risk_factor_code
                ,i.prev_plan_code
                ,i.order_num
                );
      exception 
        when dup_val_on_index then
          update risk_factor_prev_plan
          set order_num = i.order_num
          where risk_factor_code = i.risk_factor_code
          and prev_plan_code = i.prev_plan_code
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
  END load_risk_factor_prev_plan;
  --
  PROCEDURE load_disease_prev_plan
  is 
  BEGIN
    v_proc_name := upper('load_disease_prev_plan');
    for i in (select 'DEPR' disease_code,'2001' prev_plan_code,1 order_num from dual union
              select 'DEPR' disease_code,'2002' prev_plan_code,2 order_num from dual union
              select 'DEPR' disease_code,'2003' prev_plan_code,3 order_num from dual union
              select 'DEPR' disease_code,'2004' prev_plan_code,4 order_num from dual union
              select 'DEPR' disease_code,'2005' prev_plan_code,5 order_num from dual union
              select 'DEPR' disease_code,'2006' prev_plan_code,6 order_num from dual union
              --
              select 'ANXT' disease_code,'3001' prev_plan_code,1 order_num from dual union
              select 'ANXT' disease_code,'3002' prev_plan_code,2 order_num from dual union
              select 'ANXT' disease_code,'3003' prev_plan_code,3 order_num from dual union
              select 'ANXT' disease_code,'3004' prev_plan_code,4 order_num from dual union
              select 'ANXT' disease_code,'3005' prev_plan_code,5 order_num from dual union
              --
              select 'STRS' disease_code,'4001' prev_plan_code,1 order_num from dual union
              select 'STRS' disease_code,'4002' prev_plan_code,2 order_num from dual union
              select 'STRS' disease_code,'4003' prev_plan_code,3 order_num from dual union
              --
--              select 'ELNL' disease_code,'5001' prev_plan_code,1 order_num from dual union
--              select 'ELNL' disease_code,'5002' prev_plan_code,2 order_num from dual union
--              select 'ELNL' disease_code,'5003' prev_plan_code,3 order_num from dual union
--              --
--              select 'SLNL' disease_code,'5001' prev_plan_code,1 order_num from dual union
--              select 'SLNL' disease_code,'5002' prev_plan_code,2 order_num from dual union
--              select 'SLNL' disease_code,'5003' prev_plan_code,3 order_num from dual union
--              select 'SLNL' disease_code,'5004' prev_plan_code,4 order_num from dual union
              --
              select 'LONL' disease_code,'5001' prev_plan_code,1 order_num from dual union
              select 'LONL' disease_code,'5002' prev_plan_code,2 order_num from dual union
              select 'LONL' disease_code,'5003' prev_plan_code,3 order_num from dual union
              select 'LONL' disease_code,'5004' prev_plan_code,4 order_num from dual union
              --
              select 'HBPR' disease_code,'7101' prev_plan_code,1 order_num from dual union
              select 'HBPR' disease_code,'7102' prev_plan_code,2 order_num from dual union
              select 'HBPR' disease_code,'7103' prev_plan_code,3 order_num from dual union
              select 'HBPR' disease_code,'7104' prev_plan_code,4 order_num from dual union
              select 'HBPR' disease_code,'7105' prev_plan_code,5 order_num from dual union
              --
              select 'DIAB' disease_code,'7201' prev_plan_code,1 order_num from dual union
              select 'DIAB' disease_code,'7202' prev_plan_code,2 order_num from dual union
              select 'DIAB' disease_code,'7203' prev_plan_code,3 order_num from dual union
              select 'DIAB' disease_code,'7204' prev_plan_code,4 order_num from dual union
              select 'DIAB' disease_code,'7205' prev_plan_code,5 order_num from dual union
              select 'DIAB' disease_code,'7206' prev_plan_code,6 order_num from dual union
              --
              select 'HCHO' disease_code,'7301' prev_plan_code,1 order_num from dual union
              select 'HCHO' disease_code,'7302' prev_plan_code,2 order_num from dual union
              select 'HCHO' disease_code,'7303' prev_plan_code,3 order_num from dual union
              select 'HCHO' disease_code,'7304' prev_plan_code,4 order_num from dual union
              select 'HCHO' disease_code,'7305' prev_plan_code,5 order_num from dual union
              select 'HCHO' disease_code,'7306' prev_plan_code,6 order_num from dual union
              --
              select 'OBES' disease_code,'7401' prev_plan_code,1 order_num from dual union
              select 'OBES' disease_code,'7402' prev_plan_code,2 order_num from dual union
              select 'OBES' disease_code,'7403' prev_plan_code,3 order_num from dual union
              select 'OBES' disease_code,'7404' prev_plan_code,4 order_num from dual union
              select 'OBES' disease_code,'7405' prev_plan_code,5 order_num from dual union
              select 'OBES' disease_code,'7406' prev_plan_code,6 order_num from dual union
              --
              select 'STRK' disease_code,'8201' prev_plan_code,1 order_num from dual union
              select 'STRK' disease_code,'8202' prev_plan_code,2 order_num from dual union
              select 'STRK' disease_code,'8203' prev_plan_code,3 order_num from dual union
              select 'STRK' disease_code,'8204' prev_plan_code,4 order_num from dual union
              select 'STRK' disease_code,'8205' prev_plan_code,5 order_num from dual union
              select 'STRK' disease_code,'8206' prev_plan_code,6 order_num from dual union
              select 'STRK' disease_code,'8207' prev_plan_code,7 order_num from dual
              )
    loop
      v_error_rec := i.disease_code||'-'||i.prev_plan_code;
      begin
        INSERT INTO disease_prev_plan (disease_prev_plan_sn
                                          ,disease_code
                                          ,prev_plan_code
                                          ,order_num
                                          )
        VALUES  (disease_prev_plan_sng.nextval
                ,i.disease_code
                ,i.prev_plan_code
                ,i.order_num
                );
      exception 
        when dup_val_on_index then
          update disease_prev_plan
          set order_num = i.order_num
          where disease_code = i.disease_code
          and prev_plan_code = i.prev_plan_code
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
  END load_disease_prev_plan;
  --
  PROCEDURE load_prev_plan
  is 
  BEGIN
    v_proc_name := upper('load_prev_plan');
    for i in (select 'HDET' prev_plan_code,'en' lang_code,'Increase Healthy Diet' short_descr,'By eating foods that are low in sodium, saturated and trans fat, eating unprocessed carbs such as vegetables, fruits and whole high fiber grains and eating adequate amount of protein. Also, eating smaller meals instead of three large meals a day can help manage hunger better.' long_descr from dual union
              select 'PMED' prev_plan_code,'en' lang_code,'Take Prescribed Medication as recommended' short_descr,null long_descr from dual union
              select 'TBCO' prev_plan_code,'en' lang_code,'Quite Smoking' short_descr,'Stopping Tobacco use can significantly reduce the risk relates to many disease.' long_descr from dual union
              select 'PACT' prev_plan_code,'en' lang_code,'Increase Physically Activity' short_descr,'By running, walking, playing tennis, lifting weight and using resistance bands. Weekly 150 minutes of moderate or 60 minutes of vigorous physical activity is recommended.' long_descr from dual union
              select 'SOCL' prev_plan_code,'en' lang_code,'Increase Social Activity' short_descr,null long_descr from dual union
              select 'ALCO' prev_plan_code,'en' lang_code,'Follow alcohol consumption recommendation' short_descr,'Doctor advise people who drink to do so in moderate amounts(e.g. up to one drink/day for women and  two drink/day for man)' long_descr from dual union
              select 'CONS' prev_plan_code,'en' lang_code,'Consult with Doctor regarding Chronic Disease(s)' short_descr,null long_descr from dual union
              select 'PSYC' prev_plan_code,'en' lang_code,'Consult with Doctor for Psychotherapy regarding your Anxiety/Depression' short_descr,null long_descr from dual union
              select 'ASPT' prev_plan_code,'en' lang_code,'Join an anxiety support group' short_descr,null long_descr from dual union
              select 'HYPC' prev_plan_code,'en' lang_code,'Manage High Blood Pressure' short_descr,'Stick to recommended management plan ' long_descr from dual union
              select 'CHOC' prev_plan_code,'en' lang_code,'Manage High Cholesterol' short_descr,'Stick to recommended management plan ' long_descr from dual union
              select 'DIAC' prev_plan_code,'en' lang_code,'Control Diabetes' short_descr,'Stick to recommended management plan ' long_descr from dual union
              select 'PHYC' prev_plan_code,'en' lang_code,'Perform Regular Physical Checkup' short_descr,'Regular (yearly) physical checkup will help early detection of any chronic disease' long_descr from dual union
              select 'WHTM' prev_plan_code,'en' lang_code,'Try keeping to a healthy weight and body shape' short_descr,null long_descr from dual union
              --self assessment
              select '1001' prev_plan_code,'en' lang_code,null short_descr,'To help you out to change your FAIR/POOR Health Self Perception and to cope with the reported activities limitation, an integrated Prevention Plan will be included into any disease or Major event at Risk related with your negative Assessment at the adequate Personalized Prevention Plan' long_descr from dual union
              --depression
              select '2001' prev_plan_code,'en' lang_code,null short_descr,'Increase your community activities and an exercise plan of 20 mins at least 3 times per day, if it’s difficult for you to do it alone invite a friend/family or just take your dog for a breezy walk every day.' long_descr from dual union
              select '2002' prev_plan_code,'en' lang_code,null short_descr,'Physician recommend a  consultation with a Psychologist or a mental health counselor or openly talk with close family or friend about possible causes of your condition for your better understanding' long_descr from dual union
              select '2003' prev_plan_code,'en' lang_code,null short_descr,'Increase your awareness of the harm that mean to your overall health if this condition stay for  longer period (6 mos. +) and became a Major Disease (MDD)' long_descr from dual union
              select '2004' prev_plan_code,'en' lang_code,null short_descr,'Keep a weekly LOG Report about your feeling and progresses, if the condition worsened  or out of your control communicate with your Physician as soon as possible' long_descr from dual union
              select '2005' prev_plan_code,'en' lang_code,null short_descr,'Try to Enjoy one day at a time , hearing music or attending  your church  or participating into any other activity that you like the most.' long_descr from dual union
              select '2006' prev_plan_code,'en' lang_code,null short_descr,'Learning breathing & meditations techniques through: online YOGA classes, community YOGA workshop, or learned yourself:  www. topics.webmed.com/ breathing, this techniques provenly will greatly help to deal with your condition.' long_descr from dual union
              select '2007' prev_plan_code,'en' lang_code,null short_descr,'Physician Face to Face Preventive EM Assessment is warranted to discuss your Chronic issues to establish an efficient Prevention Program to AVOID or Retard Major Health issues that will seriously impact your Health. If you clinically qualify your Physician may recommend a follow-up monthly Chronic Care Monitoring Remote Program(CCM)' long_descr from dual union
              select '2008' prev_plan_code,'en' lang_code,null short_descr,'WHAT YOU NEED TO KNOW ABOUT THE DEPRESSION A PSYCHOSOCIAL DISORDER. The use of meds and/or specific psychotherapeutic techniques has proven very effective in treating Depression. Having the condition for more than a year will transform the Disorder into a Mood Disorder or Major Depressive Disorder(MDD) Frequently goes unrecognized and untreated and may foster tragic consequences, such as suicide and impaired interpersonal relationships at work and at home including a major disease that may impact your wellbeing. www.cdc.gov' long_descr from dual union
              --anxiety
              select '3001' prev_plan_code,'en' lang_code,null short_descr,'Increase your community activities and an exercise plan of 20 mins at least 3 times per day, if it’s difficult for you to do it alone invite a friend/family or just take your dog for a breezy walk every day.' long_descr from dual union
              select '3002' prev_plan_code,'en' lang_code,null short_descr,'Increase your awareness of the harm that mean to your overall health if this condition stay for longer period (6 mos. +) and became a Major Disease (GAD)' long_descr from dual union
              select '3003' prev_plan_code,'en' lang_code,null short_descr,'Keep a weekly LOG Report about your feeling and progresses, if the condition worsened  or out of your control communicate with your Physician as soon as possible' long_descr from dual union
              select '3004' prev_plan_code,'en' lang_code,null short_descr,'Try to Enjoy one day at a time , hearing music or attending  your church  or participating into any other activity that you like the most.' long_descr from dual union
              select '3005' prev_plan_code,'en' lang_code,null short_descr,'Learning breathing & meditations techniques through online or community YOGA workshop, or learned yourself: www. topics.webmed.com/breathing will greatly help to deal with your condition.' long_descr from dual union
              --stress              
              select '4001' prev_plan_code,'en' lang_code,null short_descr,'Review all the identified stressor (above described) with your, physician, close family, caregiver (if is any) and or close friends you may be able to deal with your stress and find the solution to the cause or causes that are provoking the condition, this way you may release the tension that you feel about it and cope with the condition.' long_descr from dual union
              select '4002' prev_plan_code,'en' lang_code,null short_descr,'Exercising at least 3 time per week for 20 mins or go to a breezy walk with a family or friend or take your dog out for 15 mins for a walk (twice) daily.' long_descr from dual union
              select '4003' prev_plan_code,'en' lang_code,null short_descr,'Learning breathing & meditations techniques through: online YOGA classes, community YOGA workshop, or learned yourself go to www. topics.webmed.com/breathing will greatly help to deal with your stress condition.' long_descr from dual union
              select '4004' prev_plan_code,'en' lang_code,null short_descr,'Learning breathing & meditations techniques through: online YOGA classes, community YOGA workshop, or learned yourself go to www. topics.webmed.com/breathing' long_descr from dual union
              select '4005' prev_plan_code,'en' lang_code,null short_descr,'WHAT YOU NEED TO KNOW TO IDENTIFY A DEBILITATED STRESS CONDITION. Stress is your body''s reaction to the demands of the world. Stressors are events or conditions in your surroundings that may trigger stress. Your body responds to stressors differently depending on whether the stressor is new — acute stress — or whether the stressor has been around for a longer time — chronic stress. Severe acute stress can cause mental health problems, such as post-traumatic stress disorder, and even physical difficulties such as a heart attack and undermine your immune system due to a lack of sleeping or appetite suppression www.mayoclinic.org' long_descr from dual union
              --loneliness
              select '5001' prev_plan_code,'en' lang_code,null short_descr,'Referring you to a Healthcare Mental Health specialist or Social Worker to evaluate and work with your very sensitive emotional Psychosocial disorder before became harmful to your Health.' long_descr from dual union
              select '5002' prev_plan_code,'en' lang_code,null short_descr,'Learning breathing & meditations techniques through: online YOGA classes, community YOGA workshop, or learned yourself:  www. topics.webmed.com/breathing' long_descr from dual union
              select '5003' prev_plan_code,'en' lang_code,null short_descr,'Become involve into an interpersonal relations with your community, family, friends and guardian or caregiver (if is the case)' long_descr from dual union
              select '5004' prev_plan_code,'en' lang_code,null short_descr,'WHAT YOU NEED TO KNOW TO IDENTIFY A LONELINESS CONDITION. Feeling of Loneliness was associated with higher odds of having a mental health problem. Intense loneliness &Social Isolation appeared to raise the risk of death by 26%. www.nih.gov' long_descr from dual union
              --Self harm at Risk
              select '6001' prev_plan_code,'en' lang_code,null short_descr,'Your healthcare professional feels the URGENT need to discuss this sensitive issue immediately with your Health Care Professional, close family member (spouse sibling or any close family) and you, to discuss further immediate interventions.' long_descr from dual union
              --BEHAVIORAL BP
              select '7101' prev_plan_code,'en' lang_code,null short_descr,'Daily monitoring of your BP at home or at your near pharmacy (about the same time early AM and or before going bed), keep a Log of the results to establish an effective BP level and the performance of the meds Rx or the life Style changes.' long_descr from dual union
              select '7102' prev_plan_code,'en' lang_code,null short_descr,'Change your Life Style to successfully control your Blood Pressure when adopt the following recommendation a- Lose extra pounds (loss extra 10 lb.) & watch your waistline (men greater than 40 inches/Women greater than 35 inches are at HBP risk). b- Exercise regularly (30 mins breezy walk at least 3 time per week) c- Eat a Healthy diet as *DASH (*rich in grains, fruits and veggies to boost Potassium at right level &low-fat dairy, skimps on saturated fat and High Cholesterol food). Keep a log on what you daily eat to evaluate with the Physician the BP results.  d- Reduce sodium in your diet less than 2,300 mg (limit the use of table salt on your food) & 1,500mg for those with High salt sensitivity (ask your Physician if you have a High salt sensitivity).' long_descr from dual union
              select '7103' prev_plan_code,'en' lang_code,null short_descr,'Limit your alcohol consumption.' long_descr from dual union
              select '7104' prev_plan_code,'en' lang_code,null short_descr,'Do not smoke.' long_descr from dual union
              select '7105' prev_plan_code,'en' lang_code,null short_descr,'Take your BP meds as prescribed, if you miss a dose take it as soon you remember and reassume as was prescribed. In case of any undesirable side effects, talk to your Physician about it ASAP. In the event you noticed any change of your Blood Pressure level call your Physician as soon as possible' long_descr from dual union
              --BEHAVIORAL BS
              select '7201' prev_plan_code,'en' lang_code,null short_descr,'Daily monitoring of your BS at home or at your near pharmacy (postprandial and or before going bed). If you are unable to check your BS, Physician may prescribe a DSM (Diabetes Self-Management a free co-payment Medicare Preventive service' long_descr from dual union
              select '7202' prev_plan_code,'en' lang_code,null short_descr,'Keep a Log of daily results to establish the progresses or regression  of your Blood Sugar level and prove the effectiveness of the Rx meds and or the  new life Style changes adopted.' long_descr from dual union
              select '7203' prev_plan_code,'en' lang_code,null short_descr,'Change your Life Style to successfully control your Blood Sugar when adopt the following Preventative recommendation a- Lose extra pounds (loss extra 10 lb.) & watch your waistline (men greater than 40 inches/Women greater than 35 inches are at HBP risk). b- Exercise regularly (30 mins breezy walk at least 3 time per week) c- Eat a Healthy diet as *DASH (*rich in grains, fruits and veggies to boost Potassium at right level &low-fat dairy, skimps on saturated fat and High Cholesterol food). Keep a log on what you daily eat to evaluate with the Physician your optimal Blood Sugar level. d- Reduce drastically your consumption of sugar, pick low or no sugar option USDA recommended as the max amount of added sugar for a non-diabetic: 8 teaspoons per day for adult men (36 grams/140 calories) and adult women 5 teaspoons per day or (22 grams/ 90 calories per day.). e- Eliminate all sugary beverages. f- Avoid fast and processed food. World Health organization recommended limiting to less than 5% of sugar or high- Glycemic index food of your daily caloric intake.' long_descr from dual union
              select '7204' prev_plan_code,'en' lang_code,null short_descr,'Limit your alcohol consumption.' long_descr from dual union
              select '7205' prev_plan_code,'en' lang_code,null short_descr,'Do not smoke.' long_descr from dual union
              select '7206' prev_plan_code,'en' lang_code,null short_descr,'Take your Blood Sugar meds as prescribed, if you miss a dose take it as soon you remember and reassume as was prescribed. In the event you noticed significant change of your Blood Pressure level or any undesirable side effects of your prescribed meds call your Physician as soon as possible. In the event you feel weak, dizzy and confuse after your Blood sugar med was taken, call 911 immediately you may be having a danger Hypoglycemia event.' long_descr from dual union
              --Chol
              select '7301' prev_plan_code,'en' lang_code,null short_descr,'In view of your High LDL and other CVD/RF reflected in your HRA evidence clinical Outcome, a Lipid panel may be prescribed  if it was not done. Keep a Log of your Lipids labs results for a better understanding and future  control of your Lipids Level.' long_descr from dual union
              select '7302' prev_plan_code,'en' lang_code,null short_descr,'Change your Life Style to successfully maintain control of your Chol adopting the following Preventative recommendation a- Lose extra pounds (loss extra 10 lb.) & watch your waistline (men greater than 40 inches/Women greater than 35 inches are at HBP risk). b- Exercise regularly (30 mins breezy walk at least 3 time per week) c- Eat a Healthy diet as *DASH (*rich in grains, fruits and veggies to boost Potassium at right level &low-fat dairy, skimps on saturated fat and High Cholesterol food). Keep a log on what you daily eat to evaluate with the Physician your Chol level d- Reduce drastically your consumption of High Fat food, read the labels for Chol content of your daily food & pick the lowest one USDA recommended as the max amount of a 300 mg of Cholesterol content food a day. e- Avoid as possible fast and processed food.' long_descr from dual union
              select '7303' prev_plan_code,'en' lang_code,null short_descr,'Limit your alcohol consumption.' long_descr from dual union
              select '7304' prev_plan_code,'en' lang_code,null short_descr,'Do not smoke.' long_descr from dual union
              select '7305' prev_plan_code,'en' lang_code,null short_descr,'Keep control of your Blood Pressure & Normal weight  (Both RF and High LDL are  strongly related to Heart Disease and  a major Health events as Stroke)' long_descr from dual union
              select '7306' prev_plan_code,'en' lang_code,null short_descr,'Take your Chol control meds as prescribed, if you miss a dose take it as soon you remember and reassume as was prescribed. In the event you noticed any undesirable side effects from your prescribed Cholesterol meds notify your Physician as soon as possible.' long_descr from dual union
              --Obesity
              select '7401' prev_plan_code,'en' lang_code,null short_descr,'In view of your Obesity reflected in your HRA evidence clinical Outcome, a Lipid panel may be prescribed if it was not done (follow schedule). Keep a Log of your Lipids labs results for a better understanding and future control of your Lipids Level.' long_descr from dual union
              select '7402' prev_plan_code,'en' lang_code,null short_descr,'Change your Life Style to successfully maintain control of your weight adopting the following Preventative recommendation a- Lose extra pounds (loss extra 10 lb.) & watch your waistline (men greater than 40 inches/Women greater than 35 inches are at HBP risk). With the assistance of your prescribed IBT Weight Loss Counseling Program b- Exercise regularly (30 mins breezy walk at least 3 time per week) c- Eat a Healthy diet as *DASH (*rich in grains, fruits and veggies to boost Potassium at right level &low-fat dairy, skimps on saturated fat and High Cholesterol food). Maintain a log of what you eat daily close to your scale, to help you to identify the food that are causing your Obesity                           d- Reduce drastically your consumption of High Fat food, read the labels for Chol and Calories content of your daily food & pick the lowest one USDA recommended as the max amount of a 300 mg of Cholesterol content and 2,000 cal. daily consumption e- Avoid as possible fast and processed food including soft drinks and High Glycemic food because you may be at Risk of a DM.' long_descr from dual union
              select '7403' prev_plan_code,'en' lang_code,null short_descr,'Limit your alcohol consumption.' long_descr from dual union
              select '7404' prev_plan_code,'en' lang_code,null short_descr,'Do not smoke.' long_descr from dual union
              select '7405' prev_plan_code,'en' lang_code,null short_descr,'Keep control of your Blood Pressure (Both RF and High LDL are  strongly related to Heart Disease and  a major Health events as Stroke)' long_descr from dual union
              select '7406' prev_plan_code,'en' lang_code,null short_descr,'Take all meds as prescribed by your Physician, if you miss a dose take it as soon you remember and reassume as was prescribed.' long_descr from dual union
              --Tobacco
              select '7501' prev_plan_code,'en' lang_code,null short_descr,'Referring to a Smoking Cessation counseling as requested by Medicare (Free of copay) Physician may Rx some Meds proven success during the dependency withdraw specially on those cases when a Depression is present.' long_descr from dual union
              select '7502' prev_plan_code,'en' lang_code,null short_descr,'Increasing daily outdoors activities and assisting events where smoking is prohibited.' long_descr from dual union
              select '7503' prev_plan_code,'en' lang_code,null short_descr,'Change your Life Style to successfully maintain control of your weight adopting the following Preventative recommendation a- Lose extra pounds (loss extra 10 lb.) & watch your waistline (men greater than 40 inches/Women greater than 35 inches are at HBP risk).' long_descr from dual union
              select '7504' prev_plan_code,'en' lang_code,null short_descr,'Exercise regularly (30 mins breezy walk at least 3 time per week) c- Eat a Healthy diet as *DASH (*rich in grains, fruits and veggies to boost Potassium at right level &low-fat dairy, skimps on saturated fat and High Cholesterol food).' long_descr from dual union
              select '7505' prev_plan_code,'en' lang_code,null short_descr,'Reduce drastically your consumption of High Fat food, read the labels for Chol and Calories content of your daily food & pick the lowest one USDA recommended as the max amount of a 300 mg of Cholesterol content and 2,000 cal. daily consumption' long_descr from dual union
              select '7506' prev_plan_code,'en' lang_code,null short_descr,'Avoid as possible fast and processed food including soft drinks and High Glycemic food.' long_descr from dual union
              select '7507' prev_plan_code,'en' lang_code,null short_descr,'Limit your alcohol consumption.' long_descr from dual union
              select '7508' prev_plan_code,'en' lang_code,null short_descr,'Keep control of your Blood Pressure (Both RF and smoking are strongly related to Heart Disease and a major Health events as Stroke).' long_descr from dual union
              select '7509' prev_plan_code,'en' lang_code,null short_descr,'Highly recommend additional counseling as Hypnosis or Acupuncture sessions, has been proved success in dealing with dependencies' long_descr from dual union
              --Alcohol
              select '7601' prev_plan_code,'en' lang_code,null short_descr,'In view, your alcohol drinking Habits we recommend getting into in-patient or even outpatient Rehabilitation Alcohol detox center or your close community Hospital that has an Alcohol treatment program.' long_descr from dual union
              --Physical Inactivity
              select '7701' prev_plan_code,'en' lang_code,null short_descr,'Start slowly and build. Example: Start with brisk walking for a total 50 minutes per week. Any activity is better than no activity.' long_descr from dual union
              select '7702' prev_plan_code,'en' lang_code,null short_descr,'Consult with the Physician (or therapist) about Activities that fit your health status and functional capacity.' long_descr from dual union
              select '7703' prev_plan_code,'en' lang_code,null short_descr,'Start with low intensity activity if deconditioned or limited functional capacity Strength and balance may be needed before aerobic fitness in frail elderly at risk for falls or injury.' long_descr from dual union
              select '7704' prev_plan_code,'en' lang_code,null short_descr,'Water-based aerobic activity for patients limited by Osteoarthritis.' long_descr from dual union
              select '7705' prev_plan_code,'en' lang_code,null short_descr,'Activities of Daily Living (e.g. stair climbing, errands).' long_descr from dual union
              select '7706' prev_plan_code,'en' lang_code,null short_descr,'Classes (e.g. community center, YMCA).' long_descr from dual union
              select '7707' prev_plan_code,'en' lang_code,null short_descr,'Work with an experienced fitness trainer (with caution to prevent injury or overuse).' long_descr from dual union
              select '7708' prev_plan_code,'en' lang_code,null short_descr,'May use a pedometer, and increase steps by 10% every 2 weeks.' long_descr from dual union
              select '7709' prev_plan_code,'en' lang_code,null short_descr,'Increase daily walk time by 10 min each day until target time is reached.' long_descr from dual union
              select '7710' prev_plan_code,'en' lang_code,null short_descr,'Getting involved in any appropriate Employment or Volunteer work, Gardening, Shopping and housework' long_descr from dual union
              select '7711' prev_plan_code,'en' lang_code,null short_descr,'In view that Social Activities also proved reduces mortality 20% - get into Movies, Sporting recreational or travel activity and group participation as your community church..' long_descr from dual union
              select '7712' prev_plan_code,'en' lang_code,null short_descr,'Unable to increase your daily activity? Get in- touch with the nearest community group or with *Elder Helpers a non-profit organization that has the largest network of volunteers dedicated to help the elderly. *Over 10,000 volunteers are every day joining, dedicating to serving the elderly needs www.elderhelpers.org.' long_descr from dual union
              --Poor Nutrition (Diet)
              select '7801' prev_plan_code,'en' lang_code,null short_descr,'Make most of your meal vegetables and fruits – ½ of your plate' long_descr from dual union
              select '7802' prev_plan_code,'en' lang_code,null short_descr,'Go for whole grains – ¼ of your plate' long_descr from dual union
              select '7803' prev_plan_code,'en' lang_code,null short_descr,'Protein power – ¼ of your plate' long_descr from dual union
              select '7804' prev_plan_code,'en' lang_code,null short_descr,'Healthy plant oils – in moderation' long_descr from dual union
              select '7805' prev_plan_code,'en' lang_code,null short_descr,'Drink water, coffee, or tea' long_descr from dual union
              select '7806' prev_plan_code,'en' lang_code,null short_descr,'Be active' long_descr from dual union
              --Poor Drinking Water
              select '7901' prev_plan_code,'en' lang_code,null short_descr,'Drinking enough water every day is good for overall health ( amount of water in-taken  is depended on your activities ,weight, age and Health overall condition and how often you  daily eliminate through your bathrooms visits ) . As plain drinking water has zero calories, it can also help with managing body weight and reducing caloric intake when substituted for drinks with calories, like regular soda.' long_descr from dual union
              select '7902' prev_plan_code,'en' lang_code,null short_descr,'As many visits you have to the bathroom as much water you need to drink healthy fluids (5-8 glasses of water per day By The Institute of Medicine. org.)' long_descr from dual union
              --Lack of Sleep
              select '8101' prev_plan_code,'en' lang_code,null short_descr,'Avoid Caffeine, Alcohol, Nicotine, and Other Chemicals at evening that Interfere with Sleep.' long_descr from dual union
              select '8102' prev_plan_code,'en' lang_code,null short_descr,'Turn Your Bedroom into a Sleep-Inducing Environment (cool and dark)' long_descr from dual union
              select '8103' prev_plan_code,'en' lang_code,null short_descr,'Establish a Soothing Pre-Sleep Routine ( music, relaxation time)' long_descr from dual union
              select '8104' prev_plan_code,'en' lang_code,null short_descr,'Go to Sleep When You’re Truly Tired' long_descr from dual union
              select '8105' prev_plan_code,'en' lang_code,null short_descr,'Don''t Be a Nighttime Clock-Watcher' long_descr from dual union
              select '8106' prev_plan_code,'en' lang_code,null short_descr,'Use Light to Your Advantage' long_descr from dual union
              select '8107' prev_plan_code,'en' lang_code,null short_descr,'Maintain a consistent go bed and waking time' long_descr from dual union
              select '8108' prev_plan_code,'en' lang_code,null short_descr,'Nap Early—Or Not at All' long_descr from dual union
              select '8109' prev_plan_code,'en' lang_code,null short_descr,'Lighten Up on Evening Meals (Example: a pepperoni Pizza  at 10 PM will invite  the insomnia)' long_descr from dual union
              select '8110' prev_plan_code,'en' lang_code,null short_descr,'Balance Fluid Intake' long_descr from dual union
              select '8111' prev_plan_code,'en' lang_code,null short_descr,'Exercise Early' long_descr from dual union
              select '8112' prev_plan_code,'en' lang_code,null short_descr,'Follow Through this previous 11 steps and have a Good Night Sleep' long_descr from dual union
              --Stroke
              select '8201' prev_plan_code,'en' lang_code,null short_descr,'Aiming for a healthy weight' long_descr from dual union
              select '8202' prev_plan_code,'en' lang_code,null short_descr,'Heart-healthy eating' long_descr from dual union
              select '8203' prev_plan_code,'en' lang_code,null short_descr,'Managing stress' long_descr from dual union
              select '8204' prev_plan_code,'en' lang_code,null short_descr,'Physical activity' long_descr from dual union
              select '8205' prev_plan_code,'en' lang_code,null short_descr,'Quitting smoking' long_descr from dual union
              select '8206' prev_plan_code,'en' lang_code,null short_descr,'High Blood Pressure Control' long_descr from dual union
              select '8207' prev_plan_code,'en' lang_code,null short_descr,'Diabetes Control' long_descr from dual union
              --Disability
              select '8301' prev_plan_code,'en' lang_code,null short_descr,'Organize yourself properly' long_descr from dual union
              select '8302' prev_plan_code,'en' lang_code,null short_descr,'Exercise often' long_descr from dual union
              select '8303' prev_plan_code,'en' lang_code,null short_descr,'Be polite and stay calm with obnoxious people' long_descr from dual union
              select '8304' prev_plan_code,'en' lang_code,null short_descr,'Let yourself grieve and go through all five stages of grief about your disability' long_descr from dual union
              select '8305' prev_plan_code,'en' lang_code,null short_descr,'Don''t beat yourself up for it if you''re not nice to everyone' long_descr from dual union
              select '8306' prev_plan_code,'en' lang_code,null short_descr,'Don''t be surprised if people start thinking of you as brave' long_descr from dual union
              select '8307' prev_plan_code,'en' lang_code,null short_descr,'Accept your disability' long_descr from dual union
              select '8308' prev_plan_code,'en' lang_code,null short_descr,'Take advantage of what can be done' long_descr from dual union
              select '8309' prev_plan_code,'en' lang_code,null short_descr,'Seek assistance from the community of other disabled people, especially those who''ve got the same conditions you do' long_descr from dual union
              select '8310' prev_plan_code,'en' lang_code,null short_descr,'Try to overcome other prejudices' long_descr from dual union
              select '8311' prev_plan_code,'en' lang_code,null short_descr,'Get a hobby' long_descr from dual union
              select '8312' prev_plan_code,'en' lang_code,null short_descr,'Get good Internet access and a decent computer if you have the financial resources to do so' long_descr from dual union
              select '8313' prev_plan_code,'en' lang_code,null short_descr,'Remember that money isn''t the only measure of success in life' long_descr from dual union
              select '8314' prev_plan_code,'en' lang_code,null short_descr,'Do your best' long_descr from dual
              )
    loop
      v_error_rec := i.prev_plan_code;
      begin
        INSERT INTO list_prev_plan (prev_plan_code
                                    )
        VALUES (i.prev_plan_code
               );
      exception 
        when dup_val_on_index then
          NULL;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.prev_plan_code||'-'||i.lang_code;
      begin
        INSERT INTO prev_plan_lang (prev_plan_lang_sn
                                        ,prev_plan_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (prev_plan_lang_sng.nextval
                ,i.prev_plan_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update prev_plan_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where prev_plan_code = i.prev_plan_code
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
  END load_prev_plan;
  --
  PROCEDURE load_svc_rpt_type
  is 
  BEGIN
    v_proc_name := upper('load_svc_rpt_type');
    for i in (select 'HRA' svc_rpt_type_code,'AWV' prev_svc_type_code,1 order_num,'N' used_for_template_only_flag,'en' lang_code,'Patient AWV/HRA Outcome and PPP' short_descr,'Health Risk Assessment and Prevention Plan' long_descr from dual union
              select 'HQA' svc_rpt_type_code,'AWV' prev_svc_type_code,2 order_num,'N' used_for_template_only_flag,'en' lang_code,'AWV/HRA Q&A' short_descr,'AWV/HRA Questionnaire Clinical Test' long_descr from dual union
              select 'CLI' svc_rpt_type_code,'AWV' prev_svc_type_code,3 order_num,'N' used_for_template_only_flag,'en' lang_code,'Physician HRA Outcome Clinical Report' short_descr,'Clinical Report' long_descr from dual union
              select 'RMK' svc_rpt_type_code,'AWV' prev_svc_type_code,4 order_num,'N' used_for_template_only_flag,'en' lang_code,'Remarks' short_descr,'Remarks' long_descr from dual union
              select 'EEV' svc_rpt_type_code,'E/M' prev_svc_type_code,1 order_num,'N' used_for_template_only_flag,'en' lang_code,'E/M Outcome' short_descr,'Evaluation' long_descr from dual union
              select 'CEV' svc_rpt_type_code,'CCM' prev_svc_type_code,2 order_num,'N' used_for_template_only_flag,'en' lang_code,'CCM Treatment' short_descr,'Evaluation' long_descr from dual union
              select 'ESV' svc_rpt_type_code,'E/M' prev_svc_type_code,2 order_num,'Y' used_for_template_only_flag,'en' lang_code,'E/M Service Template' short_descr,'Service Template' long_descr from dual union
              select 'CSV' svc_rpt_type_code,'CCM' prev_svc_type_code,2 order_num,'Y' used_for_template_only_flag,'en' lang_code,'CCM Service Template' short_descr,'Service Template' long_descr from dual union
              select 'ORF' svc_rpt_type_code,'IBT' prev_svc_type_code,1 order_num,'Y' used_for_template_only_flag,'en' lang_code,'Patient Obesity Risk Factor JSON' short_descr,'Patient Obesity Risk Factor JSON which will be added to template and Report' long_descr from dual union
              select 'OSC' svc_rpt_type_code,'IBT' prev_svc_type_code,2 order_num,'N' used_for_template_only_flag,'en' lang_code,'Obesity Screening Outcome' short_descr,'Obesity Screening' long_descr from dual union
              select 'OEV' svc_rpt_type_code,'IBT' prev_svc_type_code,3 order_num,'N' used_for_template_only_flag,'en' lang_code,'Obesity Counseling Outcome' short_descr,'Obesity Counseling' long_descr from dual
              )
    loop
      v_error_rec := i.svc_rpt_type_code;
      begin
        INSERT INTO list_svc_rpt_type (svc_rpt_type_code
                                      ,prev_svc_type_code
                                      ,order_num
                                      ,used_for_template_only_flag
                                        )
        VALUES (i.svc_rpt_type_code
               ,i.prev_svc_type_code
               ,i.order_num
               ,i.used_for_template_only_flag
               );
      exception 
        when dup_val_on_index then
          update list_svc_rpt_type
          set prev_svc_type_code = i.prev_svc_type_code
              ,order_num = i.order_num
              ,used_for_template_only_flag = i.used_for_template_only_flag
          where svc_rpt_type_code = i.svc_rpt_type_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.svc_rpt_type_code||'-'||i.lang_code;
      begin
        INSERT INTO svc_rpt_type_lang (svc_rpt_type_lang_sn
                                        ,svc_rpt_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (svc_rpt_type_lang_sng.nextval
                ,i.svc_rpt_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update svc_rpt_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where svc_rpt_type_code = i.svc_rpt_type_code
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
  END load_svc_rpt_type;
  --
  PROCEDURE load_priviledge_type
  is 
  BEGIN
    v_proc_name := upper('load_priviledge_type');
    for i in (select 'USI' priviledge_type_code,1 order_num,'en' lang_code,'System Options' short_descr,null long_descr from dual union
              select 'RPT' priviledge_type_code,2 order_num,'en' lang_code,'Outcome Clinical Reports' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.priviledge_type_code;
      begin
        INSERT INTO list_priviledge_type (priviledge_type_code
                                         ,order_num
                                        )
        VALUES (i.priviledge_type_code
              ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_priviledge_type
          set order_num = i.order_num
          where priviledge_type_code = i.priviledge_type_code
          ;
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
              select 'IUSR' priviledge_code,1 order_num,'USI' priviledge_type_code,'en' lang_code,'Inactive User' short_descr,'inactive-user' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'DENT' priviledge_code,3 order_num,'USI' priviledge_type_code,'en' lang_code,'Company' short_descr,'physician-data-entry' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'DENB' priviledge_code,5 order_num,'USI' priviledge_type_code,'en' lang_code,'Patient' short_descr,'beneficiary-data-entry' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'PSVC' priviledge_code,6 order_num,'USI' priviledge_type_code,'en' lang_code,'Service' short_descr,'preventive-service' href,'Y' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'SCHE' priviledge_code,8 order_num,'USI' priviledge_type_code,'en' lang_code,'Appointment' short_descr,'scheduling' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'UMGM' priviledge_code,9 order_num,'USI' priviledge_type_code,'en' lang_code,'User Management' short_descr,'user-management' href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              --
              select 'RBEN' priviledge_code,7 order_num,'RPT' priviledge_type_code,'en' lang_code,'Patient Service Data' short_descr,'beneficiary-report' href,'N' client_only_priviledge_flag,'Y' common_priviledge_flag,null long_descr from dual union
              select 'REMI' priviledge_code,8 order_num,'RPT' priviledge_type_code,'en' lang_code,'E/M Information' short_descr,'beneficiary-report' href,'N' client_only_priviledge_flag,'Y' common_priviledge_flag,null long_descr from dual union
              ---==========
              select 'RANA' priviledge_code,10 order_num,'RPT' priviledge_type_code,'en' lang_code,'Analytical' short_descr,null href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'RNPI' priviledge_code,11 order_num,'RPT' priviledge_type_code,'en' lang_code,'Other Inquiry' short_descr,null href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'RPTI' priviledge_code,12 order_num,'RPT' priviledge_type_code,'en' lang_code,'Patient Inquiry' short_descr,null href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual union
              select 'RSVC' priviledge_code,13 order_num,'RPT' priviledge_type_code,'en' lang_code,'Scheduled Services' short_descr,null href,'N' client_only_priviledge_flag,'N' common_priviledge_flag,null long_descr from dual
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
              select 'IUSR' priviledge_code,'624B26BD08D20FECE0530100007F5ACE' role_id,'Inactive User' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'79F450777D2E4B6AB98FECB17974FDEB' role_id,'Service Provider/Service' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'79F450777D2E4B6AB98FECB17974FDEB' role_id,'Service Provider/Patient Service Data' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Service' short_descr,null long_descr from dual union
              select 'SCHE' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Appointment' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/Patient Service Data' short_descr,null long_descr from dual union
              select 'REMI' priviledge_code,'3951E214B3F746BD924AFF39CABEA511' role_id,'Service Provider Lead/EM Information' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'DF56C6ED00FF47AC84754BDF1517FB83' role_id,'Primary Provider/Service' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'DF56C6ED00FF47AC84754BDF1517FB83' role_id,'Primary Provider/Patient Service Data' short_descr,null long_descr from dual union
              --
              select 'DENT' priviledge_code,'22F1493D8E914982A6C5532EDBD516FE' role_id,'Data Entry/Company' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'22F1493D8E914982A6C5532EDBD516FE' role_id,'Data Entry/Patient' short_descr,null long_descr from dual union
              --
              select 'SCHE' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Appointment' short_descr,null long_descr from dual union
              select 'PSVC' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Service' short_descr,null long_descr from dual union
              select 'DENT' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Company' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Patient' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/Patient Service Data' short_descr,null long_descr from dual union
              select 'REMI' priviledge_code,'943DF69DD1744FA2BED92A55C2800C57' role_id,'Office Admin/EM Information' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Service' short_descr,null long_descr from dual union
              select 'UMGM' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/User Management' short_descr,null long_descr from dual union
              select 'RBEN' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/Patient Service Data' short_descr,null long_descr from dual union
              select 'REMI' priviledge_code,'96A384F7D6324738A4F192AD132D3B79' role_id,'Admin and Service Provider/EM Information' short_descr,null long_descr from dual union
              --
              select 'PSVC' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Service' short_descr,null long_descr from dual union
              select 'UMGM' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/User Management' short_descr,null long_descr from dual union
              select 'SCHE' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Appointment' short_descr,null long_descr from dual union
              select 'DENT' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Company' short_descr,null long_descr from dual union
              select 'DENB' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Patient' short_descr,null long_descr from dual union              
              select 'RBEN' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Patient Service Data' short_descr,null long_descr from dual union
              select 'REMI' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/EM Information' short_descr,null long_descr from dual union
              select 'RANA' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Analytical' short_descr,null long_descr from dual union
              select 'RNPI' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Other Inquiry' short_descr,null long_descr from dual union
              select 'RPTI' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Patient Inquiry' short_descr,null long_descr from dual union
              select 'RSVC' priviledge_code,'FE10783F05FB44A2AC0FD37F1E63AD76' role_id,'Super Admin/Scheduled Services' short_descr,null long_descr from dual
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
    for i in (select 'PSVC' ui_code,1 order_num,'en' lang_code,'Clinical Service' short_descr,'service-questionnaire' href,null long_descr from dual union
              --
              select 'PHYC' ui_code,6 order_num,'en' lang_code,'Company Record Create' short_descr,'physician-company-create' href,null long_descr from dual union
              select 'CEDT' ui_code,6 order_num,'en' lang_code,'Company Record Edit' short_descr,'physician-company-edit' href,null long_descr from dual union
              select 'PPHY' ui_code,7 order_num,'en' lang_code,'Physician Mgmt' short_descr,'primary-physician' href,null long_descr from dual union
              select 'SPHY' ui_code,8 order_num,'en' lang_code,'Provider Record Create' short_descr,'service-provider-create' href,null long_descr from dual union
              select 'SPRO' ui_code,8 order_num,'en' lang_code,'Provider Record Edit' short_descr,'service-provider-edit' href,null long_descr from dual union
              select 'SVCL' ui_code,9 order_num,'en' lang_code,'Location Mgmt' short_descr,'service-location' href,null long_descr from dual union
              select 'PSVL' ui_code,10 order_num,'en' lang_code,'Physician Location Assignment' short_descr,'physician-service-location' href,null long_descr from dual union
              select 'USVC' ui_code,10 order_num,'en' lang_code,'Company Exception' short_descr,'user-company-exeption' href,null long_descr from dual union
              select 'USVL' ui_code,10 order_num,'en' lang_code,'Location Exception' short_descr,'user-location-exeption' href,null long_descr from dual union
              select 'USVP' ui_code,10 order_num,'en' lang_code,'Physician Exception' short_descr,'user-physician-exeption' href,null long_descr from dual union
              select 'BENE' ui_code,11 order_num,'en' lang_code,'Patient Record Create' short_descr,'beneficiary-demographics' href,null long_descr from dual union
              select 'PEDT' ui_code,11 order_num,'en' lang_code,'Patient Record Edit' short_descr,'patient_record-edit' href,null long_descr from dual union
              --
              select 'SCHE' ui_code,12 order_num,'en' lang_code,'Schedule Service Appointment' short_descr,'service-scheduling' href,null long_descr from dual union
              --
              select 'RAMT' ui_code,1 order_num,'en' lang_code,'New User Approval' short_descr,'new-user-role-assignment' href,null long_descr from dual union
              select 'UMGM' ui_code,2 order_num,'en' lang_code,'User Record Edit' short_descr,'existing-user-management' href,null long_descr from dual union
              --
              select 'RBEN' ui_code,1 order_num,'en' lang_code,'Service Data' short_descr,'beneficiary-report' href,null long_descr from dual union
              select 'REMI' ui_code,2 order_num,'en' lang_code,'E/M Information' short_descr,'em-report' href,null long_descr from dual union
              --==========
              select 'RANA' ui_code,3 order_num,'en' lang_code,'Analytical' short_descr,null href,null long_descr from dual union
              select 'RNPI' ui_code,4 order_num,'en' lang_code,'Other Inquiry' short_descr,null href,null long_descr from dual union
              select 'RPTI' ui_code,5 order_num,'en' lang_code,'Patient Inquiry' short_descr,null href,null long_descr from dual union
              select 'RSVC' ui_code,6 order_num,'en' lang_code,'Scheduled Services' short_descr,null href,null long_descr from dual
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
    for i in (select 'PSVC' ui_code,'PSVC' priviledge_code,1 order_num,'Clinical Service' ui_descr,'Service' privledge_descr from dual union
              --
              select 'PHYC' ui_code,'DENT' priviledge_code,1 order_num,'Company Record Create' ui_descr,'Company' privledge_descr from dual union
              select 'CEDT' ui_code,'DENT' priviledge_code,2 order_num,'Company Record Edit' ui_descr,'Company' privledge_descr from dual union
              select 'SVCL' ui_code,'DENT' priviledge_code,3 order_num,'Location Mgmt' ui_descr,'Company' privledge_descr from dual union
              select 'PPHY' ui_code,'DENT' priviledge_code,4 order_num,'Physician Mgmt' ui_descr,'Company' privledge_descr from dual union
              select 'PSVL' ui_code,'DENT' priviledge_code,5 order_num,'Physician Location Assignment' ui_descr,'Company' privledge_descr from dual union
              select 'SPHY' ui_code,'DENT' priviledge_code,6 order_num,'Provider Record Create' ui_descr,'Company' privledge_descr from dual union
              select 'SPRO' ui_code,'DENT' priviledge_code,7 order_num,'Provider Record Edit' ui_descr,'Company' privledge_descr from dual union
              --
              select 'BENE' ui_code,'DENB' priviledge_code,1 order_num,'Patient Record Create' ui_descr,'Patient' privledge_descr from dual union
              select 'PEDT' ui_code,'DENB' priviledge_code,2 order_num,'Patient Record Edit' ui_descr,'Patient' privledge_descr from dual union
              --
              select 'SCHE' ui_code,'SCHE' priviledge_code,1 order_num,'Schedule Service Appointment' ui_descr,'Appointment' privledge_descr from dual union
              --
              select 'RAMT' ui_code,'UMGM' priviledge_code,1 order_num,'New User Approval' ui_descr,'User Management' privledge_descr from dual union
              select 'UMGM' ui_code,'UMGM' priviledge_code,2 order_num,'User Record Edit' ui_descr,'User Management' privledge_descr from dual union
              select 'USVC' ui_code,'UMGM' priviledge_code,3 order_num,'Company Exception' ui_descr,'User Management' privledge_descr from dual union
              select 'USVL' ui_code,'UMGM' priviledge_code,4 order_num,'Location Exception' ui_descr,'User Management' privledge_descr from dual union
              select 'USVP' ui_code,'UMGM' priviledge_code,5 order_num,'Physician Exception' ui_descr,'User Management' privledge_descr from dual union
              --Report
              select 'RBEN' ui_code,'RBEN' priviledge_code,1 order_num,'Service Data' ui_descr,'Patient Service Data' privledge_descr from dual union
              select 'REMI' ui_code,'REMI' priviledge_code,2 order_num,'E/M Information' ui_descr,'E/M Information' privledge_descr from dual union              
              select 'RANA' ui_code,'RANA' priviledge_code,3 order_num,'Analytical' ui_descr,'Analytical' privledge_descr from dual union
              select 'RNPI' ui_code,'RNPI' priviledge_code,4 order_num,'Other Inquiry' ui_descr,'Other Inquiry' privledge_descr from dual union
              select 'RPTI' ui_code,'RPTI' priviledge_code,5 order_num,'Patient Inquiry' ui_descr,'Patient Inquiry' privledge_descr from dual union
              select 'RSVC' ui_code,'RSVC' priviledge_code,6 order_num,'Scheduled Services' ui_descr,'Scheduled Services' privledge_descr from dual
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
    for i in (select '1001' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1002' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,6 SCORE_RANGE_END,'MLD' DISEASE_LEVEL_CODE,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1003' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,7 SCORE_RANGE_BEGIN,10 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1004' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,11 SCORE_RANGE_BEGIN,13 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1005' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'DEP' QUESTION_SUB_CATEG_CODE,14 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'ESV' DISEASE_LEVEL_CODE,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1006' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1007' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,4 SCORE_RANGE_BEGIN,5 SCORE_RANGE_END,'MLD' DISEASE_LEVEL_CODE,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1008' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,6 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1009' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,8 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1010' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'ANX' QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'ESV' DISEASE_LEVEL_CODE,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1011' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1012' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,8 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'MLD' DISEASE_LEVEL_CODE,'Mild' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1013' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,12 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1014' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,13 SCORE_RANGE_BEGIN,16 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              select '1015' categ_score_eval_code,'en' lang_code,'PSYSD' QUESTION_CATEG_CODE,'STR' QUESTION_SUB_CATEG_CODE,17 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'ESV' DISEASE_LEVEL_CODE,'Extremely Severe' short_descr,'Y' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1016' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1017' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1018' categ_score_eval_code,'en' lang_code,'LONLS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,6 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'High' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1024' categ_score_eval_code,'en' lang_code,'FRLTY' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1025' categ_score_eval_code,'en' lang_code,'FRLTY' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,10 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'Vulnerable' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1026' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,1 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Fully Dependent for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1027' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,2 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'Need Significant Assistance for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1028' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Need Moderate Assistance for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1029' categ_score_eval_code,'en' lang_code,'ADLBF' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Fully Independent for ADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1030' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Fully Dependent for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1031' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'Need Significant Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1032' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,6 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Need Moderate Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1033' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'FEM' QUESTION_SUB_CATEG_CODE,7 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Fully Independent for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1034' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MAL' QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Fully Dependent for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1035' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MAL' QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'Need Significant Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1036' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MAL' QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Need Moderate Assistance for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1037' categ_score_eval_code,'en' lang_code,'IADLB' QUESTION_CATEG_CODE,'MAL' QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,999 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Fully Independent for IADL' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1038' categ_score_eval_code,'en' lang_code,'HRSTS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,130 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1039' categ_score_eval_code,'en' lang_code,'HRSTS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,131 SCORE_RANGE_BEGIN,260 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1040' categ_score_eval_code,'en' lang_code,'HRSTS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,261 SCORE_RANGE_BEGIN,510 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'High' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1041' categ_score_eval_code,'en' lang_code,'HRSTS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,511 SCORE_RANGE_BEGIN,1275 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1042' categ_score_eval_code,'en' lang_code,'ANXIT' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1043' categ_score_eval_code,'en' lang_code,'ANXIT' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1044' categ_score_eval_code,'en' lang_code,'ANXIT' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,6 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'High' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1045' categ_score_eval_code,'en' lang_code,'ANXIT' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,7 SCORE_RANGE_BEGIN,8 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1046' categ_score_eval_code,'en' lang_code,'GERDS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,5 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1047' categ_score_eval_code,'en' lang_code,'GERDS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,6 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1048' categ_score_eval_code,'en' lang_code,'GERDS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,12 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'High' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1049' categ_score_eval_code,'en' lang_code,'GERDS' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,13 SCORE_RANGE_BEGIN,15 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1050' categ_score_eval_code,'en' lang_code,'DIZZI' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Normal' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1051' categ_score_eval_code,'en' lang_code,'DIZZI' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1052' categ_score_eval_code,'en' lang_code,'DIZZI' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,99 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1053' categ_score_eval_code,'en' lang_code,'HHISQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,9 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Low (no Hearing Loss)' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1054' categ_score_eval_code,'en' lang_code,'HHISQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,10 SCORE_RANGE_BEGIN,25 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1055' categ_score_eval_code,'en' lang_code,'HHISQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,26 SCORE_RANGE_BEGIN,99 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1056' categ_score_eval_code,'en' lang_code,'HOMES' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,3 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Low Fall Risk' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1057' categ_score_eval_code,'en' lang_code,'HOMES' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,4 SCORE_RANGE_BEGIN,8 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate Fall Risk' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1058' categ_score_eval_code,'en' lang_code,'HOMES' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,9 SCORE_RANGE_BEGIN,99 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe Fall Risk' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1059' categ_score_eval_code,'en' lang_code,'SLFHQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Low' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1060' categ_score_eval_code,'en' lang_code,'SLFHQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1061' categ_score_eval_code,'en' lang_code,'SLFHQ' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,99 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1062' categ_score_eval_code,'en' lang_code,'MEDCP' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,0 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'In Compliance with Rx meds taken' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1063' categ_score_eval_code,'en' lang_code,'MEDCP' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,1 SCORE_RANGE_BEGIN,1 SCORE_RANGE_END,'HIG' DISEASE_LEVEL_CODE,'Low Compliance with Rx meds taken' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1064' categ_score_eval_code,'en' lang_code,'MEDCP' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,2 SCORE_RANGE_BEGIN,99 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'No Compliance with Rx meds taken' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              --
              select '1065' categ_score_eval_code,'en' lang_code,'COGND' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,0 SCORE_RANGE_BEGIN,2 SCORE_RANGE_END,'LOW' DISEASE_LEVEL_CODE,'Low Decline' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1066' categ_score_eval_code,'en' lang_code,'COGND' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,3 SCORE_RANGE_BEGIN,4 SCORE_RANGE_END,'MOD' DISEASE_LEVEL_CODE,'Moderate Decline' short_descr,'N' trigger_further_categ_flag,null long_descr from dual union
              select '1067' categ_score_eval_code,'en' lang_code,'COGND' QUESTION_CATEG_CODE,null QUESTION_SUB_CATEG_CODE,5 SCORE_RANGE_BEGIN,7 SCORE_RANGE_END,'SEV' DISEASE_LEVEL_CODE,'Severe Decline' short_descr,'N' trigger_further_categ_flag,null long_descr from dual
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
                                      ,DISEASE_LEVEL_CODE
                                        )
        VALUES (i.categ_score_eval_code
                ,i.QUESTION_CATEG_CODE
                ,i.QUESTION_SUB_CATEG_CODE
                ,i.SCORE_RANGE_BEGIN
                ,i.SCORE_RANGE_END
                ,i.trigger_further_categ_flag
                ,i.DISEASE_LEVEL_CODE
               );
      exception 
        when dup_val_on_index then
          update categ_score_eval
          set SCORE_RANGE_END = i.SCORE_RANGE_END
             ,trigger_further_categ_flag = i.trigger_further_categ_flag
             ,DISEASE_LEVEL_CODE = i.DISEASE_LEVEL_CODE
          where QUESTION_CATEG_CODE = i.QUESTION_CATEG_CODE
          and nvl(QUESTION_SUB_CATEG_CODE,'XXX') = nvl(i.QUESTION_SUB_CATEG_CODE,'XXX')
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
  PROCEDURE load_medication_unit
  is 
  BEGIN 
    v_proc_name := upper('load_medication_unit');
    for i in (select 'MG' medication_unit_code,'en' lang_code,'milligram' short_descr,null long_descr from dual union
              select 'GM' medication_unit_code,'en' lang_code,'gram' short_descr,null long_descr from dual union
              select 'ML' medication_unit_code,'en' lang_code,'milliliter' short_descr,null long_descr from dual union
              select 'LT' medication_unit_code,'en' lang_code,'liter' short_descr,null long_descr from dual union
              select 'UT' medication_unit_code,'en' lang_code,'Units' short_descr,null long_descr from dual union
              select 'PP' medication_unit_code,'en' lang_code,'% Patch' short_descr,null long_descr from dual union
              select 'MC' medication_unit_code,'en' lang_code,'micrograms' short_descr,null long_descr from dual union
              select 'TE' medication_unit_code,'en' lang_code,'teaspoon' short_descr,null long_descr from dual union
              select 'TB' medication_unit_code,'en' lang_code,'tablespoon' short_descr,null long_descr from dual union
              select 'MN' medication_unit_code,'en' lang_code,'milliequivalents' short_descr,null long_descr from dual union
              select 'PT' medication_unit_code,'en' lang_code,'%' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.medication_unit_code;
      begin
        INSERT INTO list_medication_unit (medication_unit_code
                                        )
        VALUES (i.medication_unit_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.medication_unit_code||'-'||i.lang_code;
      begin
        INSERT INTO medication_unit_lang (medication_unit_lang_sn
                                        ,medication_unit_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (medication_unit_lang_SNG.nextval
                ,i.medication_unit_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update medication_unit_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where medication_unit_code = i.medication_unit_code
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
  END load_medication_unit;
  --
  PROCEDURE load_frequency_unit
  is 
  BEGIN
    v_proc_name := upper('load_frequency_unit');
    for i in (select '1D' frequency_unit_code,'en' lang_code,'Once a day' short_descr,null long_descr from dual union
              select '2D' frequency_unit_code,'en' lang_code,'Twice a day' short_descr,null long_descr from dual union
              select '3D' frequency_unit_code,'en' lang_code,'Three times a day' short_descr,null long_descr from dual union
              select '4D' frequency_unit_code,'en' lang_code,'Four times a day' short_descr,null long_descr from dual union
              select '5D' frequency_unit_code,'en' lang_code,'Five times a day' short_descr,null long_descr from dual union
              select '6D' frequency_unit_code,'en' lang_code,'Every six hours' short_descr,null long_descr from dual union
              select '7D' frequency_unit_code,'en' lang_code,'Every other day' short_descr,null long_descr from dual union
              select '8D' frequency_unit_code,'en' lang_code,'Before bed' short_descr,null long_descr from dual union
              select '9D' frequency_unit_code,'en' lang_code,'Before meals' short_descr,null long_descr from dual union
              select '10' frequency_unit_code,'en' lang_code,'After meals' short_descr,null long_descr from dual union
              select '11' frequency_unit_code,'en' lang_code,'As needed' short_descr,null long_descr from dual union
              select 'EW' frequency_unit_code,'en' lang_code,'Every Week' short_descr,null long_descr from dual union
              select 'EM' frequency_unit_code,'en' lang_code,'Every Month' short_descr,null long_descr from dual
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
              select 'RNU' physician_type_code,4 order_num,'en' lang_code,'Registered Nurse' short_descr,null long_descr from dual union
              select 'NUM' physician_type_code,5 order_num,'en' lang_code,'Certified Nurse Midwives' short_descr,null long_descr from dual union
              select 'NUS' physician_type_code,6 order_num,'en' lang_code,'Certified Clinical Nurse Specialist' short_descr,null long_descr from dual union
              select 'IMP' physician_type_code,7 order_num,'en' lang_code,'Independent Medical Professional (a health educator, registered dietitian, nutrition professional, or other licensed practitioner)' short_descr,null long_descr from dual union
              select 'SMP' physician_type_code,8 order_num,'en' lang_code,'Supervised Medical Professional (a health educator, registered dietitian, nutrition professional, or other licensed practitioner who are working under the direct supervision of a physician)' short_descr,null long_descr from dual
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
              select 'FEM' gender_code,2 order_num,'en' lang_code,'Female' short_descr,null long_descr from dual
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
              select 'MAL' question_sub_categ_code,'IADLB' question_categ_code,'en' lang_code,'Male' short_descr,null long_descr from dual union
              select 'FEM' question_sub_categ_code,'IADLB' question_categ_code,'en' lang_code,'Female' short_descr,null long_descr from dual
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
  PROCEDURE load_prev_svc_type 
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_type');
    for i in (select 'AWV' prev_svc_type_code from dual union
              select 'CCM' prev_svc_type_code from dual union
              select 'E/M' prev_svc_type_code from dual union
              select 'IBT' prev_svc_type_code from dual
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
  PROCEDURE load_prev_svc_type_lang
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_type_lang');
    for i in (select 'AWV' prev_svc_type_code,'en' lang_code,'Annual Wellness Visit' short_descr,null long_descr from dual union
              select 'CCM' prev_svc_type_code,'en' lang_code,'Chronic Care Management' short_descr,null long_descr from dual union
              select 'E/M' prev_svc_type_code,'en' lang_code,'Evaluation and Management (E/M) Services' short_descr,null long_descr from dual union
              select 'IBT' prev_svc_type_code,'en' lang_code,'Intensive Behavioral Therapy' short_descr,null long_descr from dual
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
    for i in (select 'G0438' prev_svc_billing_code,'AWV' prev_svc_type_code,'HCPCS' billing_type_code,1 order_num from dual union
              select 'G0439' prev_svc_billing_code,'AWV' prev_svc_type_code,'HCPCS' billing_type_code,2 order_num from dual union
              select '99490' prev_svc_billing_code,'CCM' prev_svc_type_code,'CPT' billing_type_code,6 order_num from dual union
              select '99487' prev_svc_billing_code,'CCM' prev_svc_type_code,'CPT' billing_type_code,5 order_num from dual union
              select '99202' prev_svc_billing_code,'E/M' prev_svc_type_code,'HCPCS' billing_type_code,3 order_num from dual union
              select '99212' prev_svc_billing_code,'E/M' prev_svc_type_code,'HCPCS' billing_type_code,4 order_num from dual union
              select 'G0449' prev_svc_billing_code,'IBT' prev_svc_type_code,'HCPCS' billing_type_code,7 order_num from dual union
              select 'G0447' prev_svc_billing_code,'IBT' prev_svc_type_code,'HCPCS' billing_type_code,8 order_num from dual
              )
    loop
      v_error_rec := i.prev_svc_billing_code;
      begin
        INSERT INTO list_prev_svc_billing (prev_svc_billing_code
                                          ,prev_svc_type_code
                                          ,billing_type_code
                                          ,order_num
                                          )
                                  VALUES  (i.prev_svc_billing_code
                                          ,i.prev_svc_type_code
                                          ,i.billing_type_code
                                          ,i.order_num
                                          );
      exception 
        when dup_val_on_index then
          update list_prev_svc_billing
          set order_num = i.order_num
          where prev_svc_billing_code = i.prev_svc_billing_code
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
  END load_prev_svc_billing;
  --
  PROCEDURE load_prev_svc_billing_lang
  is 
  BEGIN
    v_proc_name := upper('load_prev_svc_billing_lang');
    for i in (select 'G0438' prev_svc_billing_code,'en' lang_code,'Annual Wellness Visit, Initial' short_descr,'Annual wellness visit; includes a personalized prevention plan of service (PPPS), initial visit' long_descr from dual union
              select 'G0439' prev_svc_billing_code,'en' lang_code,'Annual Wellness Visit, Subsequent' short_descr,'Annual wellness visit, includes a personalized prevention plan of service (PPPS), subsequent visit' long_descr from dual union
              select '99490' prev_svc_billing_code,'en' lang_code,'Chronic Care Mgmt, 20 min/month' short_descr,'Chronic Care Management Service (CCM) - 20 min/month' long_descr from dual union
              select '99487' prev_svc_billing_code,'en' lang_code,'Complex Chronic Care Mgmt, 60 min/month' short_descr,'Complex Chronic Care Management Service (CCM) - 60 min/month' long_descr from dual union
              select '99202' prev_svc_billing_code,'en' lang_code,'Evaluation and Management, New Patient' short_descr,'For New Patient where HCPCS codes ranges 99201 - 99205' long_descr from dual union
              select '99212' prev_svc_billing_code,'en' lang_code,'Evaluation and Management, Existing Patient' short_descr,'For Existing Patient where  HCPCS codes ranges 99211 - 99215' long_descr from dual union
              select 'G0449' prev_svc_billing_code,'en' lang_code,'Obesity Screening, 15 min/year' short_descr,'Annual Face-To-Face Obesity Screening, 15 minutes' long_descr from dual union
              select 'G0447' prev_svc_billing_code,'en' lang_code,'Obesity Counseling, 15 min/visit' short_descr,'Face-to-Face Behavioral Counseling for Obesity, 15 minutes' long_descr from dual
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
              select 'AT1' response_code,'en' lang_code,'Needs help transferring to the toilet, cleaning self or uses bedpan or commode.' short_descr,null long_descr from dual union
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
              select 'DD1' response_code,'en' lang_code,'Don''t Do, Because of My Health' short_descr,null long_descr from dual union
              select 'DD2' response_code,'en' lang_code,'Don''t Do, But not Because of My Health' short_descr,null long_descr from dual union
              select 'Y01' response_code,'en' lang_code,'Yes and Needed to go to ER' short_descr,null long_descr from dual union
              select 'Y02' response_code,'en' lang_code,'Yes but did not need to go to ER' short_descr,null long_descr from dual union
              select 'Y03' response_code,'en' lang_code,'Yes, take medication and under control' short_descr,null long_descr from dual union
              select 'Y04' response_code,'en' lang_code,'Yes, take medication but NOT under control' short_descr,null long_descr from dual union
              select 'Y05' response_code,'en' lang_code,'Yes, but DOES NOT take medication' short_descr,null long_descr from dual union
              select 'Y06' response_code,'en' lang_code,'Yes, Currently Smoking and Plans to Quit' short_descr,null long_descr from dual union
              select 'Y07' response_code,'en' lang_code,'Yes, Currently Smoking and NO Plans to Quit' short_descr,null long_descr from dual union
              select 'Y08' response_code,'en' lang_code,'Yes, and Currently NOT Smoking' short_descr,null long_descr from dual union
              select 'Y09' response_code,'en' lang_code,'Yes, drink Heavy (more than 6 drinks per week) and Plans to Quit' short_descr,null long_descr from dual union
              select 'Y10' response_code,'en' lang_code,'Yes, drink Heavy (more than 6 drinks per week) and NO Plans to Quit' short_descr,null long_descr from dual union
              select 'Y11' response_code,'en' lang_code,'Yes, drink Moderate and Plans to Quit' short_descr,null long_descr from dual union
              select 'Y12' response_code,'en' lang_code,'Yes, drink Moderate and NO Plans to Quit' short_descr,null long_descr from dual union
              select 'N01' response_code,'en' lang_code,'No, and Sit most of the day' short_descr,null long_descr from dual union
              select 'N02' response_code,'en' lang_code,'No, but Don''t Sit most of the day' short_descr,null long_descr from dual union
              select 'SG1' response_code,'en' lang_code,'1 Surgery' short_descr,null long_descr from dual union
              select 'SG2' response_code,'en' lang_code,'2 Surgery' short_descr,null long_descr from dual union
              select 'SG9' response_code,'en' lang_code,'More than 2 Surgery' short_descr,null long_descr from dual union
              select 'LTW' response_code,'en' lang_code,'Less than a Month ago' short_descr,null long_descr from dual union
              select 'MTW' response_code,'en' lang_code,'More than a Year ago' short_descr,null long_descr from dual union
              select 'MTM' response_code,'en' lang_code,'More than a Month ago' short_descr,null long_descr from dual union
              select 'Y13' response_code,'en' lang_code,'Yes, and on Dialysis' short_descr,null long_descr from dual union
              select 'Y14' response_code,'en' lang_code,'Yes, but NOT on Dialysis' short_descr,null long_descr from dual union
              select 'NON' response_code,'en' lang_code,'None' short_descr,null long_descr from dual union
              select 'FTR' response_code,'en' lang_code,'Father' short_descr,null long_descr from dual union
              select 'MTR' response_code,'en' lang_code,'Mother' short_descr,null long_descr from dual union
              select 'SIB' response_code,'en' lang_code,'Sibling' short_descr,null long_descr from dual union
              select 'FAM' response_code,'en' lang_code,'Father & Mother' short_descr,null long_descr from dual union
              select 'FAS' response_code,'en' lang_code,'Father & Sibling' short_descr,null long_descr from dual union
              select 'MAS' response_code,'en' lang_code,'Mother & Sibling' short_descr,null long_descr from dual union
              select 'FMS' response_code,'en' lang_code,'Father, Mother & Sibling' short_descr,null long_descr from dual union
              --
              select 'HBP' response_code,'en' lang_code,'Don''t have history of Blood Pressure' short_descr,null long_descr from dual union
              select 'HCO' response_code,'en' lang_code,'Don''t have high Cholesterol?' short_descr,null long_descr from dual union
              select 'HSG' response_code,'en' lang_code,'Don''t have uncontrolled Blood Sugar' short_descr,null long_descr from dual union
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
    for i in (select '101' question_categ_grp_code,1 order_num from dual union
              select '102' question_categ_grp_code,2 order_num from dual union
              select '103' question_categ_grp_code,3 order_num from dual union
              select '104' question_categ_grp_code,4 order_num from dual union
              select '105' question_categ_grp_code,5 order_num from dual union
              select '106' question_categ_grp_code,6 order_num from dual
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
    for i in (select '101' question_categ_grp_code,'en' lang_code,'Section I(HRA-P)' short_descr,'HEALTH RISK ASSESSMENT' long_descr from dual union
              select '102' question_categ_grp_code,'en' lang_code,'Section II(AWV)' short_descr,'PATIENT HISTORY' long_descr from dual union
              select '103' question_categ_grp_code,'en' lang_code,'Section III(AWV)' short_descr,'MOOD DISORDERS' long_descr from dual union
              select '104' question_categ_grp_code,'en' lang_code,'Section IV(AWV)' short_descr,'FALL RISK FACTORS & HOME SAFETY' long_descr from dual union
              select '105' question_categ_grp_code,'en' lang_code,'Section V(AWV)' short_descr,'ADDITIONAL RISK FACTORS' long_descr from dual union
              select '106' question_categ_grp_code,'en' lang_code,'Section VI(AWV)' short_descr,'PATIENT SYMPTOM' long_descr from dual
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
    select 'BMEDH' question_categ_code,1 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PATIENT MEDICAL HISTORY' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HSLFA' question_categ_code,7 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEALTH SELF-ASSESSMENT' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HSLF2' question_categ_code,771 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Have you had any of the following limitations:' short_descr,null long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'QR' categ_condition_code,'Yes response to the question- Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks? - in Health Self Assessment Category' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'HSLFA' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'PSYSD' question_categ_code,8 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'GENERAL PSYCHO SOCIAL DISORDER TEST' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'Y' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'ANXIT' question_categ_code,8881 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'ANXIETY TEST' short_descr,'Can you say what triggers your feeling anxious?' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Anxiety in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'GERDS' question_categ_code,8882 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'DEPRESSION TEST' short_descr,'Choose the best answer for how you have felt over the past week:' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Depression in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HRSTS' question_categ_code,8883 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'STRESS TEST' short_descr,'Please identify the life events below, that has happened to you during the previous year:' long_descr,'Y' conditional_categ_flag,'Y' checkbox_only_categ_flag,'CR' categ_condition_code,'If the interviewee is identified as to have moderate to severe Stess in the Psycho Social Disorder DASS 21 test' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'PSYSD' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'SLFHQ' question_categ_code,9 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'SELF-HARM QUIZ' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'LONLS' question_categ_code,10 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'LONELINESS' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'Y' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'FRLTY' question_categ_code,1001 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FRAILTY TEST' short_descr,null long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'CR' categ_condition_code,'If the interviewee is >= 75 yrs old' categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'LONLS' parent_question_categ_code,'Y' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'FRLT1' question_categ_code,10002 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FRAILTY TEST' short_descr,'How much difficulty, on average, do you have with the following physical activities:' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'LONLS' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'FRLT2' question_categ_code,10003 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FRAILTY TEST' short_descr,'Because of your health or a physical condition, do you have any difficulty:' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,'LONLS' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'BEHVT' question_categ_code,11 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'BEHAVIORAL TEST' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'ADLBF' question_categ_code,12 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PATIENT DAILY ACTIVITY FUNCTIONALITY' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'IADLB' question_categ_code,13 order_num,'SC' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PATIENT DAILY COGNITIVE ACTIVITY FUNCTIONALITY' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'BDTEN' question_categ_code,14 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PATIENT DATA ENTRY RESPONSE' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'101'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --------------------------------
    select 'BNPMH' question_categ_code,9999999 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PAST MEDICAL HISTORY' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HSURA' question_categ_code,2 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF SURGERY/ALLERGY' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HVACN' question_categ_code,3 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF VACCINATION' short_descr,'Have you been vaccinated as per schedule for the prevention of:' long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HVART' question_categ_code,4 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HISTORY OF VARIOUS TEST' short_descr,'Have you undergone any of the following tests:' long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,'BNPMH' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'FHNMR' question_categ_code,5 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FAMILY HISTORY (FATHER, MOTHER & SIBLING)' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'102'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'P6MSC' question_categ_code,6 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'PAST 6 MONTHS SYMPTOMS CHECK' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HENMT' question_categ_code,661 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEAD, EARS, NOSE MOUTH & THROAT SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'MUSCS' question_categ_code,662 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MUSCULOSKELETAL SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'CLHTS' question_categ_code,663 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'CHEST, LUNGS AND HEART SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'NEPYS' question_categ_code,664 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'NEUROLOGICAL & PSYCHOLOGIC SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'GASTS' question_categ_code,665 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'GASTROINTESTINAL SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'SKINS' question_categ_code,666 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'SKIN RRELATED SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'OTHRS' question_categ_code,667 order_num,'NS' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'OTHER SYMPTOMS' short_descr,null long_descr,'N' conditional_categ_flag,'Y' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'106'  question_categ_grp_code,'P6MSC' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'MOODD' question_categ_code,14 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MOOD DISORDER' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'103'  question_categ_grp_code,null parent_question_categ_code,'Y' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'MOOD1' question_categ_code,141 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'Has there ever been a period of time when you were not your usual self and...' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'103'  question_categ_grp_code,'MOODD' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'FALLR' question_categ_code,15 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'FALL RISK' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'Y' trigger_further_categ_flag,'104'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HOMES' question_categ_code,16 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HOME SAFETY' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'DIZZI' question_categ_code,17 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'DIZZINESS RISK FACTOR' short_descr,'Since you felt dizziness in the morning or evening hours, please answer the following questions:' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'QR' categ_condition_code,'Yes response to the question- During morning or evening hours do you feel any dizziness? - in Fall Risk Factor and Safety Category' categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,'FALLR' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'HHISQ' question_categ_code,18 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'HEARING HANDICAP INVENTORY SCREENING QUESTIONNAIRE' short_descr,'Since you suffer from hearing loss, please answer the following questions:' long_descr,'Y' conditional_categ_flag,'N' checkbox_only_categ_flag,'QR' categ_condition_code,'Yes response to the question- Do you suffer from hearing loss? - in Fall Risk Factor and Safety Category' categ_condition_descr,'N' trigger_further_categ_flag,'104'  question_categ_grp_code,'FALLR' parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    --
    select 'COGND' question_categ_code,19 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'COGNITIVE DECLINING' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'105'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual union
    select 'MEDCP' question_categ_code,20 order_num,'RF' QUESTION_SCORE_TYPE_CODE,'en' lang_code,'MEDICATION COMPLIANCE' short_descr,null long_descr,'N' conditional_categ_flag,'N' checkbox_only_categ_flag,null categ_condition_code,null categ_condition_descr,'N' trigger_further_categ_flag,'105'  question_categ_grp_code,null parent_question_categ_code,'N' child_categ_avail_flag,'N' data_entry_categ_flag from dual
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
                                        ,data_entry_categ_flag
                                        ,checkbox_only_categ_flag
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
                                        ,i.data_entry_categ_flag
                                        ,i.checkbox_only_categ_flag
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
              ,data_entry_categ_flag = i.data_entry_categ_flag
              ,order_num = i.order_num
              ,checkbox_only_categ_flag = i.checkbox_only_categ_flag
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
              select 'G0438' PREV_SVC_BILLING_CODE, 'HSURA' question_categ_code,2 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HVACN' question_categ_code,3 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HVART' question_categ_code,4 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'FHNMR' question_categ_code,5 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HENMT' question_categ_code,6 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MUSCS' question_categ_code,7 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'CLHTS' question_categ_code,8 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'NEPYS' question_categ_code,9 order_num from dual union              
              select 'G0438' PREV_SVC_BILLING_CODE, 'GASTS' question_categ_code,10 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'SKINS' question_categ_code,11 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'OTHRS' question_categ_code,12 order_num from dual union              
              select 'G0438' PREV_SVC_BILLING_CODE, 'BEHVT' question_categ_code,13 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HSLFA' question_categ_code,14 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'PSYSD' question_categ_code,15 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'SLFHQ' question_categ_code,16 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'LONLS' question_categ_code,17 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'ADLBF' question_categ_code,18 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'IADLB' question_categ_code,19 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MOOD1' question_categ_code,20 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'FALLR' question_categ_code,21 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'HOMES' question_categ_code,22 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'COGND' question_categ_code,23 order_num from dual union
              select 'G0438' PREV_SVC_BILLING_CODE, 'MEDCP' question_categ_code,24 order_num from dual union
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'DIZZI' question_categ_code,211 order_num from dual union --Triggered from question response of FALLR
              select 'G0438' PREV_SVC_BILLING_CODE, 'HHISQ' question_categ_code,212 order_num from dual union --Triggered from question response of FALLR
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'ANXIT' question_categ_code,151 order_num from dual union --Triggered after PSYSD categ score
              select 'G0438' PREV_SVC_BILLING_CODE, 'GERDS' question_categ_code,152 order_num from dual union --Triggered after PSYSD categ score
              select 'G0438' PREV_SVC_BILLING_CODE, 'HRSTS' question_categ_code,153 order_num from dual union --Triggered after PSYSD categ score
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLTY' question_categ_code,171 order_num from dual union --Triggered if Age > 75 after LONLS
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLT1' question_categ_code,172 order_num from dual union --Triggered if Age > 75 after LONLS
              select 'G0438' PREV_SVC_BILLING_CODE, 'FRLT2' question_categ_code,173 order_num from dual union      --Triggered if Age > 75 after LONLS
              --
              select 'G0438' PREV_SVC_BILLING_CODE, 'BDTEN' question_categ_code,9999 order_num from dual union      --Patient data entry response 
              ------------------------------------------------
              select 'G0439' PREV_SVC_BILLING_CODE, 'BMEDH' question_categ_code,1 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HSURA' question_categ_code,2 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HVACN' question_categ_code,3 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HVART' question_categ_code,4 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'FHNMR' question_categ_code,5 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HENMT' question_categ_code,6 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'MUSCS' question_categ_code,7 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'CLHTS' question_categ_code,8 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'NEPYS' question_categ_code,9 order_num from dual union              
              select 'G0439' PREV_SVC_BILLING_CODE, 'GASTS' question_categ_code,10 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'SKINS' question_categ_code,11 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'OTHRS' question_categ_code,12 order_num from dual union              
              select 'G0439' PREV_SVC_BILLING_CODE, 'BEHVT' question_categ_code,13 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HSLFA' question_categ_code,14 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'PSYSD' question_categ_code,15 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'SLFHQ' question_categ_code,16 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'LONLS' question_categ_code,17 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'ADLBF' question_categ_code,18 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'IADLB' question_categ_code,19 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'MOOD1' question_categ_code,20 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'FALLR' question_categ_code,21 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'HOMES' question_categ_code,22 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'COGND' question_categ_code,23 order_num from dual union
              select 'G0439' PREV_SVC_BILLING_CODE, 'MEDCP' question_categ_code,24 order_num from dual union
              --
              select 'G0439' PREV_SVC_BILLING_CODE, 'DIZZI' question_categ_code,211 order_num from dual union --Triggered from question response of FALLR
              select 'G0439' PREV_SVC_BILLING_CODE, 'HHISQ' question_categ_code,212 order_num from dual union --Triggered from question response of FALLR
              --
              select 'G0439' PREV_SVC_BILLING_CODE, 'ANXIT' question_categ_code,151 order_num from dual union --Triggered after PSYSD categ score
              select 'G0439' PREV_SVC_BILLING_CODE, 'GERDS' question_categ_code,152 order_num from dual union --Triggered after PSYSD categ score
              select 'G0439' PREV_SVC_BILLING_CODE, 'HRSTS' question_categ_code,153 order_num from dual union --Triggered after PSYSD categ score
              select 'G0439' PREV_SVC_BILLING_CODE, 'FRLTY' question_categ_code,171 order_num from dual union --Triggered if Age > 75 after LONLS
              select 'G0439' PREV_SVC_BILLING_CODE, 'FRLT1' question_categ_code,172 order_num from dual union --Triggered if Age > 75 after LONLS
              select 'G0439' PREV_SVC_BILLING_CODE, 'FRLT2' question_categ_code,173 order_num from dual union  --Triggered if Age > 75 after LONLS
              select 'G0439' PREV_SVC_BILLING_CODE, 'BDTEN' question_categ_code,9999 order_num from dual      --Patient data entry response 
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
    elsif v_question_categ_code = 'BDTEN' then v_return := '100300';
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
    elsif v_question_categ_code = 'IADLB' then v_return := '103400';
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
    elsif v_question_categ_code = 'GASTS' then v_return := '107050';
    elsif v_question_categ_code = 'SKINS' then v_return := '107100';
    elsif v_question_categ_code = 'OTHRS' then v_return := '107150';
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
    for i in (select 'BMEDH' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Functional Disability' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Cognitive Disability' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Mental Disorder' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Disability due to Major Health Event' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union              
              select 'BMEDH' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Ischemic Heart Disease(Coronary Heart/Artery Disease)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union              
              select 'BMEDH' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Stroke (Cerebrovascular Accident -CVA)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hypertension (HBP)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Congestive Heart Failure (CHF)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Atrial Fibrillation (AF/a-fib)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union              
              select 'BMEDH' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Cancer History' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Lung Disease COPD (Emphysema)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Alzheimer' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1015' question_code,15.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Diabetes Acquired (Diabetes Mellitus -DM2)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union              
              select 'BMEDH' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Chronic Kidney Disease' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Pneumonia or Influenza' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'HIV or any Immunosuppressive Disorder' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1020' question_code,21 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Major Depression' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1025' question_code,21 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Limiting Anxiety (GAD)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1026' question_code,21 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Limiting Stress' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union              
              select 'BMEDH' question_categ_code,'1021' question_code,22 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Sleep Apnea' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1022' question_code,23 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'High Cholesterol' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1023' question_code,25 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Injury/Fall that required ER or Hospitalization' short_descr,'ER or Hospitalization due to Injury/Fall' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1024' question_code,20 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Arthritis' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1028' question_code,7.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Mini Stroke (Transient Ischemic Attack -TIA)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1029' question_code,7.2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Late effect of Stroke/TIA as Hemiparesis (weakness of one entire side of the body)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1030' question_code,7.3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Late effect of Stroke/TIA as Speech' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1031' question_code,12.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Cancer New Diagnosed' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1032' question_code,16.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'On Dialysis' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1033' question_code,20.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Rheumatoid Arthritis (RA)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1034' question_code,20.2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Fibromyalgia' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1035' question_code,20.3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Gout' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1036' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Diabetes Juvenile (Diabetes Mellitus -DM1)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1037' question_code,16.2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Chronic Liver Disease (CLD)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1038' question_code,17.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Major Blood Disorder' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BMEDH' question_categ_code,'1039' question_code,18.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Thyroid disorder (Hyperthyroidism)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'BDTEN' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have any major Health Concern today?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you know if you have a history of Blood Pressure?' short_descr,'Uncontrolled Blood Pressure' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood Sugar)?' short_descr,'Uncontrolled Blood Sugar' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you know if you have high Cholesterol?' short_descr,'Uncontrolled Cholesterol' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have any history of Smoking?' short_descr,'Smoking Habit' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you drink Alcohol?' short_descr,'Uncontrolled Alcohol Consumption' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,'Lack of uninterrupted sleeping' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1008' question_code,8 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'BMI' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you interested in losing weight?' short_descr,'Lack of interest to lose weight' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 times per week)?' short_descr,'Lack of Activities/Exercise' long_descr,'1021' parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly drink sodas or packed drinks?' short_descr,'Habit of excessive Soda' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly eat fast food?' short_descr,'Habit of excessive Fast Food Consumption' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,'Frequent consumption of high sugary content food' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,'Regular consumption of Salty Food' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly eat fresh fruits?' short_descr,'Lack of fresh fruits in daily meal' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly eat fresh vegetables?' short_descr,'Lack of fresh vegetables in daily meal' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you regularly eat grain products?' short_descr,'Lack daily consumption of grain products' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you wear seat belt at all times while riding in a car?' short_descr,'Not wearing seat belt' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you daily drink more than 6 glasses of water or any healthy fluid?' short_descr,'Not drinking enough (6-8 Glasses/day) water/healthy fluid' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,21 order_num,'Y' conditional_question_flag,'BMEDH' triggered_question_categ_code,'1023' triggered_question_code,'CBX' triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you notice any daily activity limitation due to Fall/Injury?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,22 order_num,'Y' conditional_question_flag,'BMEDH' triggered_question_categ_code,'1014' triggered_question_code,'CBX' triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you notice any declining of your cognitive skill?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,24 order_num,'Y' conditional_question_flag,'BMEDH' triggered_question_categ_code,'1020' triggered_question_code,'CBX' triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Diagnosed of Depression for more than 6 months?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLFA' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'STR' question_sub_categ_code,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'ANX' question_sub_categ_code,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,'DEP' question_sub_categ_code,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'ANXIT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Can you say what triggers your feeling anxious(Excessively worries?)' short_descr,'Excessively worries triggers your anxious feeling' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Can you say what triggers your feeling anxious(Fear of a fall?)' short_descr,'Fear of a fall triggers your anxious feeling' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Can you say what triggers your feeling anxious(Fear to die?)' short_descr,'Fear to die triggers your anxious feeling' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Can you say what triggers your feeling anxious(Don''t know?)' short_descr,'You Don''t know what triggers your anxious feeling' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,'You been concerned about or fretted over a number of things' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,'There is something going on in your life that is causing you concern' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,'You find that you have a hard time putting things out of your mind' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,'You have felt anxious for more than a year' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'SLFHQ' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you been having any thought about harming yourself?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you basically satisfied with your life?' short_descr,'You are not satisfied with your life' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,'You dropped many of your activities and interests' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel that your life is empty?' short_descr,'You feel that your life is empty' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you get bored often?' short_descr,'You often get bored' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you in a good mood most of the time?' short_descr,'You are not in a good mood most of the time' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,'You constantly worry something bad is going to happen to you' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel happy most of the time?' short_descr,'You don''t feel happy most of the time' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you often feel helpless?' short_descr,'You often feel helpless' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,'You prefer to stay at home rather than going out and doing new things' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,'You feel that you have more memory problems than most people around you' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,'You don''t think it is wonderful to be alive now' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,'You feel pretty worthless the way you are right now' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel full of energy?' short_descr,'You don''t feel full of energy' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,'You feel that your situation is hopeless' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,'You think that most people are better off than you are' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HRSTS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Death of spouse?' short_descr,'Death of spouse' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Divorce?' short_descr,'Divorce' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Marital separation?' short_descr,'Marital separation' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Death of close family member?' short_descr,'Close family member death' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Personal injury or illness?' short_descr,'Personal injury or illness' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Jail term?' short_descr,'Jail term' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Marriage?' short_descr,'Marriage' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Job loss or termination?' short_descr,'Job loss or termination' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Marital reconciliation?' short_descr,'Marital reconciliation' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Retirement?' short_descr,'Retirement' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Illness of a close family member?' short_descr,'Close family member Illness' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Sex difficulties?' short_descr,'Sex related Difficulties' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Gain of new family member?' short_descr,'New family member' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Business readjustment?' short_descr,'Business readjustment' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in financial status?' short_descr,'Financial status change' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Death of a close friend?' short_descr,'Close friend death' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Increase in the instances of arguments with spouse?' short_descr,'Arguments with spouse' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1018' question_code,18 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Difficulty to pay a Large mortgage or loan?' short_descr,'Mortgage or loan' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1019' question_code,19 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Foreclosure of mortgage or loan?' short_descr,'Foreclosure' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1020' question_code,20 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change of responsibilities at work?' short_descr,'Work Responsibility Change' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1021' question_code,21 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Son or daughter leaving home?' short_descr,'Son or daughter leaving home' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1022' question_code,22 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Trouble with in- laws?' short_descr,'Trouble with in-laws' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1023' question_code,23 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Legal problems?' short_descr,'Legal problems' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1024' question_code,24 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Spouse begin or stop working?' short_descr,'Spouse begin or stop working' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1025' question_code,25 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Revision of personal habits?' short_descr,'Revision of personal habits' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1026' question_code,26 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in living conditions?' short_descr,'Changes in living condition' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1027' question_code,27 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Trouble at work?' short_descr,'Trouble at work' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1028' question_code,28 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in works hours or conditions?' short_descr,'Works hours or condition change' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1029' question_code,29 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change of Residence?' short_descr,'Residence change' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1030' question_code,30 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in recreation?' short_descr,'Change in recreation' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1031' question_code,31 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in Church activities?' short_descr,'Change in Church activities' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1032' question_code,32 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in Social activities?' short_descr,'Change in Social activities' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1033' question_code,33 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Changes in sleeping habits?' short_descr,'Changes in sleeping habits' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1034' question_code,34 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Change in eating habits?' short_descr,'Change in eating habits' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1035' question_code,35 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Vacation?' short_descr,'Vacation' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HRSTS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you miss having people around you?' short_descr,'You miss having people around you' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'There are many people you can trust completely?' short_descr,'There are few people you can trust' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,'You are experiencing a general sense of emptiness' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'There are enough people you feel close to?' short_descr,'There are not enough people you feel close to' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel rejected often?' short_descr,'You often feel rejected' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,'When you have problems, there are few people you can rely on' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              --select 'FRLTY' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Age' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,'Health Status' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'stooping, crouching or kneeling?' short_descr,'Difficulty in Stooping, Crouching or Kneeling' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,'Difficulty in lifting, or carrying objects' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,'Difficulty in reaching or extending arms above shoulder level' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,'Difficulty in writing, or handling and grasping small objects' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'walking a quarter of a mile?' short_descr,'Difficulty in walking' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,'Difficulty in heavy housework' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,'Difficulty in shopping for personal items' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,'Difficulty in managing money' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,'Difficulty in walking across the room' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,'Difficulty in doing light housework' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'bathing or showering?' short_descr,'Difficulty in bathing or showering' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you get help with any of the above activities?' short_descr,'Need help performing daily activities' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'ADLBF' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Bathing' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Dressing' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Toileting' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Transferring' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Continence' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Feeding' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'IADLB' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Ability to Use Telephone' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Laundry' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Shopping' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Travelling' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Food Preparation' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Medication Responsibilities' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Housekeeping' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Financial Responsibilities' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,'Recent Hospitalization' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HSURA' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HVACN' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'HepB' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Influenza (Flu Vaccine)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Pneumonia (1 or 2 doses)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Herpes Zoster / Shingles' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVACN' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HVART' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Colonoscopy' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Blood Glucose' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Lipid Panel' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1004' question_code,4 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'FEM' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Mammography' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'LDCT (Low Dose of Computer Tomography)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hemocult' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'EKG' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1008' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Bone Density' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'TSH' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Eye Exam' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hearing test' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1012' question_code,12 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MAL' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Prostate Exam' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1013' question_code,13 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MAL' triggered_other_code,null question_sub_categ_code,'en' lang_code,'PSA' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1014' question_code,14 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'FEM' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Pelvic Exam' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1015' question_code,15 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MAL' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Rectal Exam' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HVART' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Parents(any) died before age of 50?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,10.1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HENMT' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Blurred or Double Vision' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Dizziness (lightheadedness)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Fever' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Headaches' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Snoring' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Rapid Involuntary Eye Movement' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Difficulty Swallowing' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Sore Throat' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'White Tongue (Ulcers)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HENMT' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'MUSCS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Low Back Pain' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Joint Pain' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Other Muscle Pain' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Muscle Weakness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Neck Pain or Tightness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Morning Stiffness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Joint Swelling' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Back Pain' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Swollen Legs' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Stiff Muscles' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Sores or Swelling of Groin' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MUSCS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'CLHTS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Wheezing, Asthma' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Shortness of Breath' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Chest Pain or Tightness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Irregular(too fast/slow, or skipping) heartbeat' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Cough With Phlegm' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Breathing Through The Mouth' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'CLHTS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'NEPYS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Anxious' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Depression' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Insomnia' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Nervousness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Tiredness (fatigue)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Trouble Thinking' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Trouble Walking, Speaking and Understanding' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Paralysis (numbness) of the face, arm or leg' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Tremor in one hand' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Loss of Balance' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Slow Movement' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Stiffness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'NEPYS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'SKINS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hives, Welts, Wafts, Moles' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SKINS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Itching' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SKINS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Clammy (Sweaty) Skin' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SKINS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Skin Rash' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'SKINS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'GASTS' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Vomiting' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Heartburn' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Indigestion' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Loss of Appetite' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Nausea' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Pain Discomfort' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Black/Tarry Stools' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'GASTS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'OTHRS' question_categ_code,'1001' question_code,1 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'FEM' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Breast lump or breast discharge' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MAL' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Lumps in the testicles' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Persistent lumps or swollen glands' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1004' question_code,4 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'FEM' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Unusual vaginal bleeding or discharge' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Night Sweat' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Hoarseness' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Blood in the urine' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Blood in the stool' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Blueness of the lips or fingernail beds' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Increased thirst and frequent urination' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Increased hunger' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Weight loss' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Binge Eating' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Pot Belly' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Recurrent Infections' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'OTHRS' question_categ_code,'1099' question_code,99 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Patient did not choose any response in this category' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'MOOD1' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble?' short_descr,'You were so hyper that you got into trouble or you were not your normal self' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were so irritable that you shouted at people or started fights or arguments?' short_descr,'You were so irritable that you shouted at people or started fights or arguments' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you felt much more self-confident than usual?' short_descr,'You felt much more self-confident than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you got much less sleep than usual and found you didn''t really miss it?' short_descr,'You got much less sleep than usual and found you didn''t really miss it' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were much more talkative or spoke much faster than usual?' short_descr,'You were much more talkative or spoke much faster than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...thoughts raced through your head or you couldn’t slow your mind down?' short_descr,'You couldn''t slow your mind down' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were so easily distracted by things around you that you had trouble concentrating or staying on track?' short_descr,'You were so easily distracted by things around you that you had trouble concentrating or staying on track' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you had much more energy than usual?' short_descr,'You had much more energy than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were much more active or did many more things than usual?' short_descr,'You were much more active or did many more things than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were much more social or outgoing than usual, for example, you telephoned friends in the middle of the night?' short_descr,'You were much more social or outgoing than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you were much more interested in sex than usual?' short_descr,'You were much more interested in sex than usual' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...you did things that were unusual for you or that other people might have thought were excessive, foolish, or risky?' short_descr,'You did things that were unusual for you or that other people might have thought were excessive, foolish, or risky' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'...spending money got you or your family into trouble?' short_descr,'Spending money got you or your family into trouble' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1014' question_code,14 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1015' question_code,15 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'How much of a problem did any of these cause you – like being unable to work; having family, money or legal troubles; getting into arguments or fights?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1016' question_code,16 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MOOD1' question_categ_code,'1017' question_code,17 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FALLR' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,'Fall' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,'Dizziness (morning or evening)' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you suffer from hearing loss?' short_descr,'Hearing loss' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,'Afraid to walk distances or at night' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you believe you have any balance problem?' short_descr,'Balance Problem' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,'Poor Vision' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'DIZZI' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,'Looking up aggravates balance problem' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,'Dizziness problem causing difficulty getting in or out of bed' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you afraid to leave home without having someone accompanying due to of your dizziness?' short_descr,'Afraid to leave home without having someone accompanying due to the dizziness' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,11 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,'Quick movements of head aggravates the Dizziness problem' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,12 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,13 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does bending make you dizzier?' short_descr,'Bending makes you dizzier' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,'Hearing problem causes embarrassment when meeting new people' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,'Hearing problem causes frustration when talking to family members' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,'Having difficulty hearing / understanding co-workers, clients or customers' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,'Feel handicapped by a hearing problem' long_descr,'1005' parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,'Hearing problem causes difficulty when visiting friends, relatives or neighbors' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,'Hearing problem causes difficulty in the movies or in the theater' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,'Hearing problem causes to have arguments with family members' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,'Hearing problem causes difficulty when listening to TV or radio' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,'Feels that any difficulty with hearing limits or hampers personal or social life' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,10 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,'Hearing problem causes difficulty when in a restaurant with relatives or friends' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'HOMES' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,'Stairs without rails' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,'Walking space to bathroom is not clear' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,'Dark or Poor lit in hallways, entrance or stairwells' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,'Totally dark bedroom while sleeping' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,'Unsafe stairs or broken/worn steps at home' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,'Slippery kitchen or bathroom floor' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,'Home Phones are not in easy access' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,8 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose?' short_descr,'Keep pets inside of the house at all times without taking outside for elimination purpose' long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,9 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,'Needs to keep emergency alert device or cell phone always' long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'COGND' question_categ_code,'1001' question_code,1 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,2 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,3 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,5 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,6 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,7 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Noticed Patient slow pace while approached for Interview (Answered by INTERVIEWER ONLY)' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'MEDCP' question_categ_code,'1001' question_code,1 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MDC' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you take your Meds as Dr prescribed?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1002' question_code,2 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MDC' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you feel the Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,3 order_num,'Y' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,'MDC' triggered_other_code,null question_sub_categ_code,'en' lang_code,'Any undesirable side effect of the Prescribed Meds?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,4 order_num,'N' conditional_question_flag,null triggered_question_categ_code,null triggered_question_code,null triggered_response_code,null triggered_other_code,null question_sub_categ_code,'en' lang_code,'Do you take supplements?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual
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
                                ,triggered_question_categ_code
                                ,triggered_question_code
                                ,triggered_other_code
                                )
                        VALUES (QUESTION_SNG.nextval
                                ,i.QUESTION_CATEG_CODE
                                ,i.QUESTION_CODE
                                ,i.question_sub_categ_code
                                ,i.ORDER_NUM
                                ,i.CONDITIONAL_QUESTION_FLAG
                                ,v_parent_question_sn
                                ,i.triggered_response_code
                                ,i.triggered_question_categ_code
                                ,i.triggered_question_code
                                ,i.triggered_other_code
                                );
        exception 
          when dup_val_on_index then
            update question
            set ORDER_NUM = i.ORDER_NUM
                ,CONDITIONAL_QUESTION_FLAG = i.CONDITIONAL_QUESTION_FLAG
                ,PARENT_QUESTION_SN = v_parent_question_sn
                ,question_sub_categ_code = i.question_sub_categ_code
                ,triggered_response_code = i.triggered_response_code
                ,triggered_question_categ_code = i.triggered_question_categ_code
                ,triggered_question_code = i.triggered_question_code
                ,triggered_other_code = i.triggered_other_code
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
  PROCEDURE load_question_response (p_ins_upd_ind in varchar2)
  is
    v_question_sn question.question_sn%type;
    v_question_response_code question_response.question_response_code%type;
    v_question_categ_code list_question_categ.question_categ_code%type := '99999';
  BEGIN
    v_proc_name := upper('load_question_response');
    for i in (select 'BMEDH' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,'FDEC' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,'CDEC' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,'SCHI' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,'CHDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,'STRK' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,'HBPR' disease_code,null symptom_code,'HBPR' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,'CHDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,'CHDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,'CNCR' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,'COPD' disease_code,null symptom_code,'COPD' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,'ALZH' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,'DIAB' disease_code,null symptom_code,'DIAB' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1016' question_code,1 order_num,'CBX' response_code,'CKDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1017' question_code,1 order_num,'CBX' response_code,'PNEU' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1018' question_code,1 order_num,'CBX' response_code,'AIDS' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1019' question_code,1 order_num,'CBX' response_code,'PARK' disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1020' question_code,1 order_num,'CBX' response_code,'DEPR' disease_code,null symptom_code,'DEPR' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1025' question_code,1 order_num,'CBX' response_code,'ANXT' disease_code,null symptom_code,'ANXT' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1026' question_code,1 order_num,'CBX' response_code,'STRS' disease_code,null symptom_code,'STRS' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              select 'BMEDH' question_categ_code,'1021' question_code,1 order_num,'CBX' response_code,'SAPN' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1022' question_code,1 order_num,'CBX' response_code,'HCHO' disease_code,null symptom_code,'HCHO' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1023' question_code,1 order_num,'CBX' response_code,'FALL' disease_code,null symptom_code,'HOSP' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1024' question_code,1 order_num,'CBX' response_code,'ARTH' disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1028' question_code,1 order_num,'CBX' response_code,'STRK' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Mini Stroke (Transient Ischemic Attack -TIA)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1029' question_code,1 order_num,'CBX' response_code,'STRK' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Late effect of Stroke/TIA as Hemiparesis (weakness of one entire side of the body)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1030' question_code,1 order_num,'CBX' response_code,'STRK' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Late effect of Stroke/TIA as Speech' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1031' question_code,1 order_num,'CBX' response_code,'CNCR' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Cancer New Diagnosed' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1032' question_code,1 order_num,'CBX' response_code,'CKDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'On Dialysis' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1033' question_code,1 order_num,'CBX' response_code,'ARTH' disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Rheumatoid Arthritis (RA)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1034' question_code,1 order_num,'CBX' response_code,'ARTH' disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fibromyalgia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1035' question_code,1 order_num,'CBX' response_code,'ARTH' disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gout' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1036' question_code,1 order_num,'CBX' response_code,'DIAB' disease_code,null symptom_code,'DIAB' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes Juvenile (Diabetes Mellitus -DM1)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1037' question_code,1 order_num,'CBX' response_code,'CLDE' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Liver Disease (CLD)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1038' question_code,1 order_num,'CBX' response_code,'BDIS' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Major Blood Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BMEDH' question_categ_code,'1039' question_code,1 order_num,'CBX' response_code,'TDIS' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Thyroid deficiency' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BMEDH' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any disability?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              ---=============================BDTEN
              select 'BDTEN' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any major Health concern today?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BDTEN' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any major Health concern today?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++Surgery Hx
              select 'HSURA' question_categ_code,'1001' question_code,1 order_num,'SG1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1001' question_code,2 order_num,'SG2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1001' question_code,3 order_num,'SG9' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1001' question_code,4 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any past surgeries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1002' question_code,1 order_num,'LTW' response_code,null disease_code,null symptom_code,'HOSP' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1002' question_code,3 order_num,'MTW' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1002' question_code,2 order_num,'MTM' response_code,null disease_code,null symptom_code,'HOSP' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1002' question_code,4 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been Hospitalized during the past two years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from any medication allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSURA' question_categ_code,'1004' question_code,1 order_num,'Y03' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1004' question_code,2 order_num,'Y04' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1004' question_code,3 order_num,'Y05' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSURA' question_categ_code,'1004' question_code,4 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have food allergies?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++ Vaccination Hx
              select 'HVACN' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100204' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'HepB (3 doses. Needed for adults who didn''t get these vaccines when they were children)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100202' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Influenza (Get a flu vaccine every year)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100203' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pneumonia (1 or 2 doses). There are two different types of pneumococcal vaccines. Talk with your healthcare professional to find out if one or both pneumococcal vaccines are recommended for you.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100208' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Herpes Zoster / Shingles (1 dose. You should get the zoster vaccine even if you''ve had shingles before.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVACN' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Herpes Zoster / Shingles (1 dose. You should get the zoster vaccine even if you''ve had shingles before.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++Other Test Hx
              select 'HVART' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100105' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colonoscopy (Screening should start at 50 and continue until age 75. Flexible sigmoidoscopy (5y), Screening colonoscopy (10y) & Barium enema.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100002' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Blood Glucose tests, Example: FBS, A1C (A blood glucose test is recommended by the American Diabetes Association every three years. However, other tests (glucose tol. test and fasting blood sugar)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100005' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Lipid Panel (Once every five years in adults ages 20 and over.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100103' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Mammography Annually (female age 40 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100113' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'LDCT' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100007' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hemocult (Screening should start at 50 and continue until age 75. Fecal occult blood test (annual)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100109' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'EKG (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100003' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Bone Density (Age 65 & older, biennial)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100104' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'DM Management (At discretion of clinician)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100107' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Eye Exam (Adults aged 19 to 64 should have an eye exam at least every two years)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100110' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hearing test (Have one at least once in your adult life)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100108' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Prostate Exam Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100004' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'PSA Test Annually (age 50 or over)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100111' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pelvic Exam (Annually)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,'100418' em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Rectal Exam (Annually)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HVART' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pelvic Exam (Annually)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++Family Hx
              select 'FHNMR' question_categ_code,'1001' question_code,1 order_num,'NON' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,1 order_num,'NON' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,1 order_num,'NON' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,1 order_num,'NON' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,1 order_num,'NON' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,1 order_num,'NON' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,1 order_num,'NON' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,1 order_num,'NON' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,1 order_num,'NON' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,1 order_num,'NON' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,1 order_num,'NON' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,1 order_num,'NON' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,1 order_num,'NON' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,1 order_num,'NON' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,1 order_num,'NON' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,2 order_num,'FTR' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,2 order_num,'FTR' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,2 order_num,'FTR' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,2 order_num,'FTR' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,2 order_num,'FTR' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,2 order_num,'FTR' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,2 order_num,'FTR' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,2 order_num,'FTR' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,2 order_num,'FTR' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,2 order_num,'FTR' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,2 order_num,'FTR' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,2 order_num,'FTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,2 order_num,'FTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,2 order_num,'FTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,2 order_num,'FTR' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,3 order_num,'MTR' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,3 order_num,'MTR' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,3 order_num,'MTR' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,3 order_num,'MTR' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,3 order_num,'MTR' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,3 order_num,'MTR' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,3 order_num,'MTR' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,3 order_num,'MTR' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,3 order_num,'MTR' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,3 order_num,'MTR' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,3 order_num,'MTR' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,3 order_num,'MTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,3 order_num,'MTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,3 order_num,'MTR' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,3 order_num,'MTR' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,4 order_num,'SIB' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,4 order_num,'SIB' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,4 order_num,'SIB' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,4 order_num,'SIB' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,4 order_num,'SIB' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,4 order_num,'SIB' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,4 order_num,'SIB' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,4 order_num,'SIB' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,4 order_num,'SIB' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,4 order_num,'SIB' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              select 'FHNMR' question_categ_code,'1011' question_code,4 order_num,'SIB' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,4 order_num,'SIB' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,4 order_num,'SIB' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,4 order_num,'SIB' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,4 order_num,'SIB' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,5 order_num,'FAM' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,5 order_num,'FAM' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,5 order_num,'FAM' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,5 order_num,'FAM' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,5 order_num,'FAM' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,5 order_num,'FAM' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,5 order_num,'FAM' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,5 order_num,'FAM' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,5 order_num,'FAM' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,5 order_num,'FAM' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,5 order_num,'FAM' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,5 order_num,'FAM' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,5 order_num,'FAM' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,5 order_num,'FAM' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,5 order_num,'FAM' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,6 order_num,'FAS' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,6 order_num,'FAS' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,6 order_num,'FAS' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,6 order_num,'FAS' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,6 order_num,'FAS' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,6 order_num,'FAS' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,6 order_num,'FAS' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,6 order_num,'FAS' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,6 order_num,'FAS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,6 order_num,'FAS' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,6 order_num,'FAS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,6 order_num,'FAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,6 order_num,'FAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,6 order_num,'FAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,6 order_num,'FAS' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,7 order_num,'MAS' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,7 order_num,'MAS' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,7 order_num,'MAS' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,7 order_num,'MAS' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,7 order_num,'MAS' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,7 order_num,'MAS' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,7 order_num,'MAS' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,7 order_num,'MAS' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,7 order_num,'MAS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,7 order_num,'MAS' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,7 order_num,'MAS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,7 order_num,'MAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,7 order_num,'MAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,7 order_num,'MAS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1015' question_code,7 order_num,'MAS' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FHNMR' question_categ_code,'1001' question_code,8 order_num,'FMS' response_code,'DIAB' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Diabetes' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1002' question_code,8 order_num,'FMS' response_code,'COPD' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chronic Lung Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1003' question_code,8 order_num,'FMS' response_code,'HBPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hypertension' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1004' question_code,8 order_num,'FMS' response_code,'CHDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heart Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1005' question_code,8 order_num,'FMS' response_code,'STRK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Stroke/CVA' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1006' question_code,8 order_num,'FMS' response_code,'CKDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Kidney Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1007' question_code,8 order_num,'FMS' response_code,'CLDE' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Disease' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1008' question_code,8 order_num,'FMS' response_code,'DEPR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression or Bipolar Disorder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1009' question_code,8 order_num,'FMS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Obesity' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1010' question_code,8 order_num,'FMS' response_code,'PARK' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Parkinson' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1011' question_code,8 order_num,'FMS' response_code,'OBES' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alcoholism' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1012' question_code,8 order_num,'FMS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Colon/Rectal/Prostate/Lung Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1013' question_code,8 order_num,'FMS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Breast Cancer or any other type of Cancer' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FHNMR' question_categ_code,'1014' question_code,8 order_num,'FMS' response_code,'CNCR' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Any of your parents die before 50 yrs. of age?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              select 'FHNMR' question_categ_code,'1015' question_code,8 order_num,'FMS' response_code,'ALZH' disease_code,null symptom_code,'FMHX' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++Symptom start
              select 'HENMT' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'BVSN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Blurred Vision' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'DIZI' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Ringing of Ears' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'FEVR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hearing Difficulties' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'HEAD' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Mouth Sores' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'SNOR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Loss or Change in Taste' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'RIEM' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Headaches' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'DSWA' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dizziness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,'STHR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dizziness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,'ULCR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dizziness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HENMT' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fever' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MUSCS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'LBPN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Joint Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'JPAN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Joint Swelling' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'MPAN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Low Back Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'MWEK' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Other Muscle Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'NPAN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Neck Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'STFF' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Muscle Weakness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'SWEL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,'BPAN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,'SLEG' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null disease_code,'SMSL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null disease_code,'SGRN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MUSCS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'AM Stiffness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'CLHTS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'WHAS' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Chest Pain' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'BRTH' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Shortness of Breath' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'COGH' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Wheezing, Asthma' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'CPAN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Irregular Heart rhythmic' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'IHRY' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'CPGM' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'BMTH' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'CLHTS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'NEPYS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'ANXS' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Depression' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'DPRN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Insomnia' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'FRGT' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Nervousness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'INSM' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Tiredness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'NRVS' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Anxious' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'TIRD' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble Thinking' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'TTNK' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,'TWSU' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,'PFAL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null disease_code,'TRMR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null disease_code,'LBAL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null disease_code,'SMVN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null disease_code,'SNSS' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'NEPYS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Forgetfulness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'SKINS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'HWWM' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Skin Related symptoms' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SKINS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'ITCH' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Easy Bruising' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SKINS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'CSKN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hives, Welts, wafts, moles' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SKINS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'SRSH' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Hives, Welts, wafts, moles' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SKINS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Rash' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
             --
              select 'GASTS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'VOMT' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Loss of Appetite' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'HBRN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Nausea' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'IDGS' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heartburn' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'LAPP' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Indigestion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'NUSA' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Belching' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'PDCM' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Pain discomfort' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'STOL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Liver Problems' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GASTS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'OTHRS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,'BLMP' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,'TLMP' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,'PLMP' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,'VBLD' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,'SWAT' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,'HOAR' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,'BURN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,'BSTL' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,'BLPF' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null disease_code,'FURN' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null disease_code,'HUNG' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null disease_code,'LSWT' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null disease_code,'BEAT' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null disease_code,'PBLY' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,null disease_code,'RINF' symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'OTHRS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'BLK/Tarry Stools' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++Symptom end
              --++++++++++++++++++Behavioral Test
              select 'BEHVT' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              select 'BEHVT' question_categ_code,'1001' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you or your physician recently checked your Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              --
              select 'BEHVT' question_categ_code,'1002' question_code,1 order_num,'Y03' response_code,'HBPR' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,2 order_num,'Y04' response_code,'HBPR' disease_code,null symptom_code,'HBPR' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,3 order_num,'Y05' response_code,'HBPR' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,4 order_num,'HBP' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1002' question_code,5 order_num,'IDK' response_code,null disease_code,null symptom_code,'HBPR' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have history of Blood Pressure?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1003' question_code,1 order_num,'Y03' response_code,'DIAB' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,2 order_num,'Y04' response_code,'DIAB' disease_code,null symptom_code,'DIAB' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,3 order_num,'Y05' response_code,'DIAB' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,4 order_num,'HSG' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1003' question_code,5 order_num,'IDK' response_code,null disease_code,null symptom_code,'DIAB' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you know if you have Diabetes (uncontrolled Blood sugar)?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1004' question_code,1 order_num,'Y03' response_code,'HCHO' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,2 order_num,'Y04' response_code,'HCHO' disease_code,null symptom_code,'HCHO' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,3 order_num,'Y05' response_code,'HCHO' disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,4 order_num,'HCO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1004' question_code,5 order_num,'IDK' response_code,null disease_code,null symptom_code,'HCHO' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you recently check your Cholesterol?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1005' question_code,1 order_num,'Y06' response_code,null disease_code,null symptom_code,'TBCO' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,2 order_num,'Y07' response_code,null disease_code,null symptom_code,'TBCO' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,3 order_num,'Y08' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1005' question_code,4 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'during these past 15 years did you had any history of smoking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              --
              select 'BEHVT' question_categ_code,'1006' question_code,1 order_num,'Y09' response_code,null disease_code,null symptom_code,'ALCO' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,2 order_num,'Y10' response_code,null disease_code,null symptom_code,'ALCO' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,3 order_num,'Y11' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,4 order_num,'Y12' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1006' question_code,5 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently drink alcohol drinks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'SLEP' risk_factor_code,'SEV' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you sleep uninterrupted 6 hours or more?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union              
              select 'BEHVT' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'WEIT' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you interested in losing weight?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union              
              --
              select 'BEHVT' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,2 order_num,'N01' response_code,null disease_code,null symptom_code,'INAC' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1009' question_code,3 order_num,'N02' response_code,null disease_code,null symptom_code,'INAC' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you exercise regularly (at least 20 minutes 3 time per week)?' short_descr,null long_descr,'1021' parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'DTDR' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink sodas or packed drinks regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'DTFF' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fast food regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'DTSG' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1012' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high refined sugar content foods?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'DTST' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1013' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly consume high salt content food?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1014' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'DTFR' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you regularly eat fresh fruits regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union              
              --
              select 'BEHVT' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1015' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'DTVG' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat fresh vegetables regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1016' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'DTGR' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1016' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you eat grain products regularly?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1017' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1017' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drive?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1018' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'SFTY' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1018' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,'SFTY' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you wear seat belt at all times white riding in a car?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1019' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,'WATR' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1019' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1021' question_code,1 order_num,'YES' response_code,'FALL' disease_code,null symptom_code,'FALL' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1021' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1022' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'CDEC' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1022' question_code,3 order_num,'IDK' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'BEHVT' question_categ_code,'1024' question_code,1 order_num,'YES' response_code,'DEPR' disease_code,null symptom_code,'DEPR' risk_factor_code,'HIG' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'BEHVT' question_categ_code,'1024' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you drink more than 6 glasses of water daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++1
              select 'HSLFA' question_categ_code,'1001' question_code,1 order_num,'POR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,2 order_num,'FIR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,3 order_num,'GOD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,4 order_num,'VGD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1001' question_code,5 order_num,'EXC' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'How you would say your health is in general?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1002' question_code,1 order_num,'LFM' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,2 order_num,'LFY' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1002' question_code,3 order_num,'ALW' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'For how long your Health has been like this?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLFA' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'STRS' risk_factor_code,'MOD' disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'HSLF2' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HSLFA' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have your daily activities been limited due to anxiety, depression, stress, loneliness this past wks?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              --
              select 'HSLF2' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to complete any of your daily activities?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you find yourself being careless lately in performing your essential daily tasks?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by feeling down/depressed or hopeless?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During past month have you often been bothered by little interest doing things you usually enjoy?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              select 'HSLF2' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'During the past month have you had limitations at engaging in social activities as going out or visiting friends?' short_descr,null long_descr,'1003' parent_question_code,'RSP' query_type from dual union
              --===================================
              select 'PSYSD' question_categ_code,'1001' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,1 order_num,'NVR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,3 order_num,'OFT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'PSYSD' question_categ_code,'1001' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you found it hard to wind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1002' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of dryness of your mouth?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1003' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'I couldn''t seem to experience any positive feeling?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1004' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced breathing difficulty i.e. Excessively rapid breathing, breathlessness in absence of exertion' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1005' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you lost the initiative or desire to do things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1006' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself over-reacting to situations?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1007' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you experienced trembling for no apparent reason i.e. hands?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1008' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you were using a lot of nervous energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1009' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been worrying about situations in which you might panic and make a fool of yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1010' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that you have nothing to look forward to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1011' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find yourself getting agitated often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1012' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find it difficult to relax?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1013' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling down-hearted and blue?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1014' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been showing intolerance of anything that keeps you from getting on with what you are doing?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1015' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling close to panic?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1016' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you unable to become enthusiastic about anything?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1017' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling that you are not worth much as a person?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1018' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been rather touchy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1019' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you suddenly become aware of your heartbeat in the absence of physical exertion? i.e. Heart pounding' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1020' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt scared without any good reason?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'PSYSD' question_categ_code,'1021' question_code,4 order_num,'AAL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,3 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt that life was meaningless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'ANXIT' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Excessively worries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear of a fall?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear to die?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Don''t know?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'ANXIT' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Excessively worries?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear of a fall?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Fear to die?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Don''t know?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been concerned about or fretted over a number of things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is there anything going on in your life that is causing you concern?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you find that you have a hard time putting things out of your mind?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ANXIT' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you feel anxious for more than a year?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'SLFHQ' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been having any thought about harming yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'SLFHQ' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you frequently think about dying?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been having any thought about harming yourself?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'SLFHQ' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to died?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you basically satisfied with your life?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your life is empty?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get bored often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you in a good mood most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel happy most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you often feel helpless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel full of energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'GERDS' question_categ_code,'1001' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you basically satisfied with your life?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1002' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you dropped many of your activities and interests?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1003' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your life is empty?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1004' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get bored often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1005' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you in a good mood most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1006' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you constantly worry something bad is going to happen to you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1007' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel happy most of the time?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1008' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you often feel helpless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1009' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you prefer to stay at home rather than going out and doing new things?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1010' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that you have more memory problems than most people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1011' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think it is wonderful to be alive now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1012' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel pretty worthless the way you are right now?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1013' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel full of energy?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1014' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel that your situation is hopeless?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'GERDS' question_categ_code,'1015' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think that most people are better off than you are?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HRSTS' question_categ_code,'1001' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,100 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of spouse?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1002' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,73 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Divorce?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1003' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,65 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marital separation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1004' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,63 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of close family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1005' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,53 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Personal injury or illness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1006' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,50 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Jail term?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1007' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,50 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marriage?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1008' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,47 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Job loss or termination?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1009' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,45 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Marital reconciliation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1010' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,45 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Retirement?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1011' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,44 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Illness of a close family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1012' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Sex difficulties?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1013' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gain of new family member?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1014' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,39 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Business readjustment?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1015' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,38 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in financial status?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1016' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,37 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Death of a close friend?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1017' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,35 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Increase in the instances of arguments with spouse?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1018' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,31 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Difficulty to pay a Large mortgage or loan?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1019' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,30 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Foreclosure of mortgage or loan?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1020' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change of responsibilities at work?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1021' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Son or daughter leaving home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1022' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,29 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble with in- laws?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1023' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,28 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Legal problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1024' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,26 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Spouse begin or stop working?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1025' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,24 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Revision of personal habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1026' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,24 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in living conditions?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1027' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,23 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Trouble at work?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1028' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,20 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in works hours or conditions?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1029' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,20 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change of Residence?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1030' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,19 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in recreation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1031' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,19 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in Church activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1032' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,18 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in Social activities?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1033' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,16 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Changes in sleeping habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1034' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,15 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Change in eating habits?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1035' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,13 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Vacation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HRSTS' question_categ_code,'1099' question_code,1 order_num,'CBX' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Vacation?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'LONLS' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,2 order_num,'MOL' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'LONLS' question_categ_code,'1001' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you miss having people around you?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1002' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are many people you can trust completely?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1003' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing a general sense of emptiness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1004' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'There are enough people you feel close to?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1005' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel rejected often?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'LONLS' question_categ_code,'1006' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have plenty of people you can rely on when you have problems?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'FRLTY' question_categ_code,'1001' question_code,1 order_num,'POR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,2 order_num,'FIR' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,3 order_num,'GOD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,4 order_num,'VGD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FRLTY' question_categ_code,'1001' question_code,5 order_num,'EXC' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'In general, compared to other people your age, would you say that your health is:' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --+++++++++++++++++++
              select 'FRLT1' question_categ_code,'1001' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,1 order_num,'NDI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,2 order_num,'ALD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,3 order_num,'SMD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,4 order_num,'ATD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT1' question_categ_code,'1001' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'stooping, crouching or kneeling?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1002' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'lifting, or carrying objects as heavy as 10 pounds? ' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1003' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'reaching or extending arms above shoulder level?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1004' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'writing, or handling and grasping small objects?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1005' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking a quarter of a mile?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT1' question_categ_code,'1006' question_code,5 order_num,'UTD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'heavy housework such as scrubbing floors or washing windows?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --+++++++++++++++++++++
              select 'FRLT2' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,3 order_num,'DD1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1001' question_code,4 order_num,'DD2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'shopping for personal items (like toilet items or medicines)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,3 order_num,'DD1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1002' question_code,4 order_num,'DD2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'managing money (like keeping track of expenses or paying bills)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,3 order_num,'DD1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1003' question_code,4 order_num,'DD2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'walking across the room? USE OF CANE OR WALKER IS OK' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,3 order_num,'DD1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1004' question_code,4 order_num,'DD2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'doing light housework (like washing dishes, straightening up, or light cleaning)?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,3 order_num,'DD1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'Y' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1005' question_code,4 order_num,'DD2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'bathing or showering?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --
              select 'FRLT2' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get help with any of the above activities?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              select 'FRLT2' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you get help with any of the above activities?' short_descr,null long_descr,null parent_question_code,'QTN' query_type from dual union
              --++++++++++++++++++
              select 'ADLBF' question_categ_code,'1001' question_code,1 order_num,'ABI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Bathes self completely (with exception of needs help in bathing only a single part of the body such as the back, genital area or disabled extremity)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1001' question_code,2 order_num,'ABD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Need help with bathing (more than one part of the body, getting in or out of the tub or shower) or requires total bathing' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,1 order_num,'ADI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Get clothes from closets and drawers and puts on clothes and outer garments complete with fasteners (may have help tying shoes)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1002' question_code,2 order_num,'ADD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help with dressing self or needs to be completely dressed.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,1 order_num,'ATI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Goes to toilet, gets on and off, arranges clothes, cleans genital area without help.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1003' question_code,2 order_num,'AT1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help transferring to the toilet, cleaning self or uses bedpan or commode.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,1 order_num,'ARI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Moves in and out of bed or chair unassisted (mechanical transfer aids are acceptable)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1004' question_code,2 order_num,'ARD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help in moving from bed to chair or requires a complete transfer.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,1 order_num,'ACI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Exercises complete self-control over urination and defecation.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1005' question_code,2 order_num,'ACD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is partially or totally incontinent of bowel or bladder' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,1 order_num,'AFI' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Gets food from plate into mouth without help (preparation of food may be done by another person)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'ADLBF' question_categ_code,'1006' question_code,2 order_num,'AFD' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs partial or total help with feeding or requires parenteral feeding.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1001' question_code,1 order_num,'IT1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Operates telephone on own initiative (looks up and dials numbers, etc.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,2 order_num,'IT2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Dials a few well-known numbers' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,3 order_num,'IT3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Answers telephone but does not dial' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1001' question_code,4 order_num,'IT4' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not use telephone at all' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1002' question_code,1 order_num,'IL1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does personal laundry completely' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,2 order_num,'IL2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Launders small items (rinses stockings, etc.)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1002' question_code,3 order_num,'IL3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'All laundry must be done by others' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1003' question_code,1 order_num,'IS1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Takes care of all shopping needs independently' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,2 order_num,'IS2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Shops independently for small purchases' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,3 order_num,'IS3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs to be accompanied on any shopping trip' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1003' question_code,4 order_num,'IS4' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Completely unable to shop' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1004' question_code,1 order_num,'IR1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travels independently on public transportation or drives own car' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,2 order_num,'IR2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Arranges own travel via taxi, but does not otherwise use public transportation' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,3 order_num,'IR3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travels on public transportation when accompanied by another' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,4 order_num,'IR4' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Travel limited to taxi or automobile with assistance of another' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1004' question_code,5 order_num,'IR5' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not travel at all' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1005' question_code,1 order_num,'IF1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Plans, prepares and serves adequate meals independently' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,2 order_num,'IF2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Prepares adequate meals if supplied with ingredients' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,3 order_num,'IF3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Heats, serves and prepares meals, or prepares meals, or prepares meals but does not maintain adequate diet' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1005' question_code,4 order_num,'IF4' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs to have meals prepared and served' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1006' question_code,1 order_num,'IM1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is responsible for taking medication in correct dosages at correct time' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,2 order_num,'IM2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Takes responsibility if medication is prepared in advance in separate dosage' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1006' question_code,3 order_num,'IM3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is not capable of dispensing own medication' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1007' question_code,1 order_num,'IH1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Maintains house alone or with occasional assistance (e.g. "heavy work domestic help")' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,2 order_num,'IH2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Performs light daily tasks such as dish washing, bed making' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,3 order_num,'IH3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Performs light daily tasks but cannot maintain acceptable level of cleanliness' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,4 order_num,'IH4' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Needs help with all home maintenance tasks' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1007' question_code,5 order_num,'IH5' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does not participate in any housekeeping tasks' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'IADLB' question_categ_code,'1008' question_code,1 order_num,'II1' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Manages financial matters independently (budgets, writes checks, pays rent, bills, goes to bank), collects and keeps track of income' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,2 order_num,'II2' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Manages day-to- day purchases, but needs help with banking, major purchases, etc.' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'IADLB' question_categ_code,'1008' question_code,3 order_num,'II3' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Incapable of handling money' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MOOD1' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you so irritable that you shouted at people or started fights or arguments?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you felt more confident than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you gotten a lot less sleep than usual and found you didn&#39;t really miss it?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more talkative than usual or spoken a tot faster?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been experiencing racing thoughts for prolonged hours and have not been able to slow your mind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you gotten easily distracted or absent minded lately affecting your ability to complete tasks or cause you to make dangerous mistakes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more energetic than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more uninhibited than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been more social or outgoing than usual, Example: You telephoned friends in the middle of the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been feeling compulsive desire to have sex?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been doing things that are unusual for you or that other people thought were excessive, foolish, or risky?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'..you been on a shopping spree spending an excessive amount of money that got you or your family into trouble?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1014' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1016' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1017' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'MOOD1' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt so good or so hyper that other people thought you were not your normal self or you were so hyper that you got into trouble' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Were you so irritable that you shouted at people or started fights or arguments?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you felt more confident than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you gotten a lot less sleep than usual and found you didn&#39;t really miss it?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more talkative than usual or spoken a tot faster?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been experiencing racing thoughts for prolonged hours and have not been able to slow your mind down?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you gotten easily distracted or absent minded lately affecting your ability to complete tasks or cause you to make dangerous mistakes?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more energetic than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more uninhibited than usual?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been more social or outgoing than usual, Example: You telephoned friends in the middle of the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been feeling compulsive desire to have sex?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been doing things that are unusual for you or that other people thought were excessive, foolish, or risky?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you been on a shopping spree spending an excessive amount of money that got you or your family into trouble?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1014' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'If you check yes, to more than one of the above, have several of these ever happened during the same time period?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1016' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have any of your blood relatives, children, siblings, parents, grandparents, aunts, uncles, had manic-depressive illness or bipolar disorders?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1017' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'MOOD1' question_categ_code,'1015' question_code,1 order_num,'NOP' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1015' question_code,2 order_num,'MIP' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1015' question_code,3 order_num,'MOP' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MOOD1' question_categ_code,'1015' question_code,4 order_num,'SEP' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have these characteristics cause you problems in your life? - Example: Being unable to find work or keep a job; having a family, financial or legal troubles; getting arrested?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'FALLR' question_categ_code,'1001' question_code,1 order_num,'Y01' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1001' question_code,2 order_num,'Y02' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1001' question_code,3 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Did you had a fall this past 2 years?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'FALLR' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'DIZZI' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'Y' trigger_further_categ_flag,'HHISQ' triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from hearing loss?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you believe you have any balance problem?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --              
              select 'FALLR' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'During morning or evening hours do you feel any dizziness?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from hearing loss?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you afraid to walk: distances, or during the night?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you believe you have any balance problem?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'FALLR' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you suffer from cataract or have poor vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'DIZZI' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,'Looking up aggravates balance problem' long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,'Dizziness problem causing difficulty getting in or out of bed' long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you afraid to leave home w/o having someone accompanying due to of your dizziness?' short_descr,'Afraid to leave home without having someone accompanying due to the dizziness' long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,'Quick movements of head aggravates the Dizziness problem' long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does bending make you dizzier?' short_descr,'Bending makes you dizzier' long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              --
              select 'DIZZI' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does looking up aggravate your balance problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel frustrated due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Have you restricted your travel due to this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you able to tolerate walking through the aisles of a supermarket?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty getting in or out of bed?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does your problem significantly restrict your participation in social activities?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Is this problem causing you difficulty reading?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do performing more taxing activities like sports, dancing, house chores such as sweeping or putting dishes away aggravate your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you afraid to leave home w/o having someone accompanying due to of your dizziness?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1010' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Are you embarrassed of having this problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1011' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do quick movements of your head aggravate your problems?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1012' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you avoid heights due to your problem?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              select 'DIZZI' question_categ_code,'1013' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does bending make you dizzier?' short_descr,null long_descr,'1004' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HHISQ' question_categ_code,'1001' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,1 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,2 order_num,'SMT' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --
              select 'HHISQ' question_categ_code,'1001' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel embarrassed when you meet new people' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1002' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to feel frustrated when talking to members of your family' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1003' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you have difficulty hearing / understanding co-workers, clients or customers?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1004' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel handicapped by a hearing problem?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1005' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when visiting friends, relatives or neighbors' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1006' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty in the movies or in the theater?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1007' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you to have arguments with family members?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1008' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when listening to TV or radio?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1009' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Do you feel that any difficulty with your hearing limits or hampers your personal or social life' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              select 'HHISQ' question_categ_code,'1010' question_code,3 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,4 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'Y' conditional_question_flag,'en' lang_code,'Does a hearing problem cause you difficulty when in a restaurant with relatives or friends?' short_descr,null long_descr,'1005' parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'HOMES' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose??' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'HOMES' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have inside stairs or steps at the entrance of your house without rails?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a walking space to the bathroom clear of furniture and small rugs?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are your hallways, house entrance or stairwells dark or poorly lit?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Is your bedroom totally dark when you are sleeping?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have unsafe stairs or broken/worn steps at home?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Does your kitchen or bathroom floor get easily slippery when wet?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,2 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have a phone in more than one room and easy to reach?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1008' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you keep your pets inside of the house at all times without taking them outside for elimination purpose??' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'HOMES' question_categ_code,'1009' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you think you need any kind of emergency alert device or a cell phone to keep with you at all times?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'COGND' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,'MEDI' risk_factor_code,'HIG' disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Was the clinician or interviewer able to notice the Patient slow pace while was approached to assist to the AWV interview' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'COGND' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Are you aware of what is today''s date? (please confirm if the answer is correct)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you recall the day, month and year of your birthday? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you take 3 or more prescribed medications daily?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you or those around you noticed a change in your vision?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1005' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you consider that you have poor memory?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1006' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Can you provide me your home address? (please compare against the one in the file)' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'COGND' question_categ_code,'1007' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Was the clinician or interviewer able to notice the Patient slow pace while was approached to assist to the AWV interview' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --++++++++++++++++++
              select 'MEDCP' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1002' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              --
              select 'MEDCP' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1002' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,1 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1003' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you feel; this Prescribed Meds are resolving your Health issues?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
              select 'MEDCP' question_categ_code,'1004' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,0 score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Have you noticed any undesirable side effect that you believe is caused by any of the Meds taking?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual
              --
              order by question_categ_code,question_code,order_num
              )
    loop
      v_error_rec := i.question_categ_code||'-'||i.question_code||'-'||i.response_code;
      v_question_sn := list_trans_pkg.qtn_sn(i.question_categ_code,i.question_code);
      --
      if p_ins_upd_ind = 'I' then
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
                                        ,disease_code
                                        ,symptom_code
                                        ,risk_factor_code
                                        ,disease_level_code
                                        ,em_name_code
                                        )
                                  VALUES(v_question_response_code
                                        ,v_question_sn
                                        ,i.RESPONSE_CODE
                                        ,i.SCORE_VALUE
                                        ,i.order_num
                                        ,i.trigger_further_question_flag
                                        ,i.trigger_further_categ_flag
                                        ,i.triggered_question_categ_code
                                        ,i.disease_code
                                        ,i.symptom_code
                                        ,i.risk_factor_code
                                        ,i.disease_level_code
                                        ,i.em_name_code
                                        );
        exception 
          when others then
            v_err_msg := SUBSTR (SQLERRM,1,1000);
            common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
        end;
      elsif p_ins_upd_ind = 'U' then --Update only
        update question_response
        set score_value = i.score_value
            ,order_num = i.order_num
            ,trigger_further_question_flag = i.trigger_further_question_flag
            ,trigger_further_categ_flag = i.trigger_further_categ_flag
            ,triggered_question_categ_code = i.triggered_question_categ_code
            ,disease_code = i.disease_code
            ,symptom_code = i.symptom_code
            ,risk_factor_code = i.risk_factor_code
            ,disease_level_code = i.disease_level_code
            ,em_name_code = i.em_name_code
        where QUESTION_SN = v_QUESTION_SN
        and RESPONSE_CODE = i.RESPONSE_CODE
        ;
      end if;                                        
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END load_question_response;
  --
  PROCEDURE load_disease_type
  is 
  BEGIN
    v_proc_name := upper('load_disease_type');
    for i in (select 'EVNT' disease_type_code,'en' lang_code,'Event' short_descr,null long_descr from dual union
              select 'DISO' disease_type_code,'en' lang_code,'Disorder' short_descr,null long_descr from dual union
              select 'COND' disease_type_code,'en' lang_code,'Condition' short_descr,null long_descr from dual union
              select 'COMP' disease_type_code,'en' lang_code,'Compliance' short_descr,null long_descr from dual union
              select 'DISE' disease_type_code,'en' lang_code,'Disease' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.disease_type_code;
      begin
        INSERT INTO list_disease_type (disease_type_code
                                        )
        VALUES (i.disease_type_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.disease_type_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_type_lang (disease_type_lang_sn
                                        ,disease_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_type_lang_SNG.nextval
                ,i.disease_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_type_code = i.disease_type_code
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
  END load_disease_type;
  --
  PROCEDURE load_disease_categ
  is 
  BEGIN
    v_proc_name := upper('load_disease_categ');
    for i in (select 'CVDE' disease_categ_code,'en' lang_code,'Cardiovascular Disease' short_descr,'Heart conditions that include diseased vessels, structural problems, and blood clots.' long_descr from dual union
              select 'HEVN' disease_categ_code,'en' lang_code,'Heart Event' short_descr,'Heart Event that includes attack in heart' long_descr from dual union
              select 'BEVN' disease_categ_code,'en' lang_code,'Brain Event' short_descr,'Brain Event that includes attack in brain' long_descr from dual union
              select 'HCND' disease_categ_code,'en' lang_code,'Heart Condition' short_descr,'Heart Condition like changes of blood pressure' long_descr from dual union
              select 'BDWT' disease_categ_code,'en' lang_code,'Excessive Body Weight' short_descr,'Overweight or Obesity increase the risk of having heart disease, strokes, diabetes, cancer, and depression.' long_descr from dual union
              select 'ACON' disease_categ_code,'en' lang_code,'Excessive Alcohol Consumption' short_descr,'Excessive Alcohol Consumption.' long_descr from dual union
              select 'CNCR' disease_categ_code,'en' lang_code,'Cancer' short_descr,'A disease in which abnormal cells divide uncontrollably and destroy body tissue.' long_descr from dual union
              select 'META' disease_categ_code,'en' lang_code,'Metabolic Disorder' short_descr,'Metabolic Disorder is characterized by high blood sugar, insulin resistance, and relative lack of insulin.' long_descr from dual union
              select 'BLOD' disease_categ_code,'en' lang_code,'Blood Disorder' short_descr,'A blood cell disorder is a condition in which there''s a problem with red/white cells, or the smaller circulating cells called platelets, which are critical for clot formation. All three cell types form in the bone marrow.' long_descr from dual union
              select 'THRD' disease_categ_code,'en' lang_code,'Thyroid Disease' short_descr,'Any dysfunction of the butterfly-shaped gland at the base of the neck (thyroid).' long_descr from dual union
              select 'CHOL' disease_categ_code,'en' lang_code,'High amounts of cholesterol in the blood.' short_descr,'HDL is the Good and LDL is the Bad Cholesterol' long_descr from dual union
              select 'KDNY' disease_categ_code,'en' lang_code,'Kidney Disease' short_descr,'Kidney conditions that the kidneys are damaged and can''t filter blood like they should.' long_descr from dual union
              select 'LUNG' disease_categ_code,'en' lang_code,'Lung Disease' short_descr,'A group of disorders that cause progressive scarring of lung tissue.' long_descr from dual union
              select 'LIVR' disease_categ_code,'en' lang_code,'Liver Disease' short_descr,'Any condition that damages the liver and prevents it from functioning well. Most common types are Nonalcoholic fatty liver disease, Hepatitis C/B/A, Alcoholic hepatitis etc.' long_descr from dual union
              select 'COMP' disease_categ_code,'en' lang_code,'Compliance' short_descr,'Compliance to follow doctor advise' long_descr from dual union
              select 'JOIN' disease_categ_code,'en' lang_code,'Joint Disease' short_descr,'Joint disorders are caused by diseases and injuries' long_descr from dual union
              select 'MHDR' disease_categ_code,'en' lang_code,'Mental Health Disorder' short_descr,'Condition exhibiting one or more of the characteristics (Depression, Anxiety or Stress) over a long period of time and to a marked degree adversely affects personal and social activities' long_descr from dual union
              select 'IMMU' disease_categ_code,'en' lang_code,'Immune System' short_descr,'Network of cells, tissues, and organs that work together to protect the body.' long_descr from dual union
              select 'SLEP' disease_categ_code,'en' lang_code,'Sleep Disorder' short_descr,'Changes in sleeping patterns or habits that can negatively affect health.' long_descr from dual union
              select 'PMCN' disease_categ_code,'en' lang_code,'Physical and Mental Condition' short_descr,'Conditions involving Frailty, Fracture, Functional and Cognitive Decline' long_descr from dual
              )
    loop
      v_error_rec := i.disease_categ_code;
      begin
        INSERT INTO list_disease_categ (disease_categ_code
                                        )
        VALUES (i.disease_categ_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.disease_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_categ_lang (disease_categ_lang_sn
                                        ,disease_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_categ_lang_SNG.nextval
                ,i.disease_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_categ_code = i.disease_categ_code
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
  END load_disease_categ;
  --
  PROCEDURE load_disease
  is 
  BEGIN
    v_proc_name := upper('load_disease');
    for i in (select 'STRK' disease_code,'BEVN' disease_categ_code,'EVNT' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Stroke (Cerebrovascular Accident -CVA)' short_descr,'Damage to the brain from interruption of its blood supply.' long_descr from dual union
              select 'HBPR' disease_code,'HCND' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Hypertension (HBP)' short_descr,'The more blood heart pumps and the narrower the arteries, the higher the blood pressure' long_descr from dual union
              select 'CHDE' disease_code,'CVDE' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Ischemic Heart Disease(Coronary Heart/Artery Disease)' short_descr,'Coronary heart disease(CHD) is a common term for the buildup of plaque in the heart’s arteries that could lead to heart attack. This is also called as coronary artery disease (CAD)' long_descr from dual union              
              select 'BDIS' disease_code,'BLOD' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Blood Disorder' short_descr,'Common blood disorders include anemia, bleeding disorders such as hemophilia, blood clots, and blood cancers such as leukemia, lymphoma, and myeloma.' long_descr from dual union
              select 'TDIS' disease_code,'THRD' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Thyroid disorder (Hyperthyroidism)' short_descr,'The overproduction of a hormone by the butterfly-shaped gland in the neck (thyroid).' long_descr from dual union
              --
              select 'OBES' disease_code,'BDWT' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Obesity' short_descr,'A disorder involving excessive body fat that increases the risk of health problems.' long_descr from dual union
              select 'ALCO' disease_code,'ACON' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Alcoholism' short_descr,'A chronic disease characterized by uncontrolled drinking and preoccupation with alcohol.' long_descr from dual union
              select 'HCHO' disease_code,'CHOL' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'High Cholesterol' short_descr,'High amounts of cholesterol(waxy, fat-like substance that''s found in all cells of the body) in the blood.' long_descr from dual union
              --
              select 'CNCR' disease_code,'CNCR' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Cancer' short_descr,'Rather than any specific cancer disease, general cancer diagnosis has been established here.' long_descr from dual union
              select 'MCMP' disease_code,'COMP' disease_categ_code,'COMP' disease_type_code,'N' trigger_ccm_flag,'MEDCP' question_categ_code,'en' lang_code,'Medication Compliance' short_descr,'To evaluate if Patient is talking the medicine as prescribed by the doctor' long_descr from dual union
              select 'SFTY' disease_code,'COMP' disease_categ_code,'COMP' disease_type_code,'N' trigger_ccm_flag,'BEHVT' question_categ_code,'en' lang_code,'Safety' short_descr,'To evaluate if Patient is talking all the necessary safety measures in daily activities (e.g. seat belt)' long_descr from dual union
              select 'ARTH' disease_code,'JOIN' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Arthritis' short_descr,'Inflammation of one or more joints, causing pain and stiffness that can worsen with age.' long_descr from dual union
              select 'CKDE' disease_code,'KDNY' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Chronic Kidney Disease' short_descr,'Longstanding disease of the kidneys leading to renal failure.' long_descr from dual union
              select 'CLDE' disease_code,'LIVR' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Chronic Liver Disease' short_descr,'Refers to disease of the liver which lasts over a period of six months.' long_descr from dual union
              select 'COPD' disease_code,'LUNG' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Chronic Obstructive Pulmonary Disease(COPD)' short_descr,'A group of lung diseases that block airflow and make it difficult to breathe' long_descr from dual union
              select 'PNEU' disease_code,'LUNG' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Pneumonia' short_descr,'Infection that inflames air sacs in one or both lungs, which may fill with fluid.' long_descr from dual union
              select 'DIAB' disease_code,'META' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Diabetes (Diabetes Mellitus -DM)' short_descr,'A group of diseases that result in too much sugar in the blood (high blood glucose).' long_descr from dual union
              --
              select 'DEPR' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'GERDS' question_categ_code,'en' lang_code,'Depression' short_descr,'A mental health disorder characterized by persistently depressed mood or loss of interest in activities, causing significant impairment in daily life.' long_descr from dual union
              select 'ALZH' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'COGND' question_categ_code,'en' lang_code,'Alzheimer''s Disease and Dementia' short_descr,'Alzheimer is a progressive disease that destroys memory and other important mental functions and Dementia is a group of thinking and social symptoms that interferes with daily functioning.' long_descr from dual union
              select 'SCHI' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'N' trigger_ccm_flag,'MOOD1' question_categ_code,'en' lang_code,'Schizophrenia' short_descr,'A disorder that affects a person''s ability to think, feel, and behave clearly.' long_descr from dual union
              select 'SUIC' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'N' trigger_ccm_flag,'SLFHQ' question_categ_code,'en' lang_code,'Suicidal Thought' short_descr,'Suicidal thoughts, also known as suicidal ideation, are thoughts about how to kill oneself' long_descr from dual union
              select 'ANXT' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'ANXIT' question_categ_code,'en' lang_code,'Anxiety' short_descr,'A mental health disorder characterized by feelings of worry, anxiety, or fear that are strong enough to interfere with one''s daily activities' long_descr from dual union
              select 'STRS' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'HRSTS' question_categ_code,'en' lang_code,'Stress' short_descr,'Acute Stress Disorder is characterized by the development of severe anxiety, dissociative, and other symptoms that occurs within one month after exposure to an extreme traumatic stressor (e.g., witnessing a death or serious accident).' long_descr from dual union
              select 'PARK' disease_code,'MHDR' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'COGND' question_categ_code,'en' lang_code,'Parkinson' short_descr,'A disorder of the central nervous system that affects movement, often including tremors.' long_descr from dual union
              --
              select 'AIDS' disease_code,'IMMU' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'HIV/AIDS' short_descr,'HIV causes AIDS and interferes with the body''s ability to fight infections.' long_descr from dual union
              select 'SAPN' disease_code,'SLEP' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Sleep Apnea' short_descr,'A potentially serious sleep disorder in which breathing repeatedly stops and starts.' long_descr from dual union
              --
              select 'FRLT' disease_code,'PMCN' disease_categ_code,'EVNT' disease_type_code,'Y' trigger_ccm_flag,'FRLTY' question_categ_code,'en' lang_code,'Frailty Health' short_descr,'The condition of being weak and delicate.' long_descr from dual union
              select 'FRTR' disease_code,'PMCN' disease_categ_code,'COND' disease_type_code,'Y' trigger_ccm_flag,'FALLR' question_categ_code,'en' lang_code,'Fracture' short_descr,'A fracture is a partial or complete break in the bone.' long_descr from dual union
              select 'FDEC' disease_code,'PMCN' disease_categ_code,'EVNT' disease_type_code,'Y' trigger_ccm_flag,'ADLBF' question_categ_code,'en' lang_code,'Functional Decline' short_descr,'The decrement in physical and/or cognitive functioning and occurs when a person is unable to engage in activities of daily living' long_descr from dual union
              select 'CDEC' disease_code,'PMCN' disease_categ_code,'EVNT' disease_type_code,'Y' trigger_ccm_flag,'IADLB' question_categ_code,'en' lang_code,'Cognitive Decline' short_descr,'Noticeable and measurable decline in cognitive abilities' long_descr from dual union
              select 'LONL' disease_code,'PMCN' disease_categ_code,'DISO' disease_type_code,'Y' trigger_ccm_flag,'LONLS' question_categ_code,'en' lang_code,'Loneliness' short_descr,'Complex and usually unpleasant response to emotional/social isolation.' long_descr from dual union
              select 'FALL' disease_code,'PMCN' disease_categ_code,'EVNT' disease_type_code,'Y' trigger_ccm_flag,'FALLR' question_categ_code,'en' lang_code,'Fall Risk' short_descr,'Falls don''t "just happen," and people don''t fall because they get older. Often, more than one underlying cause or risk factor is involved in a fall. ... As the number of risk factors rises, so does the risk of falling.' long_descr from dual union
              select 'DIZI' disease_code,'PMCN' disease_categ_code,'COND' disease_type_code,'N' trigger_ccm_flag,'DIZZI' question_categ_code,'en' lang_code,'Dizziness' short_descr,'Dizziness is more common among older adults. A fear of dizziness can cause older adults to limit their physical and social activities. Dizziness can also lead to falls and other injuries.' long_descr from dual union
              select 'HEAR' disease_code,'PMCN' disease_categ_code,'COND' disease_type_code,'N' trigger_ccm_flag,'HHISQ' question_categ_code,'en' lang_code,'Hearing Loss' short_descr,'Total or significant loss of hearing.' long_descr from dual union
              select 'HOME' disease_code,'PMCN' disease_categ_code,'COND' disease_type_code,'N' trigger_ccm_flag,'HOMES' question_categ_code,'en' lang_code,'Home Lack of Safety' short_descr,'Home Safety ... Poor lighting -- inside and outdoors -- can increase the risk of falls.' long_descr from dual
              )
    loop
      v_error_rec := i.disease_code;
      begin
        INSERT INTO list_disease (disease_code
                                 ,disease_categ_code
                                 ,disease_type_code
                                 ,trigger_ccm_flag
                                 ,question_categ_code
                                 )
        VALUES (i.disease_code
               ,i.disease_categ_code
               ,i.disease_type_code
               ,i.trigger_ccm_flag
               ,i.question_categ_code
               );
      exception 
        when dup_val_on_index then
          update list_disease
          set disease_categ_code = i.disease_categ_code
            ,disease_type_code = i.disease_type_code
            ,trigger_ccm_flag = i.trigger_ccm_flag
            ,question_categ_code = i.question_categ_code
          where disease_code = i.disease_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.disease_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_lang (disease_lang_sn
                                        ,disease_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_lang_SNG.nextval
                ,i.disease_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_code = i.disease_code
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
  END load_disease;
  --
  PROCEDURE load_risk_factor_categ
  is 
  BEGIN
    v_proc_name := upper('load_risk_factor_categ');
    for i in (select 'MOD' risk_factor_categ_code,'en' lang_code,'Modifiable' short_descr,null long_descr,'N' diet_categ_flag from dual union
              select 'NMD' risk_factor_categ_code,'en' lang_code,'Non-modifiable' short_descr,null long_descr,'N' diet_categ_flag from dual union
              select 'DHM' risk_factor_categ_code,'en' lang_code,'Diet Home' short_descr,null long_descr,'Y' diet_categ_flag from dual union
              select 'DAW' risk_factor_categ_code,'en' lang_code,'Diet Away' short_descr,null long_descr,'Y' diet_categ_flag from dual union
              select 'DOT' risk_factor_categ_code,'en' lang_code,'Diet Other' short_descr,null long_descr,'Y' diet_categ_flag from dual              
              )
    loop
      v_error_rec := i.risk_factor_categ_code;
      begin
        INSERT INTO list_risk_factor_categ (risk_factor_categ_code
                                            ,diet_categ_flag
                                 )
        VALUES (i.risk_factor_categ_code
                ,i.diet_categ_flag
               );
      exception 
        when dup_val_on_index then
          update list_risk_factor_categ
          set diet_categ_flag = i.diet_categ_flag
          where risk_factor_categ_code = i.risk_factor_categ_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.risk_factor_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO risk_factor_categ_lang (risk_factor_categ_lang_sn
                                        ,risk_factor_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (risk_factor_categ_lang_SNG.nextval
                ,i.risk_factor_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update risk_factor_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where risk_factor_categ_code = i.risk_factor_categ_code
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
  END load_risk_factor_categ;
  --
  PROCEDURE load_risk_factor
  is 
  BEGIN
    v_proc_name := upper('load_risk_factor');
    for i in (select 'AGEE' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Age' short_descr,null long_descr from dual union
              select 'ALCO' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Alcohol Consumption' short_descr,null long_descr from dual union
              select 'ANXT' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Anxiety' short_descr,null long_descr from dual union
              select 'HOSP' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Multiple Hospitalization' short_descr,null long_descr from dual union
              select 'HBPR' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Hypertension (High Blood Pressure - HBP)' short_descr,null long_descr from dual union
              select 'HCHO' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Cholesterol' short_descr,null long_descr from dual union
              select 'COPD' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Chronic Obstructive Pulmonary Disease' short_descr,null long_descr from dual union
              select 'DEPR' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Depression' short_descr,null long_descr from dual union
              select 'DIAB' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Diabetes (High Blood Sugar)' short_descr,null long_descr from dual union
              select 'FMHX' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Family History' short_descr,null long_descr from dual union
              select 'GNDR' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Gender' short_descr,null long_descr from dual union
              select 'GENE' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Genetics(heredity)' short_descr,null long_descr from dual union
              select 'INFC' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Infectious Agents' short_descr,null long_descr from dual union
              select 'MEDI' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Medical Problem(e.g. Arthritis)' short_descr,null long_descr from dual union
              select 'OBES' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Obesity(Overweight)' short_descr,null long_descr from dual union
              select 'INAC' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Physical Inactivity' short_descr,null long_descr from dual union
              select 'RACE' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Race' short_descr,null long_descr from dual union
              select 'SECO' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Social and economic issues' short_descr,null long_descr from dual union
              select 'STRS' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Stress' short_descr,null long_descr from dual union
              select 'TBCO' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Tobacco' short_descr,null long_descr from dual union
              select 'SFTY' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Safety' short_descr,null long_descr from dual union
              select 'DIET' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Unhealthy Diet' short_descr,null long_descr from dual union
              select 'WATR' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Poor Drinking Water' short_descr,null long_descr from dual union
              select 'SLEP' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Lack of Sleep' short_descr,null long_descr from dual union
              select 'STRK' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Stroke (Cerebrovascular Accident -CVA)' short_descr,null long_descr from dual union
              select 'FALL' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Fall Risk' short_descr,null long_descr from dual union
              select 'CDEC' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Cognitive Decline' short_descr,null long_descr from dual union
              select 'CKDE' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Chronic Kidney Disease' short_descr,null long_descr from dual union              
              select 'COMO' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Comorbidity' short_descr,null long_descr from dual union
              select 'BDIS' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Blood Disorder' short_descr,null long_descr from dual union              
              select 'DISA' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Disability' short_descr,null long_descr from dual union
              --
              select 'DTDR' risk_factor_code,'DAW' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to Sodas or Packed Drinks' short_descr,null long_descr from dual union
              select 'DTFF' risk_factor_code,'DAW' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to Fast Food' short_descr,null long_descr from dual union
              select 'DTSG' risk_factor_code,'DOT' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to High Sugar' short_descr,null long_descr from dual union
              select 'DTST' risk_factor_code,'DOT' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to High Salt' short_descr,null long_descr from dual union
              select 'DTFR' risk_factor_code,'DHM' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to Fresh Fruits' short_descr,null long_descr from dual union
              select 'DTVG' risk_factor_code,'DHM' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to Fresh Vegetables' short_descr,null long_descr from dual union
              select 'DTGR' risk_factor_code,'DHM' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Diet related to Grain Products' short_descr,null long_descr from dual union
              --
              select 'CHDE' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Cardiovascular Disease' short_descr,null long_descr from dual union
              select 'WEIT' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Weight' short_descr,null long_descr from dual union
              select 'BMIR' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'BMI' short_descr,null long_descr from dual union
              select 'MDIS' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Major Diseases' short_descr,'Major Diseases (e.g. CVD, CKD, CLD, TIA, Thyroid Deficiencies, Cancer & Hx etc.)' long_descr from dual union
              select 'MDRX' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Prescribed (Rx) Meds' short_descr,null long_descr from dual union
              --
              select 'FRLT' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Frailty' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.risk_factor_code;
      begin
        INSERT INTO list_risk_factor (risk_factor_code
                                 ,risk_factor_categ_code
                                 ,risk_factor_is_a_disease_flag
                                 )
        VALUES (i.risk_factor_code
               ,i.risk_factor_categ_code
               ,i.risk_factor_is_a_disease_flag
               );
      exception 
        when dup_val_on_index then
          update list_risk_factor
          set risk_factor_categ_code = i.risk_factor_categ_code
              ,risk_factor_is_a_disease_flag = i.risk_factor_is_a_disease_flag
          where risk_factor_code = i.risk_factor_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.risk_factor_code||'-'||i.lang_code;
      begin
        INSERT INTO risk_factor_lang (risk_factor_lang_sn
                                        ,risk_factor_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (risk_factor_lang_SNG.nextval
                ,i.risk_factor_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update risk_factor_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where risk_factor_code = i.risk_factor_code
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
  END load_risk_factor;
  --
  PROCEDURE load_disease_severity
  is 
  BEGIN
    v_proc_name := upper('load_disease_severity');
    for i in (select 'RISKA' disease_severity_code,'en' lang_code,'Risk to Acquire' short_descr,null long_descr from dual union
              select 'AQURD' disease_severity_code,'en' lang_code,'Acquired' short_descr,null long_descr from dual union
              select 'EXCBT' disease_severity_code,'en' lang_code,'Risk to Exacerbate' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.disease_severity_code;
      begin
        INSERT INTO list_disease_severity (disease_severity_code
                                 )
        VALUES (i.disease_severity_code
               );
      exception 
        when dup_val_on_index then
          NULL;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.disease_severity_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_severity_lang (disease_severity_lang_sn
                                        ,disease_severity_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_severity_lang_SNG.nextval
                ,i.disease_severity_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_severity_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_severity_code = i.disease_severity_code
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
  END load_disease_severity;
  --
  PROCEDURE load_disease_level
  is 
  BEGIN
    v_proc_name := upper('load_disease_level');
    for i in (select 'SEV' disease_level_code,'en' lang_code,'Severe' short_descr,null long_descr from dual union
              select 'ESV' disease_level_code,'en' lang_code,'Extremely Severe' short_descr,null long_descr from dual union
              select 'HIG' disease_level_code,'en' lang_code,'High' short_descr,null long_descr from dual union
              select 'MOD' disease_level_code,'en' lang_code,'Moderate' short_descr,null long_descr from dual union
              select 'MLD' disease_level_code,'en' lang_code,'Mild' short_descr,null long_descr from dual union
              select 'LOW' disease_level_code,'en' lang_code,'Low' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.disease_level_code;
      begin
        INSERT INTO list_disease_level (disease_level_code
                                 )
        VALUES (i.disease_level_code
               );
      exception 
        when dup_val_on_index then
          NULL;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.disease_level_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_level_lang (disease_level_lang_sn
                                        ,disease_level_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_level_lang_SNG.nextval
                ,i.disease_level_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_level_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_level_code = i.disease_level_code
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
  END load_disease_level;
  --
  PROCEDURE load_severity
  is 
  BEGIN
    v_proc_name := upper('load_severity');
    for i in (select 'PRMY' severity_code,'en' lang_code,'Primary' short_descr,null long_descr from dual union
              select 'SIGN' severity_code,'en' lang_code,'Significant' short_descr,null long_descr from dual union
              select 'INCR' severity_code,'en' lang_code,'Increase' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.severity_code;
      begin
        INSERT INTO list_severity (severity_code
                                 )
        VALUES (i.severity_code
               );
      exception 
        when dup_val_on_index then
          NULL;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.severity_code||'-'||i.lang_code;
      begin
        INSERT INTO severity_lang (severity_lang_sn
                                        ,severity_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (severity_lang_SNG.nextval
                ,i.severity_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update severity_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where severity_code = i.severity_code
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
  END load_severity;
  --
  PROCEDURE load_disease_risk_factor
  is 
  BEGIN
    v_proc_name := upper('load_disease_risk_factor');
    for i in (select 'HBPR' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'ANXT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'DEPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'RACE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'SECO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'STRS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HBPR' DISEASE_CODE,'DTST' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'CHDE' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'FRLT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'DEPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CHDE' DISEASE_CODE,'STRK' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'ALZH' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ALZH' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ALZH' DISEASE_CODE,'RACE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ALZH' DISEASE_CODE,'CHDE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'PARK' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'INCR' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'PARK' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'INCR' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'PARK' DISEASE_CODE,'GNDR' RISK_FACTOR_CODE,'INCR' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'ARTH' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ARTH' DISEASE_CODE,'GNDR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ARTH' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'ARTH' DISEASE_CODE,'RACE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'CNCR' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'STRS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CNCR' DISEASE_CODE,'COPD' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'HCHO' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HCHO' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HCHO' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HCHO' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'HCHO' DISEASE_CODE,'DTFF' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'COPD' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'COPD' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'COPD' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'COPD' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'SAPN' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'GNDR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'SAPN' DISEASE_CODE,'SLEP' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'DIAB' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'RACE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'DIAB' DISEASE_CODE,'DTSG' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'CKDE' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'BDIS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'COMO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union              
              select 'CKDE' DISEASE_CODE,'WATR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CKDE' DISEASE_CODE,'CHDE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'CLDE' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CLDE' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CLDE' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CLDE' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CLDE' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'CLDE' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'OBES' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'MDRX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'WEIT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'MDIS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTSG' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTST' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTFF' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTDR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              --
              select 'PNEU' DISEASE_CODE,'FRLT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'PNEU' DISEASE_CODE,'COPD' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'PNEU' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'PNEU' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual
              )
    loop
      v_error_rec := i.disease_code;
      begin
        INSERT INTO disease_risk_factor (DISEASE_RISK_FACTOR_SN
                                        ,DISEASE_CODE
                                        ,RISK_FACTOR_CODE
                                        ,severity_CODE
                                        ,PRIMARY_RISK_FACTOR_FLAG
                                        )
        VALUES (DISEASE_RISK_FACTOR_SNG.nextval
               ,i.DISEASE_CODE
               ,i.RISK_FACTOR_CODE
               ,i.severity_CODE
               ,i.PRIMARY_RISK_FACTOR_FLAG
               );
      exception 
        when dup_val_on_index then
          update disease_risk_factor
          set severity_CODE = i.severity_CODE
              ,PRIMARY_RISK_FACTOR_FLAG = i.PRIMARY_RISK_FACTOR_FLAG
          where DISEASE_CODE = i.DISEASE_CODE
          and RISK_FACTOR_CODE = i.RISK_FACTOR_CODE
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
  END load_disease_risk_factor;
  --
  PROCEDURE load_symptom_categ
  is 
  BEGIN
    v_proc_name := upper('load_symptom_categ');
    for i in (select 'HEENT' symptom_categ_code,'en' lang_code,'Head, Eyes, Ears, Nose, and Throat' short_descr,null long_descr from dual union
              select 'MUSCU' symptom_categ_code,'en' lang_code,'Musculoskeletal' short_descr,null long_descr from dual union
              select 'CLHRT' symptom_categ_code,'en' lang_code,'Chest, Lungs and Heart' short_descr,null long_descr from dual union
              select 'NEPSY' symptom_categ_code,'en' lang_code,'Neurological and Psychological' short_descr,null long_descr from dual union
              select 'SKINN' symptom_categ_code,'en' lang_code,'Skin Related' short_descr,null long_descr from dual union
              select 'OTHER' symptom_categ_code,'en' lang_code,'Other Symptoms' short_descr,null long_descr from dual union
              select 'GASTR' symptom_categ_code,'en' lang_code,'Gastrointestinal' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.symptom_categ_code;
      begin
        INSERT INTO list_symptom_categ (symptom_categ_code
                                 )
        VALUES (i.symptom_categ_code
               );
      exception 
        when dup_val_on_index then
          NULL;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.symptom_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO symptom_categ_lang (symptom_categ_lang_sn
                                        ,symptom_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (symptom_categ_lang_SNG.nextval
                ,i.symptom_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update symptom_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where symptom_categ_code = i.symptom_categ_code
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
  END load_symptom_categ;
  --
  PROCEDURE load_symptom
  is 
  BEGIN
    v_proc_name := upper('load_symptom');
    for i in (select 'BVSN' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Blurred or Double Vision' short_descr,null long_descr from dual union
              select 'HEAD' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Headaches' short_descr,null long_descr from dual union
              select 'DIZI' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Dizziness (lightheadedness)' short_descr,null long_descr from dual union
              select 'FEVR' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Fever' short_descr,null long_descr from dual union
              select 'DSWA' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Difficulty Swallowing' short_descr,null long_descr from dual union
              select 'RIEM' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Rapid Involuntary Eye Movement' short_descr,null long_descr from dual union
              select 'SNOR' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Snoring' short_descr,null long_descr from dual union
              select 'STHR' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'Sore Throat' short_descr,null long_descr from dual union
              select 'ULCR' symptom_code,'HEENT' symptom_categ_code,'en' lang_code,'White Tongue (Ulcers)' short_descr,null long_descr from dual union
              --
              select 'JPAN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Joint Pain' short_descr,null long_descr from dual union
              select 'SWEL' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Joint Swelling' short_descr,null long_descr from dual union
              select 'LBPN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Low Back Pain' short_descr,null long_descr from dual union
              select 'MPAN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Other Muscle Pain' short_descr,null long_descr from dual union
              select 'NPAN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Neck Pain or Tightness' short_descr,null long_descr from dual union
              select 'MWEK' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Muscle Weakness' short_descr,null long_descr from dual union
              select 'STFF' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Morning Stiffness' short_descr,null long_descr from dual union
              select 'BPAN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Back Pain' short_descr,null long_descr from dual union
              select 'SLEG' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Swollen Legs' short_descr,null long_descr from dual union
              select 'SMSL' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Stiff Muscles' short_descr,null long_descr from dual union
              select 'SGRN' symptom_code,'MUSCU' symptom_categ_code,'en' lang_code,'Sores or Swelling of Groin' short_descr,null long_descr from dual union
              --
              select 'CPAN' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Chest Pain or Tightness' short_descr,null long_descr from dual union
              select 'BRTH' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Shortness of Breath' short_descr,null long_descr from dual union
              select 'WHAS' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Wheezing, Asthma' short_descr,null long_descr from dual union
              select 'IHRY' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Irregular(too fast/slow, or skipping) heartbeat' short_descr,null long_descr from dual union
              select 'COGH' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Persistent coughing more than a month' short_descr,null long_descr from dual union
              select 'CPGM' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Cough With Phlegm' short_descr,null long_descr from dual union
              select 'BMTH' symptom_code,'CLHRT' symptom_categ_code,'en' lang_code,'Breathing Through The Mouth' short_descr,null long_descr from dual union
              --
              select 'DPRN' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Depression' short_descr,null long_descr from dual union --
              select 'INSM' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Insomnia' short_descr,null long_descr from dual union--
              select 'NRVS' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Nervousness' short_descr,null long_descr from dual union--
              select 'TIRD' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Tiredness(Fatigue)' short_descr,null long_descr from dual union--
              select 'ANXS' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Anxious' short_descr,null long_descr from dual union --
              select 'TTNK' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Trouble Thinking' short_descr,null long_descr from dual union--
              select 'FRGT' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Forgetfulness' short_descr,null long_descr from dual union--
              select 'TWSU' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Trouble Walking, Speaking and Understanding' short_descr,null long_descr from dual union
              select 'PFAL' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Paralysis (numbness) of the face, arm or leg' short_descr,null long_descr from dual union
              select 'TRMR' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Tremor in one hand' short_descr,null long_descr from dual union
              select 'LBAL' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Loss of Balance' short_descr,null long_descr from dual union
              select 'SMVN' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Slow Movement' short_descr,null long_descr from dual union
              select 'SNSS' symptom_code,'NEPSY' symptom_categ_code,'en' lang_code,'Stiffness' short_descr,null long_descr from dual union
              --
              select 'HWWM' symptom_code,'SKINN' symptom_categ_code,'en' lang_code,'Hives, Welts, Wafts, Moles' short_descr,null long_descr from dual union
              select 'ITCH' symptom_code,'SKINN' symptom_categ_code,'en' lang_code,'Itching' short_descr,null long_descr from dual union
              select 'CSKN' symptom_code,'SKINN' symptom_categ_code,'en' lang_code,'Clammy (Sweaty) Skin' short_descr,null long_descr from dual union
              select 'SRSH' symptom_code,'SKINN' symptom_categ_code,'en' lang_code,'Skin Rash' short_descr,null long_descr from dual union
              --
              select 'NUSA' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Nausea' short_descr,null long_descr from dual union
              select 'HBRN' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Heartburn' short_descr,null long_descr from dual union
              select 'IDGS' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Indigestion' short_descr,null long_descr from dual union
              select 'LAPP' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Loss of Appetite' short_descr,null long_descr from dual union
              select 'PDCM' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Pain discomfort' short_descr,null long_descr from dual union
              select 'VOMT' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Vomiting' short_descr,null long_descr from dual union
              select 'STOL' symptom_code,'GASTR' symptom_categ_code,'en' lang_code,'Black/Tarry Stools' short_descr,null long_descr from dual union
              --
              select 'BLMP' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Breast Lump or Breast Discharge' short_descr,null long_descr from dual union
              select 'TLMP' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Lumps in the Testicles' short_descr,null long_descr from dual union
              select 'PLMP' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Persistent Lumps or Swollen Glands' short_descr,null long_descr from dual union
              select 'VBLD' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Unusual Vaginal Bleeding or Discharge' short_descr,null long_descr from dual union
              select 'SWAT' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Night Sweat' short_descr,null long_descr from dual union
              select 'HOAR' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Hoarseness' short_descr,null long_descr from dual union
              select 'BURN' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Blood in the Urine' short_descr,null long_descr from dual union
              select 'BSTL' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Blood in the Stool' short_descr,null long_descr from dual union
              select 'BLPF' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Blueness of the Lips or Fingernail Beds' short_descr,null long_descr from dual union
              select 'FURN' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Increased Thirst and Frequent Urination' short_descr,null long_descr from dual union
              select 'HUNG' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Increased Hunger' short_descr,null long_descr from dual union
              select 'LSWT' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Weight Loss' short_descr,null long_descr from dual union
              select 'BEAT' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Binge Eating' short_descr,null long_descr from dual union
              select 'PBLY' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Pot Belly' short_descr,null long_descr from dual union
              select 'RINF' symptom_code,'OTHER' symptom_categ_code,'en' lang_code,'Recurrent Infections' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.symptom_code;
      begin
        INSERT INTO list_symptom (symptom_code
                                 ,symptom_categ_code
                                 )
        VALUES (i.symptom_code
               ,i.symptom_categ_code
               );
      exception 
        when dup_val_on_index then
          update list_symptom
          set symptom_categ_code = i.symptom_categ_code
          where symptom_code = i.symptom_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.symptom_code||'-'||i.lang_code;
      begin
        INSERT INTO symptom_lang (symptom_lang_sn
                                        ,symptom_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (symptom_lang_SNG.nextval
                ,i.symptom_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update symptom_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where symptom_code = i.symptom_code
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
  END load_symptom;
  --
  PROCEDURE load_disease_symptom
  is 
  BEGIN
    v_proc_name := upper('load_disease_symptom');
    for i in (select 'ALZH' disease_code,'ANXS' symptom_code,'PRMY' severity_code from dual union
              select 'ALZH' disease_code,'DPRN' symptom_code,'PRMY' severity_code from dual union
              select 'ALZH' disease_code,'FRGT' symptom_code,'PRMY' severity_code from dual union
              select 'ALZH' disease_code,'INSM' symptom_code,'PRMY' severity_code from dual union
              select 'ALZH' disease_code,'NRVS' symptom_code,'PRMY' severity_code from dual union
              select 'ALZH' disease_code,'TTNK' symptom_code,'PRMY' severity_code from dual union
              --
              select 'ARTH' disease_code,'LBPN' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'JPAN' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'MPAN' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'MWEK' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'NPAN' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'STFF' symptom_code,'PRMY' severity_code from dual union
              select 'ARTH' disease_code,'SWEL' symptom_code,'PRMY' severity_code from dual union
              --
              select 'CNCR' disease_code,'COGH' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'IDGS' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'PDCM' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'STOL' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'FEVR' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'HEAD' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'HWWM' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'ITCH' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'BLMP' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'TLMP' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'PLMP' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'VBLD' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'SWAT' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'HOAR' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'BURN' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'BSTL' symptom_code,'PRMY' severity_code from dual union
              select 'CNCR' disease_code,'LSWT' symptom_code,'PRMY' severity_code from dual union
              --
              select 'COPD' disease_code,'WHAS' symptom_code,'PRMY' severity_code from dual union
              select 'COPD' disease_code,'BRTH' symptom_code,'PRMY' severity_code from dual union
              select 'COPD' disease_code,'COGH' symptom_code,'PRMY' severity_code from dual union
              select 'COPD' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'COPD' disease_code,'BLPF' symptom_code,'PRMY' severity_code from dual union
              --
              select 'DIAB' disease_code,'BVSN' symptom_code,'PRMY' severity_code from dual union
              select 'DIAB' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'DIAB' disease_code,'FURN' symptom_code,'PRMY' severity_code from dual union
              select 'DIAB' disease_code,'HUNG' symptom_code,'PRMY' severity_code from dual union
              select 'DIAB' disease_code,'LSWT' symptom_code,'PRMY' severity_code from dual union
              --
              select 'STRK' disease_code,'BVSN' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'DIZI' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'HEAD' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'RIEM' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'DSWA' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'NPAN' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'SMSL' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'TWSU' symptom_code,'PRMY' severity_code from dual union
              select 'STRK' disease_code,'PFAL' symptom_code,'PRMY' severity_code from dual union
              --
              select 'CHDE' disease_code,'BRTH' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'CPAN' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'IHRY' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'IDGS' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'NUSA' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'DIZI' symptom_code,'PRMY' severity_code from dual union
              select 'CHDE' disease_code,'SWAT' symptom_code,'PRMY' severity_code from dual union
              --
              select 'PARK' disease_code,'TRMR' symptom_code,'PRMY' severity_code from dual union
              select 'PARK' disease_code,'LBAL' symptom_code,'PRMY' severity_code from dual union
              select 'PARK' disease_code,'SMVN' symptom_code,'PRMY' severity_code from dual union
              select 'PARK' disease_code,'SNSS' symptom_code,'PRMY' severity_code from dual union
              --
              select 'SAPN' disease_code,'BMTH' symptom_code,'PRMY' severity_code from dual union
              select 'SAPN' disease_code,'SNOR' symptom_code,'PRMY' severity_code from dual union
              select 'SAPN' disease_code,'INSM' symptom_code,'PRMY' severity_code from dual union
              select 'SAPN' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              --
              select 'AIDS' disease_code,'FEVR' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'STHR' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'ULCR' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'SGRN' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'SRSH' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'SWAT' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'LSWT' symptom_code,'PRMY' severity_code from dual union
              select 'AIDS' disease_code,'RINF' symptom_code,'PRMY' severity_code from dual union
              --
              select 'OBES' disease_code,'SNOR' symptom_code,'PRMY' severity_code from dual union
              select 'OBES' disease_code,'JPAN' symptom_code,'PRMY' severity_code from dual union
              select 'OBES' disease_code,'BPAN' symptom_code,'PRMY' severity_code from dual union
              select 'OBES' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'OBES' disease_code,'BEAT' symptom_code,'PRMY' severity_code from dual union
              select 'OBES' disease_code,'PBLY' symptom_code,'PRMY' severity_code from dual union
              --
              select 'PNEU' disease_code,'WHAS' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'BRTH' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'CPGM' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'LAPP' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'FEVR' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'TIRD' symptom_code,'PRMY' severity_code from dual union
              select 'PNEU' disease_code,'CSKN' symptom_code,'PRMY' severity_code from dual
              )
    loop
      v_error_rec := i.disease_code||'-'||i.symptom_code;
      begin
        INSERT INTO disease_symptom (DISEASE_SYMPTOM_SN
                                    ,DISEASE_CODE
                                    ,SYMPTOM_CODE
                                    ,severity_code
                                    )
        VALUES (DISEASE_SYMPTOM_SNG.nextval
               ,i.disease_code
               ,i.symptom_code
               ,i.severity_code
               );
      exception 
        when dup_val_on_index then
          update disease_symptom
          set severity_code = i.severity_code
          where DISEASE_CODE = i.DISEASE_CODE
          and SYMPTOM_CODE = i.SYMPTOM_CODE
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
  END load_disease_symptom;
  --
  PROCEDURE load_hr
  is 
  BEGIN
    v_proc_name := upper('load_hr');
    for i in (select '01' hr_code from dual union
              select '02' hr_code from dual union
              select '03' hr_code from dual union
              select '04' hr_code from dual union
              select '05' hr_code from dual union
              select '06' hr_code from dual union
              select '07' hr_code from dual union
              select '08' hr_code from dual union
              select '09' hr_code from dual union
              select '10' hr_code from dual union
              select '11' hr_code from dual union
              select '12' hr_code from dual
              )
    loop
      v_error_rec := i.hr_code;
      begin
        INSERT INTO list_hr (hr_code)
        VALUES (i.hr_code);
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
  END load_hr;
  --
  PROCEDURE load_min
  is 
  BEGIN
    v_proc_name := upper('load_min');
    for i in (select '00' min_code from dual union
              select '01' min_code from dual union
              select '02' min_code from dual union
              select '03' min_code from dual union
              select '04' min_code from dual union
              select '05' min_code from dual union
              select '06' min_code from dual union
              select '07' min_code from dual union
              select '08' min_code from dual union
              select '09' min_code from dual union
              select '10' min_code from dual union
              select '11' min_code from dual union
              select '12' min_code from dual union
              select '13' min_code from dual union
              select '14' min_code from dual union
              select '15' min_code from dual union
              select '16' min_code from dual union
              select '17' min_code from dual union
              select '18' min_code from dual union
              select '19' min_code from dual union
              select '20' min_code from dual union
              select '21' min_code from dual union
              select '22' min_code from dual union
              select '23' min_code from dual union
              select '24' min_code from dual union
              select '25' min_code from dual union
              select '26' min_code from dual union
              select '27' min_code from dual union
              select '28' min_code from dual union
              select '29' min_code from dual union
              select '30' min_code from dual union
              select '31' min_code from dual union
              select '32' min_code from dual union
              select '33' min_code from dual union
              select '34' min_code from dual union
              select '35' min_code from dual union
              select '36' min_code from dual union
              select '37' min_code from dual union
              select '38' min_code from dual union
              select '39' min_code from dual union
              select '40' min_code from dual union
              select '41' min_code from dual union
              select '42' min_code from dual union
              select '43' min_code from dual union
              select '44' min_code from dual union
              select '45' min_code from dual union
              select '46' min_code from dual union
              select '47' min_code from dual union
              select '48' min_code from dual union
              select '49' min_code from dual union
              select '50' min_code from dual union
              select '51' min_code from dual union
              select '52' min_code from dual union
              select '53' min_code from dual union
              select '54' min_code from dual union
              select '55' min_code from dual union
              select '56' min_code from dual union
              select '57' min_code from dual union
              select '58' min_code from dual union
              select '59' min_code from dual
              )
    loop
      v_error_rec := i.min_code;
      begin
        INSERT INTO list_min (min_code)
        VALUES (i.min_code);
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
  END load_min;
  --
  PROCEDURE load_am_pm
  is 
  BEGIN
    v_proc_name := upper('load_am_pm');
    for i in (select 'AM' am_pm_code from dual union
              select 'PM' am_pm_code from dual
              )
    loop
      v_error_rec := i.am_pm_code;
      begin
        INSERT INTO list_am_pm (am_pm_code)
        VALUES (i.am_pm_code);
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
  END load_am_pm;
  --
  PROCEDURE load_ccm_question_categ
  is 
  BEGIN
    v_proc_name := upper('load_ccm_question_categ');
    for i in (select 'SYMP' ccm_question_categ_code,'en' lang_code,'Symptom' short_descr,null long_descr from dual union
              select 'MEDI' ccm_question_categ_code,'en' lang_code,'Medication' short_descr,null long_descr from dual union
              select 'FMHX' ccm_question_categ_code,'en' lang_code,'Family PMHx' short_descr,null long_descr from dual union
              select 'BERF' ccm_question_categ_code,'en' lang_code,'Behavioral Risk Factor' short_descr,null long_descr from dual union
              select 'DISE' ccm_question_categ_code,'en' lang_code,'Disease' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.ccm_question_categ_code;
      begin
        INSERT INTO list_ccm_question_categ (ccm_question_categ_code
                                 )
        VALUES (i.ccm_question_categ_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.ccm_question_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO ccm_question_categ_lang (ccm_question_categ_lang_sn
                                        ,ccm_question_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (ccm_question_categ_lang_SNG.nextval
                ,i.ccm_question_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update ccm_question_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where ccm_question_categ_code = i.ccm_question_categ_code
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
  END load_ccm_question_categ;
  --
  PROCEDURE load_ccm_question
  is 
  BEGIN
    v_proc_name := upper('load_ccm_question');
    for i in (select '100001' ccm_question_code,'SYMP' ccm_question_categ_code,1 order_num,'en' lang_code,'Is there any change of patient symptom?' short_descr,null long_descr from dual union
              select '100101' ccm_question_code,'MEDI' ccm_question_categ_code,1 order_num,'en' lang_code,'Is there any change of patient medication?' short_descr,null long_descr from dual union
              select '100201' ccm_question_code,'FMHX' ccm_question_categ_code,1 order_num,'en' lang_code,'Any new event in the family?' short_descr,null long_descr from dual union
              select '100301' ccm_question_code,'BERF' ccm_question_categ_code,1 order_num,'en' lang_code,'Is there any change of patient behavior?' short_descr,null long_descr from dual union
              select '100401' ccm_question_code,'DISE' ccm_question_categ_code,1 order_num,'en' lang_code,'Is there any change of disease severity?' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.ccm_question_code;
      begin
        INSERT INTO list_ccm_question (ccm_question_code
                                      ,ccm_question_categ_code
                                      ,order_num
                                 )
        VALUES (i.ccm_question_code
               ,i.ccm_question_categ_code
               ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_ccm_question
          set ccm_question_categ_code = i.ccm_question_categ_code
              ,order_num = i.order_num
          where ccm_question_code = i.ccm_question_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.ccm_question_code||'-'||i.lang_code;
      begin
        INSERT INTO ccm_question_lang (ccm_question_lang_sn
                                        ,ccm_question_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (ccm_question_lang_SNG.nextval
                ,i.ccm_question_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update ccm_question_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where ccm_question_code = i.ccm_question_code
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
  END load_ccm_question;
  --
  PROCEDURE load_em_categ_grp
  is 
  BEGIN
    v_proc_name := upper('load_em_categ_grp');
    for i in (select 'RXX' em_categ_grp_code,'en' lang_code,'Rx' short_descr,null long_descr from dual union
              select 'ROS' em_categ_grp_code,'en' lang_code,'Review of System' short_descr,null long_descr from dual union
              select 'EXM' em_categ_grp_code,'en' lang_code,'Exam' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.em_categ_grp_code;
      begin
        INSERT INTO list_em_categ_grp (em_categ_grp_code
                                 )
        VALUES (i.em_categ_grp_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.em_categ_grp_code||'-'||i.lang_code;
      begin
        INSERT INTO em_categ_grp_lang (em_categ_grp_lang_sn
                                        ,em_categ_grp_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (em_categ_grp_lang_SNG.nextval
                ,i.em_categ_grp_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update em_categ_grp_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where em_categ_grp_code = i.em_categ_grp_code
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
  END load_em_categ_grp;
  --
  PROCEDURE load_em_categ
  is 
  BEGIN
    v_proc_name := upper('load_em_categ');
    for i in (select 'GSYS' em_categ_code,'ROS' em_categ_grp_code,'en' lang_code,'General System' short_descr,null long_descr from dual union
              select 'PEXM' em_categ_code,'EXM' em_categ_grp_code,'en' lang_code,'Physical Exam' short_descr,null long_descr from dual union
              select 'IMMU' em_categ_code,'RXX' em_categ_grp_code,'en' lang_code,'Immunizations' short_descr,null long_descr from dual union
              select 'CLIN' em_categ_code,'RXX' em_categ_grp_code,'en' lang_code,'Clinical Test' short_descr,null long_descr from dual union
              select 'BLOD' em_categ_code,'RXX' em_categ_grp_code,'en' lang_code,'Blood Work' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.em_categ_code;
      begin
        INSERT INTO list_em_categ (em_categ_code
                                  ,em_categ_grp_code
                                 )
        VALUES (i.em_categ_code
                ,i.em_categ_grp_code
               );
      exception 
        when dup_val_on_index then
          update list_em_categ
          set em_categ_grp_code = i.em_categ_grp_code
          where em_categ_code = i.em_categ_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.em_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO em_categ_lang (em_categ_lang_sn
                                        ,em_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (em_categ_lang_SNG.nextval
                ,i.em_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update em_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where em_categ_code = i.em_categ_code
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
  END load_em_categ;
  --
  PROCEDURE load_em_name
  is 
  BEGIN
    v_proc_name := upper('load_em_name');
    for i in (select '100001' em_name_code,'BLOD' em_categ_code,1 order_num,'en' lang_code,'CBC' short_descr,'A complete blood count (CBC) is a blood test used to evaluate person''s overall health and detect a wide range of disorders, including anemia, infection and leukemia.' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100002' em_name_code,'BLOD' em_categ_code,2 order_num,'en' lang_code,'Chem.' short_descr,'Chemistry panels are groups of tests that are routinely ordered to determine a person''s general health status. The tests are performed on a blood sample' long_descr,'Y' usda_immu_comp_flag,'Blood Glucose Tests (American Diabetes Association recommends for every three years)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100003' em_name_code,'BLOD' em_categ_code,3 order_num,'en' lang_code,'TSH' short_descr,'To check for thyroid gland problems' long_descr,'Y' usda_immu_comp_flag,'Bone Density (biennial)' intervention_descr,null triggered_code,65 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100004' em_name_code,'BLOD' em_categ_code,4 order_num,'en' lang_code,'PSA' short_descr,'Screen for prostate cancer.' long_descr,'Y' usda_immu_comp_flag,'PSA Test (Annually)' intervention_descr,'MAL' triggered_code,50 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100005' em_name_code,'BLOD' em_categ_code,5 order_num,'en' lang_code,'Lipid profile' short_descr,'Abnormalities in lipids, such as cholesterol and triglycerides.' long_descr,'Y' usda_immu_comp_flag,'Lipid Panel (Once every five years)' intervention_descr,null triggered_code,20 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100006' em_name_code,'BLOD' em_categ_code,6 order_num,'en' lang_code,'Urine' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100007' em_name_code,'BLOD' em_categ_code,7 order_num,'en' lang_code,'Hemoccults' short_descr,'Presence of hidden blood in a patient''s stool' long_descr,'Y' usda_immu_comp_flag,'Hemocult (Annual Fecal occult blood test)' intervention_descr,null triggered_code,50 usda_immu_comp_age_begin,75 usda_immu_comp_age_end from dual union
              select '100008' em_name_code,'BLOD' em_categ_code,8 order_num,'en' lang_code,'Others' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              --
              select '100101' em_name_code,'CLIN' em_categ_code,1 order_num,'en' lang_code,'Pap' short_descr,'Test to detect signs of cervical cancer.' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100102' em_name_code,'CLIN' em_categ_code,2 order_num,'en' lang_code,'GC/CT' short_descr,'Sexually transmitted infection Chlamydia (CT) and Gonorrhea (GC)' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100103' em_name_code,'CLIN' em_categ_code,3 order_num,'en' lang_code,'Mammogram' short_descr,'X-ray picture of the breast to detect cancer' long_descr,'Y' usda_immu_comp_flag,'Mammography (Annually)' intervention_descr,'FEM' triggered_code,40 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100104' em_name_code,'CLIN' em_categ_code,4 order_num,'en' lang_code,'Bone density' short_descr,'To diagnose osteoporosis before a broken bone occurs' long_descr,'Y' usda_immu_comp_flag,'Bone Density (biennial)' intervention_descr,null triggered_code,65 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100105' em_name_code,'CLIN' em_categ_code,5 order_num,'en' lang_code,'Flex. sig.' short_descr,'Rectum and the lower (sigmoid) colon exam test' long_descr,'Y' usda_immu_comp_flag,'Colonoscopy (Flexible sigmoidoscopy (5y), Screening colonoscopy (10y) & Barium enema.)' intervention_descr,null triggered_code,50 usda_immu_comp_age_begin,75 usda_immu_comp_age_end from dual union
              select '100106' em_name_code,'CLIN' em_categ_code,6 order_num,'en' lang_code,'Treadmill' short_descr,'The exercise stress test' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100107' em_name_code,'CLIN' em_categ_code,7 order_num,'en' lang_code,'Ophthalmology' short_descr,'Diseases of the eyeball' long_descr,'Y' usda_immu_comp_flag,'Eye Exam (at least every two years)' intervention_descr,null triggered_code,19 usda_immu_comp_age_begin,64 usda_immu_comp_age_end from dual union
              select '100108' em_name_code,'CLIN' em_categ_code,8 order_num,'en' lang_code,'DRE' short_descr,'Digital Rectal Exam (DRE)' long_descr,'Y' usda_immu_comp_flag,'Prostate Exam (Annually)' intervention_descr,'MAL' triggered_code,50 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100109' em_name_code,'CLIN' em_categ_code,9 order_num,'en' lang_code,'EKG' short_descr,'Checks for problems with the electrical activity of your heart' long_descr,'Y' usda_immu_comp_flag,'EKG (At discretion of clinician)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100110' em_name_code,'CLIN' em_categ_code,10 order_num,'en' lang_code,'Hearing test' short_descr,null long_descr,'Y' usda_immu_comp_flag,'Hearing test (Have one at least once in your adult life)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100111' em_name_code,'CLIN' em_categ_code,11 order_num,'en' lang_code,'Pelvic Exam' short_descr,'The exam helps a doctor or nurse see the size and position of the vagina, cervix, uterus, and ovaries.' long_descr,'Y' usda_immu_comp_flag,'Pelvic Exam (Annually)' intervention_descr,'FEM' triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100112' em_name_code,'CLIN' em_categ_code,13 order_num,'en' lang_code,'Others' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100113' em_name_code,'CLIN' em_categ_code,12 order_num,'en' lang_code,'LDCT' short_descr,'Low Dose of Computer Tomography for ALL smokers or with Hx of smoking' long_descr,'Y' usda_immu_comp_flag,'LDCT (Low Dose of Computer Tomography for ALL smokers or with Hx of smoking)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              --
              select '100201' em_name_code,'IMMU' em_categ_code,1 order_num,'en' lang_code,'Td' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100202' em_name_code,'IMMU' em_categ_code,2 order_num,'en' lang_code,'Flu' short_descr,'Flu Virus' long_descr,'Y' usda_immu_comp_flag,'Influenza(Get a flu vaccine every year)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100203' em_name_code,'IMMU' em_categ_code,3 order_num,'en' lang_code,'Pneumovax' short_descr,'Response to carbohydrate antigens' long_descr,'Y' usda_immu_comp_flag,'Pneumonia(1 or 2 doses)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union              
              select '100204' em_name_code,'IMMU' em_categ_code,4 order_num,'en' lang_code,'Hep.B' short_descr,'Vaccine that prevents hepatitis B(poor immune function such as HIV/AIDS )' long_descr,'Y' usda_immu_comp_flag,'Hep.B (3 doses. needed for adults who did not get these vaccines when they were children)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              select '100205' em_name_code,'IMMU' em_categ_code,5 order_num,'en' lang_code,'Hep.C' short_descr,'Vaccine that prevents hepatitis C(acute infections, chronic disease and long-term liver problems. )' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union              
              select '100206' em_name_code,'IMMU' em_categ_code,6 order_num,'en' lang_code,'Varicella' short_descr,'Varicella zoster virus (VZV) and Chickenpox' long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100207' em_name_code,'IMMU' em_categ_code,8 order_num,'en' lang_code,'Others' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100208' em_name_code,'IMMU' em_categ_code,7 order_num,'en' lang_code,'Herpes Zoster / Shingles' short_descr,null long_descr,'Y' usda_immu_comp_flag,'Herpes Zoster / Shingles(1 dose. get the zoster vaccine even if you''ve had shingles before.)' intervention_descr,null triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union
              --
              select '100301' em_name_code,'GSYS' em_categ_code,1 order_num,'en' lang_code,'Derm.' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100302' em_name_code,'GSYS' em_categ_code,2 order_num,'en' lang_code,'Cardiovascular' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100303' em_name_code,'GSYS' em_categ_code,3 order_num,'en' lang_code,'Neuromuscular' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100304' em_name_code,'GSYS' em_categ_code,4 order_num,'en' lang_code,'Gastrointestinal' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100305' em_name_code,'GSYS' em_categ_code,5 order_num,'en' lang_code,'Genitourinary' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100306' em_name_code,'GSYS' em_categ_code,6 order_num,'en' lang_code,'Psychiatric' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100307' em_name_code,'GSYS' em_categ_code,7 order_num,'en' lang_code,'General' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union              
              select '100308' em_name_code,'GSYS' em_categ_code,8 order_num,'en' lang_code,'HEENT' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union              
              select '100309' em_name_code,'GSYS' em_categ_code,9 order_num,'en' lang_code,'Respiratory' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              --
              select '100401' em_name_code,'PEXM' em_categ_code,1 order_num,'en' lang_code,'Head' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100402' em_name_code,'PEXM' em_categ_code,2 order_num,'en' lang_code,'Heart' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100403' em_name_code,'PEXM' em_categ_code,3 order_num,'en' lang_code,'Extremities' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100404' em_name_code,'PEXM' em_categ_code,4 order_num,'en' lang_code,'Eyes' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100405' em_name_code,'PEXM' em_categ_code,5 order_num,'en' lang_code,'Lungs' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100406' em_name_code,'PEXM' em_categ_code,6 order_num,'en' lang_code,'Scrotum' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100407' em_name_code,'PEXM' em_categ_code,7 order_num,'en' lang_code,'Ears' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100408' em_name_code,'PEXM' em_categ_code,8 order_num,'en' lang_code,'Breasts' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100409' em_name_code,'PEXM' em_categ_code,9 order_num,'en' lang_code,'Penis' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100410' em_name_code,'PEXM' em_categ_code,10 order_num,'en' lang_code,'Nose' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100411' em_name_code,'PEXM' em_categ_code,11 order_num,'en' lang_code,'Abdomen' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union              
              select '100412' em_name_code,'PEXM' em_categ_code,12 order_num,'en' lang_code,'Hernia' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100413' em_name_code,'PEXM' em_categ_code,13 order_num,'en' lang_code,'Throat' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100414' em_name_code,'PEXM' em_categ_code,14 order_num,'en' lang_code,'Vulva' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100415' em_name_code,'PEXM' em_categ_code,15 order_num,'en' lang_code,'Prostate' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100416' em_name_code,'PEXM' em_categ_code,16 order_num,'en' lang_code,'Thyroid' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100417' em_name_code,'PEXM' em_categ_code,17 order_num,'en' lang_code,'Vagina' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100418' em_name_code,'PEXM' em_categ_code,18 order_num,'en' lang_code,'Rectal' short_descr,null long_descr,'Y' usda_immu_comp_flag,'Rectal Exam (Annually)' intervention_descr,'MAL' triggered_code,0 usda_immu_comp_age_begin,999 usda_immu_comp_age_end from dual union              
              select '100419' em_name_code,'PEXM' em_categ_code,19 order_num,'en' lang_code,'Nodes' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100420' em_name_code,'PEXM' em_categ_code,20 order_num,'en' lang_code,'Cervix' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100421' em_name_code,'PEXM' em_categ_code,21 order_num,'en' lang_code,'Carotids' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100422' em_name_code,'PEXM' em_categ_code,22 order_num,'en' lang_code,'Uterus' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100423' em_name_code,'PEXM' em_categ_code,23 order_num,'en' lang_code,'Skin' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual union
              select '100424' em_name_code,'PEXM' em_categ_code,24 order_num,'en' lang_code,'Adnexae' short_descr,null long_descr,'N' usda_immu_comp_flag,null intervention_descr,null triggered_code,null usda_immu_comp_age_begin,null usda_immu_comp_age_end from dual
              )
    loop
      v_error_rec := i.em_name_code;
      begin
        INSERT INTO list_em_name (em_name_code
                                      ,em_categ_code
                                      ,order_num
                                      ,usda_immu_comp_flag
                                      ,triggered_code
                                      ,usda_immu_comp_age_begin
                                      ,usda_immu_comp_age_end    
                                 )
        VALUES (i.em_name_code
               ,i.em_categ_code
               ,i.order_num
               ,i.usda_immu_comp_flag
               ,i.triggered_code
               ,i.usda_immu_comp_age_begin
               ,i.usda_immu_comp_age_end    
               );
      exception 
        when dup_val_on_index then
          update list_em_name
          set em_categ_code = i.em_categ_code
             ,order_num = i.order_num
             ,usda_immu_comp_flag = i.usda_immu_comp_flag
             ,triggered_code = i.triggered_code
             ,usda_immu_comp_age_begin = i.usda_immu_comp_age_begin
             ,usda_immu_comp_age_end = i.usda_immu_comp_age_end
          where em_name_code = i.em_name_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.em_name_code||'-'||i.lang_code;
      begin
        INSERT INTO em_name_lang (em_name_lang_sn
                                        ,em_name_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        ,intervention_descr
                                        )
        VALUES (em_name_lang_SNG.nextval
                ,i.em_name_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
                ,i.intervention_descr
               );
      exception 
        when dup_val_on_index then
          update em_name_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
              ,intervention_descr = i.intervention_descr
          where em_name_code = i.em_name_code
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
  END load_em_name;
  --
  PROCEDURE load_patient_orientation
  is 
  BEGIN
    v_proc_name := upper('load_patient_orientation');
    for i in (select 'AO2' patient_orientation_code,3 order_num,'en' lang_code,'A&O x2' short_descr,'Alert and Oriented times 2 (person, place)' long_descr from dual union
              select 'AO3' patient_orientation_code,2 order_num,'en' lang_code,'A&O x3' short_descr,'Alert and Oriented times 3 (person, place, time)' long_descr from dual union
              select 'AO4' patient_orientation_code,1 order_num,'en' lang_code,'A&O x4' short_descr,'Alert and Oriented times 4 (person, place, time, object)' long_descr from dual union
              select 'ANO' patient_orientation_code,4 order_num,'en' lang_code,'Alert but Not-Oriented' short_descr,null long_descr from dual
              )
    loop
      v_error_rec := i.patient_orientation_code;
      begin
        INSERT INTO list_patient_orientation (patient_orientation_code
                                              ,order_num
                                              )
        VALUES (i.patient_orientation_code
                ,i.order_num
               );
      exception 
        when dup_val_on_index then
          update list_patient_orientation
          set order_num = i.order_num
          where patient_orientation_code = i.patient_orientation_code
          ;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,1000);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,v_error_rec);
      end;
      v_error_rec := i.patient_orientation_code||'-'||i.lang_code;
      begin
        INSERT INTO patient_orientation_lang (patient_orientation_lang_sn
                                        ,patient_orientation_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (patient_orientation_lang_SNG.nextval
                ,i.patient_orientation_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update patient_orientation_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where patient_orientation_code = i.patient_orientation_code
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
  END load_patient_orientation;
END list_trans_pkg;
/
SHOW ERRORS
