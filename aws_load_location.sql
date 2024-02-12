set serveroutput on format wrapped
declare
  v_out clob;
begin
  loc_trans_pkg.load_LIST_ERROR_SEVERITY;
  loc_trans_pkg.load_list_lang;
  loc_trans_pkg.load_OAuth_Clients;
  loc_trans_pkg.load_COUNTRY;
  loc_trans_pkg.load_STATE;
  delete from APPLICATION_PROCESS_LOG;  commit;
  loc_trans_pkg.load_application_control;
  loc_trans_pkg.load_LIST_ADDR_TYPE;
  loc_trans_pkg.load_list_file_type;
  --
  loc_trans_pkg.load_APPLICATION_ERROR_MSG;
  loc_trans_pkg.load_APPLICATION_EM_LANG;
  --
  loc_trans_pkg.load_LIST_MONTH;
  loc_trans_pkg.load_LIST_YEAR;
  loc_trans_pkg.load_LIST_MONTH_LANG;
  loc_trans_pkg.load_calendar;
  loc_trans_pkg.load_appsnetroles;
  loc_trans_pkg.load_LIST_APPL_FUNCTIONALITY;
  loc_trans_pkg.load_TRANS_LANG;
  --
  --common_trans_pkg.load_control_data;
end;
/