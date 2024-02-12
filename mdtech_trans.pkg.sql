create or replace PACKAGE mdtech_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('mdtech_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_status      varchar2(20);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  v_empty_signature clob := 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWgAAAEECAYAAAAF0670AAAIq0lEQVR4Xu3UQQ0AAAwCseHf9Gzco1NAysLOESBAgEBSYMlUQhEgQIDAGWhPQIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQe8E8BBStqm2gAAAAASUVORK5CYII=';
  v_em_empty_signature clob := 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWgAAACgCAYAAAAhKfa4AAAFX0lEQVR4Xu3UQQ0AAAwCseHf9Gzco1NAysLOESBAgEBSYMlUQhEgQIDAGWhPQIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEDDQfoAAAQJRAQMdLUYsAgQIGGg/QIAAgaiAgY4WIxYBAgQMtB8gQIBAVMBAR4sRiwABAgbaDxAgQCAqYKCjxYhFgAABA+0HCBAgEBUw0NFixCJAgICB9gMECBCIChjoaDFiESBAwED7AQIECEQFDHS0GLEIECBgoP0AAQIEogIGOlqMWAQIEHjJsgChzQVwQgAAAABJRU5ErkJggg==';
  --
  procedure create_company(p_company_json in varchar2,p_addr_json in varchar2,p_out out varchar2);
  procedure update_company_demo(p_company_sn in number,p_company_json in varchar2,p_out out varchar2);
  procedure update_company_addr(p_company_sn in number,p_addr_json in varchar2,p_user in varchar2,p_out out varchar2);
  procedure create_provider_physician(p_provider_physician_json in varchar2,p_out out varchar2);
  procedure update_provider_physician(p_provider_physician_sn in number,p_json in varchar2,p_out out varchar2);
  procedure xfer_specific_svc(p_patient_prev_svc_sn in number,p_provider_physician_sn_from in varchar2,p_provider_physician_sn_to in varchar2,p_user in varchar2,p_out out varchar2);
  procedure xfer_all_svc(p_provider_physician_sn_from in varchar2,p_provider_physician_sn_to in varchar2,p_user in varchar2,p_out out varchar2);
  procedure delete_provider_physician(p_provider_physician_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_physician(p_physician_json in varchar2,p_out out varchar2);
  procedure update_physician(p_physician_sn in number,p_physician_json in varchar2,p_out out varchar2);
  procedure delete_physician(p_physician_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_svc_location(p_svc_location_json in varchar2,p_addr_json in varchar2,p_out out varchar2);
  procedure update_svc_location(p_svc_location_sn in number,p_svc_location_json in varchar2,p_addr_json in varchar2,p_out out varchar2);
  procedure delete_svc_location(p_svc_location_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_physician_svc_location(p_physician_svc_location_json in varchar2,p_out out varchar2);
  procedure create_user_svc_location(p_user_svc_location_json in varchar2,p_out out varchar2);
  procedure delete_user_svc_location(p_user_svc_location_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_user_company(p_json in varchar2,p_out out varchar2);
  procedure delete_user_company(p_user_company_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_user_physician(p_json in varchar2,p_out out varchar2);
  procedure delete_user_physician(p_user_physician_sn in number,p_user in varchar2,p_out out varchar2);
  procedure delete_physician_svc_location(p_physician_svc_location_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_patient(p_patient_json in varchar2,p_addr_json in varchar2,p_out out varchar2);
  procedure patient_edit_demo(p_patient_sn in number,p_demo_json in varchar2,p_out out varchar2);
  procedure patient_edit_addr(p_patient_sn in number,p_addr_json in varchar2,p_user in varchar2,p_out out varchar2);
  procedure patient_edit_physician(p_patient_sn in number,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_user in varchar2,p_out out varchar2);
  procedure patient_edit_rpt_reprocess(p_patient_prev_svc_sn in number,p_user in varchar2,p_out out varchar2);
  procedure patient_edit_temp_reprocess(p_patient_prev_svc_sn in number,p_user in varchar2,p_out out varchar2);
  procedure create_patient_signature(p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_signature in clob,p_out out varchar2);
  procedure create_em_sched_after_awv(p_em_sched_json in varchar2,p_out out varchar2);
  procedure create_patient_medication(p_patient_medication_json in varchar2,p_out out varchar2);
  procedure update_patient_medication(p_patient_medication_json in varchar2,p_patient_medication_sn in number,p_out out varchar2);
  procedure create_patient_prev_svc(p_patient_prev_svc_json in varchar2,p_out out varchar2);
  procedure create_patient_prev_svc_remark(p_patient_prev_svc_remark_json in varchar2,p_out out varchar2);
  procedure update_patient_prev_svc_remark(p_patient_prev_svc_remark_json in varchar2,p_patient_prev_svc_remark_sn in number,p_out out varchar2);
  procedure update_patient_prev_svc_demo(p_patient_prev_svc_demo_json in varchar2,p_email_addr in patient.email_addr%type,p_any_concern_txt in patient_response.response_data%type,p_out out varchar2);
  procedure manage_patient_history(p_json in varchar2,p_patient_sn in number,p_question_categ_code in varchar2,p_user in varchar2,p_out out varchar2);
  procedure create_patient_response(p_patient_response_json in varchar2,p_question_categ_code in list_question_categ.question_categ_code%type,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out out clob);
  procedure create_physician_em(p_physician_em_json in varchar2,p_patient_signature in clob,p_physician_signature in clob,p_out out varchar2);
  procedure create_provider_ccm(p_provider_ccm_json in varchar2,p_out out varchar2);
  procedure create_contact_us(p_contact_us_json in varchar2,p_out out varchar2);
  --
  procedure new_user_approval (p_user_json in varchar2,p_addr_json in varchar2, p_out out varchar2);
  procedure update_user (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_role_id in "AspNetRoles"."Id"%type,p_inactivate_user_flag in "AspNetUserRoles".active_flag%type, p_out out varchar2);
  procedure update_user_demo(p_user_email in varchar2,p_first_name in varchar2,p_middle_name in varchar2,p_last_name in varchar2,p_phone in varchar2,p_out out varchar2);
  procedure update_user_addr(p_user_email in varchar2,p_addr_json in varchar2,p_out out varchar2);
  procedure update_user_role(p_user_email in varchar2,p_role_id in varchar2,p_out out varchar2);
  procedure update_user_prov_status(p_user_email in varchar2,p_user_is_a_provider_flag in varchar2,p_out out varchar2);
  procedure update_user_status(p_user_email in varchar2,p_status_flag in varchar2,p_out out varchar2);
  --
  procedure manage_role_priviledge (p_role_id in "AspNetRoles"."Id"%type,p_priviledge_code in roles_priviledge.priviledge_code%type, p_priviledge_remove_flag in varchar2,p_out out varchar2);
  --
  procedure prev_svc_validity_old (p_patient_sn in patient_prev_svc.patient_sn%type,p_prev_svc_billing_code in patient_prev_svc.prev_svc_billing_code%type,p_svc_date in patient_prev_svc.svc_date%type,p_valid_svc out boolean,p_parent_patient_prev_svc_sn out patient_prev_svc.parent_patient_prev_svc_sn%type,p_msg out varchar2);
  procedure prev_svc_validity (p_patient_sn in patient_prev_svc.patient_sn%type,p_prev_svc_billing_code in patient_prev_svc.prev_svc_billing_code%type,p_svc_date in patient_prev_svc.svc_date%type,p_valid_svc out boolean,p_parent_patient_prev_svc_sn out patient_prev_svc.parent_patient_prev_svc_sn%type,p_msg out varchar2);
  --
  procedure svc_result_rpt_iu (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in varchar2,p_rpt_json_clob in clob);
  procedure esv_rpt_json_clob (p_patient_prev_svc_sn in number);
  procedure eev_rpt_json_clob (p_patient_prev_svc_sn in number);
  procedure csv_rpt_json_clob (p_patient_prev_svc_sn in number);
  procedure cev_rpt_json_clob (p_patient_prev_svc_sn in number);
  procedure awv_rpt_json_clob (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type);
  function checkbox_only_category_flag (p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2;
  function empty_json_flag (p_json in varchar2) return varchar2;
  function obes_appt_svc_date(p_svc_date in date,p_freq_number in number) return date;
END mdtech_trans_pkg;
/
show errors
create or replace PACKAGE BODY mdtech_trans_pkg IS
  procedure new_user_approval (p_user_json in varchar2,p_addr_json in varchar2, p_out out varchar2)
  is
    obj json := json();
    v_user_rec      "AspNetUsers"%rowtype;
    v_userrole_rec  "AspNetUserRoles"%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
  begin
    v_proc_name := upper('new_user_approval');
    v_input_str := 'p_user_json: '||p_user_json||'-p_addr_json: '||p_addr_json;
    --Parse company record
    parse_json_pkg.user_parsing(p_user_json,v_user_rec,v_userrole_rec);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_user_rec.addr_sn);
    --Required field validation
    if v_user_rec.addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Address data is required.';
    elsif v_userrole_rec.user_role_id is null then
      v_status := 'FAILED';
      v_msg := 'User Selection is required.';
    elsif v_userrole_rec."RoleId" is null then
      v_status := 'FAILED';
      v_msg := 'Role Selection is required.';
    elsif v_user_rec.company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Company Selection is required.';
    elsif v_user_rec.first_name is null then
      v_status := 'FAILED';
      v_msg := 'First Name is required.';
    elsif v_user_rec.last_name is null then
      v_status := 'FAILED';
      v_msg := 'Last Name is required.';
    elsif v_user_rec."PhoneNumber" is null then
      v_status := 'FAILED';
      v_msg := 'Phone is required.';
    elsif v_user_rec.SVC_PROVIDER_FLAG is null then
      v_status := 'FAILED';
      v_msg := 'User is a Service Provider Selection is required.';
    else
      --Approve user by changing the role from prospective user role to assigned role in "AspNetUserRoles" and updating demographic info in "AspNetUsers"
      update "AspNetUserRoles"
      set "RoleId" = v_userrole_rec."RoleId"
          ,active_flag = 'Y'
      where user_role_id = v_userrole_rec.user_role_id
      ;
      update "AspNetUsers"
      set "PhoneNumber" =  v_user_rec."PhoneNumber"
         ,FIRST_NAME = v_user_rec.first_name
         ,LAST_NAME = v_user_rec.LAST_NAME
         ,MIDDLE_NAME = v_user_rec.MIDDLE_NAME
         ,COMPANY_SN = v_user_rec.COMPANY_SN
         ,addr_sn = v_user_rec.addr_sn
         ,SVC_PROVIDER_FLAG = v_user_rec.SVC_PROVIDER_FLAG
      where "Id" = (select user_id from active_user_vw where user_role_id = v_userrole_rec.USER_ROLE_ID)
      ;
      commit;
      --
      v_status := 'SUCCESSFUL';
      v_msg := 'User has been approved successfully';
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
  end new_user_approval;
  --
  function obes_appt_svc_date(p_svc_date in date,p_freq_number in number) return date
  is
  begin
    if p_freq_number = 1 then return common_pkg.working_date(p_svc_date);
    elsif p_freq_number between 2 and 5 then return common_pkg.working_date(p_svc_date + 7);
    elsif p_freq_number between 6 and 15 then return common_pkg.working_date(p_svc_date + 14);
    elsif p_freq_number between 16 and 21 then return common_pkg.working_date(add_months(p_svc_date,1));
    elsif p_freq_number = 22 then return common_pkg.working_date(p_svc_date + 7);
    end if;
  end obes_appt_svc_date;
  --
  function empty_json_flag (p_json in varchar2) return varchar2
  is
    v_cnt pls_integer;
  begin
    --This json {"1001":null,"1002":999999,"1003":null,"1004":null} will count 0 but {"1003":"105803","1005":"105805"} will count 2
    select count(distinct question_response_code)    
    into v_cnt
    from table(parse_json_pkg.patient_response(p_json))
    ;
    --{} is empty json and will count 0 for json_ac.object_count(json(p_json))
    if json_ac.object_count(json(p_json)) = 0 or v_cnt = 0 then return 'Y';
    else return 'N';
    end if;
  end empty_json_flag;
  --
  function checkbox_only_category_flag (p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2
  is
    v_cnt pls_integer;
  begin
    select count(distinct response_code)
    into v_cnt
    from question_response_vw
    where billing_code = 'G0438'
    and category_code = p_question_categ_code
    ;
    if v_cnt = 1 then return 'Y';
    else return 'N';
    end if;
  end checkbox_only_category_flag;
  --ESV report JSON Clob is the json data used for E/M Service. This data will be generated during E/M service scheduling.
  procedure svc_result_rpt_iu (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in varchar2,p_rpt_json_clob in clob)
  is
  begin
    begin
      insert into svc_result_rpt(SVC_RESULT_RPT_SN,PATIENT_PREV_SVC_SN,SVC_RPT_TYPE_CODE,RPT_JSON_CLOB)
      values (SVC_RESULT_RPT_SNG.nextval,p_patient_prev_svc_sn,p_svc_rpt_type_code,p_rpt_json_clob);
    exception
      when dup_val_on_index then
        update svc_result_rpt
        set RPT_JSON_CLOB = p_rpt_json_clob
        where PATIENT_PREV_SVC_SN = p_patient_prev_svc_sn
        and SVC_RPT_TYPE_CODE = p_svc_rpt_type_code
        ;
    end;
  end svc_result_rpt_iu;
  --
  procedure esv_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an E/M service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('99202','99212')
    ;
    if v_cnt > 0 then --E/M Service
      common_inq_pkg.patient_em_template_data_init('en-US',p_patient_prev_svc_sn,v_out);
      svc_result_rpt_iu (p_patient_prev_svc_sn,'ESV',v_out);
      commit;
    end if;
  end esv_rpt_json_clob;
  --
  procedure eev_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an E/M service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('99202','99212')
    ;
    if v_cnt > 0 then --E/M Service    
      report_pkg.em_output_rpt_init('en-US',p_patient_prev_svc_sn,v_out);
      svc_result_rpt_iu (p_patient_prev_svc_sn,'EEV',v_out);
      commit;
    end if;
  end eev_rpt_json_clob;
  --
  procedure csv_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an CCM service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('99487','99490')
    ;
    if v_cnt > 0 then --CCM Service
      common_inq_pkg.patient_ccm_template_data_init('en-US',p_patient_prev_svc_sn,v_out);
      svc_result_rpt_iu (p_patient_prev_svc_sn,'CSV',v_out);
      commit;
    end if;
  end csv_rpt_json_clob;
  --
  procedure cev_rpt_json_clob (p_patient_prev_svc_sn in number)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an CCM service
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('99487','99490')
    ;
    if v_cnt > 0 then --CCM Service
      report_pkg.svc_rpt_init('en-US',p_patient_prev_svc_sn,'CEV',v_out);
      svc_result_rpt_iu (p_patient_prev_svc_sn,'CEV',v_out);
      commit;
    end if;
  end cev_rpt_json_clob;
  --
  procedure awv_rpt_json_clob (p_patient_prev_svc_sn in number,p_svc_rpt_type_code in list_svc_rpt_type.svc_rpt_type_code%type)
  is
    v_out clob;
    v_cnt pls_integer;
  begin
    --check if the service is an AWV service and complete
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    and prev_svc_billing_code in ('G0438','G0439')
    and svc_comp_flag = 'Y'
    ;
    if v_cnt > 0 then --AWV Service
      for i in (select srtl.svc_rpt_type_code
                from list_svc_rpt_type srt
                    ,svc_rpt_type_lang srtl
                where srt.svc_rpt_type_code = srtl.svc_rpt_type_code
                and srtl.lang_code = 'en'
                and srt.used_for_template_only_flag = 'N'
                and srt.prev_svc_type_code = 'AWV'
                and (p_svc_rpt_type_code is null or srt.svc_rpt_type_code = p_svc_rpt_type_code)
                )
      loop
        if i.svc_rpt_type_code = 'CLI' then
          report_pkg.clinical_rpt_init('en-US',p_patient_prev_svc_sn,v_out);
        elsif i.svc_rpt_type_code = 'HRA' then
          report_pkg.patient_clinical_rpt_init('en-US',p_patient_prev_svc_sn,v_out);
        elsif i.svc_rpt_type_code in ('RMK','HQA') then
          report_pkg.svc_rpt_init('en-US',p_patient_prev_svc_sn,i.svc_rpt_type_code,v_out);
        end if;        
        svc_result_rpt_iu(p_patient_prev_svc_sn,i.svc_rpt_type_code,v_out);
      end loop;
      commit;
    end if;
  end awv_rpt_json_clob;
  --
  --Valid patient under a physician is being selected by the function common_inq_pkg.patient_qualify_for_svc. 
  --This procedure identify any other needed validation and parent_patient_prev_svc_sn
  procedure prev_svc_validity (p_patient_sn in patient_prev_svc.patient_sn%type,p_prev_svc_billing_code in patient_prev_svc.prev_svc_billing_code%type,p_svc_date in patient_prev_svc.svc_date%type,p_valid_svc out boolean,p_parent_patient_prev_svc_sn out patient_prev_svc.parent_patient_prev_svc_sn%type,p_msg out varchar2)
  is
    v_return boolean := true;
    v_return_msg varchar2(300) := null;
    v_parent_patient_prev_svc_sn patient_prev_svc.parent_patient_prev_svc_sn%type;
    --
    v_ccm_cnt pls_integer;
    v_G0447_cnt pls_integer;
  begin
    if p_prev_svc_billing_code in ('99202','99212','99487','99490','G0439','G0447','G0449') then
      --Get the last/latest AWV for the Patient
      select nvl(max(patient_prev_svc_sn),0)
      into v_parent_patient_prev_svc_sn
      from patient_prev_svc
      where patient_sn = p_patient_sn
      and prev_svc_billing_code in ('G0438','G0439')
      and svc_comp_flag = 'Y'
      ;
      if v_parent_patient_prev_svc_sn = 0 then --No AWV service in the system (should never happend, since patient eligibility is already filtered by common_inq_pkg.patient_qualify_for_svc)
        v_return := false;
        v_return_msg := 'Patient first needs to complete AWV (G0438 OR G0439) before scheduling EM or CCM service';
      else --Patient have completed AWV. Now check if the last AWV qualify for CCM
        --99490 or 99487 can be scheduled any time after E/M completion
        if p_prev_svc_billing_code in ('99490','99487') then
          --99487	Complex Chronic Care Mgmt, 60 min/month
          --99490	Chronic Care Mgmt, 20 min/month
          --
          --check the number of CCM service done for requested scheduled service month
          --for 99490 (20 min monthly), max 2 (10/session) is allowed
          --for 99487 (60 min monthly), max 4 (15/session) is allowed
          --
          select count(*)
          into v_ccm_cnt
          from patient_prev_svc
          where patient_sn = p_patient_sn
          and prev_svc_billing_code = p_prev_svc_billing_code
          and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
          and to_char(svc_date,'MMYY') = to_char(p_svc_date,'MMYY')
          ;
          if p_prev_svc_billing_code = '99490' then
            if v_ccm_cnt >= 2 then -- max 2 for that month have reached
              v_return := false;
              v_return_msg := 'Maximum number (2) of 99490 CCM service for the month '||to_char(p_svc_date,'MON,YYYY')||' already been scheduled.';
            end if;
          elsif p_prev_svc_billing_code = '99487' then
            if v_ccm_cnt >= 4 then -- max 4 for that month have reached
              v_return := false;
              v_return_msg := 'Maximum number (4) of 99487 CCM service for the month '||to_char(p_svc_date,'MON,YYYY')||' already been scheduled.';
            end if;
          end if;
        end if;
      end if;
    end if;
    p_valid_svc := v_return;
    p_parent_patient_prev_svc_sn := v_parent_patient_prev_svc_sn;
    p_msg := v_return_msg;
  end prev_svc_validity;
  --
  --G0438/439 are yearly program. CCM(99490) is a monthly program. For a new patient, the program needs to start from 438. 
  --This method will return true for a patient and program if all the respective service date related validity is satisfied.
  --When p_valid_svc is false, respective message regarding invalid service will be put in the p_msg output variable.
  procedure prev_svc_validity_old (p_patient_sn in patient_prev_svc.patient_sn%type,p_prev_svc_billing_code in patient_prev_svc.prev_svc_billing_code%type,p_svc_date in patient_prev_svc.svc_date%type,p_valid_svc out boolean,p_parent_patient_prev_svc_sn out patient_prev_svc.parent_patient_prev_svc_sn%type,p_msg out varchar2)
  is
    v_return boolean := false;
    v_return_msg varchar2(300) := null;
    v_parent_patient_prev_svc_sn patient_prev_svc.parent_patient_prev_svc_sn%type;
    --
    v_billing_code_svc_date   patient_prev_svc.svc_date%type;
    v_G0438_svc_date          patient_prev_svc.svc_date%type;
    v_cnt pls_integer;
    v_99202_cnt pls_integer;
    v_99212_cnt pls_integer;
    v_qualify_for_em_followup_flag varchar2(1);
    v_svc_comp_flag varchar2(1);
    v_em_comp_cnt pls_integer;
    v_ccm_cnt pls_integer;
  begin
    select count(*)
    into v_cnt
    from patient_prev_svc
    where patient_sn = p_patient_sn
    ;
    if v_cnt = 0 then
      --New patient
      --Always push/start with G0438
      if p_prev_svc_billing_code = 'G0438' then
        v_return := true;
      else
        v_return := false;
        v_return_msg := 'New Patient needs to complete G0438 service first.';
      end if;
    else
      --Existing patient. G0438 is already in the system.
      --438 can be performed only once. Next one should be 439 (after 1 year of 438). Beside 439, other monthly 
      --service like CCM can be scheduled.
      --
      if p_prev_svc_billing_code = 'G0438' then
        v_return := false;
        v_return_msg := 'Service G0438 can be performed only once. May be you are looking for recurring service G0439.';
      else --G0439/99202/99212/99490/99487
        select nvl(max(svc_date),to_date('31-DEC-9999','DD-MON-YYYY'))
        into v_billing_code_svc_date
        from patient_prev_svc
        where patient_sn = p_patient_sn
        and prev_svc_billing_code = p_prev_svc_billing_code
        ;
        if v_billing_code_svc_date = to_date('31-DEC-9999','DD-MON-YYYY') then
          --No service available for the input billing code p_prev_svc_billing_code. So the reference 
          --service date will be against G0438 service perform date.
          select svc_perform_date
          into v_G0438_svc_date
          from patient_prev_svc
          where patient_sn = p_patient_sn
          and prev_svc_billing_code = 'G0438'
          ;
          if p_prev_svc_billing_code = 'G0439' then
            --439 needs to be scheduled after 1 year of 438
            if months_between(trunc(p_svc_date),v_G0438_svc_date) >= 12 then
              v_return := true;
            else
              v_return := false;
              v_return_msg := 'G0438 was performed on '||to_char(v_G0438_svc_date,'DD-MON-YYYY')||'. Yearly service G0439 can''t be performed before '||to_char(add_months(v_G0438_svc_date,12),'DD-MON-YYYY')||'.';
            end if;
          else --99202/99212/99490/99487
            --Get the last/latest AWV for the Patient
            select nvl(max(patient_prev_svc_sn),0)
            into v_parent_patient_prev_svc_sn
            from patient_prev_svc
            where patient_sn = p_patient_sn
            and prev_svc_billing_code in ('G0438','G0439')
            and svc_comp_flag = 'Y'
            ;
            if v_parent_patient_prev_svc_sn = 0 then --No AWV service in the system
              v_return := false;
              v_return_msg := 'Patient first needs to complete AWV (G0438 OR G0439) before scheduling EM or CCM service';
            else --Patient have completed AWV. Now check if the last AWV qualify for CCM
              if p_prev_svc_billing_code in ('99202','99212') then
                --If Patient identified as CCM patient (qualify_for_em_followup_flag = Y) then E/M face to face evaluation with primary provider
                --99202 for new patient and 99212 is for existing patient.
                --E/M service can be done only when the Patient have completed G0438 OR G0439 in the system and qualify_for_em_followup_flag = Y
                --
                --Patient have completed AWV. Now check if the last AWV qualify for CCM (qualify_for_em_followup_flag = N)
                select nvl(qualify_for_em_followup_flag,'N')
                into v_qualify_for_em_followup_flag
                from patient_prev_svc
                where patient_prev_svc_sn = v_parent_patient_prev_svc_sn
                ;
                if v_qualify_for_em_followup_flag = 'N' then
                  v_return := false;
                  v_return_msg := 'Patient does not qualify for E/M (99202/99212) service.';
                else --qualify for E/M service. Now check which EM Service 99202 or 99212
                  select count(*)
                  into v_99202_cnt
                  from patient_prev_svc
                  where patient_sn = p_patient_sn
                  and prev_svc_billing_code = '99202'
                  ;
                  if v_99202_cnt = 0 then --Needs New Patient E/M (99202) service
                    if p_prev_svc_billing_code = '99212' then
                      v_return := false;
                      v_return_msg := 'New Patient. Please submit billing code 99202.';
                    else --p_prev_svc_billing_code = '99202'
                      v_return := true;
                    end if;
                  else --Existing patient, needs EM 99212 service
                    if p_prev_svc_billing_code = '99202' then
                      v_return := false;
                      v_return_msg := 'Existing Patient. Please submit billing code 99212.';
                    else --p_prev_svc_billing_code = '99212'
                      v_return := true;
                    end if;
                  end if;
                end if;
              elsif p_prev_svc_billing_code in ('99490','99487') then
                --99487	Complex Chronic Care Mgmt, 60 min/month
                --99490	Chronic Care Mgmt, 20 min/month
                --99490 or 99487 can be scheduled any time after E/M completion
                --
                --Check if there is a completed EM service related to v_parent_patient_prev_svc_sn
                select count(*)
                into v_em_comp_cnt
                from patient_prev_svc
                where patient_sn = p_patient_sn
                and prev_svc_billing_code in ('99202','99212')
                and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
                and svc_comp_flag = 'Y'
                ;
                if v_em_comp_cnt = 0 then
                  v_return := false;
                  v_return_msg := 'No Complete E/M Service for this Patient.';
                else --EM Service is complete. CCM can be scheduled
                  --CCM is a monthly service. 99487 or 99490 can be completed only once in a month. 
                  --Here the same service can/will be broken into mutiple different services for a single month.
                  --
                  --This section is for the first time of any of the service is schedule. so just return true
                  v_return := true;
                end if;
              else
                --future coding
                v_return := false;
                v_return_msg := 'Initial configuration setup for service code '||p_prev_svc_billing_code||' is not complete. Please contact Admin/Support.';
              end if;
            end if;            
          end if;
        else
          --===================================================Recurring service===============================================================
          --Reference service date will be against the input billing code p_prev_svc_billing_code related service date.
          if p_prev_svc_billing_code = 'G0439' then
            --Recurring 439 is a yearly program
            if months_between(trunc(p_svc_date),v_billing_code_svc_date) >= 12 then
              v_return := true;
            else
              v_return := false;
              v_return_msg := 'Recurring Yearly service G0439 can''t be performed before '||to_char(add_months(v_billing_code_svc_date,12),'DD-MON-YYYY')||'.';
            end if;
          elsif p_prev_svc_billing_code in ('99202','99212') then
            if p_prev_svc_billing_code = '99202' then
              v_return := false;
              v_return_msg := 'E/M 99202 service can be scheduled only once';
            else --99212
              --Find the latest completed AWV.
              select nvl(max(patient_prev_svc_sn),0)
              into v_parent_patient_prev_svc_sn
              from patient_prev_svc
              where patient_sn = p_patient_sn
              and prev_svc_billing_code in ('G0438','G0439')
              and svc_comp_flag = 'Y'
              ;
              if v_parent_patient_prev_svc_sn = 0 then --No AWV service in the system
                v_return := false;
                v_return_msg := 'Patient first needs to complete AWV (G0438 OR G0439) before scheduling EM or CCM service';
              else
                --check if there is any 99212 for the latest completed AWV.
                select count(*)
                into v_99212_cnt
                from patient_prev_svc
                where patient_sn = p_patient_sn
                and prev_svc_billing_code = '99212'
                and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
                ;
                if v_99212_cnt = 0 then
                  v_return := true;
                else
                  v_return := false;
                  v_return_msg := 'EM Service 99212 is already scheduled.';
                end if;
              end if;
            end if;
          elsif p_prev_svc_billing_code in ('99490','99487') then
            --CCM is a monthly service. 99487 or 99490 can't be completed only once in a month. 
            --Here the same service can/will be broken into mutiple different service for a single month.
            --Find the latest completed AWV.
            select nvl(max(patient_prev_svc_sn),0)
            into v_parent_patient_prev_svc_sn
            from patient_prev_svc
            where patient_sn = p_patient_sn
            and prev_svc_billing_code in ('G0438','G0439')
            and svc_comp_flag = 'Y'
            ;
            if v_parent_patient_prev_svc_sn = 0 then --No AWV service in the system
              v_return := false;
              v_return_msg := 'Patient first needs to complete AWV (G0438 OR G0439) before scheduling EM or CCM service';
            else
              --check the number of CCM service done for requested scheduled service month
              --for 99490 (20 min monthly), max 2 (10/session) is allowed
              --for 99487 (60 min monthly), max 4 (15/session) is allowed
              --
              select count(*)
              into v_ccm_cnt
              from patient_prev_svc
              where patient_sn = p_patient_sn
              and prev_svc_billing_code = p_prev_svc_billing_code
              and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
              and to_char(svc_date,'MMYY') = to_char(p_svc_date,'MMYY')
              ;
              if p_prev_svc_billing_code = '99490' then
                if v_ccm_cnt between 0 and 1 then
                  v_return := true;
                else -- max 2 for that month have reached
                  v_return := false;
                  v_return_msg := 'Maximum number (2) of 99490 CCM service for the month '||to_char(p_svc_date,'MON,YYYY')||' already been scheduled.';
                end if;
              elsif p_prev_svc_billing_code = '99487' then
                if v_ccm_cnt between 0 and 3 then
                  v_return := true;
                else -- max 4 for that month have reached
                  v_return := false;
                  v_return_msg := 'Maximum number (4) of 99487 CCM service for the month '||to_char(p_svc_date,'MON,YYYY')||' already been scheduled.';
                end if;
              end if;
            end if;
          else
            --future coding
            v_return := true;
            v_return_msg := 'Initial configuration setup for service code '||p_prev_svc_billing_code||' is not complete. Please contact Admin/Support.';
          end if;
        end if;        
      end if;
    end if;
    p_valid_svc := v_return;
    p_parent_patient_prev_svc_sn := v_parent_patient_prev_svc_sn;
    p_msg := v_return_msg;
  end prev_svc_validity_old;
  --
  procedure create_company(p_company_json in varchar2,p_addr_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_company_rec   company%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
    v_active_flag   varchar2(1);
  begin
    v_proc_name := upper('create_company');
    v_input_str := 'p_company_json: '||p_company_json||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse company record
    parse_json_pkg.company_parsing(p_company_json,v_company_rec);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_company_rec.addr_sn);
    --check required fields
    if v_company_rec.NAME is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Name is a required field.';    
    elsif v_company_rec.CONTACT_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Contact Name is a required field.';    
    elsif v_company_rec.PHONE_NUMBER is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Phone Number is a required field.';    
    elsif v_company_rec.addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Address is a required field.';    
    elsif v_company_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is a required field.';
    else
      --Assign other required column value
      v_company_rec.updated_by_user_role_id := v_company_rec.created_by_user_role_id;
      --Create company record
      begin
        common_dml_pkg.ins_company(v_company_rec);
        v_status := 'SUCCESSFUL';
        v_msg := 'Company Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from company
          where ADDR_SN = v_company_rec.ADDR_SN
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'Company record already exist.';
          else
            update company
            set active_flag = 'Y'
            where ADDR_SN = v_company_rec.ADDR_SN
            ;
            v_status := 'SUCCESSFUL';
            v_msg := 'Company Record has been created successfully.';
          end if;        
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
  end create_company;
  --
  procedure update_company_demo(p_company_sn in number,p_company_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_company_rec   company%rowtype;
  begin
    v_proc_name := upper('update_company_demo');
    v_input_str := 'p_company_sn: '||p_company_sn||'-p_company_json: '||p_company_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse company record
    parse_json_pkg.company_parsing(p_company_json,v_company_rec);
    --check required fields
    if p_company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif v_company_rec.NAME is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Name is a required field.';
    elsif v_company_rec.CONTACT_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Contact Name is a required field.';    
    elsif v_company_rec.PHONE_NUMBER is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Phone Number is a required field.';    
    elsif v_company_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is a required field.';
    else
      --Assign other required column value
      v_company_rec.updated_by_user_role_id := v_company_rec.created_by_user_role_id;
      --Update company record
      update company
      set name = v_company_rec.NAME
         ,CONTACT_NAME = v_company_rec.CONTACT_NAME
         ,PHONE_NUMBER = v_company_rec.PHONE_NUMBER
         ,updated_by_user_role_id = v_company_rec.updated_by_user_role_id
         ,TOLL_FREE_NUMBER = v_company_rec.TOLL_FREE_NUMBER
         ,FAX_NUMBER = v_company_rec.FAX_NUMBER
         ,WEBSITE_ADDR = v_company_rec.WEBSITE_ADDR
      where company_sn = p_company_sn
      ;
      v_status := 'SUCCESSFUL';
      v_msg := 'Company Record has been updated successfully.';
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
  end update_company_demo;
  --
  procedure update_company_addr(p_company_sn in number,p_addr_json in varchar2,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_company_rec   company%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
  begin
    v_proc_name := upper('update_company_addr');
    v_input_str := 'p_company_sn: '||p_company_sn||'-p_user: '||p_user||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_company_rec.addr_sn);
    --check required fields
    if p_company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif v_company_rec.addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Comapny Address is a required field.';    
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User email is a required field.';
    else
      --Assign other required column value
      v_company_rec.updated_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
      --Update company record
      begin
        update company
        set updated_by_user_role_id = v_company_rec.updated_by_user_role_id
           ,addr_sn = v_company_rec.addr_sn
        where company_sn = p_company_sn
        ;
        v_status := 'SUCCESSFUL';
        v_msg := 'Company Record has been updated successfully.';
      exception
        when dup_val_on_index then
          v_status := 'FAILED';
          v_msg := 'Company record with this address already exist.';
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
  end update_company_addr;
  --
  procedure update_user_demo(p_user_email in varchar2,p_first_name in varchar2,p_middle_name in varchar2,p_last_name in varchar2,p_phone in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_id   "AspNetUsers"."Id"%type := mbr_inq_pkg.user_id_by_username(p_user_email);
  begin
    v_proc_name := upper('update_user_demo');
    v_input_str := 'p_user_email: '||p_user_email||'-p_first_name: '||p_first_name||'-p_middle_name: '||p_middle_name||'-p_last_name: '||p_last_name||'-p_phone: '||p_phone;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_user_email is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif p_first_name is null then
      v_status := 'FAILED';
      v_msg := 'First Name is a required field.';
    elsif p_middle_name is null then
      v_status := 'FAILED';
      v_msg := 'Middle Name is a required field.';
    elsif p_last_name is null then
      v_status := 'FAILED';
      v_msg := 'Last Name is a required field.';
    elsif p_phone is null then
      v_status := 'FAILED';
      v_msg := 'Phone is a required field.';
    else
      --Update user record
      update "AspNetUsers"
      set "PhoneNumber" = p_phone
         ,first_name = p_first_name
         ,middle_name = p_middle_name
         ,last_name = p_last_name
      where "Id" = v_user_id
      ;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Record has been updated successfully.';
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
  end update_user_demo;
  --
  procedure update_user_addr(p_user_email in varchar2,p_addr_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
    v_addr_sn       number(11);
    v_user_id   "AspNetUsers"."Id"%type := mbr_inq_pkg.user_id_by_username(p_user_email);
  begin
    v_proc_name := upper('update_user_addr');
    v_input_str := 'p_user_email: '||p_user_email||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_addr_sn);
    --check required fields
    if p_user_email is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif v_addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Address is a required field.';    
    else
      --Update user record
      update "AspNetUsers"
      set addr_sn = v_addr_sn
      where "Id" = v_user_id
      ;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Record has been updated successfully.';
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
  end update_user_addr;
  --
  procedure update_user_role(p_user_email in varchar2,p_role_id in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_role_id "AspNetUserRoles".user_role_id%type := mbr_inq_pkg.user_role_id_by_username(p_user_email);
  begin
    v_proc_name := upper('update_user_role');
    v_input_str := 'p_user_email: '||p_user_email||'-p_role_id: '||p_role_id;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_user_email is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif p_role_id is null then
      v_status := 'FAILED';
      v_msg := 'Role is a required field.';    
    else
      --Update user record
      update "AspNetUserRoles"
      set "RoleId" = p_role_id
      where user_role_id = v_user_role_id
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Record has been updated successfully.';
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
  end update_user_role;
  --
  procedure update_user_prov_status(p_user_email in varchar2,p_user_is_a_provider_flag in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_id   "AspNetUsers"."Id"%type := mbr_inq_pkg.user_id_by_username(p_user_email);
  begin
    v_proc_name := upper('update_user_prov_status');
    v_input_str := 'p_user_email: '||p_user_email||'-p_user_is_a_provider_flag: '||p_user_is_a_provider_flag;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_user_email is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif p_user_is_a_provider_flag is null then
      v_status := 'FAILED';
      v_msg := 'User Is a Provider Flag is a required field.';    
    else
      --Update user record
      update "AspNetUsers"
      set svc_provider_flag = p_user_is_a_provider_flag
      where "Id" = v_user_id
      ;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Record has been updated successfully.';
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
  end update_user_prov_status;
  --
  procedure update_user_status(p_user_email in varchar2,p_status_flag in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_role_id "AspNetUserRoles".user_role_id%type := mbr_inq_pkg.user_role_id_by_username(p_user_email);
  begin
    v_proc_name := upper('update_user_status');
    v_input_str := 'p_user_email: '||p_user_email||'-p_status_flag: '||p_status_flag;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_user_email is null then
      v_status := 'FAILED';
      v_msg := 'Record Update Key is a required field.';    
    elsif p_status_flag is null then
      v_status := 'FAILED';
      v_msg := 'User Active Status Flag is a required field.';    
    else
      --Update user record
      update "AspNetUserRoles"
      set active_flag = p_status_flag
      where user_role_id = v_user_role_id
      ;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Record has been updated successfully.';
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
  end update_user_status;
  --
  procedure create_provider_physician(p_provider_physician_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_physician_rec   provider_physician%rowtype;
    v_active_flag varchar2(1);
    v_company_sn number(11);
  begin
    v_proc_name := upper('create_provider_physician');
    v_input_str := 'p_provider_physician_json: '||p_provider_physician_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse provider_physician record
    parse_json_pkg.provider_physician_parsing(p_provider_physician_json,v_provider_physician_rec);
    --check required fields
    if v_provider_physician_rec.company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Comapny is a required field.';
    elsif v_provider_physician_rec.PHYSICIAN_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'Prospective Provider is a required field.';
    elsif v_provider_physician_rec.TITLE is null then
      v_status := 'FAILED';
      v_msg := 'Title is a required field.';
    elsif v_provider_physician_rec.PHYSICIAN_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Provider Type is a required field.';
    elsif v_provider_physician_rec.LICENSE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'License is a required field.';
    elsif v_provider_physician_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    else
      select company_sn
      into v_company_sn
      from user_vw
      where user_role_id = v_provider_physician_rec.PHYSICIAN_USER_ROLE_ID
      ;
      if v_company_sn <> v_provider_physician_rec.company_sn then
        v_status := 'FAILED';
        v_msg := 'User does not belongs to this company. Please check the input data.';
      else
        --Assign other required column value
        v_provider_physician_rec.updated_by_user_role_id := v_provider_physician_rec.created_by_user_role_id;
        --Create provider_physician record
        begin
          common_dml_pkg.ins_provider_physician(v_provider_physician_rec);
          v_status := 'SUCCESSFUL';
          v_msg := 'Provider Record has been created successfully.';      
        exception
          when dup_val_on_index then
            --there are 2 keys for this table LICENSE_NUM and PHYSICIAN_USER_ROLE_ID
            begin
              select active_flag
              into v_active_flag
              from provider_physician
              where PHYSICIAN_USER_ROLE_ID = v_provider_physician_rec.PHYSICIAN_USER_ROLE_ID
              ;
              if v_active_flag = 'Y' then
                v_status := 'FAILED';
                v_msg := 'Provider record already exist.';
              else
                update provider_physician
                set active_flag = 'Y'
                where PHYSICIAN_USER_ROLE_ID = v_provider_physician_rec.PHYSICIAN_USER_ROLE_ID
                ;
                v_status := 'SUCCESSFUL';
                v_msg := 'Provider Record has been created successfully.';
              end if;
            exception
              when no_data_found then --check license_num ak1
                v_status := 'FAILED';
                v_msg := 'Provider record with the license number '||v_provider_physician_rec.LICENSE_NUM||' already exist.';
            end;
        end;
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
  end create_provider_physician;
  --
  procedure update_provider_physician(p_provider_physician_sn in number,p_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_physician_rec   provider_physician%rowtype;
    v_active_flag varchar2(1);
  begin
    v_proc_name := upper('update_provider_physician');
    v_input_str := 'p_provider_physician_sn: '||p_provider_physician_sn||'-p_json: '||p_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse provider_physician record
    parse_json_pkg.provider_physician_update(p_json,v_provider_physician_rec);
    --check required fields
    if p_provider_physician_sn is null then
      v_status := 'FAILED';
      v_msg := 'Update key is missing.';
    elsif v_provider_physician_rec.TITLE is null then
      v_status := 'FAILED';
      v_msg := 'Title is a required field.';
    elsif v_provider_physician_rec.PHYSICIAN_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Provider Type is a required field.';
    elsif v_provider_physician_rec.LICENSE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'License is a required field.';
    elsif v_provider_physician_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    else
      --Assign other required column value
      v_provider_physician_rec.updated_by_user_role_id := v_provider_physician_rec.created_by_user_role_id;
      begin
        --update provider_physician record
        update provider_physician
        set TITLE = v_provider_physician_rec.TITLE
           ,LICENSE_NUM = v_provider_physician_rec.LICENSE_NUM
           ,NPI = v_provider_physician_rec.NPI
           ,PHYSICIAN_TYPE_CODE = v_provider_physician_rec.PHYSICIAN_TYPE_CODE
           ,DR_TYPE = v_provider_physician_rec.DR_TYPE
           ,updated_by_user_role_id = v_provider_physician_rec.updated_by_user_role_id
        where provider_physician_sn = p_provider_physician_sn
        ;
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'Provider Record has been updated successfully.';      
      exception
        when dup_val_on_index then
          v_status := 'FAILED';
          v_msg := 'Provider Record with the License Number '||v_provider_physician_rec.LICENSE_NUM||' already exist.';
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
  end update_provider_physician;
  --
  procedure xfer_specific_svc(p_patient_prev_svc_sn in number,p_provider_physician_sn_from in varchar2,p_provider_physician_sn_to in varchar2,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_physician_rec   provider_physician%rowtype;
    v_prev_svc_billing_code   list_prev_svc_billing.prev_svc_billing_code%type;
    v_parent_patient_prev_svc_sn  number(11);
  begin
    v_proc_name := upper('xfer_specific_svc');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_provider_physician_sn_from: '||p_provider_physician_sn_from||'-p_provider_physician_sn_to: '||p_provider_physician_sn_to||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_patient_prev_svc_sn is null then
      v_status := 'FAILED';
      v_msg := 'Required Edit key value is missing.';
    elsif p_provider_physician_sn_from is null then
      v_status := 'FAILED';
      v_msg := 'Provider xfer From is missing.';
    elsif p_provider_physician_sn_to is null then
      v_status := 'FAILED';
      v_msg := 'Provider xfer To is missing.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    elsif p_provider_physician_sn_from = p_provider_physician_sn_to then
      v_status := 'FAILED';
      v_msg := 'Provider xfter From and To are same. Please choose a different Provider';
    else
      --Assign other required column value
      v_provider_physician_rec.updated_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
      --
      select prev_svc_billing_code
            ,parent_patient_prev_svc_sn
      into v_prev_svc_billing_code
          ,v_parent_patient_prev_svc_sn
      from patient_prev_svc
      where patient_prev_svc_sn = p_patient_prev_svc_sn
      ;
      if v_prev_svc_billing_code = 'G0447' then
        --Obesity Counseling. There could be total 22 services. Xfer all of them
        for i in (select patient_prev_svc_sn
                  from patient_prev_svc
                  where prev_svc_billing_code = v_prev_svc_billing_code
                  and provider_physician_sn = p_provider_physician_sn_from
                  and svc_comp_flag = 'N'
                  and parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
                  )
        loop
          update patient_prev_svc
          set provider_physician_sn = p_provider_physician_sn_to
             ,updated_by_user_role_id = v_provider_physician_rec.updated_by_user_role_id
          where patient_prev_svc_sn = i.patient_prev_svc_sn
          ;
        end loop;
      else
        update patient_prev_svc
        set provider_physician_sn = p_provider_physician_sn_to
           ,updated_by_user_role_id = v_provider_physician_rec.updated_by_user_role_id
        where patient_prev_svc_sn = p_patient_prev_svc_sn
        and svc_comp_flag = 'N'
        ;
      end if;
      --
      v_status := 'SUCCESSFUL';
      v_msg := 'Service has been transferred successfully.';      
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
  end xfer_specific_svc;
  --
  procedure xfer_all_svc(p_provider_physician_sn_from in varchar2,p_provider_physician_sn_to in varchar2,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_physician_rec   provider_physician%rowtype;
  begin
    v_proc_name := upper('xfer_all_svc');
    v_input_str := 'p_provider_physician_sn_from: '||p_provider_physician_sn_from||'-p_provider_physician_sn_to: '||p_provider_physician_sn_to||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_provider_physician_sn_from is null then
      v_status := 'FAILED';
      v_msg := 'Provider xfer From is missing.';
    elsif p_provider_physician_sn_to is null then
      v_status := 'FAILED';
      v_msg := 'Provider xfer To is missing.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    elsif p_provider_physician_sn_from = p_provider_physician_sn_to then
      v_status := 'FAILED';
      v_msg := 'Provider xfter From and To are same. Please choose a different Provider';
    else
      --Assign other required column value
      v_provider_physician_rec.updated_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
      --
      --Xfer all the services under p_provider_physician_sn_from to p_provider_physician_sn_to
      for i in (select patient_prev_svc_sn
                from patient_prev_svc
                where provider_physician_sn = p_provider_physician_sn_from
                and svc_comp_flag = 'N'
                )
      loop
        update patient_prev_svc
        set provider_physician_sn = p_provider_physician_sn_to
           ,updated_by_user_role_id = v_provider_physician_rec.updated_by_user_role_id
        where patient_prev_svc_sn = i.patient_prev_svc_sn
        ;
      end loop;
      --
      v_status := 'SUCCESSFUL';
      v_msg := 'All the services have been transferred successfully.';
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
  end xfer_all_svc;
  --
  procedure delete_provider_physician(p_provider_physician_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_physician_rec   provider_physician%rowtype;
    v_active_flag varchar2(1);
  begin
    v_proc_name := upper('delete_provider_physician');
    v_input_str := 'p_provider_physician_sn: '||p_provider_physician_sn||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required fields
    if p_provider_physician_sn is null then
      v_status := 'FAILED';
      v_msg := 'Delete key is missing.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    else
      update provider_physician
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where provider_physician_sn = p_provider_physician_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Provider Record has been deleted successfully.';    
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
  end delete_provider_physician;
  --
  procedure create_physician(p_physician_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_physician_rec   physician%rowtype;
    v_active_flag varchar2(1);
  begin
    v_proc_name := upper('create_physician');
    v_input_str := 'p_physician_json: '||p_physician_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse physician record
    parse_json_pkg.physician_parsing(p_physician_json,v_physician_rec);
    --check required field
    if v_physician_rec.TITLE is null then
      v_status := 'FAILED';
      v_msg := 'Title is a required field.';    
    elsif v_physician_rec.FIRST_NAME is null then
      v_status := 'FAILED';
      v_msg := 'First Name is a required field.';
    elsif v_physician_rec.LAST_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Last Name is a required field.';
    elsif v_physician_rec.LICENSE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'License Number is a required field.';
    elsif v_physician_rec.PHYSICIAN_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Physician Type is a required field.';
    elsif v_physician_rec.DR_TYPE is null then
      v_status := 'FAILED';
      v_msg := 'Dr Type (DO/MD) is a required field.';
    elsif v_physician_rec.CONTACT_PHONE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'Phone is a required field.';
    elsif v_physician_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    else
      --Assign other required column value
      v_physician_rec.updated_by_user_role_id := v_physician_rec.created_by_user_role_id;
      --Create physician record
      begin
        common_dml_pkg.ins_physician(v_physician_rec);
        v_status := 'SUCCESSFUL';
        v_msg := 'Physician Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from physician
          where license_num = v_physician_rec.license_num
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'Physician record already exist.';
          else
            update physician
            set active_flag = 'Y'
            where license_num = v_physician_rec.license_num
            ;
            v_status := 'SUCCESSFUL';
            v_msg := 'Physician Record has been created successfully.';
          end if;   
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
  end create_physician;
  --
  procedure update_physician(p_physician_sn in number,p_physician_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_physician_rec   physician%rowtype;
  begin
    v_proc_name := upper('update_physician');
    v_input_str := 'p_physician_sn: '||p_physician_sn||'-p_physician_json: '||p_physician_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse physician record
    parse_json_pkg.physician_parsing(p_physician_json,v_physician_rec);
    --check required field
    if p_physician_sn is null then
      v_status := 'FAILED';
      v_msg := 'Update key is missing.';    
    elsif v_physician_rec.TITLE is null then
      v_status := 'FAILED';
      v_msg := 'Title is a required field.';
    elsif v_physician_rec.FIRST_NAME is null then
      v_status := 'FAILED';
      v_msg := 'First Name is a required field.';
    elsif v_physician_rec.LAST_NAME is null then
      v_status := 'FAILED';
      v_msg := 'Last Name is a required field.';
    elsif v_physician_rec.LICENSE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'License Number is a required field.';
    elsif v_physician_rec.PHYSICIAN_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Physician Type is a required field.';
    elsif v_physician_rec.DR_TYPE is null then
      v_status := 'FAILED';
      v_msg := 'Dr Type (DO/MD) is a required field.';
    elsif v_physician_rec.CONTACT_PHONE_NUM is null then
      v_status := 'FAILED';
      v_msg := 'Phone is a required field.';
    elsif v_physician_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';    
    else
      --Assign other required column value
      v_physician_rec.updated_by_user_role_id := v_physician_rec.created_by_user_role_id;
      begin
        --update physician record
        update physician
        set TITLE = v_physician_rec.TITLE
           ,FIRST_NAME = v_physician_rec.FIRST_NAME
           ,MIDDLE_NAME = v_physician_rec.MIDDLE_NAME
           ,LAST_NAME = v_physician_rec.LAST_NAME
           ,LICENSE_NUM = v_physician_rec.LICENSE_NUM
           ,NPI = v_physician_rec.NPI
           ,PHYSICIAN_TYPE_CODE = v_physician_rec.PHYSICIAN_TYPE_CODE
           ,DR_TYPE = v_physician_rec.DR_TYPE
           ,CONTACT_PHONE_NUM = v_physician_rec.CONTACT_PHONE_NUM
           ,EMAIL_ADDR = v_physician_rec.EMAIL_ADDR
           ,updated_by_user_role_id = v_physician_rec.updated_by_user_role_id
        where physician_sn = p_physician_sn
        ;
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'Physician Record has been updated successfully.';
      exception
        when dup_val_on_index then
          v_status := 'FAILED';
          v_msg := 'Physician Record with the License Number '||v_physician_rec.LICENSE_NUM||' already exist.';
      end;
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
  end update_physician;
  --
  procedure delete_physician(p_physician_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_physician_rec   physician%rowtype;
  begin
    v_proc_name := upper('delete_physician');
    v_input_str := 'p_physician_sn: '||p_physician_sn||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --check required field
    if p_physician_sn is null then
      v_status := 'FAILED';
      v_msg := 'Delete key is missing.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User email is a required field.';    
    else
      update physician
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where physician_sn = p_physician_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Physician Record has been deleted successfully.';
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
  end delete_physician;
  --
  procedure create_svc_location(p_svc_location_json in varchar2,p_addr_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_svc_location_rec   svc_location%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
    v_active_flag varchar2(1);
  begin
    v_proc_name := upper('create_svc_location');
    v_input_str := 'p_svc_location_json: '||p_svc_location_json||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse svc_location record
    parse_json_pkg.svc_location_parsing(p_svc_location_json,v_svc_location_rec);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_svc_location_rec.addr_sn);
    if v_svc_location_rec.company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Company Selection is required.';
    elsif v_svc_location_rec.NAME is null then
      v_status := 'FAILED';
      v_msg := 'Location Name is required.';
    elsif v_svc_location_rec.SVC_LOCATION_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Location Type is required.';
    elsif v_svc_location_rec.PHONE_NUM_1 is null then
      v_status := 'FAILED';
      v_msg := 'Location Phone is required.';
    elsif v_svc_location_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    elsif v_svc_location_rec.addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Address is required.';
    else
      --Assign other required column value
      v_svc_location_rec.updated_by_user_role_id := v_svc_location_rec.created_by_user_role_id;
      --Create svc_location record
      begin
        common_dml_pkg.ins_svc_location(v_svc_location_rec);
        v_status := 'SUCCESSFUL';
        v_msg := 'Service Location Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from svc_location
          where company_sn = v_svc_location_rec.company_sn
          and addr_sn = v_svc_location_rec.addr_sn
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'Service Location record already exist.';
          else
            update svc_location
            set active_flag = 'Y'
            where company_sn = v_svc_location_rec.company_sn
            and addr_sn = v_svc_location_rec.addr_sn
            ;
            v_status := 'SUCCESSFUL';
            v_msg := 'Service Location Record has been created successfully.';
          end if;
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
  end create_svc_location;
  --
  procedure update_svc_location(p_svc_location_sn in number,p_svc_location_json in varchar2,p_addr_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_svc_location_rec   svc_location%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;    
  begin
    v_proc_name := upper('update_svc_location');
    v_input_str := 'p_svc_location_json: '||p_svc_location_json||'-p_addr_json: '||p_addr_json||'-p_svc_location_sn: '||p_svc_location_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse svc_location record
    parse_json_pkg.svc_location_parsing(p_svc_location_json,v_svc_location_rec);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_svc_location_rec.addr_sn);
    if p_svc_location_sn is null then
      v_status := 'FAILED';
      v_msg := 'Update Key svc_location_sn is missing.';
    elsif v_svc_location_rec.company_sn is null then
      v_status := 'FAILED';
      v_msg := 'Company Selection is required.';
    elsif v_svc_location_rec.NAME is null then
      v_status := 'FAILED';
      v_msg := 'Location Name is required.';
    elsif v_svc_location_rec.SVC_LOCATION_TYPE_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Location Type is required.';
    elsif v_svc_location_rec.PHONE_NUM_1 is null then
      v_status := 'FAILED';
      v_msg := 'Location Phone is required.';
    elsif v_svc_location_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'User email is required.';
    elsif v_svc_location_rec.addr_sn is null then
      v_status := 'FAILED';
      v_msg := 'Address is required.';
    else
      --Assign other required column value
      v_svc_location_rec.updated_by_user_role_id := v_svc_location_rec.created_by_user_role_id;
      --Update svc_location record
      begin
        update svc_location
        set ADDR_SN = v_svc_location_rec.addr_sn
            ,NAME = v_svc_location_rec.NAME
            ,SVC_LOCATION_TYPE_CODE = v_svc_location_rec.SVC_LOCATION_TYPE_CODE
            ,UPDATED_BY_USER_ROLE_ID = v_svc_location_rec.UPDATED_BY_USER_ROLE_ID
            ,CONTACT_NAME = v_svc_location_rec.CONTACT_NAME
            ,PHONE_NUM_1 = v_svc_location_rec.PHONE_NUM_1
        where svc_location_sn = p_svc_location_sn
        ;
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'Service Location Record has been updated successfully.';
      exception
        when dup_val_on_index then
          v_status := 'FAILED';
          v_msg := 'Service Location Record with the address already exist.';
      end;
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
  end update_svc_location;
  --
  procedure delete_svc_location(p_svc_location_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_svc_location_rec   svc_location%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;    
  begin
    v_proc_name := upper('delete_svc_location');
    v_input_str := 'p_user: '||p_user||'-p_svc_location_sn: '||p_svc_location_sn;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    if p_svc_location_sn is null then
      v_status := 'FAILED';
      v_msg := 'Update Key svc_location_sn is missing.';
    elsif p_user is null then
      v_status := 'FAILED';
      v_msg := 'User Email is required.';
    else
      --Update svc_location record
      update svc_location
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where svc_location_sn = p_svc_location_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Service Location Record has been updated successfully.';
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
  end delete_svc_location;
  --
  procedure create_patient(p_patient_json in varchar2,p_addr_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    obj2 json;
    tempdata json_value;
    v_patient_rec   patient%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
    v_out           varchar2(1000);
    v_med_msg       varchar2(300);
    v_ben_msg       varchar2(300);
    v_cnt           pls_integer;
    v_ssn_cnt       pls_integer;
    v_hic_cnt       pls_integer;
    v_patient_str   varchar2(1000) := null;
  begin
    v_proc_name := upper('create_patient');
    v_input_str := 'p_patient_json: '||p_patient_json||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse patient record
    parse_json_pkg.patient_parsing(p_patient_json,v_patient_rec);
    --currently in the patient data entry screen, it's allowing to enter 2 digit year (YY) and converting to YYYY which is making it 20YY. 
    --Below is a short term fix for that. There will be appropriate changes in the screen to force user enter four digit year
    if to_char(v_patient_rec.birth_date,'YYYY') > 1999 then
      v_patient_rec.birth_date := add_months(v_patient_rec.birth_date,-12*100);
    end if;
    --Parse address record
    if p_addr_json is not null then
      parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
      v_addr_rec.ADDR_TYPE_CODE := 'ML';
      common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_patient_rec.addr_sn);   
    else
      v_patient_rec.addr_sn := null;
    end if;
    --Assign other required column value
    v_patient_rec.updated_by_user_role_id := v_patient_rec.created_by_user_role_id;
    --Create patient record
    begin
      common_dml_pkg.ins_patient(v_patient_rec);
      ----This string will be used for "PATIENT Meds and Hx DATA Mgmt" link label. When clicked on that liked, pass patient_sn as input parameter of the proc
      --admin_inq_pkg.patient_hx_qnr_template_data(p_locale in varchar2,p_patient_sn in number,p_out OUT clob);
      select name||' ('||age||' y/o, '||gender||'), HIC: '||medicare_hic_num||' - '||'Physician: '||physician_name||' ('||physician_company||')'
      into v_patient_str
      from patient_vw
      where patient_sn = v_patient_rec.patient_sn
      ;
      ----
      v_status := 'SUCCESSFUL';
      v_ben_msg := 'Patient Record has been created successfully.';
    exception
      when dup_val_on_index then
        select count(*)
        into v_ssn_cnt
        from patient
        where ssn = v_patient_rec.ssn
        ;
        select count(*)
        into v_hic_cnt
        from patient
        where MEDICARE_HIC_NUM = v_patient_rec.MEDICARE_HIC_NUM
        ;
        if v_ssn_cnt > 0 then
          v_status := 'FAILED';
          v_ben_msg := 'Patient Record with SSN '||v_patient_rec.ssn||' already exist.';
        elsif v_hic_cnt > 0 then
          v_status := 'FAILED';
          v_ben_msg := 'Patient Record with HIC '||v_patient_rec.MEDICARE_HIC_NUM||' already exist.';
        end if;
    end;
    --
    commit;
    --
    obj.put('STATUS',v_status);
    obj.put('MSG',v_ben_msg);
    obj.put('PATIENT_SN',v_patient_rec.patient_sn);
    obj.put('PATIENT_HX_LABEL',v_patient_str);
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
  end create_patient;
  --
  procedure patient_edit_demo(p_patient_sn in number,p_demo_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    obj2 json := json(p_demo_json);
    tempdata      json_value;
    v_patient_rec   patient%rowtype;
  begin
    v_proc_name := upper('patient_edit_demo');
    v_input_str := 'p_patient_sn: '||p_patient_sn||'-p_demo_json: '||p_demo_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse patient record
    if obj2.exist('CREATED_BY_USERNAME') then
      tempdata := obj2.get('CREATED_BY_USERNAME');
      if tempdata is not null then
        v_patient_rec.CREATED_BY_USER_ROLE_ID := mbr_inq_pkg.user_role_id_by_username(tempdata.get_string);
      end if;
    end if;
    if obj2.exist('HIC') then
      tempdata := obj2.get('HIC');
      if tempdata is not null then
        v_patient_rec.MEDICARE_HIC_NUM := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('SSN') then
      tempdata := obj2.get('SSN');
      if tempdata is not null then
        v_patient_rec.SSN := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('FIRST_NAME') then
      tempdata := obj2.get('FIRST_NAME');
      if tempdata is not null then
        v_patient_rec.FIRST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('MIDDLE_NAME') then
      tempdata := obj2.get('MIDDLE_NAME');
      if tempdata is not null then
        v_patient_rec.MIDDLE_NAME := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('LAST_NAME') then
      tempdata := obj2.get('LAST_NAME');
      if tempdata is not null then
        v_patient_rec.LAST_NAME := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('GENDER') then
      tempdata := obj2.get('GENDER');
      if tempdata is not null then
        v_patient_rec.GENDER_CODE := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('DOB') then
      tempdata := obj2.get('DOB');
      if tempdata is not null then
        v_patient_rec.BIRTH_DATE := to_date(substr(tempdata.get_string,1,10),'YYYY-MM-DD');
      end if;
    end if;
    if obj2.exist('EMAIL') then
      tempdata := obj2.get('EMAIL');
      if tempdata is not null then
        v_patient_rec.EMAIL_ADDR := tempdata.get_string;
      end if;
    end if;
    if obj2.exist('PHONE') then
      tempdata := obj2.get('PHONE');
      if tempdata is not null then
        v_patient_rec.CONTACT_PHONE_NUM := tempdata.get_string;
      end if;
    end if;
    --Assign other required column value
    v_patient_rec.updated_by_user_role_id := v_patient_rec.created_by_user_role_id;
    --
    begin
      --Update patient demo
      update patient
      set UPDATED_BY_USER_ROLE_ID = v_patient_rec.updated_by_user_role_id
          ,GENDER_CODE = nvl(v_patient_rec.GENDER_CODE,GENDER_CODE)
          ,FIRST_NAME = nvl(v_patient_rec.FIRST_NAME,FIRST_NAME)
          ,LAST_NAME = nvl(v_patient_rec.LAST_NAME,LAST_NAME)
          ,MIDDLE_NAME = v_patient_rec.MIDDLE_NAME
          ,CONTACT_PHONE_NUM = nvl(v_patient_rec.CONTACT_PHONE_NUM,CONTACT_PHONE_NUM)
          ,EMAIL_ADDR = v_patient_rec.EMAIL_ADDR
          ,BIRTH_DATE = nvl(v_patient_rec.BIRTH_DATE,BIRTH_DATE)
          ,SSN = nvl(v_patient_rec.SSN,SSN)
          ,MEDICARE_HIC_NUM = nvl(v_patient_rec.MEDICARE_HIC_NUM,MEDICARE_HIC_NUM)
      where patient_sn = p_patient_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Patient Demographic record has been updated successfully.';
    exception
      when dup_val_on_index then
        rollback;
        v_status := 'FAILED';
        v_msg := 'Patient Record with SSN/HIC '||v_patient_rec.ssn||'/'||v_patient_rec.MEDICARE_HIC_NUM||' already exist.';
    end;
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
  end patient_edit_demo;
  --
  procedure patient_edit_addr(p_patient_sn in number,p_addr_json in varchar2,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_rec   patient%rowtype;
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;
  begin
    v_proc_name := upper('patient_edit_addr');
    v_input_str := 'p_patient_sn: '||p_patient_sn||'-p_addr_json: '||p_addr_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse address record
    parse_json_pkg.custom_addr_parsing_prc(p_addr_json,v_state_rec,v_city_rec,v_addr_rec);
    v_addr_rec.ADDR_TYPE_CODE := 'ML';
    common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_patient_rec.addr_sn);   
    --Assign other required column value
    v_patient_rec.updated_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
    --Update patient address
    update patient
    set UPDATED_BY_USER_ROLE_ID = v_patient_rec.updated_by_user_role_id
        ,addr_sn = v_patient_rec.addr_sn
    where patient_sn = p_patient_sn
    ;
    commit;
    v_status := 'SUCCESSFUL';
    v_msg := 'Patient Address has been updated successfully.';
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
  end patient_edit_addr;
  --
  procedure patient_edit_physician(p_patient_sn in number,p_company_sn in number,p_svc_location_sn in number,p_physician_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_rec   patient%rowtype;
    v_physician_svc_location_sn number(11);
  begin
    v_proc_name := upper('patient_edit_physician');
    v_input_str := 'p_patient_sn: '||p_patient_sn||'-p_company_sn: '||p_company_sn||'-p_svc_location_sn: '||p_svc_location_sn||'-p_physician_sn: '||p_physician_sn||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    begin
      select physician_svc_location_sn
      into v_physician_svc_location_sn
      from physician_svc_location
      where physician_sn = p_physician_sn
      and svc_location_sn = p_svc_location_sn
      ;
      --Assign other required column value
      v_patient_rec.updated_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
      --Update patient
      update patient
      set UPDATED_BY_USER_ROLE_ID = v_patient_rec.updated_by_user_role_id
          ,physician_sn = p_physician_sn
      where patient_sn = p_patient_sn
      ;
      --update physician_svc_location_sn for any pending services
      for i in (select patient_prev_svc_sn
                from patient_prev_svc
                where patient_sn = p_patient_sn
                and svc_comp_flag = 'N'
                and active_flag = 'Y'
                )
      loop
        update patient_prev_svc
        set physician_svc_location_sn = v_physician_svc_location_sn
            ,UPDATED_BY_USER_ROLE_ID = v_patient_rec.updated_by_user_role_id
        where patient_prev_svc_sn = i.patient_prev_svc_sn
        ;
      end loop;
      --
      commit;
      --
      v_status := 'SUCCESSFUL';
      v_msg := 'Patient Physician has been updated successfully.';
    exception
      when no_data_found then
        v_status := 'FAILED';
        v_msg := 'Physician is not associated to this location. Please associate the location first.';
    end;
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
  end patient_edit_physician;
  --
  --Only the completed services will be reprocessed by this. For template reprocess, e.g. EM or Obesity, there will be separate process.
  procedure patient_edit_rpt_reprocess(p_patient_prev_svc_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_rec   patient%rowtype;
    v_prev_svc_billing_code patient_prev_svc.prev_svc_billing_code%type;
  begin
    v_proc_name := upper('patient_edit_rpt_reprocess');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Identify the prev_svc_billing_code
    select prev_svc_billing_code
    into v_prev_svc_billing_code
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if v_prev_svc_billing_code in ('G0438','G0439') then --AWV
      mdtech_trans_pkg.awv_rpt_json_clob(p_patient_prev_svc_sn,null);
    elsif v_prev_svc_billing_code in ('G0447') then --Obesity IBT
      obes_counseling_trans_pkg.oev_rpt_json_clob(p_patient_prev_svc_sn);
    elsif v_prev_svc_billing_code in ('99202','99212') then --EM
      mdtech_trans_pkg.eev_rpt_json_clob (p_patient_prev_svc_sn); --output report
    elsif v_prev_svc_billing_code in ('99487','99490') then --CCM
      mdtech_trans_pkg.cev_rpt_json_clob(p_patient_prev_svc_sn); --output report
    end if;
    --
    commit;
    v_status := 'SUCCESSFUL';
    v_msg := 'Patient Service Report has been reprocessed successfully.';
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
  end patient_edit_rpt_reprocess;
  --
  --Only the pending services (template) will be reprocessed by this. Not all the template data needs to be reprocessed
  procedure patient_edit_temp_reprocess(p_patient_prev_svc_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_rec   patient%rowtype;
    v_prev_svc_billing_code patient_prev_svc.prev_svc_billing_code%type;
  begin
    v_proc_name := upper('patient_edit_temp_reprocess');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_user: '||p_user;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Identify the prev_svc_billing_code
    select prev_svc_billing_code
    into v_prev_svc_billing_code
    from patient_prev_svc
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if v_prev_svc_billing_code in ('99202','99212') then --EM
      mdtech_trans_pkg.esv_rpt_json_clob (p_patient_prev_svc_sn); --EM template
    elsif v_prev_svc_billing_code in ('99487','99490') then --CCM
      mdtech_trans_pkg.csv_rpt_json_clob(p_patient_prev_svc_sn); --CCM template
    end if;
    --
    commit;
    v_status := 'SUCCESSFUL';
    v_msg := 'Patient Pending Service Template has been reprocessed successfully.';
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
  end patient_edit_temp_reprocess;
  --
  --This private proc will be called from every type of service to mark service completion
  procedure svc_completion(p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_signature in clob,p_qualify_for_em_followup_flag in varchar2,p_chronic_disease_cnt in number,p_status out varchar2,p_msg out varchar2,p_patient_sn out patient.patient_sn%type)
  is
  begin
    v_proc_name := upper('svc_completion');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn;
    --
    select psbl.short_descr||' service completed successfully.'
          ,pps.patient_sn
    into p_msg
        ,p_patient_sn
    from patient_prev_svc pps
        ,list_prev_svc_billing psb
        ,prev_svc_billing_lang psbl
        ,list_prev_svc_type pst
        ,prev_svc_type_lang pstl
    where pps.prev_svc_billing_code = psb.prev_svc_billing_code
    and psb.prev_svc_billing_code = psbl.prev_svc_billing_code
    and psbl.lang_code = 'en'
    and psb.prev_svc_type_code = pst.prev_svc_type_code
    and pst.prev_svc_type_code = pstl.prev_svc_type_code
    and pstl.lang_code = 'en'
    and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    update patient_prev_svc
    set patient_signature = p_signature
       ,svc_comp_flag = 'Y'
       ,svc_perform_date = sysdate
       ,qualify_for_em_followup_flag = nvl(p_qualify_for_em_followup_flag,'N')
       ,chronic_disease_cnt = nvl(p_chronic_disease_cnt,0)
    where patient_prev_svc_sn = p_patient_prev_svc_sn
    ;
    if sql%rowcount = 1 then
      p_status := 'SUCCESSFUL';
    else
      p_status := 'FAILED';
      p_msg := 'Service Completion failed. Please contact customer support.';
    end if;
    --
    commit;
  exception
    when others then
      rollback;
      v_err_msg := SUBSTR (SQLERRM,1,100);
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
      --
      p_status := 'FAILED';
      p_msg := 'Service Completion failed. Please contact customer support.';
  end svc_completion;
  --AWV service completion proc
  procedure create_patient_signature(p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_signature in clob,p_out out varchar2)
  is
    obj json := json();
    v_patient_sn patient.patient_sn%type;
    v_qualify_for_em_followup_flag varchar2(1);
    v_chronic_disease_cnt number(9);
  begin
    v_proc_name := upper('create_patient_signature');
    v_input_str := 'p_patient_prev_svc_sn: '||p_patient_prev_svc_sn||'-p_signature:'||p_signature;
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    if p_signature is not null and p_signature <> v_empty_signature then
      --generate Patient service evaluation data
      svc_eval_pkg.svc_result_prc (p_patient_prev_svc_sn,v_qualify_for_em_followup_flag,v_chronic_disease_cnt);
      --Call the generic service completion proc
      svc_completion(p_patient_prev_svc_sn,p_signature,v_qualify_for_em_followup_flag,v_chronic_disease_cnt,v_status,v_msg,v_patient_sn);
      --Create report json data
      awv_rpt_json_clob (p_patient_prev_svc_sn,null);
      --
      obj.put('STATUS',v_status);
      obj.put('MSG',v_msg);
      p_out := obj.to_char;
    else
      obj.put('STATUS','FAILED');
      obj.put('MSG','Please submit patient signature');
      p_out := obj.to_char;
    end if;
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
  end create_patient_signature;
  --
  procedure create_patient_medication(p_patient_medication_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_medication_rec   patient_medication%rowtype;
    v_cnt pls_integer;
  begin
    v_proc_name := upper('create_patient_medication');
    v_input_str := 'p_patient_medication_json: '||p_patient_medication_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse patient_medication record
    parse_json_pkg.patient_medication_parsing(p_patient_medication_json,v_patient_medication_rec);
    --Assign other required column value      
    v_patient_medication_rec.updated_by_user_role_id := v_patient_medication_rec.created_by_user_role_id;    
    --
    if v_patient_medication_rec.NAME is null then
      v_status := 'FAILED';
      v_msg := 'Medication NAME is required.';
    elsif v_patient_medication_rec.MEDICATION_QUANTITY is null then
      v_status := 'FAILED';
      v_msg := 'DOSAGE is required.';
    elsif v_patient_medication_rec.MEDICATION_UNIT_CODE is null then 
      v_status := 'FAILED';
      v_msg := 'MEDICATION UNIT is required.';
    elsif v_patient_medication_rec.FREQUENCY_UNIT_CODE is null then 
      v_status := 'FAILED';
      v_msg := 'FREQUENCY is required.';
    elsif v_patient_medication_rec.PATIENT_SN is null then 
      v_status := 'FAILED';
      v_msg := 'No Patient record identified. First save the patient record and then create medication under that patient.';
    else
      select count(*)
      into v_cnt
      from patient_medication
      where upper(trim(name)) = upper(trim(v_patient_medication_rec.name))
      and patient_sn = v_patient_medication_rec.patient_sn
      ;
      if v_cnt = 0 then --insert
        common_dml_pkg.ins_patient_medication(v_patient_medication_rec);
        v_status := 'SUCCESSFUL';
        v_msg := 'Medication Record has been created successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'Medication ('||v_patient_medication_rec.name||') already exist.';
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
  end create_patient_medication;
  --
  procedure update_patient_medication(p_patient_medication_json in varchar2,p_patient_medication_sn in number,p_out out varchar2)
  is
    obj json := json();
    v_patient_medication_rec   patient_medication%rowtype;
    v_cnt pls_integer;
  begin
    v_proc_name := upper('update_patient_medication');
    v_input_str := 'p_patient_medication_sn: '||p_patient_medication_sn||'-p_patient_medication_json: '||p_patient_medication_json;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --Parse patient_medication record
    parse_json_pkg.patient_medication_parsing(p_patient_medication_json,v_patient_medication_rec);
    --Assign other required column value      
    v_patient_medication_rec.updated_by_user_role_id := v_patient_medication_rec.created_by_user_role_id;    
    --Updatw patient_medication record
    select count(*)
    into v_cnt
    from patient_medication
    where upper(trim(name)) = upper(trim(v_patient_medication_rec.name))
    and patient_sn = v_patient_medication_rec.patient_sn
    ;
    if v_cnt = 1 then
      --if name exist, then don't update the name to avoid duplicate key violation
      v_patient_medication_rec.name := null;
    end if;
    --
    update patient_medication
    set UPDATED_BY_USER_ROLE_ID = v_patient_medication_rec.updated_by_user_role_id
      ,MEDICATION_QUANTITY = nvl(v_patient_medication_rec.MEDICATION_QUANTITY,MEDICATION_QUANTITY)
      ,MEDICATION_UNIT_CODE = nvl(v_patient_medication_rec.MEDICATION_UNIT_CODE,MEDICATION_UNIT_CODE)
      ,INGREDIENTS = nvl(v_patient_medication_rec.ingredients,INGREDIENTS)
      ,PURPOSE = nvl(v_patient_medication_rec.PURPOSE,PURPOSE)
      ,FREQUENCY_UNIT_CODE = nvl(v_patient_medication_rec.FREQUENCY_UNIT_CODE,FREQUENCY_UNIT_CODE)
      ,MEDICATION_CURRENT_FLAG = nvl(v_patient_medication_rec.MEDICATION_CURRENT_FLAG,MEDICATION_CURRENT_FLAG)
      ,PRESCRIBED_MED_FLAG = nvl(v_patient_medication_rec.PRESCRIBED_MED_FLAG,PRESCRIBED_MED_FLAG)
      ,NOTES = nvl(v_patient_medication_rec.NOTES,NOTES)
      ,NAME = nvl(v_patient_medication_rec.NAME,NAME)
    where patient_medication_sn = p_patient_medication_sn
    ;
    if sql%rowcount = 1 then
      v_status := 'SUCCESSFUL';
      v_msg := 'Patient Medication Record updated successfully.';
    else
      v_status := 'FAILED';
      v_msg := 'Patient Medication Record update failed.';
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
  end update_patient_medication;
  --
  procedure create_patient_prev_svc(p_patient_prev_svc_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_prev_svc_rec   patient_prev_svc%rowtype;
    v_valid_svc_date date;
    --
    v_valid_svc boolean := false;
    v_return_msg varchar2(300);
  begin
    v_proc_name := upper('create_patient_prev_svc');
    v_input_str := 'p_patient_prev_svc_json: '||p_patient_prev_svc_json; 
    --Parse patient_prev_svc record
    parse_json_pkg.patient_prev_svc_parsing(p_patient_prev_svc_json,v_patient_prev_svc_rec);
    -----Check required fields
    if v_patient_prev_svc_rec.PROVIDER_PHYSICIAN_SN is null then
      v_status := 'FAILED';
      v_msg := 'Interviewer (Provider) Selection is required.';
    elsif v_patient_prev_svc_rec.PHYSICIAN_SVC_LOCATION_SN is null then
      v_status := 'FAILED';
      v_msg := 'Physician Selection is required.';
    elsif v_patient_prev_svc_rec.PREV_SVC_BILLING_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Service Selection is required.';
    elsif v_patient_prev_svc_rec.PATIENT_SN is null then
      v_status := 'FAILED';
      v_msg := 'Patient Selection is required.';
    elsif v_patient_prev_svc_rec.INSURANCE_COMPANY_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Patient Insurance Selection is required.';
    elsif v_patient_prev_svc_rec.SVC_DATE is null then
      v_status := 'FAILED';
      v_msg := 'Service Date is required.';
    elsif v_patient_prev_svc_rec.SVC_HR_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Service Hour is required.';
    elsif v_patient_prev_svc_rec.SVC_MIN_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Service Minute is required.';
    elsif v_patient_prev_svc_rec.SVC_AM_PM_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Service AM/PM is required.';
    elsif v_patient_prev_svc_rec.CREATED_BY_USER_ROLE_ID is null then
      v_status := 'FAILED';
      v_msg := 'Login user email is required.';
    else
      --Assign other required(non default) column value
      v_patient_prev_svc_rec.updated_by_user_role_id := v_patient_prev_svc_rec.created_by_user_role_id;
      --
      mdtech_trans_pkg.prev_svc_validity(v_patient_prev_svc_rec.patient_sn,v_patient_prev_svc_rec.prev_svc_billing_code,v_patient_prev_svc_rec.svc_date,v_valid_svc,v_patient_prev_svc_rec.PARENT_PATIENT_PREV_SVC_SN,v_return_msg);
      --
      if v_valid_svc then
        --Create patient_prev_svc record
        begin
          if v_patient_prev_svc_rec.prev_svc_billing_code = 'G0447' then
            --Create 22 appointment all at the same time with different service date frequency returned by function obes_appt_svc_date.
            --There will be a six month review to evaluate if the patient have lost 3kg (6.6 lbs). If the patient can''t lose 3kg over six months,
            --then reminder of the appointment will be removed by the system (by a automated process).
            --Out of the 22 appt, 1st and last (22) are initiation and final counseling.
            for i in 1..22 loop
              v_patient_prev_svc_rec.svc_date := obes_appt_svc_date(v_patient_prev_svc_rec.svc_date,i);
              v_patient_prev_svc_rec.svc_number := i;
              common_dml_pkg.ins_patient_prev_svc(v_patient_prev_svc_rec);
            end loop;
          else
            v_patient_prev_svc_rec.svc_number := 1;
            common_dml_pkg.ins_patient_prev_svc(v_patient_prev_svc_rec);
          end if;
          --update patient record with the latest insurance_company_code
          update patient
          set insurance_company_code = v_patient_prev_svc_rec.INSURANCE_COMPANY_CODE
          where patient_sn = v_patient_prev_svc_rec.PATIENT_SN
          ;
          commit;
          --create the service json
          if v_patient_prev_svc_rec.prev_svc_billing_code in ('99202','99212') then --E/M Service
            esv_rpt_json_clob (v_patient_prev_svc_rec.patient_prev_svc_sn);
          elsif v_patient_prev_svc_rec.prev_svc_billing_code in ('99487','99490') then --CCM Service
            csv_rpt_json_clob (v_patient_prev_svc_rec.patient_prev_svc_sn);
          end if;
          v_status := 'SUCCESSFUL';
          v_msg := 'Patient '||v_patient_prev_svc_rec.PREV_SVC_BILLING_CODE||' service has been scheduled successfully on '||to_char(v_patient_prev_svc_rec.svc_date,'DD-MON-YYYY');
        exception
          when dup_val_on_index then
            v_status := 'FAILED';
            v_msg := 'Patient '||v_patient_prev_svc_rec.PREV_SVC_BILLING_CODE||' service record for service date '||to_char(v_patient_prev_svc_rec.svc_date,'DD-MON-YYYY')||' already exist.';
        end;
      else
        v_status := 'FAILED';
        v_msg := v_return_msg;
      end if;
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
  end create_patient_prev_svc;
  --
  procedure create_physician_svc_location(p_physician_svc_location_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_physician_svc_location_rec   physician_svc_location%rowtype;
    v_active_flag varchar2(1);
  begin
    v_proc_name := upper('create_physician_svc_location');
    v_input_str := 'p_physician_svc_location_json: '||p_physician_svc_location_json;
    --Parse physician_svc_location record
    parse_json_pkg.physician_svc_location_parsing(p_physician_svc_location_json,v_physician_svc_location_rec);
    --Assign other required column value
    v_physician_svc_location_rec.updated_by_user_role_id := v_physician_svc_location_rec.created_by_user_role_id;
    --Create physician_svc_location record
    begin
      common_dml_pkg.ins_physician_svc_location(v_physician_svc_location_rec);
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Physician Service Location Record has been created successfully.';
    exception
      when dup_val_on_index then
        select active_flag
        into v_active_flag
        from physician_svc_location
        where physician_sn = v_physician_svc_location_rec.physician_sn
        and svc_location_sn = v_physician_svc_location_rec.svc_location_sn
        ;
        if v_active_flag = 'Y' then
          v_status := 'FAILED';
          v_msg := 'Physician Service Location record already exist.';
        else --N
          update physician_svc_location
          set active_flag = 'Y'
          where physician_sn = v_physician_svc_location_rec.physician_sn
          and svc_location_sn = v_physician_svc_location_rec.svc_location_sn
          ;
          commit;
          v_status := 'SUCCESSFUL';
          v_msg := 'Physician Service Location Record has been created successfully.';
        end if;
    end;
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
  end create_physician_svc_location;
  --
  procedure delete_physician_svc_location(p_physician_svc_location_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('delete_physician_svc_location');
    v_input_str := 'p_physician_svc_location_sn: '||p_physician_svc_location_sn||' - p_user: '||p_user;
    if p_physician_svc_location_sn is null or p_user is null then
      v_status := 'FAILED';
      v_msg := 'Required input values are missing.';
    else
      --Update physician_svc_location record
      update physician_svc_location
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where physician_svc_location_sn = p_physician_svc_location_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'Physician Service Location Record has been deleted successfully.';
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
  end delete_physician_svc_location;
  --
  procedure create_user_svc_location(p_user_svc_location_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_svc_location_rec   user_svc_location%rowtype;
    v_active_flag varchar2(1);
    v_com_cnt pls_integer;
    v_phy_cnt pls_integer;
  begin
    v_proc_name := upper('create_user_svc_location');
    v_input_str := 'p_user_svc_location_json: '||p_user_svc_location_json;
    --Parse user_svc_location record
    parse_json_pkg.user_svc_location_parsing(p_user_svc_location_json,v_user_svc_location_rec);
    --Assign other required column value
    v_user_svc_location_rec.updated_by_user_role_id := v_user_svc_location_rec.created_by_user_role_id;
    --check if there is any exception records (physician or company exception) for this user. If there are any exception records
    --then return error message
    select count(*)
    into v_phy_cnt
    from user_physician
    where user_role_id = v_user_svc_location_rec.user_role_id
    and active_flag = 'Y'
    ;
    select count(*)
    into v_com_cnt
    from user_company
    where user_role_id = v_user_svc_location_rec.user_role_id
    and active_flag = 'Y'
    ;
    if v_phy_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active physician exception. Please delete the physician exception first before applying location exception.';
    elsif v_com_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active company exception. Please delete the company exception first before applying location exception.';
    else
      --Create user_svc_location record
      begin
        common_dml_pkg.ins_user_svc_location(v_user_svc_location_rec);
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'User Service Location Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from user_svc_location
          where user_role_id = v_user_svc_location_rec.user_role_id
          and svc_location_sn = v_user_svc_location_rec.svc_location_sn
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'User Service Location record already exist.';
          else --N
            update user_svc_location
            set active_flag = 'Y'
            where user_role_id = v_user_svc_location_rec.user_role_id
            and svc_location_sn = v_user_svc_location_rec.svc_location_sn
            ;
            commit;
            v_status := 'SUCCESSFUL';
            v_msg := 'User Service Location Record has been created successfully.';
          end if;
      end;
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
  end create_user_svc_location;
  --
  procedure delete_user_svc_location(p_user_svc_location_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('delete_user_svc_location');
    v_input_str := 'p_user_svc_location_sn: '||p_user_svc_location_sn||' - p_user: '||p_user;
    if p_user_svc_location_sn is null or p_user is null then
      v_status := 'FAILED';
      v_msg := 'Required input values are missing.';
    else
    --Update physician_svc_location record
      update user_svc_location
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where user_svc_location_sn = p_user_svc_location_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Service Location Record has been deleted successfully.';
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
  end delete_user_svc_location;
  --
  procedure create_user_company(p_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_company_rec   user_company%rowtype;
    v_active_flag varchar2(1);
    v_phy_cnt pls_integer;
    v_loc_cnt pls_integer;
  begin
    v_proc_name := upper('create_user_company');
    v_input_str := 'p_json: '||p_json;
    --Parse the record
    parse_json_pkg.user_company_parsing(p_json,v_user_company_rec);
    --Assign other required column value
    v_user_company_rec.updated_by_user_role_id := v_user_company_rec.created_by_user_role_id;
    --check if there is any exception records (location or physician exception) for this user. If there are any exception records
    --then return error message
    select count(*)
    into v_loc_cnt
    from user_svc_location
    where user_role_id = v_user_company_rec.user_role_id
    and active_flag = 'Y'
    ;
    select count(*)
    into v_phy_cnt
    from user_physician
    where user_role_id = v_user_company_rec.user_role_id
    and active_flag = 'Y'
    ;
    if v_loc_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active location exception. Please delete the location exception first before providing more company priviledge.';
    elsif v_phy_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active physician exception. Please delete the physician exception first before providing more company priviledge.';
    else
      --Create user_company record
      begin
        common_dml_pkg.ins_user_company(v_user_company_rec);
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'User Company Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from user_company
          where user_role_id = v_user_company_rec.user_role_id
          and company_sn = v_user_company_rec.company_sn
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'User Company record already exist.';
          else --N
            update user_company
            set active_flag = 'Y'
            where user_role_id = v_user_company_rec.user_role_id
            and company_sn = v_user_company_rec.company_sn
            ;
            commit;
            v_status := 'SUCCESSFUL';
            v_msg := 'User Company Record has been created successfully.';
          end if;
      end;
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
  end create_user_company;
  --
  procedure delete_user_company(p_user_company_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('delete_user_company');
    v_input_str := 'p_user_company_sn: '||p_user_company_sn||' - p_user: '||p_user;
    if p_user_company_sn is null or p_user is null then
      v_status := 'FAILED';
      v_msg := 'Required input values are missing.';
    else
    --Update user_company record
      update user_company
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where user_company_sn = p_user_company_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Company Record has been deleted successfully.';
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
  end delete_user_company;
  --
  procedure create_user_physician(p_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_user_physician_rec   user_physician%rowtype;
    v_active_flag varchar2(1);
    v_com_cnt pls_integer;
    v_loc_cnt pls_integer;
  begin
    v_proc_name := upper('create_user_physician');
    v_input_str := 'p_json: '||p_json;
    --Parse the record
    parse_json_pkg.user_physician_parsing(p_json,v_user_physician_rec);
    --Assign other required column value
    v_user_physician_rec.updated_by_user_role_id := v_user_physician_rec.created_by_user_role_id;
    --check if there is any exception records (location or company exception) for this user. If there are any exception records
    --then return error message
    select count(*)
    into v_loc_cnt
    from user_svc_location
    where user_role_id = v_user_physician_rec.user_role_id
    and active_flag = 'Y'
    ;
    select count(*)
    into v_com_cnt
    from user_company
    where user_role_id = v_user_physician_rec.user_role_id
    and active_flag = 'Y'
    ;
    if v_loc_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active location exception. Please delete the location exception first before applying physician exception.';
    elsif v_com_cnt > 0 then
      v_status := 'FAILED';
      v_msg := 'User have active company exception. Please delete the company exception first before applying physician exception.';
    else
      --Create user_physician record
      begin
        common_dml_pkg.ins_user_physician(v_user_physician_rec);
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'User Physician Record has been created successfully.';
      exception
        when dup_val_on_index then
          select active_flag
          into v_active_flag
          from user_physician
          where user_role_id = v_user_physician_rec.user_role_id
          and physician_sn = v_user_physician_rec.physician_sn
          ;
          if v_active_flag = 'Y' then
            v_status := 'FAILED';
            v_msg := 'User Physician record already exist.';
          else --N
            update user_physician
            set active_flag = 'Y'
            where user_role_id = v_user_physician_rec.user_role_id
            and physician_sn = v_user_physician_rec.physician_sn
            ;
            commit;
            v_status := 'SUCCESSFUL';
            v_msg := 'User Physician Record has been created successfully.';
          end if;
      end;
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
  end create_user_physician;
  --
  procedure delete_user_physician(p_user_physician_sn in number,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
  begin
    v_proc_name := upper('delete_user_physician');
    v_input_str := 'p_user_physician_sn: '||p_user_physician_sn||' - p_user: '||p_user;
    if p_user_physician_sn is null or p_user is null then
      v_status := 'FAILED';
      v_msg := 'Required input values are missing.';
    else
    --Update user_physician record
      update user_physician
      set active_flag = 'N'
         ,updated_by_user_role_id = mbr_inq_pkg.user_role_id_by_username(p_user)
      where user_physician_sn = p_user_physician_sn
      ;
      commit;
      v_status := 'SUCCESSFUL';
      v_msg := 'User Physician Record has been deleted successfully.';
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
  end delete_user_physician;
  --
  procedure create_patient_prev_svc_remark(p_patient_prev_svc_remark_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_prev_svc_remark_rec   patient_prev_svc_remark%rowtype;
  begin
    v_proc_name := upper('create_patient_prev_svc_remark');
    v_input_str := 'p_patient_prev_svc_remark_json: '||p_patient_prev_svc_remark_json;
    --Parse patient_prev_svc_remark record
    parse_json_pkg.patient_remark_parsing(p_patient_prev_svc_remark_json,v_patient_prev_svc_remark_rec);
    --Create patient_prev_svc_remark record
    begin
      common_dml_pkg.ins_patient_prev_svc_remark(v_patient_prev_svc_remark_rec);
      v_status := 'SUCCESSFUL';
      v_msg := 'Service Remark Record has been created successfully.';
    exception
      when dup_val_on_index then
        v_status := 'FAILED';
        v_msg := 'Service Remark record already exist.';
    end;
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
  end create_patient_prev_svc_remark;
  --
  procedure update_patient_prev_svc_demo(p_patient_prev_svc_demo_json in varchar2,p_email_addr in patient.email_addr%type,p_any_concern_txt in patient_response.response_data%type,p_out out varchar2)
  is
    obj json := json();
    v_patient_prev_svc_rec patient_prev_svc%rowtype;
    v_any_concern_response varchar2(3);
  begin
    v_proc_name := upper('update_patient_prev_svc_demo');
    v_input_str := 'p_patient_prev_svc_demo_json: '||p_patient_prev_svc_demo_json;
    --Parse patient_prev_svc_remark record
    parse_json_pkg.patient_prev_svc_demo_parsing(p_patient_prev_svc_demo_json,v_patient_prev_svc_rec);
    --Check required fields
    if v_patient_prev_svc_rec.marital_status_code is null then
      v_status := 'FAILED';
      v_msg := 'Marital Status is a required field.';
    elsif v_patient_prev_svc_rec.HEIGHT_IN_IN is null then
      v_status := 'FAILED';
      v_msg := 'Height is a required field.';
    elsif v_patient_prev_svc_rec.WEIGHT_IN_LB is null then
      v_status := 'FAILED';
      v_msg := 'Weight is a required field.';
    elsif v_patient_prev_svc_rec.SYSTOLIC_BP_IN_MM is null then
      v_status := 'FAILED';
      v_msg := 'Systolic BP is a required field.';
    elsif v_patient_prev_svc_rec.DIASTOLIC_BP_IN_MM is null then
      v_status := 'FAILED';
      v_msg := 'Diastolic BP is a required field.';
    elsif v_patient_prev_svc_rec.WORKING_STATUS_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Working Status is a required field.';
    elsif v_patient_prev_svc_rec.EDUCATION_LEVEL_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Education Level is a required field.';
    elsif v_patient_prev_svc_rec.FINANCIAL_STATUS_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Financial Status is a required field.';
    elsif v_patient_prev_svc_rec.LIVING_STATUS_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Living Status is a required field.';
    elsif v_patient_prev_svc_rec.INCOME_CODE is null then
      v_status := 'FAILED';
      v_msg := 'Income is a required field.';
    else
      --Create patient_prev_svc_remark record
      update patient_prev_svc
      set marital_status_code = nvl(v_patient_prev_svc_rec.marital_status_code,marital_status_code)
        ,working_status_code = nvl(v_patient_prev_svc_rec.working_status_code,working_status_code)
        ,education_level_code = nvl(v_patient_prev_svc_rec.education_level_code,education_level_code)
        ,financial_status_code = nvl(v_patient_prev_svc_rec.financial_status_code,financial_status_code)
        ,living_status_code = nvl(v_patient_prev_svc_rec.living_status_code,living_status_code)
        ,income_code = nvl(v_patient_prev_svc_rec.income_code,income_code)
        ,HEIGHT_IN_IN = nvl(v_patient_prev_svc_rec.HEIGHT_IN_IN,HEIGHT_IN_IN)
        ,WEIGHT_IN_LB = nvl(v_patient_prev_svc_rec.WEIGHT_IN_LB,WEIGHT_IN_LB)
        ,HDL_CHOLESTEROL_IN_MG = nvl(v_patient_prev_svc_rec.HDL_CHOLESTEROL_IN_MG,HDL_CHOLESTEROL_IN_MG)
        ,LDL_CHOLESTEROL_IN_MG = nvl(v_patient_prev_svc_rec.LDL_CHOLESTEROL_IN_MG,LDL_CHOLESTEROL_IN_MG)
        ,SYSTOLIC_BP_IN_MM = nvl(v_patient_prev_svc_rec.SYSTOLIC_BP_IN_MM,SYSTOLIC_BP_IN_MM)
        ,DIASTOLIC_BP_IN_MM = nvl(v_patient_prev_svc_rec.DIASTOLIC_BP_IN_MM,DIASTOLIC_BP_IN_MM)
        ,BLOOD_SUGAR_LEVEL_IN_MG = nvl(v_patient_prev_svc_rec.BLOOD_SUGAR_LEVEL_IN_MG,BLOOD_SUGAR_LEVEL_IN_MG)
        ,SOURCE_OF_HISTORY_EMR_FLAG = nvl(v_patient_prev_svc_rec.SOURCE_OF_HISTORY_EMR_FLAG,'Y')
        ,SOURCE_OF_HISTORY_PATIENT_FLAG = nvl(v_patient_prev_svc_rec.SOURCE_OF_HISTORY_PATIENT_FLAG,'Y')
        ,SOURCE_OF_HISTORY_FAMILY_FLAG = nvl(v_patient_prev_svc_rec.SOURCE_OF_HISTORY_FAMILY_FLAG,SOURCE_OF_HISTORY_FAMILY_FLAG)
        ,PATIENT_ORIENTATION_CODE = nvl(v_patient_prev_svc_rec.PATIENT_ORIENTATION_CODE,'AO3')
      where patient_prev_svc_sn = v_patient_prev_svc_rec.patient_prev_svc_sn
      ;
      if p_email_addr is not null then
        update patient
        set email_addr = p_email_addr
        where patient_sn = (select patient_sn from patient_prev_svc where patient_prev_svc_sn = v_patient_prev_svc_rec.patient_prev_svc_sn)
        ;            
      end if;
      --
      if p_any_concern_txt is not null then v_any_concern_response := 'YES';
      else v_any_concern_response := 'NOO';
      end if;
      ---===============Question Data Response section=============================
      begin
        insert into patient_response (patient_response_sn,patient_prev_svc_sn,question_response_code,response_data) 
        values(patient_response_sng.nextval,v_patient_prev_svc_rec.patient_prev_svc_sn,common_inq_pkg.question_response_code('BDTEN','1001',v_any_concern_response),p_any_concern_txt);
      exception
        when dup_val_on_index then
          update patient_response
          set response_data = p_any_concern_txt
          where patient_prev_svc_sn = v_patient_prev_svc_rec.patient_prev_svc_sn
          and question_response_code = common_inq_pkg.question_response_code('BDTEN','1001',v_any_concern_response)
          ;
      end;
      ---===============Question Data Response section End=============================
      --
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'Patient Demographic Record Updated successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'Patient Demographic Record update failed.';
      end if;
      --
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
  end update_patient_prev_svc_demo;
  --
  procedure update_patient_prev_svc_remark(p_patient_prev_svc_remark_json in varchar2,p_patient_prev_svc_remark_sn in number,p_out out varchar2)
  is
    obj json := json();
    v_patient_prev_svc_remark_rec   patient_prev_svc_remark%rowtype;
  begin
    v_proc_name := upper('update_patient_prev_svc_remark');
    v_input_str := 'p_patient_prev_svc_remark_json: '||p_patient_prev_svc_remark_json||'-p_patient_prev_svc_remark_sn: '||p_patient_prev_svc_remark_sn;
    --Parse patient_prev_svc_remark record
    parse_json_pkg.patient_remark_parsing(p_patient_prev_svc_remark_json,v_patient_prev_svc_remark_rec);
    --Create patient_prev_svc_remark record
    update patient_prev_svc_remark
    set REMARK_NOTE = v_patient_prev_svc_remark_rec.REMARK_NOTE
    where patient_prev_svc_remark_sn = p_patient_prev_svc_remark_sn
    ;
    if sql%rowcount = 1 then
      v_status := 'SUCCESSFUL';
      v_msg := 'Service Remark Record updated successfully.';
    else
      v_status := 'FAILED';
      v_msg := 'Service Remark Record update failed.';
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
  end update_patient_prev_svc_remark;
  --
  --This proc is for question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR')
  procedure manage_patient_history(p_json in varchar2,p_patient_sn in number,p_question_categ_code in varchar2,p_user in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_history_rec   patient_history%rowtype;
    v_checkbox_only_categ_flag varchar2(1);
    v_empty_json_flag varchar2(1);
    v_question_categ_descr question_categ_lang.short_descr%type;
  begin
    v_proc_name := upper('manage_patient_history');
    v_input_str := 'p_json: '||p_json||'-p_patient_sn: '||p_patient_sn||'-p_question_categ_code: '||p_question_categ_code||'-p_user: '||p_user;
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    if p_json is null or p_patient_sn is null or p_question_categ_code is null or p_user is null then
      v_status := 'FAILED';
      v_msg := 'Required Input parameter is missing.';
    elsif p_question_categ_code not in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
      v_status := 'FAILED';
      v_msg := 'Allowed values for Input parameter p_question_categ_code are BMEDH,HSUR,HVACN,HVART and FHNMR.';
    else
      --derive question category descr to return during successful status
      select short_descr
      into v_question_categ_descr
      from question_categ_lang
      where question_categ_code = p_question_categ_code
      and lang_code = 'en'
      ;
      --
      v_patient_history_rec.created_by_user_role_id := mbr_inq_pkg.user_role_id_by_username(p_user);
      v_patient_history_rec.updated_by_user_role_id := v_patient_history_rec.created_by_user_role_id;
      --
      v_checkbox_only_categ_flag := checkbox_only_category_flag(p_question_categ_code);
      v_empty_json_flag := empty_json_flag(p_json);
      --
      --Empty json in a non checkbox category is an error
      if v_checkbox_only_categ_flag = 'N' and v_empty_json_flag = 'Y' then
        v_status := 'FAILED';
        v_msg := 'Submitted Question Category '||p_question_categ_code||' response is mendatory. Please choose all the responses before submitting.';
      else
        --first inactivate any active records. They will be updated again
        --patient_history_vw is only for active patient_history records
        for i in (select patient_history_sn
                  from patient_history_vw
                  where patient_sn = p_patient_sn
                  and category_code = p_question_categ_code
                  )
        loop
          update patient_history
          set active_flag = 'N'
             ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
          where patient_history_sn = i.patient_history_sn
          ;
        end loop;
        --start insert/update records
        --If json is empty then insert 1099 response, else enter appropriate response code
        if v_empty_json_flag = 'Y' then
          v_patient_history_rec.patient_sn := p_patient_sn;
          v_patient_history_rec.question_response_code := common_inq_pkg.categ_no_response_code(p_question_categ_code,'1099','CBX');
          --
          begin
            insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
            values (patient_history_sng.nextval,p_patient_sn,v_patient_history_rec.question_response_code,v_patient_history_rec.created_by_user_role_id,v_patient_history_rec.updated_by_user_role_id);
          exception
            when dup_val_on_index then
              update patient_history
              set active_flag = 'Y'
                 ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
              where patient_sn = p_patient_sn
              and question_response_code = v_patient_history_rec.question_response_code
              ;
          end;
        else
          for i in (select question_response_code from table(parse_json_pkg.patient_response(p_json)) where question_response_code <> '999999' and question_response_code is not null) loop
            v_patient_history_rec.question_response_code := i.question_response_code;
            v_patient_history_rec.patient_sn := p_patient_sn;
            --
            begin
              insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
              values (patient_history_sng.nextval,p_patient_sn,v_patient_history_rec.question_response_code,v_patient_history_rec.created_by_user_role_id,v_patient_history_rec.updated_by_user_role_id);
            exception
              when dup_val_on_index then
                update patient_history
                set active_flag = 'Y'
                   ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
                where patient_sn = p_patient_sn
                and question_response_code = v_patient_history_rec.question_response_code
                ;
            end;
          end loop;
        end if;
        --
        commit;
        v_status := 'SUCCESSFUL';
        v_msg := 'Patient '||v_question_categ_descr||' Record has been created successfully.';
      end if;
    end if;
    commit;
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
  end manage_patient_history;
  --
  procedure create_patient_response(p_patient_response_json in varchar2,p_question_categ_code in list_question_categ.question_categ_code%type,p_patient_prev_svc_sn in patient_prev_svc.patient_prev_svc_sn%type,p_out out clob)
  is
    obj json := json();
    v_patient_response_rec   patient_response%rowtype;
    v_patient_history_rec   patient_history%rowtype;
    v_response_question_categ_code list_question_categ.question_categ_code%type;
    v_actual_next_question_categ list_question_categ.question_categ_code%type;
    l_cnt pls_integer;
    v_question_categ_descr question_categ_lang.short_descr%type;
    v_checkbox_only_categ_flag varchar2(1);
    v_empty_json_flag varchar2(1);
    v_patient_sn number(11);
    v_physician_user_role_id provider_physician.physician_user_role_id%type;
  begin
    v_proc_name := upper('create_patient_response');
    v_input_str := 'p_patient_response_json: '||p_patient_response_json||'-p_question_categ_code: '||p_question_categ_code||'-p_patient_prev_svc_sn: '||p_patient_prev_svc_sn;
    --common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    --Check if the sequence of question_categ_code matches or no more categ to submit
    v_actual_next_question_categ := common_inq_pkg.final_next_question_categ(p_patient_prev_svc_sn);
    if v_actual_next_question_categ is null then
      v_status := 'FAILED';
      v_msg := 'No more questions to submit for this Patient Service. Patient should move to signature page.';
    else
      if v_actual_next_question_categ = p_question_categ_code then
        --derive question category descr to return during successful status
        select decode(question_categ_code,'HSLF2','HEALTH SELF-ASSESSMENT','MOOD1','MOOD DISORDER',short_descr) short_descr
        into v_question_categ_descr
        from question_categ_lang
        where question_categ_code = p_question_categ_code
        and lang_code = 'en'
        ;
        --Check if the response json is an empty json (e.g. {}, which can happen for checkbox only category where user have not selected any one)
        --for empty json, enter no answer question response code.
        --Also check if the json is not empty but response is null or 999999 which turns out to be null in the table function.
        --This happens when user select a value and then reset or unselect the value (e.g. {"1001":null,"1002":999999,"1003":null,"1004":null}). 
        --All the above scenario is only valid for the category whose response option is only checkbox. For non checkbox category, the json
        --can not be empty or null.
        --
        v_checkbox_only_categ_flag := checkbox_only_category_flag(p_question_categ_code);
        v_empty_json_flag := empty_json_flag(p_patient_response_json);
        --Empty json in a non checkbox category is an error
        if v_checkbox_only_categ_flag = 'N' and v_empty_json_flag = 'Y' then
          v_status := 'FAILED';
          v_msg := 'Submitted Question Category '||p_question_categ_code||' response is mendatory. Please choose all the responses before submitting.';
        else
          select pps.patient_sn
                ,pp.physician_user_role_id
          into v_patient_sn
              ,v_physician_user_role_id
          from patient_prev_svc pps
              ,provider_physician pp
          where pps.provider_physician_sn = pp.provider_physician_sn
          and pps.patient_prev_svc_sn = p_patient_prev_svc_sn
          ;
          v_patient_history_rec.created_by_user_role_id := v_physician_user_role_id;
          v_patient_history_rec.updated_by_user_role_id := v_patient_history_rec.created_by_user_role_id;
          --If json is empty then insert 1099 response, else enter appropriate response code
          if v_empty_json_flag = 'Y' then
            v_patient_response_rec.patient_prev_svc_sn := p_patient_prev_svc_sn;
            v_patient_response_rec.question_response_code := common_inq_pkg.categ_no_response_code(p_question_categ_code,'1099','CBX');
            if p_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
              --first inactivate any active records. They will be updated again
              --patient_history_vw is only for active patient_history records
              for i in (select patient_history_sn
                        from patient_history_vw
                        where patient_sn = v_patient_sn
                        and category_code = p_question_categ_code
                        )
              loop
                update patient_history
                set active_flag = 'N'
                   ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
                where patient_history_sn = i.patient_history_sn
                ;
              end loop;
              begin
                insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
                values (patient_history_sng.nextval,v_patient_sn,v_patient_response_rec.question_response_code,v_patient_history_rec.created_by_user_role_id,v_patient_history_rec.updated_by_user_role_id);
              exception
                when dup_val_on_index then
                  update patient_history
                  set active_flag = 'Y'
                     ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
                  where patient_sn = v_patient_sn
                  and question_response_code = v_patient_response_rec.question_response_code
                  ;
              end;
              --insert into patient_response also. This will act as AWV service progress indicator
              --this is key driver for the common_inq_pkg.patient_last_question_categ proc which decide the next category
              --no update. insert only
              common_dml_pkg.ins_patient_response(v_patient_response_rec);
            else
              --no update. insert only
              common_dml_pkg.ins_patient_response(v_patient_response_rec);
            end if;
            --
            commit;
            v_status := 'SUCCESSFUL';
            v_msg := 'Patient '||v_question_categ_descr||' Record has been created successfully.';
          else
            --Check if the input question categ code is same as response question_cated_code. Also check that respose have distinct one question categ code.
            --This comparison could not be done with the empty json since there is no response_code to derive category
            select distinct q.question_categ_code
            into v_response_question_categ_code
            from question_response qr
                ,table(parse_json_pkg.patient_response(p_patient_response_json)) tfnc
                ,question q
            where qr.question_response_code = tfnc.question_response_code
            and qr.question_sn = q.question_sn
            and tfnc.question_response_code <> '999999'
            and tfnc.question_response_code is not null
            ;
            if p_question_categ_code = v_response_question_categ_code then
              if p_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
                --first inactivate any active records. They will be updated again
                --patient_history_vw is only for active patient_history records
                for i in (select patient_history_sn
                          from patient_history_vw
                          where patient_sn = v_patient_sn
                          and category_code = p_question_categ_code
                          )
                loop
                  update patient_history
                  set active_flag = 'N'
                     ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
                  where patient_history_sn = i.patient_history_sn
                  ;
                end loop;
              end if;
              --Parse patient_response record
              for i in (select question_response_code from table(parse_json_pkg.patient_response(p_patient_response_json)) where question_response_code <> '999999' and question_response_code is not null) loop
                v_patient_response_rec.question_response_code := i.question_response_code;
                --Assign other required column value      
                v_patient_response_rec.patient_prev_svc_sn := p_patient_prev_svc_sn;
                --
                if p_question_categ_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR') then
                  begin
                    insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
                    values (patient_history_sng.nextval,v_patient_sn,v_patient_response_rec.question_response_code,v_patient_history_rec.created_by_user_role_id,v_patient_history_rec.updated_by_user_role_id);
                  exception
                    when dup_val_on_index then
                      update patient_history
                      set active_flag = 'Y'
                         ,updated_by_user_role_id = v_patient_history_rec.updated_by_user_role_id
                      where patient_sn = v_patient_sn
                      and question_response_code = v_patient_response_rec.question_response_code
                      ;                    
                  end;
                  --insert into patient_response also. This will act as AWV service progress indicator
                  --this is key driver for the common_inq_pkg.patient_last_question_categ proc which decide the next category
                  --no update. insert only
                  common_dml_pkg.ins_patient_response(v_patient_response_rec);                  
                else
                  --Create patient_response record
                  common_dml_pkg.ins_patient_response(v_patient_response_rec);
                end if;
              end loop;
              --
              commit;
              v_status := 'SUCCESSFUL';
              v_msg := 'Patient '||v_question_categ_descr||' Record has been created successfully.';
            else
              v_status := 'FAILED';
              v_msg := 'Patient Response Question Category does not match with Input Question Category.';
            end if;
          end if;
        end if;
      else
        v_status := 'FAILED';
        v_msg := 'Submitted Question Category '||p_question_categ_code||' is incorrect. Patient Next Question Category needs to be '||v_actual_next_question_categ;
      end if;
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
  end create_patient_response;
  --=============================================User Management transaction============================================================
  procedure update_user (p_user_role_id in "AspNetUserRoles".user_role_id%type,p_role_id in "AspNetRoles"."Id"%type,p_inactivate_user_flag in "AspNetUserRoles".active_flag%type, p_out out varchar2)
  is
    obj json := json();
    v_status varchar2(30);
  begin
    v_proc_name := upper('update_user');
    v_input_str := 'p_user_role_id: '||p_user_role_id||'-p_role_id: '||p_role_id||'-p_inactivate_user_flag: '||p_inactivate_user_flag;
    --
    if upper(p_inactivate_user_flag) = 'Y' then
      update "AspNetUserRoles"
      set active_flag = 'N'
      where user_role_id = p_user_role_id
      ;
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'User Record has been inactivated successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'User Record inactivation failed. Please contact support.';
      end if;
    else
      update "AspNetUserRoles"
      set "RoleId" = p_role_id
          ,active_flag = 'Y'
      where user_role_id = p_user_role_id
      ;
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'User Role has been updated successfully';
      else
        v_status := 'FAILED';
        v_msg := 'User Role update failed. Please contact support.';
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
  end update_user;
  --
  procedure manage_role_priviledge (p_role_id in "AspNetRoles"."Id"%type,p_priviledge_code in roles_priviledge.priviledge_code%type, p_priviledge_remove_flag in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_status varchar2(30);
  begin
    v_proc_name := upper('manage_role_priviledge');
    v_input_str := 'p_role_id: '||p_role_id||'-p_priviledge_code: '||p_priviledge_code||'-p_priviledge_remove_flag: '||p_priviledge_remove_flag;
    --
    if upper(p_priviledge_remove_flag) = 'Y' then
      update roles_priviledge
      set active_flag = 'N'
      where role_id = p_role_id
      and priviledge_code = p_priviledge_code
      ;
      if sql%rowcount = 1 then
        v_status := 'SUCCESSFUL';
        v_msg := 'Role Priviledge has been inactivated successfully.';
      else
        v_status := 'FAILED';
        v_msg := 'Role Priviledge inactivation failed. The priviledge '||p_priviledge_code||' does not belong to this Role.';
      end if;
    else
      begin
        insert into roles_priviledge (roles_priviledge_sn,role_id,priviledge_code) values (roles_priviledge_sng.nextval,p_role_id,p_priviledge_code);
        v_status := 'SUCCESSFUL';
        v_msg := 'Role Priviledge has been created successfully';
      exception
        when dup_val_on_index then
          --Record exist and just make it active
          update roles_priviledge
          set active_flag = 'Y'
          where role_id = p_role_id
          and priviledge_code = p_priviledge_code
          ;
          if sql%rowcount = 1 then
            v_status := 'SUCCESSFUL';
            v_msg := 'Role Priviledge has been updated successfully';
          else
            v_status := 'FAILED';
            v_msg := 'Role Priviledge update failed. Please contact support.';
          end if;
      end;
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
  end manage_role_priviledge;
  --
  procedure create_physician_em(p_physician_em_json in varchar2,p_patient_signature in clob,p_physician_signature in clob,p_out out varchar2)
  is
    obj json := json();
    v_physician_em_rec        physician_em%rowtype;
    v_patient_sn patient.patient_sn%type;
    v_patient_prev_svc_sn patient_prev_svc.patient_prev_svc_sn%type;
  begin
    v_proc_name := upper('create_physician_em');
    v_input_str := 'p_physician_em_json: '||p_physician_em_json||'-p_patient_signature:'||p_patient_signature||'-p_physician_signature:'||p_physician_signature;
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    if nvl(p_patient_signature,v_em_empty_signature) <> v_em_empty_signature and nvl(p_physician_signature,v_em_empty_signature) <> v_em_empty_signature then
      --Parse p_physician_em_json
      parse_json_pkg.physician_em_parsing(p_physician_em_json,v_physician_em_rec);
      v_patient_prev_svc_sn := v_physician_em_rec.patient_prev_svc_sn;
      v_physician_em_rec.physician_SIGNATURE := p_physician_signature;
      common_dml_pkg.ins_physician_em(v_physician_em_rec);
      --
      --Call the generic service completion proc which will also COMMIT the records in the database
      svc_completion(v_patient_prev_svc_sn,p_patient_signature,null,null,v_status,v_msg,v_patient_sn);
      --
      eev_rpt_json_clob (v_patient_prev_svc_sn);
      --
      obj.put('STATUS',v_status);
      obj.put('MSG',v_msg);
      p_out := obj.to_char;
    else
      obj.put('STATUS','FAILED');
      obj.put('MSG','Please submit both patient and physician signature');
      p_out := obj.to_char;
    end if;
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
  end create_physician_em;
  --
  procedure create_provider_ccm(p_provider_ccm_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_provider_ccm_rec        provider_ccm%rowtype;
    v_patient_sn patient.patient_sn%type;
    v_patient_prev_svc_sn patient_prev_svc.patient_prev_svc_sn%type;
  begin
    v_proc_name := upper('create_provider_ccm');
    v_input_str := 'p_provider_ccm_json: '||p_provider_ccm_json;
    --Parse p_provider_ccm_json
    parse_json_pkg.provider_ccm_parsing(p_provider_ccm_json,v_provider_ccm_rec);
    v_patient_prev_svc_sn := v_provider_ccm_rec.patient_prev_svc_sn;
    common_dml_pkg.ins_provider_ccm(v_provider_ccm_rec);
    --Call the generic service completion proc which will also COMMIT the records in the database
    svc_completion(v_patient_prev_svc_sn,null,null,null,v_status,v_msg,v_patient_sn);
    --
    cev_rpt_json_clob(v_patient_prev_svc_sn);
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
  end create_provider_ccm;
  --
  procedure create_em_sched_after_awv(p_em_sched_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_patient_prev_svc_rec        patient_prev_svc%rowtype;
  begin
    v_proc_name := upper('create_em_sched_after_awv');
    v_input_str := 'p_em_sched_json: '||p_em_sched_json;
    --Parse p_provider_ccm_json
    parse_json_pkg.physician_em_schedule_parsing(p_em_sched_json,v_patient_prev_svc_rec);
    --
    update patient_prev_svc
    set  request_em_perf_by_pcp_flag = nvl(v_patient_prev_svc_rec.request_em_perf_by_pcp_flag,'N')
        ,em_followup_svc_date = v_patient_prev_svc_rec.em_followup_svc_date
        ,em_followup_svc_hr_code = v_patient_prev_svc_rec.em_followup_svc_hr_code
        ,em_followup_svc_min_code = v_patient_prev_svc_rec.em_followup_svc_min_code
        ,em_followup_svc_am_pm_code = v_patient_prev_svc_rec.em_followup_svc_am_pm_code
        ,comment_when_deny_em = v_patient_prev_svc_rec.comment_when_deny_em
    where patient_prev_svc_sn = v_patient_prev_svc_rec.patient_prev_svc_sn
    ;
    --
    if sql%rowcount = 1 then
      v_status := 'SUCCESSFUL';
      if common_inq_pkg.patient_qualify_for_em_flag(v_patient_prev_svc_rec.patient_prev_svc_sn) = 'Y' then
        if v_patient_prev_svc_rec.request_em_perf_by_pcp_flag = 'Y' then
          v_msg := 'We will contact with your PCP to schedule your EM Service. We will notify you once the scheduling is successful.';
        elsif v_patient_prev_svc_rec.comment_when_deny_em is not null then
          v_msg := 'Your Annual Wellness Visit Service completed successfully.';
        else
          v_msg := 'EM Service has been scheduled successfully.';
        end if;
      else --don't qualify for EM and no scheduling needed
        v_msg := 'Your Annual Wellness Visit Service completed successfully.';
      end if;
    else
      v_status := 'FAILED';

      if common_inq_pkg.patient_qualify_for_em_flag(v_patient_prev_svc_rec.patient_prev_svc_sn) = 'Y' then
        v_msg := 'EM Service scheduling failed. Please contact customer support.';
      else
        v_msg := 'Annual Wellness Visit Service final confirmation failed. Please contact customer support.';
      end if;
      --log the message
      v_err_msg := v_msg;
      common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
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
  end create_em_sched_after_awv;
  --
  procedure create_contact_us(p_contact_us_json in varchar2,p_out out varchar2)
  is
    obj json := json();
    v_contact_us_rec        contact_us%rowtype;
  begin
    v_proc_name := upper('create_contact_us');
    v_input_str := 'p_contact_us_json: '||p_contact_us_json;
    --Parse p_contact_us_json
    parse_json_pkg.contact_us_parsing(p_contact_us_json,v_contact_us_rec);
    common_dml_pkg.ins_contact_us(v_contact_us_rec);
    --
    obj.put('STATUS','SUCCESSFUL');
    obj.put('MSG','We have received your information. Someone will contact you shortly.');
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
  end create_contact_us;
END mdtech_trans_pkg;
/
show errors