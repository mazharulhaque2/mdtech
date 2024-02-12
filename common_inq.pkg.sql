create or replace PACKAGE common_inq_pkg IS
  v_pkg_name    varchar2 (30) := upper('common_inq_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  PROCEDURE common_info (p_locale in varchar2,p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type,p_out OUT clob);
  PROCEDURE common_info_init  (p_locale in varchar2,p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type,p_out OUT clob);
  procedure load_common_info_json (p_lang_code in list_lang.lang_code%type default 'en',p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type);
  function user_role_company_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED;
  function user_role_physician_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED;
  function user_role_svc_location_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED;
  --
  PROCEDURE get_country_state_data (p_locale in varchar2,p_country_code in country.country_code%type,p_out OUT clob);
  --
  PROCEDURE role_priviledge_list (p_locale in varchar2,p_role_id roles_priviledge.role_id%type,p_out OUT clob);
  PROCEDURE role_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE user_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE active_user_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE new_user_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE primary_physician (p_locale in varchar2,p_out OUT clob);
  PROCEDURE provider_physician (p_locale in varchar2,p_out OUT clob);
  PROCEDURE company_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE conditional_company_list (p_locale in varchar2,p_user in varchar2,p_ithealth_company_flag in varchar2,p_out OUT clob);
  --
  PROCEDURE patient_list (p_locale in varchar2,p_physician_sn in number,p_prev_svc_billing_code in list_PREV_SVC_BILLING.prev_svc_billing_code%type,p_out OUT clob);
  PROCEDURE patient_medication (p_locale in varchar2,p_patient_sn in number,p_out OUT clob);
  PROCEDURE service_remark (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_signature (p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_with_pend_svc (p_locale in varchar2,p_user_name in "AspNetUsers"."UserName"%type,p_out OUT clob);
  --
  PROCEDURE company_svc_location_list (p_locale in varchar2,p_company_sn in number,p_user in varchar2,p_out OUT clob);
  PROCEDURE company_physician_list (p_locale in varchar2,p_company_sn in number,p_user in varchar2,p_out OUT clob);
  PROCEDURE company_user_list (p_locale in varchar2,p_company_sn in number,p_out OUT clob);
  PROCEDURE company_prospective_prov_list(p_locale in varchar2,p_company_sn in number,p_out OUT clob);
  PROCEDURE company_provider_list(p_locale in varchar2,p_company_sn in number,p_provider_physician_sn in number,p_out OUT clob);
  --
  PROCEDURE svc_location_list (p_locale in varchar2,p_out OUT clob);
  PROCEDURE physician_svc_location (p_locale in varchar2,p_physician_sn in physician.physician_sn%type,p_out OUT clob);
  PROCEDURE physician_location_list (p_locale in varchar2,p_physician_sn in number,p_out OUT clob);
  PROCEDURE location_physician_list (p_locale in varchar2,p_svc_location_sn in number,p_user in varchar2,p_out OUT clob);
  PROCEDURE user_location_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob);
  PROCEDURE user_company_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob);
  PROCEDURE user_physician_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob);
  PROCEDURE patient_prev_svc (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_svc_completed_flag varchar2,p_out OUT clob);
  --PROCEDURE user_image  (p_out OUT clob);
  function next_question_categ_code (p_prev_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_last_categ_order_num in number) return list_question_categ.question_categ_code%type;
  function question_order_num (p_prev_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type) return svc_billing_question_categ.order_num%type;
  function patient_question_response_flag (p_patient_prev_svc_sn in number,p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return varchar2;
  function question_category_rf_flag (p_patient_prev_svc_sn in number,p_question_categ_code in list_question_categ.question_categ_code%type,p_risk_factor_code in list_risk_factor.risk_factor_code%type) return varchar2;
  procedure patient_last_question_categ (p_patient_prev_svc_sn in number
                                           ,p_last_question_categ_code out list_question_categ.question_categ_code%type
                                           ,p_last_categ_order_num out number
                                           ,p_conditional_categ_flag out list_question_categ.conditional_categ_flag%type
                                           ,p_trigger_further_categ_flag out list_question_categ.trigger_further_categ_flag%type
                                           );
  procedure patient_last_cond_qtn_categ (p_patient_prev_svc_sn in number
                                           ,p_parent_question_categ_code in list_question_categ.question_categ_code%type
                                           ,p_last_question_categ_code out list_question_categ.question_categ_code%type
                                           ,p_last_categ_order_num out number
                                           ,p_conditional_categ_flag out list_question_categ.conditional_categ_flag%type
                                           ,p_trigger_further_categ_flag out list_question_categ.trigger_further_categ_flag%type
                                           );
  PROCEDURE patient_qnr_by_categ (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_em_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_em_template_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_ccm_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_ccm_template_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE patient_em_sched_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  --
  procedure response_score_prc (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type,p_trigger_further_categ_flag out categ_score_eval.trigger_further_categ_flag%type,p_disease_level_code out categ_score_eval.disease_level_code%type);
  function response_score (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return categ_score_eval.disease_level_code%type;
  function response_trigger_further_categ (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return categ_score_eval.trigger_further_categ_flag%type;
  function categ_score_sum (p_patient_prev_svc_sn in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return number;
  function categ_no_response_code (p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return patient_response.question_response_code%type;
  function question_response_code (p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return patient_response.question_response_code%type;
  function final_next_question_categ (p_patient_prev_svc_sn in number) return list_question_categ.question_categ_code%type;
  function disease_aqurd_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2;
  function disease_excbt_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2;
  function disease_aqurd_riska_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2;
  function disease_categ_aqurd_flag (p_patient_prev_svc_sn in number,p_disease_categ_code in varchar2) return varchar2;
  function disease_categ_aqurd_riska_flag (p_patient_prev_svc_sn in number,p_disease_categ_code in varchar2) return varchar2;
  function disease_hx_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2;
  function non_cvd_diet_rf_flag (p_patient_prev_svc_sn in number) return varchar2;
  function cvd_diet_rf_level (p_patient_prev_svc_sn in number) return categ_score_eval.disease_level_code%type;
  function diet_rf_flag (p_patient_prev_svc_sn in number) return varchar2;
  function disease_fmhx_level (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return categ_score_eval.disease_level_code%type;
  function disease_rf_level (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return categ_score_eval.disease_level_code%type;
  function behavior_rf_level (p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return categ_score_eval.disease_level_code%type;
  function obesity_rf_level (p_bmi_result in varchar2) return categ_score_eval.disease_level_code%type;
  function seco_rf_level (p_financial_status_code in varchar2) return categ_score_eval.disease_level_code%type;
  function symptom_flag (p_patient_prev_svc_sn in number,p_symptom_code in varchar2) return varchar2;
  function pain_symptom_flag (p_patient_prev_svc_sn in number) return varchar2;
  function trouble_walking_flag (p_patient_prev_svc_sn in number) return varchar2;
  function patient_qualify_for_em_flag (p_patient_prev_svc_sn in number) return varchar2;
  function patient_latest_em_qual_flag (p_patient_sn in number) return varchar2;
  function patient_chronic_disease_cnt (p_patient_prev_svc_sn in number) return number;
  function user_role_id (p_username in varchar2) return "AspNetUserRoles".User_Role_ID%type;
  function patient_qualify_for_G0438 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_G0439 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_99202 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_99212 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_ccm (p_physician_sn in number,p_ccm_prev_svc_billing_code in varchar2) return t_number_tab PIPELINED;
  function patient_qualify_for_G0449 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_G0447 (p_physician_sn in number) return t_number_tab PIPELINED;
  function patient_qualify_for_svc (p_physician_sn in number,p_prev_svc_billing_code in varchar2) return t_number_tab PIPELINED;
  function awv_interview_time (p_patient_prev_svc_sn in number) return varchar2;
  function source_of_history (p_emr_flag in varchar2,p_patient_flag in varchar2,p_family_flag in varchar2) return varchar2;
  function patient_sn_of_pps_sn (p_patient_prev_svc_sn in number) return patient.patient_sn%type;
END common_inq_pkg;
/
show errors
create or replace PACKAGE BODY common_inq_pkg IS
  function patient_sn_of_pps_sn (p_patient_prev_svc_sn in number) return patient.patient_sn%type
  is
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    return v_patient_sn;
  end patient_sn_of_pps_sn;
  --
  function source_of_history (p_emr_flag in varchar2,p_patient_flag in varchar2,p_family_flag in varchar2) return varchar2
  as
  begin
    if (p_emr_flag = 'Y' and p_patient_flag = 'Y' and p_family_flag = 'Y') then return 'EMR, Patient(AWV/HRA) and Family/Caregiver';
    elsif (p_emr_flag = 'Y' and p_patient_flag = 'Y' and p_family_flag = 'N') then return 'EMR and Patient(AWV/HRA)';
    elsif (p_emr_flag = 'Y' and p_patient_flag = 'N' and p_family_flag = 'Y') then return 'EMR and Family/Caregiver';
    elsif (p_emr_flag = 'Y' and p_patient_flag = 'N' and p_family_flag = 'N') then return 'EMR';
    elsif (p_emr_flag = 'N' and p_patient_flag = 'Y' and p_family_flag = 'Y') then return 'Patient(AWV/HRA) and Family/Caregiver';
    elsif (p_emr_flag = 'N' and p_patient_flag = 'N' and p_family_flag = 'Y') then return 'Family/Caregiver';
    elsif (p_emr_flag = 'N' and p_patient_flag = 'Y' and p_family_flag = 'N') then return 'Patient(AWV/HRA)';
    else return null;
    end if;
  end source_of_history;
  --
  function awv_interview_time (p_patient_prev_svc_sn in number) return varchar2
  as
    v_return varchar2(100);
  begin
    select max(pr.z_create_tmstmp) - min(pr.z_create_tmstmp)
    into v_return
    from patient_response pr
        ,patient_prev_svc pps
    where pps.patient_prev_svc_sn = pr.patient_prev_svc_sn
    and pps.prev_svc_billing_code in ('G0438','G0439')
    and pps.svc_comp_flag = 'Y'
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    return v_return;
  exception
    when others then return null;
  end awv_interview_time;
  --
  function user_role_id (p_username in varchar2) return "AspNetUserRoles".User_Role_ID%type
  is
    v_user_role_id "AspNetUserRoles".user_role_id%type;
  begin
    select user_role_id
    into v_user_role_id
    from user_vw
    where user_name = lower(p_username)
    ;
    return v_user_role_id;
  exception
    when no_data_found then return null;
  end user_role_id;
  --
  function patient_chronic_disease_cnt (p_patient_prev_svc_sn in number) return number
  is
    v_chronic_disease_cnt number(9);
  begin
    select chronic_disease_cnt
    into v_chronic_disease_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    return v_chronic_disease_cnt;
  exception
    when others then return 0;
  end patient_chronic_disease_cnt;
  --
  function patient_latest_em_qual_flag (p_patient_sn in number) return varchar2
  is
    v_last_patient_prev_svc_sn number(11);
    v_qualify_em_flag varchar2(1);
  begin
    --get patient last awv service
    select max(pps.patient_prev_svc_sn)
    into v_last_patient_prev_svc_sn
    from patient p
        ,patient_prev_svc pps
    where p.patient_sn = pps.patient_sn
    and pps.svc_comp_flag = 'Y'
    and pps.prev_svc_billing_code in ('G0438','G0439')
    and p.patient_sn = p_patient_sn
    ;
    --check if the patient last AWV service qualify for EM
    begin
      select qualify_for_em_followup_flag
      into v_qualify_em_flag
      from patient_prev_svc
      where patient_prev_svc_sn = v_last_patient_prev_svc_sn
      ;
      return v_qualify_em_flag;
    exception
      when no_data_found then return 'N';
    end;
  end patient_latest_em_qual_flag;
  --
  function patient_qualify_for_em_flag (p_patient_prev_svc_sn in number) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and svc_comp_flag = 'Y'
    and qualify_for_em_followup_flag = 'Y'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end patient_qualify_for_em_flag;
  --
  function patient_qualify_for_svc (p_physician_sn in number,p_prev_svc_billing_code in varchar2) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    if p_prev_svc_billing_code = 'G0438' then --AWV initial
      for i in (select number_code patient_sn
                from table(patient_qualify_for_G0438(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code = 'G0439' then --AWV subsequent
      for i in (select number_code patient_sn
                from table(patient_qualify_for_G0439(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code = '99202' then --CCM Screening new patient
      for i in (select number_code patient_sn
                from table(patient_qualify_for_99202(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code = '99212' then --CCM Screening existing patient
      for i in (select number_code patient_sn
                from table(patient_qualify_for_99212(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code in ('99487','99490') then --CCM Counseling 20/60 min
      for i in (select number_code patient_sn
                from table(patient_qualify_for_ccm(p_physician_sn,p_prev_svc_billing_code))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code in ('G0449') then --Obesity Screening
      for i in (select number_code patient_sn
                from table(patient_qualify_for_G0449(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    elsif p_prev_svc_billing_code in ('G0447') then --Obesity Counseling
      for i in (select number_code patient_sn
                from table(patient_qualify_for_G0447(p_physician_sn))
                )
      loop
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end loop;
    end if;
  end patient_qualify_for_svc;
  --
  function patient_qualify_for_G0438 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    --Only the patients who has no records in the patient_prev_svc are qualified for service G0438
    for i in (select p.patient_sn
              from patient p
                  ,patient_prev_svc pps
              where p.patient_sn = pps.patient_sn(+)
              and pps.patient_sn is null
              and p.physician_sn = p_physician_sn
              )
    loop
      l_row.number_code := i.patient_sn;
      PIPE ROW (l_row);
    end loop;
  end patient_qualify_for_G0438;
  --
  function patient_qualify_for_G0439 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    --Only the patients who has records in the patient_prev_svc and last AWV service was done a year ago(12 months) will be qualified for G0439
    for i in (with
              patient_439_candidate AS
                  (select pps.patient_sn,max(pps.svc_perform_date) last_svc_perform_date
                  from patient p
                      ,patient_prev_svc pps
                  where p.patient_sn = pps.patient_sn
                  and pps.svc_comp_flag = 'Y'
                  and pps.prev_svc_billing_code in ('G0438','G0439')
                  and p.physician_sn = p_physician_sn
                  group by pps.patient_sn
                  )
              select pc.patient_sn
              from patient p
                  ,patient_439_candidate pc
              where p.patient_sn = pc.patient_sn
              and months_between(sysdate,pc.last_svc_perform_date) >= 12
              )
    loop
      l_row.number_code := i.patient_sn;
      PIPE ROW (l_row);
    end loop;
  end patient_qualify_for_G0439;
  --
  function patient_qualify_for_99202 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    --Only the patients who has been qualified for EM during AWV but no EM service has been scheduled
    for i in (with
              patient_em_candidate AS
                  (select pps.patient_sn
                  from patient p
                      ,patient_prev_svc pps
                  where p.patient_sn = pps.patient_sn
                  and pps.svc_comp_flag = 'Y'
                  and pps.qualify_for_em_followup_flag = 'Y'
                  and pps.prev_svc_billing_code in ('G0438','G0439')
                  and (p_physician_sn is null or p.physician_sn = p_physician_sn)
                  )
              select distinct pc.patient_sn
              from patient_prev_svc pps
                  ,patient_em_candidate pc
              where pc.patient_sn = pps.patient_sn(+)
              and pps.prev_svc_billing_code(+) in ('99202','99212')
              and pps.patient_sn is null
              )
    loop
      if patient_latest_em_qual_flag(i.patient_sn) = 'Y' then
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end if;
    end loop;
  end patient_qualify_for_99202;
  --
  function patient_qualify_for_99212 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
    v_pending_em_svc_cnt pls_integer;
  begin
    --Only the patients whose last AWV service has been qualified for EM and no PENDING EM services
    for i in (select pps.patient_sn
              from patient p
                  ,patient_prev_svc pps
              where p.patient_sn = pps.patient_sn
              and pps.svc_comp_flag = 'Y'
              and pps.qualify_for_em_followup_flag = 'Y'
              and pps.prev_svc_billing_code in ('G0438','G0439')
              and (p_physician_sn is null or p.physician_sn = p_physician_sn)
              )
    loop
      --If the last AWV service qualify for EM then check if there are any pending EM service
      if patient_latest_em_qual_flag(i.patient_sn) = 'Y' then
        select count(*)
        into v_pending_em_svc_cnt
        from patient_prev_svc
        where patient_sn = i.patient_sn
        and prev_svc_billing_code in ('99202','99212')
        and svc_comp_flag = 'N'
        and active_flag = 'Y'
        ;
        if v_pending_em_svc_cnt = 0 then --no pending service
          l_row.number_code := i.patient_sn;
          PIPE ROW (l_row);
        end if;
      end if;
    end loop;
  end patient_qualify_for_99212;
  --
  function patient_qualify_for_ccm (p_physician_sn in number,p_ccm_prev_svc_billing_code in varchar2) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    --Only the patients whose EM services has been completed and has been recommended (Rx) for a specific CCM service
    for i in (select distinct p.patient_sn
              from patient_prev_svc pps
                  ,patient p
                  ,physician_em pe
              where p.patient_sn = pps.patient_sn
              and pps.patient_prev_svc_sn = pe.patient_prev_svc_sn
              and pps.prev_svc_billing_code in ('99202','99212')
              and pps.svc_comp_flag = 'Y'
              and nvl(pe.rx_prev_svc_billing_code,'99999') = p_ccm_prev_svc_billing_code
              and p.physician_sn = p_physician_sn
              )
    loop
      if patient_latest_em_qual_flag(i.patient_sn) = 'Y' then
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end if;
    end loop;
  end patient_qualify_for_ccm;
  --Annual Obesity Screening
  function patient_qualify_for_G0449 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
    v_parent_patient_prev_svc_sn number(11);
    v_obesity_rf_avail_flag varchar2(1);
    v_cnt pls_integer;
  begin
    --Only the patients who has been identified as Obese (BMI >= 30) and have Obesity Risk Factor during AWV and no PENDING G0449 service
    for i in (with
              patient_G0449_candidate AS
                  (select pps.patient_sn
                  from patient p
                      ,patient_prev_svc pps
                      ,svc_result sr
                  where p.patient_sn = pps.patient_sn
                  and pps.patient_prev_svc_sn = sr.patient_prev_svc_sn
                  and sr.disease_code = 'OBES'
                  and sr.disease_severity_code = 'EXCBT'
                  and sr.obesity_rf_avail_flag = 'Y'
                  and pps.svc_comp_flag = 'Y'
                  and pps.prev_svc_billing_code in ('G0438','G0439')
                  and (p_physician_sn is null or p.physician_sn = p_physician_sn)
                  )
              select distinct pc.patient_sn
              from patient_prev_svc pps
                  ,patient_G0449_candidate pc
              where pc.patient_sn = pps.patient_sn(+)
              and pps.prev_svc_billing_code(+) = 'G0449'
              and pps.svc_comp_flag(+) = 'N'
              and pps.patient_sn is null
              )
    loop
      --For the qualified patients, check if the latest AWV is Obesity qualified. If the svc is Obesity qualified and have no child then the patient is fully quallified for G0449.
      --The parent patient_prev_svc_sn can have only one G0449. AWV is a yearly svc and that's how G0449 yearly frequency is managed.
      --
      --Get the last/latest AWV for the Patient
      select max(patient_prev_svc_sn)
      into v_parent_patient_prev_svc_sn
      from patient_prev_svc
      where patient_sn = i.patient_sn
      and prev_svc_billing_code in ('G0438','G0439')
      and svc_comp_flag = 'Y'
      ;
      --Check if the latest AWV is Obesity qualified
      begin
        select sr.obesity_rf_avail_flag
        into v_obesity_rf_avail_flag
        from patient_prev_svc pps
            ,svc_result sr
        where pps.patient_prev_svc_sn = sr.patient_prev_svc_sn
        and sr.disease_code = 'OBES'
        and sr.disease_severity_code = 'EXCBT'
        and pps.patient_prev_svc_sn = v_parent_patient_prev_svc_sn
        ;
      exception
        when no_data_found then v_obesity_rf_avail_flag := 'N';
      end;
      --Check if the latest parent have any G0449 child
      select count(*)
      into v_cnt
      from patient_prev_svc
      where prev_svc_billing_code = 'G0449'
      and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
      ;
      if v_obesity_rf_avail_flag = 'Y' and v_cnt = 0 then --no child
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end if;
    end loop;
  end patient_qualify_for_G0449;  
  --Obesity Counseling
  function patient_qualify_for_G0447 (p_physician_sn in number) return t_number_tab PIPELINED
  as
    l_row t_number_obj := t_number_obj(null);
    v_parent_patient_prev_svc_sn number(11);
    v_rx_prev_svc_billing_code varchar2(5);
    v_cnt pls_integer;
  begin
    --Only the patients whose Obesity Screening service (G0449) has been completed, has been recommended (Rx) for a Obesity Counseling service G0447 and no pending service
    for i in (with
              patient_G0447_candidate AS
                  (select p.patient_sn
                  from patient_prev_svc pps
                      ,patient p
                  where p.patient_sn = pps.patient_sn
                  and pps.prev_svc_billing_code = 'G0449'
                  and pps.svc_comp_flag = 'Y'
                  and nvl(pps.rx_prev_svc_billing_code,'99999') = 'G0447'
                  and p.physician_sn = p_physician_sn
                  )
              select distinct pc.patient_sn
              from patient_prev_svc pps
                  ,patient_G0447_candidate pc
              where pc.patient_sn = pps.patient_sn(+)
              and pps.prev_svc_billing_code(+) = 'G0447'
              and pps.svc_comp_flag(+) = 'N'
              and pps.patient_sn is null
              )
    loop
      --Latest AWV svc can have only one counseling svc
      --
      --Get the last/latest AWV svc for the Patient
      select max(patient_prev_svc_sn)
      into v_parent_patient_prev_svc_sn
      from patient_prev_svc
      where patient_sn = i.patient_sn
      and prev_svc_billing_code in ('G0438','G0439')
      and svc_comp_flag = 'Y'
      ;
      --Check if the parent have Obesity Screening svc
      begin
      select nvl(rx_prev_svc_billing_code,'99999')
      into v_rx_prev_svc_billing_code
      from patient_prev_svc
      where patient_sn = i.patient_sn
      and prev_svc_billing_code = 'G0449'
      and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
      ;
      exception
        when no_data_found then v_rx_prev_svc_billing_code := '99999';
      end;
      --Check if the latest parent have any Obesity Counseling svc G0447 (child)
      select count(*)
      into v_cnt
      from patient_prev_svc
      where prev_svc_billing_code = 'G0447'
      and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
      and patient_sn = i.patient_sn
      ;
      if v_rx_prev_svc_billing_code = 'G0447' and v_cnt = 0 then --no child
        l_row.number_code := i.patient_sn;
        PIPE ROW (l_row);
      end if;
    end loop;
  end patient_qualify_for_G0447;
  --
  function trouble_walking_flag (p_patient_prev_svc_sn in number) return varchar2
  is
    v_cnt1 pls_integer;
    v_cnt2 pls_integer;
  begin
    select count(*)
    into v_cnt1
    from patient_response_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = 'FRLT2'
    and question_code = '1003'
    and response_score <> 0
    ;
    select count(*)
    into v_cnt2
    from patient_response_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = 'FRLT1'
    and question_code = '1005'
    and response_score <> 0
    ;
    if (v_cnt1 + v_cnt2) = 0 then return 'N';
    else return 'Y';
    end if;
  end trouble_walking_flag;
  --
  function pain_symptom_flag (p_patient_prev_svc_sn in number) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from patient_response_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = 'MUSCS'
    and lower(question) like '%pain%'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end pain_symptom_flag;
  --
  function symptom_flag (p_patient_prev_svc_sn in number,p_symptom_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from patient_response_vw
    where symptom_code = p_symptom_code
    and patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end symptom_flag;
  --
  function seco_rf_level (p_financial_status_code in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_disease_level_code categ_score_eval.disease_level_code%type := 'LOW';
  begin
    if nvl(p_financial_status_code,'XXXX') in ('ONFA','ONSS') then --Mod risk
      v_disease_level_code := 'MOD';
    else
      v_disease_level_code := 'LOW';
    end if;
    return v_disease_level_code;
  end seco_rf_level;
  --
  function obesity_rf_level (p_bmi_result in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_disease_level_code categ_score_eval.disease_level_code%type := 'LOW';
  begin
    if p_bmi_result = 'Overweight' then
      v_disease_level_code := 'MOD';
    elsif p_bmi_result = 'Obese' then
      v_disease_level_code := 'HIG';
    else
      v_disease_level_code := 'LOW';
    end if;
    return v_disease_level_code;
  end obesity_rf_level;
  --
  --COPD/CKDE/STRK/CHDE//DIAB/HBPR/HCHO//DEPR/ANXT/STRS
  --Three groups. For Group 1 (COPD/CKDE/STRK/CHDE), just check if its available in PMHX. If yes then RF, else not a RF
  --For Group 2 (DIAB/HBPR/HCHO), check if there is PMHX. If yes then check if it is uncontrolled. If controlled, no RF. If no Hx, not a RF
  --For Group 3 (DEPR/ANXT/STRS), check if there is PMHX. If yes then RF. If not then check the test result
  function disease_rf_level (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_disease_level_code categ_score_eval.disease_level_code%type := 'LOW';
  begin
    if p_disease_code in ('COPD','CKDE','STRK','CHDE','DEPR','ANXT','STRS','BDIS','TDIS') then
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then
        v_disease_level_code := 'HIG';
      end if;
    elsif p_disease_code in ('DIAB','HBPR','HCHO') then
      --History and wrong behavior 
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then
        v_disease_level_code := common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,p_disease_code);
      end if;
    elsif p_disease_code = 'DEPR' then
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then
        v_disease_level_code := 'HIG';
      else
        if svc_eval_pkg.question_categ_answered(p_patient_prev_svc_sn,'GERDS') = 'Y' then
          v_disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'GERDS',null),'GERDS',null);
        end if;
      end if;
    elsif p_disease_code = 'ANXT' then
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then
        v_disease_level_code := 'HIG';
      else
        if svc_eval_pkg.question_categ_answered(p_patient_prev_svc_sn,'ANXIT') = 'Y' then
          v_disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'ANXIT',null),'ANXIT',null);
        end if;
      end if;
    elsif p_disease_code = 'STRS' then
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then
        v_disease_level_code := 'HIG';
      else
        if svc_eval_pkg.question_categ_answered(p_patient_prev_svc_sn,'HRSTS') = 'Y' then
          v_disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'HRSTS',null),'HRSTS',null);
        end if;
      end if;
    end if;
    return v_disease_level_code;
  end disease_rf_level;
  --
  function behavior_rf_level (p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_disease_level_code categ_score_eval.disease_level_code%type := 'LOW';
  begin
    begin
      select prv.disease_level_code
      into v_disease_level_code
      from patient_response_vw prv
          ,risk_factor_vw rfv
      where prv.risk_factor_code = rfv.risk_factor_code
      and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
      and prv.category_code = 'BEHVT'
      and prv.risk_factor_code = p_risk_factor_code
      ;
    exception
      when no_data_found then
        v_disease_level_code := 'LOW';
      when others then
        raise_application_error(-20221,sqlerrm);
    end;
    return v_disease_level_code;
  end behavior_rf_level;
  --
  function disease_fmhx_level (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_cnt pls_integer := 0;
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;    
    select count(*)
    into v_cnt
    from disease_risk_factor_vw drfv
        ,patient_history_vw prv
    where prv.risk_factor_code = drfv.risk_factor_code
    and prv.disease_code = drfv.disease_code
    and drfv.disease_code = p_disease_code
    and drfv.risk_factor_code = 'FMHX'
    and prv.response_code <> 'NON'
    and prv.patient_sn = v_patient_sn
    ;
    --Parents(any) died before age of 50? is a risk factor for CNCR and also for CHDE. The question response have
    --only one column (disease) to associate with this question and CNCR is the disease which has been associated.
    --So for CHDE, seperate inquiry needs to be made to evaluate FMHX of a disease.
    if p_disease_code = 'CHDE' then
      if report_pkg.patient_categ_qtn_response(p_patient_prev_svc_sn,'FHNMR','1014') <> 'NON' then
        v_cnt := v_cnt + 1;  
      end if;
    end if;
    --
    if v_cnt > 0 then return 'HIG';
    else return 'LOW';
    end if;
  end disease_fmhx_level;
  --Respective diet RF codes are ('DTDR','DTFF','DTFR','DTVG','DTGR')
  function cvd_diet_rf_level (p_patient_prev_svc_sn in number) return categ_score_eval.disease_level_code%type
  is
    v_hig_cnt pls_integer := 0;
    v_mod_cnt pls_integer := 0;
  begin
    for i in (select prv.disease_level_code,count(*) cnt
              from patient_response_vw prv
                  ,risk_factor_vw rfv
              where prv.risk_factor_code = rfv.risk_factor_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              and prv.category_code = 'BEHVT'
              and rfv.diet_categ_flag = 'Y'
              and rfv.risk_factor_categ_code in ('DAW','DHM')
              group by prv.disease_level_code
              )
    loop
      if i.disease_level_code = 'HIG' then
        v_hig_cnt := i.cnt;
      else
        v_mod_cnt := i.cnt;
      end if;
    end loop;
    --
    if v_hig_cnt = 1 then --max 1 for HIG and max 4 for MOD
      if v_mod_cnt between 3 and 4 then return 'SEV';
      else return 'HIG';
      end if;
    else --hig 0
      if v_mod_cnt = 4 then return 'HIG';
      elsif v_mod_cnt between 2 and 3 then return 'MOD';
      else return 'LOW';
      end if;
    end if;
  end cvd_diet_rf_level;
  --
  function non_cvd_diet_rf_flag (p_patient_prev_svc_sn in number) return varchar2
  is
    v_cnt pls_integer := 0;
  begin
    select count(*)
    into v_cnt
    from patient_response_vw prv
        ,risk_factor_vw rfv
    where prv.risk_factor_code = rfv.risk_factor_code
    and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
    and prv.category_code = 'BEHVT'
    and rfv.risk_factor_code in ('DTFF','DTSG','DTST')
    and rfv.diet_categ_flag = 'Y'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end non_cvd_diet_rf_flag;
  --
  function diet_rf_flag (p_patient_prev_svc_sn in number) return varchar2
  is
  begin
    if cvd_diet_rf_level(p_patient_prev_svc_sn) <> 'LOW' or non_cvd_diet_rf_flag(p_patient_prev_svc_sn) = 'Y' then return 'Y';
    else return 'N';
    end if;
  end diet_rf_flag;
  --
  function disease_hx_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_cnt_bmedh pls_integer;
    v_cnt_behvt pls_integer;
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;    
    select count(*)
    into v_cnt_bmedh
    from patient_history_vw 
    where patient_sn = v_patient_sn
    and category_code = 'BMEDH'
    and disease_code = p_disease_code
    ;
    select count(*)
    into v_cnt_behvt
    from patient_response_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = 'BEHVT'
    and disease_code = p_disease_code
    ;
    if (v_cnt_bmedh + v_cnt_behvt) = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_hx_flag;
  --
  function disease_aqurd_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code = p_disease_code
    and disease_severity_code <> 'RISKA'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_aqurd_flag;
  --EXCBT
  function disease_excbt_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code = p_disease_code
    and disease_severity_code = 'EXCBT'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_excbt_flag;
  --
  function disease_aqurd_riska_flag (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code = p_disease_code
    and disease_level_code <> 'LOW'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_aqurd_riska_flag;
  --
  function disease_categ_aqurd_riska_flag (p_patient_prev_svc_sn in number,p_disease_categ_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_categ_code = p_disease_categ_code
    and disease_level_code <> 'LOW'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_categ_aqurd_riska_flag;
  --
  function disease_categ_aqurd_flag (p_patient_prev_svc_sn in number,p_disease_categ_code in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_categ_code = p_disease_categ_code
    and disease_severity_code <> 'RISKA'
    and disease_level_code <> 'LOW'
    ;
    if v_cnt = 0 then return 'N';
    else return 'Y';
    end if;
  end disease_categ_aqurd_flag;
  --
  function response_score (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return categ_score_eval.disease_level_code%type
  is
    v_trigger_further_categ_flag categ_score_eval.trigger_further_categ_flag%type;
    v_disease_level_code categ_score_eval.disease_level_code%type;
  begin
    response_score_prc(p_categ_score_sum,p_category_code,p_sub_category_code,v_trigger_further_categ_flag,v_disease_level_code);
    return v_disease_level_code;
  end response_score;
  --
  function response_trigger_further_categ (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return categ_score_eval.trigger_further_categ_flag%type
  is
    v_trigger_further_categ_flag categ_score_eval.trigger_further_categ_flag%type;
    v_disease_level_code categ_score_eval.disease_level_code%type;
  begin
    response_score_prc(p_categ_score_sum,p_category_code,p_sub_category_code,v_trigger_further_categ_flag,v_disease_level_code);
    return v_trigger_further_categ_flag;
  end response_trigger_further_categ;
  --
  procedure response_score_prc (p_categ_score_sum in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type,p_trigger_further_categ_flag out categ_score_eval.trigger_further_categ_flag%type,p_disease_level_code out categ_score_eval.disease_level_code%type)
  is
  begin
    select trigger_further_categ_flag
          ,disease_level_code
    into p_trigger_further_categ_flag
        ,p_disease_level_code
    from categ_score_eval_vw
    where category_code = p_category_code
    and nvl(sub_category_code,'XX') = nvl(p_sub_category_code,'XX')
    and p_categ_score_sum between score_range_begin and score_range_end 
    ;
  end response_score_prc;
  --
  function categ_score_sum (p_patient_prev_svc_sn in number,p_category_code in list_question_categ.question_categ_code%type,p_sub_category_code in list_question_sub_categ.question_sub_categ_code%type) return number
  is
    v_categ_score_sum number(9);
  begin
    select nvl(sum(response_score),0) 
    into v_categ_score_sum
    from patient_response_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = p_category_code
    and nvl(sub_category_code,'XX') = nvl(p_sub_category_code,'XX')
    ;
    return v_categ_score_sum;
  end categ_score_sum;
  --
  procedure load_common_info_json (p_lang_code in list_lang.lang_code%type default 'en',p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type)
  is
    v_out clob; --varchar2(32767);
  begin
    common_inq_pkg.common_info_init(p_lang_code,p_prev_svc_type_code,v_out);
    common_pkg.upd_appl_control_value_clob (p_prev_svc_type_code,'COMMON_INFO_JSON',v_out);
  end load_common_info_json;
  --
  PROCEDURE common_info (p_locale in varchar2,p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type,p_out OUT clob)
  as
  begin
    p_out := common_pkg.appl_control_value_clob(p_prev_svc_type_code,'COMMON_INFO_JSON');
  END common_info;
  --
  PROCEDURE common_info_init  (p_locale in varchar2,p_prev_svc_type_code in list_prev_svc_type.prev_svc_type_code%type,p_out OUT clob)
  as
    --This method will return common json of all the list tables
    --
    obj json;
    obj2 json;
    obj3 json;
    l_obj json_list;
    l_obj2 json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --====================================================trans_lang
    l_obj := json_list(); --an empty list obj
    for i in (select distinct af.APPL_FUNCTIONALITY_CODE
                    ,af.DESCR
              from list_appl_functionality af
                  ,trans_lang tl
              where af.appl_functionality_code = tl.appl_functionality_code
              and tl.culture = v_lang_code
              and af.active_flag = 'Y'
              order by af.APPL_FUNCTIONALITY_CODE
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('APPL_FUNCTIONALITY_CODE',i.APPL_FUNCTIONALITY_CODE);
      obj2.put('DESCR',i.descr);
      --============================trans_lang name/value begin
      l_obj2 := json_list(); --an empty list obj
      for j in (select tl.NAME
                      ,tl.VALUE
                      ,tl.LONG_VALUE
                      ,tl.TITLE_1
                      ,tl.TITLE_2
                from trans_lang tl
                    ,list_appl_functionality af
                where tl.appl_functionality_code = af.appl_functionality_code
                and af.appl_functionality_code = i.appl_functionality_code
                and tl.active_flag = 'Y'
                and af.active_flag = 'Y'
                and tl.culture = v_lang_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.NAME);
        obj3.put('VALUE',j.VALUE);
        obj3.put('LONG_VALUE',j.LONG_VALUE);
        obj3.put('TITLE_1',j.TITLE_1);
        obj3.put('TITLE_2',j.TITLE_2);
        --Append the object to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('name_value', l_obj2);
      end if;
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('trans_lang', l_obj);
    end if;
    --==========================output
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end common_info_init;
  --
  PROCEDURE get_country_state_data  (p_locale in varchar2
                                    ,p_country_code in country.country_code%type
                                    ,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================state
    l_obj := json_list(); --an empty list obj
    for i in (select s.state_code code
                    ,s.name
              from country c
                  ,state s
              where c.country_code = s.country_code
              and c.country_code = p_country_code
              order by s.name
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('NAME',i.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('country_state', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end get_country_state_data;
  --
  PROCEDURE patient_signature (p_patient_prev_svc_sn in number,p_out OUT clob)
  as
    obj         json;
  begin
    obj := json(); --an empty structure
    for i in (select patient_signature
              from patient_prev_svc
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      obj.put('SIGNATURE',i.patient_signature);
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_signature;
  --
  PROCEDURE user_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================user
    l_obj := json_list(); --an empty list obj
    for i in (select user_role_id code
                    ,email
                    ,phone
                    ,name
                    ,status
                    ,role_name
              from user_vw
              where role_id not in ('96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('NAME',i.name);
      obj2.put('ROLE',i.role_name);
      obj2.put('STATUS',i.status);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end user_list;
  --This active_user_list method is used during the creation of Service Provider
  --So, this list is nothing but prospective Service Provider or the user in this list can provide service
  --The name is misleading and will try to change down the road.
  PROCEDURE active_user_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================active_user
    l_obj := json_list(); --an empty list obj
    for i in (select email
                    ,phone
                    ,name
                    ,role_name
                    ,user_role_id code
              from active_user_vw
              where role_id in ('DF56C6ED00FF47AC84754BDF1517FB83','3951E214B3F746BD924AFF39CABEA511','79F450777D2E4B6AB98FECB17974FDEB','943DF69DD1744FA2BED92A55C2800C57')
              and user_role_id not in (select physician_user_role_id from provider_physician)
              and user_is_a_provider_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('NAME',i.name);
      obj2.put('ROLE',i.role_name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('active_user_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end active_user_list;  
  --
  PROCEDURE new_user_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================new_user
    l_obj := json_list(); --an empty list obj
    for i in (select uvw.user_role_id code
                    ,uvw.email
              from active_user_vw uvw
              where uvw.role_id = 'a74f52c5-4d3a-46d9-bc22-a5eafa982849' --Prospective User
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('EMAIL',i.email);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end new_user_list;
  --
  PROCEDURE primary_physician (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================primary_physician
    l_obj := json_list(); --an empty list obj
    for i in (select physician_sn
                    ,name
                    ,company_name
                    ,company_addr
                    ,physician_type
                    ,license_num
                    ,npi
                    ,email
                    ,phone
                    ,status
                    ,created_by
                    ,updated_by
              from physician_vw
              where physician_type_lang = v_lang_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PHYSICIAN_SN',i.physician_sn);
      obj2.put('NAME',i.name);
      obj2.put('COMPANY_NAME',i.company_name);
      obj2.put('COMPANY_ADDR',i.company_addr);
      obj2.put('PHYSICIAN_TYPE',i.physician_type);
      obj2.put('LICENSE_NUM',i.license_num);
      obj2.put('NPI',i.npi);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('STATUS',i.status);
      obj2.put('CREATED_BY_USERNAME',i.created_by);
      obj2.put('UPDATED_BY_USERNAME',i.updated_by);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('primary_physician', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end primary_physician;
  --
  PROCEDURE provider_physician (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================provider_physician
    l_obj := json_list(); --an empty list obj
    for i in (select provider_physician_sn
                    ,name
                    ,company_name
                    ,company_addr
                    ,physician_type
                    ,license_num
                    ,npi
                    ,email
                    ,phone
                    ,status
                    ,created_by
                    ,updated_by
              from provider_physician_vw
              where physician_type_lang = v_lang_code
              and user_role_active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PROVIDER_PHYSICIAN_SN',i.provider_physician_sn);
      obj2.put('NAME',i.name);
      obj2.put('COMPANY_NAME',i.company_name);
      obj2.put('COMPANY_ADDR',i.company_addr);
      obj2.put('PHYSICIAN_TYPE',i.physician_type);
      obj2.put('NPI',i.npi);
      obj2.put('LICENSE_NUM',i.license_num);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('STATUS',i.status);
      obj2.put('CREATED_BY_USERNAME',i.created_by);
      obj2.put('UPDATED_BY_USERNAME',i.updated_by);      
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('provider_physician', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end provider_physician;
  --
  PROCEDURE company_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --=====================company
    l_obj := json_list(); --an empty list obj
    for i in (select company_sn
                    ,addr
                    ,name
                    ,contact_name
                    ,phone
                    ,fax
                    ,toll_free
                    ,website
                    ,status
                    ,created_by
                    ,updated_by
              from company_vw
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('COMPANY_SN',i.company_sn);
      obj2.put('NAME',i.name);
      obj2.put('ADDR',i.addr);
      obj2.put('CONTACT_NAME',i.contact_name);
      obj2.put('PHONE',i.phone);
      obj2.put('FAX',i.fax);
      obj2.put('TOLL_FREE',i.toll_free);
      obj2.put('WEBSITE',i.website);
--      obj2.put('STATUS',i.status);
--      obj2.put('CREATED_BY_USERNAME',i.created_by);
--      obj2.put('UPDATED_BY_USERNAME',i.updated_by);      
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('company_list', l_obj);
    end if;
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end company_list;
  --One NON ITH user can have control/view of patients under more than one company. User will have two types of company association.
  --One is the primary company or where the user works in. Beside the primary company, user can have priviledge of more than one
  --company. This function will return all the company user have control or association with.
  --
  function user_role_company_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_company_sn');
    v_err_msg := null;
    --
    for i in (select company_sn 
              from user_vw 
              where user_role_id = p_user_role_id
              union
              select company_sn
              from user_company
              where user_role_id = p_user_role_id
              and active_flag = 'Y'
              )
    loop
      l_row.number_code := i.company_sn;
      PIPE ROW (l_row);
    end loop;
  end user_role_company_sn;
  --One NON ITH user can have control/view of patients under more than one company. User will have two types of company association.
  --One is the primary company or where the user works in. Beside the primary company, user can have priviledge of more than one
  --company. This function will return all the company user have control or association with.
  --
  PROCEDURE conditional_company_list (p_locale in varchar2,p_user in varchar2,p_ithealth_company_flag in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_ithealth_company_flag varchar2(1);
    e_invalid_user exception;
  begin
    v_proc_name := upper('conditional_company_list');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_ithealth_company_flag: '||p_ithealth_company_flag;
    --
    --This conditional_company_list data return is controlled by the internal parameter v_user_role_id. This parameter is 
    --set to null for ITH USER who will have view/control of all the companies. Non ITH USER will have control/view of specific companies (patients)
    --
    if p_user is null then
      raise e_invalid_user;
    else
      select ithealth_company_flag
            ,user_role_id
      into v_ithealth_company_flag
          ,v_user_role_id
      from user_vw 
      where user_name = p_user
      ;
      if v_ithealth_company_flag = 'Y' then
        v_user_role_id := null;
      end if;
      --
      p_out := 'abc'; --initialize the clob
      obj := json(); --an empty structure
      --=====================company
      l_obj := json_list(); --an empty list obj
      for i in (select company_sn
                      ,addr
                      ,name
                      ,contact_name
                from company_vw
                where (p_ithealth_company_flag is null or ithealth_company_flag = p_ithealth_company_flag)
                and (v_user_role_id is null or company_sn in (select number_code from table(common_inq_pkg.user_role_company_sn(v_user_role_id))))
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('COMPANY_SN',i.company_sn);
        obj2.put('NAME',i.name||' - '||i.addr);
        --Append obj2 to the list
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('company_list', l_obj);
      end if;
      --===================================== end of json building
      dbms_lob.trim(p_out, 0); --empty the lob
      obj.to_clob(p_out);
    end if;
  exception
    when e_invalid_user then
      v_err_msg := 'User Email is required';
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20010,v_err_msg);
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20011,v_err_msg);
  end conditional_company_list;
  --
  PROCEDURE patient_with_pend_svc (p_locale in varchar2,p_user_name in "AspNetUsers"."UserName"%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    obj4        json;
    l_obj       json_list;
    l_obj2      json_list;
    l_obj3      json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_physician_sn physician.physician_sn%type;
    v_ccm_contact_name varchar2(100);
    v_ccm_contact_ph varchar2(100);
    v_ccm_contact_addr varchar2(100);
    v_role_id "AspNetRoles"."Id"%type;
    v_user_name "AspNetUsers"."UserName"%type;
    v_obes_patient_prev_svc_sn number(11);
    e_InvalidUser exception;
  begin
  --10/13/2017 (mh)
  --The following section was designed to give non service provider the pending service view (view only), where service provider can 
  --only perform the service. This design was having problem when service provider is admin also. When service provider is admin can
  --see the pending service but can't perform the service. 
  --Modified design is to return data only to user who owns the service. User can be in any role (Data Entry, Admin, Lead etc.).
  --The system have separate qualification for Service provider (e.g. LPN, Nurse etc.). 
--    begin
--      select role_id
--      into v_role_id
--      from user_vw
--      where user_name = lower(p_user_name)
--      ;
--      --Admin can see all the schedules but only assigned provider can perform the service. When Admin click any service link will error out if the 
--      --service is not assigned to that Admin user.
--      if v_role_id in ('3951E214B3F746BD924AFF39CABEA511','943DF69DD1744FA2BED92A55C2800C57','96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76') then
--        v_user_name := null;
--      else
--        v_user_name := lower(p_user_name);
--      end if;
--    exception
--      when no_data_found then
--        raise e_InvalidUser;
--    end;
    v_proc_name := upper('patient_with_pend_svc');
    v_user_name := lower(p_user_name);
    common_dml_pkg.ins_user_login(user_role_id(v_user_name),v_pkg_name,v_proc_name,null,null,null,null,null);
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    l_obj := json_list(); --an empty list obj
    --
    v_ccm_contact_name := common_pkg.appl_control_value_alpha('CCM','CONTACT_NAME');
    v_ccm_contact_ph := common_pkg.appl_control_value_alpha('CCM','CONTACT_PH');
    v_ccm_contact_addr := common_pkg.appl_control_value_alpha('CCM','CONTACT_ADDR');
    --
    for m in (select distinct pps.patient_sn
              from patient_prev_svc pps
                  ,provider_physician pp
                  ,user_vw uv
                  ,list_prev_svc_billing psb
              where pps.provider_physician_sn = pp.provider_physician_sn
              and pp.physician_user_role_id = uv.user_role_id
              and pps.prev_svc_billing_code = psb.prev_svc_billing_code
              and (v_user_name is null or uv.user_name = v_user_name)
              and pps.svc_comp_flag = 'N'
              and pps.active_flag = 'Y'
              )
    loop
      --=====================patient
      for i in (select patient_sn
                      ,ssn
                      ,physician_name
                      ,physician_company
                      ,lpad(nvl(substr(medicare_hic_num,-5,5),'99999'),10,'x') medicare_hic_num
                      ,addr
                      ,gender
                      ,race
                      ,age
                      ,ethnicity
                      ,first_name
                      ,middle_name
                      ,last_name
                      ,name
                      ,phone
                      ,email
                      ,skype
                      ,birth_date
                      ,legal_guardian_name
                      ,legal_guardian_ph
                from patient_vw
                where patient_sn = m.patient_sn
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('PATIENT_SN',i.patient_sn);
        obj2.put('SSN',i.ssn);
        obj2.put('PHYSICIAN_NAME',i.PHYSICIAN_NAME);
        obj2.put('CCM_CONTACT_NAME',v_ccm_contact_name);
        obj2.put('CCM_CONTACT_PH',v_ccm_contact_ph);
        obj2.put('CCM_CONTACT_ADDR',v_ccm_contact_addr);
        obj2.put('CCM_AGMT_DATE',to_char(sysdate,'MM/DD/YYYY'));
        obj2.put('PHYSICIAN_COMPANY',i.PHYSICIAN_COMPANY);
        obj2.put('MEDICARE_HIC_NUM',i.MEDICARE_HIC_NUM);
        obj2.put('ADDR',i.ADDR);
        obj2.put('GENDER',i.GENDER);
        obj2.put('RACE',i.RACE);
        obj2.put('ETHNICITY',i.ETHNICITY);
        obj2.put('NAME',i.NAME||' - '||i.age||' y/o');
        obj2.put('FIRST_NAME',i.FIRST_NAME);
        obj2.put('MIDDLE_NAME',i.MIDDLE_NAME);
        obj2.put('LAST_NAME',i.LAST_NAME);
        obj2.put('PHONE',i.PHONE);
        obj2.put('EMAIL',i.EMAIL);
        obj2.put('BIRTH_DATE',i.BIRTH_DATE);
        --=====================patient_prev_svc
        --For Obesity IBT (G0447), there will be 22 service line at the begining.
        --Only pick the immediate pending service (min svc_number among non complete services).
        --
        --In below, instead of finding min svc_number, min patient_prev_svc_sn is done. The records are being created in order
        --and in future when other similar services being added will follow the same logic (two different services could have the same svc_number)
        --
        begin
          select min(patient_prev_svc_sn)
          into v_obes_patient_prev_svc_sn
          from patient_prev_svc pps
              ,provider_physician pp
              ,user_vw uv
              ,list_prev_svc_billing psb
          where pps.provider_physician_sn = pp.provider_physician_sn
          and pp.physician_user_role_id = uv.user_role_id
          and pps.prev_svc_billing_code = psb.prev_svc_billing_code
          and uv.user_name = v_user_name
          and pps.patient_sn = i.patient_sn
          and pps.prev_svc_billing_code = 'G0447'
          and pps.svc_comp_flag = 'N'
          and pps.active_flag = 'Y'
          ;
        exception
          when no_data_found then v_obes_patient_prev_svc_sn := -99999;
        end;
        --
        l_obj2 := json_list(); --an empty list obj
        for j in (select pps.patient_prev_svc_sn
                        ,pps.svc_date
                        ,pps.g0438_comp_on_diff_sys_flag
                        ,pps.svc_comp_flag completed_flag
                        ,pslv.svc_location_name
                        ,pslv.svc_location_addr
                        ,psbl.prev_svc_billing_code billing_code
                        ,psbl.short_descr billing_code_descr
                        ,pstl.short_descr svc_type
                        ,pst.prev_svc_type_code svc_type_code
                        ,psb.prev_svc_type_code||'('||psbl.short_descr||')' svc_name
                        ,pps.height_in_in
                  from patient_prev_svc pps
                      ,physician_svc_location_vw pslv
                      ,list_prev_svc_billing psb
                      ,prev_svc_billing_lang psbl
                      ,list_prev_svc_type pst
                      ,prev_svc_type_lang pstl
                      ,provider_physician pp
                      ,user_vw uv
                  where pps.provider_physician_sn = pp.provider_physician_sn
                  and pp.physician_user_role_id = uv.user_role_id
                  and pps.physician_svc_location_sn = pslv.physician_svc_location_sn
                  and pps.prev_svc_billing_code = psb.prev_svc_billing_code
                  and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
                  and psbl.lang_code = v_lang_code
                  and psb.prev_svc_type_code = pst.prev_svc_type_code
                  and pst.prev_svc_type_code = pstl.prev_svc_type_code
                  and pstl.lang_code = v_lang_code
                  and pps.patient_sn = i.patient_sn
                  and (v_user_name is null or uv.user_name = v_user_name)
                  and pps.prev_svc_billing_code in ('G0438','G0439','99202','99212','99487','99490','G0449')
                  and pps.svc_comp_flag = 'N'
                  and pps.active_flag = 'Y'
                  union
                  select pps.patient_prev_svc_sn
                        ,pps.svc_date
                        ,pps.g0438_comp_on_diff_sys_flag
                        ,pps.svc_comp_flag completed_flag
                        ,pslv.svc_location_name
                        ,pslv.svc_location_addr
                        ,psbl.prev_svc_billing_code billing_code
                        ,psbl.short_descr billing_code_descr
                        ,pstl.short_descr svc_type
                        ,pst.prev_svc_type_code svc_type_code
                        ,psb.prev_svc_type_code||'('||psbl.short_descr||')' svc_name
                        ,pps.height_in_in
                  from patient_prev_svc pps
                      ,physician_svc_location_vw pslv
                      ,list_prev_svc_billing psb
                      ,prev_svc_billing_lang psbl
                      ,list_prev_svc_type pst
                      ,prev_svc_type_lang pstl
                      ,provider_physician pp
                      ,user_vw uv
                  where pps.provider_physician_sn = pp.provider_physician_sn
                  and pp.physician_user_role_id = uv.user_role_id
                  and pps.physician_svc_location_sn = pslv.physician_svc_location_sn
                  and pps.prev_svc_billing_code = psb.prev_svc_billing_code
                  and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
                  and psbl.lang_code = v_lang_code
                  and psb.prev_svc_type_code = pst.prev_svc_type_code
                  and pst.prev_svc_type_code = pstl.prev_svc_type_code
                  and pstl.lang_code = v_lang_code
                  and pps.patient_sn = i.patient_sn
                  and (v_user_name is null or uv.user_name = v_user_name)
                  and pps.prev_svc_billing_code in ('G0447')
                  and pps.svc_comp_flag = 'N'
                  and pps.active_flag = 'Y'
                  and pps.patient_prev_svc_sn in (v_obes_patient_prev_svc_sn)
                  )
        loop
          obj3 := json(); --an empty structure
          obj3.put('PATIENT_PREV_SVC_SN',j.patient_prev_svc_sn);
          obj3.put('TITLE',j.billing_code_descr);
          obj3.put('SVC_DATE',j.svc_date);
          obj3.put('SVC_LOCATION_NAME',j.svc_location_name);
          obj3.put('SVC_LOCATION_ADDR',j.svc_location_addr);
          obj3.put('BILLING_CODE',j.billing_code);
          obj3.put('SVC_TYPE',j.svc_type);
          obj3.put('SVC_TYPE_CODE',j.svc_type_code);
          if j.height_in_in is not null then
            obj3.put('BENE_ASSESSMENT_COMP_FLAG','Y');
          else
            obj3.put('BENE_ASSESSMENT_COMP_FLAG','N');
          end if;
          ---------------------------svc_menu
          l_obj3 := json_list(); --an empty list obj
          obj4 := json(); --an empty structure
          if j.svc_type_code = 'AWV' then
            if j.billing_code = 'G0438' then
              obj4.put('NAME','AWV(Health Risk Assessment(HRA), Initial)');
            elsif j.billing_code = 'G0439' then
              obj4.put('NAME','AWV(Health Risk Assessment(HRA), Subsequent)');
            end if;
            l_obj3.append(obj4.to_json_value);
            obj4.put('NAME','Medication');
            l_obj3.append(obj4.to_json_value);
            obj4.put('NAME','Remark');
            l_obj3.append(obj4.to_json_value);
          elsif j.svc_type_code = 'E/M' then
            obj4.put('NAME',j.svc_name);
            l_obj3.append(obj4.to_json_value);
          elsif j.svc_type_code = 'IBT' then
            if j.billing_code = 'G0447' then
              obj4.put('NAME',j.svc_name);
            elsif j.billing_code = 'G0449' then
              obj4.put('NAME',j.svc_name);
            end if;
            l_obj3.append(obj4.to_json_value);
          elsif j.svc_type_code = 'CCM' then
            obj4.put('NAME',j.svc_name);
            l_obj3.append(obj4.to_json_value);
          end if;
          --
          if json_ac.array_count(l_obj3) > 0 then
            obj3.put('svc_menu', l_obj3);
          end if;
          --=====================patient_prev_svc_remark
          l_obj3 := json_list(); --an empty list obj
          for k in (select PATIENT_PREV_SVC_REMARK_SN
                          ,REMARK_NOTE
                    from patient_prev_svc_remark
                    where PATIENT_PREV_SVC_SN = j.PATIENT_PREV_SVC_SN
                    )
          loop
            obj4 := json(); --an empty structure
            obj4.put('PATIENT_PREV_SVC_REMARK_SN',k.PATIENT_PREV_SVC_REMARK_SN);
            obj4.put('REMARK_NOTE',k.REMARK_NOTE);
            --Append obj4 to the list
            l_obj3.append(obj4.to_json_value);
          end loop;
          --
          if json_ac.array_count(l_obj3) > 0 then
            obj3.put('patient_prev_svc_remark', l_obj3);
          end if;      
          --Append obj3 to the list
          l_obj2.append(obj3.to_json_value);
        end loop;
        --
        if json_ac.array_count(l_obj2) > 0 then
          obj2.put('patient_prev_svc', l_obj2);
        end if;
        --=====================patient_medication
        l_obj2 := json_list(); --an empty list obj
        for j in (select patient_medication_sn
                        ,name
                        ,quantity
                        ,quantity_unit
                        ,ingredients
                        ,purpose
                        ,frequency
                        ,frequency_unit
                        ,medication_current_flag
                        ,prescribed_med_flag
                        ,notes
                        ,created_by
                        ,updated_by
                        ,status
                  from patient_medication_vw
                  where patient_sn = i.patient_sn
                  and frequency_lang_code = v_lang_code
                  and medication_unit_lang_code = v_lang_code
                  )
        loop
          obj3 := json(); --an empty structure
          obj3.put('PATIENT_MEDICATION_SN',j.patient_medication_sn);
          obj3.put('NAME',j.name);
          obj3.put('QUANTITY',j.quantity);
          obj3.put('QUANTITY_UNIT',j.quantity_unit);
          obj3.put('INGREDIENTS',j.ingredients);
          obj3.put('PURPOSE',j.purpose);
          obj3.put('FREQUENCY',j.frequency);
          obj3.put('FREQUENCY_UNIT',j.frequency_unit);
          obj3.put('CURRENT',j.medication_current_flag);
          obj3.put('PRESCRIBED_MED_FLAG',j.PRESCRIBED_MED_FLAG);
          obj3.put('NOTES',j.notes);
          obj3.put('CREATED_BY_USERNAME',j.created_by);
          obj3.put('UPDATED_BY_USERNAME',j.updated_by);      
          --Append obj2 to the list
          l_obj2.append(obj3.to_json_value);
        end loop;
        --
        if json_ac.array_count(l_obj2) > 0 then
          obj2.put('patient_medication', l_obj2);
        end if;
        --Append obj2 to the list
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('patient_list', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  exception
    when e_InvalidUser then
      raise_application_error(-20100,'Invalid User');
    when others then
      raise_application_error(-20101,sqlerrm);
  end patient_with_pend_svc;
  --
  PROCEDURE patient_list (p_locale in varchar2,p_physician_sn in number,p_prev_svc_billing_code in list_PREV_SVC_BILLING.prev_svc_billing_code%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    obj4        json;
    l_obj       json_list;
    l_obj2      json_list;
    l_obj3      json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_physician_name varchar2(200);
  begin
    --v_input_str := 'p_physician_sn: '||p_physician_sn||'-'||'p_prev_svc_billing_code: '||p_prev_svc_billing_code;
    --common_pkg.ins_appl_process_log('COMMON_INQ_PKG','PATIENT_LIST','N',null,null,v_input_str,null);
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for i in (select patient_sn
                    ,ssn
                    ,physician_name
                    ,physician_company
                    ,medicare_hic_num
                    ,addr
                    ,gender
                    ,race
                    ,ethnicity
                    ,name
                    ,phone
                    ,birth_date
              from patient_vw
              where gender_lang_code = v_lang_code
              and race_lang_code = v_lang_code
              and ethnicity_lang_code = v_lang_code
              and physician_sn = p_physician_sn
              and patient_sn in (select number_code patient_sn from table(patient_qualify_for_svc(p_physician_sn,p_prev_svc_billing_code)))
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_SN',i.patient_sn);
      obj2.put('NAME',i.NAME||' - '||i.birth_date||'('||i.medicare_hic_num||')'); --currently display in the drop down list
      obj2.put('DATA_GRID_NAME',i.name);
      obj2.put('GENDER',i.gender);
      obj2.put('HIC',i.medicare_hic_num);
      obj2.put('DOB',i.birth_date);
      obj2.put('PH',i.phone);
      obj2.put('ADDR',i.addr);
      obj2.put('MSG','');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_list', l_obj);
    else
      select name
      into v_physician_name
      from physician_vw
      where physician_sn = p_physician_sn
      ;
      obj2 := json(); --an empty structure
      obj2.put('NAME','No Qualified Patients for "'||p_prev_svc_billing_code||'" under '||v_physician_name);
      obj2.put('MSG','No Qualified Patients for "'||p_prev_svc_billing_code||'" under '||v_physician_name);
      l_obj.append(obj2.to_json_value);
      obj.put('patient_list', l_obj);
    end if;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_list;
  --
  PROCEDURE patient_medication (p_locale in varchar2,p_patient_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for j in (select PATIENT_MEDICATION_SN
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
              and frequency_lang_code = v_lang_code
              and medication_unit_lang_code = v_lang_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_MEDICATION_SN',j.patient_medication_sn);
      obj2.put('NAME',j.name);
      obj2.put('QUANTITY',j.quantity);
      obj2.put('QUANTITY_UNIT',j.quantity_unit);
      obj2.put('QUANTITY_UNIT_CODE',j.quantity_unit_code);
      obj2.put('INGREDIENTS',j.ingredients);
      obj2.put('PURPOSE',j.purpose);
      obj2.put('FREQUENCY',j.frequency);
      obj2.put('FREQUENCY_UNIT',j.frequency_unit);
      obj2.put('CURRENT',j.medication_current_flag);
      obj2.put('PRESCRIBED_MED_FLAG',j.PRESCRIBED_MED_FLAG);
      obj2.put('NOTES',j.notes);
      --obj2.put('CREATED_BY_USERNAME',j.created_by);
      --obj2.put('UPDATED_BY_USERNAME',j.updated_by);      
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_medication', l_obj);
    end if;
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_medication;
  --
  PROCEDURE service_remark (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for j in (select PATIENT_PREV_SVC_REMARK_SN
                    ,REMARK_NOTE
              from patient_prev_svc_remark
              where PATIENT_PREV_SVC_SN = p_patient_prev_svc_sn
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_PREV_SVC_REMARK_SN',j.PATIENT_PREV_SVC_REMARK_SN);
      obj2.put('REMARK_NOTE',j.REMARK_NOTE);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('service_remark', l_obj);
    else
      obj2 := json(); --an empty structure
      obj2.put('REMARK_NOTE','None');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
      obj.put('service_remark', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end service_remark;
  --
  PROCEDURE company_user_list(p_locale in varchar2,p_company_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select user_role_id
                    ,name
                    ,email
              from active_user_vw
              where company_sn = p_company_sn
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('USER_ROLE_ID',i.user_role_id);
      obj2.put('NAME',i.name||'('||i.email||')');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('company_user_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end company_user_list;
  --
  --For NON ITH user, this function is providing exception physician data. Instead of all the physician, user can only 
  --handle physician return by this function.
  --
  function user_role_physician_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_physician_sn');
    v_err_msg := null;
    --
    for i in (select physician_sn
              from user_physician
              where user_role_id = p_user_role_id
              and active_flag = 'Y'
              )
    loop
      l_row.number_code := i.physician_sn;
      PIPE ROW (l_row);
    end loop;
  end user_role_physician_sn;
  --
  PROCEDURE company_physician_list (p_locale in varchar2,p_company_sn in number,p_user in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_ithealth_company_flag varchar2(1);
    e_invalid_user exception;
    v_cnt pls_integer;
  begin
    v_proc_name := upper('company_physician_list');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_company_sn: '||p_company_sn;
    --
    --This company_physician_list data return is controlled by the internal parameter v_user_role_id.
    --  
    if p_user is not null then
      select ithealth_company_flag
            ,user_role_id
      into v_ithealth_company_flag
          ,v_user_role_id
      from user_vw
      where user_name = p_user
      ;
      select count(*)
      into v_cnt
      from user_physician
      where user_role_id = v_user_role_id
      and active_flag = 'Y'
      ;
      if v_ithealth_company_flag = 'Y' then
        v_user_role_id := null;
      else --N
        if v_cnt = 0 then
          v_user_role_id := null;
        end if;
      end if;
    else
      v_user_role_id := null;
    end if;
    --
    obj := json(); --an empty structure
    --=====================svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select physician_sn
                    ,name
                    ,first_name
                    ,middle_name
                    ,last_name
                    ,title_code
                    ,title
                    ,physician_type_code
                    ,physician_type
                    ,dr_type_code
                    ,dr_type
                    ,license_num
                    ,npi
                    ,email
                    ,phone
              from physician_vw
              where physician_type_lang = v_lang_code
              and company_sn = p_company_sn
              and (v_user_role_id is null or physician_sn in (select number_code from table(common_inq_pkg.user_role_physician_sn(v_user_role_id))))
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PHYSICIAN_SN',i.physician_sn);
      obj2.put('NAME',i.name||', '||i.dr_type_code);
      obj2.put('FIRST_NAME',i.first_name);
      obj2.put('MIDDLE_NAME',i.middle_name);
      obj2.put('LAST_NAME',i.last_name);
      obj2.put('TITLE_CODE',i.title_code);
      obj2.put('TITLE',i.title);
      obj2.put('PHYSICIAN_TYPE_CODE',i.physician_type_code);
      obj2.put('PHYSICIAN_TYPE',i.physician_type);
      obj2.put('DR_TYPE_CODE',i.dr_type_code);
      obj2.put('DR_TYPE',i.dr_type);
      obj2.put('LICENSE_NUM',i.license_num);
      obj2.put('NPI',i.npi);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('company_physician_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  exception
    when e_invalid_user then
      v_err_msg := 'User Email is required';
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20010,v_err_msg);
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20011,v_err_msg);
  end company_physician_list;
  --
  --For NON ITH user, this function is providing exception physician data. Instead of all the physician, user can only 
  --handle physician return by this function.
  --
  function user_role_svc_location_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_svc_location_sn');
    v_err_msg := null;
    --
    for i in (select svc_location_sn
              from user_svc_location
              where user_role_id = p_user_role_id
              and active_flag = 'Y'
              )
    loop
      l_row.number_code := i.svc_location_sn;
      PIPE ROW (l_row);
    end loop;
  end user_role_svc_location_sn;
  --
  PROCEDURE company_svc_location_list (p_locale in varchar2,p_company_sn in number,p_user in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_ithealth_company_flag varchar2(1);
    e_invalid_user exception;
    v_cnt pls_integer;
  begin
    v_proc_name := upper('company_svc_location_list');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_company_sn: '||p_company_sn;
    --
    --This company_svc_location_list data return is controlled by the internal parameter v_user_role_id.
    --  
    if p_user is null then
      raise e_invalid_user;
    else
      select ithealth_company_flag
            ,user_role_id
      into v_ithealth_company_flag
          ,v_user_role_id
      from user_vw 
      where user_name = p_user
      ;
      select count(*)
      into v_cnt
      from user_svc_location
      where user_role_id = v_user_role_id
      and active_flag = 'Y'
      ;
      if v_ithealth_company_flag = 'Y' then
        v_user_role_id := null;
      else --N
        if v_cnt = 0 then
          v_user_role_id := null;
        end if;
      end if;
      --
      obj := json(); --an empty structure
      --=====================svc_location
      l_obj := json_list(); --an empty list obj
      for i in (select svc_location_sn
                      ,name
                      ,contact_name
                      ,phone
                      ,fax
                      ,svc_location_code
                      ,svc_location_type
                      ,addr
                      ,addr_1
                      ,addr_2
                      ,city_name
                      ,postal_code
                      ,state_code
                      ,state_name
                      ,country_code
                      ,status
                      ,created_by
                      ,updated_by
                from svc_location_vw
                where svc_location_type_lang_code = v_lang_code
                and company_sn = p_company_sn
                and (v_user_role_id is null or svc_location_sn in (select number_code from table(common_inq_pkg.user_role_svc_location_sn(v_user_role_id))))
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('SVC_LOCATION_SN',i.svc_location_sn);
        obj2.put('NAME',i.name||' - '||i.addr);
        obj2.put('LOC_NAME',i.name);
        obj2.put('LOC_CODE',i.svc_location_code);
        obj2.put('LOC_CODE_NAME',i.svc_location_type);
        obj2.put('CONTACT_NAME',i.contact_name);
        obj2.put('PHONE_NUM_1',i.phone);
        obj2.put('ADDR_1',i.addr_1);
        obj2.put('ADDR_2',i.addr_2);
        obj2.put('CITY',i.city_name);
        obj2.put('STATE_CODE',i.state_code);
        obj2.put('STATE_NAME',i.state_name);
        obj2.put('ZIP',i.postal_code);
        obj2.put('COUNTRY_CODE',i.country_code);
        --Append obj2 to the list
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('company_svc_location_list', l_obj);
      end if;
      --===================================== end of json building
      p_out := obj.to_char;
    end if;
  exception
    when e_invalid_user then
      v_err_msg := 'User Email is required';
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20010,v_err_msg);
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20011,v_err_msg);
  end company_svc_location_list;
  --
  PROCEDURE company_prospective_prov_list(p_locale in varchar2,p_company_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================active_user
    l_obj := json_list(); --an empty list obj
    for i in (select email
                    ,phone
                    ,name
                    ,role_name
                    ,user_role_id code
              from active_user_vw
              where role_id in ('DF56C6ED00FF47AC84754BDF1517FB83','3951E214B3F746BD924AFF39CABEA511','79F450777D2E4B6AB98FECB17974FDEB','943DF69DD1744FA2BED92A55C2800C57')
              and user_role_id not in (select physician_user_role_id from provider_physician)
              and user_is_a_provider_flag = 'Y'
              and company_sn = p_company_sn
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',i.code);
      obj2.put('NAME',i.name||' - '||i.email);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('active_user_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end company_prospective_prov_list;
  --
  function provider_pending_svc_list (p_lang_code in varchar2,p_provider_physician_sn in number) return json_list
  is
    l_obj json_list := json_list();
    obj json;
  begin              
    for i in (select pstl.prev_svc_type_code||' ('||psbl.short_descr||' - '||psbl.prev_svc_billing_code||')' svc_name
                    ,to_char(nvl(pps.svc_perform_date,pps.svc_date),'MM/DD/YYYY') svc_date
                    ,pps.patient_prev_svc_sn
                    ,pslv.physician_name
                    ,pslv.svc_location_name
                    ,case 
                      when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
                      else p.first_name||' '||p.last_name
                      end patient_name
              from patient_prev_svc pps
                  ,patient p
                  ,physician_svc_location_vw pslv
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
                  ,list_prev_svc_type pst
                  ,prev_svc_type_lang pstl
              where pps.prev_svc_billing_code = psb.prev_svc_billing_code
              and pps.patient_sn = p.patient_sn
              and pps.physician_svc_location_sn = pslv.physician_svc_location_sn
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = p_lang_code
              and psb.prev_svc_type_code = pst.prev_svc_type_code
              and pst.prev_svc_type_code = pstl.prev_svc_type_code
              and pstl.lang_code = p_lang_code
              and pps.provider_physician_sn = p_provider_physician_sn
              and pps.svc_comp_flag = 'N'
              --
              and pps.active_flag = 'Y'
              and psb.active_flag = 'Y'
              and psbl.active_flag = 'Y'
              and pst.active_flag = 'Y'
              and pstl.active_flag = 'Y'
              order by p.patient_sn
              )
    loop
      obj := json();
      obj.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj.put('PHYSICIAN_NAME',i.physician_name);
      obj.put('PATIENT_NAME',i.patient_name);
      obj.put('SVC_LOCATION',i.svc_location_name);
      obj.put('SVC_NAME',i.svc_name);
      obj.put('SVC_DATE',i.svc_date);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end provider_pending_svc_list;  
  --xfer_specific_svc
  function xfer_specific_svc(p_lang_code in varchar2,p_provider_physician_sn in number,p_provider_name in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TAB_NAME','Specific Svc Xfer');
    obj.put('TITLE','SPECIFIC PENDING SERVICE TRANSFER');
    obj.put('SUB_TITLE1','Please select the provider for the pending service to be transferred from the list below');
    obj.put('SUB_TITLE2','PENDING SERVICE LIST');
    obj.put('SUB_TITLE3','Pending service of '||p_provider_name);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Physician Name');
    obj2.put('TH2','Patient Name');
    obj2.put('TH3','Location');
    obj2.put('TH4','Service Date');
    obj2.put('TH5','Service Name');
    obj.put('th_label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_PROV','Select New Provider');
    obj.put('label_placeholder',obj2);    
    --=======================patient_service_list
    obj.put('provider_pending_svc_list',provider_pending_svc_list(p_lang_code,p_provider_physician_sn));
    --===================================== end of json building
    return obj;
  end xfer_specific_svc;
  --xfer_all_svc
  function xfer_all_svc(p_lang_code in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TAB_NAME','ALL Svc Xfer');
    obj.put('TITLE','ALL PENDING SERVICE TRANSFER');
    obj.put('SUB_TITLE1','Please select the provider for all the pending services to be transferred');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_PROV','Select New Provider');
    obj.put('label_placeholder',obj2);    
    --===================================== end of json building
    return obj;
  end xfer_all_svc;
  --
  PROCEDURE company_provider_list(p_locale in varchar2,p_company_sn in number,p_provider_physician_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select provider_physician_sn
                    ,name
                    ,title_code
                    ,title
                    ,physician_type_code
                    ,physician_type
                    ,dr_type_code
                    ,dr_type
                    ,license_num
                    ,npi
                    ,email
                    ,phone
                    ,case
                      when dr_type_code is null then name
                      else name||', '||dr_type_code
                      end name_with_title
              from provider_physician_vw
              where physician_type_lang = v_lang_code
              and company_sn = p_company_sn
              and (p_provider_physician_sn is null or provider_physician_sn = p_provider_physician_sn)
              and status = 'Active'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PROVIDER_PHYSICIAN_SN',i.provider_physician_sn);
      obj2.put('NAME',i.name_with_title);
      obj2.put('TITLE_CODE',i.title_code);
      obj2.put('TITLE',i.title);
      obj2.put('PHYSICIAN_TYPE_CODE',i.physician_type_code);
      obj2.put('PHYSICIAN_TYPE',i.physician_type);
      obj2.put('DR_TYPE_CODE',i.dr_type_code);
      obj2.put('DR_TYPE',i.dr_type);
      obj2.put('LICENSE_NUM',i.license_num);
      obj2.put('NPI',i.npi);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('SUB_TITLE',i.email); --future place holder to add more attrib
      obj2.put('TAB_NAME','Demographic');
      if p_provider_physician_sn is not null then
        obj2.put('xfer_specific_svc',xfer_specific_svc(v_lang_code,i.provider_physician_sn,i.name_with_title));
        obj2.put('xfer_all_svc',xfer_all_svc(v_lang_code));
      end if;
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('company_provider_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end company_provider_list;
  --
  PROCEDURE svc_location_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select svc_location_sn
                    ,name
                    ,contact_name
                    ,phone
                    ,fax
                    ,svc_location_type
                    ,addr
                    ,status
                    ,created_by
                    ,updated_by
              from svc_location_vw
              where svc_location_type_lang_code = v_lang_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('SVC_LOCATION_SN',i.svc_location_sn);
      obj2.put('NAME',i.name);
      obj2.put('CONTACT_NAME',i.contact_name);
      obj2.put('PHONE',i.phone);
      obj2.put('FAX',i.fax);
      obj2.put('SVC_LOCATION_TYPE',i.svc_location_type);
      obj2.put('ADDR',i.addr);
      obj2.put('STATUS',i.status);
      obj2.put('CREATED_BY_USERNAME',i.created_by);
      obj2.put('UPDATED_BY_USERNAME',i.updated_by);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('svc_location_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end svc_location_list;
  --
  PROCEDURE user_location_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================physician_svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select USER_SVC_LOCATION_SN
                    ,SVC_LOCATION_SN
                    ,svc_location_name
                    ,svc_location_addr
              from user_svc_location_vw
              where user_role_id = p_user_role_id
              and status = 'Active'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('USER_SVC_LOCATION_SN',i.USER_SVC_LOCATION_SN);
      obj2.put('SVC_LOCATION_SN',i.SVC_LOCATION_SN);
      obj2.put('NAME',i.svc_location_name||' - '||i.svc_location_addr);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_location_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end user_location_list;
  --
  PROCEDURE user_company_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================physician_svc_company
    l_obj := json_list(); --an empty list obj
    for i in (select uc.user_company_sn
                    ,cv.company_sn
                    ,cv.name company_name
                    ,cv.addr company_addr
              from user_company uc
                  ,company_vw cv
              where uc.company_sn = cv.company_sn
              and uc.user_role_id = p_user_role_id
              and uc.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('USER_COMPANY_SN',i.user_company_sn);
      obj2.put('COMPANY_SN',i.company_sn);
      obj2.put('NAME',i.company_name||' - '||i.company_addr);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_company_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end user_company_list;
  --
  PROCEDURE user_physician_list (p_locale in varchar2,p_user_role_id in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================
    l_obj := json_list(); --an empty list obj
    for i in (select up.user_physician_sn
                    ,pv.physician_sn
                    ,pv.name physician_name
                    ,pv.dr_type_code
              from user_physician up
                  ,physician_vw pv
              where up.physician_sn = pv.physician_sn
              and up.user_role_id = p_user_role_id
              and up.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('USER_PHYSICIAN_SN',i.user_physician_sn);
      obj2.put('PHYSICIAN_SN',i.physician_sn);
      obj2.put('NAME',i.physician_name||', '||i.dr_type_code);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_physician_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end user_physician_list;
  --
  PROCEDURE physician_location_list (p_locale in varchar2,p_physician_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================physician_svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select physician_svc_location_sn
                    ,svc_location_sn
                    ,svc_location_name
                    ,svc_location_addr
              from physician_svc_location_vw
              where physician_sn = p_physician_sn
              and status = 'Active'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PHYSICIAN_SVC_LOCATION_SN',i.physician_svc_location_sn);
      obj2.put('SVC_LOCATION_SN',i.svc_location_sn);
      obj2.put('NAME',i.svc_location_name||' - '||i.svc_location_addr);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('physician_location_list', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end physician_location_list;
  --
  PROCEDURE location_physician_list (p_locale in varchar2,p_svc_location_sn in number,p_user in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_ithealth_company_flag varchar2(1);
    e_invalid_user exception;
    v_cnt pls_integer;    
  begin
    v_proc_name := upper('location_physician_list');
    v_input_str := 'p_locale: '||p_locale||'-p_user: '||p_user||'-p_svc_location_sn: '||p_svc_location_sn;
    --
    --This company_svc_location_list data return is controlled by the internal parameter v_user_role_id.
    --  
    if p_user is null then
      raise e_invalid_user;
    else
      select ithealth_company_flag
            ,user_role_id
      into v_ithealth_company_flag
          ,v_user_role_id
      from user_vw 
      where user_name = p_user
      ;
      select count(*)
      into v_cnt
      from user_physician
      where user_role_id = v_user_role_id
      and active_flag = 'Y'
      ;
      if v_ithealth_company_flag = 'Y' then
        v_user_role_id := null;
      else --N
        if v_cnt = 0 then
          v_user_role_id := null;
        end if;
      end if;
      --
      obj := json(); --an empty structure
      --=====================physician_svc_location
      l_obj := json_list(); --an empty list obj
      for i in (select physician_svc_location_sn
                      ,physician_sn
                      ,physician_name
                from physician_svc_location_vw
                where svc_location_sn = p_svc_location_sn
                and (v_user_role_id is null or physician_sn in (select number_code from table(common_inq_pkg.user_role_physician_sn(v_user_role_id))))
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('PHYSICIAN_SVC_LOCATION_SN',i.physician_svc_location_sn);
        obj2.put('PHYSICIAN_SN',i.physician_sn);
        obj2.put('NAME',i.physician_name);
        --Append obj2 to the list
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('location_physician_list', l_obj);
      end if;
      --===================================== end of json building
      p_out := obj.to_char;
    end if;
  exception
    when e_invalid_user then
      v_err_msg := 'User Email is required';
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20010,v_err_msg);
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20011,v_err_msg);
  end location_physician_list;
  --
  PROCEDURE physician_svc_location (p_locale in varchar2,p_physician_sn in physician.physician_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================physician_svc_location
    l_obj := json_list(); --an empty list obj
    for i in (select physician_svc_location_sn
                    ,svc_location_name
                    ,svc_location_addr
                    ,physician_name
                    ,physician_company_name
                    ,svc_location_type
                    ,status
                    ,created_by
                    ,updated_by
              from physician_svc_location_vw
              where (p_physician_sn is null or physician_sn = p_physician_sn)
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PHYSICIAN_SVC_LOCATION_SN',i.physician_svc_location_sn);
      obj2.put('SVC_LOCATION_NAME',i.svc_location_name);
      obj2.put('SVC_LOCATION_ADDR',i.svc_location_addr);
      obj2.put('PHYSICIAN_NAME',i.physician_name);
      obj2.put('PHYSICIAN_COMPANY_NAME',i.physician_company_name);
      obj2.put('SVC_LOCATION_TYPE',i.svc_location_type);
      obj2.put('STATUS',i.status);
      obj2.put('CREATED_BY_USERNAME',i.created_by);
      obj2.put('UPDATED_BY_USERNAME',i.updated_by);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('physician_svc_location', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end physician_svc_location;  
  --
  PROCEDURE patient_prev_svc (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_svc_completed_flag varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================patient_prev_svc
    l_obj := json_list(); --an empty list obj
    for i in (select patient_prev_svc_sn
                    ,svc_date
                    ,G0438_COMP_ON_DIFF_SYS_FLAG
                    ,completed_flag
                    ,pat_name
                    ,svc_location_name
                    ,svc_location_addr
                    ,provider_physician_name
                    ,provider_physician_npi
                    ,billing_code
                    ,billing_code_descr
                    ,svc_type
                    ,status
                    ,created_by
                    ,updated_by
              from patient_prev_svc_vw
              where prev_svc_billing_lang_code = v_lang_code
              and prev_svc_type_lang_code = v_lang_code
              and (p_patient_sn is null or patient_sn = p_patient_sn)
              and (p_svc_completed_flag is null or completed_flag = p_svc_completed_flag)
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj2.put('SVC_DATE',i.svc_date);
      obj2.put('G0438_COMP_ON_DIFF_SYS_FLAG',i.G0438_COMP_ON_DIFF_SYS_FLAG);
      obj2.put('COMPLETED_FLAG',i.completed_flag);
      obj2.put('PATIENT_NAME',i.pat_name);
      obj2.put('SVC_LOCATION_NAME',i.svc_location_name);
      obj2.put('SVC_LOCATION_ADDR',i.svc_location_addr);
      obj2.put('PROVIDER_PHYSICIAN_NAME',i.provider_physician_name);
      obj2.put('PROVIDER_PHYSICIAN_NPI',i.provider_physician_npi);
      obj2.put('BILLING_CODE',i.billing_code_descr);
      obj2.put('SVC_TYPE',i.svc_type);
      obj2.put('STATUS',i.status);
      obj2.put('CREATED_BY_USERNAME',i.created_by);
      obj2.put('UPDATED_BY_USERNAME',i.updated_by);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_prev_svc', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_prev_svc;  
  --
  PROCEDURE role_priviledge_list (p_locale in varchar2,p_role_id roles_priviledge.role_id%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    l_obj       json_list;
    l_obj2       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --==============================role_priviledge
    l_obj := json_list(); --an empty list obj
    for m in (select p.priviledge_code code
                    ,pl.short_descr||'('||ptl.short_descr||')' name
              from list_priviledge p
                  ,priviledge_lang pl
                  ,list_priviledge_type pt
                  ,priviledge_type_lang ptl
                  ,roles_priviledge rp
              where p.priviledge_code = pl.priviledge_code
              and pl.lang_code = v_lang_code
              and p.priviledge_type_code = pt.priviledge_type_code
              and pt.priviledge_type_code = ptl.priviledge_type_code
              and ptl.lang_code = v_lang_code
              and p.priviledge_code = rp.priviledge_code
              and rp.role_id = p_role_id
              --
              and p.active_flag = 'Y'
              and pl.active_flag = 'Y'
              and pt.active_flag = 'Y'
              and ptl.active_flag = 'Y'
              and rp.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('role_priviledge', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end role_priviledge_list;
  --
  PROCEDURE role_list (p_locale in varchar2,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    l_obj       json_list;
    l_obj2       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --==============================Roles
    l_obj := json_list(); --an empty list obj
    for m in (select r."Id" code
                    ,r."Name" name
              from "AspNetRoles" r
              where r."Id" not in ('a74f52c5-4d3a-46d9-bc22-a5eafa982849','96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
              and r.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --==========================role_priviledge
      l_obj2 := json_list(); --an empty list obj
      for n in (select p.priviledge_code code
                      ,pl.short_descr||'('||ptl.short_descr||')' name
                from roles_priviledge rp
                    ,list_priviledge p
                    ,priviledge_lang pl
                    ,list_priviledge_type pt
                    ,priviledge_type_lang ptl
                where rp.priviledge_code = p.priviledge_code
                and p.priviledge_code = pl.priviledge_code
                and pl.lang_code = v_lang_code
                and p.priviledge_type_code = pt.priviledge_type_code
                and pt.priviledge_type_code = ptl.priviledge_type_code
                and ptl.lang_code = v_lang_code
                and rp.role_id = m.code
                --
                and rp.active_flag = 'Y'
                and p.active_flag = 'Y'
                and pl.active_flag = 'Y'
                and pt.active_flag = 'Y'
                and ptl.active_flag = 'Y'
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',n.code);
        obj3.put('NAME',n.name);
        --Append the object to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('role_priviledge', l_obj2);
      end if;
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('role', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end role_list;
  --
  --This is a test procedure to return image (> 32k) in string
--  PROCEDURE user_image  (p_out OUT clob)
--  as
--    --This method will return common json of all the list tables
--    --
--    obj json;
--    obj2 json;
--    l_obj json_list;
--  begin
--    p_out := 'abc'; --initialize the clob
--    obj := json(); --an empty structure
--    --====================================================trans_lang
--    l_obj := json_list(); --an empty list obj
--    for i in (select USER_IMAGE_SN
--                    ,json_ext.base64(image) image
--                    ,lower(file_type_code) file_type_code
--             from user_image
--             where user_image_sn = 4
--             )
--    loop
--      obj2 := json(); --an empty structure
--      obj2.put('USER_IMAGE_SN',i.USER_IMAGE_SN);
--      obj2.put('FILE_TYPE_CODE',i.file_type_code);
--      obj2.put('IMAGE',i.image);
--      --Append obj2 to the list
--      l_obj.append(obj2.to_json_value);
--    end loop;
--    --
--    if json_ac.array_count(l_obj) > 0 then
--      obj.put('user_image', l_obj);
--    end if;
--    --==========================output
--    dbms_lob.trim(p_out, 0); --empty the lob
--    obj.to_clob(p_out);
--  end user_image;
  --
  procedure patient_last_question_categ (p_patient_prev_svc_sn in number
                                           ,p_last_question_categ_code out list_question_categ.question_categ_code%type
                                           ,p_last_categ_order_num out number
                                           ,p_conditional_categ_flag out list_question_categ.conditional_categ_flag%type
                                           ,p_trigger_further_categ_flag out list_question_categ.trigger_further_categ_flag%type
                                           )
  is
  begin
    with categ_curr_order as (
      select psb.prev_svc_billing_code,max(sbqc.order_num) curr_order_num
      from patient_response pr
          ,question_response qr
          ,question q
          ,list_question_categ qc
          ,svc_billing_question_categ sbqc
          ,patient_prev_svc pps
          ,list_prev_svc_billing psb
      where pr.question_response_code = qr.question_response_code
      and qr.question_sn = q.question_sn
      and q.question_categ_code = qc.question_categ_code
      and pr.patient_prev_svc_sn = pps.patient_prev_svc_sn
      and pps.prev_svc_billing_code = psb.prev_svc_billing_code
      and sbqc.prev_svc_billing_code = psb.prev_svc_billing_code
      and sbqc.question_categ_code = qc.question_categ_code
      and pr.patient_prev_svc_sn = p_patient_prev_svc_sn
      and qc.conditional_categ_flag = 'N'
      and sbqc.question_categ_code <> 'BDTEN'
      group by psb.prev_svc_billing_code
      )
    select qc2.question_categ_code
          ,qc2.conditional_categ_flag
          ,qc2.trigger_further_categ_flag
          ,cco.curr_order_num
    into p_last_question_categ_code
        ,p_conditional_categ_flag
        ,p_trigger_further_categ_flag
        ,p_last_categ_order_num
    from svc_billing_question_categ sbqc2
        ,categ_curr_order cco
        ,list_question_categ qc2
    where sbqc2.prev_svc_billing_code = cco.prev_svc_billing_code
    and sbqc2.order_num = cco.curr_order_num
    and sbqc2.question_categ_code = qc2.question_categ_code
    ;
  exception
    when no_data_found then
      raise_application_error(-20001,sqlerrm);
    when others then 
      raise_application_error(-20002,sqlerrm);
  end patient_last_question_categ;
  --
  procedure patient_last_cond_qtn_categ (p_patient_prev_svc_sn in number
                                           ,p_parent_question_categ_code in list_question_categ.question_categ_code%type
                                           ,p_last_question_categ_code out list_question_categ.question_categ_code%type
                                           ,p_last_categ_order_num out number
                                           ,p_conditional_categ_flag out list_question_categ.conditional_categ_flag%type
                                           ,p_trigger_further_categ_flag out list_question_categ.trigger_further_categ_flag%type
                                           )
  is
  begin
    with categ_curr_order as (
      select psb.prev_svc_billing_code,max(sbqc.order_num) curr_order_num
      from patient_response pr
          ,question_response qr
          ,question q
          ,list_question_categ qc
          ,svc_billing_question_categ sbqc
          ,patient_prev_svc pps
          ,list_prev_svc_billing psb
      where pr.question_response_code = qr.question_response_code
      and qr.question_sn = q.question_sn
      and q.question_categ_code = qc.question_categ_code
      and pr.patient_prev_svc_sn = pps.patient_prev_svc_sn
      and pps.prev_svc_billing_code = psb.prev_svc_billing_code
      and sbqc.prev_svc_billing_code = psb.prev_svc_billing_code
      and sbqc.question_categ_code = qc.question_categ_code
      and pr.patient_prev_svc_sn = p_patient_prev_svc_sn
      and qc.parent_question_categ_code = p_parent_question_categ_code
      and qc.conditional_categ_flag = 'Y'
      group by psb.prev_svc_billing_code
      )
    select qc2.question_categ_code
          ,qc2.conditional_categ_flag
          ,qc2.trigger_further_categ_flag
          ,cco.curr_order_num
    into p_last_question_categ_code
        ,p_conditional_categ_flag
        ,p_trigger_further_categ_flag
        ,p_last_categ_order_num
    from svc_billing_question_categ sbqc2
        ,categ_curr_order cco
        ,list_question_categ qc2
    where sbqc2.prev_svc_billing_code = cco.prev_svc_billing_code
    and sbqc2.order_num = cco.curr_order_num
    and sbqc2.question_categ_code = qc2.question_categ_code
    ;
  exception
    when no_data_found then
      p_last_question_categ_code := null;
      p_conditional_categ_flag := null;
      p_trigger_further_categ_flag := null;
      p_last_categ_order_num := null;
    when others then 
      raise_application_error(-20008,sqlerrm);
  end patient_last_cond_qtn_categ;
  --
  function next_question_categ_code (p_prev_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_last_categ_order_num in number) return list_question_categ.question_categ_code%type
  is
    v_next_question_categ_code list_question_categ.question_categ_code%type;
  begin
    select question_categ_code
    into v_next_question_categ_code
    from svc_billing_question_categ
    where prev_svc_billing_code = p_prev_svc_billing_code
    and question_categ_code <> 'BDTEN'
    and order_num = p_last_categ_order_num + 1
    ;
    return v_next_question_categ_code;
  exception
    when others then 
      raise_application_error(-20003,sqlerrm);
  end next_question_categ_code;
  --
  function final_next_question_categ (p_patient_prev_svc_sn in number) return list_question_categ.question_categ_code%type
  is
    obj2 json;
    tempdata      json_value;
    v_question_complete_flag varchar2(1);
    v_next_question_categ_code list_question_categ.question_categ_code%type;
    v_out clob;
  begin
    common_inq_pkg.patient_qnr_by_categ('en-US',p_patient_prev_svc_sn,v_out);
    obj2 := json(v_out);
    if obj2.exist('QUESTION_COMPLETE_FLAG') then
      tempdata := obj2.get('QUESTION_COMPLETE_FLAG');
      if tempdata is not null then
        v_question_complete_flag := tempdata.get_string;
        if v_question_complete_flag = 'N' then
          if obj2.exist('categ') then
            tempdata := obj2.get('categ');
            if tempdata is not null then
              if tempdata.is_object then
                obj2 := json(tempdata); 
                if obj2.exist('CODE') then
                  tempdata := obj2.get('CODE');
                  if tempdata is not null then
                    v_next_question_categ_code := tempdata.get_string;
                  end if;
                end if;
              end if;
            end if;
          end if;
        else
          v_next_question_categ_code := null;
        end if;
      end if;
    end if;
    return v_next_question_categ_code;
  exception
    when others then 
      raise_application_error(-20003,sqlerrm);
  end final_next_question_categ;
  --
  function question_order_num (p_prev_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type) return svc_billing_question_categ.order_num%type
  is
    v_order_num svc_billing_question_categ.order_num%type;
  begin
    select order_num
    into v_order_num
    from svc_billing_question_categ
    where prev_svc_billing_code = p_prev_svc_billing_code
    and question_categ_code = p_question_categ_code
    ;
    return v_order_num;
  exception
    when others then 
      raise_application_error(-20004,sqlerrm);
  end question_order_num;
  --Risk Factor for a Category(Y/N)
  function question_category_rf_flag (p_patient_prev_svc_sn in number,p_question_categ_code in list_question_categ.question_categ_code%type,p_risk_factor_code in list_risk_factor.risk_factor_code%type) return varchar2
  is
    v_cnt pls_integer;
    v_patient_sn number(11);
  begin
    if p_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
      select patient_sn
      into v_patient_sn
      from patient_prev_svc
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      select count(*)
      into v_cnt
      from patient_history_vw 
      where patient_sn = v_patient_sn
      and risk_factor_code = p_risk_factor_code
      and category_code = p_question_categ_code
      ;
    else
      select count(*)
      into v_cnt
      from patient_response_vw 
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and risk_factor_code = p_risk_factor_code
      and category_code = p_question_categ_code
      ;
    end if;
    if v_cnt > 0 then return 'Y';
    else return 'N';
    end if;
  end question_category_rf_flag;
  --
  function patient_question_response_flag (p_patient_prev_svc_sn in number,p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return varchar2
  is
    v_return varchar2(1);
    v_patient_sn number(11);
  begin
    begin
      if p_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
        select patient_sn
        into v_patient_sn
        from patient_prev_svc
        where patient_prev_svc_sn = p_patient_prev_svc_sn
        ;
        select 'Y'
        into v_return
        from patient_history pr
            ,question_response qr
            ,question q
        where pr.question_response_code = qr.question_response_code
        and qr.question_sn = q.question_sn
        and pr.patient_sn = v_patient_sn 
        and q.question_categ_code = p_question_categ_code
        and q.question_code = p_question_code
        and qr.response_code = p_response_code
        ;
      else    
        select 'Y'
        into v_return
        from patient_response pr
            ,question_response qr
            ,question q
        where pr.question_response_code = qr.question_response_code
        and qr.question_sn = q.question_sn
        and pr.patient_prev_svc_sn = p_patient_prev_svc_sn 
        and q.question_categ_code = p_question_categ_code
        and q.question_code = p_question_code
        and qr.response_code = p_response_code
        ;
      end if;
    exception
      when no_data_found then
        v_return := 'N';
    end;
    return v_return;
  exception
    when others then 
      raise_application_error(-20005,sqlerrm);
  end patient_question_response_flag;
  --
  function question_response_code (p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return patient_response.question_response_code%type
  is
    v_question_response_code patient_response.question_response_code%type;
  begin
    select qr.question_response_code
    into v_question_response_code
    from question_response qr
        ,question q
        ,list_question_categ qc
    where qr.question_sn = q.question_sn
    and q.question_categ_code = qc.question_categ_code
    and q.question_categ_code = p_question_categ_code
    and q.question_code = p_question_code
    and qr.response_code = p_response_code
    ;
    return v_question_response_code;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end question_response_code;
  --Function to return dummy response code (response code when patient have not answered any questions under that category (check box only categ)
  function categ_no_response_code (p_question_categ_code in list_question_categ.question_categ_code%type,p_question_code in question.question_code%type,p_response_code in list_response.response_code%type) return patient_response.question_response_code%type
  is
    v_question_response_code patient_response.question_response_code%type;
  begin
    select qr.question_response_code
    into v_question_response_code
    from question_response qr
        ,question q
        ,list_question_categ qc
    where qr.question_sn = q.question_sn
    and q.question_categ_code = qc.question_categ_code
    and q.question_categ_code = p_question_categ_code
    and q.question_code = p_question_code
    and qr.response_code = p_response_code
    and qc.checkbox_only_categ_flag = 'Y'
    ;
    return v_question_response_code;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end categ_no_response_code;
  --
  PROCEDURE patient_qnr_by_categ (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  is
    v_next_question_categ_code list_question_categ.question_categ_code%type;
    v_prev_svc_billing_code list_prev_svc_billing.prev_svc_billing_code%type;
    v_age number(9);
    v_bmi_result varchar2(30);
    v_gender varchar2(3);
    obj json := json();
    v_qnr_out clob;
    v_respose_cnt pls_integer;
    v_meds_cnt pls_integer;
    --
    --v_parent_question_categ_code list_question_categ.question_categ_code%type;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    --
    v_last_question_categ_code list_question_categ.question_categ_code%type;
    v_last_categ_order_num number;
    v_conditional_categ_flag list_question_categ.conditional_categ_flag%type;
    v_trigger_further_categ_flag list_question_categ.trigger_further_categ_flag%type;
    --
    v_last_cond_qtn_categ_code list_question_categ.question_categ_code%type;
    v_last_cond_categ_order_num number;
    v_cond_cond_categ_flag list_question_categ.conditional_categ_flag%type;
    v_cond_tgr_further_categ_flag list_question_categ.trigger_further_categ_flag%type;

    v_question_comp_flag varchar2(1);
    v_patient_sn patient.patient_sn%type;
    v_name varchar2(200);
    v_bmi number(9,3);
    v_gender_descr varchar2(30);
  begin
    select count(*) 
    into v_respose_cnt
    from patient_response_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code <> 'BDTEN'
    ;
    select pps.prev_svc_billing_code
          ,p.gender_code
          ,common_pkg.age(p.birth_date)
          ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in))
          ,pps.patient_sn
          ,case 
            when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
            else p.first_name||' '||p.last_name
            end name
          ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)
          ,gl.short_descr
    into v_prev_svc_billing_code
        ,v_gender
        ,v_age
        ,v_bmi_result
        ,v_patient_sn
        ,v_name
        ,v_bmi
        ,v_gender_descr
    from patient_prev_svc pps
        ,list_prev_svc_billing psb
        ,patient p
        ,list_gender g
        ,gender_lang gl
    where pps.prev_svc_billing_code = psb.prev_svc_billing_code
    and pps.patient_sn = p.patient_sn
    and p.gender_code = g.gender_code
    and g.gender_code = gl.gender_code
    and gl.lang_code = v_lang_code
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    select count(*)
    into v_meds_cnt
    from patient_medication
    where patient_sn = v_patient_sn
    ;
    if v_respose_cnt = 0 then
      v_next_question_categ_code := 'BMEDH';
      v_question_comp_flag := 'N';
    else
      patient_last_question_categ (p_patient_prev_svc_sn,v_last_question_categ_code,v_last_categ_order_num,v_conditional_categ_flag,v_trigger_further_categ_flag);
      if v_trigger_further_categ_flag = 'Y' then
        patient_last_cond_qtn_categ (p_patient_prev_svc_sn,v_last_question_categ_code,v_last_cond_qtn_categ_code,v_last_cond_categ_order_num,v_cond_cond_categ_flag,v_cond_tgr_further_categ_flag);
        if v_last_cond_qtn_categ_code is not null then
          v_last_question_categ_code := v_last_cond_qtn_categ_code;
          v_last_categ_order_num := v_last_cond_categ_order_num;
          v_conditional_categ_flag := v_cond_cond_categ_flag;
          v_trigger_further_categ_flag := v_cond_tgr_further_categ_flag;
        end if;
      end if;
      if v_last_question_categ_code = 'MEDCP' then
        v_question_comp_flag := 'Y';
      else        
        v_question_comp_flag := 'N';
        if v_conditional_categ_flag = 'Y' or v_trigger_further_categ_flag = 'Y' then
          if v_trigger_further_categ_flag = 'Y' then
            if v_last_question_categ_code = 'LONLS' then
              if v_age > 75 then
                v_next_question_categ_code := 'FRLTY';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,v_last_categ_order_num);
              end if;
            elsif v_last_question_categ_code = 'FALLR' then
              if patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1002','YES') = 'Y' then
                v_next_question_categ_code := 'DIZZI';
              elsif patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','YES') = 'Y' then
                v_next_question_categ_code := 'HHISQ';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,v_last_categ_order_num);
              end if;
            elsif v_last_question_categ_code = 'PSYSD' then
              --Check if any of the triggered already have been submitted then return next code as that one else evaluate from the begining
              if response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,v_last_question_categ_code,'ANX'),v_last_question_categ_code,'ANX') = 'Y' then
                v_next_question_categ_code := 'ANXIT';
              elsif response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,v_last_question_categ_code,'DEP'),v_last_question_categ_code,'DEP') = 'Y' then
                v_next_question_categ_code := 'GERDS';
              elsif response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,v_last_question_categ_code,'STR'),v_last_question_categ_code,'STR') = 'Y' then
                v_next_question_categ_code := 'HRSTS';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,v_last_categ_order_num);
              end if;
            end if;
          else --v_conditional_categ_flag = 'Y'
            if v_last_question_categ_code = 'FRLTY' then
              v_next_question_categ_code := 'FRLT1';
            elsif v_last_question_categ_code = 'FRLT1' then
              v_next_question_categ_code := 'FRLT2';
            elsif v_last_question_categ_code = 'FRLT2' then
              v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'LONLS'));
            elsif v_last_question_categ_code = 'DIZZI' then
              if patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','YES') = 'Y' then
                v_next_question_categ_code := 'HHISQ';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'FALLR'));
              end if;
            elsif v_last_question_categ_code = 'HHISQ' then
              v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'FALLR'));
            elsif v_last_question_categ_code = 'ANXIT' then
              if response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,'PSYSD','DEP'),'PSYSD','DEP') = 'Y' then
                v_next_question_categ_code := 'GERDS';
              elsif response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,'PSYSD','STR'),'PSYSD','STR') = 'Y' then
                v_next_question_categ_code := 'HRSTS';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'PSYSD'));
              end if;
            elsif v_last_question_categ_code = 'GERDS' then
              if response_trigger_further_categ(categ_score_sum(p_patient_prev_svc_sn,'PSYSD','STR'),'PSYSD','STR') = 'Y' then
                v_next_question_categ_code := 'HRSTS';
              else
                v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'PSYSD'));
              end if;
            elsif v_last_question_categ_code = 'HRSTS' then
              v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,question_order_num (v_prev_svc_billing_code,'PSYSD'));
            end if;
          end if;
        else --normal questions (non conditional)
          v_next_question_categ_code := next_question_categ_code(v_prev_svc_billing_code,v_last_categ_order_num);
        end if;
      end if;
    end if;
    --
    if v_question_comp_flag = 'N' then
      qnr_inq_pkg.qnr_by_categ_patient_info(p_locale,p_patient_prev_svc_sn,v_prev_svc_billing_code,v_next_question_categ_code,v_name,v_age,v_gender,v_gender_descr,v_bmi,v_bmi_result,v_meds_cnt,v_qnr_out);
      obj := json(v_qnr_out);
      obj.put('QUESTION_COMPLETE_FLAG',v_question_comp_flag);
    else
      obj.put('QUESTION_COMPLETE_FLAG',v_question_comp_flag);
    end if;
    --Append patient_history data. These data can be entered before the interview start. Interviewer will have the opportunity
    --to append/modify these records.
    --
    if v_next_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
      obj.put('response',admin_inq_pkg.patient_hx_response(v_patient_sn,v_next_question_categ_code));
    end if;
    p_out := obj.to_char;
  exception
    when others then
      p_out := null;
  end patient_qnr_by_categ;
  --
  PROCEDURE patient_em_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'ESV'
      ;
    exception
      when others then p_out := null;
    end;
  end patient_em_template_data;
  -- 
  PROCEDURE patient_em_template_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    v_out       clob;
    v_obj       json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    l_obj := json_list(); --an empty list obj
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,svc_date
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,svc_perform_date
                    ,completed_flag
                    ,qualify_for_em_followup_flag
                    ,nvl(CHRONIC_DISEASE_CNT,0) CHRONIC_DISEASE_CNT
                    ,billing_code
                    ,svc_type_code
                    ,svc_type
                    ,primary_physician_dr_type
                    ,provider_physician_dr_type                    
                    ,pat_primary_physician_name
                    ,case
                      when primary_physician_dr_type is null then pat_primary_physician_name
                      else pat_primary_physician_name||', '||primary_physician_dr_type
                      end pat_primary_physician_name_2
                    ,case
                      when provider_physician_dr_type is null then provider_physician_name
                      else provider_physician_name||', '||provider_physician_dr_type
                      end provider_physician_name_2                    
                    ,PAT_PRIMARY_PHYSICIAN_COMPANY
                    ,provider_physician_name
                    ,provider_physician_company
                    ,svc_location_name
                    ,svc_location_addr
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,pat_gender
                    ,pat_gender_code
                    ,pat_race
                    ,pat_ethnicity
                    ,pat_marital_status
                    ,pat_working_status
                    ,pat_educational_level
                    ,pat_financial_status
                    ,pat_living_status
                    ,pat_income
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_last_name
                      else 'Mrs. '||pat_last_name
                      end pat_last_name                    
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_birth_date
                    ,pat_age
                    ,pat_age_at_svc_perform_date
                    ,pat_bmi_result
                    ,pat_bmi bmi_num
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb||' LB' pat_weight_in_lb
                    ,pat_hdl_cholesterol_in_mg
                    ,pat_ldl_cholesterol_in_mg
                    ,pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                    ,pat_systolic_bp_in_mm
                    ,pat_diastolic_bp_in_mm
                    ,pat_blood_sugar_level_in_mg                    
                    ,patient_orientation
                    ,source_of_history
              from patient_prev_svc_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      --==============================report_hdr
      report_pkg.report_hdr (i.svc_type_code,i.pat_name,i.svc_perform_date,v_out);
      v_obj := json(v_out);
      obj.put('report_hdr',v_obj);
      --==============================patient_demo
      for j in (select pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                      ,patient_orientation
                      ,source_of_history
                      ,pat_marital_status
                      ,pat_financial_status
                      ,pat_living_status
                      ,pat_educational_level
                      ,pat_bmi_result
                      ,pat_bmi bmi_num
                      ,qualify_for_em_followup_flag
                      ,chronic_disease_cnt
                      ,pat_systolic_bp_in_mm
                      ,pat_diastolic_bp_in_mm
                      ,pat_blood_sugar_level_in_mg
                      ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                from patient_prev_svc_vw
                where patient_prev_svc_sn = i.parent_patient_prev_svc_sn
                )
      loop
        report_pkg.patient_demo (null,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,j.pat_bp,j.patient_orientation,j.source_of_history,j.pat_marital_status,i.svc_location_name,i.provider_physician_name_2,j.pat_bmi,v_out);
        v_obj := json(v_out);
        obj.put('patient_demo',v_obj);
        --==============================patient_vitals
        report_pkg.report_vitals (v_out);
        v_obj := json(v_out);
        obj.put('patient_vitals',v_obj);
        --==============================report_hra
        report_pkg.report_hra (i.patient_sn,i.parent_patient_prev_svc_sn,i.pat_age_at_svc_perform_date,i.pat_gender,i.pat_gender_code,i.pat_race,j.pat_financial_status,j.pat_living_status,j.pat_educational_level,v_out);
        v_obj := json(v_out);
        obj.put('report_hra',v_obj);
        --==============================
        report_pkg.report_prev_plan (i.parent_patient_prev_svc_sn,i.pat_name,i.provider_physician_name,i.pat_gender_code,i.pat_age_at_svc_perform_date,j.bmi_num,j.pat_bmi_result,'Y',j.qualify_for_em_followup_flag,j.chronic_disease_cnt,j.pat_systolic_bp_in_mm,j.pat_diastolic_bp_in_mm,j.pat_blood_sugar_level_in_mg,v_out);
        v_obj := json(v_out);
        obj.put('report_prev_plan',v_obj);
      end loop;
      --==============================report_clinical
      report_pkg.report_clinical (i.parent_patient_prev_svc_sn,v_out);
      v_obj := json(v_out);
      obj.put('report_clinical',v_obj);
      --==============================
      report_pkg.ccm_patient_agmt_data (i.pat_name,i.provider_physician_name,v_out);
      v_obj := json(v_out);
      obj.put('ccm_patient_agmt_data',v_obj);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_em_template_data_init;
    --
  PROCEDURE patient_ccm_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'CSV'
      ;
    exception
      when others then p_out := null;
    end;
  end patient_ccm_template_data;
  --
  PROCEDURE patient_ccm_template_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    obj4        json;
    l_obj       json_list;
    l_obj2      json_list;
    l_obj3      json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_physician_sn physician.physician_sn%type;
  begin
    obj := json(); --an empty structure
    l_obj := json_list(); --an empty list obj
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,svc_date
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,completed_flag
                    ,svc_type
                    ,pat_primary_physician_name
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,upper(substr(pat_gender,1,1)) pat_gender
                    ,pat_race
                    ,pat_ethnicity
                    ,pat_marital_status
                    ,pat_working_status
                    ,pat_educational_level
                    ,pat_financial_status
                    ,pat_living_status
                    ,pat_income
                    ,pat_name
                    ,pat_birth_date
                    ,pat_age||'y/o' pat_age
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb||' LB' pat_weight_in_lb
                    ,pat_hdl_cholesterol_in_mg
                    ,pat_ldl_cholesterol_in_mg
                    ,pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
              from patient_prev_svc_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      --HDR
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.pat_name);
      obj2.put('GENDER',i.pat_gender);
      obj2.put('HIC',i.pat_medicare_hic_num);
      obj2.put('DOB',i.pat_birth_date);
      obj2.put('AGE',i.pat_age);
      obj2.put('DATE',i.current_date);
      obj.put('hdr', obj2);
      --================================================NON_MOD_HRA_RF
      obj2 := json(); --an empty structure
      obj2.put('HEIGHT',i.pat_height_in_ft);
      obj2.put('WEIGHT',i.pat_weight_in_lb);
      obj2.put('BMI',i.pat_bmi);
      obj2.put('BP',i.pat_bp);
      --================symptom
      l_obj := json_list(); --an empty list obj
      for j in (select symptom_code
                      ,symp_short_descr
                from table(report_pkg.symptom_fnc(i.parent_patient_prev_svc_sn,null))              
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.symp_short_descr);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('symptom', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Symptom');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('symptom', l_obj);
      end if;
      --================medication
      l_obj := json_list(); --an empty list obj
      for j in (select report_pkg.medication_descr(name,quantity,quantity_unit,frequency,purpose,prescribed_med_flag) name
                from patient_medication_vw
                where patient_sn = i.patient_sn
                and medication_current_flag = 'Y'
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('medication', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Medication');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('medication', l_obj);
      end if;
      --================family_pmhx
      l_obj := json_list(); --an empty list obj
      for j in (select question 
                from patient_history_vw 
                where risk_factor_code = 'FMHX'
                and response_code <> 'NON'
                and patient_sn = i.patient_sn
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.question);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('family_pmhx', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Family PMHX');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('family_pmhx', l_obj);
      end if;
      --
      obj.put('non_mod_hra_rf', obj2);
      --======================================================MOD_RF
      obj2 := json(); --an empty structure
      --================behavioral_rf
      l_obj := json_list(); --an empty list obj
      for j in (select rf_short_descr 
                from table(report_pkg.risk_factor_fnc(i.parent_patient_prev_svc_sn,null))
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.rf_short_descr);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('behavioral_rf', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Risk Factor Identified');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('behavioral_rf', l_obj);
      end if;
      --
      obj.put('mod_rf', obj2);
      --======================================================DISEASE_SEVERITY
      obj2 := json(); --an empty structure
      --================disease
      l_obj := json_list(); --an empty list obj
      for j in (select report_pkg.disease_descr(disease_categ_code,question_score_type_code,disease_short_descr,dis_level_short_descr,dis_severity_short_descr,dis_type_short_descr) disease_descr
                from table(report_pkg.svc_result_fnc(i.parent_patient_prev_svc_sn))
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.disease_descr);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('disease', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Disease Identified');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('disease', l_obj);
      end if;
      --
      obj.put('disease_severity', obj2);
      --======================================================HR
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select hr_code code
                      ,hr_code name
                from list_hr
                order by hr_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('hr', l_obj);
      end if;
      --
      obj.put('svc_hr', obj2);
      --=====================================================MIN
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select min_code code
                      ,min_code name
                from list_min
                order by min_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('min', l_obj);
      end if;
      --
      obj.put('svc_min', obj2);
      --=====================================================AM_PM
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select am_pm_code code
                      ,am_pm_code name
                from list_am_pm
                order by am_pm_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('am_pm', l_obj);
      end if;
      --
      obj.put('svc_am_pm', obj2);
      --======================================================provider_ccm_question
      obj2 := json(); --an empty structure
      --================exam
      l_obj := json_list(); --an empty list obj
      for j in (select cqcl.ccm_question_categ_code code
                      ,cqcl.short_descr name
                from list_ccm_question_categ cqc
                    ,ccm_question_categ_lang cqcl 
                where cqc.ccm_question_categ_code = cqcl.ccm_question_categ_code
                and cqcl.lang_code = v_lang_code
                and cqc.active_flag = 'Y'
                and cqcl.active_flag = 'Y'
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --
        l_obj2 := json_list(); --an empty list obj
        for k in (select cql.ccm_question_code code
                        ,cql.short_descr name
                  from list_ccm_question_categ cqc
                      ,ccm_question_categ_lang cqcl 
                      ,list_ccm_question cq
                      ,ccm_question_lang cql
                  where cqc.ccm_question_categ_code = cqcl.ccm_question_categ_code
                  and cqcl.lang_code = v_lang_code
                  and cqc.ccm_question_categ_code = cq.ccm_question_categ_code
                  and cq.ccm_question_code = cql.ccm_question_code
                  and cql.lang_code = v_lang_code
                  and cq.ccm_question_categ_code = j.code
                  and cqc.active_flag = 'Y'
                  and cqcl.active_flag = 'Y'
                  and cq.active_flag = 'Y'
                  and cql.active_flag = 'Y'
                  order by cq.order_num
                  )
        loop
          obj4 := json(); --an empty structure
          obj4.put('CODE',k.code);
          obj4.put('NAME',k.name);
          --Append obj2 to the list
          l_obj2.append(obj4.to_json_value);
        end loop;
        --
        if json_ac.array_count(l_obj2) > 0 then
          obj3.put('ccm_question', l_obj2);
        end if;
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('ccm_question_categ', l_obj);
      end if;
      --
      obj.put('provider_ccm_question', obj2);
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_ccm_template_data_init;
  --
  PROCEDURE patient_em_sched_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    obj4        json;
    l_obj       json_list;
    l_obj2      json_list;
    l_obj3      json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_physician_sn physician.physician_sn%type;
  begin
    obj := json(); --an empty structure
    l_obj := json_list(); --an empty list obj
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,svc_date
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,completed_flag
                    ,QUALIFY_FOR_EM_FOLLOWUP_FLAG
                    ,nvl(CHRONIC_DISEASE_CNT,0) CHRONIC_DISEASE_CNT
                    ,null overall_svc_result
                    ,svc_type
                    ,pat_primary_physician_name
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,upper(substr(pat_gender,1,1)) pat_gender
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_last_name
                      else 'Mrs. '||pat_last_name
                      end pat_last_name
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_race
                    ,pat_ethnicity
                    ,pat_marital_status
                    ,pat_working_status
                    ,pat_educational_level
                    ,pat_financial_status
                    ,pat_living_status
                    ,pat_income
                    ,pat_birth_date
                    ,pat_age||'y/o' pat_age
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb||' LB' pat_weight_in_lb
                    ,pat_hdl_cholesterol_in_mg
                    ,pat_ldl_cholesterol_in_mg
                    ,pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
              from patient_prev_svc_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      --HDR
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.pat_name);
      obj2.put('GENDER',i.pat_gender);
      obj2.put('HIC',i.pat_medicare_hic_num);
      obj2.put('DOB',i.pat_birth_date);
      obj2.put('AGE',i.pat_age);
      obj2.put('DATE',i.current_date);
      obj.put('hdr', obj2);
      --================================================NON_MOD_HRA_RF
      obj2 := json(); --an empty structure
      obj2.put('HEIGHT',i.pat_height_in_ft);
      obj2.put('WEIGHT',i.pat_weight_in_lb);
      obj2.put('BMI',i.pat_bmi);
      obj2.put('BP',i.pat_bp);
      obj.put('non_mod_hra_rf', obj2);
      --================================================HRA_RESULT
      obj2 := json(); --an empty structure
      obj2.put('RESULT_STATUS',i.overall_svc_result);
      obj2.put('RESULT_NEED_CCM_FLAG',i.QUALIFY_FOR_EM_FOLLOWUP_FLAG);
      obj2.put('RESULT_MSG',report_pkg.svc_result_title(i.parent_patient_prev_svc_sn,i.pat_last_name,i.QUALIFY_FOR_EM_FOLLOWUP_FLAG,i.CHRONIC_DISEASE_CNT));
      obj.put('hra_result', obj2);
      --======================================================MOD_RF
      obj2 := json(); --an empty structure
      --================behavioral_rf
      l_obj := json_list(); --an empty list obj
      for j in (select rf_short_descr 
                from table(report_pkg.risk_factor_fnc(i.parent_patient_prev_svc_sn,null))
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.rf_short_descr);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('behavioral_rf', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Risk Factor Identified');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('behavioral_rf', l_obj);
      end if;
      --
      obj.put('mod_rf', obj2);
      --======================================================DISEASE_SEVERITY
      obj2 := json(); --an empty structure
      --================disease
      l_obj := json_list(); --an empty list obj
      for j in (select report_pkg.disease_descr(disease_categ_code,question_score_type_code,disease_short_descr,dis_level_short_descr,dis_severity_short_descr,dis_type_short_descr) disease_descr
                from table(report_pkg.svc_result_fnc(i.parent_patient_prev_svc_sn))
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('NAME',j.disease_descr);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('disease', l_obj);
      else
        l_obj := json_list(); --an empty list obj
        obj3 := json(); --an empty structure
        obj3.put('NAME','No Disease Identified');
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
        obj2.put('disease', l_obj);
      end if;
      --
      obj.put('disease_severity', obj2);
      --======================================================HR
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select hr_code code
                      ,hr_code name
                from list_hr
                order by hr_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('hr', l_obj);
      end if;
      --
      obj.put('svc_hr', obj2);
      --=====================================================MIN
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select min_code code
                      ,min_code name
                from list_min
                order by min_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('min', l_obj);
      end if;
      --
      obj.put('svc_min', obj2);
      --=====================================================AM_PM
      obj2 := json(); --an empty structure
      l_obj := json_list(); --an empty list obj
      for j in (select am_pm_code code
                      ,am_pm_code name
                from list_am_pm
                order by am_pm_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.code);
        obj3.put('NAME',j.name);
        --Append obj2 to the list
        l_obj.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj2.put('am_pm', l_obj);
      end if;
      --
      obj.put('svc_am_pm', obj2);
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_em_sched_template_data;
END common_inq_pkg;
/
show errors