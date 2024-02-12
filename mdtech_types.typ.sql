DROP TYPE t_poi_tab;
drop type t_poi_obj;
DROP TYPE t_number_tab;
drop type t_number_obj;
DROP TYPE t_string_tab;
drop type t_string_obj;
drop type t_holiday_cal_tab;
drop type t_holiday_cal_obj;
DROP TYPE t_img_tab;
drop type t_img_obj;
drop type t_question_response_code_tab;
drop type t_question_response_code_obj;
drop type t_em_name_code_tab;
drop type t_em_name_code_obj;
drop type t_ccm_question_code_tab;
drop type t_ccm_question_code_obj;
drop type t_patient_prev_svc_remark_tab;
drop type t_patient_prev_svc_remark_obj;
drop type t_patient_medication_tab;
drop type t_patient_medication_obj;
drop type t_svc_result_tab;
drop type t_svc_result_obj;
drop type t_symptom_tab;
drop type t_symptom_obj;
drop type t_risk_factor_tab;
drop type t_risk_factor_obj;
------
create TYPE t_poi_obj AS OBJECT
(
   geonameid NUMBER (15,0)
  ,lat_lon NUMBER (20,15)
);
/
create TYPE t_poi_tab IS TABLE OF t_poi_obj;
/
------------
create TYPE t_number_obj AS OBJECT
(
   number_code number(11)
);
/
create TYPE t_number_tab IS TABLE OF t_number_obj;
/
----------
create TYPE t_string_obj AS OBJECT
(
   string_code varchar2(30)
);
/
create TYPE t_string_tab IS TABLE OF t_string_obj;
/
--
create TYPE t_holiday_cal_obj AS OBJECT
(
   holiday_code varchar2(5)
  ,holiday_name varchar2(100)
  ,holiday_date date
  ,holiday_day varchar2(30)
  ,holiday_rule varchar2(200)
);
/
create TYPE t_holiday_cal_tab IS TABLE OF t_holiday_cal_obj;
/

----------
create TYPE t_img_obj AS OBJECT
(  image_table_code varchar2(5)
  ,IMAGE_SHORT_DESCR VARCHAR2(100 BYTE)
  ,IMAGE_LONG_DESCR VARCHAR2(4000 BYTE)
  ,ASPECT_RATIO VARCHAR2(30 BYTE)
  ,RESOLUTION_PIXELS_PER_IN NUMBER(3,0)
  ,PIXEL_DIMENSION_W NUMBER(5,0)
  ,PIXEL_DIMENSION_H NUMBER(5,0)
  ,image blob
  ,file_name varchar2(200)
  ,feature_type_code number(5)
  ,room_type_code varchar2(3)
  ,image_sn number(11)
  ,image_content_type varchar2(50)
);
/
create TYPE t_img_tab IS TABLE OF t_img_obj;
/
create TYPE t_question_response_code_obj AS OBJECT
(question_response_code varchar2(6)
);
/
create TYPE t_question_response_code_tab IS TABLE OF t_question_response_code_obj;
/
--=====================
create TYPE t_patient_prev_svc_remark_obj AS OBJECT
(REMARK_NOTE NVARCHAR2(2000)
);
/
create TYPE t_patient_prev_svc_remark_tab IS TABLE OF t_patient_prev_svc_remark_obj;
/
--======================
create TYPE t_patient_medication_obj AS OBJECT
(NAME	NVARCHAR2(200)
,MEDICATION_QUANTITY number(4)
,MEDICATION_UNIT_CODE varchar2(2)
,INGREDIENTS	NVARCHAR2(200)
,PURPOSE	NVARCHAR2(200)
,FREQUENCY_UNIT_CODE	VARCHAR2(2)
,MEDICATION_CURRENT_FLAG	VARCHAR2(1)
,prescribed_med_flag varchar2(1)
,NOTES	NVARCHAR2(2000)
);
/
create TYPE t_patient_medication_tab IS TABLE OF t_patient_medication_obj;
/
--
create TYPE t_em_name_code_obj AS OBJECT
(em_name_code varchar2(6)
);
/
create TYPE t_em_name_code_tab IS TABLE OF t_em_name_code_obj;
/
--
create TYPE t_ccm_question_code_obj AS OBJECT
(ccm_question_code varchar2(6)
);
/
create TYPE t_ccm_question_code_tab IS TABLE OF t_ccm_question_code_obj;
/
--
create TYPE t_svc_result_obj AS OBJECT
(patient_prev_svc_sn number(11)
,disease_code varchar2(4)
,disease_short_descr nvarchar2(100)
,trigger_ccm_flag varchar2(1)
,disease_level_code varchar2(3)
,dis_level_short_descr nvarchar2(100)
,disease_severity_code varchar2(5)
,dis_severity_short_descr nvarchar2(100)
,disease_long_descr nvarchar2(1000)
,disease_type_code varchar2(4)
,dis_type_short_descr nvarchar2(100)
,disease_categ_code varchar2(4)
,dis_cat_short_descr nvarchar2(100)
,dis_cat_long_descr nvarchar2(1000)
,question_score_type_code varchar2(2)
);
/
create TYPE t_svc_result_tab IS TABLE OF t_svc_result_obj;
/
--
create TYPE t_symptom_obj AS OBJECT
(symptom_code varchar2(4)
,symp_short_descr varchar2(100)
);
/
create TYPE t_symptom_tab IS TABLE OF t_symptom_obj;
/
--
create TYPE t_risk_factor_obj AS OBJECT
(risk_factor_code varchar2(4)
,rf_short_descr varchar2(100)
);
/
create TYPE t_risk_factor_tab IS TABLE OF t_risk_factor_obj;
/
show errors
