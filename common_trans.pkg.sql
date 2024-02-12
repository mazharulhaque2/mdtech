CREATE OR REPLACE PACKAGE common_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('common_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  --
  PROCEDURE load_control_data;
END common_trans_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY common_trans_pkg IS
  PROCEDURE load_control_data as
  begin
    common_inq_pkg.load_common_info_json('en','AWV');
    --common_inq_pkg.load_common_info_json('en','CCM');
    --qnr_inq_pkg.load_g0438_json('en');
  end load_control_data;
END common_trans_pkg;
/
SHOW ERRORS
