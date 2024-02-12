--create or replace view country_pref_lang_vw as
--select distinct can.country_code
--      ,decode(can.country_code,'AF','ur','AL','sq','AM','hy','AT','de','AZ','az','BH','ar','BD','as','BY','kk','BJ','fr','BT','gu','BA','bg','BR','kw','BG','ro','BI','rn'
--            ,'KH','zh','CM','fr','CV','fr','CF','fr','TD','wa','CN','zh','KM','ur','HR','bs','CY','el','CZ','cs','CD','ki','CG','fr','DK','sv','DO','pt','EG','fa','GQ','es'
--            ,'EE','et','FK','es','FO','fo','FI','fi','GF','fr','PF','fr','GA','ka','DE','de','GH','so','GR','el','GL','kl','GN','cy','GW','pt','HK','zh','HU','hu','IS','cs'
--            ,'IR','ur','IQ','ur','IL','he','IT','la','JP','ja','JO','ur','KZ','be','KW','ar','KG','ru','LA','bo','LV','sl','LB','ur','LY','ur','LT','lv','MO','zh','MG','mg'
--            ,'MR','ur','MU','ht','MX','pt','MD','an','MN','os','ME','bs','MZ','sv','MM','bo','NA','af','NP','hi','NL','nl','NC','fr','NE','ha','KP','ko','NO','da','OM','ur'
--            ,'PK','ur','PS','ar','PA','fr','PE','ca','PL','hr','QA','ur','RE','fr','RO','hu','RU','uz','ST','gl','SA','ar','RS','sr','SK','cs','SI','bs','KR','ko','SS','zh'
--            ,'ES','an','LK','si','SD','fa','SE','sv','CH','sv','SY','ur','TW','zh','TH','th','TR','tr','UA','be','AE','ar','UZ','uz','VN','vi','YE','fa','IN','bh',null) lang_code
--      --,CAN.ALT_NAME
--from country_alt_name can
--    ,list_lang ll
--where CAN.LANG_CODE = LL.LANG_CODE
--;
create or replace view addr_vw as
select a.addr_sn
      ,a.formatted_addr
      ,a.addr_1
      ,a.addr_2
      ,a.postal_code
      ,a.county_name
      --
      ,c.name city_name
      ,s.state_code
      ,s.name state_name
      ,cn.country_code
      ,cn.name country_name
from addr a
    ,city c
    ,state s
    ,country cn
where a.city_sn = c.city_sn
and c.state_sn = s.state_sn
and s.country_code = cn.country_code
and a.active_flag = 'Y'
and c.active_flag = 'Y'
and s.active_flag = 'Y'
and cn.active_flag = 'Y'
;
create or replace view active_user_vw as
select u."Id" user_id
      ,r."Id" role_id
      ,ur.user_role_id
      ,r."Name" role_name
      ,lower(u."UserName") user_name
      ,u."Email" email
      ,u."PhoneNumber" phone
      ,c.company_sn
      ,c.name company_name
      ,c.ithealth_company_flag
      ,c.contact_name company_contact_name
      ,c.phone_number company_phone
      ,u.svc_provider_flag user_is_a_provider_flag
      ,r.service_provider_flag
      ,case 
        when u.middle_name is not null then u.first_name||' '||u.middle_name||' '||u.last_name
        else u.first_name||' '||u.last_name
        end name
from "AspNetRoles" r
     ,"AspNetUserRoles" ur
     ,"AspNetUsers" u
     ,company c
