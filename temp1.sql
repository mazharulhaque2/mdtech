select * from question_response_vw where billing_code = 'G0438' and category_code = 'FHNMR' order by question_order_num;
select * from patient_response_vw where patient_prev_svc_sn = 33 and category_code = 'FALLR';
select * from patient_medication where patient_sn = 52;
--3287
select *
from patient_response_vw 
where patient_prev_svc_sn = 33 
and category_code = 'HHISQ'
and response_score <> 0
;

select * from patient_response_vw where category_code = 'FRLT1';
select common_inq_pkg.categ_score_sum(2,'FRLT2',null) from dual;
select * from question_response_vw where category_code = 'FALLR' order by question_order_num, question_response_order_num;
select common_inq_pkg.response_score(3,'FRLTY',null) from dual;
select * from categ_score_eval_vw;
select svc_eval_pkg.frlty_level(2,78) from dual;
select * from patient_vw;
select * from patient_prev_svc;
select common_inq_pkg.patient_question_response_flag (2,'FALLR','1001','Y02') from dual;

select common_inq_pkg.final_next_question_categ(2) from dual;
select * from patient_vw;
select * from svc_billing_question_categ order by order_num;
select * from patient_prev_svc_remark;
select * from patient_medication;
select * from patient_prev_svc;
select * from risk_factor_lang;
select * from disease_risk_factor;
select * from disease_symptom;
select * from disease_lang;

select * from response_lang;
select * from patient_prev_svc_remark;
select * from symptom_categ_lang;
select * from patient;
select * from list_question_score_type;

select qr.question_response_code,qc.question_categ_code,q.question_code,qr.response_code,qr.score_value,ql.short_descr question,rl.short_descr response,q.conditional_question_flag,q.triggered_other_code,q.triggered_question_categ_code,q.triggered_question_code,q.triggered_response_code
--select qc.question_categ_code||'/'||q.question_code||'/'||qr.response_code||'/HIG' res,ql.short_descr question,rl.short_descr response,q.conditional_question_flag,q.triggered_other_code,q.triggered_question_categ_code,q.triggered_question_code,q.triggered_response_code
from list_question_categ qc
    ,question_categ_lang qcl
    ,list_question_categ_grp qcg
    ,question_categ_grp_lang qcgl
    ,question q
    ,question_lang ql
    ,question_response qr
    ,list_response r
    ,response_lang rl
    ,svc_billing_question_categ sbqc
where qc.question_categ_code = qcl.question_categ_code
and qc.question_categ_code = q.question_categ_code
and qc.question_categ_grp_code = qcg.question_categ_grp_code
and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
and q.question_sn = ql.question_sn
and q.question_sn = qr.question_sn
and qr.response_code = r.response_code
and r.response_code = rl.response_code
and qc.question_categ_code = sbqc.question_categ_code
and sbqc.prev_svc_billing_code = 'G0438'
--and lower(ql.short_descr) like lower('%immu%')
--and qcg.question_categ_grp_code <> '106'
and qc.question_categ_code = 'LONLS'
order by q.order_num,qr.order_num
;
select * from test_lang;
select qcl.question_categ_code,ql.short_descr,q.triggered_other_code,q.triggered_question_categ_code,q.triggered_question_code,q.triggered_response_code
from list_question_categ qc
    ,question_categ_lang qcl
    ,question q
    ,question_lang ql
where qc.question_categ_code = qcl.question_categ_code
and qc.question_categ_code = q.question_categ_code
and q.question_sn = ql.question_sn
and q.conditional_question_flag = 'Y'
;

--Child will be called individually
select qcl.question_categ_code,qc.parent_question_categ_code,qcl.short_descr,qcl.long_descr,qc.order_num,qc.* 
from list_question_categ qc
    ,question_categ_lang qcl
where qc.question_categ_code = qcl.question_categ_code
and qc.child_categ_avail_flag = 'Y'
;
--Will be handled programatically
select qcl.question_categ_code,qc.parent_question_categ_code,qcl.short_descr,qcl.long_descr,qc.order_num,qc.* 
from list_question_categ qc
    ,question_categ_lang qcl
