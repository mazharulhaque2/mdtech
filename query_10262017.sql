select * from pps_simplified_vw where patient_prev_svc_sn in (124,26,35,63,72);
select * from svc_result_rpt where patient_prev_svc_sn = 78;
select * from svc_result_vw where disease_code = 'STRK' and disease_level_code <> 'LOW' and disease_severity_code = 'RISKA';
select * from disease_risk_factor_vw where disease_code = 'BDIS';
select * from disease_vw where disease_code = 'BDIS';
select * from risk_factor_vw where diet_categ_flag = 'Y';
--
select * from question_response_vw where billing_code = 'G0438' and category_code = 'BMEDH' order by question_order_num, question_response_order_num; --BMEDH BEHVT FHNMR
select distinct category_code from question_response_vw where billing_code = 'G0438' and category_code = 'FHNMR' and response_code = 'CBX';
select * from patient_response_vw where patient_prev_svc_sn = 290 and category_code = 'BMEDH';
select * from disease_risk_factor_vw where disease_code = 'OBES';
select * from list_prev_svc_type;

select * from question_response_vw where billing_code = 'G0438' and upper(question) like '%WEIGHT%';
--
select * from categ_score_eval_vw where category_code = 'HSLFA';
select * from disease_vw;
select * from disease_categ_lang;
select * from risk_factor_vw;
select * from disease_risk_factor_vw where disease_code = 'CKDE';
select * from user_svc_location_vw;
select * from svc_rpt_type_lang;
select * from patient_vw;
select json_ac.array_to_char(report_pkg.disease_rf(35,'CKDE','Y','Overweight',28.2,87,'AIAN','MAL','ONSS')) from dual;
select svc_eval_pkg.risk_factor_level(35,'CKDE',87,'MAL','AIAN',null,'Overweight','Hypertension','ONSS') from dual;
--
--set serveroutput on
--declare
--  l_obj json_list := json_list();
--  v_lbl varchar2(3);
--begin
----  l_obj := report_pkg.disease_rf(35,'CKDE','Y','Overweight',28.2,87,'AIAN','MAL','ONSS');
----  dbms_output.put_line('final l_obj cnt '||json_ac.array_count(l_obj));
--  v_lbl := svc_eval_pkg.risk_factor_level(35,'CKDE',87,'MAL','AIAN',null,'Overweight','Hypertension','ONSS');
--end;
--/

--set serveroutput on
--declare
--  obj json;
--begin
--  obj := obes_counseling_pkg.patient_rf(59);
--  obj.print;
--end;
--/
--set serveroutput on
--set feedback off
--declare
--  l_obj json_list;
--begin
--  l_obj := obes_counseling_pkg.patient_rf_list(59);
--  l_obj.print;
--end;
--/
--