where ur."UserId" = u."Id"
and ur."RoleId" = r."Id"
and r."Id" not in ('96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
and u.company_sn = c.company_sn(+)
and ur.active_flag = 'Y'
and u.active_flag = 'Y'
and r.active_flag = 'Y'
;
create or replace view user_vw as
select u."Id" user_id
      ,r."Id" role_id
      ,ur.user_role_id
      ,r."Name" role_name
      ,lower(u."UserName") user_name
      ,c.company_sn
      ,c.name company_name
      ,c.ithealth_company_flag
      ,c.contact_name company_contact_name
      ,c.phone_number company_phone
      ,u."Email" email
      ,u."PhoneNumber" phone
      ,u.svc_provider_flag user_is_a_provider_flag
      ,r.service_provider_flag
      ,u.first_name
      ,u.middle_name
      ,u.last_name
      ,case 
        when u.middle_name is not null then u.first_name||' '||u.middle_name||' '||u.last_name
        else u.first_name||' '||u.last_name
        end name
      ,av.formatted_addr addr
      ,av.addr_1
      ,av.addr_2
      ,av.city_name
      ,av.state_code
      ,av.state_name
      ,av.postal_code
      ,av.country_code
      ,decode(ur.active_flag,'Y','Active','Inactive') status
      ,r.active_flag role_active_flag
      ,u.active_flag user_active_flag
      ,ur.active_flag user_role_active_flag
from "AspNetRoles" r
     ,"AspNetUserRoles" ur
     ,"AspNetUsers" u
     ,company c
     ,addr_vw av
where ur."UserId" = u."Id"
and ur."RoleId" = r."Id"
and u.addr_sn = av.addr_sn(+)
and u.company_sn = c.company_sn(+)
;
create or replace view provider_physician_vw as
select pp.provider_physician_sn
      ,pt.physician_type_code
      ,ptl.short_descr physician_type
      ,pp.title title_code
      ,pp.title title
      ,pp.dr_type dr_type_code
      ,case
        when pp.dr_type is null then null
        else drtl.dr_type_code||' - '||drtl.short_descr
        end dr_type
      ,pp.license_num
      ,pp.npi npi
      ,pp.company_sn
      ,c.name company_name
      ,av.formatted_addr company_addr
      ,pp.title||' '||pu.name name
      ,pu.user_name
      ,pu.email
      ,pu.user_role_id
      ,pu.phone
      ,pu.addr
      ,decode(pp.active_flag,'Y','Active','Inactive') status
      ,case
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,pu.user_role_active_flag
      ,nvl(ptl.lang_code,'en') physician_type_lang
from provider_physician pp
    ,list_physician_type pt
    ,physician_type_lang ptl
    ,list_dr_type drt
    ,dr_type_lang drtl
    ,company c
    ,addr_vw av
    ,user_vw pu
    ,user_vw cu
    ,user_vw uu
where pp.physician_type_code = pt.physician_type_code
and pt.physician_type_code = ptl.physician_type_code
and pp.company_sn = c.company_sn
and c.addr_sn = av.addr_sn
and pp.physician_user_role_id = pu.user_role_id
and pp.created_by_user_role_id = cu.user_role_id
and pp.updated_by_user_role_id = uu.user_role_id
and pp.dr_type = drt.dr_type_code(+)
and drt.dr_type_code = drtl.dr_type_code(+)
;
create or replace view physician_vw as
select p.physician_sn
      ,pt.physician_type_code
      ,ptl.short_descr physician_type
      ,p.first_name
      ,p.middle_name
      ,p.last_name
      ,p.title title_code
      ,p.title title
      ,p.license_num
      ,p.npi
      ,c.company_sn
      ,c.name company_name
      ,av.formatted_addr company_addr
      ,p.dr_type dr_type_code
      ,drtl.dr_type_code||' - '||drtl.short_descr dr_type
      ,case 
        when p.middle_name is not null then p.title||' '||p.first_name||' '||p.middle_name||' '||p.last_name
        else p.title||' '||p.first_name||' '||p.last_name
        end name
      ,p.email_addr email
      ,p.contact_phone_num phone
      ,decode(p.active_flag,'Y','Active','Inactive') status
      ,case
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,nvl(ptl.lang_code,'en') physician_type_lang
from physician p
    ,list_physician_type pt
    ,physician_type_lang ptl
    ,list_dr_type drt
    ,dr_type_lang drtl
    ,company c
    ,addr_vw av
    ,user_vw cu
    ,user_vw uu
where p.physician_type_code = pt.physician_type_code
and pt.physician_type_code = ptl.physician_type_code
and p.dr_type = drt.dr_type_code(+)
and drt.dr_type_code = drtl.dr_type_code(+)
and p.company_sn = c.company_sn
and c.addr_sn = av.addr_sn
and p.created_by_user_role_id = cu.user_role_id
and p.updated_by_user_role_id = uu.user_role_id
;
create or replace view patient_vw as
select p.patient_sn
      ,p.ssn
      ,p.old_system_flag
      ,pv.physician_sn
      ,pv.dr_type_code
      ,pv.dr_type physician_dr_type
      ,pv.name physician_name
      ,pv.company_sn physician_company_sn
      ,pv.company_name physician_company
      ,case
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,p.medicare_hic_num
      ,ic.insurance_company_code
      ,ic.name insurance_company_name
      ,av.formatted_addr addr
      ,av.addr_1
      ,av.addr_2
      ,av.city_name
      ,av.state_code
      ,av.state_name
      ,av.postal_code
      ,av.country_code
      ,gl.short_descr gender
      ,gl.gender_code
      ,rl.short_descr race
      ,el.short_descr ethnicity
      ,p.first_name
      ,p.middle_name
      ,p.last_name
      ,case 
        when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
        else p.first_name||' '||p.last_name
        end name
      ,p.contact_phone_num phone
      ,p.email_addr email
      ,p.skype_id skype
      ,to_char(p.birth_date,'MM/DD/YY') birth_date
      ,p.birth_date birth_date_date
      ,common_pkg.age(p.birth_date) age
      ,p.legal_guardian_name
      ,p.legal_guardian_ph
      ,decode(p.active_flag,'Y','Active','Inactive') status
      ,nvl(gl.lang_code,'en') gender_lang_code
      ,nvl(rl.lang_code,'en') race_lang_code
      ,nvl(el.lang_code,'en') ethnicity_lang_code
from patient p
    ,physician_vw pv
    ,addr_vw av
    ,user_vw cu
    ,user_vw uu
    ,list_gender g
    ,gender_lang gl
    ,list_race r
    ,race_lang rl
    ,list_ethnicity e
    ,ethnicity_lang el
    ,insurance_company ic
where p.physician_sn = pv.physician_sn
and p.addr_sn = av.addr_sn(+)
and p.insurance_company_code = ic.insurance_company_code(+)
and p.created_by_user_role_id = cu.user_role_id
and p.updated_by_user_role_id = uu.user_role_id
and p.gender_code = g.gender_code(+)
and g.gender_code = gl.gender_code(+)
and p.race_code = r.race_code(+)
and r.race_code = rl.race_code(+)
and p.ethnicity_code = e.ethnicity_code(+)
and e.ethnicity_code = el.ethnicity_code(+)
;
create or replace view company_vw as
select c.company_sn
      ,c.name
      ,c.ithealth_company_flag
      ,c.contact_name
      ,c.phone_number phone
      ,c.fax_number fax
      ,c.toll_free_number toll_free
      ,c.website_addr website
      ,case
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,av.formatted_addr addr
      ,av.addr_1
      ,av.addr_2
      ,av.city_name
      ,av.state_code
      ,av.state_name
      ,av.postal_code
      ,av.country_code
      ,decode(c.active_flag,'Y','Active','Inactive') status
from company c
    ,addr_vw av
    ,user_vw cu
    ,user_vw uu
where c.addr_sn = av.addr_sn
and c.created_by_user_role_id = cu.user_role_id
and c.updated_by_user_role_id = uu.user_role_id
;
create or replace view patient_medication_vw as
select pm.patient_medication_sn
      ,pm.patient_sn
      ,initcap(pm.name) name
      ,pm.medication_quantity quantity
      ,mul.medication_unit_code quantity_unit_code
      ,mul.short_descr quantity_unit
      ,pm.ingredients
      ,pm.purpose
      ,fu.frequency_unit_code frequency_unit
      ,ful.short_descr frequency
      ,pm.medication_current_flag
      ,pm.prescribed_med_flag
      ,pm.notes
      ,case 
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,decode(pm.active_flag,'Y','Active','Inactive') status
      ,ful.lang_code frequency_lang_code
      ,mul.lang_code medication_unit_lang_code
from patient_medication pm
    ,user_vw cu
    ,user_vw uu
    ,list_frequency_unit fu
    ,frequency_unit_lang ful
    ,list_medication_unit mu
    ,medication_unit_lang mul
where pm.created_by_user_role_id = cu.user_role_id
and pm.updated_by_user_role_id = uu.user_role_id
and pm.frequency_unit_code = fu.frequency_unit_code(+)
and fu.frequency_unit_code = ful.frequency_unit_code(+)
and pm.medication_unit_code = mu.medication_unit_code(+)
and mu.medication_unit_code = mul.medication_unit_code(+)
;
create or replace view svc_location_vw as
select sl.svc_location_sn
      ,sl.name
      ,c.company_sn
      ,c.name company_name
      ,sl.contact_name
      ,sl.phone_num_1 phone
      ,sl.fax_num_1 fax
      ,sl.email_addr email
      ,sltl.svc_location_type_code svc_location_code
      ,sltl.short_descr svc_location_type
      ,av.formatted_addr addr
      ,av.addr_1
      ,av.addr_2
      ,av.city_name
      ,av.postal_code
      ,av.state_code
      ,av.state_name
      ,av.country_code
      ,case 
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,decode(sl.active_flag,'Y','Active','Inactive') status
      ,nvl(sltl.lang_code,'en') svc_location_type_lang_code
from svc_location sl
    ,company c
    ,user_vw cu
    ,user_vw uu
    ,addr_vw av
    ,list_svc_location_type slt
    ,svc_location_type_lang sltl
where sl.company_sn = c.company_sn
and sl.created_by_user_role_id = cu.user_role_id
and sl.updated_by_user_role_id = uu.user_role_id
and sl.addr_sn = av.addr_sn
and sl.svc_location_type_code = slt.svc_location_type_code
and slt.svc_location_type_code = sltl.svc_location_type_code
;
create or replace view user_svc_location_vw as
select usl.user_svc_location_sn
      ,uv.user_id
      ,uv.user_role_id
      ,uv.email user_email
      ,uv.name
      ,uv.phone user_phone
      ,uv.role_name user_role_name
      ,uv.company_sn
      ,uv.company_name
      ,slv.svc_location_sn
      ,slv.name svc_location_name
      ,slv.phone svc_location_phone
      ,slv.svc_location_type
      ,slv.addr svc_location_addr
      ,decode(usl.active_flag,'Y','Active','Inactive') status
from user_svc_location usl
    ,user_vw uv
    ,svc_location_vw slv
where usl.user_role_id = uv.user_role_id
and usl.svc_location_sn = slv.svc_location_sn
;
create or replace view physician_svc_location_vw as
select psl.physician_svc_location_sn
      ,psl.physician_sn
      ,slv.name svc_location_name
      ,slv.addr svc_location_addr
      ,pv.name physician_name
      ,pv.company_sn
      ,pv.company_name physician_company_name
      ,slv.svc_location_sn
      ,slv.svc_location_type
      ,case 
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,decode(psl.active_flag,'Y','Active','Inactive') status
from physician_svc_location psl
    ,user_vw cu
    ,user_vw uu
    ,physician_vw pv
    ,svc_location_vw slv
where psl.created_by_user_role_id = cu.user_role_id
and psl.updated_by_user_role_id = uu.user_role_id
and psl.physician_sn = pv.physician_sn
and psl.svc_location_sn = slv.svc_location_sn
;
create or replace view patient_prev_svc_vw as
select pps.patient_prev_svc_sn
      ,pps.patient_sn
      ,pps.parent_patient_prev_svc_sn
      ,to_char(pps.svc_date,'YYYY-MM-DD') svc_date
      ,to_char(pps.svc_perform_date,'MM/DD/YYYY') svc_perform_date
      ,pps.g0438_comp_on_diff_sys_flag
      ,pps.svc_comp_flag completed_flag
      ,pps.qualify_for_em_followup_flag
      ,pps.CHRONIC_DISEASE_CNT
      ,pv.old_system_flag
      ,pv.physician_sn pat_primary_physician_sn
      ,pv.physician_dr_type primary_physician_dr_type
      ,pv.physician_name pat_primary_physician_name
      ,pv.physician_company pat_primary_physician_company
      ,pv.ssn pat_ssn
      ,pv.medicare_hic_num pat_medicare_hic_num
      ,pv.addr pat_addr
      ,pv.gender pat_gender
      ,pv.gender_code pat_gender_code
      ,pv.race pat_race
      ,pv.ethnicity pat_ethnicity
      ,ml.short_descr pat_marital_status
      ,wl.short_descr pat_working_status
      ,ell.short_descr pat_educational_level
      ,fsl.short_descr pat_financial_status
      ,lsl.short_descr pat_living_status
      ,il.short_descr pat_income
      ,pv.first_name pat_first_name
      ,pv.middle_name pat_middle_name
      ,pv.last_name pat_last_name
      ,pv.name pat_name
      ,pv.phone pat_phone
      ,pv.email pat_email
      ,pv.birth_date pat_birth_date
      ,pv.age pat_age
      ,common_pkg.age_at_a_date(pv.birth_date_date,nvl(pps.svc_perform_date,sysdate)) pat_age_at_svc_perform_date
      ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in) pat_bmi
      ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)) pat_bmi_result
      ,pps.height_in_in pat_height_in_in
      ,common_pkg.height_in_feet(pps.height_in_in) pat_height_in_ft
      ,pps.waist_in_in pat_waist_in_in
      ,pps.weight_in_lb pat_weight_in_lb
      ,pps.hdl_cholesterol_in_mg pat_hdl_cholesterol_in_mg
      ,pps.ldl_cholesterol_in_mg pat_ldl_cholesterol_in_mg
      ,pps.systolic_bp_in_mm pat_systolic_bp_in_mm
      ,pps.diastolic_bp_in_mm pat_diastolic_bp_in_mm
      ,pps.blood_sugar_level_in_mg pat_blood_sugar_level_in_mg
      ,pps.svc_number
      ,pps.followed_rf_therapy_goals_flag
      ,pps.reason_of_not_achiving_goals      
      ,common_inq_pkg.source_of_history(pps.SOURCE_OF_HISTORY_EMR_FLAG,pps.SOURCE_OF_HISTORY_PATIENT_FLAG,pps.SOURCE_OF_HISTORY_FAMILY_FLAG) source_of_history
      ,pol.short_descr PATIENT_ORIENTATION
      ,pv.legal_guardian_name pat_legal_guardian_name
      ,pv.legal_guardian_ph pat_legal_guardian_ph
      ,pslv.svc_location_name
      ,pslv.svc_location_addr
      ,ppv.dr_type provider_physician_dr_type
      ,ppv.name provider_physician_name
      ,ppv.company_name provider_physician_company
      ,ppv.user_name provider_physician_user_name
      ,ppv.license_num provider_physician_lic_num
      ,ppv.npi provider_physician_npi
      ,psbl.prev_svc_billing_code billing_code
      ,psbl.prev_svc_billing_code||'('||psbl.short_descr||')' billing_code_descr
      ,pstl.prev_svc_type_code svc_type_code
      ,pstl.short_descr svc_type 
      ,pps.sub_prev_svc_billing_code sub_billing_code
      ,pps.addl_sub_prev_svc_billing_code addl_sub_billing_code
      ,case 
        when cu.name is not null then cu.email||'('||cu.name||')'
        else cu.email
        end created_by
      ,case
        when uu.name is not null then uu.email||'('||uu.name||')'
        else uu.email
        end updated_by
      ,decode(pps.active_flag,'Y','Active','Inactive') status
      ,nvl(psbl.lang_code,'en') prev_svc_billing_lang_code
      ,nvl(pstl.lang_code,'en') prev_svc_type_lang_code
      ,nvl(ml.lang_code,'en') marital_status_lang_code
      ,nvl(wl.lang_code,'en') working_status_lang_code
      ,nvl(ell.lang_code,'en') education_level_lang_code
      ,nvl(fsl.lang_code,'en') financial_status_lang_code
      ,nvl(lsl.lang_code,'en') living_status_lang_code
      ,nvl(il.lang_code,'en') income_lang_code
