create or replace PACKAGE list_item_pkg IS
  v_pkg_name    varchar2 (30) := upper('list_item_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_custom_fail_reason varchar2(200);
  v_input_str   CLOB;
  --
  PROCEDURE list_item  (p_locale in varchar2,p_out OUT clob);
END list_item_pkg;
/
show errors
create or replace PACKAGE BODY list_item_pkg IS
  --new_user_approval
  function new_user_approval return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','NEW USER APPROVAL');
    obj.put('SUB_TITLE1','THIS WILL COMPLETE USER REVIEW AND MOVE USER FROM PROSPECTIVE USER TO ACTIVE USER');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('USER_A_PROV','Is the User a Service Provider?');
    obj.put('label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_USER','Select User');
    obj2.put('SELECT_ROLE','Select Role');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('FIRST_NAME','First Name');
    obj2.put('MIDDLE_NAME','Middle Name');
    obj2.put('LAST_NAME','Last Name');
    obj2.put('PHONE','Phone');
    obj2.put('ADDR1','Address 1');
    obj2.put('ADDR2','Address 2');
    obj2.put('CITY','City');
    obj2.put('STATE','State');
    obj2.put('ZIP','Zip');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end new_user_approval;
  --location_to_physician
  function location_to_physician return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ASSIGN SERVICE LOCATION TO PHYSICIAN');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA. COMPANY IS MANDATORY');
    obj.put('SUB_TITLE2','Please assign one or many location this service provider will be active');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('LOC_NAME_TITLE','Location Name');
    obj.put('label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_PHYSICIAN','Select Physician');
    obj2.put('LOC_LIST','Location List');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end location_to_physician;
  --company_to_user
  function company_to_user return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ASSIGN COMPANY TO USER');
    obj.put('SUB_TITLE1','This is a user company control exception screen. The assigned user will have control over all the companies listed here besides the user default company where he/she belongs to. In order to adhere to the data privacy, please follow all the necessary approval for this user.');
    obj.put('SUB_TITLE2','Please assign one or many companies this user will have control');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE_NAME','Company Name');
    obj.put('label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_USER','Select User');
    obj2.put('LIST_NAME','Company List');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end company_to_user;
  --location_to_user
  function location_to_user return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ASSIGN SERVICE LOCATION TO USER');
    obj.put('SUB_TITLE1','This is a user location control exception screen. The assigned user will have control over only the listed locations of default company. Use this screen to restrict a user to have control of specific company service location rather than all the locations.');
    obj.put('SUB_TITLE2','Please assign one or many location this user will be active');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('LOC_NAME_TITLE','Location Name');
    obj.put('label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_USER','Select User');
    obj2.put('LOC_LIST','Location List');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end location_to_user;
  --physician_to_user
  function physician_to_user return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ASSIGN PHYSICIAN TO USER');
    obj.put('SUB_TITLE1','This is a user physician control exception screen. The assigned user will have control over only the listed physicians of default company. Use this screen to restrict a user to have control of specific company physician rather than all the physicians.');
    obj.put('SUB_TITLE2','Please assign one or many physicians this user will have control');
    --=======================label
    obj2 := json(); --an empty structure
    obj2.put('TITLE_NAME','Physician Name');
    obj.put('label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_USER','Select User');
    obj2.put('LIST_NAME','Physician List');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end physician_to_user;
  --patient_record_edit
  function patient_record_edit return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PATIENT DATA MANAGEMENT');
    obj.put('SUB_TITLE1','PLEASE SEARCH BY APPROPRIATE INPUT DATA TO IDENTIFY THE PATIENT');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('HIC','Patient HIC');
    obj2.put('SSN','Patient SSN');
    obj2.put('PAT_LN','Patient Last Name');
    obj2.put('PAT_FN','Patient First Name');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end patient_record_edit;
  --patient_record_edit
  function company_record_edit return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','COMPANY RECORD MANAGEMENT');
    obj.put('SUB_TITLE1','PLEASE SELECT THE COMPANY RECORD FOR EDIT');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end company_record_edit;
  --location_to_company
  function location_to_company return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ADD SERVICE LOCATION TO COMPANY');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA. COMPANY IS MANDATORY');
    obj.put('SUB_TITLE2','Please add all the location under this company');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Location Name');
    obj2.put('TH2','Location Type');
    obj2.put('TH3','Contact Name');
    obj2.put('TH4','Contact Ph');
    obj2.put('TH5','Addr 1');
    obj2.put('TH6','Addr 2');
    obj2.put('TH7','City');
    obj2.put('TH8','State');
    obj2.put('TH9','Zip');
    obj.put('th_label',obj2);    
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end location_to_company;
  --physician_to_company
  function physician_to_company return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ADD PRIMARY PHYSICIAN TO COMPANY');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA. COMPANY IS MANDATORY');
    obj.put('SUB_TITLE2','Please add all the physician under this company');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Title');
    obj2.put('TH2','First Name');
    obj2.put('TH3','Middle Name');
    obj2.put('TH4','Last Name');
    obj2.put('TH5','License Num');
    obj2.put('TH6','NPI');
    obj2.put('TH7','Physician Type');
    obj2.put('TH8','Dr Type');
    obj2.put('TH9','Phone');
    obj2.put('TH10','Email');
    obj.put('th_label',obj2);    
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end physician_to_company;
  --provider_record_create
  function provider_record_create return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ADD SERVICE PROVIDER TO COMPANY');
    obj.put('SUB_TITLE1','PLEASE SELECT COMPANY AND PROSPECTIVE PROVIDER. PLEASE ADD OTHER NECESSARY INFORMATIONS.');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_PROV','Select Prospective Provider');
    obj2.put('SELECT_TITLE','Select Title');
    obj2.put('SELECT_PROV_TYPE','Select Provider Type');
    obj2.put('SELECT_DR_TYPE','Select Dr Type');
    obj2.put('SELECT_LICENSE','License Num');
    obj2.put('SELECT_NPI','NPI');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end provider_record_create;
  --provider_record_edit
  function provider_record_edit return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PROVIDER DATA MANAGEMENT');
    obj.put('SUB_TITLE1','PLEASE SELECT THE COMPANY PROVIDER BELONGS TO.');
    obj.put('SUB_TITLE2','PROVIDER LIST');
    obj.put('SUB_TITLE3','Please select the provider to Edit/Delete');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Email');
    obj2.put('TH3','License Num');
    obj.put('th_label',obj2);
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_TITLE','Select Title');
    obj2.put('SELECT_PROV_TYPE','Select Provider Type');
    obj2.put('SELECT_DR_TYPE','Select Dr Type');
    obj2.put('SELECT_LICENSE','License Num');
    obj2.put('SELECT_NPI','NPI');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end provider_record_edit;
  --admin_user_data_edit
  function admin_user_data_edit return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','USER DATA MANAGEMENT');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA. AT LEAST ONE OF THE INPUT PARAMETER  IS MANDATORY');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('EMAIL','Email');
    obj2.put('LAST_NAME','Last Name');
    obj2.put('FIRST_NAME','First Name');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end admin_user_data_edit;
  --patient_service_data
  function patient_service_data return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PATIENT SERVICE DATA');
    obj.put('SUB_TITLE1','Input validation rules: 1)Only Company Selection is required.');
    obj.put('SUB_TITLE2','Inquiry By patient attributes (HIC, SSN, LAST/FIRST NAME)');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('DT_BEGIN','SVC DT Begin (MM/DD/YYYY)');
    obj2.put('DT_END','SVC DT End (MM/DD/YYYY)');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj2.put('SELECT_SVC','Select Service');
    obj2.put('HIC','Patient HIC');
    obj2.put('SSN','Patient SSN');
    obj2.put('LAST_NAME','Patient Last Name');
    obj2.put('FIRST_NAME','Patient First Name');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end patient_service_data;
  --patient_inquiry_data
  function patient_inquiry_data return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PATIENT INQUIRY');
    obj.put('SUB_TITLE1','PLEASE SELECT THE APPROPRIATE REPORT NAME.');
    obj.put('SUB_TITLE2','PLEASE SELECT PATIENT IDENTIFYING ATTRIBUTES. COMPANY SELECTION IS MANDATORY');
    obj.put('SUB_TITLE3','SPECIFIC PATIENT QUERY)');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_REPORT','Select Report Name');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj2.put('HIC','Patient HIC');
    obj2.put('SSN','Patient SSN');
    obj2.put('LAST_NAME','Patient Last Name');
    obj2.put('FIRST_NAME','Patient First Name');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end patient_inquiry_data;
  --analytical_data
  function analytical_data return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','ANALYTICAL REPORT');
    obj.put('SUB_TITLE1','PLEASE SELECT THE APPROPRIATE REPORT NAME.');
    obj.put('SUB_TITLE2','PLEASE SELECT REPORT DATA FILTER ATTRIBUTES');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_REPORT','Select Report Name');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj2.put('SELECT_SVC','Select Service');
    obj2.put('DT_BEGIN','SVC DT Begin (MM/DD/YYYY)');
    obj2.put('DT_END','SVC DT End (MM/DD/YYYY)');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end analytical_data;
  --analytical_data
  function scheduled_service_data return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','SCHEDULED SERVICE');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Interviewer Company');
    obj2.put('SELECT_PROV','Select Interviewer');
    obj2.put('SELECT_SVC','Select Service');
    obj2.put('SVC_DT_UPTO','SVC DT Up To (MM/DD/YYYY)');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end scheduled_service_data;
  --other_inquiry_data
  function other_inquiry_data return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','OTHER INQUIRY');
    obj.put('SUB_TITLE1','PLEASE SELECT APPROPRIATE DATA. REPORT NAME SELECTION  IS MANDATORY');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_REPORT','Select Report Name');
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end other_inquiry_data;
  --patient_record_create
  function patient_record_create return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','PATIENT RECORD CREATION');
    obj.put('SUB_TITLE1','PATIENT DEMOGRAPHIC DATA.');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_COMPANY','Select Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    --
    obj2.put('FN','First Name');
    obj2.put('MN','Middle Name');
    obj2.put('LN','Last Name');
    obj2.put('DOB','DOB (MM/DD/YYYY)');
    obj2.put('SSN','SSN');
    obj2.put('HIC','HIC');
    obj2.put('PH','Phone');
    obj2.put('GENDER','Gender');
    obj2.put('RACE','Race');
    obj2.put('EMAIL','Email');
    --
    obj2.put('ADDR1','Address 1');
    obj2.put('ADDR2','Address 2');
    obj2.put('CITY','City');
    obj2.put('STATE','State');
    obj2.put('ZIP','Zip');
    --
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end patient_record_create;
  --service_appointment
  function service_appointment return json
  as
    obj         json;
    obj2        json;
    --
    l_obj       json_list;
  begin
    obj := json(); --an empty structure
    obj.put('TITLE','SCHEDULE PATIENT SERVICE APPOINTMENT');
    obj.put('SUB_TITLE1','PLEASE SELECT PROVIDER (INTERVIEWER)');
    obj.put('SUB_TITLE2','PLEASE SELECT PATIENT SERVICE LOCATION AND PHYSICIAN');
    obj.put('SUB_TITLE3','PLEASE SELECT PATIENT');
    obj.put('SUB_TITLE4','SELECTED  PATIENT');
    obj.put('SUB_TITLE5','PLEASE SELECT  PATIENT CURRENT INSURANCE');
    obj.put('SUB_TITLE6','PLEASE SELECT SERVICE DATE AND TIME');
    --=======================label_placeholder
    obj2 := json(); --an empty structure
    obj2.put('SELECT_PROV_COMP','Select Interviewer Company');
    obj2.put('SELECT_PROV','Select Interviewer');
    obj2.put('SELECT_PHY_COMP','Select Physician Company');
    obj2.put('SELECT_LOC','Select Location');
    obj2.put('SELECT_PHY','Select Physician');
    obj2.put('SELECT_SVC','Select Service');
    obj2.put('SELECT_INS','Select Insurance');
    obj2.put('DATE','DATE (MM/DD/YYYY)');
    obj2.put('HR','Hour');
    obj2.put('MIN','Minute');
    obj2.put('AM','AM/PM');
    --=======================th_label
    obj2 := json(); --an empty structure
    obj2.put('TH1','Name');
    obj2.put('TH2','Gender');
    obj2.put('TH3','HIC');
    obj2.put('TH4','DOB');
    obj2.put('TH5','Phone');
    obj2.put('TH6','Address');
    obj.put('th_label',obj2);
    --
    obj.put('label_placeholder',obj2);
    --===================================== end of json building
    return obj;
  end service_appointment;
  --
  function ui_label return json
  as
    obj         json;
  begin
    obj := json(); --an empty structure
    obj.put('new_user_approval',new_user_approval);
    obj.put('location_to_physician',location_to_physician);
    obj.put('company_to_user',company_to_user);
    obj.put('location_to_user',location_to_user);
    obj.put('physician_to_user',physician_to_user);
    obj.put('patient_record_edit',patient_record_edit);
    obj.put('company_record_edit',company_record_edit);
    obj.put('location_to_company',location_to_company);
    obj.put('physician_to_company',physician_to_company);
    obj.put('provider_record_create',provider_record_create);
    obj.put('provider_record_edit',provider_record_edit);
    obj.put('admin_user_data_edit',admin_user_data_edit);
    obj.put('patient_service_data',patient_service_data);
    obj.put('patient_inquiry_data',patient_inquiry_data);
    obj.put('analytical_data',analytical_data);
    obj.put('scheduled_service_data',scheduled_service_data);
    obj.put('other_inquiry_data',other_inquiry_data);
    obj.put('patient_record_create',patient_record_create);
    obj.put('service_appointment',service_appointment);
    --===================================== end of json building
    return obj;
  end ui_label;
  --
  PROCEDURE list_item  (p_locale in varchar2,p_out OUT clob)
  as
    obj json;
    obj2 json;
    obj3 json;
    l_obj json_list;
    l_obj2 json_list;
    --
    v_lang_code  list_lang.lang_code%type := common_pkg.locale_lang_code(p_locale);
  begin
    p_out := 'abc'; --initialize the clob
    obj := json(); --an empty structure
    --====================================================gender
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('gender', l_obj);
    end if;
    --==============================race
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('race', l_obj);
    end if;
    --==============================ethnicity
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('ethnicity', l_obj);
    end if;
    --==============================living_status
    l_obj := json_list(); --an empty list obj
    for m in (select g.living_status_code code
                    ,gl.short_descr name
              from list_living_status g
                  ,living_status_lang gl
              where g.living_status_code = gl.living_status_code
              and gl.lang_code = v_lang_code
              --
              and g.active_flag = 'Y'
              and gl.active_flag = 'Y'
              order by g.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('living_status', l_obj);
    end if;
    --==============================financial_status
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('financial_status', l_obj);
    end if;
    --==============================education_level
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('education_level', l_obj);
    end if;
    --==============================working_status
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('working_status', l_obj);
    end if;
    --==============================income
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('income', l_obj);
    end if;
    --==============================marital_status
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('marital_status', l_obj);
    end if;
    --==============================medication frequency
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('medication_frequency', l_obj);
    end if;
    --==============================medication_unit
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('medication_unit', l_obj);
    end if;
    --==============================patient_orientation
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('patient_orientation', l_obj);
    end if;
    --==============================physician_type
    l_obj := json_list(); --an empty list obj
    for m in (select g.physician_type_code code
                    ,gl.short_descr name
              from list_physician_type g
                  ,physician_type_lang gl
              where g.physician_type_code = gl.physician_type_code
              and gl.lang_code = v_lang_code
              --
              and g.active_flag = 'Y'
              and gl.active_flag = 'Y'
              order by g.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('physician_type', l_obj);
    end if;
    --==============================title
    l_obj := json_list(); --an empty list obj
    for m in (select 'Mr.' code,'Mr.' name from dual union
              select 'Ms.' code,'Ms.' name from dual union
              select 'Dr.' code,'Dr.' name from dual
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('title', l_obj);
    end if;
    --==============================svc_location_type
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('svc_location_type', l_obj);
    end if;          
    --==============================prev_svc_billing
    l_obj := json_list(); --an empty list obj
    for m in (select g.prev_svc_billing_code code
                    ,g.prev_svc_type_code||'-'||g.prev_svc_billing_code||'('||gl.short_descr||')' name
              from list_prev_svc_billing g
                  ,prev_svc_billing_lang gl
              where g.prev_svc_billing_code = gl.prev_svc_billing_code
              and gl.lang_code = v_lang_code
              --
              and g.active_flag = 'Y'
              and gl.active_flag = 'Y'
              order by g.order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('service_code', l_obj);
    end if;          
    --======================================================HR
    l_obj := json_list(); --an empty list obj
    for m in (select hr_code code
                    ,hr_code name
              from list_hr
              order by hr_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('svc_hr', l_obj);
    end if;
    --======================================================MIN
    l_obj := json_list(); --an empty list obj
    for m in (select min_code code
                    ,min_code name
              from list_min
              order by min_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('svc_min', l_obj);
    end if;
    --======================================================AM_PM
    l_obj := json_list(); --an empty list obj
    for m in (select am_pm_code code
                    ,am_pm_code name
              from list_am_pm
              order by am_pm_code
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('svc_am_pm', l_obj);
    end if;
    --======================================================dr_type
    l_obj := json_list(); --an empty list obj
    for m in (select drt.dr_type_code code
                    ,drt.dr_type_code||' - '||drtl.short_descr name
              from list_dr_type drt
                  ,dr_type_lang drtl
              where drt.dr_type_code = drtl.dr_type_code
              and drtl.lang_code = v_lang_code
              and drt.active_flag = 'Y'
              and drtl.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append obj2 to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('dr_type', l_obj);
    end if;
    --==============================insurance_company
    l_obj := json_list(); --an empty list obj
    for m in (select insurance_company_code code
                    ,name
              from insurance_company
              where active_flag = 'Y'
              order by order_num
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('insurance_company', l_obj);
    end if;
    --======================================================ui_label
    obj.put('ui_label', ui_label);
    --======================================================Roles
    l_obj := json_list(); --an empty list obj
    for m in (select r."Id" code
                    ,r."Name" name
              from "AspNetRoles" r
              where r."Id" not in ('a74f52c5-4d3a-46d9-bc22-a5eafa982849','96A384F7D6324738A4F192AD132D3B79','FE10783F05FB44A2AC0FD37F1E63AD76')
              and r.active_flag = 'Y'
              )
    loop
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --==========================role_priviledge
      l_obj2 := json_list(); --an empty list obj
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
        obj3 := json(); --an empty structure
        obj3.put('CODE',n.code);
        obj3.put('NAME',n.name);
        --Append the object to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('role_priviledge', l_obj2);
      end if;
      --Append the object to the list
      l_obj.append(obj2.to_json_value);            
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('role', l_obj);
    end if;
    --==============================priviledge
    l_obj := json_list(); --an empty list obj
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
      obj2 := json(); --an empty structure
      obj2.put('CODE',m.code);
      obj2.put('NAME',m.name);
      --==========================priviledge_ui
      l_obj2 := json_list(); --an empty list obj
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
        obj3 := json(); --an empty structure
        obj3.put('CODE',n.code);
        obj3.put('NAME',n.name);
        --Append the object to the list
        l_obj2.append(obj3.to_json_value);
      end loop;
      --
      if json_ac.array_count(l_obj2) > 0 then
        obj2.put('priviledge_navigation', l_obj2);
      end if;
      --Append the object to the list
      l_obj.append(obj2.to_json_value);
    end loop;
    --
    if json_ac.array_count(l_obj) > 0 then
      obj.put('priviledge', l_obj);
    end if;    
    --==========================output
    dbms_lob.trim(p_out, 0); --empty the lob
    obj.to_clob(p_out);
  end list_item;
END list_item_pkg;
/
show errors