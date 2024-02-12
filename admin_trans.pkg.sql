CREATE OR REPLACE PACKAGE admin_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('admin_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  g_key "AspNetUserRoles".user_role_id%type := '5F62E689C3C542DBB4FF01F003D8D827';
  --
  function json_str (p_str varchar2) return nvarchar2;
  --
  PROCEDURE upd_active_flag (p_culture  IN trans_lang.culture%TYPE
                               ,p_name  IN trans_lang.name%TYPE
                               ,p_active_flag   IN trans_lang.active_flag%TYPE);
END admin_trans_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY admin_trans_pkg IS
  function json_str (p_str varchar2) return nvarchar2 is
    --new bank
    v_str1 nvarchar2(32767) := '{
                    "CONTROL_NAME" : "DB PWD 22"
                    ,"USER_ID" : "Hello@gmail.com"
                    ,"PWD" : "HeWqq12&^%$#"
                    ,"EMAIL_ADDR" : "hello@gmail.com"
                    ,"WEBSITE_ADDR" : null
                    ,"ACCT_NUM" : null
                    ,"ACCT_TYPE" : null
                    ,"ACCT_HOLDER_NAME" : null
                    ,"ACCT_EXP_MONTH" : null
                    ,"ACCT_EXP_YEAR" : null
                    ,"ACCT_CCV_NUM" : null
                    ,"BILLING_ADDR_1" : null
                    ,"BILLING_ADDR_2" : null
                    ,"BILLING_CITY" : null
                    ,"BILLING_STATE" : null
                    ,"BILLING_ZIP" : null
                    ,"IP_ADDR" : null
                    ,"DOMAIN_NAME" : null
                    ,"NOTES" : "TEST notes Hello.."
                    }';
  begin
    if p_str = 'p_pamdas_vault_info' then
      return v_str1;
    end if;
  end json_str;
  --
  PROCEDURE upd_active_flag (p_culture  IN trans_lang.culture%TYPE
                               ,p_name  IN trans_lang.name%TYPE
                               ,p_active_flag   IN trans_lang.active_flag%TYPE)
  IS
  
  BEGIN
    update trans_lang
       set active_flag = p_active_flag
     where culture = p_culture
       and name = p_name
       and active_flag <> p_active_flag
    ;
    commit;
  END upd_active_flag;
END admin_trans_pkg;
/
SHOW ERRORS
