create or replace PACKAGE menu_pkg IS
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
show errors
create or replace PACKAGE BODY menu_pkg IS
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
    v_proc_name := upper('menu_info');
    common_dml_pkg.ins_user_login(common_inq_pkg.user_role_id(p_user_name),v_pkg_name,v_proc_name,null,null,null,null,null);
    --
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
                      when role_id = 'a74f52c5-4d3a-46d9-bc22-a5eafa982849' then 'Your account is in pending review. You will be notified once the review is complete and a specific role is assigned.'
                      when role_id = '624B26BD08D20FECE0530100007F5ACE' then 'Your account has been inactivated. For any further inquiry, please contact our support center.'
                      else null
                      end prospective_user_msg
--                    ,case
--                      when role_id = '79F450777D2E4B6AB98FECB17974FDEB' then 'Y'
--                      else 'N'
--                      end can_perform_service_flag
--10/13/2017-mh This flag was designed only for Service provider but service provider having Admin roles also can perform service. 
--common_inq_pkg.patient_with_pend_svc have the logic to control this functionality.
                    ,'Y' can_perform_service_flag
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
      obj2.put('PROSPECTIVE_USER_MSG',i.prospective_user_msg);
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
show errors