from patient_prev_svc pps
    ,user_vw cu
    ,user_vw uu
    ,patient_vw pv
    ,physician_svc_location_vw pslv
    ,provider_physician_vw ppv
    ,list_prev_svc_billing psb
    ,prev_svc_billing_lang psbl
    ,list_prev_svc_type pst
    ,prev_svc_type_lang pstl
    ,list_marital_status m
    ,marital_status_lang ml
    ,list_working_status w
    ,working_status_lang wl
    ,list_education_level el
    ,education_level_lang ell
    ,list_financial_status fs
    ,financial_status_lang fsl
    ,list_living_status ls
    ,living_status_lang lsl
    ,list_income i
    ,income_lang il
    ,list_patient_orientation po
    ,patient_orientation_lang pol
where pps.created_by_user_role_id = cu.user_role_id
and pps.updated_by_user_role_id = uu.user_role_id
and pps.patient_sn = pv.patient_sn
and pps.physician_svc_location_sn = pslv.physician_svc_location_sn
and pps.provider_physician_sn = ppv.provider_physician_sn
and pps.prev_svc_billing_code = psb.prev_svc_billing_code
and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
and psb.prev_svc_type_code = pst.prev_svc_type_code
and pst.prev_svc_type_code = pstl.prev_svc_type_code
and pps.marital_status_code = m.marital_status_code(+)
and m.marital_status_code = ml.marital_status_code(+)
and pps.working_status_code = w.working_status_code(+)
and w.working_status_code = wl.working_status_code(+)
and pps.education_level_code = el.education_level_code(+)
and el.education_level_code = ell.education_level_code(+)
and pps.financial_status_code = fs.financial_status_code(+)
and fs.financial_status_code = fsl.financial_status_code(+)
and pps.living_status_code = ls.living_status_code(+)
and ls.living_status_code = lsl.living_status_code(+)
and pps.income_code = i.income_code(+)
and i.income_code = il.income_code(+)
and pps.patient_orientation_code = po.patient_orientation_code(+)
and po.patient_orientation_code = pol.patient_orientation_code(+)
;
create or replace view question_response_vw as
select qr.question_response_code
      ,pst.prev_svc_type_code svc_type
      ,sbqc.prev_svc_billing_code billing_code
      ,qcgl.short_descr section
      ,qcgl.long_descr section_descr
      ,qcl.question_categ_code category_code
      ,qcl.short_descr category
      ,lqc.data_entry_categ_flag
      ,q.question_sub_categ_code sub_category_code
      ,qscl.short_descr sub_category
      ,q.question_code
      ,ql.short_descr question
      ,ql.long_descr question_rpt_descr
      ,qr.response_code
      ,rl.short_descr response
      ,qr.score_value response_score
      ,qr.disease_code
      ,qr.symptom_code
      ,qr.risk_factor_code
      ,qr.disease_level_code
      ,qr.em_name_code
      ,q.triggered_other_code
      ,q.order_num question_order_num
      ,qr.order_num question_response_order_num
      ,nvl(ql.lang_code,'en') question_lang_code
      ,nvl(rl.lang_code,'en') response_lang_code
      ,nvl(qcl.lang_code,'en') question_categ_lang_code
      ,nvl(qcgl.lang_code,'en') question_categ_grp_lang_code
      ,nvl(qscl.lang_code,'en') question_sub_categ_lang_code
