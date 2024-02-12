----------------------------------============Report Rerun--------------=======================
------------AWV
--------svc_rpt_type_code = CLI (Physician), HRA (Patient), RMK (Remark) and HQA (Q&A) 
begin
  for i in (select patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('G0438','G0439')
            and svc_comp_flag = 'Y'
            and patient_prev_svc_sn in (613,609)
            )
  loop
    mdtech_trans_pkg.awv_rpt_json_clob(i.patient_prev_svc_sn,null);
  end loop;
end;
/
-----------Obesity IBT RF
begin
  for i in (select distinct patient_prev_svc_sn
            from svc_result
            where obesity_rf_avail_flag = 'Y'
            --and patient_prev_svc_sn in (1)
            )
  loop
    svc_eval_pkg.create_obesity_rf_json(i.patient_prev_svc_sn);
  end loop;
end;
/
-----------Obesity IBT Output
begin
  for i in (select patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('G0447')
            and svc_comp_flag = 'Y'
            )
  loop
    obes_counseling_trans_pkg.oev_rpt_json_clob(i.patient_prev_svc_sn);
  end loop;
end;
/

--------EM Template
begin
  for i in (select patient_prev_svc_sn
                  ,parent_patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('99202','99212')
            and svc_comp_flag = 'N'
            --and patient_prev_svc_sn in (21,22)
            )
  loop
    mdtech_trans_pkg.esv_rpt_json_clob (i.patient_prev_svc_sn);
  end loop;
end;
/
-----------EM Output
begin
  for i in (select patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('99202','99212')
            and svc_comp_flag = 'Y'
            )
  loop
    mdtech_trans_pkg.eev_rpt_json_clob(i.patient_prev_svc_sn);
  end loop;
end;
/
-----------CCM Template
begin
  for i in (select patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('99487','99490')
            )
  loop
    mdtech_trans_pkg.csv_rpt_json_clob(i.patient_prev_svc_sn);
  end loop;
end;
/
----------CCM Output
begin
  for i in (select patient_prev_svc_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('99487','99490')
            and svc_comp_flag = 'Y'
            )
  loop
    mdtech_trans_pkg.cev_rpt_json_clob(i.patient_prev_svc_sn);
  end loop;
end;
/
----Data reprocess
set serveroutput on
declare    
  v_em_flag varchar2(1);
  v_chronic_disease_cnt number;
begin
  for i in (select patient_prev_svc_sn
            from pps_simplified_vw
            where svc_type_code = 'AWV'
            and completed_flag = 'Y'
            and patient_prev_svc_sn in (613,609)
            )
  loop
    begin
      svc_eval_pkg.svc_result_prc (i.patient_prev_svc_sn,v_em_flag,v_chronic_disease_cnt);
      update patient_prev_svc
      set CHRONIC_DISEASE_CNT = v_chronic_disease_cnt
        ,QUALIFY_FOR_EM_FOLLOWUP_FLAG = v_em_flag
      where patient_prev_svc_sn = i.patient_prev_svc_sn
      ;
      --dbms_output.put_line ('patient_prev_svc_sn: '||i.patient_prev_svc_sn||'-v_em_flag: '||v_em_flag||'-v_chronic_disease_cnt: '||v_chronic_disease_cnt);
      commit;
    exception
      when others then
        dbms_output.put_line ('patient_prev_svc_sn: '||i.patient_prev_svc_sn);
        raise_application_error(-20001,sqlerrm);
    end;
  end loop;
  commit;
end;
/
