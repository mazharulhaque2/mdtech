CREATE OR REPLACE PACKAGE scheduler_pkg IS
  v_pkg_name    varchar2 (30) := upper('scheduler_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  PROCEDURE create_test_log;
  PROCEDURE delete_old_pending_svc;
  PROCEDURE delete_specific_pending_svc (p_patient_prev_svc_sn in number);
END scheduler_pkg;
/
SHOW ERRORS
--
create or replace PACKAGE BODY scheduler_pkg IS
  --This proc only will be used in a data error 
  PROCEDURE delete_specific_pending_svc (p_patient_prev_svc_sn in number)
  as
  begin
    v_proc_name := upper('delete_specific_pending_svc');
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,'STARTED',null,null);
    --program logic begin
    for i in (select * 
              from patient_prev_svc
              where svc_comp_flag = 'N'
              and prev_svc_billing_code in ('G0438','G0439','99202','99212','99487','99490')
              and patient_prev_svc_sn = p_patient_prev_svc_sn
              )
    loop
      v_input_str := 'patient_prev_svc_sn: '||i.patient_prev_svc_sn;
      begin
        insert into deleted_patient_prev_svc(patient_prev_svc_sn
                                            ,created_by_user_role_id
                                            ,updated_by_user_role_id
                                            ,patient_sn
                                            ,prev_svc_billing_code
                                            ,svc_date
                                            ,svc_perform_date
                                            ,provider_physician_sn
                                            ,physician_svc_location_sn
                                            ,g0438_comp_on_diff_sys_flag
                                            ,svc_comp_flag
                                            ,patient_signature
                                            ,parent_patient_prev_svc_sn
                                            ,svc_hr_code
                                            ,svc_min_code
                                            ,svc_am_pm_code
                                            ,request_em_perf_by_pcp_flag
                                            ,comment_when_deny_em
                                            ,qualify_for_em_followup_flag
                                            ,chronic_disease_cnt
                                            ,em_followup_svc_date
                                            ,em_followup_svc_hr_code
                                            ,em_followup_svc_min_code
                                            ,em_followup_svc_am_pm_code
                                            ,marital_status_code
                                            ,working_status_code
                                            ,education_level_code
                                            ,financial_status_code
                                            ,living_status_code
                                            ,income_code
                                            ,height_in_in
                                            ,weight_in_lb
                                            ,hdl_cholesterol_in_mg
                                            ,ldl_cholesterol_in_mg
                                            ,systolic_bp_in_mm
                                            ,diastolic_bp_in_mm
                                            ,blood_sugar_level_in_mg
                                            ,source_of_history_emr_flag
                                            ,source_of_history_patient_flag
                                            ,source_of_history_family_flag
                                            ,patient_orientation_code
                                            ,sub_prev_svc_billing_code
                                            ,addl_sub_prev_svc_billing_code
                                            ,inactive_reason_descr
                                            ,rec_active_flag
                                            ,rec_z_create_user_id
                                            ,rec_z_create_tmstmp
                                            ,rec_z_update_user_id
                                            ,rec_z_update_tmstmp
                                            )
        values                              (i.patient_prev_svc_sn
                                            ,i.created_by_user_role_id
                                            ,i.updated_by_user_role_id
                                            ,i.patient_sn
                                            ,i.prev_svc_billing_code
                                            ,i.svc_date
                                            ,i.svc_perform_date
                                            ,i.provider_physician_sn
                                            ,i.physician_svc_location_sn
                                            ,i.g0438_comp_on_diff_sys_flag
                                            ,i.svc_comp_flag
                                            ,i.patient_signature
                                            ,i.parent_patient_prev_svc_sn
                                            ,i.svc_hr_code
                                            ,i.svc_min_code
                                            ,i.svc_am_pm_code
                                            ,i.request_em_perf_by_pcp_flag
                                            ,i.comment_when_deny_em
                                            ,i.qualify_for_em_followup_flag
                                            ,i.chronic_disease_cnt
                                            ,i.em_followup_svc_date
                                            ,i.em_followup_svc_hr_code
                                            ,i.em_followup_svc_min_code
                                            ,i.em_followup_svc_am_pm_code
                                            ,i.marital_status_code
                                            ,i.working_status_code
                                            ,i.education_level_code
                                            ,i.financial_status_code
                                            ,i.living_status_code
                                            ,i.income_code
                                            ,i.height_in_in
                                            ,i.weight_in_lb
                                            ,i.hdl_cholesterol_in_mg
                                            ,i.ldl_cholesterol_in_mg
                                            ,i.systolic_bp_in_mm
                                            ,i.diastolic_bp_in_mm
                                            ,i.blood_sugar_level_in_mg
                                            ,i.source_of_history_emr_flag
                                            ,i.source_of_history_patient_flag
                                            ,i.source_of_history_family_flag
                                            ,i.patient_orientation_code
                                            ,i.sub_prev_svc_billing_code
                                            ,i.addl_sub_prev_svc_billing_code
                                            ,i.inactive_reason_descr
                                            ,i.active_flag
                                            ,i.z_create_user_id
                                            ,i.z_create_tmstmp
                                            ,i.z_update_user_id
                                            ,i.z_update_tmstmp
                                            );
        for j in (select *
                  from patient_response
                  where patient_prev_svc_sn = i.patient_prev_svc_sn
                  )
        loop
          insert into deleted_patient_response  (patient_response_sn
                                                ,patient_prev_svc_sn
                                                ,question_response_code
                                                ,response_data
                                                ,rec_active_flag
                                                ,rec_z_create_user_id
                                                ,rec_z_create_tmstmp
                                                ,rec_z_update_user_id
                                                ,rec_z_update_tmstmp
                                                )
          values                                (j.patient_response_sn
                                                ,j.patient_prev_svc_sn
                                                ,j.question_response_code
                                                ,j.response_data
                                                ,j.active_flag
                                                ,j.z_create_user_id
                                                ,j.z_create_tmstmp
                                                ,j.z_update_user_id
                                                ,j.z_update_tmstmp
                                                );
                                                
        end loop;
        --
        for j in (select *
                  from patient_prev_svc_remark
                  where patient_prev_svc_sn = i.patient_prev_svc_sn
                  )
        loop
          insert into deleted_pps_remark        (patient_prev_svc_remark_sn
                                                ,patient_prev_svc_sn
                                                ,remark_note
                                                ,rec_active_flag
                                                ,rec_z_create_user_id
                                                ,rec_z_create_tmstmp
                                                ,rec_z_update_user_id
                                                ,rec_z_update_tmstmp
                                                )
          values                                (j.patient_prev_svc_remark_sn
                                                ,j.patient_prev_svc_sn
                                                ,j.remark_note
                                                ,j.active_flag
                                                ,j.z_create_user_id
                                                ,j.z_create_tmstmp
                                                ,j.z_update_user_id
                                                ,j.z_update_tmstmp
                                                );
                                                
        end loop;
        --
        if i.prev_svc_billing_code in ('G0438','G0439','99202','99212','99487','99490') then
          delete from svc_result_rpt where patient_prev_svc_sn = i.patient_prev_svc_sn;
          delete from svc_result where patient_prev_svc_sn = i.patient_prev_svc_sn;
        end if;
        delete from patient_response where patient_prev_svc_sn = i.patient_prev_svc_sn;
        delete from patient_prev_svc_remark where patient_prev_svc_sn = i.patient_prev_svc_sn;
        delete from patient_prev_svc where patient_prev_svc_sn = i.patient_prev_svc_sn;
        --
        commit;
      exception
        when others then
        rollback;
        v_err_msg := SUBSTR (SQLERRM,1,1000);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      end;
    end loop;
    commit;
    --program logic end
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,'FINISHED',null,null);
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,1000);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);    
  end delete_specific_pending_svc;
  --
  --This procedure will delete any 7(could be changed) days old pending uncomplete services. 
  --Pending uncomplete services could accumulate due to 1) service provider error (started the wrong patient and patient did not show up later),
  --2) Patient abandoned the service in the middle of the service, 3) Patient did not show up at the service date and 4) Service cancelled.
  --
  --Pending service data shows up at service provider dash board. When a pending service becomes 7 days old, the data is moved to 
  --deleted_patient_prev_svc and deleted_patient_response.
  --
  --When a pending service record is deleted, that patient moves to the appointment pull for new appointment.
  --
  PROCEDURE delete_old_pending_svc
  as
  begin
    v_proc_name := upper('delete_old_pending_svc');
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,'STARTED',null,null);
    --program logic begin
    for i in (select * 
              from patient_prev_svc
              where svc_comp_flag = 'N'
              and prev_svc_billing_code in ('G0438','G0439','99202','99212','99487','99490')
              and svc_date < sysdate - 1
              )
    loop
      v_input_str := 'patient_prev_svc_sn: '||i.patient_prev_svc_sn;
      begin
        insert into deleted_patient_prev_svc(patient_prev_svc_sn
                                            ,created_by_user_role_id
                                            ,updated_by_user_role_id
                                            ,patient_sn
                                            ,prev_svc_billing_code
                                            ,svc_date
                                            ,svc_perform_date
                                            ,provider_physician_sn
                                            ,physician_svc_location_sn
                                            ,g0438_comp_on_diff_sys_flag
                                            ,svc_comp_flag
                                            ,patient_signature
                                            ,parent_patient_prev_svc_sn
                                            ,svc_hr_code
                                            ,svc_min_code
                                            ,svc_am_pm_code
                                            ,request_em_perf_by_pcp_flag
                                            ,comment_when_deny_em
                                            ,qualify_for_em_followup_flag
                                            ,chronic_disease_cnt
                                            ,em_followup_svc_date
                                            ,em_followup_svc_hr_code
                                            ,em_followup_svc_min_code
                                            ,em_followup_svc_am_pm_code
                                            ,marital_status_code
                                            ,working_status_code
                                            ,education_level_code
                                            ,financial_status_code
                                            ,living_status_code
                                            ,income_code
                                            ,height_in_in
                                            ,weight_in_lb
                                            ,hdl_cholesterol_in_mg
                                            ,ldl_cholesterol_in_mg
                                            ,systolic_bp_in_mm
                                            ,diastolic_bp_in_mm
                                            ,blood_sugar_level_in_mg
                                            ,source_of_history_emr_flag
                                            ,source_of_history_patient_flag
                                            ,source_of_history_family_flag
                                            ,patient_orientation_code
                                            ,sub_prev_svc_billing_code
                                            ,addl_sub_prev_svc_billing_code
                                            ,inactive_reason_descr
                                            ,rec_active_flag
                                            ,rec_z_create_user_id
                                            ,rec_z_create_tmstmp
                                            ,rec_z_update_user_id
                                            ,rec_z_update_tmstmp
                                            )
        values                              (i.patient_prev_svc_sn
                                            ,i.created_by_user_role_id
                                            ,i.updated_by_user_role_id
                                            ,i.patient_sn
                                            ,i.prev_svc_billing_code
                                            ,i.svc_date
                                            ,i.svc_perform_date
                                            ,i.provider_physician_sn
                                            ,i.physician_svc_location_sn
                                            ,i.g0438_comp_on_diff_sys_flag
                                            ,i.svc_comp_flag
                                            ,i.patient_signature
                                            ,i.parent_patient_prev_svc_sn
                                            ,i.svc_hr_code
                                            ,i.svc_min_code
                                            ,i.svc_am_pm_code
                                            ,i.request_em_perf_by_pcp_flag
                                            ,i.comment_when_deny_em
                                            ,i.qualify_for_em_followup_flag
                                            ,i.chronic_disease_cnt
                                            ,i.em_followup_svc_date
                                            ,i.em_followup_svc_hr_code
                                            ,i.em_followup_svc_min_code
                                            ,i.em_followup_svc_am_pm_code
                                            ,i.marital_status_code
                                            ,i.working_status_code
                                            ,i.education_level_code
                                            ,i.financial_status_code
                                            ,i.living_status_code
                                            ,i.income_code
                                            ,i.height_in_in
                                            ,i.weight_in_lb
                                            ,i.hdl_cholesterol_in_mg
                                            ,i.ldl_cholesterol_in_mg
                                            ,i.systolic_bp_in_mm
                                            ,i.diastolic_bp_in_mm
                                            ,i.blood_sugar_level_in_mg
                                            ,i.source_of_history_emr_flag
                                            ,i.source_of_history_patient_flag
                                            ,i.source_of_history_family_flag
                                            ,i.patient_orientation_code
                                            ,i.sub_prev_svc_billing_code
                                            ,i.addl_sub_prev_svc_billing_code
                                            ,i.inactive_reason_descr
                                            ,i.active_flag
                                            ,i.z_create_user_id
                                            ,i.z_create_tmstmp
                                            ,i.z_update_user_id
                                            ,i.z_update_tmstmp
                                            );
        for j in (select *
                  from patient_response
                  where patient_prev_svc_sn = i.patient_prev_svc_sn
                  )
        loop
          insert into deleted_patient_response  (patient_response_sn
                                                ,patient_prev_svc_sn
                                                ,question_response_code
                                                ,response_data
                                                ,rec_active_flag
                                                ,rec_z_create_user_id
                                                ,rec_z_create_tmstmp
                                                ,rec_z_update_user_id
                                                ,rec_z_update_tmstmp
                                                )
          values                                (j.patient_response_sn
                                                ,j.patient_prev_svc_sn
                                                ,j.question_response_code
                                                ,j.response_data
                                                ,j.active_flag
                                                ,j.z_create_user_id
                                                ,j.z_create_tmstmp
                                                ,j.z_update_user_id
                                                ,j.z_update_tmstmp
                                                );
                                                
        end loop;
        --
        for j in (select *
                  from patient_prev_svc_remark
                  where patient_prev_svc_sn = i.patient_prev_svc_sn
                  )
        loop
          insert into deleted_pps_remark        (patient_prev_svc_remark_sn
                                                ,patient_prev_svc_sn
                                                ,remark_note
                                                ,rec_active_flag
                                                ,rec_z_create_user_id
                                                ,rec_z_create_tmstmp
                                                ,rec_z_update_user_id
                                                ,rec_z_update_tmstmp
                                                )
          values                                (j.patient_prev_svc_remark_sn
                                                ,j.patient_prev_svc_sn
                                                ,j.remark_note
                                                ,j.active_flag
                                                ,j.z_create_user_id
                                                ,j.z_create_tmstmp
                                                ,j.z_update_user_id
                                                ,j.z_update_tmstmp
                                                );
                                                
        end loop;
        --
        if i.prev_svc_billing_code in ('99202','99212','99487','99490') then
          delete from svc_result_rpt where patient_prev_svc_sn = i.patient_prev_svc_sn;
        end if;
        delete from patient_response where patient_prev_svc_sn = i.patient_prev_svc_sn;
        delete from patient_prev_svc_remark where patient_prev_svc_sn = i.patient_prev_svc_sn;
        delete from patient_prev_svc where patient_prev_svc_sn = i.patient_prev_svc_sn;
        --
        commit;
      exception
        when others then
        rollback;
        v_err_msg := SUBSTR (SQLERRM,1,1000);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      end;
    end loop;
    commit;
    --program logic end
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,'FINISHED',null,null);
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,1000);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);    
  end delete_old_pending_svc;
  --
  --This is a test scheduling procedure. Keeping this for future testing.
  --
  PROCEDURE create_test_log
  as
  begin
    v_proc_name := upper('create_test_log');
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',v_err_msg,'STARTED',null,null);
    --program logic
    v_input_str := 'Log at :'||to_char(sysdate,'DD-MON-YYYY HH24:MI:SS');
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',v_err_msg,null,v_input_str,null);    
    --
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',v_err_msg,'FINISHED',null,null);
  exception
    when others then
      v_err_msg := SUBSTR (SQLERRM,1,1000);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);    
  end create_test_log;
END scheduler_pkg;
/
SHOW ERRORS