from question q
    ,question_lang ql
    ,question_response qr
    ,list_response r
    ,response_lang rl
    ,list_question_categ lqc
    ,question_categ_lang qcl
    ,list_prev_svc_billing lpsb
    ,list_question_categ_grp lqcg
    ,question_categ_grp_lang qcgl
    ,svc_billing_question_categ sbqc
    ,list_prev_svc_type pst
    ,list_question_sub_categ qsc
    ,question_sub_categ_lang qscl
where q.question_sn = ql.question_sn
and q.question_sn = qr.question_sn
and qr.response_code = r.response_code
and r.response_code = rl.response_code
and q.question_categ_code = lqc.question_categ_code
and lqc.question_categ_code = qcl.question_categ_code
and lqc.question_categ_grp_code = lqcg.question_categ_grp_code
and lqcg.question_categ_grp_code = qcgl.question_categ_grp_code
--
and lqc.question_categ_code = sbqc.question_categ_code
and lpsb.prev_svc_billing_code = sbqc.prev_svc_billing_code
and lpsb.prev_svc_type_code = pst.prev_svc_type_code
--
and q.question_sub_categ_code = qsc.question_sub_categ_code(+)
and qsc.question_sub_categ_code = qscl.question_sub_categ_code(+)
--
and q.active_flag = 'Y'
and ql.active_flag = 'Y'
and qr.active_flag = 'Y'
and r.active_flag = 'Y'
and rl.active_flag = 'Y'
and lqc.active_flag = 'Y'
and qcl.active_flag = 'Y'
and lpsb.active_flag = 'Y'
and lqcg.active_flag = 'Y'
and qcgl.active_flag = 'Y'
and sbqc.active_flag = 'Y'
and pst.active_flag = 'Y'
and qsc.active_flag(+) = 'Y'
and qscl.active_flag(+) = 'Y'
;
create or replace view hx_question_response_vw as
select qr.question_response_code
      ,qcgl.short_descr section
      ,qcgl.long_descr section_descr
      ,qcl.question_categ_code category_code
      ,qcl.short_descr category
      ,lqc.data_entry_categ_flag
      ,q.question_sub_categ_code sub_category_code
      ,qscl.short_descr sub_category
      ,q.question_sn
      ,q.question_code
      ,ql.short_descr question
      ,ql.long_descr question_rpt_descr
      ,qr.response_code
      ,rl.short_descr response
      ,qr.score_value response_score
      ,qr.disease_code
      ,qr.symptom_code
      ,qr.risk_factor_code
      ,qr.disease_level_code
      ,qr.em_name_code
      ,q.triggered_question_categ_code
      ,q.triggered_question_code
      ,q.triggered_response_code
      ,q.conditional_question_flag
      ,q.triggered_other_code
      ,q.order_num question_order_num
      ,qr.order_num question_response_order_num
      ,nvl(ql.lang_code,'en') question_lang_code
      ,nvl(rl.lang_code,'en') response_lang_code
      ,nvl(qcl.lang_code,'en') question_categ_lang_code
      ,nvl(qcgl.lang_code,'en') question_categ_grp_lang_code
      ,nvl(qscl.lang_code,'en') question_sub_categ_lang_code
