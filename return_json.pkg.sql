set define off
CREATE OR REPLACE PACKAGE return_json_pkg IS
  v_pkg_name    varchar2 (30) := upper('return_json_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  v_global_user_name "AspNetUsers"."UserName"%type;
  v_global_role_name "AspNetRoles"."Name"%type;
  --
  function patient return varchar2;
  function patient_prev_svc_demo return varchar2;
  function physician return varchar2;
  function provider_physician return varchar2;
  function company return varchar2;
  function patient_medication return varchar2;
  function patient_prev_svc return varchar2;
  function svc_location return varchar2;
  function physician_svc_location return varchar2;
  function physician_em return varchar2;
  function physician_em_schedule return varchar2;
  function provider_ccm return varchar2;
  function physician_em_name return varchar2;
  --
  function patient_prev_svc_remark return varchar2;
  function patient_response (p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2;
  --
  function contact_us return varchar2;
  function mbr return varchar2;
  function addr_json_str (p_str varchar2) return varchar2;
END return_json_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY return_json_pkg IS
  function patient_response (p_question_categ_code in list_question_categ.question_categ_code%type) return varchar2 is
    v_str1 varchar2(32767);
  begin
    if p_question_categ_code = 'BMEDH' then
      v_str1 := '{"1":"100005","2":"100011","3":"100016"}';
    elsif p_question_categ_code = 'HSURA' then
      v_str1 := '{"1":"105404","2":"105408","3":"105410","4":"105414"}';
    elsif p_question_categ_code = 'HVACN' then
      v_str1 := '{"1":"105601","2":"105602","3":"105603"}';
    elsif p_question_categ_code = 'HVART' then
      v_str1 := '{"1":"105802","2":"105807","3":"105810","4":"105811"}';
    elsif p_question_categ_code = 'FHNMR' then
      v_str1 := '{"1":"106003","2":"106008","3":"106017","4":"106024","5":"106029","6":"106036","7":"106043","8":"106050","9":"106057","10":"106064","11":"106071","12":"106078","13":"106085","14":"106092"}';
    elsif p_question_categ_code = 'HENMT' then
      v_str1 := '{"1":"106401","2":"106405","3":"106406","4":"106407"}';
    elsif p_question_categ_code = 'MUSCS' then
      v_str1 := '{"1":"106601","2":"106605","3":"106607"}';
    elsif p_question_categ_code = 'CLHTS' then
      v_str1 := '{"1":"106801","2":"106802"}';
    elsif p_question_categ_code = 'NEPYS' then
      v_str1 := '{"1":"107004","2":"107006","3":"107007"}';
    elsif p_question_categ_code = 'GASTS' then
      v_str1 := '{"1":"107053","2":"107056"}';
    elsif p_question_categ_code = 'SKINS' then
      v_str1 := '{"1":"107103"}';
    elsif p_question_categ_code = 'OTHRS' then
      v_str1 := '{}';
    elsif p_question_categ_code = 'BEHVT' then
      v_str1 := '{"1":"101801","2":"101804","3":"101812","4":"101817","5":"101821","6":"101827","7":"101828","8":"101830","9":"101834","10":"101836","11":"101837","12":"101840","13":"101842","14":"101846","15":"101848","16":"101849","17":"101852","18":"101855","19":"101859"}';
    elsif p_question_categ_code = 'HSLFA' then
      v_str1 := '{"1":"100202","2":"100206","3":"100209"}';
    elsif p_question_categ_code = 'PSYSD' then
      v_str1 := '{"1":"100404","2":"100405","3":"100410","4":"100414","5":"100419","6":"100424","7":"100427","8":"100432","9":"100434","10":"100437","11":"100444","12":"100448","13":"100450","14":"100456","15":"100458","16":"100462","17":"100466","18":"100471","19":"100475","20":"100479","21":"100482"}';
    elsif p_question_categ_code = 'SLFHQ' then
      v_str1 := '{"1":"100802","2":"100804","3":"100805"}';
    elsif p_question_categ_code = 'LONLS' then
      v_str1 := '{"1":"101402","2":"101406","3":"101408","4":"101411","5":"101413","6":"101418"}';
    elsif p_question_categ_code = 'ADLBF' then
      v_str1 := '{"1":"102001","2":"102003","3":"102005","4":"102007","5":"102009","6":"102011"}';
    elsif p_question_categ_code = 'IADLB' then
      v_str1 := '{"1":"103403","2":"103406","3":"103410","4":"103415","5":"103419","6":"103422","7":"103425","8":"103430"}';
    elsif p_question_categ_code = 'MOOD1' then
      v_str1 := '{"1":"109002","2":"109004","3":"109005","4":"109008","5":"109010","6":"109012","7":"109014","8":"109016","9":"109018","10":"109020","11":"109022","12":"109024","13":"109026","14":"109028","15":"109029","16":"109034","17":"109036"}';
    elsif p_question_categ_code = 'FALLR' then
      v_str1 := '{"1":"107403","2":"107404","3":"107406","4":"107409","5":"107411","6":"107413"}';
    elsif p_question_categ_code = 'HOMES' then
      v_str1 := '{"1":"108002","2":"108003","3":"108006","4":"108008","5":"108010","6":"108012","7":"108013","8":"108016","9":"108017"}';
    elsif p_question_categ_code = 'COGND' then
      v_str1 := '{"1":"108201","2":"108203","3":"108206","4":"108207","5":"108209","6":"108211","7":"108214"}';
    elsif p_question_categ_code = 'MEDCP' then
      v_str1 := '{"1":"109201","2":"109203","3":"109206","4":"109208"}';
    elsif p_question_categ_code = 'DIZZI' then
      v_str1 := '{"1":"107602","2":"107604","3":"107606","4":"107607","5":"107609","6":"107612","7":"107613","8":"107615","9":"107618","10":"107620","11":"107622","12":"107623","13":"107626"}';
    elsif p_question_categ_code = 'HHISQ' then
      v_str1 := '{"1":"107802","2":"107806","3":"107809","4":"107811","5":"107814","6":"107817","7":"107820","8":"107824","9":"107827","10":"107829"}';
    elsif p_question_categ_code = 'ANXIT' then
      v_str1 := '{"1":"100601","2":"100604","3":"100605","4":"100609","5":"100611","6":"100613","7":"100616"}';
    elsif p_question_categ_code = 'HRSTS' then
      v_str1 := '{"1":"101208","2":"101215"}';
    elsif p_question_categ_code = 'GERDS' then
      v_str1 := '{"1":"101002","2":"101003","3":"101005","4":"101007","5":"101010","6":"101011","7":"101014","8":"101015","9":"101017","10":"101020","11":"101022","12":"101023","13":"101025","14":"101027","15":"101029"}';
    elsif p_question_categ_code = 'FRLTY' then
      v_str1 := '{"1":"101601"}';
    elsif p_question_categ_code = 'FRLT1' then
      v_str1 := '{"1":"108603","2":"108608","3":"108611","4":"108616","5":"108623","6":"108628"}';
    elsif p_question_categ_code = 'FRLT2' then
      v_str1 := '{"1":"108802","2":"108806","3":"108810","4":"108814","5":"108818","6":"108822"}';
    end if;
    return v_str1;
  end patient_response;
  --
  function patient_prev_svc_remark return varchar2 is
  begin
    return '{
                "REMARK_NOTE" : "Test remark 1",
                "PATIENT_PREV_SVC_SN" : 2
            }';
  end patient_prev_svc_remark;
  --
  function physician_em return varchar2 is
  begin
    return '{
                "PATIENT_PREV_SVC_SN" : 3,
                "TEMP_IN_FAHRENHEIT" : 101.5,
                "SYSTOLIC_BP_IN_MM" : 130,
                "DIASTOLIC_BP_IN_MM" : 90,
                "PULSE_RATE_IN_BPM" : 12,
                "RESPIRATORY_RATE_IN_BPM" : 13,
                "RHYTHM_IND" : "R",
                "PREVENTATIVE_SCHEDULING" : "Test",
                "LAB_AND_TEST_PRESCRIBED" : "Test",
                "REFERRALS_TO_SPECIALIST" : "test",
                "RX_MAJ_DIS_OR_HEALTH_EVENT" : null,
                "RX_PREV_SVC_BILLING_CODE" : "99490"
            }';
  end physician_em;
  --
  function physician_em_schedule return varchar2 is
  begin
    return '{
                "PATIENT_PREV_SVC_SN" : 2,
                "REQUEST_EM_PERF_BY_PCP_FLAG" : "N",
                "COMMENT_WHEN_DENY_EM" : "",
                "EM_FOLLOWUP_SVC_DATE" : "2017-08-30",
                "EM_FOLLOWUP_SVC_HR_CODE" : "10",
                "EM_FOLLOWUP_SVC_MIN_CODE" : "00",
                "EM_FOLLOWUP_SVC_AM_PM_CODE" : "AM"
            }';
  end physician_em_schedule;
  --
  function physician_em_name return varchar2 is
  begin
      return '{"1":"100003","2":"100006","3":"100109","4":"100305","5":"100418"}';
  end physician_em_name;
  --
  function provider_ccm return varchar2 is
  begin
    return '{
                "PATIENT_PREV_SVC_SN" : 2,
                "SYMPTOM_COMMENT" : "SYMPTOM_COMMENT",
                "MEDICATION_COMMENT" : "MEDICATION_COMMENT",
                "FAMILY_PMHX_COMMENT" : "FAMILY_PMHX_COMMENT",
                "RF_COMMENT" : "RF_COMMENT",
                "DISEASE_COMMENT" : "DISEASE_COMMENT",
                "ADDITIONAL_NOTES" : "ADDITIONAL_NOTES",
                "CCM_FOLLOWUP_SVC_DATE" : "2017-09-30",
                "CCM_FOLLOWUP_SVC_HR_CODE" : "11",
                "CCM_FOLLOWUP_SVC_MIN_CODE" : "30",
                "CCM_FOLLOWUP_SVC_AM_PM_CODE" : "AM"
            }';
  end provider_ccm;
  --
  function patient_medication return varchar2 is
  begin
    return '{
            "NAME": "Test2",
            "QUANTITY": 80,
            "QUANTITY_UNIT_CODE": "MG",
            "INGREDIENTS": null,
            "PURPOSE": "Blood Pressure",
            "FREQUENCY_UNIT": "D2",
            "NOTES": "Test",
            "CURRENT": "Y",
            "PRESCRIBED_MED_FLAG": "Y",
            "CREATED_BY_USERNAME": "mazharul.haque2@gmail.com",
            "PATIENT_SN": 61
          }';
  end patient_medication;  
  --
  function physician_svc_location return varchar2 is
  begin
    return '{
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "PHYSICIAN_SN" : 2,
                "SVC_LOCATION_SN" : 2
            }';
  end physician_svc_location;
  --
  function patient_prev_svc return varchar2 is
  begin
    return '{
             "PHYSICIAN_SVC_LOCATION_SN": 2,
             "PATIENT_SN": 3,
             "PREV_SVC_BILLING_CODE": "99202",
             "SVC_DATE": "2017-09-14",
             "SVC_HR_CODE": "04",
             "SVC_MIN_CODE": "03",
             "SVC_AM_PM_CODE": "PM",
             "PROVIDER_PHYSICIAN_SN": 4,
             "CREATED_BY_USERNAME": "mazharul.haque2@gmail.com",
             "G0438_COMP_ON_DIFF_SYS_FLAG": "N",
             "INSURANCE_COMPANY_CODE": "MEDB"
            }';
  end patient_prev_svc;
  --
  function company return varchar2 is
  begin
    return '{
                "NAME" : "ITH Inc",
                "CONTACT_NAME" : "Mazharul Haque",
                "PHONE_NUMBER" : "1235554440",
                "FAX_NUMBER" : "1235554441",
                "TOLL_FREE_NUMBER" : "8005554440",
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "WEBSITE_ADDR" : "www.ith.com"
            }';
  end company;
  --
  function patient return varchar2 is
  begin
    return '{
                "SSN" : "666666666",
                "PHYSICIAN_SN" : 2,
                "MEDICARE_HIC_NUM" : "H666666666",
                "GENDER_CODE" : "MAL",
                "RACE_CODE" : "ASIN",
                "ETHNICITY_CODE" : "NHIS",
                "FIRST_NAME" : "Jack",
                "LAST_NAME" : "Lyan",
                "MIDDLE_NAME" : null,
                "CONTACT_PHONE_NUM" : "9999999999",
                "EMAIL_ADDR" : null,
                "SKYPE_ID" : null,
                "BIRTH_DATE" : "1971-10-05",
                "LEGAL_GUARDIAN_NAME" : null,
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "LEGAL_GUARDIAN_PH" : null
            }';
  end patient;
  --
  function patient_prev_svc_demo return varchar2 is
  begin
    return '{
                "PATIENT_PREV_SVC_SN" : 2,
                "MARITAL_STATUS_CODE" : "MRD",
                "WORKING_STATUS_CODE" : "RET",
                "EDUCATION_LEVEL_CODE" : "UNIV",
                "FINANCIAL_STATUS_CODE" : "ONFA",
                "LIVING_STATUS_CODE" : "NURH",
                "INCOME_CODE" : "6080",
                "HEIGHT_IN_IN" : 5.11,
                "WEIGHT_IN_LB" : 160,
                "HDL_CHOLESTEROL_IN_MG" : 45,
                "LDL_CHOLESTEROL_IN_MG" : 140,
                "SYSTOLIC_BP_IN_MM" : 130,
                "DIASTOLIC_BP_IN_MM" : 90,
                "BLOOD_SUGAR_LEVEL_IN_MG" : 140,
                "SOURCE_OF_HISTORY_EMR_FLAG" : "Y",
                "SOURCE_OF_HISTORY_PATIENT_FLAG" : "N",
                "SOURCE_OF_HISTORY_FAMILY_FLAG" : null,
                "PATIENT_ORIENTATION_CODE" : "AO4",
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com"
            }';
  end patient_prev_svc_demo;
  --
  function physician return varchar2 is
  begin
    return '{
                "NPI" : 9998889999,
                "LICENSE_NUM" : "AB11111",
                "TITLE" : "Mr",
                "PHYSICIAN_TYPE_CODE" : "NUP",
                "SKYPE_ID" : null,
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "COMPANY_SN" : 6,
                "FIRST_NAME" : "Srinivas",
                "LAST_NAME" : "Gujja",
                "MIDDLE_NAME" : null,
                "CONTACT_PHONE_NUM" : "9546546785",
                "EMAIL_ADDR" : "sgujja@gmail.com",
                "DR_TYPE_CODE" : "DO"
            }';
  end physician;
  --
  function provider_physician return varchar2 is
  begin
    return '{
                "NPI" : 111111111,
                "LICENSE_NUM" : "AB22222",
                "TITLE" : "Mr",
                "PHYSICIAN_TYPE_CODE" : "NUP",
                "SKYPE_ID" : null,
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "PHYSICIAN_USER_ROLE_ID" : "71D63EA9D7BB4A13A6C742ED2A3A6C04",
                "COMPANY_SN" : 5,
                "FIRST_NAME" : "James",
                "LAST_NAME" : "Don",
                "MIDDLE_NAME" : null,
                "CONTACT_PHONE_NUM" : "9545466785",
                "EMAIL_ADDR" : "john@gmail.com",
                "DR_TYPE_CODE" : null
            }';
  end provider_physician;
  --
  function svc_location return varchar2 is
  begin
    return '{
                "COMPANY_SN" : 21,
                "NAME" : "Willow Manor Retirement Living",
                "SVC_LOCATION_TYPE_CODE" : "ASLF",
                "CONTACT_NAME" : "Mr Peter Doe",
                "PHONE_NUM_1" : "9996667777",
                "PHONE_NUM_2" : null,
                "FAX_NUM_1" : "9996667778",
                "FAX_NUM_2" : null,
                "CREATED_BY_USERNAME" : "mazharul.haque2@gmail.com",
                "EMAIL_ADDR" : null
            }';
  end svc_location;
  --
  function mbr return varchar2 is
  begin
    return '{
              "EMAIL" : "abc@gmail.com",
              "EMAILCONFIRMED" : 1,
              "PASSWORDHASH" : "afjadfjkadfjkadl",
              "SECURITYSTAMP" : null,
              "PHONENUMBER" : "9549993333",
              "PHONENUMBERCONFIRMED" : null,
              "TWOFACTORENABLED" : null,
              "LOCKOUTENDDATEUTC" : null,
              "LOCKOUTENABLED" : null,
              "ACCESSFAILEDCOUNT" : null,
              "USERNAME" : "abc@gmail.com",
              "PARENT_ID" : null,
              "HOME_PHONE_NUM" : null,
              "BUSINESS_PHONE_NUM" : null,
              "FIRST_NAME" : "Mazharul",
              "LAST_NAME" : "Haque",
              "MIDDLE_NAME" : null,
              "GENDER_CODE" : "M",
              "ABOUT_PROV" : null,
              "BIRTH_DATE" : null,
              "ADDR_SN" : null,
              "RESPONSE_RATE" : null,
              "RESPONSE_TIME" : null,
              "HOSTING_STORY" : null,
              "TERMS_AND_COND_ACCEPTANCE" : null,
              "RECEIVE_NEWS_LETTER" : null,
              "ALT_EMAIL" : null,
              "USER_CREATED_REC" : "Y"
            }';
  end mbr;
  --
  function contact_us return varchar2 is
  begin
    return '{
                "FIRST_NAME" : "John",
                "LAST_NAME" : "Doe",
                "EMAIL" : "test@gmail.com",
                "PHONE_NUMBER" : "99999999",
                "SUBJECT" : "Test subject",
                "MESSAGE" : "Test message"
            }';
  end contact_us;
  --
  function addr_json_str (p_str varchar2) return varchar2 is
      v_str1 varchar2(32767) :=  '{
                                    "ADDR_1" : "103 Willow Rd",
                                    "ADDR_2" : null,
                                    "CITY" : "Coral Springs",
                                    "STATE_CODE" : "FL",
                                    "POSTAL_CODE" : "33076",
                                    "COUNTRY_CODE" : "US"
                                  }';
      v_str2 varchar2(32767) := '{
           "results" : [
              {
                 "address_components" : [
                    {
                       "long_name" : "6860",
                       "short_name" : "6860",
                       "types" : [ "street_number" ]
                    },
                    {
                       "long_name" : "North 19th Avenue",
                       "short_name" : "N 19th Ave",
                       "types" : [ "route" ]
                    },
                    {
                       "long_name" : "Alhambra",
                       "short_name" : "Alhambra",
                       "types" : [ "neighborhood", "political" ]
                    },
                    {
                       "long_name" : "Phoenix",
                       "short_name" : "Phoenix",
                       "types" : [ "locality", "political" ]
                    },
                    {
                       "long_name" : "Maricopa County",
                       "short_name" : "Maricopa County",
                       "types" : [ "administrative_area_level_2", "political" ]
                    },
                    {
                       "long_name" : "Arizona",
                       "short_name" : "AZ",
                       "types" : [ "administrative_area_level_1", "political" ]
                    },
                    {
                       "long_name" : "United States",
                       "short_name" : "US",
                       "types" : [ "country", "political" ]
                    },
                    {
                       "long_name" : "85015",
                       "short_name" : "85015",
                       "types" : [ "postal_code" ]
                    }
                 ],
                 "formatted_address" : "6860 North 19th Avenue, Phoenix, AZ 85015, USA",
                 "geometry" : {
                    "bounds" : {
                       "northeast" : {
                          "lat" : 33.5375421,
                          "lng" : -112.0995941
                       },
                       "southwest" : {
                          "lat" : 33.537542,
                          "lng" : -112.0996125
                       }
                    },
                    "location" : {
                       "lat" : 33.5375421,
                       "lng" : -112.0996125
                    },
                    "location_type" : "RANGE_INTERPOLATED",
                    "viewport" : {
                       "northeast" : {
                          "lat" : 33.5388910302915,
                          "lng" : -112.0982543197085
                       },
                       "southwest" : {
                          "lat" : 33.5361930697085,
                          "lng" : -112.1009522802915
                       }
                    }
                 },
                 "place_id" : "Ei42ODYwIE5vcnRoIDE5dGggQXZlbnVlLCBQaG9lbml4LCBBWiA4NTAxNSwgVVNB",
                 "types" : [ "street_address" ]
              }
           ],
           "status" : "OK"
        }';
  begin
    if p_str = 'custom_addr' then
      return v_str1;
    elsif p_str = 'google_addr' then
      return v_str2;
    end if;
  end addr_json_str;
END return_json_pkg;
/
SHOW ERRORS  