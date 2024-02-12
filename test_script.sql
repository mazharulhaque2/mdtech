--sqlplus to AWS
--sqlplus MDTECH@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=pamdasdev.cdv2t6nuumtt.us-east-1.rds.amazonaws.com)(PORT=1521))(CONNECT_DATA=(SID=APPSDEV)))
--sqlplus MDTECH@TNSNAMES (preferred one)
--
--select json_ac.array_to_char(report_pkg.disease_rf(35,'CKDE','N','Overweight',28.2,87,'AIAN','MAL','ONSS')) from dual;
--
--update question_response
--set disease_level_code = 'LOW'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'LTW'
--;
--delete from patient_response
--where question_response_code in (select question_response_code 
--                                from question_response 
--                                where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--                                and RESPONSE_CODE = 'CBX'
--                                )
--                                ;
--delete from question_response 
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--and RESPONSE_CODE = 'CBX'
--;
-----==============Steps. Create service provider record and then assign to one or many location===============
-----=========During the new user role assignment, user needs to be assigned to a company too.
-----===========Company and Company Service Location MUST be created before doing any activities for a user/physician/provider
--update "AspNetUsers"
--set company_sn = 11
--where "UserName" = '';
--commit;
------------Assign the location where user have priviledge to run report for the patients under those locations
--insert into user_svc_location (USER_SVC_LOCATION_SN,USER_ROLE_ID,SVC_LOCATION_SN,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (USER_SVC_LOCATION_SNG.nextval,'5C4FC97C26582FBDE0530100007F4833',1,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--commit;
--
--insert into patient_prev_svc_remark (PATIENT_PREV_SVC_REMARK_SN,PATIENT_PREV_SVC_SN,REMARK_NOTE)
--values (PATIENT_PREV_SVC_REMARK_SNG.nextval,10,'She is a dancer and goes to Pilates and yoga classes. She is also acting and regularly puts on shows for her community.');
--commit;
--
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,11,'name','doses','MG','1D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--commit;
--
----Xfer patient from one physician to other. If there is a open service (not complete) for that patient and service has not started, then
----service location also needs to be updated
--update patient
--set physician_sn = 3
--where patient_sn = 28
--;
--update patient_prev_svc
--set physician_svc_location_sn = 3
--where patient_prev_svc_sn = 32
--;
--
--Xfer service from one service provider to other
---------6 (Bethania); 5 (Madyan)
--update patient_prev_svc
--set provider_physician_sn = 6
--where patient_prev_svc_sn = 79
--;
--commit;
--========================= smtp data dictionary
select * from dba_network_acls;
--==========================dbms scheduler data dictionary
SELECT * FROM ALL_SCHEDULER_RUNNING_JOBS where owner = 'IAPPHEALTH';
select * from dba_scheduler_jobs where owner = 'IAPPHEALTH';
select * from DBA_SCHEDULER_SCHEDULES where owner = 'IAPPHEALTH';
select * from DBA_SCHEDULER_PROGRAMS where owner = 'IAPPHEALTH';
select * from DBA_SCHEDULER_PROGRAM_ARGS;
--DBMS_SCHEDULER.DROP_JOB       (job_name         IN VARCHAR2,force    IN BOOLEAN DEFAULT FALSE);
--DBMS_SCHEDULER.DROP_PROGRAM   (program_name     IN VARCHAR2,force    IN BOOLEAN DEFAULT FALSE);
--DBMS_SCHEDULER.DROP_SCHEDULE  (schedule_name    IN VARCHAR2,force    IN BOOLEAN DEFAULT FALSE);
--begin
--  DBMS_SCHEDULER.DROP_JOB       ('DAILY_2AM_JOB');
--end;
--/
--begin
--  dbms_scheduler.enable('DELETE_PENDING_SVC_JOB');
--  --dbms_scheduler.disable('TEST_JOB');
--end;
--/
--To  run a job immediately
--begin
--  dbms_scheduler.run_job (job_name => 'DELETE_PENDING_SVC_JOB');
--end;
--/
---Running jobs can be stopped using the dbms_scheduler.stop_jobprocedure.
--begin
--  dbms_scheduler.stop_job (job_name => 'run_load_sales');
--end;
--/
--==============================History data
select hc.col_name,hc.*
from appl_hist_col hc
    ,appl_hist_table ht
    ,history_data hd
where hc.appl_hist_table_num = ht.appl_hist_table_num
and hc.appl_hist_col_num = hd.appl_hist_col_num (+)
and hc.appl_hist_table_num = hd.appl_hist_table_num (+)
and hc.table_name = 'ASPNETUSERROLES'
--and hd.parent_unique_key = '34AE2581A9224784AD69DA693D235E1F'
;
--============================User Login
select *
from user_login_vw
where user_role_id = '5F857E963E781B4CE0530100007F1D4A'
--and to_number(to_char(login_datetime,'HH24')) > 17
and login_datetime between '10-JAN-2018' and '11-JAN-2018'
order by login_datetime desc
;
--==========================AWV Interview time
select *
from interview_time_vw
where old_system_flag = 'N'
and provider_physician_name = 'Madyan Al Troudy'
--and patient_prev_svc_sn = 80
;
--=====================Pending patient response
select pps.* 
from patient_response pr
    ,patient_prev_svc pps
where pps.patient_prev_svc_sn = pr.patient_prev_svc_sn
and pps.svc_comp_flag = 'N'
;
--Billing query
select pat_name patient_name
      ,pat_birth_date birth_date
      ,pat_medicare_hic_num_full hic_num
      ,svc_perform_date service_date
      ,svc_type_code service_type
      ,case
        when g0438_comp_on_diff_sys_flag = 'Y' then 'G0439'
        else 'G0438'
        end billing_code
      ,svc_location_name service_location
      ,physician_title||' '||pat_primary_physician_name physician
      ,provider_title||' '||provider_physician_name interviewer
from pps_simplified_vw 
where completed_flag = 'Y'
and sub_prev_svc_billing_code is null
order by svc_location_name,svc_perform_date
;
--
select qcgl.short_descr section
      ,qcl.short_descr category
      ,nvl(pqcl.short_descr,qcl.short_descr) parent_category
      ,q.question_code
      ,q.CONDITIONAL_QUESTION_FLAG
      ,pq.question_code parent_question_code
      ,ql.short_descr question
--      ,qr.response_code
--      ,qr.question_response_code
from question q
    ,question_lang ql
--    ,question_response qr
    ,list_question_categ lqc
    ,question_categ_lang qcl
    ,list_prev_svc_billing lpsb
    ,list_question_categ_grp lqcg
    ,question_categ_grp_lang qcgl
    ,svc_billing_question_categ sbqc
    ,list_prev_svc_type pst
    --
    ,list_question_categ plqc
    ,question_categ_lang pqcl
    ,question pq
    ,question_lang pql
where q.question_sn = ql.question_sn
and ql.lang_code = 'en'
--and q.question_sn = qr.question_sn
and q.question_categ_code = lqc.question_categ_code
and lqc.question_categ_code = qcl.question_categ_code
and qcl.lang_code = 'en'
and lqc.question_categ_grp_code = lqcg.question_categ_grp_code
and lqcg.question_categ_grp_code = qcgl.question_categ_grp_code
and qcgl.lang_code = 'en'
--
and lqc.question_categ_code = sbqc.question_categ_code
and lpsb.prev_svc_billing_code = sbqc.prev_svc_billing_code
and lpsb.prev_svc_type_code = pst.prev_svc_type_code
--
and lqc.parent_question_categ_code = plqc.question_categ_code(+)
and plqc.question_categ_code = pqcl.question_categ_code(+)
and pqcl.lang_code(+) = 'en'
and q.parent_question_sn = pq.question_sn (+)
and pq.question_sn = pql.question_sn (+)
and pql.lang_code(+) = 'en'
and pst.prev_svc_type_code = 'AWV'
and lqc.question_categ_code = 'FRLT2'
order by sbqc.order_num,q.question_code
;
--=====================================================Menu Query
select r."Name"
      ,rp.*
      ,pl.* 
from "AspNetRoles" r
    ,list_priviledge p
    ,priviledge_lang pl
    ,roles_priviledge rp
    ,list_priviledge_type pt
    ,priviledge_type_lang ptl
where rp.role_id = r."Id"
and rp.priviledge_code = p.priviledge_code
and p.priviledge_code = pl.priviledge_code
and pl.lang_code = 'en'
--
and p.priviledge_type_code = pt.priviledge_type_code
and pt.priviledge_type_code = ptl.priviledge_type_code
and ptl.lang_code = 'en'
--and pt.priviledge_type_code = 'USI'
and (('N' = 'Y' and (p.client_only_priviledge_flag = 'Y' or p.common_priviledge_flag = 'Y')) or ('N' = 'N' and p.client_only_priviledge_flag = 'N'))
--and r."Name" = 'Super Admin'
;
select p.priviledge_code
      ,uil.*
from list_priviledge p
    ,priviledge_lang pl
    ,priviledge_ui pu
    ,list_ui ui
    ,ui_lang uil
where pu.priviledge_code = p.priviledge_code
and p.priviledge_code = pl.priviledge_code
and pl.lang_code = 'en'
and pu.ui_code = ui.ui_code
and ui.ui_code = uil.ui_code
and uil.lang_code = 'en'
--and p.priviledge_code = '1006'
order by 1
;
--======================================================Insert/Update statement query
select ','||COLUMN_NAME||'' ins_stmt_1,',p_patient_response_rec.'||COLUMN_NAME ins_stmt_2 ,','||COLUMN_NAME||' = nvl(p_patient_rec.'||COLUMN_NAME||','||COLUMN_NAME||')' upd_stmt, 'p_'||lower(COLUMN_NAME)||' in product_sku_order_hist.'||COLUMN_NAME||'%type' data_type
from dba_tab_columns
where owner = 'MDTECH'
and table_name = upper('patient_response')
and COLUMN_NAME not in ('ACTIVE_FLAG','SOURCE_FROM_GOOGLE_API_FLAG','Z_CREATE_USER_ID','Z_CREATE_TMSTMP','Z_UPDATE_USER_ID','Z_UPDATE_TMSTMP')
;
--============================================user query
select r."Name"
      ,u."UserName"
      ,u."Email"
      ,ur.user_role_id
      ,u.first_name||' '||u.last_name
from "AspNetUsers" u
    ,"AspNetUserRoles" ur
    ,"AspNetRoles" r
where ur."UserId" = u."Id"
and ur."RoleId" = r."Id"
--and ur.user_role_id = 'D90DDA5916384FD2A533D41EDEFC3E47'
--and u."UserName" = 'thehealthenrollmentgroup@gmail.com'
--and u."Email" = 'zillion.rental@gmail.com'
and ur.active_flag = 'Y'
and u.active_flag = 'Y'
and r.active_flag = 'Y'
;
--============================================== Input parsing table function
select question_response_code from table(parse_json_pkg.patient_response(return_json_pkg.patient_response('BEHVT')));
select remark_note from table(parse_json_pkg.patient_prev_svc_remark(return_json_pkg.patient_prev_svc_remark));
select name,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,ingredients,purpose,frequency_unit_code,notes,medication_current_flag from table(parse_json_pkg.patient_medication(return_json_pkg.patient_medication));
--=================================Custom Addr parsing
set serveroutput on
set feedback on
declare
  v_state_rec     state%rowtype;
  v_city_rec      city%rowtype;
  v_addr_rec      addr%rowtype;
  v_company_rec   company%rowtype;
begin
  parse_json_pkg.custom_addr_parsing_prc(return_json_pkg.addr_json_str('custom_addr'),v_state_rec,v_city_rec,v_addr_rec);
  v_addr_rec.ADDR_TYPE_CODE := 'ML';
  common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_company_rec.addr_sn);
  dbms_output.put_line(v_state_rec.state_code||'-'||v_state_rec.country_code||'-'||v_city_rec.name||'-'||v_addr_rec.addr_1||'-'||v_addr_rec.addr_2||'-'||v_addr_rec.postal_code);
end;
/
--=================================Company parsing
set serveroutput on
set feedback on
declare
  v_company_rec     company%rowtype;
begin
  parse_json_pkg.company_parsing(return_json_pkg.company,v_company_rec);
  dbms_output.put_line(v_company_rec.NAME||'-'||v_company_rec.CONTACT_NAME||'-'||v_company_rec.PHONE_NUMBER||'-'||v_company_rec.FAX_NUMBER||'-'||v_company_rec.TOLL_FREE_NUMBER||'-'||v_company_rec.WEBSITE_ADDR);
end;
/
--=================================Physician parsing
set serveroutput on
set feedback on
declare
  v_physician_rec     physician%rowtype;
begin
  parse_json_pkg.physician_parsing(return_json_pkg.physician,v_physician_rec);
  dbms_output.put_line(v_physician_rec.CREATED_BY_USER_ROLE_ID||'-'||v_physician_rec.NPI||'-'||v_physician_rec.TITLE||'-'||v_physician_rec.PHYSICIAN_TYPE_CODE||'-'||v_physician_rec.SKYPE_ID||'-'||v_physician_rec.COMPANY_SN||'-'||v_physician_rec.FIRST_NAME||'-'||v_physician_rec.LAST_NAME||'-'||v_physician_rec.MIDDLE_NAME||'-'||v_physician_rec.CONTACT_PHONE_NUM||'-'||v_physician_rec.EMAIL_ADDR);
end;
/
--=================================provider_physician parsing
set serveroutput on
set feedback on
declare
  v_provider_physician_rec     provider_physician%rowtype;
begin
  parse_json_pkg.provider_physician_parsing(return_json_pkg.provider_physician,v_provider_physician_rec);
  dbms_output.put_line(v_provider_physician_rec.NPI||'-'||v_provider_physician_rec.TITLE||'-'||v_provider_physician_rec.PHYSICIAN_TYPE_CODE||'-'||v_provider_physician_rec.SKYPE_ID||'-'||v_provider_physician_rec.COMPANY_SN||'-'||v_provider_physician_rec.CREATED_BY_USER_ROLE_ID||'-'||v_provider_physician_rec.PHYSICIAN_USER_ROLE_ID||'-'||v_provider_physician_rec.FIRST_NAME||'-'||v_provider_physician_rec.LAST_NAME||'-'||v_provider_physician_rec.MIDDLE_NAME||'-'||v_provider_physician_rec.CONTACT_PHONE_NUM||'-'||v_provider_physician_rec.EMAIL_ADDR);
end;
/
--=================================svc_location parsing
set serveroutput on
set feedback on
declare
  v_svc_location_rec     svc_location%rowtype;
begin
  parse_json_pkg.svc_location_parsing(return_json_pkg.svc_location,v_svc_location_rec);
  dbms_output.put_line(v_svc_location_rec.NAME||'-'||v_svc_location_rec.SVC_LOCATION_TYPE_CODE||'-'||v_svc_location_rec.CONTACT_NAME||'-'||v_svc_location_rec.PHONE_NUM_1||'-'||v_svc_location_rec.PHONE_NUM_2||'-'||v_svc_location_rec.FAX_NUM_1||'-'||v_svc_location_rec.FAX_NUM_2||'-'||v_svc_location_rec.EMAIL_ADDR);
end;
/
--=================================physician_svc_location parsing
set serveroutput on
set feedback on
declare
  v_physician_svc_location_rec     physician_svc_location%rowtype;
begin
  parse_json_pkg.physician_svc_location_parsing(return_json_pkg.physician_svc_location,v_physician_svc_location_rec);
  dbms_output.put_line(v_physician_svc_location_rec.CREATED_BY_USER_ROLE_ID||'-'||v_physician_svc_location_rec.physician_sn||'-'||v_physician_svc_location_rec.svc_location_sn);
end;
/
--=================================patient_prev_svc_demo_parsing
set serveroutput on
set feedback on
declare
  v_patient_prev_svc_rec     patient_prev_svc%rowtype;
begin
  parse_json_pkg.patient_prev_svc_demo_parsing(return_json_pkg.patient_prev_svc_demo,v_patient_prev_svc_rec);
  dbms_output.put_line(v_patient_prev_svc_rec.PATIENT_PREV_SVC_SN||'-'||v_patient_prev_svc_rec.MARITAL_STATUS_CODE||'-'||v_patient_prev_svc_rec.WORKING_STATUS_CODE||'-'||v_patient_prev_svc_rec.EDUCATION_LEVEL_CODE||'-'||v_patient_prev_svc_rec.FINANCIAL_STATUS_CODE||'-'||v_patient_prev_svc_rec.LIVING_STATUS_CODE||'-'||v_patient_prev_svc_rec.INCOME_CODE||'-'||v_patient_prev_svc_rec.HEIGHT_IN_IN||'-'||v_patient_prev_svc_rec.WEIGHT_IN_LB||'-'||v_patient_prev_svc_rec.HDL_CHOLESTEROL_IN_MG||'-'||v_patient_prev_svc_rec.LDL_CHOLESTEROL_IN_MG||'-'||v_patient_prev_svc_rec.SYSTOLIC_BP_IN_MM||'-'||v_patient_prev_svc_rec.DIASTOLIC_BP_IN_MM||'-'||v_patient_prev_svc_rec.BLOOD_SUGAR_LEVEL_IN_MG||'-'||v_patient_prev_svc_rec.SOURCE_OF_HISTORY_EMR_FLAG||'-'||v_patient_prev_svc_rec.SOURCE_OF_HISTORY_PATIENT_FLAG||'-'||v_patient_prev_svc_rec.SOURCE_OF_HISTORY_FAMILY_FLAG||'-'||v_patient_prev_svc_rec.PATIENT_ORIENTATION_CODE||'-'||v_patient_prev_svc_rec.CREATED_BY_USER_ROLE_ID);
end;
/
--=================================patient_prev_svc parsing
set serveroutput on
set feedback on
declare
  v_patient_prev_svc_rec     patient_prev_svc%rowtype;
  v_valid_svc boolean;
  v_return_msg varchar2(100);
  v_parent_patient_prev_svc_sn number(11);
begin
--  parse_json_pkg.patient_prev_svc_parsing(return_json_pkg.patient_prev_svc,v_patient_prev_svc_rec);  
--  dbms_output.put_line(v_patient_prev_svc_rec.CREATED_BY_USER_ROLE_ID||'-'||v_patient_prev_svc_rec.PATIENT_SN||'-'||v_patient_prev_svc_rec.PREV_SVC_BILLING_CODE||'-'||to_char(v_patient_prev_svc_rec.SVC_DATE,'YYYY-MM-DD')||'-'||v_patient_prev_svc_rec.PROVIDER_PHYSICIAN_SN||'-'||v_patient_prev_svc_rec.PHYSICIAN_SVC_LOCATION_SN||'-'||v_patient_prev_svc_rec.G0438_COMP_ON_DIFF_SYS_FLAG||'-'||v_patient_prev_svc_rec.SVC_HR_CODE||'-'||v_patient_prev_svc_rec.SVC_MIN_CODE||'-'||v_patient_prev_svc_rec.SVC_AM_PM_CODE);
  --mdtech_trans_pkg.prev_svc_validity(4,'99487','30-AUG-2017',v_valid_svc,v_parent_patient_prev_svc_sn,v_return_msg);
  mdtech_trans_pkg.prev_svc_validity(44,'99202','30-AUG-2017',v_valid_svc,v_parent_patient_prev_svc_sn,v_return_msg);
  if v_valid_svc then
    dbms_output.put_line('true: '||v_return_msg);
  else
    dbms_output.put_line('false: '||v_return_msg);
  end if;
end;
/
--=================================Patient parsing
set serveroutput on
set feedback on
declare
  v_patient_rec     patient%rowtype;
begin
  parse_json_pkg.patient_parsing(return_json_pkg.patient,v_patient_rec);
  dbms_output.put_line(v_patient_rec.SSN||'-'||v_patient_rec.PHYSICIAN_SN||'-'||v_patient_rec.MEDICARE_HIC_NUM||'-'||v_patient_rec.GENDER_CODE||'-'||v_patient_rec.RACE_CODE||'-'||v_patient_rec.ETHNICITY_CODE||'-'||v_patient_rec.MARITAL_STATUS_CODE||'-'||v_patient_rec.WORKING_STATUS_CODE||'-'||v_patient_rec.EDUCATION_LEVEL_CODE||'-'||v_patient_rec.FINANCIAL_STATUS_CODE||'-'||v_patient_rec.LIVING_STATUS_CODE||'-'||v_patient_rec.INCOME_CODE||'-'||v_patient_rec.FIRST_NAME||'-'||v_patient_rec.LAST_NAME||'-'||v_patient_rec.MIDDLE_NAME||'-'||v_patient_rec.CONTACT_PHONE_NUM||'-'||v_patient_rec.EMAIL_ADDR||'-'||v_patient_rec.SKYPE_ID||'-'||to_char(v_patient_rec.BIRTH_DATE,'YYYY-MM-DD')||'-'||v_patient_rec.HEIGHT_IN_IN||'-'||v_patient_rec.WEIGHT_IN_LB||'-'||v_patient_rec.HDL_CHOLESTEROL_IN_MG||'-'||v_patient_rec.LDL_CHOLESTEROL_IN_MG||'-'||v_patient_rec.SYSTOLIC_BP_IN_MM||'-'||v_patient_rec.DIASTOLIC_BP_IN_MM||'-'||v_patient_rec.BLOOD_SUGAR_LEVEL_IN_MG||'-'||v_patient_rec.LEGAL_GUARDIAN_NAME||'-'||v_patient_rec.LEGAL_GUARDIAN_PH);
end;
/
--=========================parse patient_response json
set serveroutput on
set feedback on
declare
  v_qrc_tbl   global_type_pkg.t_question_response_code_tbl;
begin
  parse_json_pkg.patient_response_parsing(return_json_pkg.patient_response('BEHVT'),v_qrc_tbl);
  for i in v_qrc_tbl.first..v_qrc_tbl.last loop
    dbms_output.put_line(v_qrc_tbl(i));
  end loop;
end;
/
--=======================================mdtech_trans
set serveroutput on
set feedback on
declare
  v_out clob;
  v_USER_ROLE_ID "AspNetUserRoles".user_role_id%type;
begin
  --mbr_trans_pkg.i_mbr (return_json_pkg.mbr,'Service Provider',null,v_USER_ROLE_ID,v_out);
  --mdtech_trans_pkg.create_company(return_json_pkg.company,return_json_pkg.addr_json_str('custom_addr'),v_out);
  --mdtech_trans_pkg.create_provider_physician(return_json_pkg.provider_physician,v_out);
  --mdtech_trans_pkg.create_physician(return_json_pkg.physician,v_out);
  --mdtech_trans_pkg.create_svc_location(return_json_pkg.svc_location,return_json_pkg.addr_json_str('custom_addr'),v_out);
  --mdtech_trans_pkg.create_physician_svc_location(return_json_pkg.physician_svc_location,v_out);
  --mdtech_trans_pkg.create_patient(return_json_pkg.patient,null,v_out);
  --mdtech_trans_pkg.update_patient_prev_svc_demo(return_json_pkg.patient_prev_svc_demo,'abc@gmail.com',null,v_out);
  mdtech_trans_pkg.create_patient_medication(return_json_pkg.patient_medication,v_out);
  --mdtech_trans_pkg.update_patient_medication(return_json_pkg.patient_medication,22,v_out);
  --mdtech_trans_pkg.create_patient_signature(25,'---fdjadfj;--',v_out);
  --mdtech_trans_pkg.create_ccm_agmt_signature(2,'---fdjadfj;--',v_out);
  --mdtech_trans_pkg.create_physician_em(return_json_pkg.physician_em,'--++avdc--','--physician sig--',v_out);
  --mdtech_trans_pkg.create_provider_ccm(return_json_pkg.provider_ccm,v_out);
  --mdtech_trans_pkg.create_contact_us(return_json_pkg.contact_us,v_out);
  --mdtech_trans_pkg.create_em_sched_after_awv(return_json_pkg.physician_em_schedule,v_out);
  --mdtech_trans_pkg.create_patient_prev_svc(return_json_pkg.patient_prev_svc,v_out);
  --mdtech_trans_pkg.create_patient_prev_svc_remark(return_json_pkg.patient_prev_svc_remark,v_out);
  --mdtech_trans_pkg.update_patient_prev_svc_remark(return_json_pkg.patient_prev_svc_remark,5,v_out);
  --mdtech_trans_pkg.create_patient_response(return_json_pkg.patient_response('PSYSD'),'PSYSD',2,v_out);
  -----=================================
  --mdtech_trans_pkg.update_user('50469FBC597B71A7E0530100007F0CCB','FE10783F05FB44A2AC0FD37F1E63AD76','N',v_out);
  --mdtech_trans_pkg.manage_role_priviledge('22F1493D8E914982A6C5532EDBD516FE','PSVC','Y',v_out);
  dbms_output.put_line(v_out);
end;
/
set serveroutput on
declare    
  v_em_flag varchar2(1);
  v_chronic_disease_cnt number;
begin
  for i in (select patient_prev_svc_sn
            from pps_simplified_vw
            where svc_type_code = 'AWV'
            and completed_flag = 'Y'
            --and patient_prev_svc_sn = 23
            )
  loop
    begin
      svc_eval_pkg.svc_result_prc (i.patient_prev_svc_sn,v_em_flag,v_chronic_disease_cnt);
      update patient_prev_svc
      set CHRONIC_DISEASE_CNT = v_chronic_disease_cnt
        ,QUALIFY_FOR_EM_FOLLOWUP_FLAG = v_em_flag
      where patient_prev_svc_sn = i.patient_prev_svc_sn
      ;
      dbms_output.put_line ('patient_prev_svc_sn: '||i.patient_prev_svc_sn||'-v_em_flag: '||v_em_flag||'-v_chronic_disease_cnt: '||v_chronic_disease_cnt);
      commit;
    exception
      when others then
        dbms_output.put_line ('patient_prev_svc_sn: '||i.patient_prev_svc_sn);
        raise_application_error(-20001,sqlerrm);
    end;
  end loop;
end;
/
set serveroutput on
set feedback off
declare
 obj json;
 v_out varchar2(4000);
begin
 obj := qnr_inq_pkg.qnr_response(5203,'1001','shopping for personal items (like toilet items or medicines)?','en');
 v_out := obj.to_char;
 dbms_output.put_line(v_out);
end;
/
----qry
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
begin
  --qnr_inq_pkg.qnr_info('en-US','G0438',null,'N',v_out);
  --qnr_inq_pkg.qnr_by_categ('en-US','G0438','MOOD1',v_out);
  --common_inq_pkg.user_image(v_out);
  --common_inq_pkg.common_info('en','AWV',v_out);
  --common_inq_pkg.get_country_state_data('en','US',v_out);
  --common_inq_pkg.user_list('en-US',v_out);
  --common_inq_pkg.new_user_list('en-US',v_out);
  --common_inq_pkg.patient_list('en-US',2,'G0438',v_out);
  --common_inq_pkg.patient_signature(13,v_out);
  --common_inq_pkg.patient_with_pend_svc('en-US','imranul.software@gmail.com',v_out);
  common_inq_pkg.patient_qnr_by_categ('en-US',163,v_out);
  --common_inq_pkg.role_priviledge_list('en-US','3951E214B3F746BD924AFF39CABEA511',v_out);
  --menu_pkg.menu_info('en-US','mazharul.haque2@gmail.com',v_out);
  --qnr_inq_pkg.qnr_by_categ('en-US','G0438','FRLTY',v_out);
  --common_inq_pkg.patient_medication ('en-US',69,v_out);
  --common_inq_pkg.service_remark ('en-US',2,v_out);
  --dbms_output.put_line(v_out);
  json(v_out).print;
--  insert into TEMP_OUTPUT(out_clob) values(v_out);
--  commit;
end;
/
--
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
begin
  --common_inq_pkg.patient_qnr_by_categ('en-US',12,v_out);
  --common_inq_pkg.patient_em_template_data('en-US',28,v_out);
  list_item_pkg.list_item('en-US',v_out);
  --common_inq_pkg.patient_em_sched_template_data('en-US',2,v_out);
  --common_inq_pkg.patient_ccm_template_data('en-US',2,v_out);
  --mdtech_trans_pkg.create_patient_response(return_json_pkg.patient_response('HSURA'),'HSURA',2,v_out);
  --svc_eval_pkg.svc_result_prc (p_patient_prev_svc_sn,v_qualify_for_em_followup_flag);
  --qnr_by_categ_patient_info (p_locale in varchar2,p_patient_prev_svc_sn in number,p_svc_billing_code in list_prev_svc_billing.prev_svc_billing_code%type,p_question_categ_code in list_question_categ.question_categ_code%type,p_name in varchar2,p_age in number,p_gender in varchar2,p_gender_descr in varchar2,p_bmi in varchar2,p_bmi_result in varchar2,p_meds_cnt in number,p_out OUT clob)
  --qnr_inq_pkg.qnr_by_categ_patient_info('en-US',12,'G0438','BMEDH','Denzel T Washington',47,'MAL','Male',59.8,'Obese',0,v_out);
  json(v_out).print;
  --dbms_output.put_line(v_out);
end;
/
--Report
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
begin
  --ihaque@aprosoft.com/haque.mohammad.imranul@gmail.com (Service Provider); im_apu@yahoo.com (Super Admin)
  --report_pkg.bene_rpt_bene_list('en-US','ihaque@aprosoft.com',v_out);
  --report_pkg.beneficiary_rpt_menu('en-US',60,v_out);
  --report_pkg.svc_rpt_medication('en-US',1,v_out);
  report_pkg.patient_hx_and_meds('en-US',1,v_out);  
  --report_pkg.svc_rpt('en-US',16,'HQA',v_out);
  --common_inq_pkg.patient_em_template_data_init('en-US',42,v_out);
  --report_pkg.clinical_rpt('en-US',28,v_out);
  --report_pkg.patient_clinical_rpt('en-US',31,v_out);
  --report_pkg.em_output_rpt('en-US',28,v_out);
  --report_pkg.report_patient_response('en-US',14,v_out);
  --report_pkg.hra('en-US',2,v_out);
  --dbms_output.put_line(v_out);
  --dbms_output.put_line(length(v_out));
  --insert into TEMP_OUTPUT(out_clob) values(v_out);
  --commit;
  json(v_out).print;
end;
/
--Report
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
begin
  mgmt_report_pkg.patient_em_rpt('en-US','EQ',v_out);
  dbms_output.put_line(v_out);
end;
/

set serveroutput on
set feedback off
declare
  v_disease_level_code categ_score_eval.disease_level_code%type;
begin
  v_disease_level_code := svc_eval_pkg.risk_factor_level (2,'HBPR',78,'MAL','ASIN','NHIS','Overweight','ONFA');
  dbms_output.put_line('v_disease_level_code: '||v_disease_level_code);
end;
/
set serveroutput on
set feedback off
declare
  obj json := json();
begin
  obj := obes_counseling_pkg.svc_counseling_obj(55);
  obj.print;
end;
/
--Obesity IBT
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
begin
  --obes_counseling_pkg.obes_ibt_template_data('en',110,v_out);
  --obes_counseling_pkg.obes_screening_template_data('en',160,v_out);
  --obes_counseling_pkg.ibt_report_data('en',105,v_out);
  --obes_counseling_pkg.screening_report_data('en',160,v_out);
  --obes_counseling_pkg.weight_waist_changes (66,160,40,155,39,v_out);
  --obes_counseling_pkg.svc_rf_remark_proc(59,'GOAL',v_out);
  --obes_counseling_pkg.svc_rf_remark_proc (59,'GOAL',v_out);
  --report_pkg.beneficiary_rpt_menu('en-US',73,v_out);
  --list_item_pkg.list_item('en-US',v_out);
  --admin_inq_pkg.user_record_edit_data('en-US','imranul.software@gmail.com',v_out);
  --admin_inq_pkg.user_list('en-US','gmail.com',null,null,24,v_out);
  common_inq_pkg.company_provider_list('en-US',24,7,v_out);
  --common_inq_pkg.conditional_company_list('en-US','ihaque@aprosoft.com',null,v_out);
  json(v_out).print;
end;
/
--Report
set serveroutput on
set feedback off
declare
  v_out clob; --varchar2(32767);
  l_obj json_list := json_list();
begin
  --(p_locale,p_user,p_hic,p_ssn,p_last_name,p_first_name,p_company_sn,p_svc_location_sn,p_physician_sn,p_prev_svc_billing_code,p_svc_dt_begin,p_svc_dt_end)
  --admin_inq_pkg.rpt_patient_list('en-US','mazharul.haque2@gmail.com',null,null,null,null,21,null,null,null,'2018-01-01','2018-01-31',v_out);
  --report_pkg.beneficiary_rpt_menu ('en-US',84,v_out);
  --mgmt_report_pkg.priviledge_report_list('en-US','RPTI',v_out);
  --mgmt_report_pkg.patient_inquiry('en-US','RQCS',73,v_out);
  --p_locale: en-US-p_user: im_apu@yahoo.com-p_report_code: -p_company_sn: 1-p_svc_location_sn: -p_physician_sn: 0-p_prev_svc_billing_code: -p_svc_dt_begin: -p_svc_dt_end: 
  mgmt_report_pkg.analytical_data('en-US','im_apu@yahoo.com','RSCS',1,null,null,null,null,null,v_out);
  --mgmt_report_pkg.scheduled_service_data('en-US','mazharul.haque2@gmail.com',null,null,'2018-05-18',v_out);
  --mgmt_report_pkg.other_inquiry('en-US','mazharul.haque2@gmail.com','R438',null,null,null,v_out);
  --admin_inq_pkg.patient_hx_qnr_template_data('en-US',69,v_out);
  json(v_out).print;
end;
/
-----------##########################################
--======================AWV G0438 JSON=============================
select out_clob,length(out_clob),z_create_tmstmp from temp_output order by z_create_tmstmp desc;
select control_value_name,length(control_value_clob) from application_control_value;
select * from application_process_log order by z_create_tmstmp desc;
select * from dba_objects where status <> 'VALID';
--###############################################