from question q
    ,question_lang ql
    ,question_response qr
    ,list_response r
    ,response_lang rl
    ,list_question_categ lqc
    ,question_categ_lang qcl
    ,list_question_categ_grp lqcg
    ,question_categ_grp_lang qcgl
    ,list_question_sub_categ qsc
    ,question_sub_categ_lang qscl
where q.question_sn = ql.question_sn
and q.question_sn = qr.question_sn
and qr.response_code = r.response_code
and r.response_code = rl.response_code
and q.question_categ_code = lqc.question_categ_code
and lqc.question_categ_code = qcl.question_categ_code
and lqc.question_categ_grp_code = lqcg.question_categ_grp_code
and lqcg.question_categ_grp_code = qcgl.question_categ_grp_code
--
and q.question_sub_categ_code = qsc.question_sub_categ_code(+)
and qsc.question_sub_categ_code = qscl.question_sub_categ_code(+)
and qcl.question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR')
--
and q.active_flag = 'Y'
and ql.active_flag = 'Y'
and qr.active_flag = 'Y'
and r.active_flag = 'Y'
and rl.active_flag = 'Y'
and lqc.active_flag = 'Y'
and qcl.active_flag = 'Y'
and lqcg.active_flag = 'Y'
and qcgl.active_flag = 'Y'
and qsc.active_flag(+) = 'Y'
and qscl.active_flag(+) = 'Y'
;
create or replace view patient_history_vw as
select ph.patient_history_sn
      ,ph.patient_sn
      ,ph.question_response_code
      ,qrv.section
      ,qrv.section_descr
      ,qrv.category_code
      ,qrv.category
      ,qrv.sub_category_code
      ,qrv.sub_category
      ,qrv.question_code
      ,qrv.question
      ,qrv.question_rpt_descr
      ,qrv.response_code
      ,qrv.question_order_num
      ,qrv.response
      ,qrv.response_score
      ,qrv.disease_code
      ,qrv.symptom_code
      ,qrv.risk_factor_code
      ,qrv.disease_level_code
      ,qrv.em_name_code
      ,qrv.triggered_other_code
from patient_history ph
    ,hx_question_response_vw qrv
    ,patient p
where ph.question_response_code = qrv.question_response_code
and ph.patient_sn = p.patient_sn
and qrv.question_lang_code = 'en'
and qrv.response_lang_code = 'en'
and qrv.question_categ_lang_code = 'en'
and qrv.question_categ_grp_lang_code = 'en'
and qrv.question_sub_categ_lang_code = 'en'
and ph.active_flag = 'Y'
;
create or replace view patient_history_all_vw as
select ph.patient_history_sn
      ,ph.patient_sn
      ,ph.question_response_code
      ,ph.active_flag ph_active_flag
      ,qrv.section
      ,qrv.section_descr
      ,qrv.category_code
      ,qrv.category
      ,qrv.sub_category_code
      ,qrv.sub_category
      ,qrv.question_code
      ,qrv.question
      ,qrv.question_rpt_descr
      ,qrv.response_code
      ,qrv.question_order_num
      ,qrv.response
      ,qrv.response_score
      ,qrv.disease_code
      ,qrv.symptom_code
      ,qrv.risk_factor_code
      ,qrv.disease_level_code
      ,qrv.em_name_code
      ,qrv.triggered_other_code
from patient_history ph
    ,hx_question_response_vw qrv
    ,patient p
where ph.question_response_code = qrv.question_response_code
and ph.patient_sn = p.patient_sn
and qrv.question_lang_code = 'en'
and qrv.response_lang_code = 'en'
and qrv.question_categ_lang_code = 'en'
and qrv.question_categ_grp_lang_code = 'en'
and qrv.question_sub_categ_lang_code = 'en'
;
create or replace view categ_score_eval_vw as
select cse.categ_score_eval_code
      ,cse.question_categ_code category_code
      ,qcl.short_descr category
      ,qsc.question_sub_categ_code sub_category_code
      ,qscl.short_descr sub_category
      ,csel.short_descr score
      ,cse.disease_level_code
      ,cse.trigger_further_categ_flag
      ,cse.score_range_begin
      ,cse.score_range_end
      ,nvl(qscl.lang_code,'en') question_sub_categ_lang_code
      ,nvl(csel.lang_code,'en') categ_score_eval_lang_code
      ,nvl(qcl.lang_code,'en') question_categ_lang_code      
from categ_score_eval cse
    ,categ_score_eval_lang csel
    ,list_question_categ lqc
    ,question_categ_lang qcl    
    ,list_question_sub_categ qsc
    ,question_sub_categ_lang qscl
where cse.categ_score_eval_code = csel.categ_score_eval_code
and cse.question_categ_code = lqc.question_categ_code
and lqc.question_categ_code = qcl.question_categ_code
and cse.question_sub_categ_code = qsc.question_sub_categ_code(+)
and qsc.question_sub_categ_code = qscl.question_sub_categ_code(+)
--
and cse.active_flag = 'Y'
and csel.active_flag = 'Y'
and lqc.active_flag = 'Y'
and qcl.active_flag = 'Y'
and qsc.active_flag(+) = 'Y'
and qscl.active_flag(+) = 'Y'
;
create or replace view patient_response_vw as
select pr.patient_response_sn
      ,pps.patient_sn
      ,pr.patient_prev_svc_sn
      ,pr.question_response_code
      ,qrv.svc_type
      ,qrv.billing_code      
      ,qrv.section
      ,qrv.section_descr
      ,qrv.category_code
      ,qrv.category
      ,qrv.sub_category_code
      ,qrv.sub_category
      ,qrv.question_code
      ,qrv.question
      ,qrv.question_rpt_descr
      ,qrv.response_code
      ,qrv.response
      ,qrv.response_score
      ,pr.response_data
      ,qrv.disease_code
      ,qrv.symptom_code
      ,qrv.risk_factor_code
      ,qrv.disease_level_code
      ,qrv.em_name_code
      ,qrv.triggered_other_code
from patient_response pr
    ,question_response_vw qrv
    ,patient_prev_svc pps
