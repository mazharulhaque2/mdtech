select svc_perform_date "Service Date"
      ,pat_name "Patient Name"
      ,physician_title||' '||pat_primary_physician_name "Physician Name"
      --,pat_primary_physician_company "Physician Company"
      ,pat_medicare_hic_num_full "HIC"
      ,pat_gender gender
      --,pat_birth_date dob
      ,age
      ,case 
        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then 'Medicare'
        else 'Commercial'
        end "Insurance Type"
      ,decode(old_system_flag,'N','EG',old_system_flag) "Rec Ind"
--      ,case 
--        when report_pkg.medicare_ins_by_hic_flag(pat_medicare_hic_num_full) = 'Y' then prev_svc_billing_code
--        else case when age between 18 and 39 and prev_svc_billing_code = 'G0438' then '99385'
--                  when age between 18 and 39 and prev_svc_billing_code = 'G0439' then '99395'
--                  when age between 40 and 64 and prev_svc_billing_code = 'G0438' then '99386'
--                  when age between 40 and 64 and prev_svc_billing_code = 'G0439' then '99396'
--                  else prev_svc_billing_code
--                  end
--        end "Billing Code"
from pps_simplified_vw 
where completed_flag = 'Y' 
--and old_system_flag = 'Y'
and svc_type_code = 'AWV'
--and patient_prev_svc_sn in (415,410,426,408,386,382,383)
and svc_perform_date > '18-APR-2018'
order by svc_perform_date, pat_primary_physician_name
;

--EM Qualify
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease      
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
where pv.completed_flag = 'Y'
and pv.qualify_for_em_followup_flag = 'Y'
;
--Obesity Report
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease      
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from pps_simplified_vw pv
    ,svc_result_vw srv
where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and srv.disease_code = 'OBES'
and srv.obesity_rf_avail_flag = 'Y'
and srv.disease_level_code <> 'LOW'
;
--Fall Report
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease
      ,srv.disease_level_code disease_level
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
    ,svc_result_vw srv
where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and srv.disease_code = 'FALL'
and srv.disease_level_code <> 'LOW'
;
--CVD Report
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
    ,svc_result_vw srv
where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and srv.disease_code = 'CHDE'
and srv.disease_level_code <> 'LOW'
;
--Alcohol report
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease
      ,prv.response
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
    ,patient_response_vw prv
where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and prv.category_code = 'BEHVT'
and prv.question_code = '1006'
and prv.risk_factor_code is not null
;
--Smoking report
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease
      ,prv.response
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
    ,patient_response_vw prv
where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and prv.category_code = 'BEHVT'
and prv.question_code = '1005'
and prv.risk_factor_code is not null
;
--Uncontrolled HBPR/HCHO/DIAB
select pat_name patient_name
      ,pat_medicare_hic_num hic_num
      ,svc_perform_date service_date
      ,pv.patient_prev_svc_sn
      ,pat_age age
      ,pat_bmi
      ,pv.chronic_disease_cnt chronic_disease
      ,prv.response
      ,svc_location_name service_location
      ,provider_physician_name interviewer
from patient_prev_svc_vw pv
    ,patient_response_vw prv
where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
and pv.completed_flag = 'Y'
and prv.category_code = 'BEHVT'
and prv.question_code = '1003'
and prv.risk_factor_code is not null
;