where qc.question_categ_code = qcl.question_categ_code
and qc.trigger_further_categ_flag = 'Y'
;
select qcl.question_categ_code,qc.parent_question_categ_code,qcl.short_descr,qcl.long_descr,ql.short_descr,qc.* 
from list_question_categ qc
    ,question_categ_lang qcl
    ,question q
    ,question_lang ql
where qc.question_categ_code = qcl.question_categ_code
and q.question_categ_code = qc.question_categ_code
and q.question_sn = ql.question_sn
and q.conditional_question_flag = 'Y'
;
--Will be handled programatically
select qcl.question_categ_code,qc.parent_question_categ_code,qcl.short_descr,qcl.long_descr,qr.TRIGGERED_QUESTION_CATEG_CODE,ql.short_descr qtn_descr,qc.* 
from list_question_categ qc
    ,question_categ_lang qcl
    ,question q
    ,question_lang ql
    ,question_response qr
where qc.question_categ_code = qcl.question_categ_code
and q.question_categ_code = qc.question_categ_code
and q.question_sn = ql.question_sn
and qr.question_sn = q.question_sn
and qr.TRIGGER_FURTHER_CATEG_FLAG = 'Y'
;
--Will be handled programatically
select qcl.question_categ_code,qc.parent_question_categ_code,qcl.short_descr,qcl.long_descr,qr.TRIGGERED_QUESTION_CATEG_CODE,ql.short_descr qtn_descr,qc.* 
from list_question_categ qc
    ,question_categ_lang qcl
    ,question q
    ,question_lang ql
    ,question_response qr
where qc.question_categ_code = qcl.question_categ_code
and q.question_categ_code = qc.question_categ_code
and q.question_sn = ql.question_sn
and qr.question_sn = q.question_sn
and qr.TRIGGER_FURTHER_QUESTION_FLAG = 'Y'
;
select *
from dba_tab_columns
where owner = 'MDTECH'
and column_name like '%CHILD%'
;

select common_inq_pkg.patient_next_question_categ(2) from dual;
--
select q.question_sn,q.question_code,qr.* 
from question_response qr
    ,question q
where q.question_sn = qr.question_sn
and q.question_categ_code = 'FRLTY'
;
--
begin
--  list_trans_pkg.load_symptom_categ;
--  delete from svc_billing_question_categ;
--  commit;
--  list_trans_pkg.load_question_categ_grp;
--  list_trans_pkg.load_question_categ_grp_lang;
--  list_trans_pkg.load_question_categ;
--  list_trans_pkg.load_svc_bq_categ;
--  delete from question_response;
--  delete from question_lang;
--  delete from question;
--  commit;
--  list_trans_pkg.load_response;
--  list_trans_pkg.load_question;
--  list_trans_pkg.load_prev_svc_type;
--  list_trans_pkg.load_prev_svc_type_lang;
--  list_trans_pkg.load_prev_svc_billing;
--  list_trans_pkg.load_prev_svc_billing_lang;
--  delete from categ_score_eval_lang;
--  delete from categ_score_eval;
--  commit;
--  list_trans_pkg.load_question_response('U');
  list_trans_pkg.load_categ_score_eval;
--  list_trans_pkg.load_severity;
--  list_trans_pkg.load_disease;
--  list_trans_pkg.load_disease_symptom;
--  list_trans_pkg.load_disease_risk_factor;
end;
/
select * from svc_billing_question_categ order by order_num;
select qcl.question_categ_code code
                    ,qcl.short_descr descr
                    ,qcl.long_descr
                    ,qcgl.long_descr grp_descr
                    ,qc.trigger_further_categ_flag
                    ,qc.child_categ_avail_flag
                    ,qc.categ_condition_descr
                    ,sbqc.order_num
              from list_question_categ qc
                  ,question_categ_lang qcl
                  ,svc_billing_question_categ sbqc
                  ,list_question_categ_grp qcg
                  ,question_categ_grp_lang qcgl
              where qc.question_categ_code = qcl.question_categ_code
              --and qcl.lang_code = v_lang_code
              and qc.question_categ_grp_code = qcg.question_categ_grp_code
              and qcg.question_categ_grp_code = qcgl.question_categ_grp_code
              --and qcgl.lang_code = v_lang_code
              and qc.question_categ_code = sbqc.question_categ_code
              and sbqc.prev_svc_billing_code = 'G0438'
              ;