where pr.question_response_code = qrv.question_response_code
and pr.patient_prev_svc_sn = pps.patient_prev_svc_sn
and pps.prev_svc_billing_code = qrv.billing_code
and qrv.question_lang_code = 'en'
and qrv.response_lang_code = 'en'
and qrv.question_categ_lang_code = 'en'
and qrv.question_categ_grp_lang_code = 'en'
and qrv.question_sub_categ_lang_code = 'en'
;

create or replace view em_name_vw as
select enl.em_name_code
      ,enl.short_descr em_name_short_descr
      ,enl.long_descr em_name_long_descr
      ,enl.intervention_descr
      ,en.order_num em_name_order_num
      ,en.usda_immu_comp_flag
      ,en.triggered_code
      ,en.usda_immu_comp_age_begin
      ,en.usda_immu_comp_age_end    
      ,ecgl.em_categ_grp_code
      ,ecgl.short_descr em_categ_grp_short_descr
      ,ecgl.long_descr em_categ_grp_long_descr
      ,ecl.em_categ_code
      ,ecl.short_descr em_categ_short_descr
      ,ecl.long_descr em_categ_long_descr
      ,ecgl.lang_code em_categ_grp_lang_code
      ,ecl.lang_code em_categ_lang_code
      ,enl.lang_code em_name_lang_code
from list_em_categ_grp ecg
    ,em_categ_grp_lang ecgl
    ,list_em_categ ec
    ,em_categ_lang ecl
    ,list_em_name en
    ,em_name_lang enl
where ecg.em_categ_grp_code = ecgl.em_categ_grp_code
and ecg.em_categ_grp_code = ec.em_categ_grp_code
and ec.em_categ_code = ecl.em_categ_code
and ec.em_categ_code = en.em_categ_code
and en.em_name_code = enl.em_name_code
and ecg.active_flag = 'Y'
and ecgl.active_flag = 'Y'
and ec.active_flag = 'Y'
and ecl.active_flag = 'Y'
and en.active_flag = 'Y'
and enl.active_flag = 'Y'
;
create or replace view disease_vw as
select dl.disease_code
      ,dl.short_descr disease_short_descr
      ,dl.long_descr disease_long_descr
      ,d.disease_type_code
      ,dtl.short_descr dis_type_short_descr
      ,d.disease_categ_code
      ,dcl.short_descr dis_cat_short_descr
      ,dcl.long_descr dis_cat_long_descr
      ,d.question_categ_code
      ,qcl.short_descr qtn_cat_short_descr
      ,d.trigger_ccm_flag
      ,qst.question_score_type_code
      ,qst.descr question_score_type_descr
from list_disease d
    ,disease_lang dl
    ,list_disease_type dt
    ,disease_type_lang dtl
    ,list_disease_categ dc
    ,disease_categ_lang dcl
    ,list_question_categ qc
    ,question_categ_lang qcl
    ,list_question_score_type qst
where d.disease_code = dl.disease_code
and dl.lang_code = 'en'
and d.disease_type_code = dt.disease_type_code
and dt.disease_type_code = dtl.disease_type_code
and dtl.lang_code = 'en'
and d.disease_categ_code = dc.disease_categ_code
and dc.disease_categ_code = dcl.disease_categ_code
and dcl.lang_code = 'en'
and d.question_categ_code = qc.question_categ_code(+)
and qc.question_categ_code = qcl.question_categ_code(+)
and qcl.lang_code(+) = 'en'
and qc.question_score_type_code = qst.question_score_type_code(+)
and qst.active_flag(+) = 'Y'
and d.active_flag = 'Y'
and dl.active_flag = 'Y'
and dt.active_flag = 'Y'
and dtl.active_flag = 'Y'
and dc.active_flag = 'Y'
and dcl.active_flag = 'Y'
and qc.active_flag(+) = 'Y'
and qcl.active_flag(+) = 'Y'
;
create or replace view symptom_vw as
select s.symptom_code
      ,sl.short_descr symp_short_descr
      ,s.symptom_categ_code
      ,scl.short_descr symp_cat_short_descr
from list_symptom s
    ,symptom_lang sl
    ,list_symptom_categ sc
    ,symptom_categ_lang scl
where s.symptom_code = sl.symptom_code
and sl.lang_code = 'en'
and s.symptom_categ_code = sc.symptom_categ_code
and sc.symptom_categ_code = scl.symptom_categ_code
and scl.lang_code = 'en'
and s.active_flag = 'Y'
and sl.active_flag = 'Y'
and sc.active_flag = 'Y'
and scl.active_flag = 'Y'
;
create or replace view disease_symptom_vw as
select dv.disease_code
      ,dv.disease_short_descr
      ,sv.symptom_code
      ,sv.symp_short_descr
      ,s.severity_code
      ,sl.short_descr severity_short_descr
      ,sv.symptom_categ_code
      ,sv.symp_cat_short_descr
      ,dv.disease_long_descr
      ,dv.disease_type_code
      ,dv.dis_type_short_descr
      ,dv.disease_categ_code
      ,dv.dis_cat_short_descr
      ,dv.dis_cat_long_descr
      ,dv.question_categ_code
      ,dv.qtn_cat_short_descr
      ,dv.trigger_ccm_flag
from symptom_vw sv
    ,disease_vw dv
    ,list_severity s
    ,severity_lang sl
    ,disease_symptom ds
where ds.disease_code = dv.disease_code
and ds.symptom_code = sv.symptom_code
and ds.severity_code = s.severity_code
and s.severity_code = sl.severity_code
and sl.lang_code = 'en'
and ds.active_flag = 'Y'
and s.active_flag = 'Y'
and sl.active_flag = 'Y'
;
create or replace view risk_factor_vw as
select rf.risk_factor_code
      ,rfl.short_descr rf_short_descr
      ,rf.risk_factor_categ_code
      ,rfcl.short_descr rf_cat_short_descr
      ,rf.risk_factor_is_a_disease_flag
      ,rfc.diet_categ_flag
from list_risk_factor rf
    ,risk_factor_lang rfl
    ,list_risk_factor_categ rfc
    ,risk_factor_categ_lang rfcl
