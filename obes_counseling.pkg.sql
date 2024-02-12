set define off
create or replace PACKAGE obes_counseling_pkg IS
  v_pkg_name    varchar2 (30) := upper('obes_counseling_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  function mdrx_rf_for_med_categ(p_patient_prev_svc_sn in number,p_med_categ in json_list) return varchar2;
  function rf_obj (p_rf_list in json_list,p_lbl in varchar2) return json;
  function med_categ(p_med_categ_code in varchar2) return json_list;
  function mdrx_rf_list(p_patient_prev_svc_sn in number) return json_list;
  function wrong_nutrition_list(p_patient_prev_svc_sn in number) return json_list;
  function physical_inactivity_list(p_patient_prev_svc_sn in number) return json_list;
  function uncontrolled_disease_list(p_patient_prev_svc_sn in number) return json_list;
  function alco_consumption_list(p_patient_prev_svc_sn in number) return json_list;
  function smoking_habit_list(p_patient_prev_svc_sn in number) return json_list;
  function family_hx_list(p_patient_prev_svc_sn in number) return json_list;
  function hslfa_list(p_patient_prev_svc_sn in number) return json_list;
  function psysd_list(p_patient_prev_svc_sn in number) return json_list;
  function losing_weight_attitude_list(p_patient_prev_svc_sn in number) return json_list;
  function motivational_attitude_list (p_patient_prev_svc_sn in number) return json_list;
  --
  function motivational_rf_list (p_patient_prev_svc_sn in number) return json_list;
  function primary_rf_list (p_patient_prev_svc_sn in number) return json_list;
  function additional_rf_list (p_patient_prev_svc_sn in number) return json_list;
  function primary_rf_avail_flag (p_patient_prev_svc_sn in number) return varchar2;
  function additional_rf_avail_flag (p_patient_prev_svc_sn in number) return varchar2;
  function patient_rf_list (p_patient_prev_svc_sn in number) return json_list;
  function rf_counseling_list (p_patient_prev_svc_sn in number) return json_list;
  function svc_counseling_list (p_patient_prev_svc_sn in number) return json_list;
  procedure svc_counseling_rec (p_patient_prev_svc_sn in number,p_rf_counseling_categ_code in varchar2,p_compliance_flag out varchar2,p_counseling_outcome out nvarchar2);
  function report_list(p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_awv_weight in number,p_awv_height in number) return json_list;
  function svc_rf_remark_list(p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2) return json_list;
  function svc_month(p_svc_number in number) return number;
  function relative_change_of_weight(p_parent_patient_prev_svc_sn in number,p_svc_number in number,p_weight in number,p_awv_weight in number) return number;
  function weight_cng_goal_achieve_flag(p_parent_patient_prev_svc_sn in number,p_svc_number in number,p_awv_weight in number) return varchar2;
  function review_needed_flag(p_svc_number in number) return varchar2;
  procedure weight_waist_changes (p_awv_height_in_in in number,p_awv_weight_in_lb in number,p_awv_waist_in_in in number,p_current_weight_in_lb in number,p_current_waist_in_in in number,p_out out varchar2);
  function svc_rfmgr_list (p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return json_list;
  function svc_rf_remark_result_list(p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2) return json_list;
  --
  function report_hdr (p_patient_prev_svc_sn in number,p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_date in varchar2,p_height_in_in in number,p_weight_in_lb in number,p_waist_in_in in number,p_title in varchar2,p_sub_title in varchar2,p_for_rpt_flag in varchar2,p_svc_number in number) return json;
  function patient_demo (p_name in varchar2,p_gender in varchar2,p_hic in varchar2,p_dob in varchar2,p_age in number,p_bp in varchar2,p_height in varchar2,p_weight in varchar2,p_waist in varchar2,p_bmi in varchar2,p_status in varchar2,p_svc_place in varchar2,p_phy in varchar2,p_date in varchar2) return json;
  function patient_assessment(p_patient_prev_svc_sn in number,p_weight in number,p_waist in number,p_bmi in varchar2,p_weight_cng in varchar2,p_waist_cng in varchar2,p_follow_goals_flag in varchar2) return json;
  function patient_assessment_rpt(p_patient_prev_svc_sn in number,p_date in varchar2,p_counseling_month in number,p_counseling_num in number,p_interviewer in varchar2,p_weight in varchar2,p_waist in varchar2,p_bmi in varchar2,p_follow_goals_flag in varchar2) return json;
  function patient_rf (p_patient_prev_svc_sn in number) return json;
  function svc_counseling_obj (p_patient_prev_svc_sn in number) return json;
  function rf_counseling (p_patient_prev_svc_sn in number) return json;
  function ibt_report (p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_awv_weight in number,p_awv_height in number) return json;
  function goal_achievement_review (p_month_num in number,p_weight in number,p_reason_of_not_achiving_goals in varchar2) return json;
  function review_result (p_month_num in number,p_weight in number,p_review_text in varchar2,p_reason in varchar2) return json;
  function svc_rf_remark (p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_title in nvarchar2,p_subtitle in nvarchar2,p_th1_placeholder in nvarchar2,p_th2_placeholder in nvarchar2) return json;
  function svc_rf_remark_rpt (p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_title in nvarchar2,p_subtitle in nvarchar2) return json;
  function signature(p_patient_prev_svc_sn in number,p_include_counseling_txt_flag in varchar2,p_counseling_approval_txt in varchar2,p_include_signature_flag in varchar2,p_title in nvarchar2,p_sub_title1 in nvarchar2,p_sub_title2 in nvarchar2,p_sub_title3 in nvarchar2) return json;
  PROCEDURE obes_ibt_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE obes_screening_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE ibt_report_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE ibt_report_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE screening_report_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  PROCEDURE screening_report_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob);
  procedure svc_rf_remark_proc (p_locale in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_out out varchar2);
  --
  function rpt_json_clob (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in varchar2) return json;
END obes_counseling_pkg;
/
show errors
create or replace PACKAGE BODY obes_counseling_pkg IS
  function svc_counseling_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list;
    obj json;
  begin              
    for i in (select upper(rfccl.short_descr)||' ('||rfccl.long_descr||')' descr
                    ,decode(sc.compliance_flag,'Y','Yes','No') compliance_flag
                    ,sc.counseling_outcome
              from list_rf_counseling_categ rfcc
                  ,rf_counseling_categ_lang rfccl
                  ,svc_counseling sc
              where rfcc.rf_counseling_categ_code = rfccl.rf_counseling_categ_code
              and rfccl.lang_code = 'en'
              and rfcc.rf_counseling_categ_code = sc.rf_counseling_categ_code
              and sc.patient_prev_svc_sn = p_patient_prev_svc_sn
              and sc.risk_factor_code = 'OBES'
              )
    loop
      obj := json();
      l_obj2 := json_list();
      obj.put('COUNSELING_DESCR',i.descr);
      l_obj2.append('COMPLIANCE? '||i.compliance_flag);
      l_obj2.append('COUNSELING OUTCOME: '||i.counseling_outcome);
      obj.put('outcome',l_obj2);
      l_obj.append(obj.to_json_value);
    end loop;
    return l_obj;
  end svc_counseling_list;
  --
  function svc_rfmgr_list (p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case when smgr.rf_missing_goals_reason_code = '105' then to_char(rfmgr_vw.missing_goals_reason_rpt_descr||' ('||smgr.other_reason_text||')')
                      else to_char(rfmgr_vw.missing_goals_reason_rpt_descr)
                      end descr
              from rf_missing_goals_reason_vw rfmgr_vw
                  ,svc_rf_missing_goals_reason smgr
              where rfmgr_vw.rf_missing_goals_reason_code = smgr.rf_missing_goals_reason_code
              and rfmgr_vw.risk_factor_code = p_risk_factor_code
              and smgr.patient_prev_svc_sn = p_patient_prev_svc_sn
              and smgr.active_flag = 'Y'
              )
    loop
      l_obj.append(i.descr);
    end loop;
    return l_obj;
  end svc_rfmgr_list;
  --
  function svc_rfmgr_code_list (p_patient_prev_svc_sn in number,p_risk_factor_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select smgr.rf_missing_goals_reason_code code
              from rf_missing_goals_reason_vw rfmgr_vw
                  ,svc_rf_missing_goals_reason smgr
              where rfmgr_vw.rf_missing_goals_reason_code = smgr.rf_missing_goals_reason_code
              and rfmgr_vw.risk_factor_code = p_risk_factor_code
              and smgr.patient_prev_svc_sn = p_patient_prev_svc_sn
              and smgr.active_flag = 'Y'
              )
    loop
      l_obj.append(i.code);
    end loop;
    return l_obj;
  end svc_rfmgr_code_list;
  --
  function svc_rfmgr_otr_rsn(p_patient_prev_svc_sn in number) return varchar2
  is
    v_other_reason_text svc_rf_missing_goals_reason.other_reason_text%type;
  begin
    select smgr.other_reason_text
    into v_other_reason_text
    from rf_missing_goals_reason_vw rfmgr_vw
        ,svc_rf_missing_goals_reason smgr
    where rfmgr_vw.rf_missing_goals_reason_code = smgr.rf_missing_goals_reason_code
    and rfmgr_vw.risk_factor_code = 'OBES'
    and smgr.patient_prev_svc_sn = p_patient_prev_svc_sn
    and smgr.rf_missing_goals_reason_code = '105'
    ;
    return v_other_reason_text;
  exception
    when no_data_found then return null;
    when others then raise_application_error(-20001,sqlerrm);
  end svc_rfmgr_otr_rsn;
  --
  function rpt_json_clob (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in varchar2) return json
  is
    v_rpt_json json := json();
  begin
    select json(rpt_json_clob)
    into v_rpt_json
    from svc_result_rpt
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and svc_rpt_type_code = p_svc_rpt_type_code
    ;
    return v_rpt_json;
  end rpt_json_clob;
  --
  procedure weight_waist_changes (p_awv_height_in_in in number,p_awv_weight_in_lb in number,p_awv_waist_in_in in number,p_current_weight_in_lb in number,p_current_waist_in_in in number,p_out out varchar2)
  is
    obj         json;
    obj2        json;
    v_bmi       number(5,2);
    v_bmi_result varchar2(30);
  begin
    obj := json(); --an empty structure
    v_bmi := common_pkg.bmi(nvl(p_current_weight_in_lb,0),p_awv_height_in_in);
    v_bmi_result := v_bmi||'('||common_pkg.bmi_result(v_bmi)||')';
    --
    obj.put('BMI',v_bmi_result);
    obj.put('WEIGHT_CNG',(nvl(p_current_weight_in_lb,0) - nvl(p_awv_weight_in_lb,0))||' lbs');
    obj.put('WAIST_CNG',(nvl(p_current_waist_in_in,0) - nvl(p_awv_waist_in_in,p_current_waist_in_in))||' inches');
    --===================================== end of json building
    p_out := obj.to_char;
  end weight_waist_changes;
  --This goal achieve will be used with the conjunction of review needed flag
  function weight_cng_goal_achieve_flag(p_parent_patient_prev_svc_sn in number,p_svc_number in number,p_awv_weight in number) return varchar2
  is
    v_awv_weight number(9,3) := nvl(p_awv_weight,0);
    v_current_weight patient_prev_svc.weight_in_lb%type;
  begin
    select weight_in_lb
    into v_current_weight
    from patient_prev_svc
    where parent_patient_prev_svc_sn = p_parent_patient_prev_svc_sn
    and svc_number = (p_svc_number - 1)
    ;  
    if v_current_weight >= v_awv_weight then return 'N';
    else --current weight is less
      if (v_awv_weight - v_current_weight) >= svc_month(p_svc_number) then return 'Y';
      else return 'N';
      end if;
    end if;
  end weight_cng_goal_achieve_flag;
  --
  function review_needed_flag(p_svc_number in number) return varchar2
  is
  begin
    if p_svc_number in (10,14,16) then return 'Y'; --10 is begining of 4 months and 14/16 is begining of 6/7 months
    else return 'N';
    end if;
  end review_needed_flag;
  --
  function relative_change_of_weight(p_parent_patient_prev_svc_sn in number,p_svc_number in number,p_weight in number,p_awv_weight in number) return number
  is
    v_change_of_weight number(9,5);
  begin
    if p_svc_number = 1 then
      --No previous G0447 svc. Calculate Change against AWV SVC
      v_change_of_weight := nvl(p_weight,0) - nvl(p_awv_weight,0);
    else
      begin
        --Change against previous G0447 svc
        select nvl(p_weight,0) - nvl(weight_in_lb,0)
        into v_change_of_weight
        from patient_prev_svc
        where parent_patient_prev_svc_sn = p_parent_patient_prev_svc_sn
        and svc_number = p_svc_number - 1
        and prev_svc_billing_code = 'G0447'
        ;
      exception when others then return 0;
      end;
    end if;
    return v_change_of_weight;
  end relative_change_of_weight;
  --
  function svc_month(p_svc_number in number) return number
  is
  begin
    if p_svc_number between 1 and 5 then return 1;
    elsif p_svc_number between 6 and 7 then return 2;
    elsif p_svc_number between 8 and 9 then return 3;
    elsif p_svc_number between 10 and 11 then return 4;
    elsif p_svc_number between 12 and 13 then return 5;
    elsif p_svc_number between 14 and 15 then return 6;
    elsif p_svc_number = 16 then return 7;
    elsif p_svc_number = 17 then return 8;
    elsif p_svc_number = 18 then return 9;
    elsif p_svc_number = 19 then return 10;
    elsif p_svc_number = 20 then return 11;
    elsif p_svc_number between 21 and 22 then return 12;
    end if;
  end svc_month;
  --can be added any future categ
  function med_categ(p_med_categ_code in varchar2) return json_list
  is
    v_mdrx varchar2(1000);
  begin
    if p_med_categ_code = 'ADEP' then --Antidepressant
      v_mdrx := '["Ziprexa","Paxil","Zoloft","Elavil","Tofranil"]';
    elsif p_med_categ_code = 'ASEZ' then --Antiseizure meds
      v_mdrx := '["Depakote"]';
    elsif p_med_categ_code = 'DIAB' then --DM drugs
      v_mdrx := '["Diabeta","Diabinese"]';
    elsif p_med_categ_code = 'HBPR' then --HBP drugs
      v_mdrx := '["Cardura","Inderal"]';
    elsif p_med_categ_code = 'HBRN' then --Heartburn drugs
      v_mdrx := '["Prevacid","Nexium"]';
    elsif p_med_categ_code = 'STER' then --Steroid
      v_mdrx := '["Cortisone"]';
    end if;
    return json_list(v_mdrx);
  end med_categ;
  --==================================
  --This is generic and can be used for any future med categ.
  function mdrx_rf_for_med_categ(p_patient_prev_svc_sn in number,p_med_categ in json_list) return varchar2
  is
    l_obj json_list := json_list();
    v_mdrx patient_medication.name%type;
    v_str varchar2(1000) := null;
    v_cntr pls_integer := 0;
  begin
    for i in 1..json_ac.array_count(p_med_categ) loop
      v_mdrx := json_ac.array_get(p_med_categ,i).get_string;
      for j in (select pm.name
                from patient_prev_svc pps
                    ,patient p
                    ,patient_medication pm
                where pps.patient_sn = p.patient_sn
                and p.patient_sn = pm.patient_sn
                and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
                and lower(pm.name) like '%'||lower(v_mdrx)||'%'
                )
      loop
        v_cntr := v_cntr + 1;
        if v_cntr > 1 then
          v_str := v_str||','||j.name;
        else
          v_str := v_str||j.name;
        end if;
      end loop;
    end loop;
    return v_str;
  end mdrx_rf_for_med_categ;
  --==================================
  --Specific to obesity only
  function mdrx_rf_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    v_str varchar2(1000);
    v_str2 varchar2(1000);
  begin
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('ADEP'));    
    if v_str is not null then
      v_str2 := 'Antidepressant drugs ('||v_str||')';
      l_obj.append(v_str2);
    end if;
    --
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('ASEZ'));
    if v_str is not null then
      v_str2 := 'Antiseizure drugs ('||v_str||')';
      l_obj.append(v_str2);
    end if;
    --
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('DIAB'));
    if v_str is not null then
      v_str2 := 'Diabetes drugs ('||v_str||')';
      l_obj.append(v_str2);
    end if;
    --
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('HBPR'));
    if v_str is not null then
      v_str2 := 'Hypertension drugs ('||v_str||')';
      l_obj.append(v_str2);
    end if;
    --
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('HBRN'));
    if v_str is not null then
      v_str2 := 'Heartburn drugs ('||v_str||')';
      l_obj.append(v_str2);
    end if;
    --
    v_str := mdrx_rf_for_med_categ(p_patient_prev_svc_sn,med_categ('STER'));
    if v_str is not null then
      v_str2 := 'Steroid ('||v_str||')';
      l_obj.append(v_str2);
    end if;  
    return l_obj;
  end mdrx_rf_list;
  --==================================
  function wrong_nutrition_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'BEHVT'
              and risk_factor_code in ('DTSG','DTST','DTFF','DTDR')
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end wrong_nutrition_list;
  --==================================
  function physical_inactivity_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when response_code = 'N01' then question_rpt_descr||'(Sit most of the day)'
                      else question_rpt_descr||'(Don''t Sit most of the day)'
                      end question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'BEHVT'
              and risk_factor_code = 'INAC'
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end physical_inactivity_list;
  --==================================
  function uncontrolled_disease_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    for i in (select question
              from patient_history_vw
              where patient_sn = v_patient_sn
              and category_code = 'BMEDH'
              and disease_code in ('DIAB','HBPR','CHDE','CKDE','CNCR','CLDE','STRK','TDIS')
              )
    loop
      l_obj.append(i.question);
    end loop;
    return l_obj;
  end uncontrolled_disease_list;
  --==================================
  function alco_consumption_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when response_code = 'Y09' then 'Drink Heavy and Plans to Quit'
                      else 'Drink Heavy and No Plans to Quit'
                      end question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'BEHVT'
              and risk_factor_code = 'ALCO'
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end alco_consumption_list;
  --==================================
  function smoking_habit_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when response_code = 'Y06' then 'Currently Smoking and Plans to Quit'
                      else 'Currently Smoking and No Plans to Quit'
                      end question_rpt_descr
              from patient_response_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and category_code = 'BEHVT'
              and risk_factor_code = 'TBCO'
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end smoking_habit_list;
  --==================================
  function family_hx_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    v_patient_sn number(11);
  begin
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    for i in (select question||' ('||response||')' question_rpt_descr
              from patient_history_vw
              where patient_sn = v_patient_sn
              and category_code = 'FHNMR'
              and disease_code = 'OBES'
              and response_code <> 'NON'
              )
    loop
      l_obj.append(i.question_rpt_descr);
    end loop;
    return l_obj;
  end family_hx_list;
  --==================================health self assessment
  function hslfa_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    v_cnt pls_integer;
    v_patient_sn number(11);
  begin
    if (common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','FIR') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1001','POR') = 'Y') then
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1002','ALW') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1002','LFY') = 'Y' then
        if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1003','YES') = 'Y' then
          l_obj.append('Health is Fair or Poor for a long period of time and daily activities been limited due to anxiety, depression, stress or loneliness.');
        else
          l_obj.append('Health is Fair or Poor for a long period of time.');
        end if;
      elsif common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HSLFA','1003','YES') = 'Y' then
        l_obj.append('Health is Fair or Poor and daily activities been limited due to anxiety, depression, stress or loneliness.');
      else
        l_obj.append('Health is Fair or Poor.');
      end if;
    end if;
    ---------
    --History of disability
    select patient_sn
    into v_patient_sn
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;    
    select count(*)
    into v_cnt
    from patient_history_vw 
    where patient_sn = v_patient_sn
    and category_code = 'BMEDH'
    and question_code in ('1001','1002','1003','1004')
    ;
    if v_cnt > 0 then
      l_obj.append('History of disability');
    end if;
    return l_obj;
  end hslfa_list;
  --==================================phycho social disorder
  function psysd_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select case
                      when disease_severity_code = 'RISKA' then dis_level_short_descr||' Risk of '||disease_short_descr
                      else dis_level_short_descr||' '||dis_severity_short_descr||' '||disease_short_descr
                      end disease_rpt_label
              from svc_result_vw
              where disease_code in ('ANXT','DEPR','STRS')
              and disease_level_code <> 'LOW'
              and patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      l_obj.append(i.disease_rpt_label);
    end loop;
    return l_obj;
  end psysd_list;
  --==================================Beneficiary attitude toward losing weight
  function losing_weight_attitude_list(p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
  begin
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1008','NOO') = 'Y' then
      l_obj.append('Lack of interest to lose weight');
    end if;
    return l_obj;
  end losing_weight_attitude_list;
  --==================================
  function motivational_attitude_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := hslfa_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append('Health Self-Assessment');
    end if;
    --
    l_obj2 := psysd_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append('Psycho Social Disorders');
    end if;
    --
    l_obj2 := losing_weight_attitude_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append('Beneficiary attitude toward losing weight');
    end if;
    return l_obj;
  end motivational_attitude_list;
  --==================================
  --Generic list
  function rf_obj (p_rf_list in json_list,p_lbl in varchar2) return json
  is
    obj         json := json(); --an empty structure
    obj2        json := json(); --an empty structure
  begin
    obj2.put('LBL',p_lbl);
    obj2.put('rf_value', p_rf_list);
    obj.put('rf', obj2);
    return obj;
  end rf_obj;
  --==================================
  function primary_rf_avail_flag (p_patient_prev_svc_sn in number) return varchar2
  is
  begin
    if json_ac.array_count(mdrx_rf_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(wrong_nutrition_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(physical_inactivity_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(uncontrolled_disease_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(hslfa_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(psysd_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(losing_weight_attitude_list(p_patient_prev_svc_sn)) > 0 then
      return 'Y';
    else
      return 'N';
    end if;
  end primary_rf_avail_flag;
  --==================================
  function additional_rf_avail_flag (p_patient_prev_svc_sn in number) return varchar2
  is
  begin
    if json_ac.array_count(alco_consumption_list(p_patient_prev_svc_sn)) > 0 or json_ac.array_count(smoking_habit_list(p_patient_prev_svc_sn)) > 0 then
      return 'Y';
    else
      return 'N';
    end if;
  end additional_rf_avail_flag;
  --==================================
  function motivational_rf_dtl_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := hslfa_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Health Self-Assessment:').to_json_value);
    end if;
    --
    l_obj2 := psysd_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Psycho Social Disorders:').to_json_value);
    end if;
    --
    l_obj2 := losing_weight_attitude_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Beneficiary attitude toward losing weight:').to_json_value);
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end motivational_rf_dtl_list;
  --==================================
  function motivational_rf_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := motivational_attitude_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Motivational Attitude to lose weight:').to_json_value);
    end if;
    --
    l_obj2 := mdrx_rf_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Medication Associated With Weight Gain:').to_json_value);
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end motivational_rf_list;
  --==================================
  function primary_rf_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := wrong_nutrition_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Wrong Nutrition:').to_json_value);
    end if;
    --
    l_obj2 := physical_inactivity_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Physical Inactivity:').to_json_value);
    end if;
    --
    l_obj2 := alco_consumption_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Alcohol Consumption:').to_json_value);
    end if;
    --
    l_obj2 := smoking_habit_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Smoking Habit:').to_json_value);
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end primary_rf_list;
  --==================================
  function additional_rf_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := uncontrolled_disease_list(p_patient_prev_svc_sn);
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Disease Uncontrolled:').to_json_value);
    end if;
    --
    l_obj2 := family_hx_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'Family PMHx:').to_json_value);
    end if;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end additional_rf_list;
  --==================================
  function patient_rf_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    l_obj2 json_list := json_list();
  begin
    l_obj2 := motivational_rf_list(p_patient_prev_svc_sn);
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'EVIDENCED GAIN WEIGHT FACTORS').to_json_value);
    end if;
    --
    l_obj2 := primary_rf_list(p_patient_prev_svc_sn);
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'BENEFICIARY NEGATIVE BEHAVIORAL').to_json_value);
    end if;
    --
    l_obj2 := additional_rf_list(p_patient_prev_svc_sn);    
    if json_ac.array_count(l_obj2) > 0 then
      l_obj.append(rf_obj(l_obj2,'EVIDENCED PMHx LINKED WITH WEIGHT GAIN').to_json_value);
    end if;
    return l_obj;
  end patient_rf_list;
  --==================================
  procedure svc_counseling_rec (p_patient_prev_svc_sn in number,p_rf_counseling_categ_code in varchar2,p_compliance_flag out varchar2,p_counseling_outcome out nvarchar2)
  is
  begin
    for i in (select nvl(compliance_flag,'Y') compliance_flag
                    ,counseling_outcome
              from svc_counseling
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and rf_counseling_categ_code = p_rf_counseling_categ_code
              and active_flag = 'Y'
              and risk_factor_code = 'OBES'
              )
    loop
      p_compliance_flag := i.compliance_flag;
      p_counseling_outcome := i.counseling_outcome;
    end loop;
  end svc_counseling_rec;
  --==================================
  function rf_counseling_obj (p_rf_counseling_categ_code in varchar2,p_td1 in varchar2,p_td2 in varchar2,p_td2_hint in varchar2,p_td3 in varchar2,p_td4 in varchar2,p_td5 in varchar2,p_td5_placeholder in varchar2) return json
  is
    obj         json := json(); --an empty structure
  begin
    obj.put('RF_COUNSELING_CATEG_CODE',p_rf_counseling_categ_code);
    obj.put('TD1',p_td1);
    obj.put('TD2',p_td2);
    obj.put('TD2_HINT',p_td2_hint);
    obj.put('TD3',p_td3);
    obj.put('TD4',p_td4);
    obj.put('TD5',p_td5);
    obj.put('TD5_PLACEHOLDER',p_td5_placeholder);
    return obj;
  end rf_counseling_obj;
  --==================================
  function rf_counseling_list (p_patient_prev_svc_sn in number) return json_list
  is
    l_obj json_list := json_list();
    v_compliance_flag svc_counseling.compliance_flag%type;
    v_counseling_outcome svc_counseling.counseling_outcome%type;
  begin
    if json_ac.array_count(motivational_attitude_list(p_patient_prev_svc_sn)) > 0 then
      svc_counseling_rec(p_patient_prev_svc_sn,'MOTIV',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('MOTIV','Motivational Attitude','Primary Physician','Primary Physician Hint','Physician appropriate counseling',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'Any Changes on Motivational Attitude').to_json_value);
    end if;
    --
    if json_ac.array_count(mdrx_rf_list(p_patient_prev_svc_sn)) > 0 then
      svc_counseling_rec(p_patient_prev_svc_sn,'MEDRX',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('MEDRX','Medication','Primary Physician','Primary Physician Hint','Rx review & Med allergy test if necessary',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'Any Changes on Rx Meds').to_json_value);
    end if;
    --
    if json_ac.array_count(wrong_nutrition_list(p_patient_prev_svc_sn)) > 0 then
      svc_counseling_rec(p_patient_prev_svc_sn,'NUTRI',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('NUTRI','Wrong Nutrition','Dietician counseling','Dietician counseling Hint','Written Nutrition Program given to Patient',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'Any Changes of Wrong Nutrition').to_json_value);
    end if;
    --
    if json_ac.array_count(physical_inactivity_list(p_patient_prev_svc_sn)) > 0 then
      svc_counseling_rec(p_patient_prev_svc_sn,'INACT',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('INACT','Physical Inactivity','Skilled PT or Trainer','Skilled PT Hint','Activity Live training & Home Exercise Plan',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'Any Changes of Physical Inactivity').to_json_value);
    end if;
    --
    if json_ac.array_count(uncontrolled_disease_list(p_patient_prev_svc_sn)) > 0 then
      svc_counseling_rec(p_patient_prev_svc_sn,'DISEU',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('DISEU','Disease Uncontrolled','Physician EM Assessment','Physician EM Assessment Hint','Furthermore Patient may qualify for CCM',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'EM or CCM Outcome').to_json_value);
    end if;
    --
    if (json_ac.array_count(alco_consumption_list(p_patient_prev_svc_sn)) > 0) or (json_ac.array_count(family_hx_list(p_patient_prev_svc_sn)) > 0) or (json_ac.array_count(smoking_habit_list(p_patient_prev_svc_sn)) > 0) then
      svc_counseling_rec(p_patient_prev_svc_sn,'BEHAV',v_compliance_flag,v_counseling_outcome);
      l_obj.append(rf_counseling_obj('BEHAV','Behavioral Changes','Smoking, Alcohol, DNA','Smoking, Alcohol, DNA Hint','Physician appropriate counseling Referral',nvl(v_compliance_flag,'Y'),v_counseling_outcome,'Any Behavioral Changes').to_json_value);
    end if;
    return l_obj;
  end rf_counseling_list;
  --==================================
  function missing_goals_reason_list(p_risk_factor_code in varchar2) return json_list
  is
    obj         json;
    l_obj json_list := json_list();
  begin
    for i in (select rfmgr.rf_missing_goals_reason_code code
                    ,mgrl.short_descr name
              from rf_missing_goals_reason rfmgr
                  ,list_missing_goals_reason mgr
                  ,missing_goals_reason_lang mgrl
              where rfmgr.missing_goals_reason_code = mgr.missing_goals_reason_code
              and mgr.missing_goals_reason_code = mgrl.missing_goals_reason_code
              and mgrl.lang_code = 'en'
              and rfmgr.risk_factor_code = p_risk_factor_code
              )
    loop
      obj := json(); --an empty structure
      obj.put('CODE',i.code);
      obj.put('NAME',i.name);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end missing_goals_reason_list;
  --==================================
  function svc_rf_remark_list(p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2) return json_list
  is
    obj         json;
    l_obj json_list := json_list();
  begin
    for i in (select svc_risk_factor_remark_sn
                    ,remark_categ_name title
                    ,remark_note descr
              from svc_risk_factor_remark
              where patient_prev_svc_sn = p_parent_patient_prev_svc_sn
              and remark_categ_grp_code = p_remark_categ_grp_code
              and risk_factor_code = 'OBES'
              and active_flag = 'Y'
              )
    loop
      obj := json(); --an empty structure
      obj.put('SVC_RISK_FACTOR_REMARK_SN',i.svc_risk_factor_remark_sn);
      obj.put('TD1',i.title);
      obj.put('TD2',i.descr);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end svc_rf_remark_list;
  --==================================
  function svc_rf_remark_result_list(p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2) return json_list
  is
    l_obj json_list := json_list();
  begin
    for i in (select remark_categ_name||' - '||remark_note descr
              from svc_risk_factor_remark
              where patient_prev_svc_sn = p_parent_patient_prev_svc_sn
              and remark_categ_grp_code = p_remark_categ_grp_code
              and risk_factor_code = 'OBES'
              and active_flag = 'Y'
              )
    loop
      l_obj.append(i.descr);            
    end loop;
    --
    if json_ac.array_count(l_obj) = 0 then
      l_obj.append('None');
    end if;
    return l_obj;
  end svc_rf_remark_result_list;
  --==================================
  function report_list(p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_awv_weight in number,p_awv_height in number) return json_list
  is
    obj         json;
    l_obj json_list := json_list();
  begin
    for i in (select to_char(nvl(svc_perform_date,svc_date),'MM/DD/YYYY') svc_date
                    ,obes_counseling_pkg.svc_month(svc_number) svc_month
                    ,svc_number
                    ,weight_in_lb
                    ,waist_in_in
                    ,common_pkg.bmi(weight_in_lb,p_awv_height) bmi
                    ,(nvl(weight_in_lb,0) - nvl(p_awv_weight,0)) weight_change
                    ,'Report Details' rpt_dtl_label
                    ,patient_prev_svc_sn
              from patient_prev_svc
              where prev_svc_billing_code = 'G0447'
              and patient_sn = p_patient_sn
              and parent_patient_prev_svc_sn = p_parent_patient_prev_svc_sn
              and svc_comp_flag = 'Y'
              order by svc_number desc
             )
    loop
      obj := json(); --an empty structure
      obj.put('PATIENT_PREV_SVC_SN',i.patient_prev_svc_sn);
      obj.put('TD1',i.svc_date);
      obj.put('TD2',i.svc_month||' ('||i.svc_number||')');
      obj.put('TD3',i.weight_in_lb);
      obj.put('TD4',i.waist_in_in);
      obj.put('TD5',i.bmi);
      obj.put('TD6',i.weight_change);
      obj.put('TD7',i.rpt_dtl_label);
      --Append the object to the list
      l_obj.append(obj.to_json_value);            
    end loop;
    return l_obj;
  end report_list;
  ----------------------------------------------------------------
  --report_hdr
  function report_hdr (p_patient_prev_svc_sn in number,p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_date in varchar2,p_height_in_in in number,p_weight_in_lb in number,p_waist_in_in in number,p_title in varchar2,p_sub_title in varchar2,p_for_rpt_flag in varchar2,p_svc_number in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE',p_title);
    obj.put('SUB_TITLE1',p_sub_title);
    if p_for_rpt_flag = 'N' then
      obj2 := json(); --an empty structure
      obj2.put('PATIENT_PREV_SVC_SN',p_patient_prev_svc_sn);
      obj2.put('PATIENT_SN',p_patient_sn);
      obj2.put('PARENT_PATIENT_PREV_SVC_SN',p_parent_patient_prev_svc_sn);
      obj2.put('HEIGHT_IN_IN',p_height_in_in);
      obj2.put('WEIGHT_IN_LB',p_weight_in_lb);
      obj2.put('WAIST_IN_IN',p_waist_in_in);
      obj2.put('SVC_NUMBER',p_svc_number);
      obj.put('key_data',obj2);
      --=======================tab_name
      obj2 := json(); --an empty structure
      obj2.put('ASSESSMENT','TEAM ASMT');
      obj2.put('COUNSELING','COUNSELING');
      obj2.put('REVIEW','REVIEW');
      obj2.put('GOALS','GOALS');
      obj2.put('TREATMENT','TREATMENT');
      obj2.put('REFERRAL','REFERRAL');
      obj2.put('PAT_SIG','PAT SIGNATURE');
      obj2.put('PHY_SIG','PHY SIGNATURE');
      obj.put('tab_name',obj2);
    end if;
    --===================================== end of json building
    return obj;
  end report_hdr;
  --patient_demo
  function patient_demo (p_name in varchar2,p_gender in varchar2,p_hic in varchar2,p_dob in varchar2,p_age in number,p_bp in varchar2,p_height in varchar2,p_weight in varchar2,p_waist in varchar2,p_bmi in varchar2,p_status in varchar2,p_svc_place in varchar2,p_phy in varchar2,p_date in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','('||p_date||') AWV/HRA ASSESSMENT REPORT');
    obj.put('SUB_TITLE1','The clinical data contained in this medical assessment was generated by the AWV/HRA evidence base outcome performed on '||p_date);
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('NAME','PATIENT NAME:');
    obj2.put('GENDER','GENDER:');
    obj2.put('HIC','HIC:');
    obj2.put('DOB','DOB:');
    obj2.put('AGE','AGE:');
    obj2.put('BP','BP:');
    obj2.put('HEIGHT','HEIGHT:');
    obj2.put('WEIGHT','WEIGHT:');
    obj2.put('WAIST','WAIST:');
    obj2.put('BMI','BMI:');
    obj2.put('STATUS','MARITAL STATUS:');
    obj2.put('SVC_PLACE','PLACE OF SERVICE:');
    obj2.put('PHY','ATTENDING PHYSICIAN:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('NAME',p_name);
    obj2.put('GENDER',p_gender);
    obj2.put('HIC',p_hic);
    obj2.put('DOB',p_dob);
    obj2.put('AGE',p_age);
    obj2.put('BP',p_bp);
    obj2.put('HEIGHT',p_height);
    obj2.put('WEIGHT',p_weight);
    obj2.put('WAIST',p_waist);
    obj2.put('BMI',p_bmi);
    obj2.put('STATUS',p_status);
    obj2.put('SVC_PLACE',p_svc_place);
    obj2.put('PHY',p_phy);
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end patient_demo;
  --patient_assessment
  --patient_assessment(i.weight_in_lb,i.pat_waist_in_in,v_bmi,v_weight_cng,v_waist_cng));
  function patient_assessment(p_patient_prev_svc_sn in number,p_weight in number,p_waist in number,p_bmi in varchar2,p_weight_cng in varchar2,p_waist_cng in varchar2,p_follow_goals_flag in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','WEIGHT & WAIST MEASUREMENT ASSESSMENT');
    obj2.put('SUB_TITLE1','');
    obj2.put('WEIGHT','Weight:');
    obj2.put('WAIST','Waist:');
    obj2.put('DATE','Date:');
    obj2.put('BMI','BMI:');
    obj2.put('WEIGHT_CNG','Weight Change:');
    obj2.put('WAIST_CNG','Waist Change:');
    obj2.put('RF_TARGET','Since your last counseling did you follow your established Obesity Fight Plan?:');
    obj2.put('YES','Yes');
    obj2.put('NO','No');
    obj2.put('WHY','If No, Why?:');
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('DATE',to_char(sysdate,'MM/DD/YYYY'));
    obj2.put('WEIGHT',p_weight);
    obj2.put('WAIST',p_waist);
    obj2.put('BMI',p_bmi);
    obj2.put('WEIGHT_CNG',p_weight_cng);
    obj2.put('WAIST_CNG',p_waist_cng);
    obj2.put('RF_TARGET',p_follow_goals_flag);
    obj2.put('OTR_RSN',svc_rfmgr_otr_rsn(p_patient_prev_svc_sn));
    obj2.put('REASON_CODE',svc_rfmgr_code_list(p_patient_prev_svc_sn,'OBES'));
    obj.put('label_value',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('LBS','lbs');
    obj2.put('INCHES','inches');
    obj2.put('OTR_RSN','Other Reasons');
    obj.put('label_placeholder',obj2);
    --=======================missing_goals_reason_list
    l_obj := missing_goals_reason_list('OBES');
    obj.put('missing_goals_reason_list',l_obj);
    --===================================== end of json building
    return obj;
  end patient_assessment;
  --patient_assessment_rpt (for report only)
  function patient_assessment_rpt(p_patient_prev_svc_sn in number,p_date in varchar2,p_counseling_month in number,p_counseling_num in number,p_interviewer in varchar2,p_weight in varchar2,p_waist in varchar2,p_bmi in varchar2,p_follow_goals_flag in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','WEIGHT & WAIST MEASUREMENT ASSESSMENT');
    obj2.put('SUB_TITLE1','Future Placeholder');
    obj2.put('WEIGHT','WEIGHT:');
    obj2.put('WAIST','WAIST:');
    obj2.put('DATE','DATE:');
    obj2.put('BMI','BMI:');
    obj2.put('COUNSELING_MONTH_NUM','COUNSELING MONTH/NUM:');
    obj2.put('INTERVIEWER','CLINICIAN INTERVIEWER:');
    obj2.put('RF_TARGET','Patient Followed Obesity RF Therapy Targeted Goals?:');
    if p_follow_goals_flag = 'N' then
      obj2.put('REASON','Reasons Of Not Following Therapy:');
    end if;
    obj.put('label',obj2);
    --=======================label_value
    obj2 := json(); --an empty structure
    obj2.put('WEIGHT',p_weight);
    obj2.put('WAIST',p_waist);
    obj2.put('DATE',p_date);
    obj2.put('BMI',p_bmi);
    obj2.put('COUNSELING_MONTH_NUM',p_counseling_month||'/'||p_counseling_num);
    obj2.put('INTERVIEWER',p_interviewer);
    obj2.put('RF_TARGET',p_follow_goals_flag);
    if p_follow_goals_flag = 'N' then
      obj2.put('REASON',svc_rfmgr_list(p_patient_prev_svc_sn,'OBES'));
    end if;
    obj.put('label_value',obj2);
    --===================================== end of json building
    return obj;
  end patient_assessment_rpt;
  --patient_rf
  function patient_rf (p_patient_prev_svc_sn in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
    v_name varchar2(200);
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','HRA OUTCOME OF WEIGHT GAIN EVIDENCED RISK FACTORS');
    begin
      select case
          when pat_gender_code = 'MAL' then 'Mr. '||pat_name
          else 'Mrs. '||pat_name
          end pat_name
      into v_name
      from pps_simplified_vw
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
    exception
      when others then v_name := null;
    end;
    obj2.put('SUB_TITLE1',' After Physician closely reviewed the Evidence Base HRA Outcome, the following OBESITY RISK FACTORS has been identified that influenced '||v_name||' WEIGHT & WAIST INCREASING.');
    obj.put('label',obj2);
    obj.put('rf_list',patient_rf_list(p_patient_prev_svc_sn));
    --===================================== end of json building
    return obj;
  end patient_rf;
  --svc_counseling
  function svc_counseling_obj (p_patient_prev_svc_sn in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','OBESITY TARGETED RF COUNSELING');
    obj2.put('SUB_TITLE1','Patient Personalized Identified RF and Counseling');
    obj.put('label',obj2);
    obj.put('svc_counseling_list',svc_counseling_list(p_patient_prev_svc_sn));
    --===================================== end of json building
    return obj;
  end svc_counseling_obj;
  --rf_counseling
  function rf_counseling (p_patient_prev_svc_sn in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','OBESITY TARGETED RF COUNSELING');
    obj2.put('SUB_TITLE1','Patient Personalized Identified RF and Counseling');
    obj.put('label',obj2);
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Target RF');
    obj2.put('TH2','Counseling By');
    obj2.put('TH3','Description');
    obj2.put('TH4','Compliance');
    obj2.put('TH5','Counseling Outcome');
    obj.put('th_label',obj2);
    --=======================th_label_hint
    obj2 := json(); --an empty structure
    obj2.put('TH1','Target RF hint');
    obj2.put('TH2','Counseling By hint');
    obj2.put('TH3','Description hint');
    obj2.put('TH4','Compliance hint');
    obj2.put('TH5','Counseling Outcome hint');
    obj.put('th_label_hint',obj2);
    --=======================th_label
    obj.put('tr_list',rf_counseling_list(p_patient_prev_svc_sn));
    --===================================== end of json building
    return obj;
  end rf_counseling;
  --ibt_report
  function ibt_report (p_patient_sn in number,p_parent_patient_prev_svc_sn in number,p_awv_weight in number,p_awv_height in number) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','IBT COUNSELING REPORT BY DATE');
    obj2.put('SUB_TITLE1','');
    obj.put('label',obj2);    
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Service Date');
    obj2.put('TH2','Service Month (Num)');
    obj2.put('TH3','Weight (lbs)');
    obj2.put('TH4','Waist (inches)');
    obj2.put('TH5','BMI');
    obj2.put('TH6',' Weight Change (lbs)');
    obj2.put('TH7','Full Report');
    obj.put('th_label',obj2);
    --========================tr_list
    obj.put('tr_list',report_list(p_patient_sn,p_parent_patient_prev_svc_sn,p_awv_weight,p_awv_height));
    --===================================== end of json building
    return obj;
  end ibt_report;
  --goal_achievement_review
  function goal_achievement_review (p_month_num in number,p_weight in number,p_reason_of_not_achiving_goals in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE','PROGRESSIVE IBT PATIENT ACHIEVEMENTS REPORT '||p_month_num||' MONTHS REVIEW');
    obj2.put('SUB_TITLE1','Review the current goals and treatment methods.. Make necessary adjustment.');
    obj2.put('SUB_TITLE2','Patient did not achieve goals of reducing '||p_weight||' lbs of weight. Please Explain Why:');
    obj.put('label',obj2);    
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('TXT_BOX1','Please Explain Why');
    obj.put('label_placeholder',obj2);
    --=======================txt_box_value
    obj2 := json(); --an empty structure
    obj2.put('TXT_BOX1',p_reason_of_not_achiving_goals);
    obj.put('txt_box_value',obj2);
    --===================================== end of json building
    return obj;
  end goal_achievement_review;
  --
  function review_result (p_month_num in number,p_weight in number,p_review_text in varchar2,p_reason in varchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE',p_month_num||' MONTHS REVIEW RESULT');
    obj2.put('SUB_TITLE1','Below are results of the review');
    obj2.put('SUB_TITLE2',p_review_text);
    obj2.put('SUB_TITLE3',p_reason);
    obj.put('label',obj2);
    --===================================== end of json building
    return obj;
  end review_result;
  --svc_rf_remark_proc
  --This proc will be used to populate on the respective remark (treatment goals, medical treatment or referral) edit area after user create a record.
  procedure svc_rf_remark_proc (p_locale in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_out out varchar2)
  is
    obj         json;
    v_title varchar2(2000);
    v_subtitle varchar2(2000);
    v_th1_placeholder varchar2(2000);
    v_th2_placeholder varchar2(2000);
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    if p_remark_categ_grp_code = 'GOAL' then
      v_title := 'TREATMENT GOALS AND METHODS';
      v_subtitle := 'Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior';
      v_th1_placeholder := 'Goal Title';
      v_th2_placeholder := 'Goal Detail';
    elsif p_remark_categ_grp_code = 'TRET' then
      v_title := 'RECOMMENDED MEDICAL TREATMENT';
      v_subtitle := 'To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments';
      v_th1_placeholder := 'Treatment Name';
      v_th2_placeholder := 'Treatment Detail';
    elsif p_remark_categ_grp_code = 'RFRL' then
      v_title := 'RECOMMENDED REFERRAL';
      v_subtitle := 'Referral to more intensive or specialized treatment';
      v_th1_placeholder := 'Referral Name';
      v_th2_placeholder := 'Referral Detail';
    end if;
    p_out := svc_rf_remark (p_parent_patient_prev_svc_sn,p_remark_categ_grp_code,v_title,v_subtitle,v_th1_placeholder,v_th2_placeholder).to_char;
  end svc_rf_remark_proc;
  --svc_rf_remark
  function svc_rf_remark (p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_title in nvarchar2,p_subtitle in nvarchar2,p_th1_placeholder in nvarchar2,p_th2_placeholder in nvarchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE',p_title);
    obj2.put('SUB_TITLE1',p_subtitle);
    obj2.put('REMARK_CATEG_GRP_CODE',p_remark_categ_grp_code);
    obj.put('label',obj2);    
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Title');
    obj2.put('TH1_PLACEHOLDER',p_th1_placeholder);
    obj2.put('TH2','Description');
    obj2.put('TH2_PLACEHOLDER',p_th2_placeholder);
    obj.put('th_label',obj2);
    --========================tr_list
    obj.put('tr_list',svc_rf_remark_list(p_parent_patient_prev_svc_sn,p_remark_categ_grp_code));
    --===================================== end of json building
    return obj;
  end svc_rf_remark;
  --
  function svc_rf_remark_link (p_remark_categ_grp_code in varchar2,p_link_text in nvarchar2,p_title in nvarchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('LINK_TEXT',p_link_text);
    obj2.put('TITLE',p_title);
    obj2.put('REMARK_CATEG_GRP_CODE',p_remark_categ_grp_code);
    obj.put('label',obj2);    
    --===================================== end of json building
    return obj;
  end svc_rf_remark_link;
  --svc_rf_remark_rpt
  function svc_rf_remark_rpt (p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_title in nvarchar2,p_subtitle in nvarchar2) return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE',p_title);
    obj2.put('SUB_TITLE1',p_subtitle);
    obj.put('label',obj2);    
    --========================tr_list
    obj.put('remark_list',svc_rf_remark_result_list(p_parent_patient_prev_svc_sn,p_remark_categ_grp_code));
    --===================================== end of json building
    return obj;
  end svc_rf_remark_rpt;
  --signature
  function signature(p_patient_prev_svc_sn in number,p_include_counseling_txt_flag in varchar2,p_counseling_approval_txt in varchar2,p_include_signature_flag in varchar2,p_title in nvarchar2,p_sub_title1 in nvarchar2,p_sub_title2 in nvarchar2,p_sub_title3 in nvarchar2) return json
  as
    obj         json;
    obj2        json;
  begin
    obj := json(); --an empty structure
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE',p_title);
    obj2.put('SUB_TITLE1',p_sub_title1);
    obj2.put('SUB_TITLE2',p_sub_title2);
    obj2.put('SUB_TITLE3',p_sub_title3);
    if p_include_counseling_txt_flag = 'Y' then
      obj2.put('COUNSELING_APPROVAL_TXT',p_counseling_approval_txt);
      obj2.put('YES','Yes');
      obj2.put('NO','No');
    end if;
    obj.put('label',obj2);
    if p_include_signature_flag = 'Y' then
      --=======================label_value
      for i in (select patient_signature
                from patient_prev_svc
                where patient_prev_svc_sn = p_patient_prev_svc_sn
                and patient_signature is not null
                )
      loop              
        obj2 := json(); --an empty structure
        obj2.put('TITLE','Signature on File: ');
        obj2.put('PATIENT_SIGNATURE',i.patient_signature);
        obj.put('label_value',obj2);      
      end loop;
    end if;
    --===================================== end of json building
    return obj;
  end signature;
  --
  PROCEDURE obes_ibt_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_title nvarchar2(1000);
    v_sub_title1 nvarchar2(1000);
    v_sub_title2 nvarchar2(1000);
    v_sub_title3 nvarchar2(1000);
    v_hdr_title nvarchar2(1000);
    v_hdr_sub_title1 nvarchar2(1000);
    v_out varchar2(1000);
    v_weight_cng_obj json;
    tempdata      json_value;
    v_weight_cng varchar2(100);
    v_waist_cng varchar2(100);
    v_bmi varchar2(100);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,prev_svc_billing_code
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_birth_date
                    ,pat_gender
                    ,age pat_age
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb weight_in_lb
                    ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                    ,pat_waist_in_in
                    ,svc_number
                    ,svc_month(svc_number) svc_month
                    ,svc_location_name
                    ,nvl(followed_rf_therapy_goals_flag,'Y') followed_rf_therapy_goals_flag
                    ,case
                      when physician_dr_type is null then pat_primary_physician_name
                      else pat_primary_physician_name||', '||physician_dr_type
                      end pat_primary_physician_name_2
                    ,reason_of_not_achiving_goals
              from pps_simplified_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and prev_svc_billing_code = 'G0447'
              )
    loop
      --Last AWV record
      for j in (select pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                      ,svc_perform_date
                      ,pat_marital_status
                      ,qualify_for_em_followup_flag
                      ,chronic_disease_cnt
                      ,pat_height_in_in
                      ,pat_height_in_ft
                      ,pat_weight_in_lb weight_in_lb
                      ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                      ,pat_waist_in_in
                      ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                from pps_simplified_vw
                where patient_prev_svc_sn = i.parent_patient_prev_svc_sn
                )
      loop
        v_hdr_title := 'IBT (INTENSIVE BEHAVIORAL THERAPY) COUNSELING PROGRAM FOR OBESITY';
        v_hdr_sub_title1 := 'Obesity has been the subject of increasing professional attention in the past decade, including the American Medical Association’s declaration that it is a disease.1 In 2003 (and again in 2011) the U.S. Preventive Services Task Force recommended that primary care practitioners screen all adults for obesity and offer intensive behavioral counseling to affected individuals, either by providing such treatment themselves or by referral https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4443898/#BX1';
        obj.put('report_hdr',report_hdr(i.patient_prev_svc_sn,i.patient_sn,i.parent_patient_prev_svc_sn,j.svc_perform_date,j.pat_height_in_in,j.weight_in_lb,j.pat_waist_in_in,v_hdr_title,v_hdr_sub_title1,'N',i.svc_number));
        obj.put('patient_demo',patient_demo(i.pat_name,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,j.pat_bp,j.pat_height_in_ft,j.pat_weight_in_lb,j.pat_waist_in_in||' inches',j.pat_bmi,j.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,j.svc_perform_date));
        if i.weight_in_lb is not null then --data has been submitted already. Display existing data
          weight_waist_changes(j.pat_height_in_in,j.weight_in_lb,j.pat_waist_in_in,i.weight_in_lb,i.pat_waist_in_in,v_out);
          v_weight_cng_obj := json(v_out);
          --          
          if v_weight_cng_obj.exist('BMI') then
            tempdata := v_weight_cng_obj.get('BMI');
            if tempdata is not null then
              v_bmi := tempdata.get_string;
            end if;
          end if;
          if v_weight_cng_obj.exist('WEIGHT_CNG') then
            tempdata := v_weight_cng_obj.get('WEIGHT_CNG');
            if tempdata is not null then
              v_weight_cng := tempdata.get_string;
            end if;
          end if;
          if v_weight_cng_obj.exist('WAIST_CNG') then
            tempdata := v_weight_cng_obj.get('WAIST_CNG');
            if tempdata is not null then
              v_waist_cng := tempdata.get_string;
            end if;
          end if;
        end if;
        obj.put('patient_assessment',patient_assessment(i.patient_prev_svc_sn,i.weight_in_lb,i.pat_waist_in_in,v_bmi,v_weight_cng,v_waist_cng,i.followed_rf_therapy_goals_flag));
        obj.put('patient_rf',rpt_json_clob(i.parent_patient_prev_svc_sn,'ORF'));
        obj.put('rf_counseling',rf_counseling(i.parent_patient_prev_svc_sn));
        obj.put('ibt_report',ibt_report(i.patient_sn,i.parent_patient_prev_svc_sn,j.weight_in_lb,j.pat_height_in_in));
        ----If review is needed and patient has not achieved weight reduction goal then
        if review_needed_flag(i.svc_number) = 'Y' then
          if weight_cng_goal_achieve_flag(i.parent_patient_prev_svc_sn,i.svc_number,j.weight_in_lb) = 'N' then
            obj.put('goal_achievement_review',goal_achievement_review(i.svc_month,i.svc_month,i.reason_of_not_achiving_goals));
          end if;
        end if;
        --
        obj.put('treatment_goals',svc_rf_remark(i.parent_patient_prev_svc_sn,'GOAL','TREATMENT GOALS AND METHODS','Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior','Goal Title','Goal Detail'));
        obj.put('medical_treatment',svc_rf_remark(i.parent_patient_prev_svc_sn,'TRET','RECOMMENDED MEDICAL TREATMENT','To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments','Treatment Name','Treatment Detail'));
        obj.put('referral',svc_rf_remark(i.parent_patient_prev_svc_sn,'RFRL','RECOMMENDED REFERRAL','Referral to more intensive or specialized treatment','Referral Name','Referral Detail'));
        --
        v_title := 'PATIENT SIGNATURE';
        v_sub_title1 := 'UNDERSIGNED PATIENT ACCEPT AND UNDERSTAND IBT THERAPY COUNSELING RECOMMENDED BY '||i.pat_primary_physician_name_2;
        v_sub_title2 := 'Sign Above';
        v_sub_title3 := 'Print Name: '||i.pat_name||' Date: '||i.current_date;
        obj.put('patient_signature',signature(i.patient_prev_svc_sn,'N',null,'Y',v_title,v_sub_title1,v_sub_title2,v_sub_title3));
        --
        v_title := 'HEALTH PROFESSIONAL SIGNATURE';
        v_sub_title1 := 'UNDERSIGNED HEALTH CARE PROFESSIONAL PERFORMED THE ABOVE IBT THERAPY COUNSELING UNDER '||i.pat_primary_physician_name_2||' SUPERVISION';
        v_sub_title2 := 'Sign Above';
        v_sub_title3 := 'Print Name: '||i.pat_primary_physician_name_2||' Date: '||i.current_date;
        obj.put('physician_signature',signature(i.patient_prev_svc_sn,'N',null,'N',v_title,v_sub_title1,v_sub_title2,v_sub_title3));
      end loop;
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end obes_ibt_template_data;
  --  
  PROCEDURE obes_screening_template_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  is
    obj         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_title nvarchar2(1000);
    v_sub_title1 nvarchar2(1000);
    v_sub_title2 nvarchar2(1000);
    v_sub_title3 nvarchar2(1000);
    v_hdr_title nvarchar2(1000);
    v_hdr_sub_title1 nvarchar2(1000);
    v_out varchar2(1000);
    v_weight_cng_obj json;
    tempdata      json_value;
    v_weight_cng varchar2(100);
    v_waist_cng varchar2(100);
    v_bmi varchar2(100);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,prev_svc_billing_code
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_birth_date
                    ,pat_gender
                    ,age pat_age
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb weight_in_lb
                    ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                    ,pat_waist_in_in
                    ,svc_number
                    ,svc_month(svc_number) svc_month
                    ,svc_location_name
                    ,nvl(followed_rf_therapy_goals_flag,'Y') followed_rf_therapy_goals_flag
                    ,case
                      when physician_dr_type is null then pat_primary_physician_name
                      else pat_primary_physician_name||', '||physician_dr_type
                      end pat_primary_physician_name_2
                    ,reason_of_not_achiving_goals
              from pps_simplified_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and prev_svc_billing_code = 'G0449'
              )
    loop
      --Last AWV record
      for j in (select pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                      ,svc_perform_date
                      ,pat_marital_status
                      ,qualify_for_em_followup_flag
                      ,chronic_disease_cnt
                      ,pat_height_in_in
                      ,pat_height_in_ft
                      ,pat_weight_in_lb weight_in_lb
                      ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                      ,pat_waist_in_in
                      ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                from pps_simplified_vw
                where patient_prev_svc_sn = i.parent_patient_prev_svc_sn
                )
      loop
        v_hdr_title := 'OBESITY SCREENING';
        v_hdr_sub_title1 := 'Obesity has been the subject of increasing professional attention in the past decade, including the American Medical Association’s declaration that it is a disease.1 In 2003 (and again in 2011) the U.S. Preventive Services Task Force recommended that primary care practitioners screen all adults for obesity and offer intensive behavioral counseling to affected individuals, either by providing such treatment themselves or by referral https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4443898/#BX1';
        obj.put('report_hdr',report_hdr(i.patient_prev_svc_sn,i.patient_sn,i.parent_patient_prev_svc_sn,j.svc_perform_date,j.pat_height_in_in,j.weight_in_lb,j.pat_waist_in_in,v_hdr_title,v_hdr_sub_title1,'N',i.svc_number));
        obj.put('patient_demo',patient_demo(i.pat_name,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,j.pat_bp,j.pat_height_in_ft,j.pat_weight_in_lb,j.pat_waist_in_in||' inches',j.pat_bmi,j.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,j.svc_perform_date));
        if i.weight_in_lb is not null then --data has been submitted already. Display existing data
          weight_waist_changes(j.pat_height_in_in,j.weight_in_lb,j.pat_waist_in_in,i.weight_in_lb,i.pat_waist_in_in,v_out);
          v_weight_cng_obj := json(v_out);
          --          
          if v_weight_cng_obj.exist('BMI') then
            tempdata := v_weight_cng_obj.get('BMI');
            if tempdata is not null then
              v_bmi := tempdata.get_string;
            end if;
          end if;
          if v_weight_cng_obj.exist('WEIGHT_CNG') then
            tempdata := v_weight_cng_obj.get('WEIGHT_CNG');
            if tempdata is not null then
              v_weight_cng := tempdata.get_string;
            end if;
          end if;
          if v_weight_cng_obj.exist('WAIST_CNG') then
            tempdata := v_weight_cng_obj.get('WAIST_CNG');
            if tempdata is not null then
              v_waist_cng := tempdata.get_string;
            end if;
          end if;
        end if;
        obj.put('patient_assessment',patient_assessment(i.patient_prev_svc_sn,i.weight_in_lb,i.pat_waist_in_in,v_bmi,v_weight_cng,v_waist_cng,i.followed_rf_therapy_goals_flag));
        obj.put('patient_rf',rpt_json_clob(i.parent_patient_prev_svc_sn,'ORF'));
        obj.put('rf_counseling',rf_counseling(i.parent_patient_prev_svc_sn));
        obj.put('ibt_report',ibt_report(i.patient_sn,i.parent_patient_prev_svc_sn,j.weight_in_lb,j.pat_height_in_in));
        ----If review is needed and patient has not achieved weight reduction goal then
        if review_needed_flag(i.svc_number) = 'Y' then
          if weight_cng_goal_achieve_flag(i.parent_patient_prev_svc_sn,i.svc_number,j.weight_in_lb) = 'N' then
            obj.put('goal_achievement_review',goal_achievement_review(i.svc_month,i.svc_month,i.reason_of_not_achiving_goals));
          end if;
        end if;
        --
        obj.put('treatment_goals',svc_rf_remark(i.parent_patient_prev_svc_sn,'GOAL','TREATMENT GOALS AND METHODS','Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior','Goal Title','Goal Detail'));
        obj.put('medical_treatment',svc_rf_remark(i.parent_patient_prev_svc_sn,'TRET','RECOMMENDED MEDICAL TREATMENT','To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments','Treatment Name','Treatment Detail'));
        obj.put('referral',svc_rf_remark(i.parent_patient_prev_svc_sn,'RFRL','RECOMMENDED REFERRAL','Referral to more intensive or specialized treatment','Referral Name','Referral Detail'));
        --
        v_title := 'PATIENT SIGNATURE';
        v_sub_title1 := 'UNDERSIGNED PATIENT ACCEPT AND UNDERSTAND IBT THERAPY COUNSELING RECOMMENDED BY '||i.pat_primary_physician_name_2;
        v_sub_title2 := 'Sign Above';
        v_sub_title3 := 'Print Name: '||i.pat_name||' Date: '||i.current_date;
        obj.put('patient_signature',signature(i.patient_prev_svc_sn,'N',null,'Y',v_title,v_sub_title1,v_sub_title2,v_sub_title3));
        --
        v_title := 'HEALTH PROFESSIONAL SIGNATURE';
        v_sub_title1 := 'UNDERSIGNED HEALTH CARE PROFESSIONAL PERFORMED THE ABOVE IBT THERAPY COUNSELING UNDER '||i.pat_primary_physician_name_2||' SUPERVISION';
        v_sub_title2 := 'Sign Above';
        v_sub_title3 := 'Print Name: '||i.pat_primary_physician_name_2||' Date: '||i.current_date;
        obj.put('physician_signature',signature(i.patient_prev_svc_sn,'Y','Approve 22 Session Obesity Counseling?:','N',v_title,v_sub_title1,v_sub_title2,v_sub_title3));
      end loop;
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end obes_screening_template_data;
  --
  PROCEDURE ibt_report_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'OEV'
      ;
      --ibt_report_data_init (p_locale,p_patient_prev_svc_sn,p_out);
    exception
      when others then p_out := null;
    end;
  end ibt_report_data;
  --
  PROCEDURE ibt_report_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  is
    obj         json;
    obj2         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_review_text varchar2(1000);
    v_sub_title nvarchar2(1000);
    v_bmi varchar2(30);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,prev_svc_billing_code
                    ,svc_perform_date
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_birth_date
                    ,pat_gender
                    ,age pat_age
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb weight_in_lb
                    ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                    ,pat_waist_in_in
                    ,svc_number
                    ,svc_month(svc_number) svc_month
                    ,svc_location_name
                    ,case
                      when physician_dr_type is null then pat_primary_physician_name
                      else pat_primary_physician_name||', '||physician_dr_type
                      end pat_primary_physician_name_2
                    ,case
                      when provider_dr_type is null then provider_physician_name
                      else provider_physician_name||', '||provider_dr_type
                      end provider_physician_name_2
                    ,followed_rf_therapy_goals_flag
                    ,goals_achived_flag
                    ,reason_of_not_achiving_goals
              from pps_simplified_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and prev_svc_billing_code = 'G0447'
              and completed_flag = 'Y'
              )
    loop
      --Last AWV record
      for j in (select pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                      ,svc_perform_date
                      ,pat_marital_status
                      ,qualify_for_em_followup_flag
                      ,chronic_disease_cnt
                      ,pat_height_in_in
                      ,pat_height_in_ft
                      ,pat_weight_in_lb weight_in_lb
                      ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                      ,pat_waist_in_in
                      ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                from pps_simplified_vw
                where patient_prev_svc_sn = i.parent_patient_prev_svc_sn
                )
      loop
        obj.put('report_hdr',report_hdr(i.patient_prev_svc_sn,i.patient_sn,i.parent_patient_prev_svc_sn,i.svc_perform_date,j.pat_height_in_in,i.weight_in_lb,j.pat_waist_in_in,'OBESITY COUNSELING (IBT) OUTCOME','THE CLINICAL DATA CONTAINED IN THIS ASSESSMENT WAS GENERATED BY THE OBESITY COUNSELING OUTCOME PERFORMED ON','Y',i.svc_number));
        obj.put('patient_demo',patient_demo(i.pat_name,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,j.pat_bp,j.pat_height_in_ft,j.pat_weight_in_lb,j.pat_waist_in_in||' inches',j.pat_bmi,j.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,j.svc_perform_date));
        --
        v_bmi := common_pkg.bmi(i.weight_in_lb,j.pat_height_in_in)||'('||common_pkg.bmi_result(common_pkg.bmi(i.weight_in_lb,j.pat_height_in_in))||')';
        obj.put('patient_assessment',patient_assessment_rpt(i.patient_prev_svc_sn,i.svc_perform_date,i.svc_month,i.svc_number,i.provider_physician_name_2,i.pat_weight_in_lb,i.pat_waist_in_in||' inches',v_bmi,i.followed_rf_therapy_goals_flag));
        obj.put('patient_rf',rpt_json_clob(i.parent_patient_prev_svc_sn,'ORF'));
        obj.put('svc_counseling',svc_counseling_obj(i.parent_patient_prev_svc_sn));
        if review_needed_flag(i.svc_number) = 'Y' then
          if i.goals_achived_flag = 'N' then
            v_review_text := 'Patient did not achieve goals of reducing '||i.svc_month||' lbs of weight. Below are the reasons:';
          else
            v_review_text := 'Patient did achieve goals of reducing '||i.svc_month||' lbs of weight.';
          end if;
          obj.put('review_result',review_result(i.svc_month,i.svc_month,v_review_text,i.reason_of_not_achiving_goals));
        end if;
        obj.put('treatment_goals',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'GOAL','TREATMENT GOALS AND METHODS','Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior'));
        obj.put('medical_treatment',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'TRET','RECOMMENDED MEDICAL TREATMENT','To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments'));
        obj.put('referral',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'RFRL','RECOMMENDED REFERRAL','Referral to more intensive or specialized treatment'));
        --==============================================patient_signature
        obj2 := json(); --an empty structure
        for s in (select patient_signature
                        ,physician_signature
                  from patient_prev_svc
                  where patient_prev_svc_sn = p_patient_prev_svc_sn
                  )
        loop
          obj2.put('PATIENT_SIGNATURE_TITLE','PATIENT SIGNATURE');
          v_sub_title := 'Name: '||i.pat_name||' Date: '||i.svc_perform_date;
          obj2.put('PATIENT_SIGNATURE_SUBTITLE',v_sub_title);
          obj2.put('PATIENT_SIGNATURE',s.patient_signature);
          --
          obj2.put('PHYSICIAN_SIGNATURE_TITLE','HEALTH PROFESSIONAL SIGNATURE');
          v_sub_title := 'Name: '||i.pat_primary_physician_name_2||' Date: '||i.svc_perform_date;
          obj2.put('PHYSICIAN_SIGNATURE_SUBTITLE',v_sub_title);
          obj2.put('PHYSICIAN_SIGNATURE',s.physician_signature);
        end loop;
        obj.put('signature', obj2);
      end loop;
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end ibt_report_data_init;
  --
  PROCEDURE screening_report_data (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  as
  begin
    begin
      select rpt_json_clob
      into p_out
      from svc_result_rpt
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      and svc_rpt_type_code = 'OSC'
      ;
      --screening_report_data_init (p_locale,p_patient_prev_svc_sn,p_out);
    exception
      when others then p_out := null;
    end;
  end screening_report_data;
  --
  PROCEDURE screening_report_data_init (p_locale in varchar2,p_patient_prev_svc_sn in number,p_out OUT clob)
  is
    obj         json;
    obj2         json;
    v_lang_code list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
    v_review_text varchar2(1000);
    v_sub_title nvarchar2(1000);
    v_bmi varchar2(30);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --
    for i in (select patient_prev_svc_sn
                    ,patient_sn
                    ,parent_patient_prev_svc_sn
                    ,prev_svc_billing_code
                    ,svc_perform_date
                    ,to_char(sysdate,'MM/DD/YY') current_date
                    ,case
                      when pat_gender_code = 'MAL' then 'Mr. '||pat_name
                      else 'Mrs. '||pat_name
                      end pat_name
                    ,pat_birth_date
                    ,pat_gender
                    ,age pat_age
                    ,lpad(nvl(substr(pat_medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
                    ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                    ,pat_height_in_ft
                    ,pat_weight_in_lb weight_in_lb
                    ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                    ,pat_waist_in_in
                    ,svc_number
                    ,svc_month(svc_number) svc_month
                    ,svc_location_name
                    ,case
                      when physician_dr_type is null then pat_primary_physician_name
                      else pat_primary_physician_name||', '||physician_dr_type
                      end pat_primary_physician_name_2
                    ,case
                      when provider_dr_type is null then provider_physician_name
                      else provider_physician_name||', '||provider_dr_type
                      end provider_physician_name_2
                    ,followed_rf_therapy_goals_flag
                    ,goals_achived_flag
                    ,reason_of_not_achiving_goals
              from pps_simplified_vw
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and prev_svc_billing_code = 'G0447'
              and completed_flag = 'Y'
              )
    loop
      --Last AWV record
      for j in (select pat_systolic_bp_in_mm||'/'||pat_diastolic_bp_in_mm pat_bp
                      ,svc_perform_date
                      ,pat_marital_status
                      ,qualify_for_em_followup_flag
                      ,chronic_disease_cnt
                      ,pat_height_in_in
                      ,pat_height_in_ft
                      ,pat_weight_in_lb weight_in_lb
                      ,pat_weight_in_lb||' lbs' pat_weight_in_lb
                      ,pat_waist_in_in
                      ,pat_bmi||'('||pat_bmi_result||')' pat_bmi
                from pps_simplified_vw
                where patient_prev_svc_sn = i.parent_patient_prev_svc_sn
                )
      loop
        obj.put('report_hdr',report_hdr(i.patient_prev_svc_sn,i.patient_sn,i.parent_patient_prev_svc_sn,i.svc_perform_date,j.pat_height_in_in,i.weight_in_lb,j.pat_waist_in_in,'OBESITY COUNSELING (IBT) OUTCOME','THE CLINICAL DATA CONTAINED IN THIS ASSESSMENT WAS GENERATED BY THE OBESITY COUNSELING OUTCOME PERFORMED ON','Y',i.svc_number));
        obj.put('patient_demo',patient_demo(i.pat_name,i.pat_gender,i.pat_medicare_hic_num,i.pat_birth_date,i.pat_age,j.pat_bp,j.pat_height_in_ft,j.pat_weight_in_lb,j.pat_waist_in_in||' inches',j.pat_bmi,j.pat_marital_status,i.svc_location_name,i.pat_primary_physician_name_2,j.svc_perform_date));
        --
        v_bmi := common_pkg.bmi(i.weight_in_lb,j.pat_height_in_in)||'('||common_pkg.bmi_result(common_pkg.bmi(i.weight_in_lb,j.pat_height_in_in))||')';
        obj.put('patient_assessment',patient_assessment_rpt(i.patient_prev_svc_sn,i.svc_perform_date,i.svc_month,i.svc_number,i.provider_physician_name_2,i.pat_weight_in_lb,i.pat_waist_in_in||' inches',v_bmi,i.followed_rf_therapy_goals_flag));
        obj.put('patient_rf',rpt_json_clob(i.parent_patient_prev_svc_sn,'ORF'));
        obj.put('svc_counseling',svc_counseling_obj(i.parent_patient_prev_svc_sn));
        if review_needed_flag(i.svc_number) = 'Y' then
          if i.goals_achived_flag = 'N' then
            v_review_text := 'Patient did not achieve goals of reducing '||i.svc_month||' lbs of weight. Below are the reasons:';
          else
            v_review_text := 'Patient did achieve goals of reducing '||i.svc_month||' lbs of weight.';
          end if;
          obj.put('review_result',review_result(i.svc_month,i.svc_month,v_review_text,i.reason_of_not_achiving_goals));
        end if;
        obj.put('treatment_goals',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'GOAL','TREATMENT GOALS AND METHODS','Appropriate treatment goals and methods based on the patient''s interest in and willingness to change the behavior'));
        obj.put('medical_treatment',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'TRET','RECOMMENDED MEDICAL TREATMENT','To Assist patient in achieving the treatment goals, when appropriate recommend supplemental adjunctive medical treatments'));
        obj.put('referral',svc_rf_remark_rpt(i.parent_patient_prev_svc_sn,'RFRL','RECOMMENDED REFERRAL','Referral to more intensive or specialized treatment'));
        --==============================================patient_signature
        obj2 := json(); --an empty structure
        for s in (select patient_signature
                        ,physician_signature
                  from patient_prev_svc
                  where patient_prev_svc_sn = p_patient_prev_svc_sn
                  )
        loop
          obj2.put('PATIENT_SIGNATURE_TITLE','PATIENT SIGNATURE');
          v_sub_title := 'Name: '||i.pat_name||' Date: '||i.svc_perform_date;
          obj2.put('PATIENT_SIGNATURE_SUBTITLE',v_sub_title);
          obj2.put('PATIENT_SIGNATURE',s.patient_signature);
          --
          obj2.put('PHYSICIAN_SIGNATURE_TITLE','HEALTH PROFESSIONAL SIGNATURE');
          v_sub_title := 'Name: '||i.pat_primary_physician_name_2||' Date: '||i.svc_perform_date;
          obj2.put('PHYSICIAN_SIGNATURE_SUBTITLE',v_sub_title);
          obj2.put('PHYSICIAN_SIGNATURE',s.physician_signature);
        end loop;
        obj.put('signature', obj2);
      end loop;
    end loop;
    --
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end screening_report_data_init;  
END obes_counseling_pkg;
/
show errors