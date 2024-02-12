create or replace PACKAGE svc_eval_pkg IS
  v_pkg_name    varchar2 (30) := upper('svc_eval_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  procedure svc_result_prc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_qualify_for_em_followup_flag out varchar2,p_chronic_disease_cnt out number);
  procedure em_followup_check (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_med_cnt in number,p_em_followup_flag out varchar2,p_chronic_disease_cnt out number);
  function question_categ_answered (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2;
  function mdq_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return categ_score_eval.disease_level_code%type;
  function frlty_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_age in number) return categ_score_eval.disease_level_code%type;
  function como_level (p_patient_prev_svc_sn in number) return categ_score_eval.disease_level_code%type;
  function fall_risk_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_med_cnt in number,p_age in number) return categ_score_eval.disease_level_code%type;
  function fdec_risk_level (p_patient_prev_svc_sn in number,p_age in number,p_bmi_result in varchar2) return categ_score_eval.disease_level_code%type;
  function cdec_risk_level (p_patient_prev_svc_sn in number,p_age in number,p_gender_code in varchar2) return categ_score_eval.disease_level_code%type;
  function cognitive_decline (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return categ_score_eval.disease_level_code%type;
  function symptom_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return categ_score_eval.disease_level_code%type;
  function risk_factor_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_age in number,p_gender_code in list_gender.gender_code%type,p_race_code in list_race.race_code%type,p_ethnicity_code in list_ethnicity.ethnicity_code%type,p_bmi_result in varchar2,p_bp_result in varchar2,p_financial_status_code in list_financial_status.financial_status_code%type) return categ_score_eval.disease_level_code%type;
  function disease_severity (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return list_disease_severity.disease_severity_code%type;
  --Risk Factor
  function chads2_stroke_rf (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_age in number) return categ_score_eval.disease_level_code%type;  
  function age_rf (p_disease_code in list_disease.disease_code%type,p_age in number) return categ_score_eval.disease_level_code%type;
  function gender_rf (p_disease_code in list_disease.disease_code%type,p_gender_code in list_gender.gender_code%type) return categ_score_eval.disease_level_code%type;
  function race_rf (p_disease_code in list_disease.disease_code%type,p_race_code in list_race.race_code%type,p_ethnicity_code in list_ethnicity.ethnicity_code%type) return categ_score_eval.disease_level_code%type;
  function disease_min_rf (p_patient_prev_svc_sn in number,p_disease_code in varchar2,p_bmi_result in varchar2,p_age in number) return varchar2;
  --
  function med_cnt (p_patient_sn in patient.patient_sn%type) return number;
END svc_eval_pkg;
/
show errors
create or replace PACKAGE BODY svc_eval_pkg IS
  --comorbidity level
  function como_level (p_patient_prev_svc_sn in number) return categ_score_eval.disease_level_code%type
  is
    v_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from patient_response_vw prv
        ,disease_vw dv
    where prv.disease_code = dv.disease_code
    and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
    and prv.category_code = 'BMEDH'
    ;
    if v_cnt = 2 then return 'MOD';
    elsif v_cnt = 3 then return 'HIG';
    elsif v_cnt >= 4 then return 'SEV';
    else return 'LOW';
    end if;
  end como_level;
  --Estimates stroke risk in patients with atrial fibrillation
  --CHADS? Score for Atrial Fibrillation Stroke Risk
  function chads2_stroke_rf (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_age in number) return categ_score_eval.disease_level_code%type
  is
    v_score number(9) := 0;
  begin
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1009','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1011','CBX') = 'Y' then --CHF or AFIB History
      if common_inq_pkg.disease_aqurd_riska_flag(p_patient_prev_svc_sn,'CHDE') = 'Y' then --if CHDE level is not LOW
        v_score := v_score + 1;
      end if;
    end if;
    --
    if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'HBPR') <> 'LOW' then --uncontrolled BP
      v_score := v_score + 1;
    end if;
    --
    if p_age >= 75 then
      v_score := v_score + 1;
    end if;
    --
    if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'DIAB') <> 'LOW' then --uncontrolled diab
      v_score := v_score + 1;
    end if;
    --
    if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'STRK') <> 'LOW' then --Stroke/TIA (Cerebrovascular Accident(CVA)) History
      v_score := v_score + 2;
    end if;
    --
    if v_score between 0 and 0 then return 'LOW';
    elsif v_score between 1 and 2 then return 'MOD';
    elsif v_score between 3 and 4 then return 'HIG';
    elsif v_score between 5 and 6 then return 'SEV';
    end if;
  end chads2_stroke_rf;
  --
  function disease_severity (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return list_disease_severity.disease_severity_code%type
  is
  begin
    --Disease from reported medical history
    if p_disease_code in ('FRLT','OBES','ALCO') then return 'AQURD';
    else
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,p_disease_code) = 'Y' then return 'AQURD';
      else return 'RISKA';
      end if;
    end if;
  end disease_severity;
  --
  function risk_factor_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type,p_age in number,p_gender_code in list_gender.gender_code%type,p_race_code in list_race.race_code%type,p_ethnicity_code in list_ethnicity.ethnicity_code%type,p_bmi_result in varchar2,p_bp_result in varchar2,p_financial_status_code in list_financial_status.financial_status_code%type) return categ_score_eval.disease_level_code%type
  is
    v_prmy_sev_cnt pls_integer := 0;
    v_incr_sev_cnt pls_integer := 0;
    v_pat_prmy_sev_cnt number(9,2) := 0;
    v_pat_incr_sev_cnt number(9,2) := 0;
    v_prmy_pct number(3) := 0;
    v_incr_pct number(3) := 0;
    v_prmy_return categ_score_eval.disease_level_code%type;
    v_incr_return categ_score_eval.disease_level_code%type;
    v_disease_level_code categ_score_eval.disease_level_code%type;
    v_cnt pls_integer := 0;
    v_risky_incr_diet_cnt pls_integer := 0;
    v_risky_prmy_diet_cnt pls_integer := 0;
  begin
    for i in (select drfv.severity_code,count(*) sev_cnt 
              from disease_risk_factor_vw drfv
              where drfv.disease_code = p_disease_code
              group by drfv.severity_code
              )
    loop
      if i.severity_code = 'PRMY' then
        v_prmy_sev_cnt := i.sev_cnt;
      elsif i.severity_code = 'INCR' then
        v_incr_sev_cnt := i.sev_cnt;
      end if;
    end loop;
    ---------------setting max
    if v_prmy_sev_cnt > 11 then
      v_prmy_sev_cnt := 11; --max is 11
    end if;
    if v_incr_sev_cnt > 11 then
      v_incr_sev_cnt := 11; --max is 11
    end if;
    --To avoid divided by zero error. This a specific severity_code is not available then percentage will become zero
    if v_prmy_sev_cnt = 0 then 
      v_prmy_sev_cnt := 1;
    end if;
    if v_incr_sev_cnt = 0 then 
      v_incr_sev_cnt := 1;
    end if;
    --
    for i in (select drfv.risk_factor_code,drfv.severity_code,drfv.risk_factor_is_a_disease_flag,drfv.rf_diet_categ_flag
              from disease_risk_factor_vw drfv
              where drfv.disease_code = p_disease_code
              )
    loop
      v_disease_level_code := 'LOW';
      if i.risk_factor_is_a_disease_flag = 'N' then
        if i.risk_factor_code = 'AGEE' then
          v_disease_level_code := age_rf(p_disease_code,p_age);
        elsif i.risk_factor_code = 'GNDR' then
          v_disease_level_code := gender_rf(p_disease_code,p_gender_code);
        elsif i.risk_factor_code = 'RACE' then
          v_disease_level_code := race_rf(p_disease_code,p_race_code,p_ethnicity_code);
        elsif i.risk_factor_code = 'BMIR' then
          v_disease_level_code := common_inq_pkg.obesity_rf_level(p_bmi_result);
        elsif i.risk_factor_code = 'FMHX' then
          v_disease_level_code := common_inq_pkg.disease_fmhx_level(p_patient_prev_svc_sn,p_disease_code);
        elsif i.risk_factor_code = 'SECO' then
          v_disease_level_code := common_inq_pkg.seco_rf_level(p_financial_status_code);
        elsif i.risk_factor_code = 'FRLT' then
          v_disease_level_code := svc_eval_pkg.frlty_level(p_patient_prev_svc_sn,p_age);
        elsif i.risk_factor_code = 'COMO' then
          v_disease_level_code := svc_eval_pkg.como_level(p_patient_prev_svc_sn);
        elsif i.risk_factor_code in ('ALCO','INAC','TBCO','SLEP','WATR','WEIT','DTFF','DTSG','DTST') then
          v_disease_level_code := common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,i.risk_factor_code);
        end if;
      else --i.risk_factor_is_a_disease_flag = 'Y'
        --COPD/CKDE/STRK/CHDE/BDIS//DIAB/HBPR/HCHO//DEPR/ANXT/STRS
        if i.risk_factor_code in ('DIAB','HBPR') then
          if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
            v_disease_level_code := common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code);
          elsif common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,i.risk_factor_code) = 'Y' then
            v_disease_level_code := 'MOD';
          else
            v_disease_level_code := 'LOW';
          end if;
        else
          v_disease_level_code := common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code);
        end if;
      end if;
      --
      if v_disease_level_code <> 'LOW' then
        if i.severity_code = 'INCR' then
          if v_disease_level_code = 'MOD' then v_pat_incr_sev_cnt := v_pat_incr_sev_cnt + 0.5;
          elsif v_disease_level_code = 'HIG' then v_pat_incr_sev_cnt := v_pat_incr_sev_cnt + 1;
          elsif v_disease_level_code = 'SEV' then v_pat_incr_sev_cnt := v_pat_incr_sev_cnt + 1.5;
          end if;
        elsif i.severity_code = 'PRMY' then
          if v_disease_level_code = 'MOD' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 0.5;
          elsif v_disease_level_code = 'HIG' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 1;
          elsif v_disease_level_code = 'SEV' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 1.5;
          end if;
        end if;
      end if;
      --dbms_output.put_line(i.risk_factor_code||'-LOOP v_pat_incr_sev_cnt: '||v_pat_incr_sev_cnt||'-v_pat_prmy_sev_cnt: '||v_pat_prmy_sev_cnt);
    end loop;
    --CHDE Diet related RF are not added in the disease_risk_factor table to avoid multiple RF count. 
    if p_disease_code = 'CHDE' then
      v_disease_level_code := common_inq_pkg.cvd_diet_rf_level(p_patient_prev_svc_sn);
      if v_disease_level_code <> 'LOW' then
        if v_disease_level_code = 'MOD' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 0.5;
        elsif v_disease_level_code = 'HIG' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 1;
        elsif v_disease_level_code = 'SEV' then v_pat_prmy_sev_cnt := v_pat_prmy_sev_cnt + 1.5;
        end if;
      end if;
    end if;
    --
    --dbms_output.put_line('v_pat_incr_sev_cnt: '||v_pat_incr_sev_cnt||'-v_pat_prmy_sev_cnt: '||v_pat_prmy_sev_cnt);
    --dbms_output.put_line('v_incr_sev_cnt: '||v_incr_sev_cnt||'-v_prmy_sev_cnt: '||v_prmy_sev_cnt);
    --
    v_prmy_pct := round((v_pat_prmy_sev_cnt*100)/v_prmy_sev_cnt);
    v_incr_pct := round((v_pat_incr_sev_cnt*100)/v_incr_sev_cnt);
    --changed of ranges on 10/14/2017 -mh
    if v_prmy_pct between 0 and 29 then  --changed from 29 to 39
      v_prmy_return := 'LOW';
    elsif v_prmy_pct between 30 and 60 then --changed from 30 to 40 
      v_prmy_return := 'MOD';
    elsif v_prmy_pct between 61 and 80 then --
      v_prmy_return := 'HIG';
    else
      v_prmy_return := 'SEV';
    end if;
    --
    if v_incr_pct between 0 and 29 then
      v_incr_return := 'LOW';
    elsif v_incr_pct between 30 and 60 then
      v_incr_return := 'MOD';
    elsif v_incr_pct between 61 and 80 then
      v_incr_return := 'HIG';
    else
      v_incr_return := 'SEV';
    end if;
    --
    if v_prmy_return = 'SEV' then
      return 'SEV';
    elsif v_prmy_return = 'HIG' then
      return 'HIG';
    elsif v_prmy_return = 'MOD' then
      if v_incr_return in ('HIG','SEV') then
        return 'HIG';
      else
        return 'MOD';
      end if;
    else --'LOW'
      if v_incr_return in ('HIG','SEV') then
        return 'MOD';
      else
        return 'LOW';
      end if;
    end if;
  end risk_factor_level;
  --
  function symptom_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_disease_code in list_disease.disease_code%type) return categ_score_eval.disease_level_code%type
  is
    v_prmy_sev_cnt pls_integer := 0;
    v_incr_sev_cnt pls_integer := 0;
    v_pat_prmy_sev_cnt pls_integer := 0;
    v_pat_incr_sev_cnt pls_integer := 0;
    v_prmy_pct number(3) := 0;
    v_incr_pct number(3) := 0;
    v_prmy_return categ_score_eval.disease_level_code%type;
    v_incr_return categ_score_eval.disease_level_code%type;
  begin
    for i in (select dsv.severity_code,count(*) sev_cnt 
              from disease_symptom_vw dsv
              where dsv.disease_code = p_disease_code
              group by dsv.severity_code
              )
    loop
      if i.severity_code = 'PRMY' then
        v_prmy_sev_cnt := i.sev_cnt;
      elsif i.severity_code = 'INCR' then
        v_incr_sev_cnt := i.sev_cnt;
      end if;
    end loop;
    --To avoid divided by zero error. This a specific severity_code is not available then percentage will become zero
    if v_prmy_sev_cnt = 0 then 
      v_prmy_sev_cnt := 1;
    end if;
    if v_incr_sev_cnt = 0 then 
      v_incr_sev_cnt := 1;
    end if;
    --
    for i in (select dsv.severity_code,count(*) sev_cnt
              from disease_symptom_vw dsv
                  ,patient_response_vw prv
              where prv.symptom_code = dsv.symptom_code
              and dsv.disease_code = p_disease_code
              and prv.patient_prev_svc_sn = p_patient_prev_svc_sn
              group by dsv.severity_code
              )
    loop
      if i.severity_code = 'PRMY' then
        v_pat_prmy_sev_cnt := i.sev_cnt;
      elsif i.severity_code = 'INCR' then
        v_pat_incr_sev_cnt := i.sev_cnt;
      end if;
    end loop;
    --
    v_prmy_pct := round((v_pat_prmy_sev_cnt*100)/v_prmy_sev_cnt);
    v_incr_pct := round((v_pat_incr_sev_cnt*100)/v_incr_sev_cnt);
    --
    if v_prmy_pct between 0 and 29 then
      v_prmy_return := 'LOW';
    elsif v_prmy_pct between 30 and 60 then
      v_prmy_return := 'MOD';
    elsif v_prmy_pct between 61 and 80 then
      v_prmy_return := 'HIG';
    else
      v_prmy_return := 'SEV';
    end if;
    --
    if v_incr_pct between 0 and 29 then
      v_incr_return := 'LOW';
    elsif v_incr_pct between 30 and 60 then
      v_incr_return := 'MOD';
    elsif v_incr_pct between 61 and 80 then
      v_incr_return := 'HIG';
    else
      v_incr_return := 'SEV';
    end if;
    --
    if v_prmy_return = 'SEV' then
      return 'SEV';
    elsif v_prmy_return = 'HIG' then
      return 'HIG';
    elsif v_prmy_return = 'MOD' then
      if v_incr_return in ('HIG','SEV') then
        return 'HIG';
      else
        return 'MOD';
      end if;
    else --'LOW'
      if v_incr_return in ('HIG','SEV') then
        return 'MOD';
      else
        return 'LOW';
      end if;
    end if;
  end symptom_level;
  --Function to determine race risk factor
  function race_rf (p_disease_code in list_disease.disease_code%type,p_race_code in list_race.race_code%type,p_ethnicity_code in list_ethnicity.ethnicity_code%type) return categ_score_eval.disease_level_code%type
  is
  begin
    if p_disease_code in ('HBPR','CHDE','STRK') then
      if p_race_code in ('ASIN','BLAK') then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'ALZH' then
      --if p_ethnicity_code = 'HISP' then return 'MOD';
      if p_race_code = 'BLAK' then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'ARTH' then
      --if p_ethnicity_code = 'HISP' then return 'MOD';
      if p_race_code = 'BLAK' then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'DIAB' then
      --if p_ethnicity_code = 'HISP' then return 'MOD';
      if p_race_code in ('AIAN','ASIN','BLAK','NHPI') then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'CKDE' then
      if p_race_code in ('AIAN','ASIN','BLAK') then return 'MOD';
      else return 'LOW';
      end if;
    else return 'LOW';
    end if;
  end race_rf;
  --Function to determine gender risk factor
  function gender_rf (p_disease_code in list_disease.disease_code%type,p_gender_code in list_gender.gender_code%type) return categ_score_eval.disease_level_code%type
  is
  begin
    if p_disease_code = 'ARTH' then
      if p_gender_code = 'FEM' then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'PARK' then
      if p_gender_code = 'MAL' then return 'MOD';
      else return 'LOW';
      end if;
    elsif p_disease_code = 'SAPN' then
      if p_gender_code = 'MAL' then return 'MOD';
      else return 'LOW';
      end if;
    else return 'LOW';
    end if;
  end gender_rf;
  --
  --Function to determine Age risk factor
  function age_rf (p_disease_code in list_disease.disease_code%type,p_age in number) return categ_score_eval.disease_level_code%type
  is
  begin
    if p_disease_code in ('HBPR','CHDE','STRK') then
      if p_age < 55 then return 'LOW';
      elsif p_age between 55 and 75 then return 'MOD';
      elsif p_age between 76 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'ALZH' then
      if p_age < 85 then return 'LOW';
      elsif p_age between 85 and 90 then return 'MOD';
      elsif p_age between 91 and 95 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'ARTH' then
      if p_age < 50 then return 'LOW';
      elsif p_age between 50 and 70 then return 'MOD';
      elsif p_age between 71 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'CNCR' then
      if p_age < 60 then return 'LOW';
      elsif p_age between 60 and 75 then return 'MOD';
      elsif p_age between 76 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'HCHO' then
      if p_age < 55 then return 'LOW';
      elsif p_age between 55 and 75 then return 'MOD';
      elsif p_age between 76 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'COPD' then
      if p_age < 50 then return 'LOW';
      elsif p_age between 50 and 70 then return 'MOD';
      elsif p_age between 71 and 85 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'DIAB' then
      if p_age < 45 then return 'LOW';
      elsif p_age between 45 and 70 then return 'MOD';
      elsif p_age between 71 and 85 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'CKDE' then
      if p_age < 75 then return 'LOW';
      elsif p_age between 75 and 80 then return 'MOD';
      elsif p_age between 81 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'PNEU' then
      if p_age < 65 then return 'LOW';
      elsif p_age between 65 and 80 then return 'MOD';
      elsif p_age between 81 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'PARK' then
      if p_age < 60 then return 'LOW';
      elsif p_age between 60 and 70 then return 'MOD';
      elsif p_age between 71 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'SAPN' then
      if p_age < 40 then return 'LOW';
      elsif p_age between 40 and 65 then return 'MOD';
      elsif p_age between 66 and 80 then return 'HIG';
      else return 'SEV';
      end if;
    elsif p_disease_code = 'OBES' then
      if p_age < 50 then return 'LOW';
      elsif p_age between 50 and 70 then return 'MOD';
      elsif p_age between 71 and 90 then return 'HIG';
      else return 'SEV';
      end if;
    else return 'LOW';
    end if;
  end age_rf;
  --
  function cognitive_decline (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return categ_score_eval.disease_level_code%type
  is
  begin
    return common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'COGND',null),'COGND',null);
  exception
    when others then
      raise_application_error(-20005,sqlerrm);
  end cognitive_decline;
  --
  function fall_risk_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_med_cnt in number,p_age in number) return categ_score_eval.disease_level_code%type
  is
    v_er_and_hosp_point number(1) := 0;
    v_er_and_no_hosp_point number(1) := 0;
    v_med_cnt number(1) := 0;
    v_age_cnt number(1) := 0;
    v_frlt_cnt number(1) := 0;
    v_other_cnt number(1) := 0;
    v_return_1 categ_score_eval.disease_level_code%type;
    v_return_2 categ_score_eval.disease_level_code%type;
  begin
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1001','Y01') = 'Y' then --Yes and Needed to go to ER
      v_er_and_hosp_point := 2;
    end if;
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1001','Y02') = 'Y' then --Yes but did not need to go to ER
      v_er_and_no_hosp_point := 1;
    end if;
    if common_inq_pkg.trouble_walking_flag(p_patient_prev_svc_sn) = 'Y' then --Trouble walking ('FRLT1','1005',ATD/UTD or 'FRLT2','1003',YES/DD1)
      v_frlt_cnt := 1;
    end if;
    if common_inq_pkg.pain_symptom_flag(p_patient_prev_svc_sn) = 'Y' then --Pain symptom
      v_frlt_cnt := v_frlt_cnt + 1;
    end if;
    if p_med_cnt > 2 then
      v_med_cnt := 1;
    end if;
    if p_age >= 80 then
      v_age_cnt := 1;
    end if;
    v_other_cnt := common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'FALLR',null);
    --If user did not report dizziness in FALLR then check  validated test DIZZI or symptom for dizziness
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1002','NOO') = 'Y' then
      --validated test for DIZZI question categ
      if common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'DIZZI',null),'DIZZI',null) <> 'LOW' then
        v_other_cnt := v_other_cnt + 1;
      elsif common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HENMT','1002','CBX') = 'Y' then --Dizziness (morning or evening) or Dizziness (lightheadedness) symptom
        v_other_cnt := v_other_cnt + 1;
      end if;
    end if;
    --If user did not report Hearing loss in FALLR then check  HHISQ
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','NOO') = 'Y' then 
      if common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'HHISQ',null),'HHISQ',null) <> 'LOW' then --Suffer Hearing loss
        v_other_cnt := v_other_cnt + 1;
      end if;
    end if;
    if common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'HOMES',null),'HOMES',null) <> 'LOW' then --Home Lack of Safety
      v_other_cnt := v_other_cnt + 1;
    end if;
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1021','YES') = 'Y' then --Daily activity limitation due to Fall/Injury
      v_other_cnt := v_other_cnt + 1;
    end if;
    --
    if (v_er_and_hosp_point + v_er_and_no_hosp_point + v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 7 and 99 then
      v_return_1 := 'SEV';
    elsif (v_er_and_hosp_point + v_er_and_no_hosp_point + v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 5 and 6 then
      v_return_1 := 'HIG';
    elsif (v_er_and_hosp_point + v_er_and_no_hosp_point + v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 4 and 4 then
      v_return_1 := 'MOD';
    else --between 0 and 1
      v_return_1 := 'LOW';
    end if;
    --
    if (v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 7 and 99 then
      v_return_2 := 'SEV';
    elsif (v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 5 and 6 then
      v_return_2 := 'HIG';
    elsif (v_med_cnt + v_age_cnt + v_other_cnt + v_frlt_cnt) between 4 and 4 then
      v_return_2 := 'MOD';
    else --between 0 and 2
      v_return_2 := 'LOW';
    end if;
    --
    if v_return_1 = 'SEV' or v_return_2 = 'SEV' then
      return 'SEV';
    elsif v_return_1 = 'HIG' or v_return_2 = 'HIG' then
      return 'MOD';
    elsif v_return_1 = 'MOD' or v_return_2 = 'MOD' then
      return 'MOD';
    else
      return 'LOW';
    end if;
  exception
    when others then
      raise_application_error(-20005,sqlerrm);
  end fall_risk_level;
  --
  function fdec_risk_level (p_patient_prev_svc_sn in number,p_age in number,p_bmi_result in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_adl_disease_level_code categ_score_eval.disease_level_code%type;
    v_addl_rf_code categ_score_eval.disease_level_code%type;
    v_addl_rf_cnt pls_integer := 0;
  begin
    --Any ADL Limitation
    v_adl_disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'ADLBF',null),'ADLBF',null);
    --12/19/2017
    --Other RF. Minimum requirement for other RF is any two condition from three (Joint pain, Loss of balance and Slow movement)
    --Joint pain
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'MUSCS','1002','CBX') = 'Y' then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --Loss of balance
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1011','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1005','YES') = 'Y' then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --Slow movement
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1012','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1007','YES') = 'Y' then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --
    if v_addl_rf_cnt >= 2 then
      --Age
      if p_age >= 80 then
        v_addl_rf_cnt := v_addl_rf_cnt + 1;
      end if;
      --BMI
      if common_inq_pkg.obesity_rf_level(p_bmi_result) = 'HIG' then --Obese
        v_addl_rf_cnt := v_addl_rf_cnt + 1;
      end if;
      --Lack of activity
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'INAC') <> 'LOW' then
        v_addl_rf_cnt := v_addl_rf_cnt + 1;
      end if;
    end if;
    --Max point for v_addl_rf_cnt is 6
    if v_addl_rf_cnt between 0 and 2 then v_addl_rf_code := 'LOW';
    elsif v_addl_rf_cnt between 3 and 4 then v_addl_rf_code := 'MOD';
    elsif v_addl_rf_cnt between 5 and 5 then v_addl_rf_code := 'HIG';
    elsif v_addl_rf_cnt between 6 and 99 then v_addl_rf_code := 'SEV';
    end if;
    --Final evaluation
    if v_adl_disease_level_code = 'SEV' or v_addl_rf_code = 'SEV' then return 'SEV';
    elsif v_adl_disease_level_code = 'HIG' or v_addl_rf_code = 'HIG' then return 'HIG';
    elsif v_adl_disease_level_code = 'MOD' or v_addl_rf_code = 'MOD' then return 'MOD';
    else return 'LOW';
    end if;
  exception
    when others then
      raise_application_error(-20005,sqlerrm);
  end fdec_risk_level;
  --
  function cdec_risk_level (p_patient_prev_svc_sn in number,p_age in number,p_gender_code in varchar2) return categ_score_eval.disease_level_code%type
  is
    v_iadl_disease_level_code categ_score_eval.disease_level_code%type;
    v_addl_rf_code categ_score_eval.disease_level_code%type;
    v_addl_rf_cnt pls_integer := 0;
  begin
    --Any IADL Limitation
    v_iadl_disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'IADLB',null),'IADLB',p_gender_code);
    --Other RF. Minimum requirement for other RF is any one condition from (Major Depression, Any MDQ (SCHI), Poor memory)
    --Any Major Depression
    if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'DEPR') = 'Y' or (question_categ_answered(p_patient_prev_svc_sn,'GERDS') = 'Y' and common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'GERDS',null),'GERDS',null) <> 'LOW') then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --Any MDQ (SCHI)
    if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'SCHI') = 'Y' or svc_eval_pkg.mdq_level(p_patient_prev_svc_sn) <> 'LOW' then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --Poor memory
    if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1005','YES') = 'Y' then
      v_addl_rf_cnt := v_addl_rf_cnt + 1;
    end if;
    --
    if v_addl_rf_cnt > 0 then
      --Slow movement
      if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'NEPYS','1012','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'COGND','1007','YES') = 'Y' then
        v_addl_rf_cnt := v_addl_rf_cnt + 1;
      end if;
      --Age
      if p_age >= 80 then
        v_addl_rf_cnt := v_addl_rf_cnt + 1;
      end if;
    end if;
    --Max point for v_addl_rf_cnt is 5
    if v_addl_rf_cnt between 0 and 1 then v_addl_rf_code := 'LOW';
    elsif v_addl_rf_cnt between 2 and 3 then v_addl_rf_code := 'MOD';
    elsif v_addl_rf_cnt between 4 and 4 then v_addl_rf_code := 'HIG';
    elsif v_addl_rf_cnt between 5 and 99 then v_addl_rf_code := 'SEV';
    end if;
    --Final evaluation
    if v_iadl_disease_level_code = 'SEV' or v_addl_rf_code = 'SEV' then return 'SEV';
    elsif v_iadl_disease_level_code = 'HIG' or v_addl_rf_code = 'HIG' then return 'HIG';
    elsif v_iadl_disease_level_code = 'MOD' or v_addl_rf_code = 'MOD' then return 'MOD';
    else return 'LOW';
    end if;
  exception
    when others then
      raise_application_error(-20005,sqlerrm);
  end cdec_risk_level;
  --
  function frlty_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_age in number) return categ_score_eval.disease_level_code%type
  is
    v_frlty number(9);
    v_frlt1 number(9);
    v_frlt2 number(9);
    v_age   number(9);
  begin
    --Frailty have four parts, age, frlty, frlty1 and frlty2.
    --Frlty1 can have max 2 and Frlty2 can have max 4 points
    --Frlty have max 1 points and Age have max 3 points. Total 10 points
    --
    --If total score is >= 3 then risk is high
    v_frlty := common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'FRLTY',null);
    v_frlt1 := common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'FRLT1',null);
    v_frlt2 := common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'FRLT2',null);
    --
    if v_frlt1 > 2 then
      v_frlt1 := 2;
    end if;
    --
    if v_frlt2 > 4 then
      v_frlt2 := 4;
    end if;
    --
    if p_age < 75 then
      v_age := 0;
    elsif p_age between 75 and 84 then
      v_age := 1;
    else -->= 85
      v_age := 3;
    end if;
    --
    return common_inq_pkg.response_score((v_age + v_frlty + v_frlt1 + v_frlt2),'FRLTY',null);
  exception
    when others then
      raise_application_error(-20004,sqlerrm);
  end frlty_level;
  --
  function mdq_level (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type) return categ_score_eval.disease_level_code%type
  is
  begin
    --Criteria 1)"Yes” to >=7 of the 13 question numbers between 1001 and 1013 AND
    --Criteria 2)“Yes” to question number 1014 AND
    --Criteria 3)“Moderate” or “Serious” to question number 1015;
    --All three of the criteria above should be met and then the patient have a positive screen
    if common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,'MOOD1',null) >= 7 and
       common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'MOOD1','1014','YES') = 'Y' and
       ((common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'MOOD1','1015','MOP') = 'Y') or (common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'MOOD1','1015','SEP') = 'Y')) 
    then
      return 'HIG';
    else
      return 'LOW';
    end if;
  exception
    when others then
      raise_application_error(-20003,sqlerrm);
  end mdq_level;
  --To check if patient have answer any question on a specific category
  function question_categ_answered (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2
  is
    l_cnt pls_integer;
  begin
    select count(*)
    into l_cnt
    from patient_response_vw 
    where category_code = p_question_categ_code
    and patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if l_cnt = 0 then
      return 'N';
    else
      return 'Y';
    end if;
  exception
    when others then
      raise_application_error(-20002,sqlerrm);
  end question_categ_answered;
  --
  procedure em_followup_check (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_med_cnt in number,p_em_followup_flag out varchar2,p_chronic_disease_cnt out number)
  is
    v_excbt_cnt pls_integer := 0;
    v_riska_cnt pls_integer := 0;
  begin
    --Count of HIGH or SEVERE RISK TO ACQUIRE disease/event/condition (can only be RISKA)
    --Count of EXISTING uncontrolled disease/event/condition (can only be EXCBT)
    --Alcoholic (can only be EXCBT)
    --Obese (can only be EXCBT)
    ------------
    --If EXCBT + RISKA with HIG/SEV >=2 then Y
    select count(*)
    into v_excbt_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_severity_code = 'EXCBT'
    and trigger_ccm_flag = 'Y'
    ;
    select count(*)
    into v_riska_cnt
    from svc_result_vw
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and disease_severity_code = 'RISKA'
    and disease_level_code in ('HIG','SEV')
    and trigger_ccm_flag = 'Y'
    ;
    p_chronic_disease_cnt := v_excbt_cnt + v_riska_cnt;
    --
    if p_chronic_disease_cnt >= 2 then p_em_followup_flag := 'Y';
    else p_em_followup_flag := 'N';
    end if;
  exception
    when others then
      raise_application_error(-20001,sqlerrm);
  end em_followup_check;
  --
  function med_cnt (p_patient_sn in patient.patient_sn%type) return number
  is
    v_med_cnt pls_integer;
  begin
    select count(*)
    into v_med_cnt
    from patient_medication
    where patient_sn = p_patient_sn 
    and medication_current_flag = 'Y'
    and active_flag = 'Y'
    and prescribed_med_flag = 'Y'
    ;
    return v_med_cnt;
  end med_cnt;
  --
  --Mininum RF, before a disease is considered for further evaluation. There are many RF for a disease. 
  --Some RF are primary and some are additional RF. Some primary RF needs to met before a disease
  --is evaluated further to identify it's risk level. This function will hold all the logic for all the diseases.
  function disease_min_rf (p_patient_prev_svc_sn in number,p_disease_code in varchar2,p_bmi_result in varchar2,p_age in number) return varchar2
  is
    v_return varchar2(1) := 'N';
    v_cnt pls_integer := 0;
  begin
    if p_disease_code = 'SPAN' then
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'SLEP') <> 'LOW' then --Sleep RF available
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'COPD' then    
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'TBCO') <> 'LOW' then --Primray RF
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'PNEU' then
      if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'COPD') <> 'LOW' and common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'TBCO') <> 'LOW' then --Hx of COPD and TBCO is Primray RF
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'ALZH' then
      if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'CHDE') <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'ARTH' then
      if common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'CHDE' then
      for i in (select risk_factor_code
                      ,risk_factor_is_a_disease_flag
                from risk_factor_vw
                where risk_factor_code in ('HCHO','DIAB','TBCO','BMIR','CHDE','STRK')
                )
      loop
        if i.risk_factor_is_a_disease_flag = 'Y' then
          if i.risk_factor_code = 'DIAB' then
            if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,i.risk_factor_code) = 'Y' then
              v_cnt := v_cnt + 1;
            end if;
          else
            if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
              v_cnt := v_cnt + 1;
            end if;
          end if;
        else --not a disease
          if i.risk_factor_code = 'TBCO' then
            if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
              v_cnt := v_cnt + 1;
            end if;
          elsif i.risk_factor_code = 'BMIR' then
            if common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then
              v_cnt := v_cnt + 1;
            end if;
          end if;
        end if;
      end loop;
      --
      if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'HBPR') = 'Y' and v_cnt >= 2 then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'CNCR' then
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'TBCO') <> 'LOW' and common_inq_pkg.disease_fmhx_level(p_patient_prev_svc_sn,p_disease_code) <> 'LOW' and age_rf(p_disease_code,p_age) <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'DIAB' then
      if common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then 
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'PARK' then
      if common_inq_pkg.disease_fmhx_level(p_patient_prev_svc_sn,p_disease_code) <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'CKDE' then
      if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'DIAB') <> 'LOW' and (common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'HBPR') = 'Y' or common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,'HCHO') <> 'LOW') then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'HBPR' then
      for i in (select risk_factor_code
                      ,risk_factor_is_a_disease_flag
                from risk_factor_vw
                where risk_factor_code in ('BMIR','DTST','INAC','ALCO','STRS')
                )
      loop
        if i.risk_factor_is_a_disease_flag = 'Y' then
          if common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
            v_cnt := v_cnt + 1;
          end if;
        else --not a disease
          if i.risk_factor_code in ('ALCO','INAC','DTST') then
            if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,i.risk_factor_code) <> 'LOW' then
              v_cnt := v_cnt + 1;
            end if;
          elsif i.risk_factor_code = 'BMIR' then
            if common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then
              v_cnt := v_cnt + 1;
            end if;
          end if;
        end if;
      end loop;
      --
      if v_cnt >= 3 then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'HCHO' then
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'DTFF') <> 'LOW' and common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'CLDE' then
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'ALCO') <> 'LOW' and (common_inq_pkg.obesity_rf_level(p_bmi_result) <> 'LOW' or common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'DIAB') = 'Y') then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'AIDS' then
      v_return := 'Y';
    elsif p_disease_code = 'OBES' then
      if p_bmi_result = 'Obese' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'ALCO' then
      if common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'ALCO') <> 'LOW' then
        v_return := 'Y';
      end if;
    elsif p_disease_code = 'STRK' then
      --will be evaluated based on chad 2
      v_return := 'Y';
    else
      v_return := 'N';
    end if;
    return v_return;
  end disease_min_rf;
  --
  procedure svc_result_prc (p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_qualify_for_em_followup_flag out varchar2,p_chronic_disease_cnt out number)
  as
    v_svc_result_rec svc_result%rowtype;
    v_gender_code list_gender.gender_code%type;
    v_financial_status_code list_financial_status.financial_status_code%type;
    v_ethnicity_code list_ethnicity.ethnicity_code%type;
    v_race_code list_race.race_code%type;
    v_age number(9);
    v_bmi number(9,3);
    v_bmi_result varchar2(30);
    v_bp_result varchar2(30);
    v_med_cnt pls_integer;
    --
    v_prmy_return categ_score_eval.disease_level_code%type;
    v_incr_return categ_score_eval.disease_level_code%type;
  begin
    select p.gender_code
          ,common_pkg.age_at_a_date(p.birth_date,pps.svc_date)
          ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)
          ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in))
          ,common_pkg.bp_reading(pps.SYSTOLIC_BP_IN_MM,pps.DIASTOLIC_BP_IN_MM)
          ,svc_eval_pkg.med_cnt(pps.patient_sn)
          ,pps.financial_status_code
          ,p.race_code
          ,p.ethnicity_code
    into v_gender_code
        ,v_age
        ,v_bmi
        ,v_bmi_result
        ,v_bp_result
        ,v_med_cnt
        ,v_financial_status_code
        ,v_race_code
        ,v_ethnicity_code
    from patient_prev_svc pps
        ,patient p
    where pps.patient_sn = p.patient_sn
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    --
    v_svc_result_rec.patient_prev_svc_sn := p_patient_prev_svc_sn;
    --OBES will be used for prevention plan and as a RF. But not as a disease
    for i in (select disease_code
                    ,question_categ_code
              from list_disease
              where active_flag = 'Y'
              order by disease_code
              )
    loop
      v_svc_result_rec.disease_code := i.disease_code;
      --Aquired or Risk to Aquire. This will be changed based on the final disease level code
      v_svc_result_rec.disease_severity_code := svc_eval_pkg.disease_severity(p_patient_prev_svc_sn,i.disease_code); 
      v_svc_result_rec.disease_level_code := 'LOW'; --setting at LOW, which will be evaluated furthers and if needed, changed to appropriate one.
      v_prmy_return := 'LOW';
      v_incr_return := 'LOW';
      --disease_level_code will be evaluated by four criteria
      --1) By scoring
      --2) By evaluating Risk Factor and Symptom
      --3) By evaluating Risk Factor only
      --4) By evaluating Symptom only
      if i.disease_code = 'LONL' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
      elsif i.disease_code in ('DEPR','ANXT','STRS') then
        if question_categ_answered(p_patient_prev_svc_sn,i.question_categ_code) = 'Y' then
          v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
        end if;
      elsif i.disease_code = 'SCHI' then
        v_svc_result_rec.disease_level_code := svc_eval_pkg.mdq_level(p_patient_prev_svc_sn);
      elsif i.disease_code = 'FDEC' then
        v_svc_result_rec.disease_level_code := fdec_risk_level(p_patient_prev_svc_sn,v_age,v_bmi_result);
      elsif i.disease_code = 'CDEC' then
        if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1022','YES') = 'Y' then --Notice declining of cognitive skill
          v_svc_result_rec.disease_level_code := 'HIG';
        else
          v_svc_result_rec.disease_level_code := cdec_risk_level(p_patient_prev_svc_sn,v_age,v_gender_code);
        end if;
      elsif i.disease_code = 'FRLT' then
        v_svc_result_rec.disease_level_code := svc_eval_pkg.frlty_level(p_patient_prev_svc_sn,v_age);
      elsif i.disease_code = 'FALL' then
        if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BEHVT','1021','YES') = 'Y' then --Notice daily activity limitation due to Fall/Injury
          v_svc_result_rec.disease_level_code := 'HIG';
        else
          v_svc_result_rec.disease_level_code := svc_eval_pkg.fall_risk_level(p_patient_prev_svc_sn,v_med_cnt,v_age);
        end if;
      elsif i.disease_code = 'DIZI' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
        --if the validated test result is LOW then check if the patient reported any dizziness symptom (cross ref)
        if v_svc_result_rec.disease_level_code = 'LOW' then
          if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'HENMT','1002','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1002','YES') = 'Y' then --Dizziness (morning or evening) or Dizziness (lightheadedness) symptom or reported dizziness in the fall rf
            v_svc_result_rec.disease_level_code := 'MOD';
          end if;
        end if;
      elsif i.disease_code = 'HEAR' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
        if v_svc_result_rec.disease_level_code = 'LOW' then
          --check if reported Hearing loss in Fall rf test
          if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'FALLR','1003','YES') = 'Y' then 
            v_svc_result_rec.disease_level_code := 'MOD';
          end if;
        end if;        
      elsif i.disease_code = 'HOME' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
      elsif i.disease_code = 'SUIC' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
      elsif i.disease_code = 'MCMP' then
        v_svc_result_rec.disease_level_code := common_inq_pkg.response_score(common_inq_pkg.categ_score_sum(p_patient_prev_svc_sn,i.question_categ_code,null),i.question_categ_code,null);
      elsif i.disease_code = 'SFTY' then
        if common_inq_pkg.question_category_rf_flag(p_patient_prev_svc_sn,'BEHVT','SFTY') = 'Y' then
          v_svc_result_rec.disease_level_code := 'HIG';
        end if;
      --elsif i.disease_code = 'FRTR' then --//needs to evaluate further
      elsif i.disease_code in ('ALZH','ARTH','CHDE','CNCR','COPD','DIAB','PARK','PNEU','SAPN','STRK','HBPR','HCHO','CKDE','CLDE','AIDS','OBES','ALCO','BDIS') then
        --disease_min_rf is for risk to acquire and common_inq_pkg.disease_rf_level is for exacerbate
        if disease_min_rf(p_patient_prev_svc_sn,i.disease_code,v_bmi_result,v_age) = 'Y' or common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.disease_code) <> 'LOW' then
          if i.disease_code = 'STRK' then
            --STRK is evaluated based on chad 2 score
            if common_inq_pkg.disease_hx_flag(p_patient_prev_svc_sn,'STRK') = 'Y' then --Stroke Hx available
              if common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1029','CBX') = 'Y' or common_inq_pkg.patient_question_response_flag (p_patient_prev_svc_sn,'BMEDH','1030','CBX') = 'Y' then --Have any post Stroke(CVA) limitation
                v_prmy_return := 'HIG';
              else                
                v_prmy_return := svc_eval_pkg.chads2_stroke_rf(p_patient_prev_svc_sn,v_age);
              end if;
              v_incr_return := symptom_level(p_patient_prev_svc_sn,i.disease_code);
            else --no Hx
              v_prmy_return := svc_eval_pkg.chads2_stroke_rf(p_patient_prev_svc_sn,v_age);
              v_incr_return := symptom_level(p_patient_prev_svc_sn,i.disease_code);
            end if;
          elsif i.disease_code = 'OBES' then
            v_prmy_return := common_inq_pkg.obesity_rf_level(v_bmi_result);
          elsif i.disease_code = 'ALCO' then
            v_prmy_return := common_inq_pkg.behavior_rf_level(p_patient_prev_svc_sn,'ALCO');
          else
            v_prmy_return := risk_factor_level(p_patient_prev_svc_sn,i.disease_code,v_age,v_gender_code,v_race_code,v_ethnicity_code,v_bmi_result,v_bp_result,v_financial_status_code);
            v_incr_return := symptom_level(p_patient_prev_svc_sn,i.disease_code);
            if i.disease_code in ('HBPR','HCHO','DIAB') then
              --If the above disease is uncontrolled declared by user but the risk_factor_level still LOW then force it to MOD
              if v_prmy_return = 'LOW' and common_inq_pkg.disease_rf_level(p_patient_prev_svc_sn,i.disease_code) <> 'LOW' then
                v_prmy_return := 'MOD';
              end if;
            end if;            
          end if;
        end if;
        --
        if v_prmy_return = 'SEV' then v_svc_result_rec.disease_level_code := 'SEV';
        elsif v_prmy_return = 'HIG' then v_svc_result_rec.disease_level_code := 'HIG';
        elsif v_prmy_return = 'MOD' then
          if v_incr_return in ('HIG','SEV') then v_svc_result_rec.disease_level_code := 'HIG';
          else v_svc_result_rec.disease_level_code := 'MOD';
          end if;
        else --'LOW'
          if v_incr_return in ('HIG','SEV') then v_svc_result_rec.disease_level_code := 'MOD';
          else v_svc_result_rec.disease_level_code := 'LOW';
          end if;
        end if;
      end if;
      --================================================end of disease evaluation
      --check to see if the severity have changed for a aquired disease
      if v_svc_result_rec.disease_severity_code = 'AQURD' and v_svc_result_rec.disease_level_code <> 'LOW' then
        v_svc_result_rec.disease_severity_code := 'EXCBT';
      end if;
      --enter result data
      common_dml_pkg.ins_upd_svc_result (v_svc_result_rec);
    end loop;
    commit;
    em_followup_check (p_patient_prev_svc_sn,v_med_cnt,p_qualify_for_em_followup_flag,p_chronic_disease_cnt);
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      raise_application_error(-20100,v_err_msg);
  end svc_result_prc;
END svc_eval_pkg;
/
show errors