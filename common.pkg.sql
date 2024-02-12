create or replace PACKAGE common_pkg
IS
   g_key constant "AspNetUserRoles".user_role_id%type := '5F62E689C3C542DBB4FF01F003D8D827';
   --
   FUNCTION record_status (p_eff_date     IN DATE,p_inactive_date IN DATE) RETURN VARCHAR2;
   FUNCTION appl_last_run_tmstmp (p_application_name IN application_control.application_name%TYPE) RETURN application_control.last_run_tmstmp%TYPE;
   FUNCTION appl_control_value_alpha (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE) RETURN application_control_value.control_value_alpha%TYPE;     
   FUNCTION appl_control_value_clob (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE) RETURN application_control_value.control_value_clob%TYPE;      
   FUNCTION appl_control_value_date (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE) RETURN application_control_value.control_value_date%TYPE;
   FUNCTION appl_control_value_number (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE) RETURN application_control_value.control_value_number%TYPE;
   FUNCTION appl_control_value_timestamp (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE) RETURN application_control_value.control_value_timestamp%TYPE;
   FUNCTION appl_cntl_value_lst_run_tmstmp (p_application_name IN application_control.application_name%TYPE,p_control_value IN application_control_value.control_value_name%TYPE) RETURN application_control_value.last_run_tmstmp%TYPE;
   PRAGMA RESTRICT_REFERENCES (appl_cntl_value_lst_run_tmstmp,WNDS,WNPS,RNDS,RNPS,trust);
   PROCEDURE upd_appl_control_value_alpha (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE,p_new_alpha_value IN application_control_value.control_value_alpha%TYPE);
   --                                          
   PROCEDURE upd_appl_control_value_clob (p_application_name IN application_control.application_name%TYPE,p_control_value_name IN application_control_value.control_value_name%TYPE,p_new_clob_value IN application_control_value.control_value_clob%TYPE);
   PROCEDURE update_appl_last_run_tmstmp (p_application_name IN application_control.application_name%TYPE,p_run_tmstmp   IN application_control.last_run_tmstmp%TYPE);
   PROCEDURE ins_appl_process_log (p_package_name  VARCHAR2,p_proc_name VARCHAR2,p_err_severity_code CHAR,p_err_msg VARCHAR2,p_notes  VARCHAR2,p_input_clob clob default null,p_input_blob    blob default null);
   PROCEDURE turn_on_hist_prc (p_table_name   IN appl_hist_table.name%TYPE,p_col_name     IN appl_hist_col.col_name%TYPE,p_data_type    IN VARCHAR2,p_hist_flag    IN VARCHAR2 DEFAULT 'Y');
   --    
   FUNCTION check_valid_date (p_date IN VARCHAR2)  RETURN VARCHAR2;
   FUNCTION is_a_valid_number (p_num IN VARCHAR2) RETURN varchar2;
   FUNCTION string_to_table_num (p VARCHAR2) RETURN tab_number PIPELINED;
   PROCEDURE check_valid_date_and_age (p_date IN VARCHAR2,p_out out VARCHAR2);
   --                                      
   PROCEDURE get_user(p_username IN NVARCHAR2,p_password IN NVARCHAR2,p_out  OUT SYS_REFCURSOR); 
   function get_random_num_15 return varchar2;
   function get_random_vc_15 return varchar2;
   function get_random_alphanum_15 return varchar2;
   --
   procedure get_random_num_15 (p_out out varchar2);
   procedure get_random_vc_15 (p_out out varchar2);
   procedure get_random_alphanum_15 (p_out out varchar2);
   --
   FUNCTION appl_error_msg (p_APPLICATION_ERROR_MSG_CODE in APPLICATION_ERROR_MSG.APPLICATION_ERROR_MSG_CODE%type,p_application_code IN list_application.application_code%TYPE default 'CNST',p_lang_code IN list_lang.lang_code%type default 'en') RETURN APPLICATION_ERROR_MSG_LANG.descr%TYPE;
  --
  function get_enc_val  (p_in in nvarchar2,p_key in raw default g_key) return raw;
  function get_dec_val (p_in in raw,p_key in raw default g_key) return nvarchar2;
  --
  PROCEDURE extract_file(p_file in blob,p_file_name in varchar2,p_file_directory varchar2 default 'EXT_FILE_IMAGE');
  PROCEDURE extract_file(p_file in out nocopy clob,p_file_name in varchar2,p_file_directory varchar2 default 'EXT_FILE_IMAGE');
  FUNCTION base64encode(p_blob IN BLOB) RETURN CLOB;
  FUNCTION base64decode(p_clob IN CLOB) RETURN BLOB;
  function get_g_key return raw;
  function password_generator(p_pwd_length in number,p_pwd_key in varchar2) return varchar2;
  -- Public types
  TYPE t_split_array IS TABLE OF VARCHAR2(32767);
  --
  FUNCTION split_text (p_text       IN  CLOB,p_delimeter  IN  VARCHAR2 DEFAULT ',') RETURN t_split_array;
  procedure print_clob (p_clob in clob);
  --
  function return_img_data_url  (p_img in blob,p_mime in varchar2) return varchar2;
  function return_file_type (p_file_name in varchar2) return varchar2;
  --
  function return_integer_of_a_num (p_number in varchar2) return number; 
  function return_decimal_of_a_num (p_number in varchar2) return number;
  function return_file_content_type (p_file_name in varchar2) return varchar2;
  function age (p_birth_date in date) return number;
  function age_at_a_date (p_birth_date in date,p_date in date) return number;
  function bmi (p_weight_in_lb in number,p_height_in_in in number) return number;
  function bmi_result (p_bmi in number) return varchar2;
  function height_in_feet (p_height_in_in in number) return varchar2;
  function height_in_inch (p_height_in_feet in varchar2) return number;
  function bp_reading (p_sys_bp_in_mm in number,p_dia_bp_in_mm in number) return varchar2;
  function locale_lang_code (p_locale in varchar2) return varchar2;
  function locale_country_code (p_locale in varchar2) return varchar2;
  function first_specific_day_of_month (p_year in varchar2,p_month in varchar2,p_day in varchar2) return date;
  function last_specific_day_of_month (p_year in varchar2,p_month in varchar2,p_day in varchar2) return date;
  function us_holiday_date (p_year in varchar2,p_holiday in varchar2) return date;
  function us_holiday (p_year in varchar2,p_holiday_json_array in json_list) return t_holiday_cal_tab PIPELINED;
  function working_date (p_date in date) return date;
