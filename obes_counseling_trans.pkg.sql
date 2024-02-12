create or replace PACKAGE obes_counseling_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('obes_counseling_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_status      varchar2(20);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  v_empty_signature clob := 'data:image/png;base64,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';
  v_em_empty_signature clob := 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWgAAACgCAYAAAAhKfa4AAAFX0lEQVR4Xu3UQQ0AAAwCseHf9Gzco1NAysLOESBAgEBSYMlUQhEgQIDAGWhPQIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEHjJsgChzQVwQgAAAABJRU5ErkJggg==';
  --
  function remark_descr (p_remark_categ_grp_code in varchar2) return varchar2;
  function undefined_list_flag(p_list in json_list) return varchar2;
  procedure remark_json_parsing (p_json in varchar2,p_svc_risk_factor_remark_rec OUT svc_risk_factor_remark%rowtype);
  PROCEDURE ins_svc_risk_factor_remark(p_svc_risk_factor_remark_rec  IN OUT  svc_risk_factor_remark%rowtype);
  procedure assessment_json_parsing (p_json in varchar2,p_weight OUT number,p_waist OUT number,p_follow_goals_flag OUT varchar2,p_other_rsn out varchar2,p_missing_goals_rsn_list out json_list);
  procedure create_svc_counseling (p_json_list in varchar2,p_parent_patient_prev_svc_sn in number);
  --
  procedure create_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_out out varchar2);
  procedure update_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_svc_risk_factor_remark_sn in number,p_out out varchar2);
  procedure delete_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_svc_risk_factor_remark_sn in number,p_out out varchar2);
  procedure patient_assessment(p_patient_prev_svc_sn in number,p_svc_number in number,p_awv_waist_in_in in number,p_awv_weight_in_lb in number,p_review_textbox in varchar2,p_assessment_json in varchar2,p_out out varchar2);
  procedure patient_counseling(p_parent_patient_prev_svc_sn in number,p_counseling_json_list in varchar2,p_out out varchar2);
  procedure patient_signature(p_patient_prev_svc_sn in number,p_signature in clob,p_out out varchar2);
  procedure physician_signature(p_patient_prev_svc_sn in number,p_signature in clob,p_out out varchar2,p_approval_flag in varchar2 default 'N');
  procedure oev_rpt_json_clob (p_patient_prev_svc_sn in number);
  procedure osc_rpt_json_clob (p_patient_prev_svc_sn in number);