where rf.risk_factor_code = rfl.risk_factor_code
and rfl.lang_code = 'en'
and rf.risk_factor_categ_code = rfc.risk_factor_categ_code
and rfc.risk_factor_categ_code = rfcl.risk_factor_categ_code
and rfcl.lang_code = 'en'
and rf.active_flag = 'Y'
and rfl.active_flag = 'Y'
and rfc.active_flag = 'Y'
and rfcl.active_flag = 'Y'
;
create or replace view disease_risk_factor_vw as
select dv.disease_code
      ,dv.disease_short_descr
      ,rfv.risk_factor_code
      ,rfv.rf_short_descr
      ,rfs.severity_code
      ,drf.PRIMARY_RISK_FACTOR_FLAG
      ,rfv.risk_factor_is_a_disease_flag
      ,rfsl.short_descr severity_short_descr
      ,rfv.risk_factor_categ_code
      ,rfv.diet_categ_flag rf_diet_categ_flag
      ,rfv.rf_cat_short_descr
      ,dv.disease_long_descr
      ,dv.disease_type_code
      ,dv.dis_type_short_descr
      ,dv.disease_categ_code
      ,dv.dis_cat_short_descr
      ,dv.dis_cat_long_descr
      ,dv.question_categ_code
      ,dv.qtn_cat_short_descr
      ,dv.trigger_ccm_flag
from risk_factor_vw rfv
    ,disease_vw dv
    ,list_severity rfs
    ,severity_lang rfsl
    ,disease_risk_factor drf
where drf.disease_code = dv.disease_code
and drf.risk_factor_code = rfv.risk_factor_code
and drf.severity_code = rfs.severity_code
and rfs.severity_code = rfsl.severity_code
and rfsl.lang_code = 'en'
and drf.active_flag = 'Y'
and rfs.active_flag = 'Y'
and rfsl.active_flag = 'Y'
;
create or replace view svc_result_vw as
select sr.svc_result_sn
      ,pps.patient_sn
      ,sr.patient_prev_svc_sn
      ,sr.disease_code
      ,dv.disease_short_descr
      ,dv.trigger_ccm_flag
      ,sr.obesity_rf_avail_flag
      ,sr.disease_level_code
      ,dll.short_descr dis_level_short_descr
      ,sr.disease_severity_code
      ,dsl.short_descr dis_severity_short_descr
      ,dv.question_categ_code
      ,dv.disease_long_descr
      ,dv.disease_type_code
      ,dv.dis_type_short_descr
      ,dv.disease_categ_code
      ,dv.dis_cat_short_descr
      ,dv.dis_cat_long_descr
      ,dv.question_score_type_code
      ,dv.question_score_type_descr
from svc_result sr
    ,patient_prev_svc pps
    ,disease_vw dv
    ,list_disease_level dl
    ,disease_level_lang dll
    ,list_disease_severity ds
    ,disease_severity_lang dsl
where sr.patient_prev_svc_sn = pps.patient_prev_svc_sn
and sr.disease_code = dv.disease_code
and sr.disease_level_code = dl.disease_level_code
and dl.disease_level_code = dll.disease_level_code
and dll.lang_code = 'en'
and sr.disease_severity_code = ds.disease_severity_code
and ds.disease_severity_code = dsl.disease_severity_code
and dsl.lang_code = 'en'
and sr.active_flag = 'Y'
and pps.active_flag = 'Y'
and dl.active_flag = 'Y'
and dll.active_flag = 'Y'
and ds.active_flag = 'Y'
and dsl.active_flag = 'Y'
;
create or replace view prev_plan_vw as
select pp.prev_plan_code
      ,ppl.short_descr prev_plan_short_descr
      ,ppl.long_descr prev_plan_long_descr
from list_prev_plan pp
    ,prev_plan_lang ppl
where pp.prev_plan_code = ppl.prev_plan_code
and ppl.lang_code = 'en'
and pp.active_flag = 'Y'
and ppl.active_flag = 'Y'
;
create or replace view risk_factor_prev_plan_vw as
select rfpp.risk_factor_code
      ,rfv.rf_short_descr
      ,rfpp.prev_plan_code
      ,ppv.prev_plan_short_descr
      ,ppv.prev_plan_long_descr
      ,rfpp.order_num
      ,rfv.rf_cat_short_descr
      ,rfv.diet_categ_flag rf_diet_categ_flag
      ,rfv.risk_factor_categ_code
      ,rfv.risk_factor_is_a_disease_flag
from risk_factor_prev_plan rfpp
    ,risk_factor_vw rfv
    ,prev_plan_vw ppv
where rfpp.risk_factor_code = rfv.risk_factor_code
and rfpp.prev_plan_code = ppv.prev_plan_code
and rfpp.active_flag = 'Y'
;
create or replace view disease_prev_plan_vw as
select dpp.disease_code
      ,dpp.prev_plan_code
      ,ppv.prev_plan_short_descr
      ,ppv.prev_plan_long_descr
      ,dpp.order_num
      ,dv.question_categ_code
      ,dv.disease_long_descr
      ,dv.disease_type_code
      ,dv.dis_type_short_descr
      ,dv.disease_categ_code
      ,dv.dis_cat_short_descr
      ,dv.dis_cat_long_descr
      ,dv.question_score_type_code
      ,dv.question_score_type_descr
from disease_prev_plan dpp
    ,disease_vw dv
    ,prev_plan_vw ppv
