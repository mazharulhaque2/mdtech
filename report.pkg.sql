set define off
create or replace PACKAGE report_pkg IS
  v_pkg_name    varchar2 (30) := upper('report_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  PROCEDURE beneficiary_rpt_menu (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob);
  PROCEDURE bene_rpt_bene_list (p_locale in varchar2,p_user_name in "AspNetUsers"."UserName"%type,p_out OUT clob);
  PROCEDURE svc_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type,p_out OUT clob);
  PROCEDURE svc_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type,p_out OUT clob);
  PROCEDURE clinical_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE clinical_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE patient_clinical_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE patient_clinical_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE em_output_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE em_output_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE svc_rpt_medication (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob);
  PROCEDURE patient_hx_and_meds (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob);
  function report_patient_med (p_locale in varchar2,p_patient_sn in number) return json_list;
  function report_patient_med_list (p_locale in varchar2,p_patient_sn in number) return json_list;
  --
  PROCEDURE hra (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE ppps (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE clinical (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE ccm_eval (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE em_eval (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  --
  PROCEDURE report_symptom (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2);
  PROCEDURE report_risk_factor (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2);
  PROCEDURE report_prev_plan (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2);
  PROCEDURE report_patient_response (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob);
  PROCEDURE report_conclusion (p_patient_prev_svc_sn in number,p_name in varchar2,p_pat_last_name in varchar2,p_em_flag in varchar2,p_CHRONIC_DISEASE_CNT in number,p_out OUT varchar2);
  PROCEDURE report_prev_plan (p_patient_prev_svc_sn in number,p_name in varchar2,p_physician_name in varchar2,p_gender_code in varchar2,p_age in number,p_bmi in number,p_bmi_result in varchar2,p_em_flag in varchar2,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_sys in number,p_dia in number,p_sugar in number,p_out OUT clob);
  PROCEDURE report_vitals (p_out OUT varchar2);
  PROCEDURE patient_vitals (p_temp in number,p_bp in varchar2,p_pulse in varchar2,p_resp in varchar2,p_rhythm in varchar2,p_out out varchar2);
  PROCEDURE tertiary_intervention (p_ppp in varchar2,p_lab_and_test in varchar2,p_referrals in varchar2,p_clinical_rx in varchar2,p_out out varchar2);
  --
  function ppp_cms (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_usda (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_gender_code in varchar2,p_age in number) return json_list;
  function ppp_referral (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_qualify_for_em_followup_flag in varchar2,p_sys in number,p_dia in number) return json_list;
  function ppp_sch_hra_sa (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return varchar2;
  function ppp_sch_psy_disorder (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_psy_depression (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_psy_anxiety (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_psy_stress (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_bp (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_chol (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_bs (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_bmi (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_physical (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  function ppp_sch_hra_behav_diet (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list;
  --
  function ppp_sa (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json;
  --
  PROCEDURE ccm_patient_agmt_data (p_patient_name in varchar2,p_primary_physician_name in varchar2,p_out OUT varchar2);
  PROCEDURE report_hdr (p_svc_type_code in varchar2,p_name in varchar2,p_date in varchar2,p_out OUT varchar2);
  PROCEDURE patient_demo (p_svc_rpt_type_code in varchar2,p_gender in varchar2,p_hic in varchar2,p_dob in varchar2,p_age in number,p_bp in varchar2,p_orin in varchar2,p_hist_src in varchar2,p_status in varchar2,p_svc_place in varchar2,p_phy in varchar2,p_bmi_result in varchar2,p_out OUT varchar2);
  PROCEDURE report_hra (p_patient_sn in number,p_patient_prev_svc_sn in number,p_age in number,p_gender in varchar2,p_gender_code in varchar2,p_rase in varchar2,p_fin_status in varchar2,p_living_status in varchar2,p_edu in varchar2,p_out OUT varchar2);
  PROCEDURE report_clinical (p_patient_prev_svc_sn in number,p_out OUT varchar2);
  --
  function svc_result_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return t_svc_result_tab PIPELINED;
  function symptom_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return t_symptom_tab PIPELINED;
  function risk_factor_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return t_risk_factor_tab PIPELINED;
  function svc_result_title (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_pat_last_name in varchar2,p_em_flag in varchar2,p_CHRONIC_DISEASE_CNT in number) return varchar2;
  function disease_descr (disease_categ_code in varchar2,question_score_type_code in varchar2,disease_short_descr in varchar2,dis_level_short_descr in varchar2,dis_severity_short_descr in varchar2,dis_type_short_descr in varchar2) return varchar2;
  function medication_descr (p_name in varchar2,p_quantity in varchar2,p_quantity_unit in varchar2,p_frequency in varchar2,p_purpose in varchar2,p_prescribed_med_flag in varchar2) return varchar2;
  function prescribed_medication_descr (p_name in varchar2,p_quantity in varchar2,p_quantity_unit in varchar2,p_frequency in varchar2,p_purpose in varchar2) return varchar2;
  function score_descr (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_sub_category_code in categ_score_eval.QUESTION_SUB_CATEG_CODE%type) return categ_score_eval_lang.short_descr%type;
  function patient_categ_qtn_response (p_patient_prev_svc_sn in number,p_category_code in varchar2,p_question_code in varchar2) return varchar2;
  function user_role_patient_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED;
  function disease_rf(p_patient_prev_svc_sn in number,p_disease_code in varchar2,p_primary_rf_flag in varchar2,p_bmi_result in varchar2,p_bmi in number,p_age in number,p_race_code in varchar2,p_gender_code in varchar2,p_financial_status_code in varchar2) return json_list;
  function disease_rpt_label (p_disease_code in varchar2,p_disease_severity_code in varchar2,p_disease_name in varchar2,p_disease_level in varchar2) return varchar2;
  function disease_rf_label (p_disease_code in varchar2,p_disease_severity_code in varchar2,p_disease_name in varchar2,p_disease_level in varchar2) return varchar2;
  function rx_meds_result (p_patient_prev_svc_sn in number,p_med_cnt in number) return varchar2;
  function patient_med_list (p_patient_sn in number,p_medication_current_flag in varchar2,p_prescribed_med_flag in varchar2) return json_list;
  function patient_remark_list (p_patient_prev_svc_sn in number) return json_list;
  function medicare_ins_by_hic_flag (p_hic in varchar2) return varchar2;
END report_pkg;
/
show errors
create or replace PACKAGE BODY report_pkg IS
  function medicare_ins_by_hic_flag (p_hic in varchar2) return varchar2
  is
  begin
    --If first digit is number and the full hic is non number then MED.
    --If first digit is letter then commercial insurance
    if common_pkg.is_a_valid_number(substr(p_hic,1,1)) = 'Y' then --first digit is number
      if common_pkg.is_a_valid_number(p_hic) = 'N' then return 'Y';
      else return 'N';
      end if;
    else return 'N';
    end if;
  end medicare_ins_by_hic_flag;
  --
  function rx_meds_result (p_patient_prev_svc_sn in number,p_med_cnt in number) return varchar2
  is
    v_1001_rx_comp  varchar2(1) := 'N';
    v_1002_issue    varchar2(1) := 'N';
    v_1003_effect   varchar2(1) := 'N';
  begin
    for i in (select question_code
              from patient_response_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'MEDCP'
              and response_score <> 0
              )
    loop
      if i.question_code = '1001' then v_1001_rx_comp := 'Y';
      elsif i.question_code = '1002' then v_1002_issue := 'Y';
      elsif i.question_code = '1003' then v_1003_effect := 'Y';
      end if;
    end loop;
    if v_1001_rx_comp = 'Y' and v_1002_issue = 'Y' and v_1003_effect = 'Y' then return 'Prescribed Meds are not resolving health issues, causing side effect and not taking as Dr prescribed';
    elsif v_1003_effect = 'Y' and v_1002_issue = 'Y' then return 'Prescribed Meds are not resolving health issues and causing side effect';
    elsif v_1003_effect = 'Y' and v_1001_rx_comp = 'Y' then return 'Prescribed Meds causing side effect and not taking as Dr prescribed';
    elsif v_1002_issue = 'Y' and v_1001_rx_comp = 'Y' then return 'Prescribed Meds are not resolving health issues and not taking as Dr prescribed';
    elsif v_1003_effect = 'Y' then return 'Prescribed Meds causing side effect';
    elsif v_1002_issue = 'Y' then return 'Prescribed Meds are not resolving health issues';
    elsif v_1001_rx_comp = 'Y' then return 'Not taking Meds as Dr prescribed';
    else
      if p_med_cnt = 0 then return 'Currently no Prescribed Meds reported';
      else return 'No concern with Prescribed Meds';
      end if;
    end if;
  end rx_meds_result;
  --
  function disease_rpt_label (p_disease_code in varchar2,p_disease_severity_code in varchar2,p_disease_name in varchar2,p_disease_level in varchar2) return varchar2
  is
    v_return varchar2(1000);
    v_severity_txt varchar2(100);
  begin
    if p_disease_severity_code = 'RISKA' then 
      if p_disease_code in ('FDEC','CDEC') then v_severity_txt := 'Risk of a';
      else v_severity_txt := 'Risk of';
      end if;
    else v_severity_txt := 'Risk to Exacerbate';
    end if;
    --
    if p_disease_code in ('DIZI','HEAR','HOME') then v_return := 'You reported '||p_disease_name||' which is '||p_disease_level||' as per validated Inventory test that is interfering in your daily living and may be a Factor to sustain a Fall/injury';
    elsif p_disease_code = 'CHDE' then v_return := 'You are at '||p_disease_level||' '||v_severity_txt||' Cardiovascular Disease';
    elsif p_disease_code = 'HBPR' then
      if p_disease_severity_code = 'RISKA' then v_return := 'You are at '||p_disease_level||' Risk to become Hypertensive';
      else v_return := 'You are at '||p_disease_level||' Risk to Exacerbate your Hypertension';
      end if;
    elsif p_disease_code = 'FALL' then v_return := 'You are at '||p_disease_level||' Risk to sustain a Fall';
    elsif p_disease_code = 'FRLT' then v_return := 'Your health is at Risk to become Frail';
    elsif p_disease_code = 'LONL' then v_return := 'You are suffering of Loneliness';
    else v_return := 'You are at '||p_disease_level||' '||v_severity_txt||' '||p_disease_name;
    end if;
    return v_return;
  end disease_rpt_label;
  --
  function disease_rf_label (p_disease_code in varchar2,p_disease_severity_code in varchar2,p_disease_name in varchar2,p_disease_level in varchar2) return varchar2
  is
    v_return varchar2(1000);
    v_severity_txt varchar2(100);
  begin
    if p_disease_code in ('DIZI','HEAR','HOME','LONL','ANXT','DEPR','STRS') then v_return := 'Finding related to your '||p_disease_name;
    elsif p_disease_code = 'FALL' then v_return := 'Evidenced Risk Factors related to a Fall at Risk';
    else v_return := 'Evidenced Risk Factors related to '||p_disease_name;
    end if;
    return v_return;
  end disease_rf_label;
  --
  function disease_level(p_disease_level_code in varchar2) return varchar2
  is
    v_short_descr disease_level_lang.short_descr%type;
  begin
    select short_descr
    into v_short_descr
    from disease_level_lang
    where disease_level_code = p_disease_level_code
    and lang_code = 'en'
    ;
    return v_short_descr;
  end disease_level;
  --
  function disease_severity(p_disease_severity_code in varchar2) return varchar2
  is
    v_short_descr disease_severity_lang.short_descr%type;
  begin
    select short_descr
    into v_short_descr
    from disease_severity_lang
    where disease_severity_code = p_disease_severity_code
    and lang_code = 'en'
    ;
    return v_short_descr;
  end disease_severity;
  --====================================local functions returning text======================
  function wrong_behav(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list;
    v_daw_cnt pls_integer := 0;
    v_dhm_cnt pls_integer := 0;    
  begin
    l_obj := json_list();
    --Non diet related wrong behavior
    for j in (select case
                      when question_code = '1009' then case when response_code = 'N01' then question_rpt_descr||' (Sit most of the day)' else question_rpt_descr||' (Don''t Sit most of the day)' end
                      when question_code = '1005' then case when response_code = 'Y07' then question_rpt_descr||' (NO Plans to Quit)' else question_rpt_descr||' (Plans to Quit)' end
                      else question_rpt_descr
                      end descr
              from patient_response_vw prv
                  ,risk_factor_vw rfv
              where prv.risk_factor_code = rfv.risk_factor_code              
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              and prv.category_code = 'BEHVT'
              and rfv.diet_categ_flag = 'N'
              )
    loop
      l_obj.append(j.descr);
    end loop;
    --diet related wrong behavior    
    for j in (select rfv.risk_factor_categ_code,count(*) cnt
              from patient_response_vw prv
                  ,risk_factor_vw rfv
              where prv.risk_factor_code = rfv.risk_factor_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              and prv.category_code = 'BEHVT'
              and rfv.diet_categ_flag = 'Y'
              and rfv.risk_factor_categ_code in ('DAW','DHM')
              group by rfv.risk_factor_categ_code
              )
    loop
      if j.risk_factor_categ_code = 'DAW' then
        v_daw_cnt := j.cnt;
      else
        v_dhm_cnt := j.cnt;
      end if;
    end loop;
    if v_daw_cnt > 0 then
      if v_daw_cnt > 1 then
        l_obj.append('Poor nutrition away from home');
      else
        for j in (select prv.question_rpt_descr
                  from patient_response_vw prv
                      ,risk_factor_vw rfv
                  where prv.risk_factor_code = rfv.risk_factor_code
                  and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
                  and prv.category_code = 'BEHVT'
                  and rfv.diet_categ_flag = 'Y'
                  and rfv.risk_factor_categ_code = 'DAW'
                  )
        loop
          l_obj.append(j.question_rpt_descr);
        end loop;
      end if;                
    end if;
    --
    if v_dhm_cnt > 0 then
      if v_dhm_cnt > 1 then
        l_obj.append('Poor nutrition habit at home');
      else
        for j in (select prv.question_rpt_descr
                  from patient_response_vw prv
                      ,risk_factor_vw rfv
                  where prv.risk_factor_code = rfv.risk_factor_code
                  and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
                  and prv.category_code = 'BEHVT'
                  and rfv.diet_categ_flag = 'Y'
                  and rfv.risk_factor_categ_code = 'DHM'
                  )
        loop
          l_obj.append(j.question_rpt_descr);
        end loop;
      end if;                
    end if;
    for j in (select prv.question_rpt_descr
              from patient_response_vw prv
                  ,risk_factor_vw rfv
              where prv.risk_factor_code = rfv.risk_factor_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              and prv.category_code = 'BEHVT'
              and rfv.diet_categ_flag = 'Y'
              and rfv.risk_factor_categ_code = 'DOT'
              )
    loop
      l_obj.append(j.question_rpt_descr);
    end loop;
    return l_obj;
  end wrong_behav;
  --
  function usda_vaccination_test(p_patient_prev_svc_sn in number,p_gender_code in varchar2) return json_list
  is
    l_obj json_list;
    v_patient_sn number(11);
  begin
    l_obj := json_list();
    --USDA vaccination and Test
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;   
    for i in (select case 
                      when em_categ_code = 'IMMU' then 'Compliance of USDA Vaccination - '||em_name_short_descr
                      else 'Compliance of USDA Test - '||em_name_short_descr
                      end em_name_short_descr
              from em_name_vw
              where usda_immu_comp_flag = 'Y'
              and nvl(triggered_code,p_gender_code) = p_gender_code
              and em_name_code not in (select nvl(em_name_code,'99999999')
                            from patient_history_vw
                            where patient_sn = v_patient_sn
                            and category_code in ('HVACN','HVART')
                            and nvl(triggered_other_code,p_gender_code) = p_gender_code
                            )
              order by em_categ_code
              )
    loop
      l_obj.append(i.em_name_short_descr);
    end loop;    
    return l_obj;
  end usda_vaccination_test;
  --
  function disease_as_a_rf(p_patient_prev_svc_sn in number,p_disease_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    for i in (select case 
                      when srv.disease_type_code = 'DISO' then to_char(nvl(prv.question,srv.disease_short_descr))
                      when srv.disease_code = 'DIAB' then case when common_inq_pkg.disease_rf_level(srv.patient_prev_svc_sn,srv.disease_code) <> 'LOW' then 'Your PMHx - Uncontrolled Diabetes' else 'Your PMHx - Diabetes' end
                      when srv.disease_code = 'HBPR' then case when common_inq_pkg.disease_rf_level(srv.patient_prev_svc_sn,srv.disease_code) <> 'LOW' then 'Your PMHx - Uncontrolled High Blood Pressure' else 'Your PMHx - High Blood Pressure' end
                      when srv.disease_code = 'HCHO' then case when common_inq_pkg.disease_rf_level(srv.patient_prev_svc_sn,srv.disease_code) <> 'LOW' then 'Your PMHx - Uncontrolled High Cholesterol' else 'Your PMHx - High Cholesterol' end
                      else 'Your PMHx - '||to_char(nvl(prv.question,srv.disease_short_descr))
                      end disease_name
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = v_patient_sn
              and srv.disease_code = p_disease_code
              and srv.disease_severity_code <> 'RISKA'
              and prv.category_code(+) = 'BMEDH'
              )
    loop
      l_obj.append(i.disease_name);
    end loop;
    return l_obj;
  end disease_as_a_rf;
  --==================================
  function patient_hx(p_patient_sn in number,p_categ_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when question_rpt_descr is not null then case when response_code = 'CBX' then question_rpt_descr else question_rpt_descr||' ('||response||')' end
                      else case when response_code = 'CBX' then question else question||' ('||response||')' end
                      end response
              from patient_history_vw 
              where category_code = p_categ_code
              and patient_sn = p_patient_sn
              and question_code <> '1099'
              and response_code <> 'NON'
              )
    loop
      l_obj.append(i.response);
    end loop;
    return l_obj;
  end patient_hx;
  --
  function disease_fmhx(p_patient_prev_svc_sn in number,p_disease_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
    v_rsp varchar2(100);
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    for j in (select 'Family PMHx of '||question||' ('||response||')' response
              from patient_history_vw
              where patient_sn = v_patient_sn
              and category_code = 'FHNMR'
              and disease_code = p_disease_code
              and response_code <> 'NON'
              )
    loop
      l_obj.append(j.response);
    end loop;
    --Parents(any) died before age of 50? is a risk factor for CNCR and also for CHDE. The question response have
    --only one column (disease) to associate with this question and CNCR is the disease which has been associated.
    --So for CHDE, seperate inquiry needs to be made to evaluate FMHX of a disease.
    if p_disease_code = 'CHDE' then
      if report_pkg.patient_categ_qtn_response(p_patient_prev_svc_sn,'FHNMR','1014') <> 'NON' then
        select 'Family PMHx of '||question||' ('||response||')'
        into v_rsp
        from patient_history_vw 
        where patient_sn = v_patient_sn
        and category_code = 'FHNMR'
        and question_code = '1014'
        ;
        l_obj.append(v_rsp);
      end if;
    end if;
    return l_obj;
  end disease_fmhx;
  --
  function alco_rf(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    --There are two response will trigger Alcohol as a RF. Y09 and Y10
    if report_pkg.patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1006') = 'Y09' then
      l_obj.append('Uncontrolled Alcohol Consumption (Drink more than 6 driks per week and Plans to Quit)');
    else --Y10
      l_obj.append('Uncontrolled Alcohol Consumption (Drink more than 6 driks per week and NO Plans to Quit)');
    end if;
    return l_obj;
  end alco_rf;
  --
  function strk_rf(p_patient_prev_svc_sn in number,p_age in number,p_primary_rf_flag in varchar2,p_calls_from_riska_evnt_flag in varchar2) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    if p_primary_rf_flag = 'Y' then
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1009','CBX') = 'Y' then
        l_obj.append('Your PMHx - Congestive Heart Failure (CHF)');
      elsif common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1011','CBX') = 'Y' then
        l_obj.append('Your PMHx -  Atrial Fibrillation (AF/a-fib)');
      end if;
      if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'HBPR') <> 'LOW' then --uncontrolled BP
        l_obj.append('Reported Uncontrolled Hypertension (High Blood Pressure - HBP)');
      end if;
      if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'DIAB') <> 'LOW' then --uncontrolled diab
        l_obj.append('Reported Uncontrolled Diabetes (Diabetes Mellitus -DM2)');
      end if;
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'STRK') = 'Y' then --Stroke/TIA (Cerebrovascular Accident(CVA)) History
        l_obj.append('Your PMHx - Stroke/TIA');
      end if;
      --Any post Stroke(CVA) limitation
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1029','CBX') = 'Y' then
        l_obj.append('Reported late effect of Stroke/TIA as Hemiparesis');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1030','CBX') = 'Y' then
        l_obj.append('Reported late effect of Stroke/TIA as Speech');
      end if;
      if p_calls_from_riska_evnt_flag = 'Y' then
        if p_age >= 75 then
          l_obj.append('Your Age ('||p_age||' y/o)');
        end if;
        l_obj2 := disease_fmhx(p_patient_prev_svc_sn,'STRK');
        if json_ac.array_count(l_obj2) <> 0 then
          for i in 1..json_ac.array_count(l_obj2) loop
            l_obj.append(json_ac.array_get(l_obj2,i).get_string);
          end loop;
        end if;
      end if;
    else
      if p_age >= 75 then
        l_obj.append('Your Age ('||p_age||' y/o)');
      end if;
      l_obj2 := disease_fmhx(p_patient_prev_svc_sn,'STRK');
      if json_ac.array_count(l_obj2) <> 0 then
        for i in 1..json_ac.array_count(l_obj2) loop
          l_obj.append(json_ac.array_get(l_obj2,i).get_string);
        end loop;
      end if;
    end if;
    return l_obj;
  end strk_rf;
  --
  function diet_rf(p_patient_prev_svc_sn in number,p_disease_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
    v_daw_cnt pls_integer := 0;
    v_dhm_cnt pls_integer := 0;
  begin
    if p_disease_code <> 'CHDE' then
      for j in (select question_rpt_descr
                from patient_response_vw 
                where patient_prev_svc_sn = p_patient_prev_svc_sn
                and category_code = 'BEHVT'
                and risk_factor_code = p_disease_code
                )
      loop
        l_obj.append(j.question_rpt_descr);
      end loop;
    else --CHDE
      for j in (select rfv.risk_factor_categ_code,count(*) cnt
                from patient_response_vw prv
                    ,risk_factor_vw rfv
                where prv.risk_factor_code = rfv.risk_factor_code
                and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
                and prv.category_code = 'BEHVT'
                and rfv.diet_categ_flag = 'Y'
                and rfv.risk_factor_categ_code in ('DAW','DHM')
                group by rfv.risk_factor_categ_code
                )
      loop
        if j.risk_factor_categ_code = 'DAW' then
          v_daw_cnt := j.cnt;
        else
          v_dhm_cnt := j.cnt;
        end if;
      end loop;
      if v_daw_cnt > 0 then
        if v_daw_cnt > 1 then
          l_obj.append('Poor nutrition away from home');
        else
          for j in (select prv.question_rpt_descr
                    from patient_response_vw prv
                        ,risk_factor_vw rfv
                    where prv.risk_factor_code = rfv.risk_factor_code
                    and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
                    and prv.category_code = 'BEHVT'
                    and rfv.diet_categ_flag = 'Y'
                    and rfv.risk_factor_categ_code = 'DAW'
                    )
          loop
            l_obj.append(j.question_rpt_descr);
          end loop;
        end if;                
      end if;
      --
      if v_dhm_cnt > 0 then
        if v_dhm_cnt > 1 then
          l_obj.append('Poor nutrition habit at home');
        else
          for j in (select prv.question_rpt_descr
                    from patient_response_vw prv
                        ,risk_factor_vw rfv
                    where prv.risk_factor_code = rfv.risk_factor_code
                    and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
                    and prv.category_code = 'BEHVT'
                    and rfv.diet_categ_flag = 'Y'
                    and rfv.risk_factor_categ_code = 'DHM'
                    )
          loop
            l_obj.append(j.question_rpt_descr);
          end loop;
        end if;                
      end if;
    end if;
    return l_obj;
  end diet_rf;
  --
  function non_diet_rf(p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when question_code = '1009' then case when response_code = 'N01' then question_rpt_descr||' (Sit most of the day)' else question_rpt_descr||' (Don''t Sit most of the day)' end
                      when question_code = '1005' then case when response_code = 'Y07' then question_rpt_descr||' (NO Plans to Quit)' else question_rpt_descr||' (Plans to Quit)' end
                      else question_rpt_descr
                      end question_rpt_descr                      
              from patient_response_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and risk_factor_code = p_risk_factor_code
              and category_code = 'BEHVT'
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end non_diet_rf;
  --
  function pain_symptom_rf(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select question
              from patient_response_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'MUSCS'
              and lower(question) like '%pain%'
              )
    loop
      l_obj.append(i.question);
    end loop;
    return l_obj;
  end pain_symptom_rf;
  --
  function symptom_rf(p_patient_prev_svc_sn in number,p_disease_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select prv.question
              from disease_symptom_vw dsv
                  ,patient_response_vw prv
              where prv.symptom_code = dsv.symptom_code
              and dsv.disease_code = p_disease_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj.append(i.question);
    end loop;
    return l_obj;
  end symptom_rf;
  --
  function frlt_rf(p_patient_prev_svc_sn in number,p_age in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    l_obj.append('Your Age ('||p_age||' y/o)');
    for i in (select case
                      when category_code = 'FRLTY' then question_rpt_descr||' ('||response||')'
                      else question_rpt_descr
                      end question_rpt_descr
              from patient_response_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code in ('FRLTY','FRLT1','FRLT2')
              and response_score <> 0
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end frlt_rf;
  --
  function fall_rf(p_patient_prev_svc_sn in number,p_patient_sn in number,p_age in number,p_med_cnt in number) return json_list
  is
    l_obj json_list;
    l_obj2 json_list;
    v_dizi_level categ_score_eval.disease_level_code%type;
    v_dizi_text varchar2(30);
  begin
    l_obj := json_list();
    l_obj2 := json_list();
    for i in (select question_rpt_descr descr
              from patient_response_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'FALLR'
              and response_score <> 0
              )
    loop
      l_obj.append(i.descr);
    end loop;
    --
    if common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'HOMES',null),'HOMES',null) <> 'LOW' then --Home Lack of Safety
      l_obj.append('You reported Home Lack of Safety as per validated Inventory test');
    end if;
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1002','NOO') = 'Y' then 
      v_dizi_level := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'DIZZI',null),'DIZZI',null);
      if v_dizi_level <> 'LOW' then
        if v_dizi_level = 'MOD' then v_dizi_text := 'Moderate';
        elsif v_dizi_level = 'HIG' then v_dizi_text := 'High';
        elsif v_dizi_level = 'SEV' then v_dizi_text := 'Severe';
        end if;
        --
        l_obj.append('Reported '||v_dizi_text||' Dizziness in your validated clinical test.');
      elsif common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HENMT','1002','CBX') = 'Y' then
        l_obj.append('Dizziness (light head) reported in your neurological Symptoms');
      end if;
    end if;
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','NOO') = 'Y' then 
      if common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'HHISQ',null),'HHISQ',null) <> 'LOW' then
        l_obj.append('You reported Hearing Loss as per validated Inventory test');
      end if;
    end if;
    --
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1001','Y01') = 'Y' then
      l_obj.append('Sustained a fall during past 2 years (Needed to go to ER)');
    end if;
    if  common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1001','Y02') = 'Y' then
      l_obj.append('Sustained a fall during past 2 years (Did not need to go to ER)');
    end if;
    if p_med_cnt > 2 then
      l_obj.append('Take '||p_med_cnt||' Rx meds daily');
    end if;
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1021','YES') = 'Y' then
      l_obj.append('Daily activity limitation due to Fall/Injury');
    end if;
    if p_age >= 80 then
      l_obj.append('Your Age ('||p_age||' y/o)');
    end if;    
    --
    if common_inq_pkg.trouble_walking_flag(p_patient_prev_svc_sn) = 'Y' then
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FRLT1','1005','ATD') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FRLT1','1005','UTD') = 'Y' then
        l_obj.append('Additional Factor - Difficulty in walking short distance');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FRLT2','1003','YES') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FRLT2','1003','DD1') = 'Y' then
        l_obj.append('Additional Factor - Difficulty in walking across the room');
      end if;
    end if;
    --
    if common_inq_pkg.pain_symptom_flag (p_patient_prev_svc_sn) = 'Y' then
      l_obj2 := pain_symptom_rf(p_patient_prev_svc_sn);
      if json_ac.array_count(l_obj2) <> 0 then
        for i in 1..json_ac.array_count(l_obj2) loop
          l_obj.append('Additional Factor - '||json_ac.array_get(l_obj2,i).get_string);
        end loop;
      end if;
    end if;
    return l_obj;
  end fall_rf;
  --====================================local functions returning text======================
  function disease_rf(p_patient_prev_svc_sn in number,p_disease_code in varchar2,p_primary_rf_flag in varchar2,p_bmi_result in varchar2,p_bmi in number,p_age in number,p_race_code in varchar2,p_gender_code in varchar2,p_financial_status_code in varchar2) return json_list
  is
    l_obj json_list;
    l_obj2 json_list;
  begin
    l_obj := json_list();
    --
    if p_disease_code = 'STRK' then
      l_obj := strk_rf(p_patient_prev_svc_sn,p_age,p_primary_rf_flag,'N');
    else
      l_obj := json_list();
      for i in (select risk_factor_code,severity_code,risk_factor_is_a_disease_flag,rf_diet_categ_flag
                from disease_risk_factor_vw
                where disease_code = p_disease_code
                and PRIMARY_RISK_FACTOR_FLAG = p_primary_rf_flag
                order by risk_factor_is_a_disease_flag desc
                )
      loop
        if i.risk_factor_is_a_disease_flag = 'Y' then
          if i.risk_factor_code in ('DIAB','HBPR') then
            if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,i.risk_factor_code) = 'Y' then
              l_obj2 := json_list();
              l_obj2 := disease_as_a_rf(p_patient_prev_svc_sn,i.risk_factor_code);
              if json_ac.array_count(l_obj2) <> 0 then
                for j in 1..json_ac.array_count(l_obj2) loop
                  l_obj.append(json_ac.array_get(l_obj2,j).get_string);
                end loop;
              end if;
            end if;
          else
            if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
              l_obj2 := json_list();
              l_obj2 := disease_as_a_rf(p_patient_prev_svc_sn,i.risk_factor_code);
              if json_ac.array_count(l_obj2) <> 0 then
                for j in 1..json_ac.array_count(l_obj2) loop
                  l_obj.append(json_ac.array_get(l_obj2,j).get_string);
                end loop;
              end if;
            end if;
          end if;
        else
          if i.rf_diet_categ_flag = 'Y' then
            l_obj2 := json_list();
            l_obj2 := diet_rf(p_patient_prev_svc_sn,p_disease_code);          
            if json_ac.array_count(l_obj2) <> 0 then
              for j in 1..json_ac.array_count(l_obj2) loop
                l_obj.append(json_ac.array_get(l_obj2,j).get_string);
              end loop;
            end if;
          else
            if i.risk_factor_code = 'BMIR' then
              if common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then
                l_obj.append('BMI Result: '||p_bmi||'('||p_bmi_result||')');
              end if;
            elsif i.risk_factor_code = 'AGEE' then
              if svc_eval_pkg.age_rf(p_disease_code,p_age) <> 'LOW' then
                l_obj.append('Your Age ('||p_age||' y/o)');
              end if;
            elsif i.risk_factor_code = 'RACE' then
              if svc_eval_pkg.race_rf(p_disease_code,p_race_code,null) <> 'LOW' then
                l_obj.append('Your Race');
              end if;
            elsif i.risk_factor_code = 'GNDR' then
              if svc_eval_pkg.gender_rf(p_disease_code,p_gender_code) <> 'LOW' then
                l_obj.append('Your Gender');
              end if;
            elsif i.risk_factor_code = 'FMHX' then
              if common_inq_pkg.disease_fmhx_level(p_patient_prev_svc_sn,p_disease_code) <> 'LOW' then
                l_obj2 := json_list();
                l_obj2 := disease_fmhx(p_patient_prev_svc_sn,p_disease_code);
                if json_ac.array_count(l_obj2) <> 0 then
                  for j in 1..json_ac.array_count(l_obj2) loop
                    l_obj.append(json_ac.array_get(l_obj2,j).get_string);
                  end loop;
                end if;
              end if;
            elsif i.risk_factor_code = 'SECO' then
              if common_inq_pkg.seco_rf_level(p_financial_status_code) <> 'LOW' then
                l_obj.append('Limitation of economic and social indicators.');
              end if;
            elsif i.risk_factor_code = 'COMO' then
              if svc_eval_pkg.como_level(p_patient_prev_svc_sn) <> 'LOW' then
                l_obj.append('Comorbidity.');
              end if;
            elsif i.risk_factor_code = 'FRLT' then
              if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FRLT') = 'Y' then
                l_obj.append('Frailty Health');
              end if;
            elsif i.risk_factor_code in ('ALCO','INAC','TBCO','SLEP','WATR','WEIT') then
              if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
                l_obj2 := json_list();
                l_obj2 := non_diet_rf(p_patient_prev_svc_sn,i.risk_factor_code);
                if json_ac.array_count(l_obj2) <> 0 then
                  for j in 1..json_ac.array_count(l_obj2) loop
                    l_obj.append(json_ac.array_get(l_obj2,j).get_string);
                  end loop;
                end if;
              end if;
            end if;
          end if;
        end if;
      end loop;
    end if;
    --
    return l_obj;
  end disease_rf;
  --ppp self assessment rf
  function ppp_sa (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json
  is
    obj         json;
    obj2        json;
    v_rsp       varchar2(30);
  begin
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','HRA SELF ASSESSMENT AS A RISK FACTOR');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('PARA1',ppp_sch_hra_sa(p_patient_prev_svc_sn));
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','FIR') = 'Y' then v_rsp := 'FAIR';
    else v_rsp := 'POOR';
    end if;
    obj2.put('PARA2','To help you out to change your **'||v_rsp||' Health Self Perception** and to cope with the reported activities limitation, an integrated Personalized Prevention Plan will be included into any disease or Major event you are at Risk that is related with your negative Assessment.');
    obj.put('label',obj2);
    return obj;
  end ppp_sa;
  --ppp self assessment no rf
  function ppp_sa_no_rf (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json
  is
    obj         json;
    obj2        json;
  begin
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','CONGRATULATION FOR YOUR WONDERFUL HEALTH');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('PARA1','Currently, you don''t have any major health risk or condition. There is NO OTHER related negative Health finding of your HRA Outcome that concern your Physician.');
    obj2.put('PARA2','Please continue all of your healthy behavior to maintain your wonderful health.');
    obj.put('label',obj2);
    return obj;
  end ppp_sa_no_rf;
  --
  function disease_prev_plan (p_disease_code in varchar2, p_prev_plan_code in varchar2) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select prev_plan_long_descr descr
              from disease_prev_plan_vw 
              where disease_code = p_disease_code
              and (p_prev_plan_code is null or prev_plan_code <> p_prev_plan_code)
              order by order_num
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end disease_prev_plan;
  --
  function risk_factor_prev_plan (p_risk_factor_code in varchar2, p_prev_plan_code in varchar2) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select prev_plan_long_descr descr
              from risk_factor_prev_plan_vw 
              where risk_factor_code = p_risk_factor_code
              and (p_prev_plan_code is null or prev_plan_code <> p_prev_plan_code)
              order by order_num
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end risk_factor_prev_plan;
  --
  function tbco_quit_prev_plan return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select prev_plan_long_descr descr
              from risk_factor_prev_plan_vw 
              where risk_factor_code = 'TBCO'
              and prev_plan_code in ('7502','7503','7504','7505','7506','7507','7508')
              order by order_num
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end tbco_quit_prev_plan;
  --
  function disease_risk_factor (p_disease_code in varchar2) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select rf_short_descr||' ('||severity_short_descr||')' descr
              from disease_risk_factor_vw 
              where disease_code = p_disease_code
              order by severity_code desc
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end disease_risk_factor;
  --Patient response that triggered a specific condition become a risk factor
  function cond_triggered_resp (p_patient_prev_svc_sn in number,p_category_code in varchar2,p_include_resp in varchar2) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select case 
                      when p_include_resp = 'Y' then case when response_code = 'YES' then question_rpt_descr else question_rpt_descr||' ('||response||')' end
                      else question_rpt_descr
                      end descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = p_category_code
              and nvl(response_score,0) <> 0
              )
    loop
      l_obj.append(i.descr);
    end loop;
    --
    if p_category_code = 'DIZZI' then
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HENMT','1002','CBX') = 'Y' then --Dizziness (morning or evening) or Dizziness (lightheadedness) symptom
        l_obj.append('Dizziness (light head) reported in your neurological Symptoms');
      elsif common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1002','YES') = 'Y' then -- reported dizziness in the fall rf
        l_obj.append('You reported feeling Dizziness during morning or evening hours.');
      end if;
    elsif p_category_code = 'HHISQ' then
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','YES') = 'Y' then 
        l_obj.append('You reported suffering from hearing loss.');
      end if;
    end if;
    return l_obj;
  end cond_triggered_resp;
  --Patient response that triggered a specific condition become a risk factor (ADL and IADL only)
  function cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn in number,p_category_code in varchar2) return json_list
  is
    l_obj       json_list;
    v_age number(9);
    v_bmi number(9,3);
    v_bmi_result varchar2(30);
  begin
    select common_pkg.age_at_a_date(p.birth_date,pps.svc_date)
          ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)
          ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in))          
    into v_age
        ,v_bmi
        ,v_bmi_result
    from patient_prev_svc pps
        ,patient p
    where pps.patient_sn = p.patient_sn
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    l_obj := json_list();
    for i in (select response descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = p_category_code
              and response_score = 0
              )
    loop
      l_obj.append(i.descr);
    end loop;
    --
    if p_category_code = 'IADLB' then --cdec
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1022','YES') = 'Y' then
        l_obj.append('Reported declining of cognitive skill');
      end if;
      if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DEPR') = 'Y' then
        l_obj.append('Depression');
      end if;
      if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'SCHI') = 'Y' then
        l_obj.append('Schizophrenia');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1005','YES') = 'Y' then
        l_obj.append('Reported Poor memory');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1012','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1007','YES') = 'Y' then
        l_obj.append('Additional Factor: Reported Slow movement');
      end if;
      if v_age >= 80 then
        l_obj.append('Additional Factor: Your Age ('||v_age||' y/o)');
      end if;
    else --ADLBF
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'MUSCS','1002','CBX') = 'Y' then
        l_obj.append('Reported Joint pain');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1011','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1005','YES') = 'Y' then
        l_obj.append('Reported Loss of balance');
      end if;
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1012','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1007','YES') = 'Y' then
        l_obj.append('Reported Slow movement or Walking Short steps');
      end if;
      if v_age >= 80 then
        l_obj.append('Additional Factor: Your Age ('||v_age||' y/o)');
      end if;
      if common_inq_pkg.obesity_rf_level(v_bmi_result) <> 'LOW' then
        l_obj.append('Additional Factor: BMI Result '||v_bmi||'('||v_bmi_result||')');
      end if;
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'INAC') <> 'LOW' then
        l_obj.append('Additional Factor: Lack of activity');
      end if;
    end if;
    return l_obj;
  end cond_triggered_resp_adl_iadl;
  --
  --Patient response that triggered a specific condition become a risk factor (DEPR, ANXT and STRS)
  function cond_triggered_resp_psy (p_patient_prev_svc_sn in number,p_category_code in varchar2) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select question_rpt_descr descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = p_category_code
              and nvl(response_score,0) <> 0
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end cond_triggered_resp_psy;
  --Patient response that triggered a specific condition become a risk factor (DEPR, ANXT and STRS)
  function cond_triggered_resp_mdq (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj       json_list;
  begin
    l_obj := json_list();
    for i in (select question_rpt_descr descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'MOOD1'
              and response_score <> 0
              )
    loop
      l_obj.append(i.descr);
    end loop;
    l_obj.append('Several of the above things happened during the same time period and caused moderate to serious Problem in your life');
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end cond_triggered_resp_mdq;
  --
  function ppp_psy_depr (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_disease_level_code_descr in varchar2,p_disease_severity_code in varchar2,p_dis_severity_short_descr in varchar2) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
  begin
    if p_disease_severity_code = 'RISKA' then --opt A-1 (risk to acquire)
      v_outcome_text := 'Your HRA Outcome finding reflected**'||p_disease_level_code_descr||'**Risk to Acquire a Depression Disorder.';
      v_ppp_text := 'To cope with your Risk to have a  harmful Depression, your physician recommends:';
      v_prev_plan_code := null;
      v_ppp_em_text := null;
    else --disease acquired
      if p_qualify_for_em_followup_flag = 'N' then --opt A-1i (Acquired but not qualify for CCM)
        v_outcome_text := 'Your HRA Outcome finding reflected that you have PMHx of ACTUAL Depression Disorder without other relevant Chronic condition';
        v_ppp_text := 'To cope with your harmful Depression, your Physician recommends:';
        v_prev_plan_code := '2002';
        v_ppp_em_text := null;
      else --opt A-1ii (CCM patient)
        v_outcome_text := 'Your HRA Outcome finding reflected Mod-Severe Risk to exacerbate  ACTUAL Depression condition that is aggravated by other existent major Medical conditions showed in PMHx.';
        v_ppp_text := 'Your Physician recommends:';
        v_prev_plan_code := '2002';
        v_ppp_em_text := 'In viewing your HRA Outcome identified serious Disease Risk Factors related to your Major Depression at Risk, an EM Face to Face Assessment is clinically needed to establish an efficient Prevention Program to AVOID or Retard Major Health issues that will seriously impact your Health. If you clinically qualify, your Physician may recommend a follow-up monthly Chronic Care Monitoring Remote Program(CCM).';
      end if;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','DEPRESSION');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('WNK_TITLE','*What you need to know about the Depression a Psychosocial disorder');
    obj2.put('WNK_BODY','The use of meds and/or specific psychotherapeutic techniques has proven very effective in treating Depression. Having the condition for more than a year will transform the Disorder into a Mood Disorder or Major Depressive Disorder(MDD) Frequently goes unrecognized and untreated and may foster tragic consequences, such as suicide and impaired interpersonal relationships at work and at home including a major disease that may impact your wellbeing.');
    obj2.put('WNK_WEB','www.cdc.gov');
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', disease_prev_plan('DEPR',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_psy_depr;
  --
  function ppp_psy_anxt (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_disease_level_code_descr in varchar2,p_disease_severity_code in varchar2,p_dis_severity_short_descr in varchar2) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
  begin
    if p_disease_severity_code = 'RISKA' then --opt A-1 (risk to acquire)
      v_outcome_text := 'Your HRA Outcome finding reflected**'||p_disease_level_code_descr||'**Risk to acquire an Anxiety Disorder.';
      v_ppp_text := 'To cope with your Risk to have a  harmful Anxiety, your physician recommends:';
      v_prev_plan_code := null;
      v_ppp_em_text := 'Referring to your Psychiatric Team Physician that may prescribes Psychotherapy called *Cognitive Behavior Therapy is especially useful for treating severe Anxiety. * It teaches a person different way of thinking, behaving, and reacting to situations that help you to feel less anxious and worried. If the Severe condition has been running for more than 6 months your physician may prescribe some medication that help to adequate the anxiety or may prescribe the latest Medical Grade technology (FDA approved) to cope with the Anxiety symptoms';
    else --disease acquired
      if p_qualify_for_em_followup_flag = 'N' then --opt A-1i (Acquired but not qualify for CCM)
        v_outcome_text := 'Your HRA Outcome finding reflected that you have PMHx of Anxiety Disorder (GAD) without other relevant Chronic condition';
        v_ppp_text := 'To cope with your harmful Anxiety, your Physician recommends:';
        v_prev_plan_code := null;
        v_ppp_em_text := 'Referring to your Psychiatric Team Physician that may prescribes Psychotherapy called *Cognitive Behavior Therapy is especially useful for treating severe Anxiety. * It teaches a person different way of thinking, behaving, and reacting to situations that help you to feel less anxious and worried. If the Severe condition has been running for more than 6 months your physician may prescribe some medication that help to adequate the anxiety or may prescribe the latest Medical Grade technology (FDA approved) to cope with the Anxiety symptoms';
      else --opt A-1ii (CCM patient)
        v_outcome_text := 'Your psychosocial validated clinical test outcome for Anxiety Disorders reflected you are at Mod to Severe PLUS other Disease Risk Factors (2 Plus) and the condition became a harmful GAD.';
        v_ppp_text := 'Your Physician recommends:';
        v_prev_plan_code := null;
        v_ppp_em_text := 'In viewing your HRA Outcome identified serious Disease Risk Factors related with Major Anxiety at Risk an EM Face to Face Assessment is clinically needed to establish an efficient Prevention Program to AVOID or Retard Major Health issues that will seriously impact your Health. If you clinically qualify, your Physician may recommend a follow-up monthly Chronic Care Monitoring Remote Program(CCM).';
      end if;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','ANXIETY');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('WNK_TITLE','What you need to know to identify your Anxiety');
    obj2.put('WNK_BODY','It is characterized by excessive and unrealistic worry about everyday tasks or events, or may be specific to certain objects or rituals. As its name implies, social phobias are fears of interacting with others, particularly in large groups. In obsessive-compulsive disorder (OCD), the individual experiences an obsession - an intrusive and recurrent thought, idea, sensation or feeling - coupled with a compulsion - ');
    obj2.put('WNK_WEB','www.cdc.gov');
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', disease_prev_plan('ANXT',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_psy_anxt;
  --
  function rsp_triggered_stressors (p_patient_prev_svc_sn in number) return json_list
  is
    l_json  json_list;
  begin
    l_json := json_list();
    for i in (select question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'HRSTS'
              )
    loop
      l_json.append(i.question_rpt_descr);
    end loop;
    return l_json;
  end rsp_triggered_stressors;
  --
  function ppp_psy_strs (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_disease_level_code_descr in varchar2,p_disease_severity_code in varchar2,p_dis_severity_short_descr in varchar2) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
  begin
    if p_disease_severity_code = 'RISKA' then --opt A-1 (risk to acquire)
      v_outcome_text := 'Your **'||p_disease_level_code_descr||'** Stress Disorder that can be detrimental for your mental and/or Cardiovascular Health.';
      v_ppp_text := 'In view of your Severe Stress, physician may prescribes adequate medication to be taken during the peak of your stress condition. Your physician recommends:';
      v_prev_plan_code := null;
      v_ppp_em_text := null;
    else --disease acquired
      if p_qualify_for_em_followup_flag = 'N' then --opt A-1i (Acquired but not qualify for CCM)
        v_outcome_text := 'Your HRA Outcome finding reflected that you have PMHx of Stress Disorder without other relevant Chronic condition';
        v_ppp_text := 'In view of your Severe Stress, physician may prescribes adequate medication to be taken during the peak of your stress condition. Your physician recommends:';
        v_prev_plan_code := null;
        v_ppp_em_text := null;
      else --opt A-1ii (CCM patient)
        v_outcome_text := 'Your psychosocial validated clinical test outcome for Stress Disorders reflected you are at Mod to Severe PLUS other Disease Risk Factors (2 Plus) that can be detrimental for your mental and/or Cardiovascular Health.';
        v_ppp_text := 'In view of your Severe Stress, physician may prescribes adequate medication to be taken during the peak of your stress condition. Your physician recommends:';
        v_prev_plan_code := null;
        v_ppp_em_text := 'In viewing your HRA Outcome identified serious Disease Risk Factors related with Stress at Risk an EM Face to Face Assessment is clinically needed to establish an efficient Prevention Program to AVOID or Retard Major Health issues that will seriously impact your Health. If you clinically qualify, your Physician may recommend a follow-up monthly Chronic Care Monitoring Remote Program(CCM).';
      end if;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','STRESS');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('WNK_TITLE','What you need to know to identify a debilitated Stress condition');
    obj2.put('WNK_BODY','Stress is your body''s reaction to the demands of the world. Stressors are events or conditions in your surroundings that may trigger stress. Your body responds to stressors differently depending on whether the stressor is new — acute stress — or whether the stressor has been around for a longer time — chronic stress. Severe acute stress can cause mental health problems, such as post-traumatic stress disorder, and even physical difficulties such as a heart attack and undermine your immune system due to a lack of sleeping or appetite suppression');
    obj2.put('WNK_WEB','www.mayoclinic.org');
    obj2.put('TRIGGERED_TEXT','To help you to understand your condition, please read  following listing of the situations you are going through that are evidenced known triggered stressors:');
    obj2.put('TRIGGERED_TEXT_ADDL','In addition, the System identified some serious Stress related Symptoms (already listed on Symptoms check) and some additional Disease Risk Factors related with your Stress.');
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_TEXT', rsp_triggered_stressors(p_patient_prev_svc_sn));
    obj2.put('PPP', disease_prev_plan('STRS',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_psy_strs;
  --
  function ppp_psy_suic (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_disease_level_code_descr in varchar2,p_disease_severity_code in varchar2,p_dis_severity_short_descr in varchar2) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
  begin
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','SELF HARM AT RISK');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME','In view of your answer to some Self Harm sensitive question of your HRA AWV validated test evidence based medicine proved you may be at **'||p_disease_level_code_descr||'** risk to harm yourself.');
    obj2.put('URGENT','URGENT NEED OF PHYSICIAN FACE TO FACE ENCOUNTER');
    --obj2.put('URGENT_ADDL','Your healthcare professional feels the URGENT need to discuss this sensitive issue immediately with your Healthcare Professional, close family member (spouse sibling or any close family) and you, to discuss further immediate interventions.');
    obj2.put('URGENT_ADDL','It''s recommended you discuss this sensitive issue with your Healthcare Professional specialist or close family member (spouse sibling or any close family). Further interventions should be necessary to cope with the issue.');
    obj.put('label',obj2);
    --=======================
    return obj;
  end ppp_psy_suic;
  --
  function ppp_psy_lonl (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
  begin
    v_outcome_text := 'Our clinically validated test outcome for Loneliness Risk Scale determined you are suffering of Loneliness.';
    v_prev_plan_code := null;
    v_ppp_text := 'To cope with your Loneliness your Physician recommends:';
    v_ppp_em_text := null;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','LONELINESS');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('WNK_TITLE','*What you need to know to identify a Loneliness condition');
    obj2.put('WNK_BODY','Feeling of Loneliness was associated with higher odds of having a mental health problem. Intense loneliness & Social Isolation appeared to raise the risk of death by 26%.');
    obj2.put('WNK_WEB','www.nih.gov');
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', disease_prev_plan('LONL',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_psy_lonl;
  --ppp psychosocial disorder
  function ppp_psy (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PSYCHOSOCIAL EVALUATION OUTCOME');
    for i in (select disease_code,disease_level_code,dis_level_short_descr,disease_severity_code,dis_severity_short_descr
              from svc_result_vw 
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_code in ('ANXT','DEPR','STRS','SUIC','LONL') 
              and disease_level_code <> 'LOW'
              )
    loop
      if i.disease_code = 'DEPR' then
        obj.put('DEPR',ppp_psy_depr (p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,i.dis_level_short_descr,i.disease_severity_code,i.dis_severity_short_descr));
      elsif i.disease_code = 'ANXT' then
        obj.put('ANXT',ppp_psy_anxt (p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,i.dis_level_short_descr,i.disease_severity_code,i.dis_severity_short_descr));
      elsif i.disease_code = 'STRS' then
        obj.put('STRS',ppp_psy_strs (p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,i.dis_level_short_descr,i.disease_severity_code,i.dis_severity_short_descr));
      elsif i.disease_code = 'SUIC' then
        obj.put('SUIC',ppp_psy_suic (p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,i.dis_level_short_descr,i.disease_severity_code,i.dis_severity_short_descr));
      elsif i.disease_code = 'LONL' then
        obj.put('LONL',ppp_psy_lonl (p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
      end if;
    end loop;
    --
    return obj;
  end ppp_psy;
  --
  function neg_health_finding(p_patient_prev_svc_sn in number,p_disease_code in varchar2) return json_list
  is
    l_obj json_list;
  begin
    l_obj := json_list();
    for i in (select case
                      when prv.question_code = '1009' then case when prv.response_code = 'N01' then prv.question_rpt_descr||' (Sit most of the day)' else prv.question_rpt_descr||' (Don''t Sit most of the day)' end
                      else prv.question_rpt_descr
                      end descr                      
              from patient_response_vw prv
                  ,disease_risk_factor_vw drfv
              where prv.risk_factor_code = drfv.risk_factor_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              and prv.category_code = 'BEHVT'
              and drfv.disease_code = p_disease_code
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end neg_health_finding;
  --
  function patient_categ_qtn_response (p_patient_prev_svc_sn in number,p_category_code in varchar2,p_question_code in varchar2) return varchar2
  is
    v_rsp varchar2(3);
    v_patient_sn number(11);
  begin
    if p_category_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
      select patient_sn
      into v_patient_sn
      from patient_prev_svc
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      select response_code
      into v_rsp
      from patient_history_vw 
      where patient_sn = v_patient_sn 
      and category_code = p_category_code 
      and question_code = p_question_code
      ;
    else
      select response_code
      into v_rsp
      from patient_response_vw 
      where patient_prev_svc_sn = p_patient_prev_svc_sn 
      and category_code = p_category_code 
      and question_code = p_question_code
      ;
    end if;
    return v_rsp;
  exception
    when others then 
      --raise_application_error(-20011,sqlerrm);
      return null;
  end patient_categ_qtn_response;
  --
  function patient_disease_level_code (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_disease_level_code varchar2(3);
  begin
    select disease_level_code
    into v_disease_level_code
    from svc_result_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code = p_disease_code
    ;
    return v_disease_level_code;
  exception
    when others then 
      raise_application_error(-20012,sqlerrm);
  end patient_disease_level_code;  
  --
  function patient_disease_severity (p_patient_prev_svc_sn in number,p_disease_code in varchar2) return varchar2
  is
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
  begin
    select disease_severity_code
    into v_disease_severity_code
    from svc_result_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code = p_disease_code
    ;
    return v_disease_severity_code;
  exception
    when others then 
      raise_application_error(-20013,sqlerrm);
  end patient_disease_severity;
  --
  function ppp_behav_bp (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_sys in number,p_dia in number) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_rsp varchar2(3);
    v_bp_reading varchar2(30);
    v_disease_level_code varchar2(3);
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
  begin
    v_rsp := patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1002');
    v_bp_reading := common_pkg.bp_reading(p_sys,p_dia);
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'HBPR');
    v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'HBPR');
    --
    v_prev_plan_code := null;
    v_ppp_em_text := null;
    v_ppp_ccm_text := null;
    v_neg_health_finding_text := null;
    v_outcome_text := 'BP reading '||p_sys||'/'||p_dia||'. Your BP reading is '||v_bp_reading||'.';
    v_ppp_text := 'To prevent your Blood Pressure goes out of control your Physician recommend the following Prevention Plan:';
    v_911_text := null;
    v_ccm_log_text := null;
    --
    if v_bp_reading <> 'Hypertension' then
      if v_rsp = 'Y03' then --Yes, take medication and under control
        if p_chronic_disease_cnt = 0 or v_disease_level_code = 'MOD' then 
          v_outcome_text := 'BP reading '||p_sys||'/'||p_dia||'. HBP Controlled on med or Life Style. No significant PMHx or Disease RF.';
        else
          v_outcome_text := 'BP reading '||p_sys||'/'||p_dia||'. HBP Controlled on med or Life Style.';          
        end if;
      end if;
    else --Hypertension
      if v_rsp in ('Y04','Y05') then --Yes, take medication but NOT under control , Yes, but DOES NOT take medication
        v_outcome_text := 'BP reading '||p_sys||'/'||p_dia||'. Your BP reading is '||v_bp_reading||'. In addition, your Blood Pressure level has been reported consistently HIGH or uncontrolled';
      end if;
    end if;
    --
    if v_disease_level_code in ('HIG','SEV','ESV') then
      v_neg_health_finding_text := 'BP related negative Health finding of your HRA Outcome that concern your Physician as (listed):';      
    end if;
    --
    if v_disease_severity_code <> 'RISKA' and p_qualify_for_em_followup_flag = 'Y' then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish a Preventive Plan of Care aimed to control the HBP and establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. To Help to maintain normal level of BP for Better Health your Physician may recommend some lab and other necessary analysis & Test to Help maintain normal BP levels for Better Health. Dr may  set you up into an ABPM 24 hours monitoring, results, will be carefully  analyzed and  new med may be prescribed accordingly aimed to cope with your uncontrolled  Blood Pressure.';
      v_ppp_ccm_text := 'At Physician discretion, and with your previous consent, you may qualify for a Chronic Care Management CCM monthly monitoring program to timely collect all progresses and/or regression data of your condition, to prevent any major issue that seriously may impact your Health.';
      v_ccm_log_text := 'If you are participating into the CCM program timely report all logs and event to your healthcare CCM monitoring professional for an immediate intervention if is necessary.';
    end if;
    --
    if v_rsp in ('Y04','Y03') or v_disease_severity_code <> 'RISKA' then
      v_911_text := 'In the event you noticed any change of your Blood Pressure level or any undesirable med side effects, notify your Physician as soon as possible.';
    else --NOO, IDK and Y05 (not talking medication and exclude medication related pp)
      v_prev_plan_code := '7105';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','BLOOD PRESSURE HEALTH RISK FACTOR');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('NEG_HEALTH_FINDING',v_neg_health_finding_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP_CCM_TEXT',v_ppp_ccm_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj2.put('PPP_CCM_LOG_TEXT',v_ccm_log_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if v_neg_health_finding_text is not null then
      obj2.put('NEG_HEALTH_FINDING', neg_health_finding(p_patient_prev_svc_sn,'HBPR'));
    end if;
    obj2.put('PPP', disease_prev_plan('HBPR',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_bp;
  --
  function ppp_behav_bs (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_sugar in number) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_rsp varchar2(3);
    v_disease_level_code varchar2(3);
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
  begin
    v_rsp := patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1003');
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'DIAB');
    v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'DIAB');
    --
    v_prev_plan_code := null;
    v_ppp_em_text := null;
    v_ppp_ccm_text := null;
    v_neg_health_finding_text := null;
    v_outcome_text := null;
    v_ppp_text := 'To prevent your Blood Sugar goes out of control your Physician recommend the following Prevention Plan:';
    v_911_text := null;
    v_ccm_log_text := null;
    --
    if v_rsp = 'Y03' then
      v_outcome_text := 'You reported Blood Sugar controlled on med or Life Style.';
    elsif v_rsp = 'Y04' then
      v_outcome_text := 'You reported Blood Sugar is NOT in controll on med.';
    elsif v_rsp = 'Y05' then
      v_outcome_text := 'You reported you have Blood Sugar but NOT talking medication.';
    end if;
    if p_qualify_for_em_followup_flag = 'N' then
      if p_chronic_disease_cnt = 0 then 
        v_outcome_text := v_outcome_text||' No significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
      else
        v_outcome_text := v_outcome_text||' Some significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
      end if;
    else
      v_outcome_text := v_outcome_text||' Significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
    end if;
    --
    if v_disease_level_code in ('HIG','SEV','ESV') then
      v_neg_health_finding_text := 'BS related negative Health finding of your HRA Outcome that concern your Physician as (listed):';
    end if;
    --
    if v_disease_severity_code <> 'RISKA' and p_qualify_for_em_followup_flag = 'Y' then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish: 1- a Preventive Plan of Care aimed to control the BP & High Blood Sugar. 2-establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation.3- To Help to maintain normal level of Blood Sugar for Better Health your Physician may recommend some lab and other necessary analysis & Test to maintain normal BS levels for Better Health. 4- In the event your BP is higher than 135/80 Dr may set you up into an ABPM 24 hour monitoring, results, will be carefully analyzed and new med may be prescribed accordingly aimed to cope with your Blood Pressure and uncontrolled Blood Sugar.';
      v_ppp_ccm_text := 'At Physician discretion, and with your previous consent, you may qualify for a Chronic Care Management CCM monthly monitoring program to timely collect all progresses and/or regression data of your condition, to prevent any major issue that seriously may impact your Health.';
      v_ccm_log_text := 'If you are participating into the CCM program timely report all logs and event to your healthcare CCM monitoring professional for an immediate intervention if is necessary.';
    end if;
    --
    if v_rsp in ('Y04','Y03') or v_disease_severity_code <> 'RISKA' then
      v_911_text := 'In the event you feel weak, dizzy and confuse after your Blood sugar med was taken, call 911 immediately you may be having a danger Hypoglycemia event.';
    else --NOO, IDK and Y05 (not talking medication and exclude medication related pp)
      v_prev_plan_code := '7206';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','BLOOD SUGAR HEALTH RISK FACTOR');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('NEG_HEALTH_FINDING',v_neg_health_finding_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP_CCM_TEXT',v_ppp_ccm_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj2.put('PPP_CCM_LOG_TEXT',v_ccm_log_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if v_neg_health_finding_text is not null then
      obj2.put('NEG_HEALTH_FINDING', neg_health_finding(p_patient_prev_svc_sn,'DIAB'));
    end if;
    obj2.put('PPP', disease_prev_plan('DIAB',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_bs;
  --
  function ppp_behav_hcho (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_rsp varchar2(3);
    v_disease_level_code varchar2(3);
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
  begin
    v_rsp := patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1004');
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'HCHO');
    v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'HCHO');
    --
    v_prev_plan_code := null;
    v_screening_reco_text := 'U.S Preventive Services Task Force (A) strongly recommends Lipid Panel screening 1.Men aged 35 and older, 2.Women aged 45 and older for Lipid disorders if they are at increased risk for coronary heart disease” eating fatty foods raises your bad Cholesterol level (LDL). Elevated LDL clog up your arteries making difficult for your heart to do its job and potentially lead your health to Heart Disease.';
    v_ppp_em_text := null;
    v_other_reco_text := null;
    v_neg_health_finding_text := null;
    v_outcome_text := null;
    v_ppp_text := 'For better health, your Physician recommend the following Prevention Plan:';
    v_911_text := null;
    v_ccm_log_text := null;
    --
    if v_rsp = 'Y03' then
      v_outcome_text := 'You reported  suffer from High Chol  but controlled on med or Life Style';
    elsif v_rsp = 'Y04' then
      v_outcome_text := 'You reported  suffer from High Chol  but NOT in controll on med or Life Style';
    elsif v_rsp = 'Y05' then
      v_outcome_text := 'You reported  suffer from High Chol but NOT talking medication.';
    end if;
    if p_qualify_for_em_followup_flag = 'N' then
      if p_chronic_disease_cnt = 0 then 
        v_outcome_text := v_outcome_text||' No significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
      else
        v_outcome_text := v_outcome_text||' Some significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
      end if;
    else
      v_outcome_text := v_outcome_text||' Significant PMHx or Disease RF are found in your evidence base HRA Outcome.';
    end if;
    --
    if v_disease_level_code in ('HIG','SEV','ESV') then
      v_neg_health_finding_text := 'High Chol related negative Health finding of your HRA Outcome that concern your Physician as (listed):';
    end if;
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-establish a Preventive Plan of Care aimed to control the High LDL. 2- establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. 3-Help to maintain normal level of Lipid level 4-Physician may recommend some lab and other necessary analysis & Test to maintain normal LDL level for Better Health. In the event your BP is higher than 135/80 Dr may set you up into an ABPM 24 hours monitoring, results, will be carefully analyzed and new med may be prescribed accordingly aimed to cope with your HBP and relationship with your High LDL as a major Disease RF.';
      v_ccm_log_text := 'If you are participating into the CCM program timely report all logs and event to your healthcare CCM monitoring professional for an immediate intervention if is necessary.';
    end if;
    --
    if v_rsp in ('Y04','Y03') or v_disease_severity_code <> 'RISKA' then
      v_911_text := 'In the event you noticed any undesirable side effects from your prescribed Cholesterol meds notify your Physician as soon as possible.';
    else --NOO, IDK and Y05 (not talking medication and exclude medication related pp)
      v_prev_plan_code := '7306';
    end if;
    --
    if common_inq_pkg.disease_categ_aqurd_riska_flag(p_patient_prev_svc_sn,'CVDE') = 'Y' then
      v_other_reco_text := 'To prevent your controlled LDL goes out of normal range, keep you Weight & Blood Pressure and Blood Sugar (CVD RISK FACTORS are evidenced proved related) under control.  (all associated with Cardiovascular Disease and Arteriosclerosis).To help to control your LDL in preventing an increased Risk to have a CVD harm affect your Health your Physician may prescribe IBT (Intensive Behavioral Therapy for CVD) if was not done during the last 12 months.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','HIGH CHOLESTEROL HEALTH RISK FACTOR');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('SCREENING_RECO_TEXT',v_screening_reco_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('NEG_HEALTH_FINDING',v_neg_health_finding_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('OTHER_RECO_TEXT',v_other_reco_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj2.put('PPP_CCM_LOG_TEXT',v_ccm_log_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if v_neg_health_finding_text is not null then
      obj2.put('NEG_HEALTH_FINDING', neg_health_finding(p_patient_prev_svc_sn,'HCHO'));
    end if;
    obj2.put('PPP', disease_prev_plan('HCHO',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_hcho;
  --
  function ppp_behav_obes (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_bmi in number,p_bmi_result in varchar2) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
  begin
    v_prev_plan_code := null;
    v_title := upper(p_bmi_result)||' HEALTH RISK FACTOR';
    --
    v_outcome_text := null;
    v_other_outcome_text := null;
    v_neg_health_finding_text := null;
    v_ppp_em_text := null;
    v_ppp_ccm_text := null;
    v_ppp_text := 'For better health, your Physician recommend the following Prevention Plan:';
    --
    if p_bmi_result = 'Underweight' then
      v_outcome_text := 'Your BMI '||p_bmi||' indicated you are **Underweight**.';
      v_other_outcome_text := 'In view your BMI today, your Healthcare Professional want you become aware what your Risks of a low body weight without a known cause, pose your Health in an out numbers of serious Medical conditions as  Anemia & Nutrient Deficiencies, Osteoporosis, Heart irregularities, Blood Vessel Disease, Prone to Infections & disease, delayed wound healing among others serious conditions.';
    elsif p_bmi_result = 'Overweight' then
      v_outcome_text := 'Your BMI '||p_bmi||' indicated you are **Overweight**.';
      if p_qualify_for_em_followup_flag = 'N' then
        v_other_outcome_text := 'Your PMHX and HRA outcome does not show any additional disease related Risk Factors that may influence a major Health issue. Regardless your Healthcare Professional recommend reviewing your eating habits and Life style to improve a healthier weight to prevent a harmful obesity.';
      else --Y
        v_other_outcome_text := 'Your PMHX and HRA outcome does show additional serious Disease Related Risk Factors as You are at Higher Risk to get exacerbated a Major Disease';
        v_neg_health_finding_text := 'Your PMHX & HRA Outcome found other important disease related Risk Factors with your Overweight as stated in your HRA outcome Report of finding.';
        v_ppp_em_text := 'In view of the afore mentioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to control your weight 2-  establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. 3- Help preventing gaining more weight your Physician may recommend some lab and other necessary analysis & Test to maintain your ideal weight levels for Better Health 4- perform closely review all Disease at Risk causes for an adequate Preventive Plan and Plan of Care.';
        v_ppp_ccm_text := 'At the Physician''s clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a better control of your Health.';
      end if;
    else --Obesity
      v_outcome_text := 'Your BMI '||p_bmi||' indicated you are **Obese**.';
      if p_qualify_for_em_followup_flag = 'N' then
        v_other_outcome_text := 'Your PMHX & HRA Outcome did not found other important disease related Risk Factors with your Obesity. Your Healthcare Professional is referring you to an Intensive Behavioral Therapy (IBT) Weight Loss Counseling Program aimed to help you to lose weight free of charge as recommended by Medicare.';
      else --Y
        v_other_outcome_text := 'Your PMHX & HRA Outcome found other important disease related Risk Factors with your Obesity as stated in your HRA outcome Report of finding.';
        v_ppp_em_text := 'In view of the afore mentioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to control your weight 2-  establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. 3- Help preventing gaining more weight your Physician may recommend some lab and other necessary analysis & Test to maintain your ideal weight levels for Better Health 4- perform closely review all Disease at Risk causes for an adequate Preventive Plan and Plan of Care.';
        v_ppp_ccm_text := 'At the Physician''s clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a better control of your Health.';
      end if;
    end if;
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('OTHER_OUTCOME',v_other_outcome_text);
    obj2.put('NEG_HEALTH_FINDING',v_neg_health_finding_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP_CCM_TEXT',v_ppp_ccm_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if v_neg_health_finding_text is not null then
      obj2.put('NEG_HEALTH_FINDING', neg_health_finding(p_patient_prev_svc_sn,'OBES'));
    end if;
    obj2.put('PPP', disease_prev_plan('OBES',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_obes;
  --
  function ppp_behav_tbco (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_rsp varchar2(3);
  begin
    v_rsp := patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1005');
    v_prev_plan_code := null;
    v_title := 'SMOKING HEALTH RISK FACTOR';
    v_other_outcome_text := 'Your Physician understand that dealing with smoking dependency is a difficult task, especially on heavy smokers that eventually in most of the time it is not a lung cancer  will acquire a COPD ,the third leading cause of dead in the US and most of the time the cause of a disability. In viewing to the harm this behavioral dependency will strike the Health and wellbeing as a first step Physician prescribed a lung low dose computerized tomography(CT)yearly(uspstf) for those smokers and one CT every 2 years with those with Smoking Hx (15 yrs. or less). (Cancer Early detection through a low dose of CT screening procedure will save the life of 20% of the eventual newly diagnosed lung Cancer).';
    v_ppp_em_text := null;
    v_ppp_ccm_text := null;
    v_ppp_text := 'To cope with your dependency your Physician recommend the following Prevention Plan:';
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish a Preventive Plan of Care aimed to control smoking dependency and establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. To Help preventing gaining more harm to your health and for Better Health your Physician may recommend some lab and other necessary analysis & Test to Help in maintaining an effective control of the habit and perform closely review all Disease at Risk for an adequate Preventive Plan and Plan of Care.';
      v_ppp_ccm_text := null; --future placeholder    
    else
      if v_rsp = 'Y08' then
        v_ppp_ccm_text := 'Congratulation for your big effort of quit smoking.';
      end if;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OTHER_OUTCOME',v_other_outcome_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP_CCM_TEXT',v_ppp_ccm_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if v_rsp = 'Y08' then      
      obj2.put('PPP', tbco_quit_prev_plan);
    else
      obj2.put('PPP', risk_factor_prev_plan('TBCO',v_prev_plan_code));
    end if;
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_tbco;
  --
  function ppp_behav_alco (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
  begin
    v_prev_plan_code := null;
    v_title := 'ALCOHOL ABUSE HEALTH RISK FACTOR';
    v_outcome_text := null;
    v_other_outcome_text := 'Many of the acute and chronic medical and psychiatric diseases are influenced by lifestyle choices and behaviors, such as the consumption of alcohol and the use of psychoactive prescription medications. www.ncoa.org Drinking problems and psychoactive medication misuse are by far the largest types of substance use problems seen in older adults today.www.shasha.org';
    v_ppp_em_text := null;
    v_ppp_ccm_text := null;
    v_ppp_text := 'To cope with your dependency your Physician recommend the following Prevention Plan:';
    v_other_reco_text := 'As soon d/c from alcohol treatment & become clean, to maintain your sobriety & strength we recommend to daily attend an Alcohol support community organization like AA (Alcoholic Anonymous) or some other support groups into your community.';
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_outcome_text := null; --future placeholder
      v_ppp_em_text := 'In view of the afore mentioned clinical reasons a Face to Face Physician Assessment is medically needed to 1- establish a Preventive Plan of Care aimed to help  prevent a serious harming effect to your health,  due to your drinking habits  2- establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk. 3-  Your Physician may recommend some lab and other necessary analysis & Test 4- Help in maintaining an effective control of the behavioral and perform closely review all Disease at Risk for an adequate Preventive Plan and Plan of Care.';
      v_ppp_ccm_text := null; --future placeholder
    else
      v_outcome_text := null; --future placeholder
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('OTHER_OUTCOME',v_other_outcome_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP_CCM_TEXT',v_ppp_ccm_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('OTHER_RECO_TEXT',v_other_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', risk_factor_prev_plan('ALCO',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_alco;
  --
  function ppp_behav_inac (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_benefit_text varchar2(1000);
    v_ref_title varchar2(30);
    v_ref_1 varchar2(300);
    v_ref_2 varchar2(300);
    v_ref_3 varchar2(300);
  begin
    v_prev_plan_code := null;
    v_title := 'LACK OF ACTIVITIES HEALTH RISK FACTOR';
    v_general_text := 'A sedentary lifestyle over several years is associated with increased risk for type 2 diabetes, cardiovascular disease, and premature mortality. ... Lack of exercise is a major cause of chronic diseases.cdc.gov More than a third over age 65 years old in U.S. with no leisure-time Physical Activity. Sedentary status is also associated with Disability and with increased mortality.';
    v_outcome_text := null;
    v_ppp_em_text := null;
    v_ppp_text := 'Your Physician recommend the following Prevention Plan:';
    v_benefit_text := 'In the event  Physician found on the HRA Outcome any  ADL restrictions  or in your mobility, may prescribe a Physical and or Occupational Rehab. Skilled services to avoid a major Health event. Following overall benefits as evidenced stated will bring to your health been ACTIVE:';
    v_ref_title := 'References:';
    v_ref_1 := 'Benefits realized even if Exercise started at late age Glass  BMJ 319:478-83 [PubMed]';
    v_ref_2 := 'Life Expectancy increases even at age 75 years Paffenbarger N Engl J Med 314:605-13 [PubMed]';
    v_ref_3 := 'Measurement of max amount of O2 that an individual can utilize during intense exercise”VO2” max decline reversed up to 30% at 6 months  Med Sci Sports Exerc 30:992-1008 [PubMed]';
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_outcome_text := 'No exercising is reported, in addition the evidenced HRA Outcome found severe related Disease Risk Factors due to sedentary life that is seriously harming the Health at Risk to an eventual Disability Risk, that will increase with aging.';
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to help prevent a serious harming effect to your health, due to lack of activity (a major cause of Chronic Diseases www.cdc.gov) 2-  establish an appropriate Prevention measurement to avoid or retard all severe Health issues at Risk of exacerbation. 3- Your Physician may recommend some lab and other necessary analysis & Test to Help in maintaining an effective control of the Disease(s) at Risk caused by the behavioral 4- perform closely clinical review all Disease at Risk for an adequate Preventive Plan and Plan of Care.';
    else
      v_prev_plan_code := '7712';
      v_outcome_text := 'No exercise is reported, in addition the evidenced HRA Outcome did not found important Disease related with the Lack of Activities, starting been active it’s never too late. Sedentary status is also associated with Disability and with increased mortality.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('BENEFIT_TEXT',v_benefit_text);
    obj2.put('REF_TITLE',v_ref_title);
    obj2.put('REF_1',v_ref_1);
    obj2.put('REF_2',v_ref_2);
    obj2.put('REF_3',v_ref_3);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', risk_factor_prev_plan('INAC',v_prev_plan_code));
    l_obj := json_list();
    l_obj.append('Fall Prevention and reduced Hip Fracture');
    l_obj.append('Improved sleep quality');
    l_obj.append('Impacts functional independence');
    l_obj.append('Fitness Activity reduces mortality 19%');
    l_obj.append('Protects against the development of Dementia');
    l_obj.append('Productive Activity reduces mortality 35%');
    --
    obj2.put('BENEFIT_TEXT', l_obj);
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_inac;
  --
  function ppp_behav_diet (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_age in number) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_benefit_text varchar2(1000);
    v_sugary_drink_text varchar2(1000);
    v_fast_food_text varchar2(1000);
    v_sugary_food_text varchar2(1000);
    v_high_salt_food_text varchar2(1000);
    v_fruit_veg_text varchar2(1000);
    --
    v_rsp_sugary_drink varchar2(3);
    v_rsp_fast_food varchar2(3);
    v_rsp_sugary_food varchar2(3);
    v_rsp_salt_food varchar2(3);
    v_rsp_fruit varchar2(3);
    v_rsp_veg varchar2(3);
    v_rsp_grain varchar2(3);
    v_cnt pls_integer := 0;
    v_LIVING_STATUS_CODE varchar2(4);
  begin
    for i in (select question_code,response_code
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'BEHVT'
              and question_code in ('1010','1011','1012','1013','1014','1015','1016')
              )
    loop
      if i.question_code = '1010' then v_rsp_sugary_drink := i.response_code;
      elsif i.question_code = '1011' then v_rsp_fast_food := i.response_code;
      elsif i.question_code = '1012' then v_rsp_sugary_food := i.response_code;
      elsif i.question_code = '1013' then v_rsp_salt_food := i.response_code;
      elsif i.question_code = '1014' then v_rsp_fruit := i.response_code;
      elsif i.question_code = '1015' then v_rsp_veg := i.response_code;
      elsif i.question_code = '1016' then v_rsp_grain := i.response_code;
      end if;
    end loop;
    --
    v_prev_plan_code := null;
    v_title := 'POOR NUTRITION HABITS HEALTH RISK FACTOR';
    v_sugary_drink_text := null;
    v_fast_food_text := null;
    v_sugary_food_text := null;
    v_high_salt_food_text := null;
    v_fruit_veg_text := null;
    v_ppp_em_text := null;
    v_ppp_text := 'Physician recommend for the prevention to acquire major Disease  and for a Better Health:';
    v_911_text := null;
    v_other_reco_text := null;
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_outcome_text := 'You have been identified to consume drinks or food or not having fruit/veg causing negative effect on your health.';
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to help avoid a serious harming effect to your health due to the accumulation of wrong nutritional behaviors 2-  establish an appropriate Prevention measurement to avoid or retard all severe related  Disease(s) at Risk of exacerbation. 3- Your Physician may recommend some lab and other necessary analysis & Test to Help in maintaining an effective control of the Disease(s) at Risk caused by the behavioral 4- perform closely clinical review all Disease(s) at Risk for an adequate Preventive Plan and Plan of Care.';
      v_other_reco_text := 'Physician will closely review all related Diseases at Risk of an exacerbation due to harmful behaviors on his comprehensive Preventive Plan of Care.';
    else
      v_outcome_text := 'You have been identified to consume drinks or food or not having fruit/veg causing negative effect on your health. In addition the evidenced HRA Outcome found important serious chronic Disease(s) at Risk and other related harmful behavioral (likes accumulation of other wrong nutrition habits).';
    end if;
    --
    if v_rsp_sugary_drink = 'YES' then --sodas/drinks
      v_sugary_drink_text := 'Frequently Drinking sodas or sugary drinks reported. There are evidences that sugary drinks increase the risk of type 2 diabetes, obesity, heart disease, and other chronic conditions including an Osteoporosis *link *Nutritional Scientifics believe that this link is probably because the trend to substitute the soda to essential consumption of healthy calcium content drink and natural water. Older adults who consume sugary drinks regularly—1 to 2 cans a day or more—have a 26% greater risk of developing type 2 diabetes than people who rarely have such drinks as well to rapidly gaining harmful weight. Am J Clinic Nutritional.';
      v_cnt := v_cnt + 1;
    end if;
    if v_rsp_fast_food = 'YES' then --fast food
      v_fast_food_text := 'Frequently eating fast food reported. Systematic review and cohort of Six studies (991-9951 adults) found a significant association between fast food intake and higher weight in adults, and more than one fast food meal consumed per week was associated with increases in BMI and Obesity.';
      v_cnt := v_cnt + 1;
    end if;
    if v_rsp_sugary_food = 'YES' then --sugar content food
      v_sugary_food_text := 'Frequently consuming added sugar or high sugar content food reported. There are evidences that high sugar content food consumption increased the risk of type 2 diabetes, obesity, heart disease, and other chronic conditions. Studies have shown that over the past four decades, consumption of food eaten away from home has also risen alarmingly (represent 11 % of the US food intake. cdc.gov). It is well known that eating out may lead to excess calorie intake and increases the risk of obesity because of large portion sizes and increased energy density of foods.';
      v_cnt := v_cnt + 1;
    end if;
    if v_rsp_salt_food = 'YES' then --salt content food
      v_high_salt_food_text := 'Frequently consuming excess of table salt or high salt content food reported. There are evidences that high salt content food consumption increased the risk of High Blood Pressure, obesity, heart disease, and other chronic conditions. Junk food can not only damage your body but it also affects the brain.. Scientists are still gathering data on the link between health risks and fast food consumption, but they have found eating it regularly ups the risk of various chronic conditions prevalently Obesity, HBP, High Chol and Cardiovascular Risk and latest studies linked with Depression.';
      v_cnt := v_cnt + 1;
    end if;
    if (v_rsp_fruit = 'NOO' and v_rsp_veg = 'NOO') or (v_rsp_fruit = 'NOO' and v_rsp_grain = 'NOO') or (v_rsp_veg = 'NOO' and v_rsp_grain = 'NOO') then
      v_fruit_veg_text := 'Does not eat a balanced diet (Fruits, Veggies and Grains). There are evidences that diet rich in fruits and vegetables along with grains may reduce the risk of some types of cancer and other chronic diseases and help to lose the unwanted weight.';
      v_cnt := v_cnt + 1;
    end if;
    --
    select LIVING_STATUS_CODE
    into v_LIVING_STATUS_CODE
    from patient_prev_svc 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if v_LIVING_STATUS_CODE = 'ALON' and (p_age >= 80 or common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FRLT') = 'Y') and v_cnt >= 3 then
      v_911_text := 'Unable to follow a healthful diet, Physician may refer to a Health Nutritionist Professional for a consultation & coaching.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('SUGARY_DRINK_TEXT',v_sugary_drink_text);
    obj2.put('FAST_FOOD_TEXT',v_fast_food_text);
    obj2.put('SUGARY_FOOD_TEXT',v_sugary_food_text);
    obj2.put('HIGH_SALT_FOOD_TEXT',v_high_salt_food_text);
    obj2.put('FRUIT_VEG_TEXT',v_fruit_veg_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj2.put('OTHER_RECO_TEXT',v_other_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', risk_factor_prev_plan('DIET',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_diet;
  --
  function ppp_behav_watr (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_benefit_text varchar2(1000);
    --
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'CKDE');
    v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'CKDE');
    --
    v_prev_plan_code := null;
    v_title := 'POOR DRINKING WATER HEALTH RISK FACTOR';
    v_outcome_text := 'Indicated drinking less than 6 glasses of water or any Healthy fluids per day.';
    v_general_text := 'Water represents a critical nutrient whose absence will be lethal within days. Water comprises from 75% body weight in infants to 55% in elderly and is essential for cellular homeostasis and life (ncbi.gov). The US Dietary Recommendations for water are based on median water intakes with no use of measurements of dehydration status of the population to assist. Because of their low water reserves, Physician recommend for the elderly to learn to drink regularly when not thirsty and to moderately increase their salt intake when they sweat.';
    v_warning_text := 'Better education of water consumption may help prevent sudden Hypotension and Stroke or abnormal Fatigue can lead to a vicious circle and eventually hospitalization.';
    v_ppp_em_text := null;
    v_ppp_text := 'Physician recommend:';
    v_911_text := 'In the event of a Diarrhea, there is an urgent to increase the water intake with extra electrolyte added otherwise you may suffer of a dehydration with harmful consequences to your Health. If Diarrhea persist for more than 2 days call your physician immediately.';
    --
    if v_disease_severity_code <> 'RISKA' or (v_disease_severity_code = 'RISKA' and v_disease_level_code = 'SEV') then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to help avoid a serious harming effect to your health due to the accumulation of wrong nutritional behaviors (lack of water plus) 2-  establish an appropriate Prevention measurement to avoid or retard all severe related Disease(s) at Risk of exacerbation. 3- Your Physician may recommend some lab and other necessary analysis & Test to Help in maintaining an effective control of the Disease(s) at Risk caused by the behavioral 4-perform closely clinical review all Disease(s) at Risk for an adequate Preventive Plan and Plan of Care.';  
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('WARNING_TEXT',v_warning_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', risk_factor_prev_plan('WATR',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_watr;
  --
  function ppp_behav_sfty (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    v_title       varchar2(100);
    v_outcome_text varchar2(1000);
    v_911_text varchar2(1000);
  begin
    v_title := 'SEAT BELT LACK OF COMPLIANCE';
    v_outcome_text := 'You indicated do not use a seatbelt while riding an automobile.';
    v_911_text := 'It''s the Law "Buckle on" otherwise may cost a $ 250 ticket or even an injury or dead in the event of a car accident occurs.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('PPP_911_TEXT',v_911_text);
    obj.put('label',obj2);
    --=======================
    return obj;
  end ppp_behav_sfty;
  --
  function ppp_behav_slep (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_benefit_text varchar2(1000);
    v_sleep_apnia_flag varchar2(1);
    v_poor_sleep_flag varchar2(1);
    v_cvd_flag varchar2(1);
  begin
    v_sleep_apnia_flag := common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1021','CBX');
    v_poor_sleep_flag := common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','SLEP');
    v_cvd_flag := common_inq_pkg.disease_categ_aqurd_riska_flag(p_patient_prev_svc_sn,'CVDE');
    --
    v_prev_plan_code := null;
    v_title := 'LACK OF SLEEP COMPLIANCE';
    v_outcome_text := null;
    v_general_text := 'It is Common condition for Seniors to have sleep deprivation that is just as debilitating, if not as complex. The likelihood of sleep apnea and restless leg syndrome also increases with age. Frequent urination and the pain from arthritis are more common too, and rob sleep from seniors.';
    v_warning_text := 'The National Sleep Foundation has reported that 24 percent of people aged 65-84 have been diagnosed with four or more medical conditions. In general, people with poor health or chronic medical conditions have more sleep problems.';
    v_ppp_em_text := null;
    v_ppp_text := 'Physician recommend:';
    v_ppp_learn_text := 'Learn about Common health conditions that can disrupt sleep in older adults:';
    v_ppp_reco_text := 'For a better sleep night, your Physician recommend twelve steps:';
    --
    if v_sleep_apnia_flag = 'Y' and v_poor_sleep_flag = 'Y' then
      v_outcome_text := 'You reported has a poor sleeping pattern and or sleep less than 6 hours every night. In addition you reported suffer from Sleep Apnea or Resting Leg Syndrome.';
    elsif v_sleep_apnia_flag = 'Y' and v_poor_sleep_flag = 'N' then
      v_outcome_text := 'You reported suffer from Sleep Apnea or Resting Leg Syndrome.';
    elsif v_sleep_apnia_flag = 'N' and v_poor_sleep_flag = 'Y' then
      v_outcome_text := 'You reported has a poor sleeping pattern and or sleep less than 6 hours every night.';
    end if;
    --
    if p_qualify_for_em_followup_flag = 'N' then
      v_outcome_text := v_outcome_text||' There are no other related Disease RF at the HRA clinical Outcome';
    else
      v_outcome_text := v_outcome_text||' There are other related Disease RF at the HRA clinical Outcome';
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to 1-  establish a Preventive Plan of Care aimed to help avoid a serious harming effect to your health due to the accumulation of a lack of Sleep and other severe Disease RF & wrong behaviors 2-  establish an appropriate Prevention measurement to avoid or retard all severe related Disease(s) at Risk of exacerbation. 3- Physician may recommend some lab and other necessary analysis & Test to Help in maintaining an effective control of the Disease(s) at Risk caused by the behavioral 4-perform closely clinical review all Disease(s) at Risk for an adequate Preventive Plan and Plan of Care.';
    end if;
    --
    if v_sleep_apnia_flag = 'N' and v_cvd_flag = 'Y' then
      v_ppp_em_text := v_ppp_em_text||' 5- After some clinical considerations for an evaluation and proper diagnosis, Physician may refer to a Sleep Disorder and a Cardiologist Physician.';
    elsif v_sleep_apnia_flag = 'Y' and v_cvd_flag = 'Y' then
      v_ppp_em_text := v_ppp_em_text||' 5- After some clinical considerations for an evaluation and proper diagnosis, Physician may refer to a Cardiologist Physician.';
    elsif v_sleep_apnia_flag = 'N' and v_cvd_flag = 'N' then
      v_ppp_em_text := v_ppp_em_text||' 5- After some clinical considerations for an evaluation and proper diagnosis, Physician may refer to a Sleep Disorder Physician.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('WARNING_TEXT',v_warning_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('PPP_LEARN_TEXT',v_ppp_learn_text);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    --learning 
    l_obj := json_list();
    l_obj.append('Heart and lung conditions which affect breathing, such as heart failure and chronic obstructive pulmonary disease');
    l_obj.append('Gastroesophageal reflux disease, which causes heartburn symptoms and can be affected by big meals late at night');
    l_obj.append('Painful conditions, including osteoarthritis');
    l_obj.append('Urinary problems that cause urination at night; this can be caused by an enlarged prostate or an overactive bladder');
    l_obj.append('Mood problems such as depression and anxiety');
    l_obj.append('Neurodegenerative disorders such as Alzheimer’s and Parkinson’s');
    l_obj.append('Medication side-effects');
    l_obj.append('Sleep Disorders');
    obj2.put('PPP_LEARN_TEXT', l_obj);
    --
    obj2.put('PPP_RECO_TEXT', risk_factor_prev_plan('SLEP',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_behav_slep;
  --ppp behavioral risk factor
  function ppp_behav (p_patient_prev_svc_sn in number,p_bmi in number,p_bmi_result in varchar2,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_sys in number,p_dia in number,p_sugar in number,p_age in number) return json
  is
    obj         json;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','BEHAVIORAL HRA TEST OUTCOME');
    obj.put('SUB_TITLE1','Evidence Medicine proved that wrong behavior has been identified as one of the main Risk Factors to  acquire or exacerbate major Medical conditions and/or have significant  Health events as: frequent Hospitalizations,  falls, stroke, Disabilities  even premature death.');
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HBPR') = 'Y' then
      obj.put('HBP',ppp_behav_bp(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,p_sys,p_dia));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DIAB') = 'Y' then
      obj.put('HBS',ppp_behav_bs(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,p_sugar));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HCHO') = 'Y' then
      obj.put('HCHO',ppp_behav_hcho(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if p_bmi_result <> 'Normal weight' then
      obj.put('OBES',ppp_behav_obes(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,p_bmi,p_bmi_result));
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','TBCO') = 'Y' then
      obj.put('TBCO',ppp_behav_tbco(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','ALCO') = 'Y' then
      obj.put('ALCO',ppp_behav_alco(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','INAC') = 'Y' then
      obj.put('INAC',ppp_behav_inac(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.diet_rf_flag(p_patient_prev_svc_sn) = 'Y' then
      obj.put('DIET',ppp_behav_diet(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,p_age));
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','WATR') = 'Y' then
      obj.put('WATR',ppp_behav_watr(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','SFTY') = 'Y' then
      obj.put('SFTY',ppp_behav_sfty(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'SAPN') = 'Y' then
      obj.put('SLEP',ppp_behav_slep(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    --
    return obj;
  end ppp_behav;
  --
  function ppp_event_strk (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_strk_flag in varchar2) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
  begin
    v_prev_plan_code := null;
    --
    v_general_text := 'Stroke is the 5th leading cause of death and a leading cause of serious, long-term disability. The accumulation of the evidence known Stroke Risk Factors, increased the Risk to have a stroke. Modifiable Risk factors can be treated and control such as high blood pressure and smoking. Other non-modifiable risk factors such as age and gender, cannot be controlled.';
    v_rf_text := 'Following the prevalent known stroke Risk Factors:';
    v_ppp_text := 'Your Physician recommends 7 KEY to cope with Harmful event:';
    --
    if p_strk_flag = 'Y' then
      v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'STRK');
      v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'STRK');
      --
      v_title := 'STROKE HEALTH RISK FACTOR';
      v_outcome_text := disease_level(v_disease_level_code)||' '||disease_severity(v_disease_severity_code)||' Stroke.';
    end if;
    if p_qualify_for_em_followup_flag = 'Y' then
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish: 1- a Preventive Plan of Care aimed to control All severe RF found in the HRA outcome that pose you at Relative Risk to have a Major Health event this coming 12 months 2-establish appropriate evidenced Prevention Recommendations to avoid or retard all severe Health issues at Risk of exacerbation. 3-To assist in modifying all wrong behaviors that has been identified as major Risk Factors   4- your Physician may recommend some lab and other necessary analysis & Test to more accurately establish an effective Preventive Plan of Care for Better Health.5- Dr may  set you up into an appropriate monitoring of BP,DM & Heart rhythm  monitoring, results, will be carefully  analyzed for appropriate treatment 6- If  Disease(s) at Risk are out of control , may referred to a Cardiologist or Electro physiologist Physician Team  7- At the Physician clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a better control of your Health.';    
    else
      v_ppp_em_text := null;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('RF_TEXT',v_rf_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('PPP',v_ppp_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    if p_strk_flag = 'Y' then
      obj2.put('RF_TEXT', disease_risk_factor('STRK'));
    end if;
    obj2.put('PPP', disease_prev_plan('STRK',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_event_strk;
  --
  function ppp_event_fall (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
    v_disease_severity_code list_disease_severity.disease_severity_code%type;
    v_adl_flag varchar2(1);
    v_iadl_flag varchar2(1);
    v_dizi_flag varchar2(1);
    v_hear_flag varchar2(1);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'FALL');
    v_disease_severity_code := patient_disease_severity(p_patient_prev_svc_sn,'FALL');
    --
    v_adl_flag := common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FDEC');
    v_iadl_flag := common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'CDEC');
    v_dizi_flag := common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DIZI');
    v_hear_flag := common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HEAR');
    --
    v_prev_plan_code := null;
    v_title := 'FALL & INJURY PREVENTION PLAN';
    v_general_text := 'Each year, 30 to 40% of elderly people living in the community and 50% of nursing home residents fall. Falls contribute to > 40% of nursing home admissions and are the 7th leading cause of death in people >= 65.';
    v_ppp_em_text := null;
    -- 
    if v_adl_flag = 'N' and v_iadl_flag = 'N' then
      v_outcome_text := 'Clinical Report HRA Outcome evidenced are at '||disease_level(v_disease_level_code)||' Risk to sustain a Fall, No ADL/IADL limitations has been found.';
    else
      v_outcome_text := 'Clinical Report HRA Outcome evidenced are at '||disease_level(v_disease_level_code)||' Risk to sustain a Fall, plus there are ADL/IADL limitations.';
    end if;
    --
    if p_qualify_for_em_followup_flag = 'Y' then
      v_outcome_text := v_outcome_text||' HRA Outcome  Clinical Report found other related Disease at Risk.';
      v_ppp_em_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish: 1- a Preventive Plan of Care aimed to control All severe RF found in the HRA outcome that pose you at Relative Risk to have a Major Health event this coming 12 months 2-establish appropriate evidenced Prevention Recommendations to avoid or retard all severe Health issues at Risk of exacerbation. 3-To assist in modifying all wrong behaviors that has been identified as major Risk Factors 4- your Physician may recommend some lab and other necessary analysis & Test to more accurately establish an effective Preventive Plan of Care for Better Health. 5- At the Physician clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a better control of your Health.';
      if v_dizi_flag = 'Y' and v_hear_flag = 'Y'  then
        v_ppp_em_text := v_ppp_em_text||' 6- Physician may refer to an appropriate Internist specialist team for more in deep evaluation of your dizziness disorder reported and to a Hearing Physician Specialist Team for further evaluation of your hearing loss condition reported.';
      elsif v_dizi_flag = 'Y' and v_hear_flag = 'N'  then
        v_ppp_em_text := v_ppp_em_text||' 6- Physician may refer to an appropriate Internist specialist team for more in deep evaluation of your dizziness disorder reported.';
      elsif v_dizi_flag = 'N' and v_hear_flag = 'Y'  then
        v_ppp_em_text := v_ppp_em_text||' 6- Physician may refer to a Hearing Physician Specialist Team for further evaluation of your hearing loss condition reported.';
      end if;
      if v_adl_flag = 'Y' or v_iadl_flag = 'Y' then
        v_ppp_em_text := v_ppp_em_text||' In addition we may refer to a Skilled Physical and Occupational therapist skilled professional to address your HRA Outcome Clinical Report of ADL/IADL limitations.';
      end if;
    else
      if v_dizi_flag = 'Y' and v_hear_flag = 'Y'  then
        v_ppp_em_text := 'Physician may refer to an appropriate Internist specialist team for more in deep evaluation of your dizziness disorder reported and to a Hearing Physician Specialist Team for further evaluation of your hearing loss condition reported.';
      elsif v_dizi_flag = 'Y' and v_hear_flag = 'N'  then
        v_ppp_em_text := 'Physician may refer to an appropriate Internist specialist team for more in deep evaluation of your dizziness disorder reported.';
      elsif v_dizi_flag = 'N' and v_hear_flag = 'Y'  then
        v_ppp_em_text := 'Physician may refer to a Hearing Physician Specialist Team for further evaluation of your hearing loss condition reported.';
      end if;
      if v_adl_flag = 'Y' or v_iadl_flag = 'Y' then
        v_ppp_em_text := v_ppp_em_text||' In addition we may refer to a Skilled Physical and Occupational therapist skilled professional to address your HRA Outcome Clinical Report of ADL/IADL limitations.';
      end if;
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj.put('label',obj2);
    --=======================
    return obj;
  end ppp_event_fall;
  --
  function ppp_event_frlt (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_general_text varchar2(1000);
    v_active_text varchar2(1000);
    v_eat_well_text varchar2(1000);
    v_mind_active_text varchar2(1000);
    v_conclusion_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'FRLT');
    --
    v_prev_plan_code := null;
    v_title := 'FRAILTY';
    v_general_text := 'The condition of being weak and delicate.';
    v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Frailty.';
    v_ppp_text := 'Your Physician Recommends:';
    v_active_text := 'Be active most days of the week:';
    v_eat_well_text := 'Eat Well:';
    v_mind_active_text := 'Keep your mind active, your attitude optimistic:';
    v_ppp_em_text := null;
    v_conclusion_text := 'Frailty impacts your life significantly, in consideration Physician may refer to an Physical/Occupational Therapist.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('PPP',v_ppp_text);
    obj2.put('ACTIVE',v_active_text);
    obj2.put('EAT_WELL',v_eat_well_text);
    obj2.put('MIND_ACTIVE',v_mind_active_text);
    obj2.put('PPP_EM_TEXT',v_ppp_em_text);
    obj2.put('CONCLUSION_TEXT',v_conclusion_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('ACTIVE','One cause of frailty is the age-related loss of muscle mass. Research suggests that activities like walking and easy strength-training moves improve strength and reduce weakness even in very old, frail adults. Every little bit helps, at any age.');
    obj2.put('EAT_WELL','Aim for three healthy meals a day that provide fruit, vegetables, protein, good fats, whole grains and low-fat dairy products. In one study, people who followed this approach (also known as the Mediterranean diet) faithfully were 74 percent less likely to become frail. Be sure to include enough muscle-nurturing protein. Women need about 46 grams per day, men about 56 grams—but many older people don’t get quite enough.');
    obj2.put('MIND_ACTIVE','Positive feelings were shown to translate into a lower risk of frailty in one study. “Staying socially connected with others and continuing to learn may also help.');
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_event_frlt;
  --ppp health event
  function ppp_event (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    v_strk_flag varchar2(1);
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','MAJOR HEALTH EVENT AT RISK OUTCOME');
    obj.put('SUB_TITLE1','Stroke (Cerebrovascular Accident(CVA)), Fall Risk and Frailty are Major Health Events.');
    --
    v_strk_flag := common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'STRK');
    --
    if v_strk_flag = 'Y' then
      obj.put('STRK',ppp_event_strk(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,v_strk_flag));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FALL') = 'Y' then
      obj.put('FALL',ppp_event_fall(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FRLT') = 'Y' then
      obj.put('FRLT',ppp_event_frlt(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    --
    return obj;
  end ppp_event;
  --
  function ppp_cond_home (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'HOME');
    --
    v_prev_plan_code := null;
    v_title := 'HOME SAFETY';
    v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Lack of Safety of your Home.';
    v_general_text := null;
    v_triggered_resp := 'Here are the items concerning the Safety of your Home:';
    v_ppp_reco_text := 'Physician encourage to correct those deficiencies ASAP to prevent a Fall & Injury that may impact your Health. If you are unable to make this correction may referred to a Social Worker to assist your safety.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('TRIGGERED_RESP',v_triggered_resp);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_RESP', cond_triggered_resp (p_patient_prev_svc_sn,'HOMES','N'));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_home;
  --
  function ppp_cond_hear (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'HEAR');
    --
    v_prev_plan_code := null;
    v_title := 'HEARING LOSS';
    v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Hearing Loss.';
    v_general_text := null;
    v_triggered_resp := 'Here are the items related to your Hearing Difficulties:';
    v_ppp_reco_text := 'Hearing Loss is among one of the HRA significant Falls Risk factors finding and/or a relevant symptom reported in the Evidenced HRA Outcome Clinical Report that may impact your well-being. An increasing hearing loss is a significant risk for a Disability in consideration Physician may refer to an Audiologist Professional for further evaluations of this condition.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('TRIGGERED_RESP',v_triggered_resp);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_RESP', cond_triggered_resp (p_patient_prev_svc_sn,'HHISQ','Y'));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_hear;
  --
  function ppp_cond_dizi (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'DIZI');
    --
    v_prev_plan_code := null;
    v_title := 'DIZZINESS';
    v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Dizziness.';
    v_general_text := null;
    v_triggered_resp := 'Here are the items related to your Dizziness:';
    v_ppp_reco_text := 'Severe Dizziness was among one of the significant HRA Falls Risk factors finding and or a relevant symptom reported in the Evidenced HRA Outcome Clinical Report that may impact your well-being, in consideration Physician may refer to an Internist for further clinical evaluations & causes of this condition.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('TRIGGERED_RESP',v_triggered_resp);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_RESP', cond_triggered_resp (p_patient_prev_svc_sn,'DIZZI','N'));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_dizi;
  --
  function ppp_cond_fdec (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(2000);
    v_definition_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'FDEC');
    v_prev_plan_code := null;
    v_title := 'FUNCTIONAL DECLINE';
    v_definition_text := 'Older Adults who has no ADL limitations had fewer falls related fractures. www.ncbi.nlm.nih.gov. Our Hi-Tech Prevention Program target all those with debilitating comorbidity conditions and ADL or mobility related limitations, special attention will be emphasize on older*women & men(75 an older) with ADL limitations  (*women lives longer than men  and in consequence more prone to become Disable for much longer period of time).';
    v_general_text := null;
    v_triggered_resp := 'Here are the items related to your Decline:';
    v_ppp_reco_text := '1- Skilled Professional will establish, HOME SELF MANAGEMENT written program tailored for your rehab needs aimed to maintain your regained functionality after reaching your plateau. This program will be initially trained during your Rehab treatment and recommended to follow up afterward for a better and safe performance of your daily activities and mobility  and will trained your compliance to the program 2- Identifying the causes of your impairments with your Physician  and  maintain a written note of  improvements or regression and  related symptoms(as  muscles pain, strength and or stiffness  level of the current functional status) it will help  out your Physician or healthcare CCM professional (if with your consent the Physician prescribed for) to contributes with your recovering. 3- Your safety while performing your Daily task is a must. Physician will instruct your skilled Rehab professional to check all safety measurements at your home during the performance of your Daily task specially at the showers, bedroom and entrance. In the event it is necessary, special holders will be prescribed and easily installed on any of home areas at Risk. 4- An advanced quick ADL/IADL Performance questionnaire will be provided by your CCM healthcare professional to be timely completed at least every quarter. 5- Maintain a Good mental Health & attitude through the process of your recovering it is extremely  important  at Physician discretion  may refer to a Psychologist team for any future evaluation and assistance.';
    --
    if p_qualify_for_em_followup_flag = 'N' then
      v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Functional Decline. No other related Disease Severe Risk Factors was found on the OUTCOME of the evidenced HRA clinical report.';
    else
      v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Functional Decline. Other related Severe Disease Risk Factor was found on the OUTCOME of the evidenced HRA clinical report.';
      v_general_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish: 1- a Preventive Plan of Care aimed to control All severe RF found in the HRA outcome that pose you at Relative Risk to have a Major Health event this coming 12 months 2-establish appropriate evidenced Prevention Recommendations to avoid or retard all severe Health issues at Risk of exacerbation. 3-To assist in modifying all wrong behaviors that has been identified as major Risk Factors   4- your Physician may recommend some lab and other necessary analysis & Test to more accurately establish an effective Preventive Plan of Care aimed to regain your Independence at your maximum functional capacity   and to cope with the core causes of your ADL limitations. 5- At the Physician clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a future  better control of your Health. 6-  Physician may refer to a Skilled Physical and/or Occupational therapist skilled professional to address your '||v_disease_level_code||' Functional limitations.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('DEFINITION_TEXT',v_definition_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('TRIGGERED_RESP',v_triggered_resp);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_RESP', cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'ADLBF'));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_fdec;
  --
  function ppp_cond_cdec (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(2000);
    v_definition_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
    v_disease_level_code varchar2(3);
  begin
    v_disease_level_code := patient_disease_level_code(p_patient_prev_svc_sn,'CDEC');
    v_prev_plan_code := null;
    v_title := 'COGNITIVE DECLINE';
    v_definition_text := 'Noticeable and measurable decline in cognitive abilities.';
    v_general_text := null;
    v_triggered_resp := 'Here are the items related to your Decline:';
    v_ppp_reco_text := '1- Skilled Professional will establish, HOME SELF MANAGEMENT written program tailored for your rehab needs aimed to maintain your regained functionality after reaching your plateau. This program will be initially trained during your Rehab treatment and recommended to follow up afterward for a better and safe performance of your daily activities and mobility  and will trained your compliance to the program 2- Identifying the causes of your impairments with your Physician  and  maintain a written note of  improvements or regression and  related symptoms(as  muscles pain, strength and or stiffness  level of the current functional status) it will help  out your Physician or healthcare CCM professional (if with your consent the Physician prescribed for) to contributes with your recovering. 3- Your safety while performing your Daily task is a must. Physician will instruct your skilled Rehab professional to check all safety measurements at your home during the performance of your Daily task specially at the showers, bedroom and entrance. In the event it is necessary, special holders will be prescribed and easily installed on any of home areas at Risk. 4- An advanced quick ADL/IADL Performance questionnaire will be provided by your CCM healthcare professional to be timely completed at least every quarter. 5- Maintain a Good mental Health & attitude through the process of your recovering it is extremely  important  at Physician discretion  may refer to a Psychologist team for any future evaluation and assistance.';
    --    
    --
    if p_qualify_for_em_followup_flag = 'N' then
      v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Cognitive Decline. No other related Disease Severe Risk Factors was found on the OUTCOME of the evidenced HRA clinical report.';
    else
      v_outcome_text := 'Evidenced HRA Clinical Outcome reported a '||disease_level(v_disease_level_code)||' Cognitive Decline. Other related Severe Disease Risk Factor was found on the OUTCOME of the evidenced HRA clinical report.';
      v_general_text := 'In view of the aforementioned clinical reasons a Face to Face Physician Assessment is medically needed to establish: 1- a Preventive Plan of Care aimed to control All severe RF found in the HRA outcome that pose you at Relative Risk to have a Major Health event this coming 12 months 2-establish appropriate evidenced Prevention Recommendations to avoid or retard all severe Health issues at Risk of exacerbation. 3-To assist in modifying all wrong behaviors that has been identified as major Risk Factors   4- your Physician may recommend some lab and other necessary analysis & Test to more accurately establish an effective Preventive Plan of Care aimed to regain your Independence at your maximum functional capacity   and to cope with the core causes of your ADL limitations. 5- At the Physician clinical judgement, you may qualify with your consent to a CCM (Chronic Care Management) monthly monitoring program for a future  better control of your Health. 6-  Physician may refer to a Skilled Physical and/or Occupational therapist skilled professional to address your '||v_disease_level_code||' Cognitive limitations.';
    end if;
    --
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('DEFINITION_TEXT',v_definition_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('TRIGGERED_RESP',v_triggered_resp);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TRIGGERED_RESP', cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'IADLB'));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_cdec;
  --
  function ppp_cond_disa (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number) return json
  is
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_title       varchar2(100);
    v_prev_plan_code  list_prev_plan.prev_plan_code%type;
    v_ppp_em_text varchar2(2000);
    v_other_reco_text varchar2(1000);
    v_neg_health_finding_text varchar2(1000);
    v_outcome_text varchar2(1000);
    v_ppp_text varchar2(1000);
    v_ppp_learn_text varchar2(1000);
    v_ppp_reco_text varchar2(2000);
    v_ppp_ccm_text varchar2(1000);
    v_911_text varchar2(1000);
    v_ccm_log_text varchar2(1000);
    v_screening_reco_text varchar2(1000);
    v_other_outcome_text varchar2(1000);
    v_general_text varchar2(1000);
    v_definition_text varchar2(1000);
    v_warning_text varchar2(1000);
    v_rf_text varchar2(1000);
    v_triggered_resp varchar2(1000);
    v_benefit_text varchar2(1000);
  begin
    v_prev_plan_code := null;
    v_title := 'DISABILITY';
    v_definition_text := 'Physical or mental condition that limits a person''s movements, senses, or activities.';
    v_outcome_text := 'Evidenced HRA Clinical Outcome reported a Severe Disability.';
    v_general_text := null;
    v_ppp_text := '14 steps of how to cope with  your Disability (http://www.wikihow.com/Emotionally-Cope-With-Having-Disabilities)';    
    v_warning_text := null;
    v_ppp_reco_text := 'Disabilities impacts your life significantly, in consideration Physician may refer to an Physical/Occupational Therapist.';
    --    
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('DEFINITION_TEXT',v_definition_text);
    obj2.put('OUTCOME',v_outcome_text);
    obj2.put('GENERAL_TEXT',v_general_text);
    obj2.put('PPP',v_ppp_text);    
    obj2.put('WARNING_TEXT',v_warning_text);
    obj2.put('PPP_RECO_TEXT',v_ppp_reco_text);
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP', risk_factor_prev_plan('DISA',v_prev_plan_code));
    obj.put('label_value',obj2);
    --=======================
    return obj;
  end ppp_cond_disa;
  --ppp other condition
  function ppp_cond (p_patient_prev_svc_sn in number,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_other_cond_cnt in number) return json
  is
    obj         json;
    --
    v_sev_fdec_cdec_cnt pls_integer;
    v_disa_hist_cnt     pls_integer;
    v_cnt pls_integer := 0;
    v_disease_descr     varchar2(1000) := null;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','OTHER CONDITIONS IMPACTING HEALTH');
    --
    for i in (select disease_short_descr
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_code in ('HOME','DIZI','HEAR','CDEC','FDEC') 
              and disease_level_code <> 'LOW'
              )
    loop
      v_cnt := v_cnt + 1;
      if v_cnt = 1 then
        v_disease_descr := v_disease_descr||i.disease_short_descr;
      else
        if v_cnt = p_other_cond_cnt then
          v_disease_descr := v_disease_descr||' and '||i.disease_short_descr;
        else
          v_disease_descr := v_disease_descr||', '||i.disease_short_descr;
        end if;
      end if;
    end loop;
    --
    if p_other_cond_cnt = 1 then
      v_disease_descr := v_disease_descr||' is the Major Condition related to Health.';
    else
      v_disease_descr := v_disease_descr||' are Major Conditions related to Health.';
    end if;
    obj.put('SUB_TITLE1',v_disease_descr);
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HOME') = 'Y' then
      obj.put('HOME',ppp_cond_home(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HEAR') = 'Y' then
      obj.put('HEAR',ppp_cond_hear(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DIZI') = 'Y' then
      obj.put('DIZI',ppp_cond_dizi(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FDEC') = 'Y' then
      obj.put('FDEC',ppp_cond_fdec(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'CDEC') = 'Y' then
      obj.put('CDEC',ppp_cond_cdec(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    --
    --Require further evaluation
--    select  count(*)
--    into v_disa_hist_cnt
--    from patient_response_vw
--    where patient_prev_svc_sn = p_patient_prev_svc_sn
--    and category_code = 'BMEDH'
--    and question_code in ('1001','1002','1003','1004')
--    ;
--    select count(*)
--    into v_sev_fdec_cdec_cnt
--    from svc_result_vw 
--    where patient_prev_svc_sn = p_patient_prev_svc_sn
--    and disease_code in ('FDEC','CDEC')
--    and disease_level_code not in ('LOW','MOD')
--    ;
--    if v_disa_hist_cnt > 0 or v_sev_fdec_cdec_cnt > 0 then
--      obj.put('DISA',ppp_cond_disa(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
--    end if;
    --
    return obj;
  end ppp_cond;
  --patient_info
  function patient_info (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    obj         json;
    l_obj       json_list;
    --
    v_svc_date varchar2(30);
    v_svc_perform_date varchar2(30);
    v_qualify_for_em_followup_flag varchar2(1);
    v_pat_primary_physician_name varchar2(500);
    v_PAT_PRI_PHYSICIAN_COMPANY varchar2(500);
    v_provider_physician_name varchar2(500);
    v_provider_physician_company varchar2(500);
    v_svc_location_name varchar2(500);
    v_svc_location_addr varchar2(500);
    v_pat_medicare_hic_num varchar2(30);
    v_pat_addr varchar2(500);
    v_pat_email varchar2(200);
    v_pat_phone varchar2(50);
    v_pat_gender varchar2(10);
    v_pat_race varchar2(100);
    v_pat_marital_status varchar2(500);
    v_pat_working_status varchar2(500);
    v_pat_educational_level varchar2(500);
    v_pat_financial_status varchar2(500);
    v_pat_living_status varchar2(500);
    v_pat_income varchar2(500);
    v_pat_name varchar2(500);
    v_pat_birth_date varchar2(30);
    v_pat_age varchar2(4);
    v_pat_age_at_svc_perform_date varchar2(4);
    v_pat_bmi varchar2(100);
    v_pat_height_in_ft varchar2(30);
    v_pat_weight_in_lb varchar2(30);
    v_pat_hdl_cholesterol_in_mg varchar2(30);
    v_pat_ldl_cholesterol_in_mg varchar2(30);
    v_pat_bp varchar2(30);
    v_patient_orientation varchar2(100);
    v_source_of_history varchar2(200);
    v_CHRONIC_DISEASE_CNT number(2);
  begin
    l_obj := json_list(); --an empty list obj
    --
    select svc_date
          ,svc_perform_date
          ,qualify_for_em_followup_flag
          ,CHRONIC_DISEASE_CNT
          ,pat_primary_physician_name
          ,PAT_PRIMARY_PHYSICIAN_COMPANY
          ,provider_physician_name
          ,provider_physician_company
          ,svc_location_name
          ,svc_location_addr
          ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
          ,pat_addr
          ,pat_email
          ,pat_phone
          ,pat_gender
          ,pat_race
          ,pat_marital_status
          ,pat_working_status
          ,pat_educational_level
          ,pat_financial_status
          ,pat_living_status
          ,pat_income
          ,case
            when pat_gender_code = 'MAL' then 'MR. '||pat_name
            else 'MRS. '||pat_name
            end pat_name
          ,pat_birth_date
          ,pat_age
          ,pat_age_at_svc_perform_date
          ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
          ,pat_height_in_ft
          ,pat_weight_in_lb||' LB' pat_weight_in_lb
          ,pat_hdl_cholesterol_in_mg
          ,pat_ldl_cholesterol_in_mg
          ,pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
          ,patient_orientation
          ,source_of_history
    into  v_svc_date
          ,v_svc_perform_date
          ,v_qualify_for_em_followup_flag
          ,v_CHRONIC_DISEASE_CNT
          ,v_pat_primary_physician_name
          ,v_PAT_PRI_PHYSICIAN_COMPANY
          ,v_provider_physician_name
          ,v_provider_physician_company
          ,v_svc_location_name
          ,v_svc_location_addr
          ,v_pat_medicare_hic_num
          ,v_pat_addr
          ,v_pat_email
          ,v_pat_phone
          ,v_pat_gender
          ,v_pat_race
          ,v_pat_marital_status
          ,v_pat_working_status
          ,v_pat_educational_level
          ,v_pat_financial_status
          ,v_pat_living_status
          ,v_pat_income
          ,v_pat_name
          ,v_pat_birth_date
          ,v_pat_age
          ,v_pat_age_at_svc_perform_date
          ,v_pat_bmi
          ,v_pat_height_in_ft
          ,v_pat_weight_in_lb
          ,v_pat_hdl_cholesterol_in_mg
          ,v_pat_ldl_cholesterol_in_mg
          ,v_pat_bp
          ,v_patient_orientation
          ,v_source_of_history
    from patient_prev_svc_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    obj := json(); --an empty structure
    obj.put('NAME','Name: '||v_pat_name);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Phone: '||v_pat_phone);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Email: '||v_pat_email);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Address: '||v_pat_addr);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Service Schedule Date: '||v_svc_date);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Service Perform Date: '||v_svc_perform_date);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Qualify for EM (CCM Patient)?: '||v_qualify_for_em_followup_flag);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Chronic Disease (Acquired) Count: '||v_CHRONIC_DISEASE_CNT);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Physician Name: '||v_pat_primary_physician_name);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Physician Company: '||v_PAT_PRI_PHYSICIAN_COMPANY);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Clinician Interviewer: '||v_provider_physician_name);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Interviewer Company: '||v_provider_physician_company);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Service Location Name: '||v_svc_location_name);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Service Location Address: '||v_svc_location_addr);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Medicare HIC Num: '||v_pat_medicare_hic_num);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Gender: '||v_pat_gender);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Race: '||v_pat_race);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Marital Status: '||v_pat_marital_status);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Working Status: '||v_pat_working_status);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Educational Level: '||v_pat_educational_level);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Financial Status: '||v_pat_financial_status);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Living Status: '||v_pat_living_status);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Income: '||v_pat_income);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Birth Date: '||v_pat_birth_date);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Current Age: '||v_pat_age);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Age At Service Perform Date: '||v_pat_age_at_svc_perform_date);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','BMI: '||v_pat_bmi);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Height (ft): '||v_pat_height_in_ft);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Weight (lb): '||v_pat_weight_in_lb);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Cholesterol HDL (mg): '||v_pat_hdl_cholesterol_in_mg);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Cholesterol LDL (mg): '||v_pat_ldl_cholesterol_in_mg);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Blood Pressure: '||v_pat_bp);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Orientation: '||v_patient_orientation);
    l_obj.append(obj.to_json_value);
    --
    obj := json(); --an empty structure
    obj.put('NAME','Source of Patient History Record: '||v_source_of_history);
    l_obj.append(obj.to_json_value);
    --===================================== end of json building
    return l_obj;
  end patient_info;
  --ppp_cms
  function ppp_cms (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
    v_cnt       pls_integer;
  begin
    l_obj := json_list(); --an empty list obj
    --
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1008','YES') = 'Y' or common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'OBES') = 'Y' then
      l_obj.append('IBT (Weight Loss Counseling)');
    end if;
    --
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','TBCO') = 'Y' then
      l_obj.append('Smoking Cessation counseling (8 counseling/year)');
    end if;
    if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','ALCO') = 'Y' then
      l_obj.append('Alcohol Misuse and Screening and Counseling');
    end if;
    --Check DIAB Hx 
    if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'DIAB') = 'Y' then
      l_obj.append('Medical Nutrition Therapy (MNT)');
      l_obj.append('Diabetes Mellitus (DM) self-management');
    else --v_cnt = 0 no Diabetes, check for Kidney disease
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'CKDE') = 'Y' then
        l_obj.append('Medical Nutrition Therapy (MNT)');
      end if;
    end if;
    --
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DEPR') = 'Y' then
      l_obj.append('Depression Screening (annually)');
    end if;
    --
    if common_inq_pkg.disease_categ_aqurd_riska_flag(p_patient_prev_svc_sn,'CVDE') = 'Y' then
      l_obj.append('Intensive Behavioral Therapy for CVD (annually)');
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_cms;
  --ppp_usda
  function ppp_usda (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_gender_code in varchar2,p_age in number) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select intervention_descr descr
              from em_name_vw
              where usda_immu_comp_flag = 'Y'
              and p_age between usda_immu_comp_age_begin and usda_immu_comp_age_end
              and nvl(triggered_code,p_gender_code) = p_gender_code
              and em_name_code not in (select nvl(em_name_code,'999999999')
                                      from patient_history_vw 
                                      where patient_sn = common_inq_pkg.patient_sn_of_pps_sn(p_patient_prev_svc_sn)
                                      and em_name_code is not null
                                      and category_code in ('HVACN','HVART')
                                      )
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_usda;
  --ppp_referral
  function ppp_referral (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_qualify_for_em_followup_flag in varchar2,p_sys in number,p_dia in number) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    --Blurred or Double Vision symptom
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HENMT','1001','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1004','YES') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1006','YES') = 'Y' then
      l_obj.append('Ophthalmologist Physician Team');
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'HEAR') = 'Y' then
      l_obj.append('Audiologist Team');
    end if;
    if common_inq_pkg.disease_categ_aqurd_riska_flag(p_patient_prev_svc_sn,'CVDE') = 'Y' then
      l_obj.append('Cardiologist Team');
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DIZI') = 'Y' then
      l_obj.append('Ear, Nose & Throat Physician Team');
    end if;
    --Shortness of Breath Symptom
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'CLHTS','1002','CBX') = 'Y' then
      l_obj.append('Pulmonologist Physician Team');
    end if;
    --
    if common_inq_pkg.pain_symptom_flag(p_patient_prev_svc_sn) = 'Y' or common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'ARTH') = 'Y' then
      l_obj.append('Osteopathy Dr. Team (DO) for pain management & manipulations');
    end if;
    if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FALL') = 'Y' then
      l_obj.append('Skilled Physical Therapy for Fall Prevention');
    end if;
    if common_pkg.bp_reading(p_sys,p_dia) = 'Hypertension' then
      l_obj.append('BP Monitoring');
    end if;
    if p_qualify_for_em_followup_flag = 'Y' then
      l_obj.append('Face to Face EM Prevention Assessment with the Physician');
    end if;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_referral;
  --ppp_sch_hra_sa
  function ppp_sch_hra_sa (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return varchar2
  as
    v_poor_self_assessment boolean := false;
    v_cnt pls_integer;
    v_txt varchar2(1000)  := null;
  begin
    v_txt := 'Basis in the negative statement about your Health Assessment, and taking in considerations your reported activities limitations, your self- perception of your Health became an important Risk Factor to acquire a new Disease, exacerbate an old Medical Condition, encounter a Major Health Event';
    if (common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','FIR') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','POR') = 'Y') and (common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1002','ALW') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1002','LFY') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1003','YES') = 'Y') then
      v_poor_self_assessment := true;
    elsif (common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','POR') = 'Y') and ((common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'CDEC') = 'Y' or common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FDEC') = 'Y') or (common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'FALL') = 'Y') or (common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'DEPR') = 'Y')) then
      v_poor_self_assessment := true;
    end if;
    --History of disability
    select count(*)
    into v_cnt
    from patient_history_vw 
    where patient_sn = common_inq_pkg.patient_sn_of_pps_sn(p_patient_prev_svc_sn)
    and category_code = 'BMEDH'
    and question_code in ('1001','1002','1003','1004')
    ;
    if v_poor_self_assessment then
      if v_cnt = 0 then
        v_txt := v_txt||' or became Disable.';
      else
        v_txt := v_txt||'.';
      end if;
      --
      return v_txt;
    else
      return null;
    end if;
    --===================================== end of json building
  end ppp_sch_hra_sa;
  --ppp_sch_psy_disorder
  function ppp_sch_psy_disorder (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_psy_disorder;
  --ppp_sch_psy_depression
  function ppp_sch_psy_depression (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_psy_depression;
  --ppp_sch_psy_anxiety
  function ppp_sch_psy_anxiety (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_psy_anxiety;
  --ppp_sch_psy_stress
  function ppp_sch_psy_stress (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_psy_stress;
  --ppp_sch_hra_behav_bp
  function ppp_sch_hra_behav_bp (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_bp;
  --ppp_sch_hra_behav_chol
  function ppp_sch_hra_behav_chol (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_chol;
  --ppp_sch_hra_behav_bs
  function ppp_sch_hra_behav_bs (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_bs;
  --ppp_sch_hra_behav_bmi
  function ppp_sch_hra_behav_bmi (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_bmi;
  --ppp_sch_hra_behav_physical
  function ppp_sch_hra_behav_physical (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_physical;
  --ppp_sch_hra_behav_diet
  function ppp_sch_hra_behav_diet (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return json_list
  as
    l_obj       json_list;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select 'Intervention 1' descr from dual union
              select 'Intervention 2' descr from dual
              )
    loop
      l_obj.append(i.descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    --===================================== end of json building
    return l_obj;
  end ppp_sch_hra_behav_diet;
  --ccm_patient_agmt_data
  PROCEDURE ccm_patient_agmt_data (p_patient_name in varchar2,p_primary_physician_name in varchar2,p_out OUT varchar2)
  as
    obj         json;
  begin
    obj := json(); --an empty structure
    obj.put('CCM_CONTACT_NAME',common_pkg.appl_control_value_alpha('CCM','CONTACT_NAME'));
    obj.put('CCM_CONTACT_PH',common_pkg.appl_control_value_alpha('CCM','CONTACT_PH'));
    obj.put('CCM_CONTACT_ADDR',common_pkg.appl_control_value_alpha('CCM','CONTACT_ADDR'));
    obj.put('CCM_AGMT_DATE',to_char(sysdate,'MM/DD/YYYY'));
    obj.put('CCM_PHYSICIAN_NAME',p_primary_physician_name);
    obj.put('CCM_PATIENT_NAME',p_patient_name);    
    --===================================== end of json building
    p_out := obj.to_char;
  end ccm_patient_agmt_data;
  --report_vitals
  PROCEDURE report_vitals (p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
  begin
    obj := json(); --an empty structure
    --======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','VITALS');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TEMP','Temp:');
    obj2.put('BP','BP:');
    obj2.put('PULSE','Pulse:');
    obj2.put('RHY','Rhythms:');
    obj2.put('REG','regular');
    obj2.put('IRRE','irregular');
    obj2.put('RESP','Resp:');
    obj.put('label',obj2);
    --=======================placeholder
    obj2 := json(); --an empty structure
    obj2.put('TEMP','&#8457;');
    obj2.put('SBP','SBP');
    obj2.put('DBP','DBP');
    obj2.put('PULSE','BPM');
    obj2.put('RESP','BPM');
    obj.put('placeholder',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end report_vitals;
  --report_hdr
  PROCEDURE report_hdr (p_svc_type_code in varchar2,p_name in varchar2,p_date in varchar2,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    if p_svc_type_code = 'AWV' then
      obj.put('TITLE','ANNUAL WELLNESS VISIT & HRA');
    elsif p_svc_type_code = 'E/M' then
      obj.put('TITLE','EM PREVENTION MEDICAL ASSESSMENT');
    end if;
    --obj.put('SUB_TITLE1','HRA EBM CLINICAL REPORT and PERSONALIZED PREVENTION PLAN');
    obj.put('SUB_TITLE1','');
    obj.put('SUB_TITLE2',upper('the clinical data contained in this clinical report was generated by the awv/hra evidence base outcome PERFORMED on ')||p_date||' FOR');
    obj.put('SUB_TITLE3',upper(p_name));
    --===================================== end of json building
    p_out := obj.to_char;
  end report_hdr;
  --patient_demo
  PROCEDURE patient_demo (p_svc_rpt_type_code in varchar2,p_gender in varchar2,p_hic in varchar2,p_dob in varchar2,p_age in number,p_bp in varchar2,p_orin in varchar2,p_hist_src in varchar2,p_status in varchar2,p_svc_place in varchar2,p_phy in varchar2,p_bmi_result in varchar2,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('GENDER','GENDER:');
    obj2.put('HIC','HIC:');
    obj2.put('DOB','DOB:');
    obj2.put('AGE','AGE/BMI:');
    if nvl(p_svc_rpt_type_code,'XXX') <> 'EEV' then
      obj2.put('BP','BP:');
    end if;
    obj2.put('ORIEN','ORIENTATION:');
    obj2.put('HIST_SRC','SOURCE OF HIST:');
    obj2.put('STATUS','MARITAL STATUS:');
    obj2.put('SVC_PLACE','PLACE OF SERVICE:');
    obj2.put('PHY','ATTENDING PHYSICIAN:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('GENDER',p_gender);
    obj2.put('HIC',p_hic);
    obj2.put('DOB',p_dob);
    obj2.put('AGE',p_age||'/'||p_bmi_result);
    if nvl(p_svc_rpt_type_code,'XXX') <> 'EEV' then
      obj2.put('BP',p_bp);
    end if;
    obj2.put('ORIEN',p_orin);
    obj2.put('HIST_SRC',p_hist_src);
    obj2.put('STATUS',p_status);
    obj2.put('SVC_PLACE',p_svc_place);
    obj2.put('PHY',p_phy);
    obj.put('label_value',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_demo;
  --patient_vitals
  PROCEDURE patient_vitals (p_temp in number,p_bp in varchar2,p_pulse in varchar2,p_resp in varchar2,p_rhythm in varchar2,p_out out varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TEMP','TEMP:');
    obj2.put('BP','BP:');
    obj2.put('PULSE','PULSE:');
    obj2.put('RESP','RESP:');
    obj2.put('RHYTHM','RHYTHMS:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('TEMP',p_temp);
    obj2.put('BP',p_bp);
    obj2.put('PULSE',p_pulse);
    obj2.put('RESP',p_resp);
    obj2.put('RHYTHM',p_rhythm);
    obj.put('label_value',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end patient_vitals; 
  --tertiary_intervention
  PROCEDURE tertiary_intervention (p_ppp in varchar2,p_lab_and_test in varchar2,p_referrals in varchar2,p_clinical_rx in varchar2,p_out out varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('PPP','Preventative scheduling:');
    obj2.put('LAB','LAB & TEST prescribed:');
    obj2.put('REFERRAL','Referrals:');
    obj2.put('CLINICAL_RX','Clinically warranted Rx Followup:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('PPP',p_ppp);
    obj2.put('LAB',p_lab_and_test);
    obj2.put('REFERRAL',p_referrals);
    obj2.put('CLINICAL_RX',p_clinical_rx);
    obj.put('label_value',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end tertiary_intervention; 
  --hra_hdr
  PROCEDURE report_hra (p_patient_sn in number,p_patient_prev_svc_sn in number,p_age in number,p_gender in varchar2,p_gender_code in varchar2,p_rase in varchar2,p_fin_status in varchar2,p_living_status in varchar2,p_edu in varchar2,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2       json_list;
    v_response        response_lang.short_descr%type;
    v_disability_cnt  pls_integer;
    v_disability      varchar2(30);
    v_score           varchar2(100);
    v_fall_risk       disease_level_lang.short_descr%type;
    v_med_cnt         pls_integer := 0;
    v_diab_hx_cnt     pls_integer;
  begin
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','HEALTH RISK ASSESSMENT');
    obj2.put('SUB_TITLE1','PMHX');
    obj2.put('SUB_TITLE2','THE ACCURACY OF THIS PMHX WAS VERIFIED FROM THE EMR AND BY THE BENEFICIARY DURING THE AWV/HRA Q1 ENCOUNTER.');
    obj2.put('SUB_TITLE3','RX MEDS LIST AND DOSES');
    obj2.put('SUB_TITLE4','HRA/NON-MODIFIABLE RISK FACTORS FINDING');
    obj2.put('SUB_TITLE5','THE FOLLOWING NON-MODIFIABLE RF MAY HAVE INFLUENCED THE PERSONALIZED HRA EVIDENCED CLINICAL REPORT SCORED OUTCOME');
    obj2.put('SUB_TITLE6','HRA/MODIFIABLE RISK FACTORS FINDING');
    obj2.put('SUB_TITLE7','THE FOLLOWING RF MAY HAVE INFLUENCED PERSONALIZED HRA EVIDENCED CLINICAL DISEASE SCORED OUTCOME');
    obj.put('hdr',obj2);
    --=======================pmhx_label
    obj2 := json(); --an empty structure
    obj2.put('PAST_SURG','Past Surgeries:');
    obj2.put('HOSP','Hospitalization during past two years:');
    obj2.put('MED_ALRG','Medication Allergies:');
    obj2.put('FOOD_ALRG','Food Allergies:');
    obj2.put('PMHX_DISE','PMHX of Disease, Event or Condition:');
    obj.put('pmhx_label',obj2);
    --=======================pmhx_label_value
    obj2 := json(); --an empty structure
    for i in (select question_code,question,response_code,response
              from patient_history_vw
              where patient_sn = p_patient_sn
              and category_code = 'HSURA'
              )
    loop
      if i.response_code = 'NOO' then v_response := 'None';
      else v_response := i.response;
      end if;
      if i.question_code = '1001' then
        obj2.put('PAST_SURG',v_response);
      end if;
      if i.question_code = '1002' then
        obj2.put('HOSP',v_response);
      end if;
      if i.question_code = '1003' then
        obj2.put('MED_ALRG',v_response);
      end if;
      if i.question_code = '1004' then
        obj2.put('FOOD_ALRG',v_response);
      end if;
    end loop;
    --=================PMHX_DISE
    l_obj := json_list(); --an empty list obj
    for j in (select nvl(prv.question,srv.disease_short_descr) disease_name
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = p_patient_sn
              and srv.disease_severity_code <> 'RISKA'
              and srv.disease_code not in ('FRLT','OBES','ALCO')
              and prv.category_code(+) = 'BMEDH'
              )
    loop
      l_obj.append(j.disease_name);
    end loop;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('PMHX_DISE', l_obj);
    obj.put('pmhx_label_value',obj2);
    --=====================meds
    l_obj := json_list(); --an empty list obj
    for k in (select report_pkg.prescribed_medication_descr(name,quantity,quantity_unit,frequency,purpose) name
              from patient_medication_vw
              where patient_sn = p_patient_sn
              and medication_current_flag = 'Y'
              and status = 'Active'
              and prescribed_med_flag = 'Y'              
              )
    loop
      v_med_cnt := v_med_cnt + 1;
      l_obj.append(k.name);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj.put('meds', l_obj);
    --=======================nonmod_rf_label
    obj2 := json(); --an empty structure
    obj2.put('AGE','Age:');
    obj2.put('GENDER','Gender:');
    obj2.put('RACE','Race:');
    obj2.put('DISABILITY','Disability:');
    obj2.put('FIN_STATUS','Financial Status:');
    obj2.put('LIV_STATUS','Living Status:');
    obj2.put('EDUCATION','Education:');
    obj2.put('FAM_PMHX','Family PMHX');
    obj.put('nonmod_rf_label',obj2);
    --=======================nonmod_rf_label_value
    select count(*)
    into v_disability_cnt
    from patient_history_vw
    where patient_sn = p_patient_sn
    and category_code = 'BMEDH'
    and question_code in ('1001','1002','1003','1004')
    ;
    if v_disability_cnt = 0 then v_disability := 'No';
    else v_disability := 'Yes';
    end if;
    --
    obj2 := json(); --an empty structure
    obj2.put('AGE',p_age);
    obj2.put('GENDER',p_gender);
    obj2.put('RACE',p_rase);
    obj2.put('DISABILITY',v_disability);
    obj2.put('FIN_STATUS',p_fin_status);
    obj2.put('LIV_STATUS',p_living_status);
    obj2.put('EDUCATION',p_edu);
    --==============================FAM_PMHX
    l_obj := json_list(); --an empty list obj
    for j in (select question||' ('||response||')' response
              from patient_history_vw
              where patient_sn = p_patient_sn
              and category_code = 'FHNMR'
              and response_code <> 'NON'
              )
    loop
      l_obj.append(j.response);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('FAM_PMHX', l_obj);
    obj.put('nonmod_rf_label_value',obj2);
    --=======================mod_rf_label
    obj2 := json(); --an empty structure
    obj2.put('WRONG_BEHV','Wrong Behaviors Reported');
    obj2.put('PSY_DISORDER','Psycho Social Disorder');
    obj2.put('MNTL_DISORDER','Mental Disorder');
    obj2.put('SFTY','Home Safety');
    obj2.put('FUN_LIMIT','Functionality Limitation:');
    obj2.put('COG_LIMIT','Cognitive Limitation:');
    obj2.put('ELONE','Loneliness:');
    obj2.put('SLONE',''); --will be removed from the UI later
    obj2.put('DIZZI','Dizziness:');
    obj2.put('HEAR','Hearing Loss:');
    obj2.put('FALL','Fall Risk:');
    obj2.put('MED','Medication Compliance:');
    obj.put('mod_rf_label',obj2);
    --=======================mod_rf_label_value
    obj2 := json(); --an empty structure
    --==========WRONG_BEHV
    l_obj := json_list(); --an empty list obj
    l_obj := wrong_behav(p_patient_prev_svc_sn);
    --
    l_obj2 := json_list(); --an empty list obj
    l_obj2 := usda_vaccination_test(p_patient_prev_svc_sn,p_gender_code);
    if json_ac.array_count(l_obj2) <> 0 then
      if json_ac.array_count(l_obj2) > 2 then
        l_obj.append('Compliance of USDA vaccination and Test');
      else
        for i in 1..json_ac.array_count(l_obj2) loop
          l_obj.append(json_ac.array_get(l_obj2,i).get_string);
        end loop;
      end if;
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('WRONG_BEHV', l_obj);
    --==========PSY_DISORDER    
    l_obj := json_list(); --an empty list obj
    for j in (select srv.dis_level_short_descr||' '||nvl(srv.disease_short_descr,prv.question) disease_name
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = p_patient_sn
              and srv.disease_code in ('ANXT','DEPR','STRS')
              and srv.disease_severity_code <> 'RISKA'
              and prv.category_code(+) = 'BMEDH'
              union
              select dis_level_short_descr||' '||disease_short_descr disease_name
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_code in ('ANXT','DEPR','STRS')
              and disease_level_code <> 'LOW'
              )
    loop
      l_obj.append(j.disease_name);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('PSY_DISORDER', l_obj);
    --==========MNTL_DISORDER
    l_obj := json_list(); --an empty list obj
    for j in (select srv.dis_level_short_descr||' '||nvl(srv.disease_short_descr,prv.question) disease_name
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = p_patient_sn
              and srv.disease_code = 'SCHI'
              and srv.disease_severity_code <> 'RISKA'
              and prv.category_code(+) = 'BMEDH'
              union
              select dis_level_short_descr||' '||disease_short_descr disease_name
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_code = 'SCHI'
              and disease_level_code <> 'LOW'
              )
    loop
      l_obj.append(j.disease_name);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('MNTL_DISORDER', l_obj);
    --==========SFTY
    l_obj := json_list(); --an empty list obj
    for j in (select question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'HOMES'
              and response_score <> 0
              )
    loop
      l_obj.append(j.question_rpt_descr);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj2.put('SFTY', l_obj);
    --========
    obj2.put('FUN_LIMIT',report_pkg.score_descr(p_patient_prev_svc_sn,'FDEC',null));
    obj2.put('COG_LIMIT',report_pkg.score_descr(p_patient_prev_svc_sn,'CDEC',p_gender_code));
    obj2.put('ELONE',report_pkg.score_descr(p_patient_prev_svc_sn,'LONL',null));
    obj2.put('SLONE',''); --will be removed from the UI later
    obj2.put('DIZZI',report_pkg.score_descr(p_patient_prev_svc_sn,'DIZI',null));
    obj2.put('HEAR',report_pkg.score_descr(p_patient_prev_svc_sn,'HEAR',null));
    --========
    select short_descr
    into v_fall_risk
    from disease_level_lang 
    where disease_level_code = svc_eval_pkg.fall_risk_level(p_patient_prev_svc_sn,v_med_cnt,p_age)
    ;
    obj2.put('FALL',v_fall_risk);
    obj2.put('MED',rx_meds_result(p_patient_prev_svc_sn,v_med_cnt));
    obj.put('mod_rf_label_value',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end report_hra;
  --
  PROCEDURE report_clinical (p_patient_prev_svc_sn in number,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list := json_list();
    l_obj2      json_list := json_list();
    l_obj3      json_list := json_list();
    v_response_data patient_response.response_data%type;
    --
    v_patient_sn patient.patient_sn%type;
    v_gender_code list_gender.gender_code%type;
    v_financial_status_code list_financial_status.financial_status_code%type;
    v_race_code list_race.race_code%type;
    v_age number(9);
    v_bmi number(9,3);
    v_bmi_result varchar2(30);
    v_bp_result varchar2(30);
    v_med_cnt pls_integer;
    v_SYSTOLIC_BP_IN_MM number(3);
    v_DIASTOLIC_BP_IN_MM number(3);
  begin
    select p.gender_code
          ,common_pkg.age_at_a_date(p.birth_date,pps.SVC_PERFORM_DATE)
          ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)
          ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in))
          ,common_pkg.bp_reading(pps.SYSTOLIC_BP_IN_MM,pps.DIASTOLIC_BP_IN_MM)
          ,pps.SYSTOLIC_BP_IN_MM
          ,pps.DIASTOLIC_BP_IN_MM
          ,svc_eval_pkg.med_cnt(pps.patient_sn)
          ,pps.financial_status_code
          ,p.race_code
          ,p.patient_sn
    into v_gender_code
        ,v_age
        ,v_bmi
        ,v_bmi_result
        ,v_bp_result
        ,v_SYSTOLIC_BP_IN_MM
        ,v_DIASTOLIC_BP_IN_MM
        ,v_med_cnt
        ,v_financial_status_code
        ,v_race_code
        ,v_patient_sn
    from patient_prev_svc pps
        ,patient p
    where pps.patient_sn = p.patient_sn
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','Evidence base AWV/HRA OUTCOME CLINICAL REPORT & PERSONALIZED PREVENTION PLAN');
    obj2.put('SUB_TITLE1','This report is Based in Algorithmic and Fuzzy-Logic technology of sensitive Beneficiary answers to our validated clinical test the system generates this evidence base Personalized Clinical Report for the Physician review.');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('HEALTH_CONCERN1','Any Major Health Concern');
    obj2.put('HEALTH_CONCERN2','(Subjective Patient Health Report):');
    obj2.put('DIS_COND','Diseases & Conditions at Risk');
    obj2.put('MAJ_EVENT','Major Health Events at Risk');
    obj2.put('DIS_ACQ_CNTRL','Diseases Acquired (Controlled with Meds or life change)');
    obj2.put('DIS_ACQ_AT_RISK','Diseases Acquired at Risk to Get Exacerbated');
    obj2.put('OTR_HRA','Other HRA Factors finding that may impact your Well Being that need your attention');
    obj.put('label',obj2);
    --=======================label_value
    --==========HEALTH_CONCERN
    begin
      select response_data
      into v_response_data
      from patient_response_vw
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and category_code = 'BDTEN'
      and question_code = '1001'
      ;
    exception
      when others then v_response_data := null;
    end;
    obj.put('HEALTH_CONCERN',v_response_data);
    --==========DIS_COND
    l_obj := json_list(); --an empty list obj
    for i in (select disease_rpt_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rpt_label
                    ,disease_rf_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rf_label
                    ,disease_code
                    ,disease_type_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'RISKA'
              and disease_type_code in ('DISE','COND')
              and disease_level_code <> 'LOW'
              union
              select disease_rpt_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rpt_label
                    ,disease_rf_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rf_label
                    ,disease_code
                    ,disease_type_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'RISKA'
              and disease_type_code = 'DISO'
              and disease_code in ('LONL','ANXT','DEPR','STRS')
              and disease_level_code <> 'LOW'
              order by disease_type_code desc
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('LBL',i.disease_rpt_label);
      --=============rf
      obj3 := json(); --an empty structure
      obj3.put('LBL',i.disease_rf_label);
      --=============rf_value
      l_obj2 := json_list(); --an empty list obj
      --
      if i.disease_type_code = 'DISE' then
        l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'Y',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);        
      else --COND (DISO for LONL)
        if i.disease_code = 'HOME' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'HOMES','N');
        elsif i.disease_code = 'HEAR' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'HHISQ','Y');
        elsif i.disease_code = 'DIZI' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'DIZZI','N');
        elsif i.disease_code = 'LONL' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'LONLS','N');
        elsif i.disease_code = 'ANXT' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'ANXIT','N');
        elsif i.disease_code = 'DEPR' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'GERDS','N');
        elsif i.disease_code = 'STRS' then
          l_obj2 := cond_triggered_resp (p_patient_prev_svc_sn,'HRSTS','N');
        elsif i.disease_code = 'FRTR' then
          null; --will be added in future further evaluation needed
        end if;
      end if;
      if json_ac.array_count(l_obj2) = 0 then
        l_obj2.append('None');
      end if;
      obj3.put('rf_value', l_obj2);
      --
      obj2.put('rf', obj3);
      --=============symptom and additional RF
      obj3 := json(); --an empty structure
      obj3.put('LBL','Additional Factors Reported');
      --=============symptom_value
      l_obj2 := json_list(); --an empty list obj
      l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'N',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);
      --
      l_obj3 := symptom_rf(p_patient_prev_svc_sn,i.disease_code);
      if json_ac.array_count(l_obj3) <> 0 then
        for i in 1..json_ac.array_count(l_obj3) loop
          l_obj2.append(json_ac.array_get(l_obj3,i).get_string);
        end loop;
      end if;
      if json_ac.array_count(l_obj2) = 0 then
        l_obj2.append('None');
      end if;
      obj3.put('symptom_value', l_obj2);
      --
      obj2.put('symptom', obj3);
      --========
      l_obj.append(obj2.to_json_value);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      obj2 := json(); --an empty structure
      obj2.put('LBL','None');
      l_obj.append(obj2.to_json_value);
    end if;
    obj.put('DIS_COND', l_obj);
    --==========MAJ_EVENT
    l_obj := json_list(); --an empty list obj
    for i in (select disease_rpt_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rpt_label
                    ,disease_rf_label(disease_code,disease_severity_code,disease_short_descr,dis_level_short_descr) disease_rf_label
                    ,disease_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'RISKA'
              and disease_type_code = 'EVNT'
              and disease_level_code <> 'LOW'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('LBL',i.disease_rpt_label);
      --=============rf
      obj3 := json(); --an empty structure
      obj3.put('LBL',i.disease_rf_label);
      --=============rf_value
      l_obj2 := json_list(); --an empty list obj
      if i.disease_code = 'STRK' then
        l_obj2 := strk_rf(p_patient_prev_svc_sn,v_age,'Y','Y');
      elsif i.disease_code = 'FALL' then
        l_obj2 := fall_rf(p_patient_prev_svc_sn,v_patient_sn,v_age,v_med_cnt);
      elsif i.disease_code = 'FRLT' then
        l_obj2 := frlt_rf(p_patient_prev_svc_sn,v_age);
      elsif i.disease_code = 'CDEC' then  --IADLB
        l_obj2 := cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'IADLB');
      elsif i.disease_code = 'FDEC' then  --ADLBF
        l_obj2 := cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'ADLBF');
      end if;
      ----
      if json_ac.array_count(l_obj2) = 0 then
        l_obj2.append('None');
      end if;
      obj3.put('rf_value', l_obj2);
      --
      obj2.put('rf', obj3);
      --========
      l_obj.append(obj2.to_json_value);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      obj2 := json(); --an empty structure
      obj2.put('LBL','None');
      l_obj.append(obj2.to_json_value);
    end if;
    obj.put('MAJ_EVENT', l_obj);
    --==========DIS_ACQ_CNTRL
    l_obj := json_list(); --an empty list obj
    for i in (select nvl(prv.question,srv.disease_short_descr) disease_name
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = common_inq_pkg.patient_sn_of_pps_sn(p_patient_prev_svc_sn)
              and srv.disease_severity_code = 'AQURD'
              and srv.disease_code not in ('FRLT','OBES','ALCO')
              and prv.category_code(+) = 'BMEDH'
              )
    loop
      l_obj.append(i.disease_name);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj.put('DIS_ACQ_CNTRL', l_obj);
    --==========DIS_ACQ_AT_RISK
    l_obj := json_list(); --an empty list obj
    for i in (select disease_rpt_label(srv.disease_code,srv.disease_severity_code,to_char(nvl(prv.question,srv.disease_short_descr)),srv.dis_level_short_descr) disease_rpt_label
                     ,disease_rf_label(srv.disease_code,srv.disease_severity_code,to_char(nvl(prv.question,srv.disease_short_descr)),srv.dis_level_short_descr) disease_rf_label
                     ,srv.disease_code
                     ,srv.disease_type_code
              from svc_result_vw srv
                  ,patient_history_vw prv
              where srv.patient_sn = prv.patient_sn(+)
              and srv.disease_code = prv.disease_code(+)
              and srv.patient_sn = common_inq_pkg.patient_sn_of_pps_sn(p_patient_prev_svc_sn)
              and srv.disease_severity_code = 'EXCBT'
              and srv.disease_code not in ('OBES','ALCO')
              and prv.category_code(+) = 'BMEDH'
              order by srv.disease_type_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('LBL',i.disease_rpt_label);
      --=============rf
      obj3 := json(); --an empty structure
      obj3.put('LBL',i.disease_rf_label);
      --=============rf_value
      l_obj2 := json_list(); --an empty list obj
      --
      if i.disease_type_code = 'DISE' then
        l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'Y',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);
      elsif i.disease_type_code = 'EVNT' then
        if i.disease_code = 'STRK' then      
          l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'Y',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);
        elsif i.disease_code = 'FALL' then
          l_obj2 := fall_rf(p_patient_prev_svc_sn,v_patient_sn,v_age,v_med_cnt);
        elsif i.disease_code = 'FRLT' then
          l_obj2 := frlt_rf(p_patient_prev_svc_sn,v_age);
        elsif i.disease_code = 'CDEC' then  --IADLB
          l_obj2 := cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'IADLB');
        elsif i.disease_code = 'FDEC' then  --ADLBF
          l_obj2 := cond_triggered_resp_adl_iadl (p_patient_prev_svc_sn,'ADLBF');
        end if;
      elsif i.disease_type_code = 'DISO' then
        if i.disease_code = 'DEPR' then
          l_obj2 := cond_triggered_resp_psy(p_patient_prev_svc_sn,'GERDS');
        elsif i.disease_code = 'ANXT' then
          l_obj2 := cond_triggered_resp_psy(p_patient_prev_svc_sn,'ANXIT');
        elsif i.disease_code = 'STRS' then
          l_obj2 := cond_triggered_resp_psy(p_patient_prev_svc_sn,'HRSTS');
        elsif i.disease_code = 'SCHI' then
          l_obj2 := cond_triggered_resp_mdq(p_patient_prev_svc_sn);
        elsif i.disease_code in ('ALZH','SAPN','PARK') then
          l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'Y',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);
        end if;
      end if;
      if json_ac.array_count(l_obj2) = 0 then
        l_obj2.append('None');
      end if;
      obj3.put('rf_value', l_obj2);
      --
      obj2.put('rf', obj3);
      --=============symptom and additional RF
      obj3 := json(); --an empty structure
      obj3.put('LBL','Additional Factors Reported');
      --=============symptom_value
      l_obj2 := json_list(); --an empty list obj
      l_obj2 := disease_rf(p_patient_prev_svc_sn,i.disease_code,'N',v_bmi_result,v_bmi,v_age,v_race_code,v_gender_code,v_financial_status_code);
      --
      l_obj3 := symptom_rf(p_patient_prev_svc_sn,i.disease_code);
      if json_ac.array_count(l_obj3) <> 0 then
        for i in 1..json_ac.array_count(l_obj3) loop
          l_obj2.append(json_ac.array_get(l_obj3,i).get_string);
        end loop;
      end if;
      if json_ac.array_count(l_obj2) = 0 then
        l_obj2.append('None');
      end if;
      obj3.put('symptom_value', l_obj2);
      --
      obj2.put('symptom', obj3);
      --========
      l_obj.append(obj2.to_json_value);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      obj2 := json(); --an empty structure
      obj2.put('LBL','None');
      l_obj.append(obj2.to_json_value);
    end if;
    obj.put('DIS_ACQ_AT_RISK', l_obj);
    --==========OTR_HRA
    l_obj := json_list(); --an empty list obj
    for i in (select disease_code
                    ,disease_short_descr
                    ,dis_level_short_descr
                    ,disease_level_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'RISKA'
              and disease_type_code not in ('DISE','COND','EVNT')
              and disease_level_code <> 'LOW'
              union
              select disease_code
                    ,disease_short_descr
                    ,dis_level_short_descr
                    ,disease_level_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'EXCBT'
              and disease_code in ('OBES','ALCO')
              and disease_level_code <> 'LOW'
              )
    loop
      --'ANXT','DEPR','STRS','LONL','SCHI' diseases are covered in HRA section
      if i.disease_code = 'ALCO' then
        --There are two response will trigger Alcohol as a RF. Y09 and Y10
        if report_pkg.patient_categ_qtn_response(p_patient_prev_svc_sn,'BEHVT','1006') = 'Y09' then
          l_obj.append('Uncontrolled Alcohol Consumption (Drink more than 6 driks per week and Plans to Quit)');
        else --Y10
          l_obj.append('Uncontrolled Alcohol Consumption (Drink more than 6 driks per week and NO Plans to Quit)');
        end if;
      elsif i.disease_code = 'OBES' then
        l_obj.append(v_bmi_result||'('||v_bmi||')');
      elsif i.disease_code in ('PARK','SAPN','ALZH') then
        l_obj.append(i.dis_level_short_descr||' Risk of '||i.disease_short_descr||' disorder');
      elsif i.disease_code = 'SUIC' then
        l_obj.append('Reported at risk of Self-Harm');
      elsif i.disease_code = 'SFTY' then
        l_obj.append('Reported not wearing seat belt while riding in a car');
      elsif i.disease_code = 'MCMP' then
        l_obj.append(rx_meds_result(p_patient_prev_svc_sn,v_med_cnt));
      end if;
    end loop;
    if v_bp_result = 'Hypertension' then
      l_obj.append('Reported Hypertension ('||v_SYSTOLIC_BP_IN_MM||'/'||v_DIASTOLIC_BP_IN_MM||') during interview');
    end if;
    --Adding remarks
    for i in (select remark_note
              from patient_prev_svc_remark
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and active_flag = 'Y'
              )
    loop
      l_obj.append('Interviewer Remarks: '||i.remark_note);
    end loop;
    --
    if json_ac.array_count(l_obj) = 0 then
      --Wrong behavior
      l_obj := wrong_behav(p_patient_prev_svc_sn);
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    obj.put('OTR_HRA', l_obj);
    --===================================== end of json building
    p_out := obj.to_char;
  end report_clinical;
  --report_conclusion
  PROCEDURE report_conclusion (p_patient_prev_svc_sn in number,p_name in varchar2,p_pat_last_name in varchar2,p_em_flag in varchar2,p_CHRONIC_DISEASE_CNT in number,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
    v_para1     varchar2(1000);
  begin
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE','CONCLUSIONS');
    obj.put('hdr',obj2);
    --=======================body1
    obj2 := json(); --an empty structure
    --v_return := 'RISK WITH TWO OR MORE CHRONIC DISEASES that require a Face to Face Preventive Assessment (EM) with the Physician. There are some other important issues that needed attention. Further down is warranted and EM Preventive Assessment with the Physician.';
    obj2.put('para1','The above EBM disease HRA outcome Risk Clinical report, showed sufficient clinical evidences supporting '||p_name||' health presently appears at');
    obj2.put('para2',svc_result_title(p_patient_prev_svc_sn,p_pat_last_name,p_em_flag,p_CHRONIC_DISEASE_CNT));
    obj.put('body1',obj2);
    --=======================body2
    if p_em_flag = 'Y' then
      v_para1 := 'There are some other important issues that needed attention. Further down is warranted and EM Preventive Assessment with the Physician.';
    else --not qualify for em
      v_para1 := 'Nevertheless, physician recommend to closely look into some areas of Health concern that may impact '||p_pat_last_name||' wellbeing.';
    end if;
    --    
    obj2 := json(); --an empty structure
    obj2.put('para1',v_para1);
--    obj2.put('para1','Nevertheless, the HRA Clinical outcome reflected some');
--    obj2.put('para2','Medical Conditions');
--    obj2.put('para3','(listed above)');
--    obj2.put('para4','at RISK to be acquired and/or some wrong Modifiable Behaviors');
--    obj2.put('para5','(modifiable Risk Factors finding)');
--    obj2.put('para6','that needed your immediate attention');
--    obj2.put('para7','before impacting your future health and the safety of your well being.');
    --obj2.put('para1','');
    obj2.put('para2','');
    obj2.put('para3','');
    obj2.put('para4','');
    obj2.put('para5','');
    obj2.put('para6','');
    obj2.put('para7','');
    --
    obj.put('body2',obj2);
    --=======================body3
    obj2 := json(); --an empty structure
--    obj2.put('para1','In view of the finding in compliance with the CMS AWV/HRA regulations, the following');
--    obj2.put('para2','Personalized Prevention Plan (PPP)');
--    obj2.put('para3','and');
--    obj2.put('para4','Scheduling');
--    obj2.put('para5','has been prepared by the physician to be follow at your discretion.');

    obj2.put('para1','');
    obj2.put('para2','');
    obj2.put('para3','');
    obj2.put('para4','');
    obj2.put('para5','');


    obj.put('body3',obj2);
    --===================================== end of json building
    p_out := obj.to_char;
  end report_conclusion;
  --report_prev_plan
  PROCEDURE report_prev_plan (p_patient_prev_svc_sn in number,p_name in varchar2,p_physician_name in varchar2,p_gender_code in varchar2,p_age in number,p_bmi in number,p_bmi_result in varchar2,p_em_flag in varchar2,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_sys in number,p_dia in number,p_sugar in number,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
    v_psy_cnt   pls_integer;
    v_wrong_behav_dis_cnt pls_integer;
    v_wrong_behav_cnt pls_integer;
    v_health_event_cnt  pls_integer;
    v_other_cond_cnt  pls_integer;
    v_perfect_health boolean := true;
    v_title       varchar2(1000);
    v_sub_title1  varchar2(1000);
    v_sub_title2  varchar2(1000);
    v_sub_title3  varchar2(1000);
    v_sub_title4  varchar2(1000);
    v_footer1     varchar2(1000);
    v_physician_name varchar2(200);
    v_em_gender_txt1  varchar2(30);
  begin
    --p_em_flag is to control the title of EM reports
    if p_em_flag = 'Y' then v_title := 'PERSONALIZED PREVENTION PLAN PPP & PHYSICIAN PLAN OF CARE';
    else v_title := 'PERSONALIZED PREVENTION PLAN';
    end if;
    if p_em_flag = 'Y' then v_sub_title1 := 'To efficiently address all the';
    else v_sub_title1 := 'EVIDENCED BASE UPSTF, CDC, CMS…PREVENTATIVE RECOMMENDATIONS';
    end if;
    if p_em_flag = 'Y' then v_sub_title2 := 'COMPLEX/HIGH COMPLEX';
    else v_sub_title2 := 'Dear '||p_name||' in view of the HRA finding, the following CMS approved Recommendation are warranted by your Health Professional to avoid or retard any major Health issue that eventually may impact your Health';
    end if;
    --
    v_physician_name := p_physician_name;
    --
    if p_gender_code = 'MAL' then v_em_gender_txt1 := 'as he required';
    else v_em_gender_txt1 := 'as she required';
    end if;
    --
    if p_em_flag = 'Y' then v_sub_title3 := 'medical conditions, I the undersigned '||v_physician_name||' comprehensively assessed the Health of '||p_name||' '||v_em_gender_txt1||' and prescribed the following Preventive Plan of Care to be followed by the patient at his/her discretion to Prevent or Retard the consequence of major health exacerbation issues and or Major Health events at Severe Risk.';
    else v_sub_title3 := 'PRIMARY & SECONDARY INTERVENTIONS';
    end if;
    if p_em_flag = 'Y' then v_sub_title4 := 'PRIMARY & SECONDARY INTERVENTIONS';
    else v_sub_title4 := 'PREVENTATIVE RECOMMENDATIONS & SCHEDULING';
    end if;
    --    
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --=======================hdr
    obj2 := json(); --an empty structure
    obj2.put('TITLE',v_title);
    obj2.put('SUB_TITLE1',v_sub_title1);
    obj2.put('SUB_TITLE2',v_sub_title2);
    obj2.put('SUB_TITLE3',v_sub_title3);
    obj2.put('SUB_TITLE4',v_sub_title4);
    obj2.put('SUB_TITLE5','Targeting Beneficiary Wrong Behavioral & immunization Compliance on this Comprehensive PPP is an essential complement tool to reduce the impact of the illness or Disease on-going');
    obj2.put('SUB_TITLE6','TERTIARY INTERVENTION');
    obj2.put('SUB_TITLE7','Aims to soften the impact of an ongoing illness or injury that has lasting effects');
    obj2.put('SUB_TITLE8','Follow-up clinically warranted Rx');
    obj2.put('SUB_TITLE9','(Patient acceptance attached)');
    obj2.put('SUB_TITLE10','PREVENTATIVE RECOMMENDATIONS & SCHEDULING');
    obj.put('hdr',obj2);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('CMS','CMS Behavioral Approved Preventive services to Avoid or Retard any related Disease at Risk');
    obj2.put('USDA','USDA yearly Immunization & Clinical Test Compliance');
    obj2.put('PREV_SCHD','Additional Preventative scheduling:');
    obj2.put('LAB_TEST','LAB & TEST prescribed:');
    obj2.put('REFERRAL','Referrals:');
    obj2.put('REFERRAL1','Warranted Referrals Options approved by the Healthcare Professional');
    obj2.put('REFERRAL2','(In view of the following HRA finding, the');
    obj2.put('REFERRAL3','Referral');
    obj2.put('REFERRAL4','down below is recommended by your Physician)');
    --
    obj2.put('PAT_SEV_RISK','Patient at Severe Risk to have a major Disease(s) or Health Events:');
    obj2.put('PAT_CCM1','Patient Chronically ill at Risk');
    obj2.put('PAT_CCM2','(CHRONIC CARE MANAGEMENT)');
    obj2.put('PAT_CCCM1','Patient with High Complexity Health at Risk');
    obj2.put('PAT_CCCM2','(COMPLEX CHRONIC CARE MANAGEMENT)');
    obj2.put('DR_ACK','I '||v_physician_name||', THE UNDERSIGNED HEALTH CARE PROFESSIONAL RECOMMEND AND PRESCRIBED THE ABOVE COMPREHENSIVE PREVENTION PLAN OF CARE PERSONALIZED PREVENTION PLAN');
    obj2.put('PATIENT_ACK','I '||p_name||', THE UNDERSIGNED PATIENT AGREES TO FOLLOW THE ABOVE COMPREHENSIVE PREVENTION PLAN OF CARE PERSONALIZED PREVENTION PLAN');    
    obj2.put('DR_NAME',v_physician_name);    
    --
    obj2.put('HRA_SA','HRA Self Assessment Risk Factor');
    obj2.put('PSY_DISORDER','Your Psychosocial Disorders');
    obj2.put('HRA_BEHAV','HRA Behavioral Test Outcome');
    obj2.put('HRA_BEHAV_BP','Blood Pressure');
    obj2.put('HRA_BEHAV_CHOL','Cholesterol');
    obj2.put('HRA_BEHAV_BS','Blood Sugar');
    obj2.put('HRA_BEHAV_BMI','BMI');
    obj2.put('HRA_BEHAV_PHYSICAL','Physical Activities');
    obj2.put('HRA_BEHAV_DIET','Diet');
    obj.put('label',obj2);
    --=======================placeholder
    obj2 := json(); --an empty structure
    obj2.put('PREV_SCHD','PPP Evidenced based Preventative scheduling');
    obj2.put('LAB_TEST','LAB & TEST prescribed');
    obj2.put('REFERRAL','Referrals to Team Specialists');
    obj2.put('PAT_SEV_RISK','Major Disease(s) or Health Event');
    obj.put('placeholder',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('CMS', ppp_cms(p_patient_prev_svc_sn));
    obj2.put('USDA', ppp_usda(p_patient_prev_svc_sn,p_gender_code,p_age));
    obj2.put('REFERRAL', ppp_referral(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_sys,p_dia));
    --
    obj2.put('HRA_SA', ppp_sch_hra_sa(p_patient_prev_svc_sn));
    obj2.put('PSY_DISORDER', ppp_sch_psy_disorder(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_BP', ppp_sch_hra_behav_bp(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_CHOL', ppp_sch_hra_behav_chol(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_BS', ppp_sch_hra_behav_bs(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_BMI', ppp_sch_hra_behav_bmi(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_PHYSICAL', ppp_sch_hra_behav_physical(p_patient_prev_svc_sn));
    obj2.put('HRA_BEHAV_DIET', ppp_sch_hra_behav_diet(p_patient_prev_svc_sn));
    obj.put('label_value',obj2);
    --====================================================PPP & Scheduling=============================================
    if ppp_sch_hra_sa(p_patient_prev_svc_sn) is not null then
      v_perfect_health := false;
      obj.put('ppp_sa',ppp_sa(p_patient_prev_svc_sn));
    end if;
    --
    select count(*)
    into v_psy_cnt
    from svc_result_vw 
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code in ('ANXT','DEPR','STRS','SUIC','LONL') 
    and disease_level_code <> 'LOW'
    ;
    if v_psy_cnt > 0 then
      v_perfect_health := false;
      obj.put('ppp_psy',ppp_psy(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    --
    select count(*)
    into v_wrong_behav_cnt
    from patient_response_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and category_code = 'BEHVT'
    and risk_factor_code in ('TBCO','ALCO','INAC','WATR','SFTY')
    ;
    select count(*)
    into v_wrong_behav_dis_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code in ('HBPR','DIAB','HCHO','SAPN') 
    and disease_level_code <> 'LOW'
    ;
    if v_wrong_behav_cnt > 0 or v_wrong_behav_dis_cnt > 0 or common_inq_pkg.diet_rf_flag(p_patient_prev_svc_sn) = 'Y' or p_bmi_result <> 'Normal weight' then
      v_perfect_health := false;
      obj.put('ppp_behav',ppp_behav(p_patient_prev_svc_sn,p_bmi,p_bmi_result,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,p_sys,p_dia,p_sugar,p_age));
    end if;
    select count(*)
    into v_health_event_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code in ('STRK','FALL','FRLT') 
    and disease_level_code <> 'LOW'
    ;
    if v_health_event_cnt > 0 then
      v_perfect_health := false;
      obj.put('ppp_event',ppp_event(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt));
    end if;
    --
    select count(*)
    into v_other_cond_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_code in ('HOME','DIZI','HEAR','CDEC','FDEC') 
    and disease_level_code <> 'LOW'
    ;
    if v_other_cond_cnt > 0 then
      v_perfect_health := false;
      obj.put('ppp_cond',ppp_cond(p_patient_prev_svc_sn,p_qualify_for_em_followup_flag,p_chronic_disease_cnt,v_other_cond_cnt));
    end if;
    --
    if v_perfect_health then
      --Perfect health (no risk) statement. Using ppp_sa for this message.
      obj.put('ppp_sa',ppp_sa_no_rf(p_patient_prev_svc_sn));
    end if;
    --====================================================END OF PPP & Scheduling=============================================
    --=======================footer
    obj2 := json(); --an empty structure
    if p_gender_code = 'MAL' then
      v_footer1 := v_physician_name||' highly recommends '||p_name||' to closely follow his above Preventive Plan to achieve better health and avoid or retard major Health issues that may impact Wellbeing.';
    else
      v_footer1 := v_physician_name||' highly recommends '||p_name||' to closely follow her above Preventive Plan to achieve better health and avoid or retard major Health issues that may impact Wellbeing.';
    end if;
    obj2.put('footer1',v_footer1);
    obj.put('footer',obj2);
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);    
  end report_prev_plan;
  --
  PROCEDURE clinical_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'CLI'
      ;
    exception
      when others then p_out := null;
    end;
  end clinical_rpt;
  --This is the main clinical report
  PROCEDURE clinical_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
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
      report_hdr (i.svc_type_code,i.pat_name,i.svc_perform_date,v_out);
      v_obj := json(v_out);
      obj.put('report_hdr',v_obj);
      --==============================patient_demo
      patient_demo (null,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,i.pat_bp,i.patient_orientation,i.source_of_history,i.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,i.pat_bmi,v_out);
      v_obj := json(v_out);
      obj.put('patient_demo',v_obj);
      --==============================report_hra
      report_hra (i.patient_sn,i.patient_prev_svc_sn,i.pat_age_at_svc_perform_date,i.pat_gender,i.pat_gender_code,i.pat_race,i.pat_financial_status,i.pat_living_status,i.pat_educational_level,v_out);
      v_obj := json(v_out);
      obj.put('report_hra',v_obj);
      --==============================report_clinical
      report_clinical (i.patient_prev_svc_sn,v_out);
      v_obj := json(v_out);
      obj.put('report_clinical',v_obj);
      --==============================
      report_conclusion (i.patient_prev_svc_sn,i.pat_name,i.pat_last_name,i.qualify_for_em_followup_flag,i.CHRONIC_DISEASE_CNT,v_out);
      v_obj := json(v_out);
      obj.put('report_conclusion',v_obj);
      --==============================
      report_prev_plan (i.patient_prev_svc_sn,i.pat_name,i.pat_primary_physician_name,i.pat_gender_code,i.pat_age_at_svc_perform_date,i.bmi_num,i.pat_bmi_result,'N',i.qualify_for_em_followup_flag,i.chronic_disease_cnt,i.pat_systolic_bp_in_mm,i.pat_diastolic_bp_in_mm,i.pat_blood_sugar_level_in_mg,v_out);
      v_obj := json(v_out);
      obj.put('report_prev_plan',v_obj);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end clinical_rpt_init;
  --
  PROCEDURE patient_clinical_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'HRA'
      ;
    exception
      when others then p_out := null;
    end;
  end patient_clinical_rpt;
  --This is the main patient clinical report
  PROCEDURE patient_clinical_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
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
                    ,pat_medicare_hic_num pat_medicare_hic_num_orig
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
                    ,pat_bmi bmi_num
                    ,pat_bmi_result
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
      report_hdr (i.svc_type_code,i.pat_name,i.svc_perform_date,v_out);
      v_obj := json(v_out);
      obj.put('report_hdr',v_obj);
      --==============================patient_demo
      patient_demo (null,i.pat_gender,i.pat_medicare_hic_num_orig,i.pat_birth_date,i.pat_age,i.pat_bp,i.patient_orientation,i.source_of_history,i.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,i.pat_bmi,v_out);
      v_obj := json(v_out);
      obj.put('patient_demo',v_obj);
      --==============================report_clinical
      report_clinical (i.patient_prev_svc_sn,v_out);
      v_obj := json(v_out);
      obj.put('report_clinical',v_obj);
      --==============================
      report_conclusion (i.patient_prev_svc_sn,i.pat_name,i.pat_last_name,i.qualify_for_em_followup_flag,i.CHRONIC_DISEASE_CNT,v_out);
      v_obj := json(v_out);
      obj.put('report_conclusion',v_obj);
      --==============================
      report_prev_plan (i.patient_prev_svc_sn,i.pat_name,i.pat_primary_physician_name,i.pat_gender_code,i.pat_age_at_svc_perform_date,i.bmi_num,i.pat_bmi_result,'N',i.qualify_for_em_followup_flag,i.chronic_disease_cnt,i.pat_systolic_bp_in_mm,i.pat_diastolic_bp_in_mm,i.pat_blood_sugar_level_in_mg,v_out);
      v_obj := json(v_out);
      obj.put('report_prev_plan',v_obj);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end patient_clinical_rpt_init;  
  --
  PROCEDURE em_output_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'EEV'
      ;
    exception
      when others then p_out := null;
    end;
  end em_output_rpt;
  --This is the main em_output_rpt
  PROCEDURE em_output_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
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
                    ,CHRONIC_DISEASE_CNT
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
                    ,pat_medicare_hic_num pat_medicare_hic_num_orig
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
                      when pat_gender_code = 'MAL' then 'MR. '||pat_name
                      else 'MRS. '||pat_name
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
        report_pkg.patient_demo ('EEV',i.pat_gender,i.pat_medicare_hic_num_orig,i.pat_birth_date,i.pat_age,j.pat_bp,j.patient_orientation,j.source_of_history,j.pat_marital_status,i.svc_location_name,i.provider_physician_name_2,j.pat_bmi,v_out);
        v_obj := json(v_out);
        obj.put('patient_demo',v_obj);
        --==============================report_hra
        report_pkg.report_hra (i.patient_sn,i.parent_patient_prev_svc_sn,i.pat_age_at_svc_perform_date,i.pat_gender,i.pat_gender_code,i.pat_race,j.pat_financial_status,j.pat_living_status,j.pat_educational_level,v_out);
        v_obj := json(v_out);
        obj.put('report_hra',v_obj);
        --==============================
        report_pkg.report_prev_plan (i.parent_patient_prev_svc_sn,i.pat_name,i.provider_physician_name,i.pat_gender_code,i.pat_age_at_svc_perform_date,j.bmi_num,j.pat_bmi_result,'Y',j.qualify_for_em_followup_flag,j.chronic_disease_cnt,j.pat_systolic_bp_in_mm,j.pat_diastolic_bp_in_mm,j.pat_blood_sugar_level_in_mg,v_out);
        v_obj := json(v_out);
        obj.put('report_prev_plan',v_obj);
      end loop;
      --==============================patient_vitals
      for j in (select pem.temp_in_fahrenheit temp
                      ,pem.systolic_bp_in_mm||'/'||pem.diastolic_bp_in_mm bp
                      ,pem.pulse_rate_in_bpm pulse
                      ,pem.respiratory_rate_in_bpm resp
                      ,decode(pem.rhythm_ind,'R','regular','irregular') rhythm
                      ,nvl(pem.preventative_scheduling,'None') ppp
                      ,nvl(pem.lab_and_test_prescribed,'None') lab_and_test
                      ,nvl(pem.referrals_to_specialist,'None') referrals
                      ,case
                        when rx_prev_svc_billing_code is null then nvl(rx_maj_dis_or_health_event,'None')
                        else psbl.long_descr
                        end clinical_rx
                from physician_em pem
                    ,list_prev_svc_billing psb
                    ,prev_svc_billing_lang psbl
                where pem.rx_prev_svc_billing_code = psb.prev_svc_billing_code(+)
                and psb.prev_svc_billing_code = psbl.prev_svc_billing_code(+)
                and pem.patient_prev_svc_sn = p_patient_prev_svc_sn
                )
      loop
        --==============================patient_vitals
        report_pkg.patient_vitals (j.temp,j.bp,j.pulse,j.resp,j.rhythm,v_out);
        v_obj := json(v_out);
        obj.put('patient_vitals',v_obj);
        --==============================patient_vitals
        report_pkg.tertiary_intervention (j.ppp,j.lab_and_test,j.referrals,j.clinical_rx,v_out);
        v_obj := json(v_out);
        obj.put('tertiary_intervention',v_obj);
      end loop;
      --==============================report_clinical
      report_pkg.report_clinical (i.parent_patient_prev_svc_sn,v_out);
      v_obj := json(v_out);
      obj.put('report_clinical',v_obj);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end em_output_rpt_init;
  --
  function score_descr (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_sub_category_code in categ_score_eval.QUESTION_SUB_CATEG_CODE%type) return categ_score_eval_lang.short_descr%type
  is
    v_score categ_score_eval_lang.short_descr%type;
  begin
    select csev.score
    into v_score
    from svc_result_vw srv
        ,categ_score_eval_vw csev
    where srv.question_categ_code = csev.category_code
    and srv.disease_level_code = csev.disease_level_code
    and srv.patient_prev_svc_sn = p_patient_prev_svc_sn
    and srv.disease_code = p_disease_code
    and (p_sub_category_code is null or csev.sub_category_code = p_sub_category_code)
    ;
    return v_score;
  exception
    when others then return null;
  end score_descr;
  --
  function medication_descr (p_name in varchar2,p_quantity in varchar2,p_quantity_unit in varchar2,p_frequency in varchar2,p_purpose in varchar2,p_prescribed_med_flag in varchar2) return varchar2
  is
    v_return nvarchar2(1000);
  begin
    --name, quantity, quantity_unit and prescribed_med_flag are not null attribute
    if p_frequency is not null and p_purpose is not null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' - '||p_frequency||' ('||p_purpose||') - '||case when p_prescribed_med_flag='Y' then 'Prescribed' else 'Non Prescribed' end;
    elsif p_frequency is null and p_purpose is null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' - '||case when p_prescribed_med_flag='Y' then 'Prescribed' else 'Non Prescribed' end;
    elsif p_frequency is not null and p_purpose is null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' - '||p_frequency||' ('||case when p_prescribed_med_flag='Y' then 'Prescribed' else 'Non Prescribed' end||')';
    elsif p_frequency is null and p_purpose is not null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' ('||p_purpose||') - '||case when p_prescribed_med_flag='Y' then 'Prescribed' else 'Non Prescribed' end;
    end if;
    return v_return;
  end medication_descr;
  --Call this function only with p_prescribed_med_flag = Y
  function prescribed_medication_descr (p_name in varchar2,p_quantity in varchar2,p_quantity_unit in varchar2,p_frequency in varchar2,p_purpose in varchar2) return varchar2
  is
    v_return nvarchar2(1000);
  begin
    --name, quantity, quantity_unit and prescribed_med_flag are not null attribute
    if p_frequency is not null and p_purpose is not null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' - '||p_frequency||' ('||p_purpose||')';
    elsif p_frequency is null and p_purpose is null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit;
    elsif p_frequency is not null and p_purpose is null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' - '||p_frequency;
    elsif p_frequency is null and p_purpose is not null then
      v_return := p_name||' '|| p_quantity||' '||p_quantity_unit||' ('||p_purpose||')';
    end if;
    return v_return;
  end prescribed_medication_descr;
  --
  function disease_descr (disease_categ_code in varchar2,question_score_type_code in varchar2,disease_short_descr in varchar2,dis_level_short_descr in varchar2,dis_severity_short_descr in varchar2,dis_type_short_descr in varchar2) return varchar2
  is
    v_return nvarchar2(1000);
  begin
    if dis_severity_short_descr is null and dis_type_short_descr is null then
      if disease_categ_code = 'CVDE' then
        v_return := disease_short_descr||'(CVD) - Level '||dis_level_short_descr;
      else
        if nvl(question_score_type_code,'XX') = 'SC' then
          v_return := disease_short_descr||' - Level '||dis_level_short_descr||'(Based on Validated Clinical Test)';
        else
          v_return := disease_short_descr||' - Level '||dis_level_short_descr;
        end if;
      end if;
    else
      if disease_categ_code = 'CVDE' then
        v_return := disease_short_descr||'(CVD) - Level '||dis_level_short_descr||' - '||dis_severity_short_descr||' ('||dis_type_short_descr||')';
      else
        if nvl(question_score_type_code,'XX') = 'SC' then
          v_return := disease_short_descr||' - Level '||dis_level_short_descr||'(Based on Validated Clinical Test)'||' - '||dis_severity_short_descr||' ('||dis_type_short_descr||')';
        else
          v_return := disease_short_descr||' - Level '||dis_level_short_descr||' - '||dis_severity_short_descr||' ('||dis_type_short_descr||')';
        end if;
      end if;
    end if;
    return v_return;
  end disease_descr;
  --
  function svc_result_title (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_pat_last_name in varchar2,p_em_flag in varchar2,p_CHRONIC_DISEASE_CNT in number) return varchar2
  is
    v_return varchar2(1000);
    v_cnt pls_integer;
  begin
    --The EBM disease HRA outcome Risk Clinical report, showed sufficient clinical evidences supporting that '||p_name||' health presently appears at
    if p_em_flag = 'Y' then
      v_return := 'RISK WITH SOME CHRONIC DISEASES and MAJOR HEALTH CONCERNS that require a Face to Face Preventive Assessment (EM) with the Physician.';
    else --not qualify for em
      select count(*)
      into v_cnt
      from svc_result_vw 
      where patient_prev_svc_sn = p_patient_prev_svc_sn 
      and disease_level_code <> 'LOW'
      ;
      if v_cnt > 0 then
        v_return := 'RISK WITH SOME HEALTH CONCERNS.';
      else
        v_return := 'WITH NO MAJOR HEALTH CONCERNS.';
      end if;
    end if;
    --
    return v_return;
  end svc_result_title;
  --
  function symptom_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return t_symptom_tab PIPELINED
  is
    l_row t_symptom_obj := t_symptom_obj(null,null);
  begin
    for i in (select distinct dsv.symptom_code,dsv.symp_short_descr
              from patient_response_vw prv
                  ,(select distinct symptom_code,symp_short_descr from disease_symptom_vw where p_disease_code is null or disease_code = p_disease_code) dsv
              where prv.symptom_code = dsv.symptom_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              )                    
    loop
      l_row.symptom_code := i.symptom_code;
      l_row.symp_short_descr := i.symp_short_descr;
      --
      PIPE ROW (l_row);
    end loop;
  end symptom_fnc;
  --
  function risk_factor_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return t_risk_factor_tab PIPELINED
  is
    l_row t_risk_factor_obj := t_risk_factor_obj(null,null);
    --
    v_gender_code list_gender.gender_code%type;    
    v_ethnicity_code list_ethnicity.ethnicity_code%type;
    v_race_code list_race.race_code%type;
    v_age number(9);
    v_bmi_result varchar2(30);
    v_patient_sn number(11);
  begin
    select p.gender_code
          ,common_pkg.age_at_a_date(p.birth_date,pps.svc_perform_date)
          ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in))
          ,p.race_code
          ,p.ethnicity_code
          ,p.patient_sn
    into v_gender_code
        ,v_age
        ,v_bmi_result
        ,v_race_code
        ,v_ethnicity_code
        ,v_patient_sn
    from patient_prev_svc pps
        ,patient p
    where pps.patient_sn = p.patient_sn
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    for i in (select distinct drfv.risk_factor_code,drfv.rf_short_descr
              from patient_response_vw prv
                  ,(select distinct risk_factor_code,rf_short_descr from disease_risk_factor_vw where p_disease_code is null or disease_code = p_disease_code) drfv
              where prv.risk_factor_code = drfv.risk_factor_code
              and prv.category_code not in ('BMEDH','HSURA','HVACN','HVART','FHNMR')
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              union
              select distinct drfv.risk_factor_code,drfv.rf_short_descr
              from patient_history_vw prv --category_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR')
                  ,(select distinct risk_factor_code,rf_short_descr from disease_risk_factor_vw where p_disease_code is null or disease_code = p_disease_code) drfv
              where prv.risk_factor_code = drfv.risk_factor_code
              and prv.patient_sn = v_patient_sn                            
              )                    
    loop
      l_row.risk_factor_code := i.risk_factor_code;
      l_row.rf_short_descr := i.rf_short_descr;
      --
      PIPE ROW (l_row);
    end loop;
    --
    if v_bmi_result in ('Overweight','Obese') then
      l_row.risk_factor_code := 'OBES';
      l_row.rf_short_descr := 'Obese(Overweight)';
      PIPE ROW (l_row);
    end if;
    --
    if p_disease_code is null then
      if v_race_code in ('AIAN','ASIN','BLAK') then
        l_row.risk_factor_code := 'RACE';
        l_row.rf_short_descr := 'Race';
        PIPE ROW (l_row);
      end if;
      --
      if v_age >= 75 then
        l_row.risk_factor_code := 'AGEE';
        l_row.rf_short_descr := 'Age';
        PIPE ROW (l_row);
      end if;
    else --p_disease_code not null
      if svc_eval_pkg.race_rf(p_disease_code,v_race_code,v_ethnicity_code) <> 'LOW' then
        l_row.risk_factor_code := 'RACE';
        l_row.rf_short_descr := 'Race';
        PIPE ROW (l_row);
      end if;
      --
      if svc_eval_pkg.age_rf(p_disease_code,v_age) <> 'LOW' then
        l_row.risk_factor_code := 'AGEE';
        l_row.rf_short_descr := 'Age';
        PIPE ROW (l_row);
      end if;
      --
      if svc_eval_pkg.gender_rf(p_disease_code,v_gender_code) <> 'LOW' then
        l_row.risk_factor_code := 'GNDR';
        l_row.rf_short_descr := 'Gender';
        PIPE ROW (l_row);
      end if;
    end if;
  end risk_factor_fnc;
  --
  function svc_result_fnc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return t_svc_result_tab PIPELINED
  is
    l_row t_svc_result_obj := t_svc_result_obj(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
  begin
    for i in (select patient_prev_svc_sn
                    ,disease_code
                    ,disease_short_descr
                    ,trigger_ccm_flag
                    ,disease_level_code
                    ,dis_level_short_descr
                    ,disease_severity_code
                    ,dis_severity_short_descr
                    ,disease_long_descr
                    ,disease_type_code
                    ,dis_type_short_descr
                    ,disease_categ_code
                    ,dis_cat_short_descr
                    ,dis_cat_long_descr
                    ,question_score_type_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code in ('EXCBT','AQURD')
              union
              select patient_prev_svc_sn
                    ,disease_code
                    ,disease_short_descr
                    ,trigger_ccm_flag
                    ,disease_level_code
                    ,dis_level_short_descr
                    ,disease_severity_code
                    ,dis_severity_short_descr
                    ,disease_long_descr
                    ,disease_type_code
                    ,dis_type_short_descr
                    ,disease_categ_code
                    ,dis_cat_short_descr
                    ,dis_cat_long_descr
                    ,question_score_type_code
              from svc_result_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and disease_severity_code = 'RISKA'
              and disease_level_code in ('HIG','SEV')
              )                    
    loop
      l_row.patient_prev_svc_sn := i.patient_prev_svc_sn;
      l_row.disease_code := i.disease_code;
      l_row.disease_short_descr := i.disease_short_descr;
      l_row.trigger_ccm_flag := i.trigger_ccm_flag;
      l_row.disease_level_code := i.disease_level_code;
      l_row.dis_level_short_descr := i.dis_level_short_descr;
      l_row.disease_severity_code := i.disease_severity_code;
      l_row.dis_severity_short_descr := i.dis_severity_short_descr;
      l_row.disease_long_descr := i.disease_long_descr;
      l_row.disease_type_code := i.disease_type_code;
      l_row.dis_type_short_descr := i.dis_type_short_descr;
      l_row.disease_categ_code := i.disease_categ_code;
      l_row.dis_cat_short_descr := i.dis_cat_short_descr;
      l_row.dis_cat_long_descr := i.dis_cat_long_descr;
      l_row.question_score_type_code := i.question_score_type_code;
      --
      PIPE ROW (l_row);
    end loop;
  end svc_result_fnc;
  --Prev Plan Data
  PROCEDURE report_prev_plan (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Prevention Plan:');
    l_obj := json_list(); --an empty list obj
    for i in (select distinct ppv.prev_plan_code
                    ,ppv.prev_plan_short_descr
                    ,ppv.prev_plan_long_descr
              from risk_factor_prev_plan_vw ppv
                  ,table(report_pkg.risk_factor_fnc(p_patient_prev_svc_sn,p_disease_code)) rff
              where ppv.risk_factor_code = rff.risk_factor_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.prev_plan_short_descr);
      obj2.put('DESCR',i.prev_plan_long_descr);
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('prev_plan', l_obj);
    else
      obj2 := json(); --an empty structure
      obj2.put('NAME','No Prevention Plan Identified.');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
      obj.put('prev_plan', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end report_prev_plan;
  --Risk Factor Data
  PROCEDURE report_risk_factor (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Risk Factors:');
    l_obj := json_list(); --an empty list obj
    for i in (select risk_factor_code 
                    ,rf_short_descr
              from table(report_pkg.risk_factor_fnc(p_patient_prev_svc_sn,p_disease_code))
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.rf_short_descr);
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('risk_factor', l_obj);
    else
      obj2 := json(); --an empty structure
      obj2.put('NAME','No Fisk Factors Identified.');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
      obj.put('risk_factor', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end report_risk_factor;
  --Symptom Data
  PROCEDURE report_symptom (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Symptoms:');
    l_obj := json_list(); --an empty list obj
    for i in (select symptom_code
                    ,symp_short_descr
              from table(report_pkg.symptom_fnc(p_patient_prev_svc_sn,p_disease_code))
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.symp_short_descr);
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('symptom', l_obj);
    else
      obj2 := json(); --an empty structure
      obj2.put('NAME','No Symptom');
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
      obj.put('symptom', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end report_symptom;
  --Summary data by disease_severity
  PROCEDURE report_summary (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
    v_qualify_for_em  varchar2(1);
    v_last_name patient.last_name%type;
    v_CHRONIC_DISEASE_CNT pls_integer;
  begin
    select case
            when p.gender_code = 'MAL' then 'Mr. '||p.last_name
            else 'Mrs. '||p.last_name
            end last_name
          ,pps.QUALIFY_FOR_EM_FOLLOWUP_FLAG
          ,nvl(pps.CHRONIC_DISEASE_CNT,0)
    into v_last_name
        ,v_qualify_for_em
        ,v_CHRONIC_DISEASE_CNT
    from patient p
        ,patient_prev_svc pps
    where p.patient_sn = pps.patient_sn
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    obj := json(); --an empty structure
    obj.put('TITLE',report_pkg.svc_result_title(p_patient_prev_svc_sn,v_last_name,v_qualify_for_em,v_CHRONIC_DISEASE_CNT));
    obj.put('SUB_TITLE','Summary of Disease, Condition, Event or Disorder at Risk:');
    l_obj := json_list(); --an empty list obj
    for i in (select disease_severity_code,dis_severity_short_descr,disease_type_code,dis_type_short_descr,count(*) sev_cnt
              from table(report_pkg.svc_result_fnc(p_patient_prev_svc_sn))
              group by disease_severity_code,dis_severity_short_descr,disease_type_code,dis_type_short_descr
              order by disease_severity_code,disease_type_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.dis_severity_short_descr||' ('||i.dis_type_short_descr||')'||' - '||i.sev_cnt);
      --
      l_obj.append(obj2.to_json_value);
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('summary', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end report_summary;
  --Summary data by disease_severity
  PROCEDURE report_summary_dtl (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT varchar2)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','Detail of Disease, Condition, Event or Disorder at Risk:');
    l_obj := json_list(); --an empty list obj
    for i in (select disease_severity_code,dis_severity_short_descr,disease_type_code,dis_type_short_descr,count(*) sev_cnt
              from table(report_pkg.svc_result_fnc(p_patient_prev_svc_sn))
              group by disease_severity_code,dis_severity_short_descr,disease_type_code,dis_type_short_descr
              order by disease_severity_code,disease_type_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.dis_severity_short_descr||' ('||i.dis_type_short_descr||')'||' - '||i.sev_cnt);
      --====================================
      l_obj2 := json_list(); --an empty list obj
      for j in (select report_pkg.disease_descr(disease_categ_code,question_score_type_code,disease_short_descr,dis_level_short_descr,null,null) disease_descr
                      ,disease_long_descr
                from table(report_pkg.svc_result_fnc(p_patient_prev_svc_sn))
                where disease_severity_code = i.disease_severity_code
                and disease_type_code = i.disease_type_code
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('DISEASE',j.disease_descr);
        obj3.put('DISEASE_LONG_DESCR',j.disease_long_descr);
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('disease', l_obj2);
      end if;
      --
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('summary_dtl', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end report_summary_dtl;
  --
  PROCEDURE em_eval (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    for i in (select patient_prev_svc_sn
              from patient_prev_svc
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj := json_list(); --an empty list obj
      --================================================symptom
      for j in (select symp_short_descr
                from symptom_vw
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',j.symp_short_descr);
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('synonym', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end em_eval;
  --
  PROCEDURE ccm_eval (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    for i in (select patient_prev_svc_sn
              from patient_prev_svc
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj := json_list(); --an empty list obj
      --================================================symptom
      for j in (select symp_short_descr
                from symptom_vw
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',j.symp_short_descr);
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('synonym', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end ccm_eval;
  --
  PROCEDURE ppps (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    for i in (select patient_prev_svc_sn
              from patient_prev_svc
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj := json_list(); --an empty list obj
      --================================================symptom
      for j in (select symp_short_descr
                from symptom_vw
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',j.symp_short_descr);
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('synonym', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end ppps;
  --
  PROCEDURE clinical (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    for i in (select patient_prev_svc_sn
              from patient_prev_svc
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj := json_list(); --an empty list obj
      --================================================symptom
      for j in (select symp_short_descr
                from symptom_vw
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('NAME',j.symp_short_descr);
        l_obj.append(obj2.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj) > 0 then
        obj.put('synonym', l_obj);
      end if;
    end loop;
    --===================================== end of json building
    p_out := obj.to_char;
  end clinical;
  --
  PROCEDURE hra (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_out       varchar2(32767);
    v_obj       json;
  begin
    obj := json(); --an empty structure
    --==============================report_summary
    report_summary (p_patient_prev_svc_sn,v_out);
    v_obj := json(v_out);
    obj.put('report_summary',v_obj);
    --==============================report_summary_dtl
    report_summary_dtl (p_patient_prev_svc_sn,v_out);
    v_obj := json(v_out);
    obj.put('report_summary_dtl',v_obj);
    --==============================report_summary_dtl
    report_symptom (p_patient_prev_svc_sn,null,v_out);
    v_obj := json(v_out);
    obj.put('report_symptom',v_obj);
    --==============================report_summary_dtl
    report_risk_factor (p_patient_prev_svc_sn,null,v_out);
    v_obj := json(v_out);
    obj.put('report_risk_factor',v_obj);
    --==============================report_summary_dtl
    report_prev_plan (p_patient_prev_svc_sn,null,v_out);
    v_obj := json(v_out);
    obj.put('report_prev_plan',v_obj);
    --===================================== end of json building
    p_out := obj.to_char;
  end hra;
  --
  PROCEDURE svc_rpt_medication (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    v_rpt_obj   json;
    v_rpt_out   clob;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    l_obj := json_list(); --an empty list obj
    --
    for i in (select patient_sn
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,PHYSICIAN_NAME pat_primary_physician_name
                    ,PHYSICIAN_COMPANY PAT_PRIMARY_PHYSICIAN_COMPANY
                    ,MEDICARE_HIC_NUM pat_medicare_hic_num
                    ,upper(substr(gender,1,1)) pat_gender
                    ,name pat_name
                    ,birth_date pat_birth_date
                    ,age||'y/o' pat_age
              from patient_vw
              where patient_sn = p_patient_sn
              )
    loop
      --================================================report_hdr
      obj2 := json(); --an empty structure
      obj2.put('RPT_CODE','MED');
      obj2.put('RPT_NAME','Medication');
      obj2.put('RPT_DESCR','Patient Medication List');
      obj.put('report_hdr', obj2);
      --===============================================hdr
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.pat_name);
      obj2.put('GENDER',i.pat_gender);
      obj2.put('HIC',i.pat_medicare_hic_num);
      obj2.put('DOB',i.pat_birth_date);
      obj2.put('AGE',i.pat_age);
      obj2.put('DATE',i.current_date);
      obj.put('hdr', obj2);
      --================================================provider_info
      obj2 := json(); --an empty structure
      obj2.put('PRIMARY_PHYSICIAN_NAME',i.pat_primary_physician_name);
      obj2.put('PRIMARY_PHYSICIAN_COMPANY',i.PAT_PRIMARY_PHYSICIAN_COMPANY);
      obj.put('provider_info', obj2);
      --
      obj2 := json(); --an empty structure
      obj2.put('patient_medication',report_patient_med(p_locale,p_patient_sn));
      obj.put('report_data', obj2);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);    
  end svc_rpt_medication;
  --
  PROCEDURE patient_hx_and_meds (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob)
  as
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
      --================================================report_hdr
      obj.put('TITLE','Patient Medical History and Medication');
      obj.put('SUB_TITLE1',i.name||' ('||i.age||' y/o, '||i.gender||'), HIC: '||i.medicare_hic_num||' - '||'Physician: '||i.physician_name||' ('||i.physician_company||')');
      obj.put('MEDICATION_TITLE','Medication');
      obj.put('MEDICAL_HX_TITLE','Medical History');
      obj.put('SURGERY_HX_TITLE','History of Surgery/Allergy');
      obj.put('VACCINATION_HX_TITLE','History of Vaccination');
      obj.put('TEST_HX_TITLE','History of Various Test');
      obj.put('FAMILY_HX_TITLE','Family History');
      obj.put('patient_medication',report_patient_med_list(p_locale,p_patient_sn));
      obj.put('patient_medical_hx',patient_hx(p_patient_sn,'BMEDH'));
      obj.put('patient_surgery_hx',patient_hx(p_patient_sn,'HSURA'));
      obj.put('patient_vaccination_hx',patient_hx(p_patient_sn,'HVACN'));
      obj.put('patient_test_hx',patient_hx(p_patient_sn,'HVART'));
      obj.put('patient_family_hx',patient_hx(p_patient_sn,'FHNMR'));
    end loop;
    --===================================== end of json building
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);    
  end patient_hx_and_meds;
  --
  PROCEDURE svc_rpt (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = p_svc_rpt_type_code
      ;
    exception
      when others then p_out := null;
    end;
  end svc_rpt;
  --
  PROCEDURE svc_rpt_init (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    v_rpt_obj   json;
    v_rpt_out   clob;
    v_sig       clob;
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
                    ,CHRONIC_DISEASE_CNT
                    ,billing_code
                    ,svc_type_code
                    ,svc_type
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
                    ,upper(substr(pat_gender,1,1)) pat_gender
                    ,pat_race
                    ,pat_ethnicity
                    ,pat_marital_status
                    ,pat_working_status
                    ,pat_educational_level
                    ,pat_financial_status
                    ,pat_living_status
                    ,pat_income
                    ,pat_addr
                    ,pat_email
                    ,pat_phone
                    ,pat_name
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name2
                    ,case
                      when pat_gender_code = 'MAL' then 'he'
                      else 'she'
                      end pat_gender_text1
                    ,case
                      when pat_gender_code = 'MAL' then 'his'
                      else 'her'
                      end pat_gender_text2
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
      --==============================================report_hdr
      for j in (select srtl.svc_rpt_type_code
                      ,srtl.short_descr
                      ,srtl.long_descr
                from list_svc_rpt_type srt
                    ,svc_rpt_type_lang srtl
                where srt.svc_rpt_type_code = srtl.svc_rpt_type_code
                and srtl.lang_code = v_lang_code
                and srt.svc_rpt_type_code = p_svc_rpt_type_code
                )
      loop
        obj2 := json(); --an empty structure
        obj2.put('RPT_CODE',j.svc_rpt_type_code);
        obj2.put('RPT_NAME',j.short_descr);
        obj2.put('RPT_DESCR',j.long_descr);
        obj.put('report_hdr', obj2);
      end loop;
      --=============================================report_lbl
      obj2 := json(); --an empty structure
      obj2.put('PAT_NAME','NAME:');
      obj2.put('PAT_GENDER','GENDER:');
      obj2.put('PAT_HIC','HIC:');
      obj2.put('PAT_DOB','DOB:');
      obj2.put('PAT_AGE','AGE:');
      obj2.put('PAT_PHONE','PHONE:');
      obj2.put('PAT_EMAIL','EMAIL:');
      obj2.put('PAT_ADDR','ADDRESS:');      
      obj2.put('SVC_DATE','SERVICE DATE:');
      obj2.put('PAT_HEIGHT','HEIGHT:');
      obj2.put('PAT_WEIGHT','WEIGHT:');
      obj2.put('PAT_BMI','BMI:');
      obj2.put('PAT_BP','BP:');
      obj2.put('PROV_INFO','PROVIDER INFORMATION');
      obj2.put('PHY_NAME','PHYSICIAN NAME:');
      obj2.put('PHY_COMPANY','PHYSICIAN COMPANY:');
      obj2.put('PROV_PHY_NAME','CLINICIAN INTERVIEWER:');
      obj2.put('PROV_PHY_COMPANY','INTERVIEWER COMPANY:');
      obj2.put('LOC_NAME','LOCATION NAME:');
      obj2.put('LOC_ADDR','LOCATION ADDR:');
      obj2.put('SEARCH_BY','SEARCH BY:');
      obj2.put('SEARCH_BY_PLACEHOLDER','NAME');
      obj2.put('PAT_SIG_TITLE','Patient Signature');
      obj2.put('PAT_SIG_SUB_TITLE1',i.pat_name2||' acknowledges that '||i.pat_gender_text1||' had provided all the answers best of '||i.pat_gender_text2||' knowledge.');
      obj.put('report_lbl', obj2);
      --==============================================patient_signature
      obj2 := json(); --an empty structure
      for s in (select patient_signature
                from patient_prev_svc
                where patient_prev_svc_sn = p_patient_prev_svc_sn
                )
      loop
        obj2.put('SIGNATURE',s.patient_signature);
      end loop;
      obj.put('patient_signature', obj2);
      --==============================================report_footer
      obj2 := json(); --an empty structure
      --if i.svc_type_code = 'AWV' then
      if i.qualify_for_em_followup_flag = 'Y' then
        obj2.put('TITLE','We will work with you in managing your Chronic Diseases.');
      else
        obj2.put('TITLE','See you in an Year for your subsequent Annual Wellness Visit. Stay Healthy.');
      end if;
      obj2.put('SUB_TITLE','If you have any further question, please contact us.');
      --end if;
      obj.put('report_footer', obj2);
      --==============================================hdr
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.pat_name);
      obj2.put('GENDER',i.pat_gender);
      obj2.put('HIC',i.pat_medicare_hic_num);
      obj2.put('DOB',i.pat_birth_date);
      obj2.put('AGE',i.pat_age);
      obj2.put('DATE',i.svc_perform_date);
      obj2.put('PHONE',i.pat_phone);
      obj2.put('EMAIL',i.pat_email);
      obj2.put('ADDR',i.pat_addr);
      obj.put('hdr', obj2);
      --================================================sub_hdr
      obj2 := json(); --an empty structure
      obj2.put('HEIGHT',i.pat_height_in_ft);
      obj2.put('WEIGHT',i.pat_weight_in_lb);
      obj2.put('BMI',i.pat_bmi);
      obj2.put('BP',i.pat_bp);
      obj.put('sub_hdr', obj2);
      --================================================provider_info
      obj2 := json(); --an empty structure
      obj2.put('PRIMARY_PHYSICIAN_NAME',i.pat_primary_physician_name_2);
      obj2.put('PRIMARY_PHYSICIAN_COMPANY',i.PAT_PRIMARY_PHYSICIAN_COMPANY);
      obj2.put('PROVIDER_PHYSICIAN_NAME',i.provider_physician_name);
      obj2.put('PROVIDER_PHYSICIAN_COMPANY',i.provider_physician_company);
      obj2.put('SVC_LOCATION_NAME',i.svc_location_name);
      obj2.put('SVC_LOCATION_ADDR',i.svc_location_addr);
      obj.put('provider_info', obj2);
      --==============================================report_data
      if p_svc_rpt_type_code = 'RMK' then
        common_inq_pkg.service_remark(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      elsif p_svc_rpt_type_code = 'HRA' then
        hra(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      elsif p_svc_rpt_type_code = 'HQA' then
        report_patient_response(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      elsif p_svc_rpt_type_code = 'CLI' then
        clinical(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      elsif p_svc_rpt_type_code = 'EEV' then
        em_eval(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      elsif p_svc_rpt_type_code = 'CEV' then
        ccm_eval(p_locale,p_patient_prev_svc_sn,v_rpt_out);
      end if;
      v_rpt_obj := json(v_rpt_out);
      obj.put('report_data',v_rpt_obj);
    end loop;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end svc_rpt_init;
  --
  PROCEDURE beneficiary_rpt_menu (p_locale in varchar2,p_patient_sn in patient.patient_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    l_obj       json_list;
    l_obj2       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_pat_name varchar2(300);
    v_phy_name varchar2(300);
    v_pat_age  number(9);
  begin
    obj := json(); --an empty structure
    --=====================company
    l_obj := json_list(); --an empty list obj
    for i in (select pps.patient_prev_svc_sn
                    ,to_char(pps.svc_perform_date,'MM/DD/YYYY') svc_date
                    ,psbl.prev_svc_billing_code billing_code
                    ,psbl.short_descr billing_code_descr
                    ,pstl.short_descr svc_type
                    ,pst.prev_svc_type_code svc_type_code
                    ,psb.prev_svc_type_code||'('||psbl.short_descr||'-'||psbl.prev_svc_billing_code||')' svc_name
                    ,pps.svc_number
                    ,case 
                      when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
                      else p.first_name||' '||p.last_name
                      end pat_name
                    ,common_pkg.age(p.birth_date) pat_age
                    ,case 
                      when phy.middle_name is not null then phy.title||' '||phy.first_name||' '||phy.middle_name||' '||phy.last_name
                      else phy.title||' '||phy.first_name||' '||phy.last_name
                      end phy_name
              from patient_prev_svc pps
                  ,list_prev_svc_billing psb
                  ,prev_svc_billing_lang psbl
                  ,list_prev_svc_type pst
                  ,prev_svc_type_lang pstl
                  ,patient p
                  ,physician_svc_location psl
                  ,physician phy
              where pps.prev_svc_billing_code = psb.prev_svc_billing_code
              and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
              and psbl.lang_code = v_lang_code
              and psb.prev_svc_type_code = pst.prev_svc_type_code
              and pst.prev_svc_type_code = pstl.prev_svc_type_code
              and pstl.lang_code = v_lang_code
              and pps.patient_sn = p.patient_sn
              and pps.physician_svc_location_sn = psl.physician_svc_location_sn
              and psl.physician_sn = phy.physician_sn
              and pps.patient_sn = p_patient_sn
              and pps.svc_comp_flag = 'Y'
              and pps.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj2.put('SVC_DATE',i.svc_date);
      obj2.put('BILLING_CODE',i.billing_code);
      obj2.put('SVC_TYPE_CODE',i.svc_type_code);
      obj2.put('SVC_NAME',i.svc_name);
      --
      v_pat_name := i.pat_name;
      v_phy_name := i.phy_name;
      v_pat_age  := i.pat_age;
      --=======================================================
      l_obj2 := json_list(); --an empty list obj
      for j in (select srtl.svc_rpt_type_code
                      ,case
                        when srt.prev_svc_type_code = 'IBT' then srtl.short_descr||' - '||i.svc_number
                        else srtl.short_descr
                        end short_descr
                      ,srtl.long_descr
                from list_svc_rpt_type srt
                    ,svc_rpt_type_lang srtl
                where srt.svc_rpt_type_code = srtl.svc_rpt_type_code
                and srt.prev_svc_type_code = i.svc_type_code
                and srt.used_for_template_only_flag = 'N'
                and srtl.lang_code = v_lang_code
                order by srt.order_num
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('CODE',j.svc_rpt_type_code);
        obj3.put('NAME',j.short_descr);
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('report_name', l_obj2);
      end if;
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    obj.put('TITLE','Reports for - '||v_pat_name||'('||v_pat_age||')');
    obj.put('SUB_TITLE1','Current Physician - '||v_phy_name);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Service Name');
    obj2.put('TH2','Service Date');
    obj2.put('TH3','Report Display Below');
    obj2.put('TH4','Report Print');
    obj.put('th_label',obj2);
    --    
    if json_ac.array_count(l_obj) > 0 then
      obj.put('beneficiary_rpt_menu', l_obj);
    end if;
    --===================================== end of json building
    p_out := obj.to_char;
  end beneficiary_rpt_menu;
  --
  function user_role_patient_sn (p_user_role_id in "AspNetUserRoles".user_role_id%type) return t_number_tab PIPELINED 
  as
    l_row t_number_obj := t_number_obj(null);
  begin
    v_proc_name := upper('user_role_patient_sn');
    v_err_msg := null;
    --
    for i in (select distinct pps.patient_sn
              from patient_prev_svc pps
                  ,physician_svc_location psl
                  ,svc_location sl
                  ,user_svc_location usl
              where pps.physician_svc_location_sn = psl.physician_svc_location_sn
              and psl.svc_location_sn = sl.svc_location_sn
              and sl.svc_location_sn = usl.svc_location_sn
              and usl.user_role_id = p_user_role_id
              )
    loop
      l_row.number_code := i.patient_sn;
      PIPE ROW (l_row);
    end loop;
  end user_role_patient_sn;
  --
  PROCEDURE bene_rpt_bene_list (p_locale in varchar2,p_user_name in "AspNetUsers"."UserName"%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    obj4        json;
    l_obj       json_list;
    l_obj2      json_list;
    l_obj3      json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_role_id "AspNetRoles"."Id"%type;
    v_user_role_id "AspNetUserRoles".user_role_id%type;
    v_provider_physician_sn provider_physician.provider_physician_sn%type;
    v_patient_sn patient.patient_sn%type;
    v_ithealth_company_flag varchar2(1);
    e_invalid_user exception;
    e_invalid_user_company exception;
  begin
    v_proc_name := upper('bene_rpt_bene_list');
    v_input_str := 'p_user_name: '||p_user_name;
    --
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    begin
      select role_id
            ,user_role_id
            ,nvl(ithealth_company_flag,'X')
      into v_role_id
          ,v_user_role_id
          ,v_ithealth_company_flag
      from user_vw
      where user_name = lower(p_user_name)
      ;
    exception
      when no_data_found then
        v_role_id := null;
    end;
    common_dml_pkg.ins_user_login(v_user_role_id,v_pkg_name,v_proc_name,null,null,null,null,null);
    --
    if v_role_id is null then
      raise e_invalid_user;
    elsif v_ithealth_company_flag = 'X' then
      raise e_invalid_user_company;
    else
      --if ithealth_company_flag = 'Y' means the user is ITHHEALTH employee, else physician company.
      --For the physician (non ITHHEALTH) company user, identify qualified patient_sn and return only those patients.
      --For physician company users, there is a trigerring table name user_svc_location. Under a physician company, there could be 
      --many service location and there are options for someone just to see the patient's only under a specific location vs 
      --someone to see patient's under all the locations. If the need is to restrict a user to see only patients under a
      --specific location, then that user and specific location(s) needs to be added in the user_svc_location table. 
      --Rules are different for ITHHEALTH employee.
      --
      --There is a common rule between ITHHEALTH user vs non ITHHEALTH user. If role is service provider, then will see only the patients 
      --whose service were provided by that user.
      if v_role_id = '79F450777D2E4B6AB98FECB17974FDEB' then  --Service Provider
        select provider_physician_sn
        into v_provider_physician_sn
        from provider_physician
        where physician_user_role_id = v_user_role_id
        ;
        v_patient_sn := null; --any patient under v_provider_physician_sn
      else --not a service provider
        v_provider_physician_sn := null; --any physician
        if v_ithealth_company_flag = 'Y' then
          v_patient_sn := null; --any patient under any provider
        else --N
          --Initially setting a dummy number and later patient_sn will be derived in a table function, which will return all the patient_sn
          v_patient_sn := 999999999; --specific patient
        end if;
      end if;
    end if;
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for i in (select distinct p.patient_sn
                    --,to_char(pps.SVC_PERFORM_DATE,'MM/DD/YYYY') RPT_SVC_PERFORM_DATE
                    --,pps.SVC_PERFORM_DATE
                    ,case 
                      when ps.middle_name is not null then ps.first_name||' '||ps.middle_name||' '||ps.last_name
                      else ps.first_name||' '||ps.last_name
                      end physician
                    ,c.name physician_company
                    ,lpad(nvl(substr(p.medicare_hic_num,-5,5),'99999'),10,'x') medicare_hic_num
                    ,p.gender_code
                    ,case 
                      when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
                      else p.first_name||' '||p.last_name
                      end name
                    ,case
                      when p.old_system_flag = 'Y' then '(Old Sys)'
                      when p.old_system_flag = 'N' and medicare_ins_by_hic_flag(p.medicare_hic_num) = 'Y' then '(Med)'
                      else '(Com)'
                      end old_system_text
                    ,to_char(birth_date,'MM/DD/YYYY') dob
                    ,common_pkg.age_at_a_date(p.birth_date,nvl(pps.SVC_PERFORM_DATE,pps.svc_date)) age
              from patient_prev_svc pps
                  ,patient p
                  ,physician ps
                  ,company c
              where pps.patient_sn = p.patient_sn
              and p.physician_sn = ps.physician_sn
              and ps.company_sn = c.company_sn
              and pps.svc_comp_flag = 'Y'
              and ps.active_flag = 'Y'
              and p.active_flag = 'Y'
              and pps.active_flag = 'Y'
              and c.active_flag = 'Y'
              and (v_provider_physician_sn is null or pps.provider_physician_sn = v_provider_physician_sn)
              and (v_patient_sn is null or pps.patient_sn in (select number_code from table(report_pkg.user_role_patient_sn(v_user_role_id))))
              --order by pps.SVC_PERFORM_DATE desc
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_SN',i.patient_sn);
      obj2.put('NAME',i.NAME||' - '||i.age||' y/o'||i.old_system_text);
      obj2.put('DOB',i.DOB);
      obj2.put('HIC',i.MEDICARE_HIC_NUM);
      obj2.put('PHYSICIAN',i.PHYSICIAN);
      obj2.put('PHYSICIAN_COMPANY',i.PHYSICIAN_COMPANY);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('beneficiary_list', l_obj);
    end if;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  exception
    when e_invalid_user then
      raise_application_error(-20010,'You are not authorized for this report');
    when e_invalid_user_company then
      raise_application_error(-20011,'User company setup is incomplete.');
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20011,v_err_msg);
  end bene_rpt_bene_list;
  --
  PROCEDURE report_patient_response (p_locale in varchar2,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out OUT clob)
  as
    obj         json;
    obj2        json;
    obj3        json;
    --
    l_obj       json_list;
    l_obj2      json_list;
    v_title varchar2(200);
    v_prev_svc_billing_code list_prev_svc_billing.prev_svc_billing_code%type;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_patient_sn patient.patient_sn%type;
    v_response_data varchar2(2000);
  begin
    select psbl.short_descr||' Patient Response'
          ,psb.prev_svc_billing_code
          ,pps.patient_sn
    into v_title
        ,v_prev_svc_billing_code
        ,v_patient_sn
    from patient_prev_svc pps
        ,list_prev_svc_billing psb
        ,prev_svc_billing_lang psbl
        ,list_prev_svc_type pst
        ,prev_svc_type_lang pstl
    where pps.prev_svc_billing_code = psb.prev_svc_billing_code
    and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
    and psbl.lang_code = 'en'
    and psb.prev_svc_type_code = pst.prev_svc_type_code
    and pst.prev_svc_type_code = pstl.prev_svc_type_code
    and pstl.lang_code = 'en'
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    obj.put('TITLE',v_title);
    --
    l_obj := json_list(); --an empty list obj
    for i in (select case
                      when qc.question_categ_code = 'MOOD1' then qcgl.long_descr
                      else qcl.short_descr||' ('||qcgl.long_descr||')'
                      end question_categ_descr
                    ,qc.question_categ_code
              from svc_billing_question_categ sbqc
                  ,list_question_categ qc
                  ,question_categ_lang qcl
                  ,list_question_categ_grp qcg
                  ,question_categ_grp_lang qcgl
                  ,list_question_score_type qst
              where sbqc.prev_svc_billing_code = v_prev_svc_billing_code
              and sbqc.question_categ_code = qc.question_categ_code
              and qc.question_categ_code = qcl.question_categ_code
              and qcl.lang_code = 'en'
              and qc.question_categ_grp_code = qcg.question_categ_grp_code
              and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
              and qcgl.lang_code = 'en'
              and qc.question_score_type_code = qst.question_score_type_code
              order by sbqc.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.question_categ_descr);
      --==========================================response
      l_obj2 := json_list(); --an empty list obj
      --Data entry category BDTEN, can only have response data
      if i.question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
        for j in (select question||' ('||response||')' response
                  from patient_history_vw
                  where patient_sn = v_patient_sn
                  and category_code = i.question_categ_code
                  )
        loop
          obj3 := json(); --an empty structure
          obj3.put('NAME',j.response);
          l_obj2.append(obj3.to_json_value);
        end loop;
      else
        for j in (select case
                          when i.question_categ_code = 'BDTEN' then case when response_data is not null then question||' ('||response||' - '||response_data||')' else question||' ('||response||')' end
                          else question||' ('||response||')'
                          end response
                  from patient_response_vw
                  where patient_prev_svc_sn = p_patient_prev_svc_sn
                  and category_code = i.question_categ_code
                  )
        loop
          obj3 := json(); --an empty structure
          obj3.put('NAME',j.response);
          l_obj2.append(obj3.to_json_value);
        end loop;
      end if;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('response', l_obj2);
      else
        obj3 := json(); --an empty structure
        obj3.put('NAME','Conditional Category. This Category was not triggered by the Patient');
        --Append obj2 to the list
        l_obj2.append(obj3.to_json_value);
        obj2.put('response', l_obj2);
      end if;
      --
      l_obj.append(obj2.to_json_value);
    end loop;
    --Add custom patient information category
    -------------------patient info
    obj2 := json(); --an empty structure
    obj2.put('NAME','PATIENT DEMOGRAPHIC INFORMATION');
    obj2.put('response',patient_info(p_patient_prev_svc_sn));
    l_obj.append(obj2.to_json_value);
    ---------------------------patient medication
    obj2 := json(); --an empty structure
    obj2.put('NAME','PATIENT MEDICATION');
    obj2.put('response',patient_med_list(v_patient_sn,'Y',null));
    l_obj.append(obj2.to_json_value);
    ---------------------------patient_maj_health_concern
    begin
      select response_data
      into v_response_data
      from patient_response_vw
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and category_code = 'BDTEN'
      and question_code = '1001'
      ;
    exception
      when others then v_response_data := null;
    end;
    --
    l_obj2 := json_list(); --an empty list obj
    obj2 := json(); --an empty structure
    if v_response_data is null then
      obj2.put('NAME','None');
    else
      obj2.put('NAME',v_response_data);
    end if;
    l_obj2.append(obj2.to_json_value);
    --
    obj2 := json(); --an empty structure
    obj2.put('NAME','PATIENT MAJOR HEALTH CONCERN');
    obj2.put('response',l_obj2);
    l_obj.append(obj2.to_json_value);
    ---------------------------interviewer remark
    obj2 := json(); --an empty structure
    obj2.put('NAME','INTERVIEWER REMARK');
    obj2.put('response',patient_remark_list(p_patient_prev_svc_sn));
    l_obj.append(obj2.to_json_value);
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('category', l_obj);
    end if;
    --===================================== end of json building
    --p_out := obj.to_char;
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  exception
    when others then 
      raise_application_error(-20001,sqlerrm);
  end report_patient_response;
  --
  function patient_med_list (p_patient_sn in number,p_medication_current_flag in varchar2,p_prescribed_med_flag in varchar2) return json_list
  is
    l_obj       json_list;
    obj         json;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select report_pkg.medication_descr(name,quantity,quantity_unit,frequency,purpose,prescribed_med_flag) name
              from patient_medication_vw
              where patient_sn = p_patient_sn
              and (p_medication_current_flag is null or medication_current_flag = p_medication_current_flag)
              and (p_prescribed_med_flag is null or prescribed_med_flag = p_prescribed_med_flag)
              )
    loop
      obj := json(); --an empty structure    
      obj.put('NAME',i.name);
      l_obj.append(obj.to_json_value);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      obj := json(); --an empty structure    
      obj.put('NAME','None');
      l_obj.append(obj.to_json_value);
    end if;
    --===================================== end of json building
    return l_obj;    
  end patient_med_list;
  --
  function patient_remark_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj       json_list;
    obj         json;
  begin
    l_obj := json_list(); --an empty list obj
    for i in (select remark_note
              from patient_prev_svc_remark
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and active_flag = 'Y'
              )
    loop
      obj := json(); --an empty structure    
      obj.put('NAME',i.remark_note);
      l_obj.append(obj.to_json_value);
    end loop;
    if json_ac.array_count(l_obj) = 0 then
      obj := json(); --an empty structure    
      obj.put('NAME','None');
      l_obj.append(obj.to_json_value);
    end if;
    --===================================== end of json building
    return l_obj;    
  end patient_remark_list;
  --
  function report_patient_med (p_locale in varchar2,p_patient_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for i in (select patient_medication_sn
                    ,report_pkg.medication_descr(name,quantity,quantity_unit,frequency,purpose,prescribed_med_flag) name
              from patient_medication_vw
              where patient_sn = p_patient_sn
              and medication_current_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_MEDICATION_SN',i.patient_medication_sn);
      obj2.put('NAME',i.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    return l_obj;
  end report_patient_med;  
  --
  function report_patient_med_list (p_locale in varchar2,p_patient_sn in number) return json_list
  as
    obj         json;
    obj2        json;
    l_obj       json_list;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    obj := json(); --an empty structure
    --=====================patient
    l_obj := json_list(); --an empty list obj
    for i in (select patient_medication_sn
                    ,report_pkg.medication_descr(name,quantity,quantity_unit,frequency,purpose,prescribed_med_flag) name
              from patient_medication_vw
              where patient_sn = p_patient_sn
              and medication_current_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      --Append obj2 to the list
      l_obj.append(i.name);
    end loop;
    return l_obj;
  end report_patient_med_list;
END report_pkg;
/
show errors