END common_pkg;
/
show errors
create or replace PACKAGE BODY common_pkg
IS
  --will return FIRST Thursday, Monday of any specific day of a month
  function first_specific_day_of_month (p_year in varchar2,p_month in varchar2,p_day in varchar2) return date
  is
    v_date1 date;
    v_date2 date;
  begin
    v_date1 := to_date(p_year||p_month||'01','YYYYMMDD');
    if p_day = 'MON' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 2;
      end if;
    elsif p_day = 'TUE' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 3;
      end if;
    elsif p_day = 'WED' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 4;
      end if;
    elsif p_day = 'THU' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 5;
      end if;
    elsif p_day = 'FRI' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 6;
      end if;
    elsif p_day = 'SAT' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 1;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 0;
      end if;
    elsif p_day = 'SUN' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 + 0;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 + 6;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 + 5;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 + 4;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 + 3;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 + 2;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 + 1;
      end if;
    end if;
    return v_date2;
  end first_specific_day_of_month;
  --
  --will return LAST Thursday, Monday of any specific day of a month
  function last_specific_day_of_month (p_year in varchar2,p_month in varchar2,p_day in varchar2) return date
  is
    v_date1 date;
    v_date2 date;
  begin
    v_date1 := last_day(to_date(p_year||p_month||'01','YYYYMMDD'));
    if p_day = 'MON' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 5;
      end if;
    elsif p_day = 'TUE' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 4;
      end if;
    elsif p_day = 'WED' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 3;
      end if;
    elsif p_day = 'THU' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 2;
      end if;
    elsif p_day = 'FRI' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 1;
      end if;
    elsif p_day = 'SAT' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 6;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 0;
      end if;
    elsif p_day = 'SUN' then
      if to_char(v_date1,'D') = 1 then v_date2 := v_date1 - 0;
      elsif to_char(v_date1,'D') = 2 then v_date2 := v_date1 - 1;
      elsif to_char(v_date1,'D') = 3 then v_date2 := v_date1 - 2;
      elsif to_char(v_date1,'D') = 4 then v_date2 := v_date1 - 3;
      elsif to_char(v_date1,'D') = 5 then v_date2 := v_date1 - 4;
      elsif to_char(v_date1,'D') = 6 then v_date2 := v_date1 - 5;
      elsif to_char(v_date1,'D') = 7 then v_date2 := v_date1 - 6;
      end if;
    end if;
    return v_date2;
  end last_specific_day_of_month;
  --
  function us_holiday_date (p_year in varchar2,p_holiday in varchar2) return date
  is
  begin
    if p_holiday = 'NYEAR' then
      return to_date(p_year||'0101','YYYYMMDD');
    elsif p_holiday = 'MLKNG' then
      --3rd Monday of Jan
      return first_specific_day_of_month(p_year,'01','MON') + 14;
    elsif p_holiday = 'PRESI' then
      --3rd Monday of Feb
      return first_specific_day_of_month(p_year,'02','MON') + 14;
    elsif p_holiday = 'MEMOR' then
      --Last Monday of May
      return last_specific_day_of_month(p_year,'05','MON');
    elsif p_holiday = 'INDPN' then
      return to_date(p_year||'0704','YYYYMMDD');
    elsif p_holiday = 'LABOR' then
      --1st Monday of Sep
      return first_specific_day_of_month(p_year,'09','MON');
    elsif p_holiday = 'COLUM' then
      --2nd Monday of Oct
      return first_specific_day_of_month(p_year,'10','MON') + 7;
    elsif p_holiday = 'VETER' then
      return to_date(p_year||'1111','YYYYMMDD');
    elsif p_holiday = 'THANK' then
      --4th Thursday of Nov
      return first_specific_day_of_month(p_year,'11','THU') + 21;
    elsif p_holiday = 'CHRIS' then
      return to_date(p_year||'1225','YYYYMMDD');
    elsif p_holiday = 'NYEVE' then
      return to_date(p_year||'1231','YYYYMMDD');
    else return null;
    end if;
  end us_holiday_date;
  --
  function us_holiday (p_year in varchar2,p_holiday_json_array in json_list) return t_holiday_cal_tab PIPELINED
  is
    l_row t_holiday_cal_obj := t_holiday_cal_obj(null,null,null,null,null);
    v_holiday varchar2(5);
    v_holiday_json_array json_list;
  begin
    if p_holiday_json_array is null then
      v_holiday_json_array := json_list('["NYEAR","MLKNG","PRESI","MEMOR","INDPN","LABOR","COLUM","VETER","THANK","CHRIS","NYEVE"]');
    else
      v_holiday_json_array := p_holiday_json_array;
    end if;
    for i in 1..json_ac.array_count(v_holiday_json_array) loop
      v_holiday := json_ac.array_get(v_holiday_json_array,i).get_string;
      if v_holiday = 'NYEAR' then
        l_row.holiday_code := 'NYEAR';
        l_row.holiday_name := 'New Year''s Day';
        l_row.holiday_date := us_holiday_date(p_year,'NYEAR');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'NYEAR'),'DY');
        l_row.holiday_rule := 'First Day of the Year';
        PIPE ROW (l_row);
      elsif v_holiday = 'MLKNG' then
        l_row.holiday_code := 'MLKNG';
        l_row.holiday_name := 'Martin Luther King Day';
        l_row.holiday_date := us_holiday_date(p_year,'MLKNG');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'MLKNG'),'DY');
        l_row.holiday_rule := '3rd Monday of Jan';
        PIPE ROW (l_row);
      elsif v_holiday = 'PRESI' then
        l_row.holiday_code := 'PRESI';
        l_row.holiday_name := 'Presidents'' Day';
        l_row.holiday_date := us_holiday_date(p_year,'PRESI');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'PRESI'),'DY');
        l_row.holiday_rule := '3rd Monday of Feb';
        PIPE ROW (l_row);
      elsif v_holiday = 'MEMOR' then
        l_row.holiday_code := 'MEMOR';
        l_row.holiday_name := 'Memorial Day';
        l_row.holiday_date := us_holiday_date(p_year,'MEMOR');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'MEMOR'),'DY');
        l_row.holiday_rule := 'Last Monday of May';
        PIPE ROW (l_row);
      elsif v_holiday = 'INDPN' then
        l_row.holiday_code := 'INDPN';
        l_row.holiday_name := 'Independence Day';
        l_row.holiday_date := us_holiday_date(p_year,'INDPN');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'INDPN'),'DY');
        l_row.holiday_rule := 'July 4th';
        PIPE ROW (l_row);
      elsif v_holiday = 'LABOR' then
        l_row.holiday_code := 'LABOR';
        l_row.holiday_name := 'Labor Day';
        l_row.holiday_date := us_holiday_date(p_year,'LABOR');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'LABOR'),'DY');
        l_row.holiday_rule := '1st Monday of Sep';
        PIPE ROW (l_row);
      elsif v_holiday = 'COLUM' then
        l_row.holiday_code := 'COLUM';
        l_row.holiday_name := 'Columbus Day';
        l_row.holiday_date := us_holiday_date(p_year,'COLUM');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'COLUM'),'DY');
        l_row.holiday_rule := '2nd Monday of Oct';
        PIPE ROW (l_row);
      elsif v_holiday = 'VETER' then
        l_row.holiday_code := 'VETER';
        l_row.holiday_name := 'Veterans Day';
        l_row.holiday_date := us_holiday_date(p_year,'VETER');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'VETER'),'DY');
        l_row.holiday_rule := 'Nov 11';
        PIPE ROW (l_row);
      elsif v_holiday = 'THANK' then
        l_row.holiday_code := 'THANK';
        l_row.holiday_name := 'Thanksgiving Day';
        l_row.holiday_date := us_holiday_date(p_year,'THANK');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'THANK'),'DY');
        l_row.holiday_rule := '4th Thursday of Nov';
        PIPE ROW (l_row);
      elsif v_holiday = 'CHRIS' then
        l_row.holiday_code := 'CHRIS';
        l_row.holiday_name := 'Christmas Day';
        l_row.holiday_date := us_holiday_date(p_year,'CHRIS');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'CHRIS'),'DY');
        l_row.holiday_rule := 'Dec 25th';
        PIPE ROW (l_row);
      elsif v_holiday = 'NYEVE' then
        l_row.holiday_code := 'NYEVE';
        l_row.holiday_name := 'New Year''s Eve';
        l_row.holiday_date := us_holiday_date(p_year,'NYEVE');
        l_row.holiday_day := to_char(us_holiday_date(p_year,'NYEVE'),'DY');
        l_row.holiday_rule := 'Last Day of the Year';
        PIPE ROW (l_row);
      end if;
    end loop;
  end us_holiday;
  --Weekdays excluding holidays
  --Needs to be evaluated for new holidays
  function working_date (p_date in date) return date
  is
    v_date date;
    v_yyyy varchar2(4);
    v_mm varchar2(2);
    v_d number(1);
    v_return_date date;
    --v_holiday_json_list json_list := json_list('["NYEAR","MLKNG","PRESI","MEMOR","INDPN","LABOR","THANK","CHRIS","NYEVE"]');
  begin
    if to_char(p_date,'D') = 7 then
      --Monday D = 2
      v_date := p_date + 2;
    elsif to_char(p_date,'D') = 1 then
      --Monday D = 2
      v_date := p_date + 1;
    else
      ----Monday to Friday. D between 2 and 6
      v_date := p_date;
    end if;
    --
    --Evaluate if there is any holiday in the week days
    --
    v_yyyy := to_char(v_date,'YYYY');
    v_mm := to_char(v_date,'MM');
    v_d := to_char(v_date,'D');
    --Monday only holidays
    if v_date in (us_holiday_date(v_yyyy,'MLKNG'),us_holiday_date(v_yyyy,'PRESI'),us_holiday_date(v_yyyy,'MEMOR'),us_holiday_date(v_yyyy,'LABOR')) then
      v_return_date := v_date + 1; --Tue
    --Holidays could fall in any weekdays
    elsif v_date in (us_holiday_date(v_yyyy,'NYEAR'),us_holiday_date(v_yyyy,'INDPN'),us_holiday_date(v_yyyy,'CHRIS')) then
      if v_d = 6 then --Fri
        v_return_date := v_date + 3; --Mon
      else --Mon to Thu
        v_return_date := v_date + 1; --Tue to Fri
      end if;
    --Holidays could fall in any weekdays and next day is a holiday also
    elsif v_date = us_holiday_date(v_yyyy,'NYEVE') then --skip NYEAR also
      if v_d = 6 then --Fri
        v_return_date := v_date + 3; --Mon
      elsif v_d in (2,3,4) then--Mon to Wed
        v_return_date := v_date + 2; --Wed to Fri
      else --Thu
        v_return_date := v_date + 4; --Mon
      end if;
    --Thursday only holiday
    elsif v_date = us_holiday_date(v_yyyy,'THANK') then
      v_return_date := v_date + 1; --Fri
    else
      v_return_date := v_date;
    end if;
    return v_return_date;
  end working_date;
  --
  function bp_reading (p_sys_bp_in_mm in number,p_dia_bp_in_mm in number) return varchar2
  is
  begin
    if p_sys_bp_in_mm < 120 and  p_dia_bp_in_mm < 80 then return 'Normal';
    elsif (p_sys_bp_in_mm between 120 and 139) or (p_dia_bp_in_mm between 80 and 89) then return 'Prehypertension';
    elsif p_sys_bp_in_mm >= 140 or p_dia_bp_in_mm >= 90 then return 'Hypertension';
    else return 'Abnormal';
    end if;
  end bp_reading;
  --
  function locale_lang_code (p_locale in varchar2) return varchar2
  is
    v_lang_code varchar2(2);
    v_pos pls_integer;
  begin
    --typical input is en-US
    v_pos := instr(p_locale,'-',1,1);
    if v_pos = 0 then --input is just lang_code (en)
      v_lang_code := lower(substr(p_locale,1,2));
    else
      v_lang_code := lower(substr(p_locale,1,v_pos-1));
    end if;
    return v_lang_code;
  exception
    when others then return null;
  end locale_lang_code;
  --
  function locale_country_code (p_locale in varchar2) return varchar2
  is
    v_country_code varchar2(2);
    v_pos pls_integer;
  begin
    --typical input is en-US
    v_pos := instr(p_locale,'-',1,1);
    if v_pos = 0 then --input is just lang_code (en)
      v_country_code := null;
    else
      v_country_code := upper(substr(p_locale,v_pos+1));
    end if;
    return v_country_code;
  exception
    when others then return null;
  end locale_country_code;
  --
  function return_file_content_type (p_file_name in varchar2) return varchar2
  is
    v_file_content_type list_file_type.file_content_type%type;
  begin
    select file_content_type
    into v_file_content_type
    from list_file_type
    where file_type_code = common_pkg.return_file_type(p_file_name)
    ;
    return v_file_content_type;
  exception
    when others then return null;
  end return_file_content_type;
  --
  function return_file_type (p_file_name in varchar2) return varchar2
  is
  begin
    return upper(substr(p_file_name,instr(p_file_name,'.',-1,1)+1));
  end return_file_type;
  --
  function return_img_data_url  (p_img in blob
                                ,p_mime in varchar2 --'image/png'
                                ) return varchar2
  is
    v_img_data_url varchar2(32767);
  begin
    if p_img is not null then
      v_img_data_url := 'data:'||p_mime||';base64,'||dbms_lob.substr( common_pkg.base64encode(p_img), 32767, 1 );
    end if;
    return v_img_data_url;
  end return_img_data_url;
  --
  PROCEDURE print_clob (p_clob IN CLOB) IS
    l_offset NUMBER := 1;
    l_chunk  NUMBER := 32767;
  BEGIN
    LOOP
      EXIT WHEN l_offset > DBMS_LOB.getlength(p_clob);
      DBMS_OUTPUT.put_line(DBMS_LOB.substr(p_clob, l_chunk, l_offset));
      l_offset := l_offset + l_chunk;
    END LOOP;
  END print_clob;
  --
  FUNCTION split_text (p_text       IN  CLOB,
                     p_delimeter  IN  VARCHAR2 DEFAULT ',')
    RETURN t_split_array IS
  -- ----------------------------------------------------------------------------
    l_array  t_split_array   := t_split_array();
    l_text   CLOB := p_text;
    l_idx    NUMBER;
  BEGIN
    l_array.delete;

    IF l_text IS NULL THEN
      RAISE_APPLICATION_ERROR(-20000, 'P_TEXT parameter cannot be NULL');
    END IF;

    WHILE l_text IS NOT NULL LOOP
      l_idx := INSTR(l_text, p_delimeter);
      l_array.extend;
      IF l_idx > 0 THEN
        l_array(l_array.last) := SUBSTR(l_text, 1, l_idx - 1);
        l_text := SUBSTR(l_text, l_idx + 1);
      ELSE
        l_array(l_array.last) := l_text;
        l_text := NULL;
      END IF;
    END LOOP;
    RETURN l_array;
  END split_text;
  --
  function password_generator(p_pwd_length in number
                             ,p_pwd_key in varchar2)
                             return varchar2
  is
    v_pwd_key varchar2(50);
    v_return varchar2(50);
  begin
    if p_pwd_key is not null then
      v_pwd_key := upper(p_pwd_key);
    else
      v_pwd_key := upper('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    end if;
    --
    for v_Cur in ( 
    WITH charac_classes AS
    (       /* Character classes */
              SELECT  '0123456789'                            AS NUMCHR
              ,       LOWER(v_pwd_key)     AS LOWCHR
              ,       v_pwd_key            AS UPPERCHR
              ,       '!#$%^*:;,.'                            AS SPECCHR
              FROM    DUAL
      ),      randomstring AS
    (       /* Generate a random character string making up the WHOLE set in RANDOM order*/
           SELECT  MAX(REVERSE
                   (
                           REPLACE
                           (       SYS_CONNECT_BY_PATH
                                   (
                                           INDV_CHARS
                                   ,       '/'             /* Something not in special character string */
                                   )
                           ,       '/'
                           ,       ''
                           )
                   )) AS RANSTRING
           FROM
           (
                   SELECT  SUBSTR
                           (
                                   NUMCHR||LOWCHR||UPPERCHR||SPECCHR
                           ,       LEVEL
                           ,       1
                           ) AS INDV_CHARS
                   ,       ROW_NUMBER() OVER (ORDER BY DBMS_RANDOM.VALUE) RN
                   FROM    charac_classes
                   CONNECT BY LEVEL <= LENGTH(NUMCHR||LOWCHR||UPPERCHR||SPECCHR)
                   ORDER BY DBMS_RANDOM.VALUE
           )
           WHERE   CONNECT_BY_ISLEAF=1
           CONNECT BY PRIOR RN + 1 = RN
   ),      strchars AS
   (       /* Generate a partial password string that
            * will guarantee your string contains at least your password requirements
            */
           SELECT  p_pwd_length      AS PASSWORD_LENGTH
           ,       SUBSTR
                   (
                           UPPERCHR
                   ,       DBMS_RANDOM.VALUE(1,LENGTH(UPPERCHR))
                   ,       1
                   ) ||
                   SUBSTR
                   (
                           LOWCHR
                   ,       DBMS_RANDOM.VALUE(1,LENGTH(LOWCHR))
                   ,       1
                   ) ||
                   SUBSTR
                   (
                           SPECCHR
                   ,       DBMS_RANDOM.VALUE (1, LENGTH(SPECCHR))
                   ,       1
                   ) ||
                   SUBSTR
                   (
                           NUMCHR
                   ,       DBMS_RANDOM.VALUE (1, LENGTH(NUMCHR))
                   ,       1
                   )       AS PART_PWD
           FROM    charac_classes
   ), random_sort AS
   (       /* Append the partial password with the random string generated from the entire set.
            * Make sure that you apply a substring to achieve the length necessary for the password.
            */
           SELECT  SUBSTR(PART_PWD || (SELECT SUBSTR(RANSTRING,1,PASSWORD_LENGTH - LENGTH(PART_PWD)) FROM randomstring) ,LEVEL,1) AS INDV_CHARS
           ,       ROW_NUMBER() OVER (ORDER BY DBMS_RANDOM.VALUE) RN
           FROM    strchars
           CONNECT BY LEVEL <= LENGTH(PART_PWD || (SELECT SUBSTR(RANSTRING,1,PASSWORD_LENGTH - LENGTH(PART_PWD)) FROM randomstring))
           ORDER BY DBMS_RANDOM.VALUE
   )
   /* Rebuild into string */
   SELECT  MAX(REVERSE
           (
                   REPLACE
                   (       SYS_CONNECT_BY_PATH
                           (
                                   INDV_CHARS
                           ,       '/'             /* Something not in special character string */
                           )
                   ,       '/'
                   ,       ''
                   )
           ))      AS PWD
   FROM    random_sort
   WHERE   CONNECT_BY_ISLEAF=1
   CONNECT BY PRIOR RN + 1 = RN
   )
   loop
    v_return := v_Cur.pwd;
   end loop;
   return v_return;
  end password_generator;
  --
  function get_g_key return raw
  is
  begin
    return g_key;
  end get_g_key;
  --
  function get_enc_val  (p_in in nvarchar2,p_key in raw default g_key)
          return raw 
  is
    l_enc_val raw (2000);
    l_mod number := dbms_crypto.ENCRYPT_AES128 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5;
  begin
   l_enc_val := dbms_crypto.encrypt (UTL_I18N.STRING_TO_RAW(p_in, 'AL32UTF8'),l_mod,p_key);
   return l_enc_val;
  end;
  --
  function get_dec_val (p_in in raw,p_key in raw default g_key)
        return nvarchar2 
  is
    l_ret nvarchar2 (2000);
    l_dec_val raw (2000);
    l_mod number := dbms_crypto.ENCRYPT_AES128 + dbms_crypto.CHAIN_CBC + dbms_crypto.PAD_PKCS5;
  begin
    l_dec_val := dbms_crypto.decrypt (p_in,l_mod,p_key);
    l_ret:= UTL_I18N.RAW_TO_NCHAR(l_dec_val, 'AL32UTF8');
    return l_ret;
  end;
  --
   FUNCTION appl_error_msg (p_APPLICATION_ERROR_MSG_CODE in APPLICATION_ERROR_MSG.APPLICATION_ERROR_MSG_CODE%type
                                  ,p_application_code IN list_application.application_code%TYPE default 'CNST'
                                  ,p_lang_code IN list_lang.lang_code%type default 'en'
                                  )
              RETURN APPLICATION_ERROR_MSG_LANG.descr%TYPE
   is
     v_descr APPLICATION_ERROR_MSG_LANG.descr%TYPE;
   begin
      select aeml.descr
      into v_descr
      from APPLICATION_ERROR_MSG aem
          ,APPLICATION_ERROR_MSG_LANG aeml
      where aem.APPLICATION_ERROR_MSG_CODE = aeml.APPLICATION_ERROR_MSG_CODE
      and aeml.lang_code = p_lang_code
      and aem.application_code = p_application_code
      and aem.APPLICATION_ERROR_MSG_CODE = p_APPLICATION_ERROR_MSG_CODE
      ;
      return v_descr;
   exception
    when others then 
      v_descr := null;
      return v_descr;
   end appl_error_msg;
   --
   function get_random_num_15 return varchar2 is
   begin
    return trunc(dbms_random.value(100000000000000, 999999999999999));
   end get_random_num_15;
   --
   function get_random_vc_15 return varchar2 is
   begin
    return dbms_random.string('U', 15);
   end get_random_vc_15;
   --
   function get_random_alphanum_15 return varchar2 is
   begin
    return dbms_random.string('X', 15);
   end get_random_alphanum_15;


   procedure get_random_num_15 (p_out out varchar2)
   is
    v_out varchar2(15);
   begin
    v_out := trunc(dbms_random.value(100000000000000, 999999999999999));
    p_out := v_out;
   end get_random_num_15;
   --
   procedure get_random_vc_15 (p_out out varchar2)
   is
    v_out varchar2(15);
   begin
    v_out := dbms_random.string('U', 15);
    p_out := v_out;
   end get_random_vc_15;
   --
   procedure get_random_alphanum_15 (p_out out varchar2)
   is
    v_out varchar2(15);
   begin
    v_out := dbms_random.string('X', 15);
    p_out := v_out;
   end get_random_alphanum_15;
   --
   -- return the record status of an application
   FUNCTION record_status (p_eff_date     IN DATE
                          ,p_inactive_date IN DATE)
      RETURN VARCHAR2
   AS
   BEGIN
      IF (p_eff_date IS NOT NULL AND p_eff_date <= SYSDATE) AND NVL (p_inactive_date, SYSDATE + 1) >= SYSDATE
      THEN
         --Means Active
         RETURN 'A';
      ELSIF (p_eff_date IS NOT NULL AND p_eff_date <= SYSDATE) AND p_inactive_date < SYSDATE
      THEN
         IF NVL (p_inactive_date, SYSDATE) < p_eff_date
         THEN
            RETURN 'N';
         --N means Never Active
         ELSE
            --inactive_date < sysdate, means inactive
            RETURN 'I';
         END IF;
      ELSIF p_eff_date IS NOT NULL AND p_eff_date > SYSDATE
      THEN
         --eff_date > sysdate, means future
         RETURN 'F';
      ELSE --could be eff_date is null
         RETURN 'U';
      END IF;
   END record_status;

   --  Function to provide last run time stamp of an individual data

   FUNCTION appl_last_run_tmstmp (p_application_name IN application_control.application_name%TYPE)
      RETURN application_control.last_run_tmstmp%TYPE
   IS
      l_last_run_tmstmp   application_control.last_run_tmstmp%TYPE;
   BEGIN
      SELECT ac.last_run_tmstmp - NVL (acv.control_value_number, 0) last_run_tmstmp
      INTO l_last_run_tmstmp
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn(+)
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name(+) = 'NUMBER_OF_DAYS'
            AND common_pkg.record_status (ac.eff_date
                                         ,ac.inactive_date) = 'A'
            AND common_pkg.record_status (acv.eff_date(+)
                                         ,acv.inactive_date(+)) = 'A';

      RETURN l_last_run_tmstmp;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20010
                                 ,SQLERRM);
   END appl_last_run_tmstmp;

   --procedure to update application_control
   --last_run_tmstmp column which is used for next run tmstmp.
   --
   PROCEDURE update_appl_last_run_tmstmp (p_application_name IN application_control.application_name%TYPE
                                         ,p_run_tmstmp   IN application_control.last_run_tmstmp%TYPE)
   IS
   BEGIN
      UPDATE application_control
      SET last_run_tmstmp   = p_run_tmstmp
      WHERE     application_name = UPPER (p_application_name)
            AND record_status (eff_date
                              ,inactive_date) = 'A';

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20011
                                 ,SQLERRM);
   END update_appl_last_run_tmstmp;

   --This function will return the alpha or char parameter_value for a process
   --and parameter
   --
   FUNCTION appl_control_value_alpha (p_application_name IN application_control.application_name%TYPE
                                     ,p_control_value_name IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.control_value_alpha%TYPE
   IS
      v_return   application_control_value.control_value_alpha%TYPE;
   BEGIN
      SELECT control_value_alpha
      INTO v_return
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value_name)
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A'
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A';

      RETURN v_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END appl_control_value_alpha;
   --
   --This function will return the clob parameter_value for a process
   --and parameter
   --
   FUNCTION appl_control_value_clob (p_application_name IN application_control.application_name%TYPE
                                     ,p_control_value_name IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.control_value_clob%TYPE
   IS
      v_return   application_control_value.control_value_clob%TYPE;
   BEGIN
      SELECT control_value_clob
      INTO v_return
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value_name)
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A'
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A';

      RETURN v_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END appl_control_value_clob;   

   --This function will return the date parameter_value for a process
   --and parameter
   --
   FUNCTION appl_control_value_date (p_application_name IN application_control.application_name%TYPE
                                    ,p_control_value_name IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.control_value_date%TYPE
   IS
      v_return   application_control_value.control_value_date%TYPE;
   BEGIN
      SELECT control_value_date
      INTO v_return
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value_name)
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A'
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A';

      RETURN v_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END appl_control_value_date;

   --This function will return the number parameter_value for a process
   --and parameter
   --
   FUNCTION appl_control_value_number (p_application_name IN application_control.application_name%TYPE
                                      ,p_control_value_name IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.control_value_number%TYPE
   IS
      v_return   application_control_value.control_value_number%TYPE;
   BEGIN
      SELECT control_value_number
      INTO v_return
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value_name)
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A'
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A';

      RETURN v_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END appl_control_value_number;

   --This function will return the number parameter_value for a process
   --and parameter
   --
   FUNCTION appl_control_value_timestamp (p_application_name IN application_control.application_name%TYPE
                                         ,p_control_value_name IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.control_value_timestamp%TYPE
   IS
      v_return   application_control_value.control_value_timestamp%TYPE;
   BEGIN
      SELECT control_value_timestamp
      INTO v_return
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = acv.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value_name)
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A'
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A';

      RETURN v_return;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20013
                                 ,SQLERRM);
   END appl_control_value_timestamp;

   -- This procedure update the application control value alpha
   PROCEDURE upd_appl_control_value_alpha (p_application_name IN application_control.application_name%TYPE
                                          ,p_control_value_name IN application_control_value.control_value_name%TYPE
                                          ,p_new_alpha_value IN application_control_value.control_value_alpha%TYPE)
   IS
   BEGIN
      UPDATE application_control_value acv
      SET control_value_alpha   = p_new_alpha_value
      WHERE acv_sn =
               (SELECT acv_sn
                FROM application_control ac
                WHERE     ac.application_control_sn = acv.application_control_sn
                      AND UPPER (ac.application_name) = UPPER (p_application_name)
                      AND UPPER (acv.control_value_name) = UPPER (p_control_value_name));

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20014
                                 ,SQLERRM);
   END upd_appl_control_value_alpha;

   -- This procedure update the application control value clob
   PROCEDURE upd_appl_control_value_clob (p_application_name IN application_control.application_name%TYPE
                                          ,p_control_value_name IN application_control_value.control_value_name%TYPE
                                          ,p_new_clob_value IN application_control_value.control_value_clob%TYPE)
   IS
   BEGIN
      UPDATE application_control_value acv
      SET control_value_clob   = p_new_clob_value
      WHERE acv_sn =
               (SELECT acv_sn
                FROM application_control ac
                WHERE     ac.application_control_sn = acv.application_control_sn
                      AND UPPER (ac.application_name) = UPPER (p_application_name)
                      AND UPPER (acv.control_value_name) = UPPER (p_control_value_name));

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20014
                                 ,SQLERRM);
   END upd_appl_control_value_clob;
   --procedure to insert into application_process_log table
   PROCEDURE ins_appl_process_log (p_package_name  VARCHAR2
                                  ,p_proc_name     VARCHAR2
                                  ,p_err_severity_code CHAR
                                  ,p_err_msg       VARCHAR2
                                  ,p_notes         VARCHAR2
                                  ,p_input_clob    clob default null
                                  ,p_input_blob    blob default null
                                  )
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO application_process_log (appl_process_log_sn
                                          ,error_severity_code
                                          ,notes
                                          ,package_name
                                          ,procedure_name
                                          ,error_msg
                                          ,input_clob
                                          ,input_blob
                                          )
      VALUES (appl_process_log_sng.NEXTVAL
             ,p_err_severity_code
             ,SUBSTR (p_notes
                     ,1
                     ,500)
             ,p_package_name
             ,p_proc_name
             ,SUBSTR (p_err_msg
                     ,1
                     ,1000)
             ,p_input_clob
             ,p_input_blob
             );

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END ins_appl_process_log;

    -- function to get the last_run_tmstmp for application_control_value
   FUNCTION appl_cntl_value_lst_run_tmstmp (p_application_name IN application_control.application_name%TYPE
                                           ,p_control_value IN application_control_value.control_value_name%TYPE)
      RETURN application_control_value.last_run_tmstmp%TYPE
   AS
      v_last_run_tmstmp   application_control_value.last_run_tmstmp%TYPE;
   BEGIN
      SELECT acv.last_run_tmstmp
      INTO v_last_run_tmstmp
      FROM application_control ac
          ,application_control_value acv
      WHERE     ac.application_control_sn = ac.application_control_sn
            AND ac.application_name = UPPER (p_application_name)
            AND acv.control_value_name = UPPER (p_control_value)
            AND record_status (ac.eff_date
                              ,ac.inactive_date) = 'A'
            AND record_status (acv.eff_date
                              ,acv.inactive_date) = 'A';

      RETURN v_last_run_tmstmp;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END appl_cntl_value_lst_run_tmstmp;

   -- this procedure is used to update the last_run_tmstmp in application_control_value table
   PROCEDURE upd_apl_ctl_val_lst_run_tmstmp (p_application_name IN application_control.application_name%TYPE
                                            ,p_cntrl_value_name IN application_control_value.control_value_name%TYPE
                                            ,p_run_tmstmp   IN application_control_value.last_run_tmstmp%TYPE)
   AS
   BEGIN
      UPDATE application_control_value acv
      SET last_run_tmstmp   = p_run_tmstmp
      WHERE acv_sn =
               (SELECT acv_sn
                FROM application_control ac
                WHERE     ac.application_control_sn = acv.application_control_sn
                      AND UPPER (ac.application_name) = UPPER (p_application_name)
                      AND UPPER (acv.control_value_name) = UPPER (p_cntrl_value_name));


      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20012
                                 ,SQLERRM);
   END upd_apl_ctl_val_lst_run_tmstmp;

   --
   --this procedure will create records to turn on history for a column in a table
   PROCEDURE turn_on_hist_prc (p_table_name   IN appl_hist_table.name%TYPE
                              ,p_col_name     IN appl_hist_col.col_name%TYPE
                              ,p_data_type    IN VARCHAR2
                              ,p_hist_flag    IN VARCHAR2 DEFAULT 'Y')
   IS
      l_appl_hist_table_num   NUMBER;
      l_appl_hist_col_num     NUMBER;
      l_table_exist_cnt       NUMBER;
      l_col_exist_cnt         NUMBER;
   BEGIN
      SELECT COUNT (*)
      INTO l_table_exist_cnt
      FROM appl_hist_table
      WHERE name = UPPER (p_table_name);

      IF l_table_exist_cnt = 0
      THEN
         SELECT NVL (MAX (appl_hist_table_num), 0) + 1
         INTO l_appl_hist_table_num
         FROM appl_hist_table;

         INSERT INTO appl_hist_table (appl_hist_table_num
                                     ,descr
                                     ,hist_flag
                                     ,name)
         VALUES (l_appl_hist_table_num
                ,UPPER (p_table_name) || ' DATA'
                ,UPPER (p_hist_flag)
                ,UPPER (p_table_name));
      ELSE
         SELECT appl_hist_table_num
         INTO l_appl_hist_table_num
         FROM appl_hist_table
         WHERE name = UPPER (p_table_name);
      END IF;

      --
      SELECT COUNT (*)
      INTO l_col_exist_cnt
      FROM appl_hist_col
      WHERE table_name = UPPER (p_table_name) AND col_name = UPPER (p_col_name);

      --
      IF l_col_exist_cnt = 0
      THEN
         SELECT NVL (MAX (appl_hist_col_num), 0) + 1
         INTO l_appl_hist_col_num
         FROM appl_hist_col
         WHERE appl_hist_table_num = l_appl_hist_table_num;

         INSERT INTO appl_hist_col (appl_hist_col_num
                                   ,appl_hist_table_num
                                   ,col_name
                                   ,data_type_code
                                   ,descr
                                   ,hist_flag
                                   ,table_name)
         VALUES (l_appl_hist_col_num
                ,l_appl_hist_table_num
                ,p_col_name
                ,UPPER (p_data_type)
                ,UPPER (p_col_name) || ' DATA'
                ,UPPER (p_hist_flag)
                ,UPPER (p_table_name));
      END IF;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20099
                                 ,SQLERRM);
   END;


   FUNCTION check_valid_date (p_date IN VARCHAR2)
      RETURN VARCHAR2
   AS
      v_valid_date   VARCHAR2 (1) := 'Y';
      v_date         DATE;
   BEGIN
      BEGIN
         SELECT TO_DATE (p_date
                        ,'YYYY/MM/DD')
         INTO v_date
         FROM DUAL;

         v_valid_date   := 'Y';
      EXCEPTION
         WHEN OTHERS
         THEN
            v_valid_date   := 'N';
      END;

      RETURN v_valid_date;
   END check_valid_date;

   FUNCTION is_a_valid_number (p_num IN VARCHAR2) RETURN varchar2
   AS
     v_num         NUMBER;
   BEGIN
     v_num := TO_NUMBER (p_num);
     RETURN 'Y';
   EXCEPTION
     WHEN OTHERS THEN
      RETURN 'N';
   END is_a_valid_number;
   --
   FUNCTION string_to_table_num (p VARCHAR2)
      RETURN tab_number
      PIPELINED
   IS
   BEGIN
      FOR cc IN (SELECT RTRIM (REGEXP_SUBSTR (str
                                             ,'[^,]*,'
                                             ,1
                                             ,LEVEL)
                              ,',')
                           res
                 FROM (SELECT p || ',' str
                       FROM DUAL)
                 CONNECT BY LEVEL <=   LENGTH (str)
                                     - LENGTH (REPLACE (str
                                                       ,','
                                                       ,'')))
      LOOP
         PIPE ROW (cc.res);
      END LOOP;
   END string_to_table_num;
    --
    PROCEDURE check_valid_date_and_age (p_date IN VARCHAR2
                                      ,p_out out VARCHAR2)
    is
      v_age number(9,4);
      obj json := json();
    begin
      if common_pkg.check_valid_date(p_date) = 'Y' then
        SELECT trunc(((SYSDATE - TO_DATE (p_date,'YYYY/MM/DD'))/365),2)
        INTO v_age
        from dual;
        if v_age >= 18 then
          obj.put('VALID_DATE_FLAG', 'Y');
          obj.put('VALID_AGE_FLAG', 'Y');
        else
          obj.put('VALID_DATE_FLAG', 'Y');
          obj.put('VALID_AGE_FLAG', 'N');
        end if;
      else
        obj.put('VALID_DATE_FLAG', 'N');
        obj.put('VALID_AGE_FLAG', 'N');
      end if;
      --dbms_lob.createtemporary(p_out, true);
      --obj.to_clob(p_out);
      --dbms_lob.freetemporary(p_out);
      p_out := obj.to_char;
    end check_valid_date_and_age;
    --
  PROCEDURE get_user(p_username IN NVARCHAR2
                          ,p_password IN NVARCHAR2
                            ,p_out  OUT SYS_REFCURSOR) IS
    BEGIN
      open p_out for
      select     "Id"
                ,"Email"
                ,"EmailConfirmed"
                ,"PasswordHash"
                ,"SecurityStamp"
                ,"PhoneNumber"
                ,"PhoneNumberConfirmed"
                ,"TwoFactorEnabled"
                ,"LockoutEndDateUtc"
                ,"LockoutEnabled"
                ,"AccessFailedCount"
                ,"UserName"
      from "AspNetUsers"
      where "UserName" = p_username
      and "PasswordHash" = p_password
      order by "Id"
      ;
  END get_user;
  --
  PROCEDURE extract_file(p_file in blob,p_file_name in varchar2,p_file_directory varchar2 default 'EXT_FILE_IMAGE') IS
    vstart NUMBER := 1;
    bytelen NUMBER := 32000;
    len NUMBER;
    my_vr RAW(32000);
    x NUMBER;
    --  
    l_output utl_file.file_type;
  BEGIN
    -- define output directory
    l_output := utl_file.fopen(p_file_directory, p_file_name,'wb', 32760);
    vstart := 1;
    bytelen := 32000;
    -- get length of blob
    len := dbms_lob.getlength(p_file);
    --  
    x := len;
    -- if small enough for a single write
    IF len < 32760 THEN
      utl_file.put_raw(l_output,p_file);
      utl_file.fflush(l_output);
    ELSE -- write in pieces
      vstart := 1;
      WHILE vstart < len and bytelen > 0
      LOOP
        dbms_lob.read(p_file,bytelen,vstart,my_vr);

        utl_file.put_raw(l_output,my_vr);
        utl_file.fflush(l_output); 

        -- set the start position for the next cut
        vstart := vstart + bytelen;

        -- set the end position if less than 32000 bytes
        x := x - bytelen;
        IF x < 32000 THEN
          bytelen := x;
        END IF;
      end loop;
    END IF;
    utl_file.fclose(l_output);
  end;
  --
  PROCEDURE extract_file(p_file in out nocopy clob,p_file_name in varchar2,p_file_directory varchar2 default 'EXT_FILE_IMAGE') IS
    l_file  UTL_FILE.file_type;
    l_step  PLS_INTEGER := 12000;
  BEGIN
    l_file := UTL_FILE.fopen(p_file_directory, p_file_name, 'w', 32767);

    FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_file) - 1 )/l_step) LOOP
      UTL_FILE.put(l_file, DBMS_LOB.substr(p_file, l_step, i * l_step + 1));
      UTL_FILE.fflush(l_file);
    END LOOP;
    UTL_FILE.fclose(l_file);
  end;
  --
  FUNCTION base64encode(p_blob IN BLOB) RETURN CLOB
  IS
    l_clob CLOB;
    l_step PLS_INTEGER := 12000; -- make sure you set a multiple of 3 not higher than 24573
  BEGIN
    FOR i IN 0 .. TRUNC((DBMS_LOB.getlength(p_blob) - 1 )/l_step) LOOP
      l_clob := l_clob || UTL_RAW.cast_to_varchar2(UTL_ENCODE.base64_encode(DBMS_LOB.substr(p_blob, l_step, i * l_step + 1)));
    END LOOP;
    RETURN l_clob;
  END base64encode;
  --
  FUNCTION base64decode(p_clob IN CLOB) RETURN BLOB
  -- Decodes a Base64 CLOB into a BLOB
  IS
    l_blob    BLOB;
    l_raw     RAW(32767);
    l_amt     NUMBER := 7700;
    l_offset  NUMBER := 1;
    l_temp    VARCHAR2(32767);
  BEGIN
    BEGIN
      DBMS_LOB.createtemporary (l_blob, FALSE, DBMS_LOB.CALL);
      LOOP
        DBMS_LOB.read(p_clob, l_amt, l_offset, l_temp);
        l_offset := l_offset + l_amt;
        l_raw    := UTL_ENCODE.base64_decode(UTL_RAW.cast_to_raw(l_temp));
        DBMS_LOB.append (l_blob, TO_BLOB(l_raw));
      END LOOP;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
    RETURN l_blob;
  END base64decode;
  --
  function age (p_birth_date in date) return number is  
  begin
    return trunc(months_between(sysdate,p_birth_date)/12);
  end age;
  --
  function age_at_a_date (p_birth_date in date,p_date in date) return number is
  begin
    return trunc(months_between(p_date,p_birth_date)/12);
  end age_at_a_date;
  --
  function bmi (p_weight_in_lb in number,p_height_in_in in number) return number is
  begin
    return round(p_weight_in_lb*0.453592/(p_height_in_in*0.0254*p_height_in_in*0.0254),1);
  end bmi;
  --
  function bmi_result (p_bmi in number) return varchar2 is
    v_return varchar2(30);
  begin
    if p_bmi < 18.5 then
      v_return := 'Underweight';
    elsif p_bmi between 18.5 and 24.9 then
      v_return := 'Normal weight';
    elsif p_bmi between 25 and 29.9 then
      v_return := 'Overweight';
    elsif p_bmi >= 30 then
      v_return := 'Obese';
    end if;
    return v_return;
  end bmi_result;
  --
  function height_in_feet (p_height_in_in in number) return varchar2 is
    v_feet varchar2(10);
    v_inch varchar2(10);
  begin
    if p_height_in_in < 12 then
      v_feet := '0''';
      v_inch := p_height_in_in||'"';
    else
      v_feet := (p_height_in_in - (mod(p_height_in_in,12)))/12||'''';
      v_inch := mod(p_height_in_in,12)||'"';
    end if;
    return v_feet||v_inch;
  end height_in_feet;
  --Here input height will be entered as decimal. E.g. 5.7 means 5 feet 7 inches with max height limitation of 8.1
  function height_in_inch (p_height_in_feet in varchar2) return number is
    v_dec_num number(11);
    v_int_num number(11);
    e_inv_num exception;
  begin
    v_dec_num := return_decimal_of_a_num(p_height_in_feet);
    v_int_num := return_integer_of_a_num(p_height_in_feet);
    --max height can be 8.1 (8 ft and 1 inch) and following section is performing that validation
    --8.1 is the world record for tallest person
    if v_dec_num > 11 or v_int_num > 8 or to_number(p_height_in_feet) < 0 then
      raise e_inv_num;
    elsif (v_int_num = 8) and (v_dec_num > 1) then
      raise e_inv_num;
    else
      return v_int_num*12 + v_dec_num;
    end if;
  exception
    when e_inv_num then
      raise_application_error(-20101,'Invalid Height');
    when others then
      raise_application_error(-20102,sqlerrm);
  end height_in_inch;
  --
  function return_integer_of_a_num (p_number in varchar2) return number
  is
  begin
    return trunc(p_number);
  end return_integer_of_a_num;
  --
  function return_decimal_of_a_num (p_number in varchar2) return number
  is
    v_instr_dot number;
  begin
    v_instr_dot := instr(p_number,'.');
    if v_instr_dot = 0 then return 0;
    else return substr(p_number,v_instr_dot+1,length(p_number)-v_instr_dot);
    end if;
  end return_decimal_of_a_num;
END common_pkg;
/
show errors