END obes_counseling_trans_pkg;
/
show errors
create or replace PACKAGE BODY obes_counseling_trans_pkg IS
  function undefined_list_flag(p_list in json_list) return varchar2
  is
    v_str varchar2(100);
    v_cnt pls_integer := 0;
  begin
    for i in 1..json_ac.array_count(p_list) loop
      v_str := json_ac.array_get(p_list,i).get_string;
      if v_str = 'undefined' then
        v_cnt := v_cnt + 1;
      end if;
    end loop;
    --
    if v_cnt > 0 and json_ac.array_count(p_list) = 1 then return 'Y';
    else return 'N';
    end if;
  end undefined_list_flag;
  --
  procedure oev_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an Obesity IBT service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('G0447')
    ;
    if v_cnt > 0 then --Obesity IBT Service
      obes_counseling_pkg.ibt_report_data_init('en-US',p_patient_prev_svc_sn,v_out);
      mdtech_trans_pkg.svc_result_rpt_iu (p_patient_prev_svc_sn,'OEV',v_out);
      commit;
    end if;
  end oev_rpt_json_clob;
  --
  procedure osc_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an Obesity Screening service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('G0449')
    ;
    if v_cnt > 0 then --Obesity Screening Service
      obes_counseling_pkg.screening_report_data_init('en-US',p_patient_prev_svc_sn,v_out);
      mdtech_trans_pkg.svc_result_rpt_iu (p_patient_prev_svc_sn,'OSC',v_out);
      commit;
    end if;
  end osc_rpt_json_clob;
  --
  function req_step_comp_fnc(p_patient_prev_svc_sn in number) return varchar2
  is
    v_patient_prev_svc_rec patient_prev_svc%rowtype;
    v_counseling_cnt pls_integer;
    v_rf_remark_cnt pls_integer;
  begin
    select parent_patient_prev_svc_sn
          ,weight_in_lb
          ,prev_svc_billing_code
    into v_patient_prev_svc_rec.parent_patient_prev_svc_sn
        ,v_patient_prev_svc_rec.weight_in_lb
        ,v_patient_prev_svc_rec.prev_svc_billing_code
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if v_patient_prev_svc_rec.prev_svc_billing_code = 'G0447' then --Obesity Counseling
      if v_patient_prev_svc_rec.weight_in_lb is null then return 'Please complete Assessment.';
      else
        select count(*)
        into v_counseling_cnt
        from svc_counseling
        where patient_prev_svc_sn = v_patient_prev_svc_rec.parent_patient_prev_svc_sn
        and risk_factor_code = 'OBES'
        ;
        if v_counseling_cnt = 0 then return 'Please complete counseling.';
        else
          select count(*)
          into v_rf_remark_cnt
          from svc_risk_factor_remark
          where patient_prev_svc_sn = v_patient_prev_svc_rec.parent_patient_prev_svc_sn
          and remark_categ_grp_code = 'GOAL'
          and risk_factor_code = 'OBES'
          ;
          if v_rf_remark_cnt = 0 then return 'Please complete Treatment Goals and Method.';
          else return null;
          end if;
        end if;
      end if;
    elsif v_patient_prev_svc_rec.prev_svc_billing_code = 'G0449' then --Obesity Screening
      return null;
    else return null;
    end if;
  end req_step_comp_fnc;
  --
  function remark_descr (p_remark_categ_grp_code in varchar2) return varchar2
  is
  begin
    if p_remark_categ_grp_code = 'GOAL' then return 'Treatment Goals';
    elsif p_remark_categ_grp_code = 'TRET' then return 'Medical Treatment';
    elsif p_remark_categ_grp_code = 'RFRL' then return 'Referral';
    end if;
  end remark_descr;
  --
  PROCEDURE ins_svc_risk_factor_remark(p_svc_risk_factor_remark_rec  IN OUT  svc_risk_factor_remark%rowtype) 
  IS
  BEGIN
    INSERT INTO svc_risk_factor_remark (
         svc_risk_factor_remark_SN
        ,PATIENT_PREV_SVC_SN
        ,RISK_FACTOR_CODE
        ,REMARK_CATEG_GRP_CODE
        ,REMARK_CATEG_NAME
        ,REMARK_NOTE
      ) VALUES (
         svc_risk_factor_remark_SNG.nextval
        ,p_svc_risk_factor_remark_rec.PATIENT_PREV_SVC_SN
        ,p_svc_risk_factor_remark_rec.RISK_FACTOR_CODE
        ,p_svc_risk_factor_remark_rec.REMARK_CATEG_GRP_CODE
        ,p_svc_risk_factor_remark_rec.REMARK_CATEG_NAME
        ,p_svc_risk_factor_remark_rec.REMARK_NOTE
      )returning svc_risk_factor_remark_SN
     into p_svc_risk_factor_remark_rec.svc_risk_factor_remark_SN
    ;
  END ins_svc_risk_factor_remark;
  --
  procedure remark_json_parsing (p_json in varchar2,p_svc_risk_factor_remark_rec OUT svc_risk_factor_remark%rowtype)
  as
    obj json;
    tempdata      json_value;
  begin
    --  p_json := '{"TITLE": "Title","DESCRIPTION": "Title Description"}';
    obj    := json(p_json);
    --
    if obj.exist('TITLE') then
      tempdata := obj.get('TITLE');
      if tempdata is not null then
        p_svc_risk_factor_remark_rec.REMARK_CATEG_NAME := tempdata.get_string;
      end if;
    end if;
    --
    if obj.exist('DESCRIPTION') then
      tempdata := obj.get('DESCRIPTION');
      if tempdata is not null then
        p_svc_risk_factor_remark_rec.REMARK_NOTE := tempdata.get_string;
      end if;
    end if;
  end remark_json_parsing;
  --
  procedure assessment_json_parsing (p_json in varchar2,p_weight OUT number,p_waist OUT number,p_follow_goals_flag OUT varchar2,p_other_rsn out varchar2,p_missing_goals_rsn_list out json_list)
  as
    obj           json;
    tempdata      json_value;
  begin
    --  p_json := '{"WEIGHT": 155,"WAIST": 40,"FOLLOW_GOALS_FLAG": "N","MISSING_GOALS_RSN_CODE": ["101", "105"],"OTR_RSN": "Other reasons"}';
    obj    := json(p_json);
    --
    if obj.exist('WEIGHT') then
      tempdata := obj.get('WEIGHT');
      if tempdata is not null then
        p_weight := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('WAIST') then
      tempdata := obj.get('WAIST');
      if tempdata is not null then
        p_waist := tempdata.get_number;
      end if;
    end if;
    --
    if obj.exist('FOLLOW_GOALS_FLAG') then
      tempdata := obj.get('FOLLOW_GOALS_FLAG');
      if tempdata is not null then
        if tempdata.get_string = 'null' then
          p_follow_goals_flag := null;
        else
          p_follow_goals_flag := tempdata.get_string;
        end if;
      end if;
    end if;
    --
    if obj.exist('OTR_RSN') then
      tempdata := obj.get('OTR_RSN');
      if tempdata is not null then
        p_other_rsn := trim(tempdata.get_string);
      end if;
    end if;
    --
    if obj.exist('MISSING_GOALS_RSN_CODE') then
      tempdata := obj.get('MISSING_GOALS_RSN_CODE');
      if (tempdata.is_array) then
        p_missing_goals_rsn_list := json_list(tempdata);
      end if;
    end if;
  end assessment_json_parsing;
  --
  function missing_other_rsn_text_flag (p_other_reason_text in varchar2,p_json_list in json_list) return varchar2
  is
    v_cnt pls_integer := 0;
    v_svc_rf_missing_goals_reason svc_rf_missing_goals_reason%rowtype;
  begin
    for i in 1..json_ac.array_count(p_json_list) loop
      v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE := json_ac.array_get(p_json_list,i).get_string;
      if v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE = '105' then
        v_cnt := v_cnt + 1;
      end if;
    end loop;
    if p_other_reason_text is null and v_cnt > 0 then return 'Y';
    else return 'N';
    end if;
  end missing_other_rsn_text_flag;
  --
  function sc_req_attrib_missing_flag (p_json_list in json_list) return varchar2
  as
    obj json;
    tempdata      json_value;
    v_svc_counseling svc_counseling%rowtype;
    v_cnt pls_integer := 0;
  begin
    --  p_json_list := '[{"RF_COUNSELING_CATEG_CODE": "MEDRX","COMPLIANCE_FLAG": "Y","OUTCOME": "Medrx Outcome"},{"RF_COUNSELING_CATEG_CODE": "NUTRI","COMPLIANCE_FLAG": "N","OUTCOME": "Nutrition Outcome"},{"RF_COUNSELING_CATEG_CODE": "INACT","COMPLIANCE_FLAG": "Y","OUTCOME": "Inactive Outcome"},{"RF_COUNSELING_CATEG_CODE": "DISEU","COMPLIANCE_FLAG": "Y","OUTCOME": "Disease Outcome"},{"RF_COUNSELING_CATEG_CODE": "BEHAV","COMPLIANCE_FLAG": "Y","OUTCOME": "Behavioral Outcome"}]';
    for i in 1..json_ac.array_count(p_json_list) loop
      obj    := json(json_ac.array_get(p_json_list,i));
      if obj.exist('RF_COUNSELING_CATEG_CODE') then
        tempdata := obj.get('RF_COUNSELING_CATEG_CODE');
        if tempdata is not null then
          v_svc_counseling.RF_COUNSELING_CATEG_CODE := tempdata.get_string;
        end if;
      end if;
      if obj.exist('COMPLIANCE_FLAG') then
        tempdata := obj.get('COMPLIANCE_FLAG');
        if tempdata is not null then
          v_svc_counseling.COMPLIANCE_FLAG := tempdata.get_string;
        end if;
      end if;
      if obj.exist('OUTCOME') then
        tempdata := obj.get('OUTCOME');
        if tempdata is not null then
          v_svc_counseling.COUNSELING_OUTCOME := tempdata.get_string;
        end if;
      end if;
      --
      if v_svc_counseling.RF_COUNSELING_CATEG_CODE is null or v_svc_counseling.COMPLIANCE_FLAG is null or v_svc_counseling.COUNSELING_OUTCOME is null then
        v_cnt := v_cnt + 1;
      end if;
    end loop;
    --
    if v_cnt > 0 then return 'Y';
    else return 'N';
    end if;
  end sc_req_attrib_missing_flag;  
  --
  procedure create_svc_counseling (p_json_list in varchar2,p_parent_patient_prev_svc_sn in number)
  as
    obj json;
    l_obj json_list;
    tempdata      json_value;
    v_svc_counseling svc_counseling%rowtype;
  begin
    --  p_json_list := '[{"RF_COUNSELING_CATEG_CODE": "MEDRX","COMPLIANCE_FLAG": "Y","OUTCOME": "Medrx Outcome"},{"RF_COUNSELING_CATEG_CODE": "NUTRI","COMPLIANCE_FLAG": "N","OUTCOME": "Nutrition Outcome"},{"RF_COUNSELING_CATEG_CODE": "INACT","COMPLIANCE_FLAG": "Y","OUTCOME": "Inactive Outcome"},{"RF_COUNSELING_CATEG_CODE": "DISEU","COMPLIANCE_FLAG": "Y","OUTCOME": "Disease Outcome"},{"RF_COUNSELING_CATEG_CODE": "BEHAV","COMPLIANCE_FLAG": "Y","OUTCOME": "Behavioral Outcome"}]';
    l_obj := json_list(p_json_list);
    for i in 1..json_ac.array_count(l_obj) loop
      obj    := json(json_ac.array_get(l_obj,i));
      if obj.exist('RF_COUNSELING_CATEG_CODE') then
        tempdata := obj.get('RF_COUNSELING_CATEG_CODE');
        if tempdata is not null then
          v_svc_counseling.RF_COUNSELING_CATEG_CODE := tempdata.get_string;
        end if;
      end if;
      if obj.exist('COMPLIANCE_FLAG') then
        tempdata := obj.get('COMPLIANCE_FLAG');
        if tempdata is not null then
          v_svc_counseling.COMPLIANCE_FLAG := tempdata.get_string;
        end if;
      end if;
      if obj.exist('OUTCOME') then
        tempdata := obj.get('OUTCOME');
        if tempdata is not null then
          v_svc_counseling.COUNSELING_OUTCOME := tempdata.get_string;
        end if;
      end if;
      begin
        insert into svc_counseling (svc_counseling_sn,patient_prev_svc_sn,rf_counseling_categ_code,risk_factor_code,compliance_flag,counseling_outcome)
        values (svc_counseling_sng.nextval,p_parent_patient_prev_svc_sn,v_svc_counseling.RF_COUNSELING_CATEG_CODE,'OBES',v_svc_counseling.COMPLIANCE_FLAG,v_svc_counseling.COUNSELING_OUTCOME);
      exception
        when dup_val_on_index then
          update svc_counseling
          set COMPLIANCE_FLAG = v_svc_counseling.COMPLIANCE_FLAG
              ,COUNSELING_OUTCOME = v_svc_counseling.COUNSELING_OUTCOME
          where patient_prev_svc_sn = p_parent_patient_prev_svc_sn
          and risk_factor_code = 'OBES'
          and rf_counseling_categ_code = v_svc_counseling.RF_COUNSELING_CATEG_CODE
          ;
      end;
    end loop;
  end create_svc_counseling;
  --
  procedure create_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_svc_risk_factor_remark_rec   svc_risk_factor_remark%rowtype;
    v_cnt pls_integer;
    v_active_flag varchar2(1);
    v_svc_risk_factor_remark_sn number(11);
  begin
    v_proc_name := upper('create_svc_risk_factor_remark');
    v_input_str := 'p_json: '||p_json||'-p_parent_patient_prev_svc_sn: '||p_parent_patient_prev_svc_sn||'-p_remark_categ_grp_code: '||p_remark_categ_grp_code;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse input JSON
    remark_json_parsing(p_json,v_svc_risk_factor_remark_rec);
    --Assign other required column value
    v_svc_risk_factor_remark_rec.patient_prev_svc_sn := p_parent_patient_prev_svc_sn;
    v_svc_risk_factor_remark_rec.remark_categ_grp_code := p_remark_categ_grp_code;
    v_svc_risk_factor_remark_rec.risk_factor_code := 'OBES';
    --Required field validation
    if p_parent_patient_prev_svc_sn is null or p_remark_categ_grp_code is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Title is required.';
    elsif v_svc_risk_factor_remark_rec.REMARK_NOTE is null then
      v_status := 'FAILED';
      v_msg := 'Title description is required.';
    else
      begin
        --Insert
        ins_svc_risk_factor_remark(v_svc_risk_factor_remark_rec);
        v_status := 'SUCCESSFUL';
        v_msg := remark_descr(p_remark_categ_grp_code)||' record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
                ,svc_risk_factor_remark_sn
          into v_active_flag
              ,v_svc_risk_factor_remark_sn
          from svc_risk_factor_remark
          where patient_prev_svc_sn = v_svc_risk_factor_remark_rec.patient_prev_svc_sn
          and risk_factor_code = v_svc_risk_factor_remark_rec.risk_factor_code
          and remark_categ_grp_code = v_svc_risk_factor_remark_rec.remark_categ_grp_code
          and upper(REMARK_CATEG_NAME) = upper(trim(v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME))
          ;
          if v_active_flag = 'Y' then
            --active record exist
            v_status := 'FAILED';
            v_msg := 'Title ('||v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME||') already exist.';
          else
            --record exist but inactive. update the record with new REMARK_NOTE and make it it active
            update svc_risk_factor_remark
            set REMARK_NOTE = v_svc_risk_factor_remark_rec.REMARK_NOTE
               ,ACTIVE_FLAG = 'Y'
            where svc_risk_factor_remark_sn = v_svc_risk_factor_remark_sn
            ;
            v_status := 'SUCCESSFUL';
            v_msg := remark_descr(p_remark_categ_grp_code)||' record has been created successfully.';
          end if;
        when others then
          v_err_msg := SUBSTR (SQLERRM,1,100);
          common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
          --
          v_status := 'FAILED';
          v_msg := 'Unexpected errors. Please contact customer support.';
      end;
    end if;
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;    
  end create_svc_risk_factor_remark;
  --
  procedure update_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_svc_risk_factor_remark_sn in number,p_out out varchar2)
  is
    obj json := json();
    v_svc_risk_factor_remark_rec   svc_risk_factor_remark%rowtype;
    v_cnt pls_integer;
  begin
    v_proc_name := upper('update_svc_risk_factor_remark');
    v_input_str := 'p_svc_risk_factor_remark_sn: '||p_svc_risk_factor_remark_sn||'-p_parent_patient_prev_svc_sn: '||p_parent_patient_prev_svc_sn||'-p_remark_categ_grp_code: '||p_remark_categ_grp_code||'-p_json: '||p_json; 
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse input JSON
    remark_json_parsing(p_json,v_svc_risk_factor_remark_rec);
    --Required field validation
    if p_parent_patient_prev_svc_sn is null or p_remark_categ_grp_code is null or p_svc_risk_factor_remark_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Title is required.';
    elsif v_svc_risk_factor_remark_rec.REMARK_NOTE is null then
      v_status := 'FAILED';
      v_msg := 'Title description is required.';
    else
      --Update process
      select count(*)
      into v_cnt
      from svc_risk_factor_remark
      where patient_prev_svc_sn = p_parent_patient_prev_svc_sn
      and risk_factor_code = 'OBES'
      and remark_categ_grp_code = p_remark_categ_grp_code
      and upper(REMARK_CATEG_NAME) = upper(trim(v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME))
      ;
      if v_cnt = 1 then
        --if name exist, then don't update the name to avoid duplicate key violation
        update svc_risk_factor_remark
        set REMARK_NOTE = v_svc_risk_factor_remark_rec.REMARK_NOTE
        where svc_risk_factor_remark_sn = p_svc_risk_factor_remark_sn
        ;
      else
        update svc_risk_factor_remark
        set REMARK_NOTE = v_svc_risk_factor_remark_rec.REMARK_NOTE
           ,REMARK_CATEG_NAME = v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME
        where svc_risk_factor_remark_sn = p_svc_risk_factor_remark_sn
        ;
      end if;
      --
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := remark_descr(p_remark_categ_grp_code)||' record updated successfully.';
      else
        v_status := 'FAILED';
        v_msg := remark_descr(p_remark_categ_grp_code)||' record update failed.';
      end if;
      commit;
    end if;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;    
  end update_svc_risk_factor_remark;
  --
  procedure delete_svc_risk_factor_remark(p_json in varchar2,p_parent_patient_prev_svc_sn in number,p_remark_categ_grp_code in varchar2,p_svc_risk_factor_remark_sn in number,p_out out varchar2)
  is
    obj json := json();
    v_svc_risk_factor_remark_rec   svc_risk_factor_remark%rowtype;
  begin
    v_proc_name := upper('delete_svc_risk_factor_remark');
    v_input_str := 'p_svc_risk_factor_remark_sn: '||p_svc_risk_factor_remark_sn||'-p_parent_patient_prev_svc_sn: '||p_parent_patient_prev_svc_sn||'-p_remark_categ_grp_code: '||p_remark_categ_grp_code||'-p_json: '||p_json; 
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse input JSON
    remark_json_parsing(p_json,v_svc_risk_factor_remark_rec);
    --Required field validation
    if p_parent_patient_prev_svc_sn is null or p_remark_categ_grp_code is null or p_svc_risk_factor_remark_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Title is required.';
    elsif v_svc_risk_factor_remark_rec.REMARK_NOTE is null then
      v_status := 'FAILED';
      v_msg := 'Title description is required.';
    else
      update svc_risk_factor_remark
      set active_flag = 'N'
      where svc_risk_factor_remark_sn = p_svc_risk_factor_remark_sn
      ;
      --
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := remark_descr(p_remark_categ_grp_code)||' record for the title '||v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME||' has been deleted successfully.';
      else
        v_status := 'FAILED';
        v_msg := remark_descr(p_remark_categ_grp_code)||' record for the title '||v_svc_risk_factor_remark_rec.REMARK_CATEG_NAME||' delete failed.';
      end if;  
    end if;
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;
  end delete_svc_risk_factor_remark;
  --
  procedure patient_assessment(p_patient_prev_svc_sn in number,p_svc_number in number,p_awv_waist_in_in in number,p_awv_weight_in_lb in number,p_review_textbox in varchar2,p_assessment_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_missing_goals_rsn_list json_list;
    v_patient_prev_svc_rec patient_prev_svc%rowtype;
    v_svc_rf_missing_goals_reason svc_rf_missing_goals_reason%rowtype; 
    v_goals_achived_flag varchar2(1) := 'Y';
    v_parent_patient_prev_svc_sn number(11);
    v_waist_in_in number(9,3);
    v_goal_pp_prev_svc_sn number(11);
  begin
    v_proc_name := upper('patient_assessment');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_svc_number: '||p_svc_number||'-p_awv_waist_in_in: '||p_awv_waist_in_in||'-p_awv_weight_in_lb: '||p_awv_weight_in_lb||'-p_review_textbox: '||p_review_textbox||'-p_assessment_json: '||p_assessment_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse input JSON
    assessment_json_parsing (p_assessment_json,v_patient_prev_svc_rec.weight_in_lb,v_patient_prev_svc_rec.waist_in_in,v_patient_prev_svc_rec.FOLLOWED_RF_THERAPY_GOALS_FLAG,v_svc_rf_missing_goals_reason.OTHER_REASON_TEXT,v_missing_goals_rsn_list);
    ---
    if obes_counseling_pkg.review_needed_flag(p_svc_number) = 'Y' then
      select parent_patient_prev_svc_sn
      into v_goal_pp_prev_svc_sn
      from patient_prev_svc
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      v_goals_achived_flag := obes_counseling_pkg.weight_cng_goal_achieve_flag(v_goal_pp_prev_svc_sn,p_svc_number,p_awv_weight_in_lb);
    end if;
    --Check required fields
    if p_patient_prev_svc_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif v_patient_prev_svc_rec.weight_in_lb is null or v_patient_prev_svc_rec.weight_in_lb = 0 then
      v_status := 'FAILED';
      v_msg := 'Patient Weight assessment is required.';
    elsif v_patient_prev_svc_rec.waist_in_in is null or v_patient_prev_svc_rec.waist_in_in = 0 then
      v_status := 'FAILED';
      v_msg := 'Patient Waist assessment is required.';
    elsif v_patient_prev_svc_rec.FOLLOWED_RF_THERAPY_GOALS_FLAG is null then
      v_status := 'FAILED';
      v_msg := 'Whether Patient followed Risk Factor Therapy Goals Indicator is required.';
    elsif v_patient_prev_svc_rec.FOLLOWED_RF_THERAPY_GOALS_FLAG = 'N' and (json_ac.array_count(v_missing_goals_rsn_list) = 0 or undefined_list_flag(v_missing_goals_rsn_list) = 'Y') then
      v_status := 'FAILED';
      v_msg := 'Please select the reason(s) of WHY patient did not follow the plan.';
    elsif missing_other_rsn_text_flag (v_svc_rf_missing_goals_reason.OTHER_REASON_TEXT,v_missing_goals_rsn_list) = 'Y' then --check if other reason has been selected
      v_status := 'FAILED';
      v_msg := 'When Patient chooses Other Reasons for missing goals, Patient needs to explain the reason.';
    elsif obes_counseling_pkg.review_needed_flag(p_svc_number) = 'Y' and v_goals_achived_flag = 'N' and p_review_textbox is null then
      v_status := 'FAILED';
      v_msg := 'Please explain why patient did not achieve weight reduction goals.';
    else
      if json_ac.array_count(v_missing_goals_rsn_list) > 0 or v_patient_prev_svc_rec.FOLLOWED_RF_THERAPY_GOALS_FLAG = 'Y' then
        --inactive all the records (if exist). they will be activated again. this logic is put in place, if user try to make any correction on
        --the records submitted before or swith between Y/N for follow flag
        for i in (select smgr.rf_missing_goals_reason_code
                  from rf_missing_goals_reason_vw rfmgr_vw
                      ,svc_rf_missing_goals_reason smgr
                  where rfmgr_vw.rf_missing_goals_reason_code = smgr.rf_missing_goals_reason_code
                  and rfmgr_vw.risk_factor_code = 'OBES'
                  and smgr.patient_prev_svc_sn = p_patient_prev_svc_sn
                  and smgr.active_flag = 'Y'
                  )
        loop                  
          update svc_rf_missing_goals_reason
          set active_flag = 'N'
          where patient_prev_svc_sn = p_patient_prev_svc_sn
          and rf_missing_goals_reason_code = i.rf_missing_goals_reason_code
          ;
        end loop;
      end if;
      --Process the assessment record
      for i in 1..json_ac.array_count(v_missing_goals_rsn_list) loop
        v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE := json_ac.array_get(v_missing_goals_rsn_list,i).get_string;
        if v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE = '105' then --other reason code
          begin
            insert into svc_rf_missing_goals_reason (patient_prev_svc_sn,rf_missing_goals_reason_code,other_reason_text)
            values (p_patient_prev_svc_sn,v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE,v_svc_rf_missing_goals_reason.OTHER_REASON_TEXT);
          exception
            when DUP_VAL_ON_INDEX then
              update svc_rf_missing_goals_reason
              set active_flag = 'Y'
                  ,other_reason_text = v_svc_rf_missing_goals_reason.OTHER_REASON_TEXT
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and RF_MISSING_GOALS_REASON_CODE = v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE
              ;
          end;
        else
          begin
            insert into svc_rf_missing_goals_reason (patient_prev_svc_sn,rf_missing_goals_reason_code)
            values (p_patient_prev_svc_sn,v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE);      
          exception
            when DUP_VAL_ON_INDEX then
              update svc_rf_missing_goals_reason
              set active_flag = 'Y'
              where patient_prev_svc_sn = p_patient_prev_svc_sn
              and RF_MISSING_GOALS_REASON_CODE = v_svc_rf_missing_goals_reason.RF_MISSING_GOALS_REASON_CODE
              ;
          end;
        end if;
      end loop;
      --Track goals_achived_flag for every service. If function review_needed_flag = Y, then update
      --obes_counseling_pkg.review_needed_flag(p_svc_number) = 'Y' then
      update patient_prev_svc
      set weight_in_lb = v_patient_prev_svc_rec.weight_in_lb
         ,waist_in_in = v_patient_prev_svc_rec.waist_in_in
         ,followed_rf_therapy_goals_flag = v_patient_prev_svc_rec.FOLLOWED_RF_THERAPY_GOALS_FLAG
         ,goals_achived_flag = v_goals_achived_flag
         ,reason_of_not_achiving_goals = p_review_textbox
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      returning parent_patient_prev_svc_sn into v_parent_patient_prev_svc_sn
      ;
      if p_svc_number = 1 then
        --if the parent (awv) svc waist was not captured, then update the parent record with the first serevice waist_in_in
        if p_awv_waist_in_in is null then
          update patient_prev_svc
          set waist_in_in = v_patient_prev_svc_rec.waist_in_in
          where patient_prev_svc_sn = v_parent_patient_prev_svc_sn
          ;
        end if;
      end if;
      --
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'Patient Assessment has been completed successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'Patient Assessment failed. Please contact customer support.';
      end if;
    end if;
    --
    commit;
    --
    if v_status = 'FAILED' then
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_msg,null,v_input_str,null);
    end if;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;
  end patient_assessment;
  --
  procedure patient_counseling(p_parent_patient_prev_svc_sn in number,p_counseling_json_list in varchar2,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('patient_counseling');
    v_input_str := 'p_parent_patient_prev_svc_sn: '||p_parent_patient_prev_svc_sn||'-p_counseling_json_list: '||p_counseling_json_list;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Check required fields
    if p_parent_patient_prev_svc_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif sc_req_attrib_missing_flag(json_list(p_counseling_json_list)) = 'Y' then
      v_status := 'FAILED';
      v_msg := 'Patient counseling required field value is missing.';
    else
      --Create svc_counseling records
      create_svc_counseling (p_counseling_json_list,p_parent_patient_prev_svc_sn);
      v_status := 'SUCCESSFUL';
      v_msg := 'Patient Counseling has been completed successfully.';
    end if;
    --
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;
  end patient_counseling;
  --
  procedure patient_signature(p_patient_prev_svc_sn in number,p_signature in clob,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('patient_signature');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_signature: '||p_signature;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Check required fields
    if p_patient_prev_svc_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif p_signature is null or p_signature = v_empty_signature then
      v_status := 'FAILED';
      v_msg := 'Patient Signature is required input parameter.';
    else
      update patient_prev_svc
      set patient_signature = p_signature
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'Patient Signature has been submitted successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'Patient Signature submission failed. Please contact customer support.';
      end if;
    end if;
    --
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;
  end patient_signature;
  --
  function rx_prev_svc_billing_code_fnc(p_prev_svc_billing_code in varchar2,p_approval_flag in varchar2) return patient_prev_svc_rec.rx_prev_svc_billing_code%type
  is
    v_rx_prev_svc_billing_code patient_prev_svc_rec.rx_prev_svc_billing_code%type;
  begin
    if v_patient_prev_svc_rec.prev_svc_billing_code = 'G0449' then --Obesity Screening
      if p_approval_flag = 'Y' then
        v_rx_prev_svc_billing_code := 'G0447'; --Obesity Counseling
      else
        v_rx_prev_svc_billing_code := null;
      end if;
    else
      v_rx_prev_svc_billing_code := null;
    end if;
    return v_rx_prev_svc_billing_code;
  end rx_prev_svc_billing_code_fnc;
  --
  procedure physician_signature(p_patient_prev_svc_sn in number,p_signature in clob,p_out out varchar2,p_approval_flag in varchar2 default 'N')
  is
    obj json := json();
    v_req_step_msg varchar2(1000);
    v_patient_prev_svc_rec patient_prev_svc%rowtype;
  begin
    v_proc_name := upper('physician_signature');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_signature: '||p_signature||'-p_approval_flag: '||p_approval_flag;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Check required fields
    if p_patient_prev_svc_sn is null then
      v_status := 'FAILED';
      v_msg := 'Missing required input parameter.';
    elsif p_signature is null or p_signature = v_empty_signature then
      v_status := 'FAILED';
      v_msg := 'Physician Signature is required input parameter.';
    else
      select parent_patient_prev_svc_sn
            ,prev_svc_billing_code
      into v_patient_prev_svc_rec.parent_patient_prev_svc_sn
          ,v_patient_prev_svc_rec.prev_svc_billing_code
      from patient_prev_svc
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      v_patient_prev_svc_rec.rx_prev_svc_billing_code := rx_prev_svc_billing_code_fnc(v_patient_prev_svc_rec.prev_svc_billing_code,p_approval_flag);
      --check requied section/steps completion
      v_req_step_msg := req_step_comp_fnc(p_patient_prev_svc_sn);
      --
      if v_req_step_msg is not null then
        v_status := 'FAILED';
        v_msg := v_req_step_msg;      
      else
        update patient_prev_svc
        set physician_signature = p_signature
           ,svc_comp_flag = 'Y'
           ,svc_perform_date = sysdate
           ,rx_prev_svc_billing_code = v_patient_prev_svc_rec.rx_prev_svc_billing_code
        where patient_prev_svc_sn = p_patient_prev_svc_sn
        ;
        if sql%rowcount = 1 then
          if v_patient_prev_svc_rec.prev_svc_billing_code = 'G0447' then --Obesity Counseling
            oev_rpt_json_clob(p_patient_prev_svc_sn);
          elsif v_patient_prev_svc_rec.prev_svc_billing_code = 'G0449' then --Obesity Screening
            osc_rpt_json_clob(p_patient_prev_svc_sn);
          end if;
          v_status := 'SUCCESSFUL';
          v_msg := 'Physician Signature has been submitted successfully.';
        else
          v_status := 'FAILED';
          v_msg := 'Physician Signature submission failed. Please contact customer support.';
        end if;
      end if;
    end if;
    --
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_msg);
    p_out := obj.to_char;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      obj.put('STATUS','FAILED');
      obj.put('MSG',v_err_msg);
      --
      p_out := obj.to_char;
  end physician_signature;
END obes_counseling_trans_pkg;
/
show errors  