where dpp.disease_code = dv.disease_code
and dpp.prev_plan_code = ppv.prev_plan_code
and dpp.active_flag = 'Y'
;
create or replace view pps_simplified_vw as
select pps.patient_prev_svc_sn
      ,psl.physician_svc_location_sn
      ,pps.svc_comp_flag completed_flag
      ,p.old_system_flag
      ,pps.svc_date
      ,pps.svc_perform_date
      ,pps.qualify_for_em_followup_flag
      ,pps.chronic_disease_cnt
      ,psb.prev_svc_type_code svc_type_code
      ,pstl.short_descr svc_type_descr
      ,pps.prev_svc_billing_code
      ,psbl.short_descr billing_code_descr
      ,pps.sub_prev_svc_billing_code
      ,pps.addl_sub_prev_svc_billing_code
      ,pps.g0438_comp_on_diff_sys_flag
      ,pps.parent_patient_prev_svc_sn
      ,to_char(p.birth_date,'MM/DD/YY') birth_date
      ,p.birth_date birth_date_date      
      ,common_pkg.age(p.birth_date) age
      ,common_pkg.age_at_a_date(p.birth_date,nvl(pps.svc_perform_date,sysdate)) pat_age_at_svc_perform_date
      ,common_pkg.bmi(pps.weight_in_lb,pps.height_in_in) pat_bmi
      ,common_pkg.bmi_result(common_pkg.bmi(pps.weight_in_lb,pps.height_in_in)) pat_bmi_result
      ,pps.height_in_in pat_height_in_in
      ,common_pkg.height_in_feet(pps.height_in_in) pat_height_in_ft
      ,pps.waist_in_in pat_waist_in_in
      ,common_inq_pkg.source_of_history(pps.SOURCE_OF_HISTORY_EMR_FLAG,pps.SOURCE_OF_HISTORY_PATIENT_FLAG,pps.SOURCE_OF_HISTORY_FAMILY_FLAG) source_of_history
      ,pps.weight_in_lb pat_weight_in_lb
      ,pps.hdl_cholesterol_in_mg pat_hdl_cholesterol_in_mg
      ,pps.ldl_cholesterol_in_mg pat_ldl_cholesterol_in_mg
      ,pps.systolic_bp_in_mm pat_systolic_bp_in_mm
      ,pps.diastolic_bp_in_mm pat_diastolic_bp_in_mm
      ,pps.blood_sugar_level_in_mg pat_blood_sugar_level_in_mg
      ,pps.svc_number
      ,pps.followed_rf_therapy_goals_flag
      ,pps.goals_achived_flag
      ,pps.reason_of_not_achiving_goals
      ,p.patient_sn
      ,pol.short_descr PATIENT_ORIENTATION
      ,ml.short_descr pat_marital_status
      ,phy.title physician_title
      ,phy.dr_type physician_dr_type
      ,phy.physician_sn
      ,case
        when phy.middle_name is not null then phy.first_name||' '||phy.middle_name||' '||phy.last_name
        else phy.first_name||' '||phy.last_name
        end pat_primary_physician_name
      ,phy_c.name PAT_PRIMARY_PHYSICIAN_COMPANY
      ,phy_c.company_sn PAT_PHYSICIAN_COMPANY_SN
      ,pp.dr_type provider_dr_type
      ,pp.title provider_title
      ,p.first_name pat_first_name
      ,p.middle_name pat_middle_name
      ,p.last_name pat_last_name
      ,pp.provider_physician_sn
      ,case
        when pp.middle_name is not null then pp.first_name||' '||pp.middle_name||' '||pp.last_name
        else pp.first_name||' '||pp.last_name
        end provider_physician_name
      ,pp_c.name provider_physician_company
      ,pp_c.company_sn provider_company_sn
      ,sl.name svc_location_name
      ,sl.svc_location_sn
      ,sl_a.formatted_addr svc_location_addr
      ,lpad(nvl(substr(p.medicare_hic_num,-5,5),'99999'),10,'x') pat_medicare_hic_num
      ,p.medicare_hic_num pat_medicare_hic_num_full
      ,p.ssn pat_ssn
      ,ic.insurance_company_code
      ,ic.name insurance_company_name
      ,lg.gender_code pat_gender_code
      ,gl.short_descr pat_gender
      ,case
        when p.middle_name is not null then p.first_name||' '||p.middle_name||' '||p.last_name
        else p.first_name||' '||p.last_name
        end pat_name
      ,to_char(p.birth_date,'MM/DD/YY') pat_birth_date
      ,p.contact_phone_num pat_phone
      ,p.email_addr pat_email
      ,nvl(gl.lang_code,'en') gender_lang_code
      ,nvl(psbl.lang_code,'en') billing_lang_code
      ,nvl(pstl.lang_code,'en') service_type_lang_code
from physician phy
    ,patient p
    ,list_gender lg
    ,gender_lang gl
    ,company phy_c
    ,patient_prev_svc pps
    ,list_prev_svc_billing psb
    ,prev_svc_billing_lang psbl    
    ,list_prev_svc_type pst
    ,prev_svc_type_lang pstl    
    ,physician_svc_location psl
    ,svc_location sl
    ,addr sl_a
    ,provider_physician pp
    ,company pp_c
    ,list_patient_orientation po
    ,patient_orientation_lang pol
    ,list_marital_status m
    ,marital_status_lang ml
    ,insurance_company ic
where phy.physician_sn = p.physician_sn
and phy.company_sn = phy_c.company_sn
and phy.physician_sn = psl.physician_sn
and psl.svc_location_sn = sl.svc_location_sn
and sl.addr_sn = sl_a.addr_sn
and p.patient_sn = pps.patient_sn
and p.gender_code = lg.gender_code
and lg.gender_code = gl.gender_code
and psl.physician_svc_location_sn = pps.physician_svc_location_sn
and pps.provider_physician_sn = pp.provider_physician_sn
and pps.prev_svc_billing_code = psb.prev_svc_billing_code
and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
and psb.prev_svc_type_code = pst.prev_svc_type_code
and pst.prev_svc_type_code = pstl.prev_svc_type_code
and pp.company_sn = pp_c.company_sn
and pps.insurance_company_code = ic.insurance_company_code(+)
and pps.patient_orientation_code = po.patient_orientation_code(+)
and po.patient_orientation_code = pol.patient_orientation_code(+)
and pps.marital_status_code = m.marital_status_code(+)
and m.marital_status_code = ml.marital_status_code(+)
;
create or replace view user_login_vw as
select uv.name
      ,uv.user_role_id
      ,uv.company_name
      ,to_char((ul.z_create_tmstmp - 5/24),'DD-MON-YYYY HH12:MI:SS AM') login_time
      ,ul.z_create_tmstmp - 5/24 login_datetime
      ,ul.package_name
      ,ul.procedure_name      
from user_vw uv
    ,user_login ul
where uv.user_role_id = ul.user_role_id
;
create or replace view interview_time_vw as
select patient_prev_svc_sn
      ,provider_physician_name
      ,pat_name
      ,svc_perform_date
      ,old_system_flag
      ,common_inq_pkg.awv_interview_time(patient_prev_svc_sn) interview_time
      ,svc_location_name
from pps_simplified_vw 
where svc_type_code = 'AWV' 
and completed_flag = 'Y'
;
create or replace view rf_missing_goals_reason_vw as
select rfmgr.rf_missing_goals_reason_code
      ,rfmgr.missing_goals_reason_code
      ,mgrl.short_descr missing_goals_reason_descr
      ,mgrl.rpt_descr missing_goals_reason_rpt_descr
      ,rf.risk_factor_code
      ,rfl.short_descr risk_factor_descr
      ,mgrl.lang_code  mgr_lang_code
      ,rfl.lang_code rf_lang_code
from rf_missing_goals_reason rfmgr
    ,list_missing_goals_reason mgr
    ,missing_goals_reason_lang mgrl
    ,list_risk_factor rf
    ,risk_factor_lang rfl
where rfmgr.missing_goals_reason_code = mgr.missing_goals_reason_code
and mgr.missing_goals_reason_code = mgrl.missing_goals_reason_code
and rfmgr.risk_factor_code = rf.risk_factor_code
and rf.risk_factor_code = rfl.risk_factor_code
and rfmgr.active_flag = 'Y'
and mgr.active_flag = 'Y'
and mgrl.active_flag = 'Y'
and rf.active_flag = 'Y'
and rfl.active_flag = 'Y'
;

