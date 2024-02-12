CREATE OR REPLACE PACKAGE menu_pkg IS
  v_pkg_name    varchar2 (30) := upper('menu_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  PROCEDURE menu_info  (p_locale in varchar2
                       ,p_user_name in "AspNetUsers"."UserName"%type
                       --,p_client_app_flag in varchar2
                       ,p_out OUT clob);
END menu_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY menu_pkg IS
  PROCEDURE menu_info  (p_locale in varchar2
                       ,p_user_name in "AspNetUsers"."UserName"%type
                       --,p_client_app_flag in varchar2
                       ,p_out OUT clob)
  as
    --This method will return common json of all the list tables
    --
    obj json;
    obj2 json;
    obj3 json;
    obj4 json;
    obj5 json;
    obj6 json;
    l_obj json_list;
    l_obj2 json_list;
    l_obj3 json_list;
    l_obj4 json_list;
    l_obj5 json_list;
    --
    v_role_id "AspNetRoles"."Id"%type;
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    --p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --====================================================user_navigation
    l_obj := json_list(); --an empty list obj
    for i in (select pt.priviledge_type_code
                    ,ptl.short_descr priviledge_type
              from list_priviledge_type pt
                  ,priviledge_type_lang ptl
              where pt.priviledge_type_code = ptl.priviledge_type_code
              and ptl.lang_code = v_lang_code
              --
              and pt.active_flag = 'Y'
              and ptl.active_flag = 'Y'
              order by pt.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAVIGATION_CATEGORY',i.priviledge_type);
      --============================priviledge
      l_obj2 := json_list(); --an empty list obj
      for j in (select pl.short_descr priviledge_name
                      ,pl.priviledge_code
                      ,r."Name" ui_role_name
                      ,'/'||p.href href
                from roles_priviledge rp
                    ,"AspNetRoles" r
                    ,"AspNetUserRoles" ur
                    ,"AspNetUsers" u
                    ,list_priviledge p
                    ,priviledge_lang pl
                    ,list_priviledge_type pt
                    ,priviledge_type_lang ptl
                where ur."UserId" = u."Id"
                and ur."RoleId" = r."Id"
                and r."Id" = rp.role_id
                and rp.priviledge_code = p.priviledge_code
                and p.priviledge_code = pl.priviledge_code
                and pl.lang_code = v_lang_code
                and p.priviledge_type_code = pt.priviledge_type_code
                and pt.priviledge_type_code = ptl.priviledge_type_code
                and ptl.lang_code = v_lang_code
                --
                and u.active_flag = 'Y'
                and ur.active_flag = 'Y'
                and r.active_flag = 'Y'
                and p.active_flag = 'Y'
                and pl.active_flag = 'Y'
                and pt.active_flag = 'Y'
                and ptl.active_flag = 'Y'
                and rp.active_flag = 'Y'
                and upper(u."UserName") = upper(p_user_name)
                and pt.priviledge_type_code = i.priviledge_type_code
                --and ((p_client_app_flag = 'Y' and (p.client_only_priviledge_flag = 'Y' or p.common_priviledge_flag = 'Y')) or (p_client_app_flag = 'N' and p.client_only_priviledge_flag = 'N'))
                )
      loop
        obj3 := json(); --an empty structure
        obj3.put('LINK_CODE',j.priviledge_code);
        obj3.put('LINK_NAME',j.priviledge_name);
        obj3.put('NAVIGATION_HREF',j.href);
        obj3.put('LINK_ROLE_NAME',j.ui_role_name);
        --============================priviledge_ui
        l_obj3 := json_list(); --an empty list obj
        for l in (select uil.ui_code
                        ,uil.short_descr ui_name
                        ,'/'||ui.href href
                  from priviledge_ui pui
                      ,list_ui ui
                      ,ui_lang uil
                      ,list_priviledge p
                      ,priviledge_lang pl
                  where pui.ui_code = ui.ui_code 
                  and ui.ui_code = uil.ui_code
                  and uil.lang_code = v_lang_code
                  and pui.priviledge_code = p.priviledge_code
                  and p.priviledge_code = pl.priviledge_code
                  and pl.lang_code = v_lang_code
                  --
                  and pui.active_flag = 'Y'
                  and ui.active_flag = 'Y'
                  and uil.active_flag = 'Y'
                  and p.active_flag = 'Y'
                  and pl.active_flag = 'Y'
                  and p.priviledge_code = j.priviledge_code
                  order by pui.order_num
                  )
        loop
          obj4 := json(); --an empty structure
          obj4.put('LINK_CODE',l.UI_CODE);
          obj4.put('LINK_NAME',l.UI_NAME);
          obj4.put('LINK_ROLE_NAME',j.ui_role_name);
          obj4.put('NAVIGATION_HREF',l.href);
          --====================================================================================lookup items for each menu pages BEGIN
          if l.UI_CODE = 'BENE' then --beneficiary record
            --==============================gender
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.gender_code code
                            ,gl.short_descr name
                      from list_gender g
                          ,gender_lang gl
                      where g.gender_code = gl.gender_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('gender', l_obj4);
            end if;
            --==============================race
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.race_code code
                            ,gl.short_descr name
                      from list_race g
                          ,race_lang gl
                      where g.race_code = gl.race_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('race', l_obj4);
            end if;
            --==============================ethnicity
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.ethnicity_code code
                            ,gl.short_descr name
                      from list_ethnicity g
                          ,ethnicity_lang gl
                      where g.ethnicity_code = gl.ethnicity_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('ethnicity', l_obj4);
            end if;
            --==============================marital_status
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.marital_status_code code
                            ,gl.short_descr name
                      from list_marital_status g
                          ,marital_status_lang gl
                      where g.marital_status_code = gl.marital_status_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('marital_status', l_obj4);
            end if;
            --==============================medication frequency
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.frequency_unit_code code
                            ,gl.short_descr name
                      from list_frequency_unit g
                          ,frequency_unit_lang gl
                      where g.frequency_unit_code = gl.frequency_unit_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('medication_frequency', l_obj4);
            end if;
            --==============================medication_unit
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.medication_unit_code code
                            ,gl.short_descr name
                      from list_medication_unit g
                          ,medication_unit_lang gl
                      where g.medication_unit_code = gl.medication_unit_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('medication_unit', l_obj4);
            end if;
          elsif l.UI_CODE = 'PHYC' then --physician company
            null;
          elsif l.UI_CODE = 'PPHY' then --primary physician record
            --==============================physician_type
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.physician_type_code code
                            ,gl.short_descr name
                      from list_physician_type g
                          ,physician_type_lang gl
                      where g.physician_type_code = gl.physician_type_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('physician_type', l_obj4);
            end if;
            --==============================title
            l_obj4 := json_list(); --an empty list obj
            for m in (select 'Mr.' code,'Mr.' name from dual union
                      select 'Ms.' code,'Ms.' name from dual union
                      select 'Dr.' code,'Dr.' name from dual
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('title', l_obj4);
            end if;
          elsif l.UI_CODE = 'PSVL' then --Physician Service Location Record
            null;
          elsif l.UI_CODE = 'SVCL' then --Service Location Record
            --==============================svc_location_type
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.svc_location_type_code code
                            ,gl.short_descr name
                      from list_svc_location_type g
                          ,svc_location_type_lang gl
                      where g.svc_location_type_code = gl.svc_location_type_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('svc_location_type', l_obj4);
            end if;          
          elsif l.UI_CODE = 'SPHY' then --Service Provider Physician Record
            --==============================physician_type
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.physician_type_code code
                            ,gl.short_descr name
                      from list_physician_type g
                          ,physician_type_lang gl
                      where g.physician_type_code = gl.physician_type_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('physician_type', l_obj4);
            end if;          
            --==============================title
            l_obj4 := json_list(); --an empty list obj
            for m in (select 'Mr.' code,'Mr.' name from dual union
                      select 'Ms.' code,'Ms.' name from dual
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('title', l_obj4);
            end if;
          elsif l.UI_CODE = 'PSVC' then --Service --------------Beneficiary Preventive Service (Questionnaire)
            --==============================gender
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.gender_code code
                            ,gl.short_descr name
                      from list_gender g
                          ,gender_lang gl
                      where g.gender_code = gl.gender_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('gender', l_obj4);
            end if;
            --==============================race
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.race_code code
                            ,gl.short_descr name
                      from list_race g
                          ,race_lang gl
                      where g.race_code = gl.race_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('race', l_obj4);
            end if;
            --==============================ethnicity
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.ethnicity_code code
                            ,gl.short_descr name
                      from list_ethnicity g
                          ,ethnicity_lang gl
                      where g.ethnicity_code = gl.ethnicity_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('ethnicity', l_obj4);
            end if;
            --==============================living_status
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.living_status_code code
                            ,gl.short_descr name
                      from list_living_status g
                          ,living_status_lang gl
                      where g.living_status_code = gl.living_status_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('living_status', l_obj4);
            end if;
            --==============================financial_status
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.financial_status_code code
                            ,gl.short_descr name
                      from list_financial_status g
                          ,financial_status_lang gl
                      where g.financial_status_code = gl.financial_status_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('financial_status', l_obj4);
            end if;
            --==============================education_level
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.education_level_code code
                            ,gl.short_descr name
                      from list_education_level g
                          ,education_level_lang gl
                      where g.education_level_code = gl.education_level_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('education_level', l_obj4);
            end if;
            --==============================marital_status
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.marital_status_code code
                            ,gl.short_descr name
                      from list_marital_status g
                          ,marital_status_lang gl
                      where g.marital_status_code = gl.marital_status_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('marital_status', l_obj4);
            end if;
            --==============================working_status
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.working_status_code code
                            ,gl.short_descr name
                      from list_working_status g
                          ,working_status_lang gl
                      where g.working_status_code = gl.working_status_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('working_status', l_obj4);
            end if;
            --==============================income
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.income_code code
                            ,gl.short_descr name
                      from list_income g
                          ,income_lang gl
                      where g.income_code = gl.income_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('income', l_obj4);
            end if;
            --==============================medication frequency
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.frequency_unit_code code
                            ,gl.short_descr name
                      from list_frequency_unit g
                          ,frequency_unit_lang gl
                      where g.frequency_unit_code = gl.frequency_unit_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('medication_frequency', l_obj4);
            end if;
            --==============================medication_unit
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.medication_unit_code code
                            ,gl.short_descr name
                      from list_medication_unit g
                          ,medication_unit_lang gl
                      where g.medication_unit_code = gl.medication_unit_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('medication_unit', l_obj4);
            end if;
            --==============================patient_orientation
            l_obj4 := json_list(); --an empty list obj
            for m in (select pol.patient_orientation_code code
                            ,case
                              when pol.long_descr is null then pol.short_descr
                              else pol.short_descr||' - '||pol.long_descr 
                              end name
                      from list_patient_orientation po
                          ,patient_orientation_lang pol
                      where po.patient_orientation_code = pol.patient_orientation_code
                      and pol.lang_code = 'en'
                      and po.active_flag = 'Y'
                      and pol.active_flag = 'Y'
                      order by po.order_num
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('patient_orientation', l_obj4);
            end if;
          elsif l.UI_CODE = 'RBEN' then --Beneficiary Report
            --==============================prev_svc_billing
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.prev_svc_billing_code code
                            ,g.prev_svc_type_code||'-'||g.prev_svc_billing_code||'('||gl.short_descr||')' name
                      from list_prev_svc_billing g
                          ,prev_svc_billing_lang gl
                      where g.prev_svc_billing_code = gl.prev_svc_billing_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      order by g.prev_svc_type_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('service_code', l_obj4);
            end if;          
          elsif l.UI_CODE = 'RMGM' then --Management Report
            --==============================prev_svc_billing
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.prev_svc_billing_code code
                            ,g.prev_svc_type_code||'-'||g.prev_svc_billing_code||'('||gl.short_descr||')' name
                      from list_prev_svc_billing g
                          ,prev_svc_billing_lang gl
                      where g.prev_svc_billing_code = gl.prev_svc_billing_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      order by g.prev_svc_type_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('service_code', l_obj4);
            end if;          
          elsif l.UI_CODE = 'SCHE' then --Beneficiary Preventive Service Scheduling
            --==============================prev_svc_billing
            l_obj4 := json_list(); --an empty list obj
            for m in (select g.prev_svc_billing_code code
                            ,g.prev_svc_type_code||'-'||g.prev_svc_billing_code||'('||gl.short_descr||')' name
                      from list_prev_svc_billing g
                          ,prev_svc_billing_lang gl
                      where g.prev_svc_billing_code = gl.prev_svc_billing_code
                      and gl.lang_code = v_lang_code
                      --
                      and g.active_flag = 'Y'
                      and gl.active_flag = 'Y'
                      order by g.prev_svc_type_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('service_code', l_obj4);
            end if;
            --======================================================HR
            l_obj4 := json_list(); --an empty list obj
            for m in (select hr_code code
                            ,hr_code name
                      from list_hr
                      order by hr_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append obj2 to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('svc_hr', l_obj4);
            end if;
            --======================================================MIN
            l_obj4 := json_list(); --an empty list obj
            for m in (select min_code code
                            ,min_code name
                      from list_min
                      order by min_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append obj2 to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('svc_min', l_obj4);
            end if;
            --======================================================AM_PM
            l_obj4 := json_list(); --an empty list obj
            for m in (select am_pm_code code
                            ,am_pm_code name
                      from list_am_pm
                      order by am_pm_code
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --Append obj2 to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('svc_am_pm', l_obj4);
            end if;
          elsif l.UI_CODE = 'RAMT' then --New User Role Assignment
            --==============================Roles
            l_obj4 := json_list(); --an empty list obj
            for m in (select r."Id" code
                            ,r."Name" name
                      from "AspNetRoles" r
                      where r."Id" not in ('a74f52c5-4d3a-46d9-bc22-a5eafa982849','96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
                      and r.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --==========================role_priviledge
              l_obj5 := json_list(); --an empty list obj
              for n in (select p.priviledge_code code
                              ,pl.short_descr||'('||ptl.short_descr||')' name
                        from roles_priviledge rp
                            ,list_priviledge p
                            ,priviledge_lang pl
                            ,list_priviledge_type pt
                            ,priviledge_type_lang ptl
                        where rp.priviledge_code = p.priviledge_code
                        and p.priviledge_code = pl.priviledge_code
                        and pl.lang_code = v_lang_code
                        and p.priviledge_type_code = pt.priviledge_type_code
                        and pt.priviledge_type_code = ptl.priviledge_type_code
                        and ptl.lang_code = v_lang_code
                        and rp.role_id = m.code
                        --
                        and rp.active_flag = 'Y'
                        and p.active_flag = 'Y'
                        and pl.active_flag = 'Y'
                        and pt.active_flag = 'Y'
                        and ptl.active_flag = 'Y'
                        )
              loop
                obj6 := json(); --an empty structure
                obj6.put('CODE',n.code);
                obj6.put('NAME',n.name);
                --Append the object to the list
                l_obj5.append(obj6.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj5) > 0 then
                obj5.put('role_priviledge', l_obj5);
              end if;
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('role', l_obj4);
            end if;
          elsif l.UI_CODE = 'UMGM' then --Existing User Role/Inactivation Management
            --==============================Roles
            l_obj4 := json_list(); --an empty list obj
            for m in (select r."Id" code
                            ,r."Name" name
                      from "AspNetRoles" r
                      where r."Id" not in ('a74f52c5-4d3a-46d9-bc22-a5eafa982849','96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
                      and r.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --==========================role_priviledge
              l_obj5 := json_list(); --an empty list obj
              for n in (select p.priviledge_code code
                              ,pl.short_descr||'('||ptl.short_descr||')' name
                        from roles_priviledge rp
                            ,list_priviledge p
                            ,priviledge_lang pl
                            ,list_priviledge_type pt
                            ,priviledge_type_lang ptl
                        where rp.priviledge_code = p.priviledge_code
                        and p.priviledge_code = pl.priviledge_code
                        and pl.lang_code = v_lang_code
                        and p.priviledge_type_code = pt.priviledge_type_code
                        and pt.priviledge_type_code = ptl.priviledge_type_code
                        and ptl.lang_code = v_lang_code
                        and rp.role_id = m.code
                        --
                        and rp.active_flag = 'Y'
                        and p.active_flag = 'Y'
                        and pl.active_flag = 'Y'
                        and pt.active_flag = 'Y'
                        and ptl.active_flag = 'Y'
                        )
              loop
                obj6 := json(); --an empty structure
                obj6.put('CODE',n.code);
                obj6.put('NAME',n.name);
                --Append the object to the list
                l_obj5.append(obj6.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj5) > 0 then
                obj5.put('role_priviledge', l_obj5);
              end if;
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);            
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('role', l_obj4);
            end if;
          elsif l.UI_CODE = 'PMGM' then --Roles Priviledge Management
            --==============================priviledge
            l_obj4 := json_list(); --an empty list obj
            for m in (select p.priviledge_code code
                            ,pl.short_descr name
                      from list_priviledge p
                          ,priviledge_lang pl
                          ,list_priviledge_type pt
                          ,priviledge_type_lang ptl
                      where p.priviledge_code = pl.priviledge_code
                      and pl.lang_code = v_lang_code
                      and p.priviledge_type_code = pt.priviledge_type_code
                      and pt.priviledge_type_code = ptl.priviledge_type_code
                      and ptl.lang_code = v_lang_code
                      and p.priviledge_code not in ('UMGM','PUSR')
                      --
                      and p.active_flag = 'Y'
                      and pl.active_flag = 'Y'
                      and pt.active_flag = 'Y'
                      and ptl.active_flag = 'Y'
                      )
            loop
              obj5 := json(); --an empty structure
              obj5.put('CODE',m.code);
              obj5.put('NAME',m.name);
              --==========================priviledge_ui
              l_obj5 := json_list(); --an empty list obj
              for n in (select pui.ui_code code
                              ,uil.short_descr name
                        from priviledge_ui pui
                            ,list_priviledge p
                            ,priviledge_lang pl
                            ,list_priviledge_type pt
                            ,priviledge_type_lang ptl
                            ,list_ui ui
                            ,ui_lang uil
                        where pui.priviledge_code = p.priviledge_code
                        and p.priviledge_code = pl.priviledge_code
                        and pl.lang_code = v_lang_code
                        and p.priviledge_type_code = pt.priviledge_type_code
                        and pt.priviledge_type_code = ptl.priviledge_type_code
                        and ptl.lang_code = v_lang_code
                        and pui.ui_code = ui.ui_code
                        and ui.ui_code = uil.ui_code
                        and uil.lang_code = v_lang_code
                        and pui.priviledge_code = m.code
                        --
                        and pui.active_flag = 'Y'
                        and p.active_flag = 'Y'
                        and pl.active_flag = 'Y'
                        and pt.active_flag = 'Y'
                        and ptl.active_flag = 'Y'
                        and ui.active_flag = 'Y'
                        and uil.active_flag = 'Y'
                        )
              loop
                obj6 := json(); --an empty structure
                obj6.put('CODE',n.code);
                obj6.put('NAME',n.name);
                --Append the object to the list
                l_obj5.append(obj6.to_json_value);
              end loop;
              --
              if json_ac.array_count(l_obj5) > 0 then
                obj5.put('priviledge_navigation', l_obj5);
              end if;
              --Append the object to the list
              l_obj4.append(obj5.to_json_value);
            end loop;
            --
            if json_ac.array_count(l_obj4) > 0 then
              obj4.put('priviledge', l_obj4);
            end if;
          end if;
          --====================================================================================lookup items for each menu pages END
          --Append the object to the list
          l_obj3.append(obj4.to_json_value);
        end loop;
        --
        if json_ac.array_count(l_obj3) > 0 then
          obj3.put('navigation_link', l_obj3);
        end if;          
        --Append the object to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('navigation_list', l_obj2);
      end if;
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('user_navigation', l_obj);
    end if;
    --====================================================user_info
    for i in (select role_name
                    ,user_name
                    ,email
                    ,phone
                    ,service_provider_flag
                    ,name
                    ,case
                      when role_id = '79F450777D2E4B6AB98FECB17974FDEB' then 'Y'
                      else 'N'
                      end can_perform_service_flag
                    ,case
                      when trim(name) is null then user_name
                      else name||' ('||user_name||')'
                      end display_name
              from user_vw 
              where status = 'Active'
              and user_name = lower(p_user_name)
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('NAME',i.name);
      obj2.put('DISPLAY_NAME',i.display_name);
      obj2.put('ROLE_NAME',i.role_name);
      obj2.put('USER_NAME',i.user_name);
      obj2.put('EMAIL',i.email);
      obj2.put('PHONE',i.phone);
      obj2.put('SERVICE_PROVIDER_FLAG',i.service_provider_flag);
      obj2.put('CAN_PERFORM_SERVICE_FLAG',i.can_perform_service_flag);
      --
      obj.put('user_info', obj2);
    end loop;
    --==========================output
    p_out := obj.to_char;
  end menu_info;
END menu_pkg;
/
SHOW ERRORS;