select * from prev_svc_billing_lang;   

-----------==============New question_response entry block=====================================================================
--declare
--    v_question_sn question.question_sn%type;
--    v_question_response_code question_response.question_response_code%type;
--    v_question_categ_code list_question_categ.question_categ_code%type := '99999';
--begin
--    for i in (select 'BDTEN' question_categ_code,'1001' question_code,1 order_num,'YES' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any major Health concern today?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual union
--              select 'BDTEN' question_categ_code,'1001' question_code,2 order_num,'NOO' response_code,null disease_code,null symptom_code,null risk_factor_code,null disease_level_code,null em_name_code,null score_value,'N' trigger_further_question_flag,'N' trigger_further_categ_flag,null triggered_question_categ_code,'N' conditional_question_flag,'en' lang_code,'Do you have any major Health concern today?' short_descr,null long_descr,null parent_question_code,'RSP' query_type from dual
--              )
--    loop
--      v_question_sn := list_trans_pkg.qtn_sn(i.question_categ_code,i.question_code);
--      --
--      if v_question_categ_code <> i.question_categ_code then
--        v_question_response_code := list_trans_pkg.get_categ_qrc(i.question_categ_code);
--      end if;
--      --
--      v_question_response_code := v_question_response_code + 1;
--      v_question_categ_code := i.question_categ_code;
--      --
--      begin
--        INSERT INTO question_response (QUESTION_RESPONSE_CODE
--                                      ,QUESTION_SN
--                                      ,RESPONSE_CODE
--                                      ,SCORE_VALUE
--                                      ,order_num
--                                      ,trigger_further_question_flag
--                                      ,trigger_further_categ_flag
--                                      ,triggered_question_categ_code
--                                      ,disease_code
--                                      ,symptom_code
--                                      ,risk_factor_code
--                                      ,disease_level_code
--                                      ,em_name_code
--                                      )
--                                VALUES(v_question_response_code
--                                      ,v_question_sn
--                                      ,i.RESPONSE_CODE
--                                      ,i.SCORE_VALUE
--                                      ,i.order_num
--                                      ,i.trigger_further_question_flag
--                                      ,i.trigger_further_categ_flag
--                                      ,i.triggered_question_categ_code
--                                      ,i.disease_code
--                                      ,i.symptom_code
--                                      ,i.risk_factor_code
--                                      ,i.disease_level_code
--                                      ,i.em_name_code
--                                      );
--      exception 
--        when others then
--          raise_application_error(-20001,sqlerrm);
--      end;
--    end loop;
--    commit;
--end;
--/
-------------========================================================================================

--delete from patient_response where patient_response_sn in
--      (select pr.patient_response_sn
--      from question_response qr
--          ,question q
--          ,patient_response pr
--      where qr.question_sn = q.question_sn
--      and pr.question_response_code = qr.question_response_code
--      and q.question_categ_code = 'BMEDH'
--      )
--;
--commit;
--delete from patient_response where patient_prev_svc_sn = 14;
--insert into [tblRemarksMedication] ([PacienteId],[Description],[UsuarioId],[DataCriacao])
--values (5071,'Sertraline 100 mg',78,GETDATE());
--select * FROM [IHSDB].[dbo].[Pacientes] where hic = '';
--SUZAN	SMITH	NULL	1939-11-18 HIC = 456585649B	SS = 456585649
--Delete PacienteId = 7701


--delete from disease_symptom;
--delete from disease_risk_factor;
--delete from disease_lang;
--delete from list_disease;
--delete from disease_type_lang;
--delete from list_disease_type;
--delete from disease_categ_lang;
--delete from list_disease_categ;
----
--delete from risk_factor_severity_lang;
--delete from list_risk_factor_severity;
--delete from risk_factor_lang;
--delete from list_risk_factor;
--delete from risk_factor_categ_lang;
--delete from list_risk_factor_categ;
--delete from symptom_lang;
--delete from list_symptom;
--delete from symptom_categ_lang;
--delete from list_symptom_categ;
--delete from disease_level_lang;
--delete from list_disease_level;
--delete from disease_severity_lang;
--delete from list_disease_severity;
----
--commit;
