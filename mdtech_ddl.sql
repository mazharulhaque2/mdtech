--Dropped forever
drop table roles_priviledge_grouping purge;
--
drop table roles_priviledge purge;
drop table priviledge_ui purge;
--Dropped forever
drop table priviledge_grouping_priv purge;
--
drop table ui_lang purge;
drop table list_ui purge;
----Dropped forever
drop table priviledge_grouping_lang purge;
drop table list_priviledge_grouping purge;
--Dropped forever
drop table priviledge_grouping_type_lang purge;
drop table list_priviledge_grouping_type purge;
--
drop table report_lang purge;
drop table list_report purge;
drop table report_template_lang purge;
drop table list_report_template purge;
--
drop table priviledge_lang purge;
drop table list_priviledge purge;
drop table priviledge_type_lang purge;
drop table list_priviledge_type purge;
-------------------==================++++++Drop+++++==============================
--EM related drop start---------------=========================================
drop TABLE svc_result_rpt purge;
drop table svc_result purge;
--
drop table missing_goals_reason_lang purge;
drop table list_missing_goals_reason purge;
drop table rf_missing_goals_reason purge;
drop table svc_counseling_rf_mg_reason purge;
drop table svc_counseling purge;
drop table svc_risk_factor_remark purge;
drop table rf_counseling_categ_lang purge;
drop table list_rf_counseling_categ purge;
-------------------------------------------PHSYCIAN EM and CCM
drop table physician_em_name purge;
drop table physician_em purge;
drop table em_name_lang purge;
drop table list_em_name purge;
drop table em_categ_lang purge;
drop table list_em_categ purge;
--
drop table provider_ccm_question purge;
drop table provider_ccm purge;
drop table ccm_question_lang purge;
drop table list_ccm_question purge;
drop table ccm_question_categ_lang purge;
drop table list_ccm_question_categ purge;
-------------------------------------------
--EM related drop end---------------=========================================
--Patient Prev Servic related drop start--------==================================+++++++++++++++++++++++
drop table patient_prev_svc_remark purge;
drop table remark_categ_grp_lang purge;
drop table list_remark_categ_grp purge;
drop table patient_response purge;
drop table patient_history purge;
drop table patient_svc_prov purge;
drop table patient_svc_prov_cat_lang purge;
drop table list_patient_svc_prov_categ purge;
drop table patient_prev_svc purge;
--Patient Prev Servic related drop end--------==================================+++++++++++++++++++++++
--Patient Response RESULT related drop start--------================
--Patient Response RESULT related drop end--------================
--Patient related drop start--------==================================+++++++++++++++++++++++
drop table patient_medication purge;
drop table frequency_unit_lang purge;
drop table list_frequency_unit purge;
drop table patient purge;
drop table education_level_lang purge;
drop table list_education_level purge;
drop table gender_lang purge;
drop table list_gender purge;
drop table ethnicity_lang purge;
drop table list_ethnicity purge;
drop table race_lang purge;
drop table list_race purge;
drop table income_lang purge;
drop table list_income purge;
drop table working_status_lang purge;
drop table list_working_status purge;
drop table marital_status_lang purge;
drop table list_marital_status purge;
drop table financial_status_lang purge;
drop table list_financial_status purge;
drop table living_status_lang purge;
drop table list_living_status purge;
drop table cholesterol_lang purge;
drop table list_cholesterol purge;
drop table systolic_bp_lang purge;
drop table list_systolic_bp purge;
drop table diastolic_bp_lang purge;
drop table list_diastolic_bp purge;
drop table weight_lang purge;
drop table list_weight purge;
drop table height_lang purge;
drop table list_height purge;
drop table blood_sugar_level_lang purge;
drop table list_blood_sugar_level purge;
drop table patient_orientation_lang purge;
drop table list_patient_orientation purge;
--Patient related drop end--------==================================+++++++++++++++++++++++
--Service Location related drop start--------==================================+++++++++++++++++++++++
drop table physician_svc_location purge;
drop table user_svc_location purge;
drop table user_company purge;
drop table user_physician purge;
drop table svc_location purge;
drop table svc_location_type_lang purge;
drop table list_svc_location_type purge;
--Service Location related drop end--------==================================+++++++++++++++++++++++
--Physician related drop start--------==================================+++++++++++++++++++++++
drop table physician purge;
drop table provider_physician purge;
drop table company purge;
--Drop forever
drop table prev_svc_physician_type purge;
drop table physician_type_lang purge;
drop table list_physician_type purge;
--Physician related drop end--------==================================+++++++++++++++++++++++
--Question related drop start--------=========================
drop table question_response purge;
drop table question_lang purge;
drop table question purge;
drop table svc_billing_question_categ purge;
drop table categ_score_eval_lang purge;
drop table categ_score_eval purge;
drop table question_sub_categ_lang purge;
drop table list_question_sub_categ purge;
drop table question_categ_lang purge;
drop table list_question_categ purge;
drop table list_categ_condition purge;
drop table prev_svc_billing_lang purge;
drop table list_prev_svc_billing purge;
drop table billing_type_lang purge;
drop table list_billing_type purge;
drop table svc_rpt_type_lang purge;
drop table list_svc_rpt_type purge;
drop table prev_svc_type_lang purge;
drop table list_prev_svc_type purge;
drop table question_categ_grp_lang purge;
drop table list_question_categ_grp purge;
drop table list_question_score_type purge;
drop table response_lang purge;
drop table list_response purge;
--================================disease and risk factor
drop table disease_risk_factor purge;
drop table risk_factor_lang purge;
drop table list_risk_factor purge;
drop table risk_factor_categ_lang purge;
drop table list_risk_factor_categ purge;
drop table severity_lang purge;
drop table list_severity purge;
--
drop table disease_severity_lang purge;
drop table list_disease_severity purge;
drop table disease_level_lang purge;
drop table list_disease_level purge;
--
drop table disease_symptom purge;
drop table symptom_lang purge;
drop table list_symptom purge;
drop table symptom_categ_lang purge;
drop table list_symptom_categ purge;
--
drop table disease_lang purge;
drop table list_disease purge;
drop table disease_categ_lang purge;
drop table list_disease_categ purge;
drop table disease_type_lang purge;
drop table list_disease_type purge;
--
drop table list_hr purge;
drop table list_min purge;
drop table list_am_pm purge;
--
drop table risk_factor_prev_plan purge;
drop table disease_prev_plan purge;
drop table prev_plan_lang purge;
drop table list_prev_plan purge;
drop table contact_us purge;
drop table deleted_patient_response purge;
drop table deleted_patient_prev_svc purge;
drop table deleted_pps_remark purge;
drop table dr_type_lang purge;
drop table list_dr_type purge;
--================================
drop table insurance_company purge;
drop table temp_output purge;
--=================================Temp table-------------------
CREATE TABLE temp_output
    (out_clob clob
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
--========================================
--Question related drop end--------=========================
-------------------==================++++++Create+++++==============================
--======================================
CREATE TABLE insurance_company
    (insurance_company_code varchar2(4)
    ,order_num  number(9)
    ,name varchar2(200)
    ,website varchar2(300)
    ,phone_num varchar2(20)
    ,fax_num varchar2(20)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE insurance_company ADD CONSTRAINT insurance_company_PK
PRIMARY KEY (insurance_company_code);
--======================================
CREATE TABLE list_dr_type
    (dr_type_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_dr_type ADD CONSTRAINT list_dr_type_PK
PRIMARY KEY (dr_type_code);
--
CREATE TABLE dr_type_lang
    (dr_type_lang_sn number(11)
    ,dr_type_code varchar2(2) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE dr_type_lang ADD CONSTRAINT dr_type_lang_PK
PRIMARY KEY (dr_type_lang_sn);
--
ALTER TABLE  dr_type_lang ADD CONSTRAINT  dr_type_lang_FK1
FOREIGN KEY (dr_type_code) REFERENCES list_dr_type (dr_type_code);
--
ALTER TABLE dr_type_lang ADD CONSTRAINT dr_type_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX dr_type_lang_ak1
ON dr_type_lang (dr_type_code,lang_code);
--======================================
CREATE TABLE list_medication_unit
    (medication_unit_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_medication_unit ADD CONSTRAINT list_medication_unit_PK
PRIMARY KEY (medication_unit_code);
--
CREATE TABLE medication_unit_lang
    (medication_unit_lang_sn number(11)
    ,medication_unit_code varchar2(2) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE medication_unit_lang ADD CONSTRAINT medication_unit_lang_PK
PRIMARY KEY (medication_unit_lang_sn);
--
ALTER TABLE  medication_unit_lang ADD CONSTRAINT  medication_unit_lang_FK1
FOREIGN KEY (medication_unit_code) REFERENCES list_medication_unit (medication_unit_code);
--
ALTER TABLE medication_unit_lang ADD CONSTRAINT medication_unit_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX medication_unit_lang_ak1
ON medication_unit_lang (medication_unit_code,lang_code);
--=========================================disease and risk factor DDL Begin=============================================================================
--======================================
CREATE TABLE list_disease_type
    (disease_type_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_disease_type ADD CONSTRAINT list_disease_type_PK
PRIMARY KEY (disease_type_code);
--
CREATE TABLE disease_type_lang
    (disease_type_lang_sn number(11)
    ,disease_type_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_type_lang ADD CONSTRAINT disease_type_lang_PK
PRIMARY KEY (disease_type_lang_sn);
--
ALTER TABLE  disease_type_lang ADD CONSTRAINT  disease_type_lang_FK1
FOREIGN KEY (disease_type_code) REFERENCES list_disease_type (disease_type_code);
--
ALTER TABLE disease_type_lang ADD CONSTRAINT disease_type_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX disease_type_lang_ak1
ON disease_type_lang (disease_type_code,lang_code);
--======================================
CREATE TABLE list_disease_categ
    (disease_categ_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_disease_categ ADD CONSTRAINT list_disease_categ_PK
PRIMARY KEY (disease_categ_code);
--
CREATE TABLE disease_categ_lang
    (disease_categ_lang_sn number(11)
    ,disease_categ_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_categ_lang ADD CONSTRAINT disease_categ_lang_PK
PRIMARY KEY (disease_categ_lang_sn);
--
ALTER TABLE  disease_categ_lang ADD CONSTRAINT  disease_categ_lang_FK1
FOREIGN KEY (disease_categ_code) REFERENCES list_disease_categ (disease_categ_code);
--
ALTER TABLE disease_categ_lang ADD CONSTRAINT disease_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX disease_categ_lang_ak1
ON disease_categ_lang (disease_categ_code,lang_code);
--======================================
CREATE TABLE list_disease
    (disease_code varchar2(4)
    ,disease_categ_code varchar2(4) not null
    ,disease_type_code varchar2(4) not null
    ,trigger_ccm_flag varchar2(1) DEFAULT 'N' NOT NULL
    .question_categ_code varchar2(5)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_disease ADD CONSTRAINT list_disease_PK
PRIMARY KEY (disease_code);
--
ALTER TABLE  list_disease ADD CONSTRAINT  list_disease_FK1
FOREIGN KEY (disease_categ_code) REFERENCES list_disease_categ (disease_categ_code);
--
ALTER TABLE  list_disease ADD CONSTRAINT  list_disease_FK2
FOREIGN KEY (disease_type_code) REFERENCES list_disease_type (disease_type_code);
--
ALTER TABLE list_disease ADD CONSTRAINT list_disease_FK3
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
CREATE TABLE disease_lang
    (disease_lang_sn number(11)
    ,disease_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_lang ADD CONSTRAINT disease_lang_PK
PRIMARY KEY (disease_lang_sn);
--
ALTER TABLE  disease_lang ADD CONSTRAINT  disease_lang_FK1
FOREIGN KEY (disease_code) REFERENCES list_disease (disease_code);
--
ALTER TABLE disease_lang ADD CONSTRAINT disease_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX disease_lang_ak1
ON disease_lang (disease_code,lang_code);
--======================================
CREATE TABLE list_risk_factor_categ
    (risk_factor_categ_code varchar2(3)
    ,diet_categ_flag       VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_risk_factor_categ ADD CONSTRAINT list_risk_factor_categ_PK
PRIMARY KEY (risk_factor_categ_code);
--
CREATE TABLE risk_factor_categ_lang
    (risk_factor_categ_lang_sn number(11)
    ,risk_factor_categ_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE risk_factor_categ_lang ADD CONSTRAINT risk_factor_categ_lang_PK
PRIMARY KEY (risk_factor_categ_lang_sn);
--
ALTER TABLE  risk_factor_categ_lang ADD CONSTRAINT  risk_factor_categ_lang_FK1
FOREIGN KEY (risk_factor_categ_code) REFERENCES list_risk_factor_categ (risk_factor_categ_code);
--
ALTER TABLE risk_factor_categ_lang ADD CONSTRAINT risk_factor_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX risk_factor_categ_lang_ak1
ON risk_factor_categ_lang (risk_factor_categ_code,lang_code);
--======================================
CREATE TABLE list_risk_factor
    (risk_factor_code varchar2(4)
    ,risk_factor_categ_code varchar2(3) not null
    ,risk_factor_is_a_disease_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_risk_factor ADD CONSTRAINT list_risk_factor_PK
PRIMARY KEY (risk_factor_code);
--
ALTER TABLE  list_risk_factor ADD CONSTRAINT  list_risk_factor_FK1
FOREIGN KEY (risk_factor_categ_code) REFERENCES list_risk_factor_categ (risk_factor_categ_code);
--
CREATE TABLE risk_factor_lang
    (risk_factor_lang_sn number(11)
    ,risk_factor_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE risk_factor_lang ADD CONSTRAINT risk_factor_lang_PK
PRIMARY KEY (risk_factor_lang_sn);
--
ALTER TABLE  risk_factor_lang ADD CONSTRAINT  risk_factor_lang_FK1
FOREIGN KEY (risk_factor_code) REFERENCES list_risk_factor (risk_factor_code);
--
ALTER TABLE risk_factor_lang ADD CONSTRAINT risk_factor_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX risk_factor_lang_ak1
ON risk_factor_lang (risk_factor_code,lang_code);
--======================================
CREATE TABLE list_severity
    (severity_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_severity ADD CONSTRAINT list_severity_PK
PRIMARY KEY (severity_code);
--
CREATE TABLE severity_lang
    (severity_lang_sn number(11)
    ,severity_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE severity_lang ADD CONSTRAINT severity_lang_PK
PRIMARY KEY (severity_lang_sn);
--
ALTER TABLE  severity_lang ADD CONSTRAINT  severity_lang_FK1
FOREIGN KEY (severity_code) REFERENCES list_severity (severity_code);
--
ALTER TABLE severity_lang ADD CONSTRAINT severity_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX severity_lang_ak1
ON severity_lang (severity_code,lang_code);
--======================================
CREATE TABLE disease_risk_factor
    (disease_risk_factor_sn number(11)
    ,disease_code varchar2(4) not null
    ,risk_factor_code varchar2(4) not null
    ,severity_code varchar2(4) not null
    ,PRIMARY_RISK_FACTOR_FLAG VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_risk_factor ADD CONSTRAINT disease_risk_factor_PK
PRIMARY KEY (disease_risk_factor_sn);
--
ALTER TABLE disease_risk_factor ADD CONSTRAINT disease_risk_factor_FK1
FOREIGN KEY (disease_code) REFERENCES  list_disease(disease_code);
--
ALTER TABLE disease_risk_factor ADD CONSTRAINT disease_risk_factor_FK2
FOREIGN KEY (risk_factor_code) REFERENCES  list_risk_factor(risk_factor_code);
--
ALTER TABLE  disease_risk_factor ADD CONSTRAINT  disease_risk_factor_FK3
FOREIGN KEY (severity_code) REFERENCES list_severity (severity_code);
--
CREATE unique INDEX disease_risk_factor_ak1
ON disease_risk_factor (disease_code,risk_factor_code);
--======================================
CREATE TABLE list_disease_severity
    (disease_severity_code varchar2(5)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_disease_severity ADD CONSTRAINT list_disease_severity_PK
PRIMARY KEY (disease_severity_code);
--
CREATE TABLE disease_severity_lang
    (disease_severity_lang_sn number(11)
    ,disease_severity_code varchar2(5) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_severity_lang ADD CONSTRAINT disease_severity_lang_PK
PRIMARY KEY (disease_severity_lang_sn);
--
ALTER TABLE  disease_severity_lang ADD CONSTRAINT  disease_severity_lang_FK1
FOREIGN KEY (disease_severity_code) REFERENCES list_disease_severity (disease_severity_code);
--
ALTER TABLE disease_severity_lang ADD CONSTRAINT disease_severity_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX disease_severity_lang_ak1
ON disease_severity_lang (disease_severity_code,lang_code);
--======================================
CREATE TABLE list_disease_level
    (disease_level_code varchar2(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_disease_level ADD CONSTRAINT list_disease_level_PK
PRIMARY KEY (disease_level_code);
--
CREATE TABLE disease_level_lang
    (disease_level_lang_sn number(11)
    ,disease_level_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_level_lang ADD CONSTRAINT disease_level_lang_PK
PRIMARY KEY (disease_level_lang_sn);
--
ALTER TABLE  disease_level_lang ADD CONSTRAINT  disease_level_lang_FK1
FOREIGN KEY (disease_level_code) REFERENCES list_disease_level (disease_level_code);
--
ALTER TABLE disease_level_lang ADD CONSTRAINT disease_level_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX disease_level_lang_ak1
ON disease_level_lang (disease_level_code,lang_code);
--======================================
CREATE TABLE list_symptom_categ
    (symptom_categ_code varchar2(5)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_symptom_categ ADD CONSTRAINT list_symptom_categ_PK
PRIMARY KEY (symptom_categ_code);
--
CREATE TABLE symptom_categ_lang
    (symptom_categ_lang_sn number(11)
    ,symptom_categ_code varchar2(5) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE symptom_categ_lang ADD CONSTRAINT symptom_categ_lang_PK
PRIMARY KEY (symptom_categ_lang_sn);
--
ALTER TABLE  symptom_categ_lang ADD CONSTRAINT  symptom_categ_lang_FK1
FOREIGN KEY (symptom_categ_code) REFERENCES list_symptom_categ (symptom_categ_code);
--
ALTER TABLE symptom_categ_lang ADD CONSTRAINT symptom_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX symptom_categ_lang_ak1
ON symptom_categ_lang (symptom_categ_code,lang_code);
--======================================
CREATE TABLE list_symptom
    (symptom_code varchar2(4)
    ,symptom_categ_code varchar2(5) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_symptom ADD CONSTRAINT list_symptom_PK
PRIMARY KEY (symptom_code);
--
ALTER TABLE  list_symptom ADD CONSTRAINT  list_symptom_FK1
FOREIGN KEY (symptom_categ_code) REFERENCES list_symptom_categ (symptom_categ_code);
--
CREATE TABLE symptom_lang
    (symptom_lang_sn number(11)
    ,symptom_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE symptom_lang ADD CONSTRAINT symptom_lang_PK
PRIMARY KEY (symptom_lang_sn);
--
ALTER TABLE  symptom_lang ADD CONSTRAINT  symptom_lang_FK1
FOREIGN KEY (symptom_code) REFERENCES list_symptom (symptom_code);
--
ALTER TABLE symptom_lang ADD CONSTRAINT symptom_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX symptom_lang_ak1
ON symptom_lang (symptom_code,lang_code);
--======================================
CREATE TABLE disease_symptom
    (disease_symptom_sn number(11)
    ,disease_code varchar2(4) not null
    ,symptom_code varchar2(4) not null
    ,severity_code varchar2(4) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE disease_symptom ADD CONSTRAINT disease_symptom_PK
PRIMARY KEY (disease_symptom_sn);
--
ALTER TABLE  disease_symptom ADD CONSTRAINT  disease_symptom_FK1
FOREIGN KEY (symptom_code) REFERENCES list_symptom (symptom_code);
--
ALTER TABLE  disease_symptom ADD CONSTRAINT  disease_symptom_FK2
FOREIGN KEY (disease_code) REFERENCES list_disease (disease_code);
--
ALTER TABLE  disease_symptom ADD CONSTRAINT  disease_symptom_FK3
FOREIGN KEY (severity_code) REFERENCES list_severity (severity_code);
--
CREATE unique INDEX disease_symptom_ak1
ON disease_symptom (disease_code,symptom_code);
--=========================================disease and risk factor DDL End===========================================================================
--role_priviledge related ddl start--------------------- (Menu DDL Begin)
--==================================================================
CREATE TABLE list_priviledge_type
    (priviledge_type_code varchar2(3)
    ,order_num  number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_priviledge_type ADD CONSTRAINT list_priviledge_type_PK
PRIMARY KEY (priviledge_type_code);
--
CREATE TABLE priviledge_type_lang
    (priviledge_type_lang_sn number(11)
    ,priviledge_type_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
    
ALTER TABLE priviledge_type_lang ADD CONSTRAINT priviledge_type_lang_PK
PRIMARY KEY (priviledge_type_lang_sn);
--
ALTER TABLE  priviledge_type_lang ADD CONSTRAINT  priviledge_type_lang_FK1
FOREIGN KEY (priviledge_type_code) REFERENCES list_priviledge_type (priviledge_type_code);
--
ALTER TABLE priviledge_type_lang ADD CONSTRAINT priviledge_type_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX priviledge_type_lang_ak1
ON priviledge_type_lang (priviledge_type_code,lang_code);
--==================================================================
CREATE TABLE list_priviledge
    (priviledge_code varchar2(4)
    ,priviledge_type_code varchar2(3) not null
    ,client_only_priviledge_flag varchar2(1) DEFAULT 'N' NOT NULL
    ,common_priviledge_flag varchar2(1) DEFAULT 'N' NOT NULL
    ,href varchar2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_priviledge ADD CONSTRAINT list_priviledge_PK
PRIMARY KEY (priviledge_code);
--
ALTER TABLE  list_priviledge ADD CONSTRAINT  list_priviledge_FK1
FOREIGN KEY (priviledge_type_code) REFERENCES list_priviledge_type (priviledge_type_code);
--
CREATE TABLE priviledge_lang
    (priviledge_lang_sn number(11)
    ,priviledge_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
 
ALTER TABLE priviledge_lang ADD CONSTRAINT priviledge_lang_PK
PRIMARY KEY (priviledge_lang_sn);
--
ALTER TABLE  priviledge_lang ADD CONSTRAINT  priviledge_lang_FK1
FOREIGN KEY (priviledge_code) REFERENCES list_priviledge (priviledge_code);
--
ALTER TABLE priviledge_lang ADD CONSTRAINT priviledge_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX priviledge_lang_ak1
ON priviledge_lang (priviledge_code,lang_code);
--==================================================================
CREATE TABLE list_ui
    (ui_code varchar2(4)
    ,href varchar2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_ui ADD CONSTRAINT list_ui_PK
PRIMARY KEY (ui_code);
--
CREATE TABLE ui_lang
    (ui_lang_sn number(11)
    ,ui_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
    
ALTER TABLE ui_lang ADD CONSTRAINT ui_lang_PK
PRIMARY KEY (ui_lang_sn);
--
ALTER TABLE  ui_lang ADD CONSTRAINT  ui_lang_FK1
FOREIGN KEY (ui_code) REFERENCES list_ui (ui_code);
--
ALTER TABLE ui_lang ADD CONSTRAINT ui_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX ui_lang_ak1
ON ui_lang (ui_code,lang_code);
--============================================================
create table priviledge_ui
    (priviledge_ui_sn number(11)
    ,ui_code VARCHAR2(4) NOT NULL
    ,priviledge_code varchar2(4) not null
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE priviledge_ui ADD CONSTRAINT priviledge_ui_PK
PRIMARY KEY (priviledge_ui_sn);
--
ALTER TABLE priviledge_ui  ADD CONSTRAINT priviledge_ui_fk1
FOREIGN KEY (ui_code) REFERENCES list_ui(ui_code);
--
ALTER TABLE priviledge_ui  ADD CONSTRAINT priviledge_ui_fk2
FOREIGN KEY (priviledge_code) REFERENCES list_priviledge(priviledge_code);
--
CREATE unique INDEX priviledge_ui_ak1
ON priviledge_ui (priviledge_code,ui_code);
--======================================
CREATE TABLE list_report_template
    (report_template_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_report_template ADD CONSTRAINT list_report_template_PK
PRIMARY KEY (report_template_code);
--
CREATE TABLE report_template_lang
    (report_template_lang_sn number(11)
    ,report_template_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE report_template_lang ADD CONSTRAINT report_template_lang_PK
PRIMARY KEY (report_template_lang_sn);
--
ALTER TABLE  report_template_lang ADD CONSTRAINT  report_template_lang_FK1
FOREIGN KEY (report_template_code) REFERENCES list_report_template (report_template_code);
--
ALTER TABLE report_template_lang ADD CONSTRAINT report_template_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX report_template_lang_ak1
ON report_template_lang (report_template_code,lang_code);
--======================================
CREATE TABLE list_report
    (report_code varchar2(4)
    ,report_template_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_report ADD CONSTRAINT list_report_PK
PRIMARY KEY (report_code);
--
ALTER TABLE  list_report ADD CONSTRAINT  list_report_FK1
FOREIGN KEY (report_template_code) REFERENCES list_report_template (report_template_code);
--
CREATE TABLE report_lang
    (report_lang_sn number(11)
    ,report_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE report_lang ADD CONSTRAINT report_lang_PK
PRIMARY KEY (report_lang_sn);
--
ALTER TABLE  report_lang ADD CONSTRAINT  report_lang_FK1
FOREIGN KEY (report_code) REFERENCES list_report (report_code);
--
ALTER TABLE report_lang ADD CONSTRAINT report_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX report_lang_ak1
ON report_lang (report_code,lang_code);
--============================================================
create table priviledge_report
    (priviledge_report_sn number(11)
    ,report_code VARCHAR2(4) NOT NULL
    ,priviledge_code varchar2(4) not null
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE priviledge_report ADD CONSTRAINT priviledge_report_PK
PRIMARY KEY (priviledge_report_sn);
--
ALTER TABLE priviledge_report  ADD CONSTRAINT priviledge_report_fk1
FOREIGN KEY (report_code) REFERENCES list_report(report_code);
--
ALTER TABLE priviledge_report  ADD CONSTRAINT priviledge_report_fk2
FOREIGN KEY (priviledge_code) REFERENCES list_priviledge(priviledge_code);
--
CREATE unique INDEX priviledge_report_ak1
ON priviledge_report (priviledge_code,report_code);
--============================================================
create table roles_priviledge
    (roles_priviledge_sn number(11)
    ,role_id nvarchar2(128) not null
    ,priviledge_code VARCHAR2(4) NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE roles_priviledge ADD CONSTRAINT roles_priviledge_PK
PRIMARY KEY (roles_priviledge_sn);
--
ALTER TABLE roles_priviledge  ADD CONSTRAINT roles_priviledge_fk1
FOREIGN KEY (priviledge_code) REFERENCES list_priviledge(priviledge_code);
--
ALTER TABLE roles_priviledge ADD CONSTRAINT roles_priviledge_fk2
FOREIGN KEY (role_id) REFERENCES "AspNetRoles"("Id");
--
CREATE unique INDEX roles_priviledge_ak1
ON roles_priviledge (role_id,priviledge_code);

--role_priviledge related ddl end---------------------(Menu DDL End)
--Question related create start--------=========================
create table list_prev_svc_type
    (prev_svc_type_code VARCHAR2(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_prev_svc_type ADD CONSTRAINT list_prev_svc_type_PK
PRIMARY KEY (prev_svc_type_code);
--==================================================
create table prev_svc_type_lang
    (prev_svc_type_lang_sn NUMBER(11)
    ,prev_svc_type_code VARCHAR2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE prev_svc_type_lang ADD CONSTRAINT prev_svc_type_lang_PK
PRIMARY KEY (prev_svc_type_lang_sn);
--
ALTER TABLE prev_svc_type_lang ADD CONSTRAINT prev_svc_type_lang_FK1
FOREIGN KEY (prev_svc_type_code) REFERENCES list_prev_svc_type(prev_svc_type_code);
--
ALTER TABLE prev_svc_type_lang ADD CONSTRAINT prev_svc_type_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX prev_svc_type_lang_ak1
ON prev_svc_type_lang (prev_svc_type_code,LANG_CODE);
--==================================================
create table list_svc_rpt_type
    (svc_rpt_type_code VARCHAR2(3)
    ,prev_svc_type_code VARCHAR2(3) NOT NULL
    ,order_num number(9)
    ,used_for_template_only_flag           VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_svc_rpt_type ADD CONSTRAINT list_svc_rpt_type_PK
PRIMARY KEY (svc_rpt_type_code);
--
ALTER TABLE list_svc_rpt_type ADD CONSTRAINT list_svc_rpt_type_FK1
FOREIGN KEY (prev_svc_type_code) REFERENCES list_prev_svc_type(prev_svc_type_code);
--==================================================
create table svc_rpt_type_lang
    (svc_rpt_type_lang_sn NUMBER(11)
    ,svc_rpt_type_code VARCHAR2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE svc_rpt_type_lang ADD CONSTRAINT svc_rpt_type_lang_PK
PRIMARY KEY (svc_rpt_type_lang_sn);
--
ALTER TABLE svc_rpt_type_lang ADD CONSTRAINT svc_rpt_type_lang_FK1
FOREIGN KEY (svc_rpt_type_code) REFERENCES list_svc_rpt_type(svc_rpt_type_code);
--
ALTER TABLE svc_rpt_type_lang ADD CONSTRAINT svc_rpt_type_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX svc_rpt_type_lang_ak1
ON svc_rpt_type_lang (svc_rpt_type_code,LANG_CODE);
--===================================
create table list_billing_type
    (billing_type_code VARCHAR2(5)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_billing_type ADD CONSTRAINT list_billing_type_PK
PRIMARY KEY (billing_type_code);
--==================================================
create table billing_type_lang
    (billing_type_lang_sn NUMBER(11)
    ,billing_type_code VARCHAR2(5) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE billing_type_lang ADD CONSTRAINT billing_type_lang_PK
PRIMARY KEY (billing_type_lang_sn);
--
ALTER TABLE billing_type_lang ADD CONSTRAINT billing_type_lang_FK1
FOREIGN KEY (billing_type_code) REFERENCES list_billing_type(billing_type_code);
--
ALTER TABLE billing_type_lang ADD CONSTRAINT billing_type_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX billing_type_lang_ak1
ON billing_type_lang (billing_type_code,LANG_CODE);
--==================================================
create table list_prev_svc_billing
    (prev_svc_billing_code VARCHAR2(5)
    ,prev_svc_type_code    VARCHAR2(3) not null
    ,billing_type_code     VARCHAR2(5) not null
    ,order_num             number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_prev_svc_billing ADD CONSTRAINT list_prev_svc_billing_PK
PRIMARY KEY (prev_svc_billing_code);
--
ALTER TABLE list_prev_svc_billing ADD CONSTRAINT list_prev_svc_billing_FK1
FOREIGN KEY (prev_svc_type_code) REFERENCES list_prev_svc_type(prev_svc_type_code);
--
ALTER TABLE list_prev_svc_billing ADD CONSTRAINT list_prev_svc_billing_FK2
FOREIGN KEY (billing_type_code) REFERENCES list_billing_type(billing_type_code);
--==================================================
create table prev_svc_billing_lang
    (prev_svc_billing_lang_sn NUMBER(11)
    ,prev_svc_billing_code VARCHAR2(5) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(300)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE prev_svc_billing_lang ADD CONSTRAINT prev_svc_billing_lang_PK
PRIMARY KEY (prev_svc_billing_lang_sn);
--
ALTER TABLE prev_svc_billing_lang ADD CONSTRAINT prev_svc_billing_lang_FK1
FOREIGN KEY (prev_svc_billing_code) REFERENCES list_prev_svc_billing(prev_svc_billing_code);
--
ALTER TABLE prev_svc_billing_lang ADD CONSTRAINT prev_svc_billing_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX prev_svc_billing_lang_ak1
ON prev_svc_billing_lang (prev_svc_billing_code,LANG_CODE);
--==================================================
create table list_question_score_type
    (question_score_type_code VARCHAR2(2)
    ,descr                 varchar2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_question_score_type ADD CONSTRAINT list_question_score_type_PK
PRIMARY KEY (question_score_type_code);
--==================================================
create table list_question_categ_grp
    (question_categ_grp_code VARCHAR2(3)
    ,order_num  number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_question_categ_grp ADD CONSTRAINT list_question_categ_grp_PK
PRIMARY KEY (question_categ_grp_code);
--==================================================
create table question_categ_grp_lang
    (question_categ_grp_lang_sn NUMBER(11)
    ,question_categ_grp_code VARCHAR2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question_categ_grp_lang ADD CONSTRAINT question_categ_grp_lang_PK
PRIMARY KEY (question_categ_grp_lang_sn);
--
ALTER TABLE question_categ_grp_lang ADD CONSTRAINT question_categ_grp_lang_FK1
FOREIGN KEY (question_categ_grp_code) REFERENCES list_question_categ_grp(question_categ_grp_code);
--
ALTER TABLE question_categ_grp_lang ADD CONSTRAINT question_categ_grp_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX question_categ_grp_lang_ak1
ON question_categ_grp_lang (question_categ_grp_code,LANG_CODE);
--==================================================
create table list_categ_condition
    (categ_condition_code VARCHAR2(2)
    ,descr                varchar2(30)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_categ_condition ADD CONSTRAINT list_categ_condition_PK
PRIMARY KEY (categ_condition_code);
--==================================================
create table list_question_categ
    (question_categ_code VARCHAR2(5)
    ,question_score_type_code VARCHAR2(2) not null
    ,question_categ_grp_code  VARCHAR2(3)
    ,conditional_categ_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,categ_condition_code VARCHAR2(2)
    ,categ_condition_descr VARCHAR2(300)
    ,child_categ_avail_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,trigger_further_categ_flag varchar2(1) default 'N'
    ,checkbox_only_categ_flag varchar2(1) default 'N'
    ,parent_question_categ_code VARCHAR2(5)
    ,data_entry_categ_flag varchar2(1) default 'N'
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_question_categ ADD CONSTRAINT list_question_categ_PK
PRIMARY KEY (question_categ_code);
--
ALTER TABLE list_question_categ ADD CONSTRAINT list_question_categ_FK1
FOREIGN KEY (question_score_type_code) REFERENCES list_question_score_type(question_score_type_code);
--
ALTER TABLE list_question_categ ADD CONSTRAINT list_question_categ_FK2
FOREIGN KEY (question_categ_grp_code) REFERENCES list_question_categ_grp(question_categ_grp_code);
--
ALTER TABLE list_question_categ ADD CONSTRAINT list_question_categ_FK3
FOREIGN KEY (parent_question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
ALTER TABLE list_question_categ ADD CONSTRAINT list_question_categ_FK4
FOREIGN KEY (categ_condition_code) REFERENCES list_categ_condition(categ_condition_code);
--
CREATE INDEX list_question_categ_idx1
ON list_question_categ (parent_question_categ_code);
--==================================================
create table question_categ_lang
    (question_categ_lang_sn NUMBER(11)
    ,question_categ_code VARCHAR2(5) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question_categ_lang ADD CONSTRAINT question_categ_lang_PK
PRIMARY KEY (question_categ_lang_sn);
--
ALTER TABLE question_categ_lang ADD CONSTRAINT question_categ_lang_FK1
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
ALTER TABLE question_categ_lang ADD CONSTRAINT question_categ_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX question_categ_lang_ak1
ON question_categ_lang (question_categ_code,LANG_CODE);
--==================================================
create table list_question_sub_categ
    (question_sub_categ_code VARCHAR2(3)
    ,question_categ_code    varchar2(5) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_question_sub_categ ADD CONSTRAINT list_question_sub_categ_PK
PRIMARY KEY (question_sub_categ_code);
--
ALTER TABLE list_question_sub_categ ADD CONSTRAINT list_question_sub_categ_FK1
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--==================================================
create table question_sub_categ_lang
    (question_sub_categ_lang_sn NUMBER(11)
    ,question_sub_categ_code VARCHAR2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question_sub_categ_lang ADD CONSTRAINT question_sub_categ_lang_PK
PRIMARY KEY (question_sub_categ_lang_sn);
--
ALTER TABLE question_sub_categ_lang ADD CONSTRAINT question_sub_categ_lang_FK1
FOREIGN KEY (question_sub_categ_code) REFERENCES list_question_sub_categ(question_sub_categ_code);
--
ALTER TABLE question_sub_categ_lang ADD CONSTRAINT question_sub_categ_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX question_sub_categ_lang_ak1
ON question_sub_categ_lang (question_sub_categ_code,LANG_CODE);
--==================================================
create table categ_score_eval
    (categ_score_eval_code varchar2(4)
    ,question_categ_code    varchar2(5) not null
    ,question_sub_categ_code    varchar2(3)
    ,score_range_begin     number(3) not null
    ,score_range_end     number(4) not null
    ,disease_level_code varchar2(3) not null
    ,trigger_further_categ_flag VARCHAR2(1)   DEFAULT 'N'
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE categ_score_eval ADD CONSTRAINT categ_score_eval_PK
PRIMARY KEY (categ_score_eval_code);
--
ALTER TABLE categ_score_eval ADD CONSTRAINT categ_score_eval_FK1
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
ALTER TABLE categ_score_eval ADD CONSTRAINT categ_score_eval_FK2
FOREIGN KEY (question_sub_categ_code) REFERENCES list_question_sub_categ(question_sub_categ_code);
--
ALTER TABLE  categ_score_eval ADD CONSTRAINT  categ_score_eval_FK3
FOREIGN KEY (disease_level_code) REFERENCES list_disease_level (disease_level_code);
--
CREATE unique INDEX categ_score_eval_ak1
ON categ_score_eval (question_categ_code,question_sub_categ_code,score_range_begin);
--==================================================
create table categ_score_eval_lang
    (categ_score_eval_lang_sn NUMBER(11)
    ,categ_score_eval_code varchar2(4) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE categ_score_eval_lang ADD CONSTRAINT categ_score_eval_lang_PK
PRIMARY KEY (categ_score_eval_lang_sn);
--
ALTER TABLE categ_score_eval_lang ADD CONSTRAINT categ_score_eval_lang_FK1
FOREIGN KEY (categ_score_eval_code) REFERENCES categ_score_eval(categ_score_eval_code);
--
ALTER TABLE categ_score_eval_lang ADD CONSTRAINT categ_score_eval_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX categ_score_eval_lang_ak1
ON categ_score_eval_lang (categ_score_eval_code,LANG_CODE);
--==================================================
create table svc_billing_question_categ
    (svc_billing_question_categ_sn NUMBER(11)
    ,prev_svc_billing_code VARCHAR2(5) not null
    ,question_categ_code VARCHAR2(5) not null
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE svc_billing_question_categ ADD CONSTRAINT svc_billing_question_categ_PK
PRIMARY KEY (svc_billing_question_categ_sn);
--
ALTER TABLE svc_billing_question_categ ADD CONSTRAINT svc_billing_question_categ_FK1
FOREIGN KEY (prev_svc_billing_code) REFERENCES list_prev_svc_billing(prev_svc_billing_code);
--
ALTER TABLE svc_billing_question_categ ADD CONSTRAINT svc_billing_question_categ_FK2
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
CREATE unique INDEX svc_billing_question_categ_ak1
ON svc_billing_question_categ (prev_svc_billing_code,question_categ_code);
--==================================================
create table list_response
    (response_code VARCHAR2(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_response ADD CONSTRAINT list_response_PK
PRIMARY KEY (response_code);
--==================================================
create table response_lang
    (response_lang_sn NUMBER(11)
    ,response_code VARCHAR2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(300)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE response_lang ADD CONSTRAINT response_lang_PK
PRIMARY KEY (response_lang_sn);
--
ALTER TABLE response_lang ADD CONSTRAINT response_lang_FK1
FOREIGN KEY (response_code) REFERENCES list_response(response_code);
--
ALTER TABLE response_lang ADD CONSTRAINT response_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX response_lang_ak1
ON response_lang (response_code,LANG_CODE);
--==================================================
create table question
    (question_sn number(11)
    ,question_categ_code varchar2(5) not null
    ,question_code varchar2(4) not null
    ,question_sub_categ_code  varchar2(3)
    ,order_num             number(10,1)
    ,conditional_question_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,parent_question_sn number(11)
    ,triggered_response_code VARCHAR2(3)
    ,triggered_question_categ_code varchar2(5)
    ,triggered_question_code varchar2(4)
    ,triggered_other_code varchar2(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question ADD CONSTRAINT question_PK
PRIMARY KEY (question_sn);
--
ALTER TABLE question ADD CONSTRAINT question_FK1
FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
ALTER TABLE question ADD CONSTRAINT question_FK2
FOREIGN KEY (parent_question_sn) REFERENCES question(question_sn);
--
ALTER TABLE question ADD CONSTRAINT question_FK3
FOREIGN KEY (question_sub_categ_code) REFERENCES list_question_sub_categ(question_sub_categ_code);
--
ALTER TABLE question ADD CONSTRAINT question_FK4
FOREIGN KEY (triggered_response_code) REFERENCES list_response(response_code);
--
ALTER TABLE question ADD CONSTRAINT question_FK5
FOREIGN KEY (triggered_question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
CREATE unique INDEX question_ak1
ON question (question_categ_code,question_code);
--
CREATE INDEX question_idx1
ON question (parent_question_sn);
--
CREATE INDEX question_idx2
ON question (conditional_question_flag);
--==================================================
create table question_lang
    (question_lang_sn NUMBER(11)
    ,question_sn number(11) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(400)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question_lang ADD CONSTRAINT question_lang_PK
PRIMARY KEY (question_lang_sn);
--
ALTER TABLE question_lang ADD CONSTRAINT question_lang_FK1
FOREIGN KEY (question_sn) REFERENCES question(question_sn);
--
ALTER TABLE question_lang ADD CONSTRAINT question_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX question_lang_ak1
ON question_lang (question_sn,LANG_CODE);
--==================================================
create table question_response
    (question_response_code VARCHAR2(6)
    ,question_SN NUMBER(11) NOT NULL
    ,response_code VARCHAR2(3) NOT NULL
    ,score_value           number(3)
    ,order_num             number(9)
    ,trigger_further_question_flag varchar2(1) default 'N'
    ,trigger_further_categ_flag varchar2(1) default 'N'
    ,triggered_question_categ_code varchar2(5)
    ,disease_code varchar2(4)
    ,symptom_code varchar2(4)
    ,risk_factor_code varchar2(4)
    ,disease_level_code varchar2(3)
    ,em_name_code varchar2(6)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE question_response ADD CONSTRAINT question_response_PK
PRIMARY KEY (question_response_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK1
FOREIGN KEY (response_code) REFERENCES list_response(response_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK2
FOREIGN KEY (question_sn) REFERENCES question(question_sn);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK3
FOREIGN KEY (triggered_question_categ_code) REFERENCES list_question_categ(question_categ_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK4
FOREIGN KEY (disease_code) REFERENCES list_disease(disease_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK5
FOREIGN KEY (symptom_code) REFERENCES list_symptom(symptom_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK6
FOREIGN KEY (risk_factor_code) REFERENCES list_risk_factor(risk_factor_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK7
FOREIGN KEY (disease_level_code) REFERENCES list_disease_level(disease_level_code);
--
ALTER TABLE question_response ADD CONSTRAINT question_response_FK8
FOREIGN KEY (em_name_code) REFERENCES list_em_name(em_name_code);
--
CREATE unique INDEX question_response_ak1
ON question_response (question_sn,response_code);
--Question related create end--------=========================
--Physician related create start--------==================================+++++++++++++++++++++++&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--=================================================================
create table list_physician_type
    (physician_type_code varchar2(3)
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_physician_type ADD CONSTRAINT list_physician_type_PK
PRIMARY KEY (physician_type_code);
--
create table physician_type_lang
    (physician_type_lang_sn number(11)
    ,physician_type_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE physician_type_lang ADD CONSTRAINT physician_type_lang_PK
PRIMARY KEY (physician_type_lang_sn);
--
ALTER TABLE physician_type_lang ADD CONSTRAINT physician_type_lang_FK1
FOREIGN KEY (lang_code) REFERENCES list_lang(lang_code);
--
ALTER TABLE physician_type_lang ADD CONSTRAINT physician_type_lang_FK2
FOREIGN KEY (physician_type_code) REFERENCES list_physician_type(physician_type_code);
--
CREATE unique INDEX physician_type_lang_ak1
ON physician_type_lang (physician_type_code,lang_code);
--==========================================================
create table company
    (company_sn number(11)
    ,ADDR_SN NUMBER(11) NOT NULL
    ,NAME NVARCHAR2(200) NOT NULL
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,CONTACT_NAME	NVARCHAR2(100)
    ,PHONE_NUMBER  NVARCHAR2(40)
    ,FAX_NUMBER  NVARCHAR2(40)
    ,TOLL_FREE_NUMBER NVARCHAR2(40)
    ,WEBSITE_ADDR  NVARCHAR2(200)
    ,ITHEALTH_COMPANY_FLAG           VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE company ADD CONSTRAINT company_PK
PRIMARY KEY (company_sn);
--
ALTER TABLE company ADD CONSTRAINT company_FK1
FOREIGN KEY (ADDR_SN) REFERENCES addr(addr_sn);
--
ALTER TABLE company ADD CONSTRAINT company_FK2
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE company ADD CONSTRAINT company_FK3
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX company_ak1
ON company (ADDR_SN);
--
create index company_indx1
on company (created_by_user_role_id);
--
create index company_indx2
on company (updated_by_user_role_id);
--==========================================================
create table physician
    (physician_sn number(11)
    ,license_num varchar2(20) not null
    ,npi number(10)
    ,company_SN NUMBER(11) NOT NULL
    ,physician_type_code varchar2(3) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,first_name nvarchar2(100)
    ,last_name nvarchar2(100)
    ,middle_name nvarchar2(100)
    ,contact_phone_num varchar2(20)
    ,email_addr varchar2(100)
    ,title nvarchar2(100)
    ,skype_id varchar2(100)
    ,dr_type varchar2(30)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE physician ADD CONSTRAINT physician_PK
PRIMARY KEY (physician_sn);
--
ALTER TABLE physician ADD CONSTRAINT physician_FK1
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE physician ADD CONSTRAINT physician_FK2
FOREIGN KEY (physician_type_code) REFERENCES list_physician_type(physician_type_code);
--
ALTER TABLE physician ADD CONSTRAINT physician_FK3
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
ALTER TABLE physician ADD CONSTRAINT physician_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE physician ADD CONSTRAINT physician_FK5
FOREIGN KEY (dr_type) REFERENCES list_dr_type(dr_type_code);
--
CREATE unique INDEX physician_ak1
ON physician (license_num);
--
create index physician_indx1
on physician (created_by_user_role_id);
--
create index physician_indx2
on physician (updated_by_user_role_id);
--==========================================================
create table provider_physician
    (provider_physician_sn number(11)
    ,license_num varchar2(20) not null
    ,npi number(10)
    ,company_SN NUMBER(11) NOT NULL
    ,physician_type_code varchar2(3) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,physician_user_role_id raw(16) not null
    ,first_name nvarchar2(100)
    ,last_name nvarchar2(100)
    ,middle_name nvarchar2(100)
    ,contact_phone_num varchar2(20)
    ,email_addr varchar2(100)
    ,title nvarchar2(100)
    ,skype_id varchar2(100)
    ,dr_type varchar2(30)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_PK
PRIMARY KEY (provider_physician_sn);
--
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_FK1
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_FK2
FOREIGN KEY (physician_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_FK3
FOREIGN KEY (physician_type_code) REFERENCES list_physician_type(physician_type_code);
--
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_FK4
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
ALTER TABLE provider_physician ADD CONSTRAINT provider_physician_FK5
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX provider_physician_ak1
ON provider_physician (license_num);
--
CREATE unique INDEX provider_physician_ak2
ON provider_physician (physician_user_role_id);
--
create index provider_physician_indx1
on provider_physician (created_by_user_role_id);
--
create index provider_physician_indx2
on provider_physician (updated_by_user_role_id);
--Physician related create end--------==================================+++++++++++++++++++++++
--Service Location related create start--------==================================+++++++++++++++++++++++&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--=============================================
create table list_svc_location_type
    (svc_location_type_code varchar2(4)
    ,order_num  number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_svc_location_type ADD CONSTRAINT list_svc_location_type_PK
PRIMARY KEY (svc_location_type_code);
--
create table svc_location_type_lang
    (svc_location_type_lang_sn number(11)
    ,svc_location_type_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE svc_location_type_lang ADD CONSTRAINT svc_location_type_lang_PK
PRIMARY KEY (svc_location_type_lang_sn);
--
ALTER TABLE svc_location_type_lang ADD CONSTRAINT svc_location_type_lang_FK1
FOREIGN KEY (lang_code) REFERENCES list_lang(lang_code);
--
ALTER TABLE svc_location_type_lang ADD CONSTRAINT svc_location_type_lang_FK2
FOREIGN KEY (svc_location_type_code) REFERENCES list_svc_location_type(svc_location_type_code);
--
CREATE unique INDEX svc_location_type_lang_ak1
ON svc_location_type_lang (svc_location_type_code,lang_code);
--==================================================================
create table svc_location
    (svc_location_sn number(11)
    ,company_SN NUMBER(11) NOT NULL
    ,addr_sn number(11) not null
    ,name nvarchar2(200) not null
    ,svc_location_type_code varchar2(4) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,contact_name nvarchar2(200)
    ,phone_num_1 varchar2(20)
    ,phone_num_2 varchar2(20)
    ,fax_num_1 varchar2(20)
    ,fax_num_2 varchar2(20)
    ,email_addr varchar2(100)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE svc_location ADD CONSTRAINT svc_location_PK
PRIMARY KEY (svc_location_sn);
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK1
FOREIGN KEY (addr_sn) REFERENCES addr(addr_sn);
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK2
FOREIGN KEY (svc_location_type_code) REFERENCES list_svc_location_type(svc_location_type_code);
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK5
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
CREATE unique INDEX svc_location_ak1
ON svc_location (company_SN,addr_sn);
--
create index svc_location_indx1
on svc_location (created_by_user_role_id);
--
create index svc_location_indx2
on svc_location (updated_by_user_role_id);
--==================================================================
create table physician_svc_location
    (physician_svc_location_sn number(11)
    ,physician_sn number(11) not null
    ,svc_location_sn number(11) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE physician_svc_location ADD CONSTRAINT physician_svc_location_PK
PRIMARY KEY (physician_svc_location_sn);
--
ALTER TABLE physician_svc_location ADD CONSTRAINT physician_svc_location_FK1
FOREIGN KEY (physician_sn) REFERENCES physician(physician_sn);
--
ALTER TABLE physician_svc_location ADD CONSTRAINT physician_svc_location_FK2
FOREIGN KEY (svc_location_sn) REFERENCES svc_location(svc_location_sn);
--
ALTER TABLE physician_svc_location ADD CONSTRAINT physician_svc_location_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE physician_svc_location ADD CONSTRAINT physician_svc_location_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX physician_svc_location_ak1
ON physician_svc_location (physician_sn,svc_location_sn);
--
create index physician_svc_location_indx1
on physician_svc_location (created_by_user_role_id);
--
create index physician_svc_location_indx2
on physician_svc_location (updated_by_user_role_id);
--===========================
create table user_svc_location
    (user_svc_location_sn number(11)
    ,user_role_id raw(16) not null
    ,svc_location_sn number(11) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE user_svc_location ADD CONSTRAINT user_svc_location_PK
PRIMARY KEY (user_svc_location_sn);
--
ALTER TABLE user_svc_location ADD CONSTRAINT user_svc_location_FK1
FOREIGN KEY (user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_svc_location ADD CONSTRAINT user_svc_location_FK2
FOREIGN KEY (svc_location_sn) REFERENCES svc_location(svc_location_sn);
--
ALTER TABLE user_svc_location ADD CONSTRAINT user_svc_location_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_svc_location ADD CONSTRAINT user_svc_location_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX user_svc_location_ak1
ON user_svc_location (user_role_id,svc_location_sn);
--
create index user_svc_location_indx1
on user_svc_location (created_by_user_role_id);
--
create index user_svc_location_indx2
on user_svc_location (updated_by_user_role_id);
--===========================
create table user_company
    (user_company_sn number(11)
    ,user_role_id raw(16) not null
    ,company_sn number(11) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE user_company ADD CONSTRAINT user_company_PK
PRIMARY KEY (user_company_sn);
--
ALTER TABLE user_company ADD CONSTRAINT user_company_FK1
FOREIGN KEY (user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_company ADD CONSTRAINT user_company_FK2
FOREIGN KEY (company_sn) REFERENCES company(company_sn);
--
ALTER TABLE user_company ADD CONSTRAINT user_company_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_company ADD CONSTRAINT user_company_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX user_company_ak1
ON user_company (user_role_id,company_sn);
--
create index user_company_indx1
on user_company (created_by_user_role_id);
--
create index user_company_indx2
on user_company (updated_by_user_role_id);
--===========================
create table user_physician
    (user_physician_sn number(11)
    ,user_role_id raw(16) not null
    ,physician_sn number(11) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE user_physician ADD CONSTRAINT user_physician_PK
PRIMARY KEY (user_physician_sn);
--
ALTER TABLE user_physician ADD CONSTRAINT user_physician_FK1
FOREIGN KEY (user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_physician ADD CONSTRAINT user_physician_FK2
FOREIGN KEY (physician_sn) REFERENCES physician(physician_sn);
--
ALTER TABLE user_physician ADD CONSTRAINT user_physician_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE user_physician ADD CONSTRAINT user_physician_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX user_physician_ak1
ON user_physician (user_role_id,physician_sn);
--
create index user_physician_indx1
on user_physician (created_by_user_role_id);
--
create index user_physician_indx2
on user_physician (updated_by_user_role_id);
--===========================
create table user_login
    (user_login_sn number(11)
    ,user_role_id raw(16) not null
    ,PACKAGE_NAME VARCHAR2(30)
    ,PROCEDURE_NAME VARCHAR2(30) 
    ,LATITUDE NUMBER(9,6)
    ,LONGITUDE NUMBER(9,6) 
    ,BROWSER_NAME VARCHAR2(200) 
    ,IP_ADDR VARCHAR2(200)
    ,PREF_LOCALE VARCHAR2(30) 
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE user_login ADD CONSTRAINT user_login_PK
PRIMARY KEY (user_login_sn);
--
ALTER TABLE user_login ADD CONSTRAINT user_login_FK1
FOREIGN KEY (user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--Service Location related create end--------==================================+++++++++++++++++++++++
--Patient related create start--------==================================+++++++++++++++++++++++&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--================================================================
CREATE TABLE list_financial_status
    (financial_status_code    varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_financial_status ADD CONSTRAINT list_financial_status_PK
PRIMARY KEY (financial_status_code);
--
CREATE TABLE financial_status_lang
    (financial_status_lang_sn number(11)
    ,financial_status_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE financial_status_lang ADD CONSTRAINT financial_status_lang_PK
PRIMARY KEY (financial_status_lang_sn);
--
ALTER TABLE  financial_status_lang ADD CONSTRAINT  financial_status_lang_FK1
FOREIGN KEY (financial_status_code) REFERENCES list_financial_status (financial_status_code);
--
ALTER TABLE financial_status_lang ADD CONSTRAINT financial_status_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX financial_status_lang_ak1
ON financial_status_lang (financial_status_code,lang_code);
--================================================================
CREATE TABLE list_living_status
    (living_status_code    varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_living_status ADD CONSTRAINT list_living_status_PK
PRIMARY KEY (living_status_code);
--
CREATE TABLE living_status_lang
    (living_status_lang_sn number(11)
    ,living_status_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE living_status_lang ADD CONSTRAINT living_status_lang_PK
PRIMARY KEY (living_status_lang_sn);
--
ALTER TABLE  living_status_lang ADD CONSTRAINT  living_status_lang_FK1
FOREIGN KEY (living_status_code) REFERENCES list_living_status (living_status_code);
--
ALTER TABLE living_status_lang ADD CONSTRAINT living_status_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX living_status_lang_ak1
ON living_status_lang (living_status_code,lang_code);
--================================================================
CREATE TABLE list_race
    (race_code varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_race ADD CONSTRAINT list_race_PK
PRIMARY KEY (race_code);
--
CREATE TABLE race_lang
    (race_lang_sn number(11)
    ,race_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE race_lang ADD CONSTRAINT race_lang_PK
PRIMARY KEY (race_lang_sn);
--
ALTER TABLE  race_lang ADD CONSTRAINT  race_lang_FK1
FOREIGN KEY (race_code) REFERENCES list_race (race_code);
--
ALTER TABLE race_lang ADD CONSTRAINT race_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX race_lang_ak1
ON race_lang (race_code,lang_code);
--================================================================
CREATE TABLE list_ethnicity
    (ethnicity_code varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_ethnicity ADD CONSTRAINT list_ethnicity_PK
PRIMARY KEY (ethnicity_code);
--
CREATE TABLE ethnicity_lang
    (ethnicity_lang_sn number(11)
    ,ethnicity_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE ethnicity_lang ADD CONSTRAINT ethnicity_lang_PK
PRIMARY KEY (ethnicity_lang_sn);
--
ALTER TABLE  ethnicity_lang ADD CONSTRAINT  ethnicity_lang_FK1
FOREIGN KEY (ethnicity_code) REFERENCES list_ethnicity (ethnicity_code);
--
ALTER TABLE ethnicity_lang ADD CONSTRAINT ethnicity_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX ethnicity_lang_ak1
ON ethnicity_lang (ethnicity_code,lang_code);
--======================================
CREATE TABLE list_gender
    (gender_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_gender ADD CONSTRAINT list_gender_PK
PRIMARY KEY (gender_code);
--
CREATE TABLE gender_lang
    (gender_lang_sn number(11)
    ,gender_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE gender_lang ADD CONSTRAINT gender_lang_PK
PRIMARY KEY (gender_lang_sn);
--
ALTER TABLE  gender_lang ADD CONSTRAINT  gender_lang_FK1
FOREIGN KEY (gender_code) REFERENCES list_gender (gender_code);
--
ALTER TABLE gender_lang ADD CONSTRAINT gender_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX gender_lang_ak1
ON gender_lang (gender_code,lang_code);
--==================================================================
CREATE TABLE list_education_level
    (education_level_code varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_education_level ADD CONSTRAINT list_education_level_PK
PRIMARY KEY (education_level_code);
--
CREATE TABLE education_level_lang
    (education_level_lang_sn number(11)
    ,education_level_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
    
ALTER TABLE education_level_lang ADD CONSTRAINT education_level_lang_PK
PRIMARY KEY (education_level_lang_sn);
--
ALTER TABLE  education_level_lang ADD CONSTRAINT  education_level_lang_FK1
FOREIGN KEY (education_level_code) REFERENCES list_education_level (education_level_code);
--
ALTER TABLE education_level_lang ADD CONSTRAINT education_level_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX education_level_lang_ak1
ON education_level_lang (education_level_code,lang_code);
--==================================================================
CREATE TABLE list_marital_status
    (marital_status_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_marital_status ADD CONSTRAINT list_marital_status_PK
PRIMARY KEY (marital_status_code);
--
CREATE TABLE marital_status_lang
    (marital_status_lang_sn number(11)
    ,marital_status_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE marital_status_lang ADD CONSTRAINT marital_status_lang_PK
PRIMARY KEY (marital_status_lang_sn);
--
ALTER TABLE  marital_status_lang ADD CONSTRAINT  marital_status_lang_FK1
FOREIGN KEY (marital_status_code) REFERENCES list_marital_status (marital_status_code);
--
ALTER TABLE marital_status_lang ADD CONSTRAINT marital_status_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX marital_status_lang_ak1
ON marital_status_lang (marital_status_code,lang_code);
--==================================================
create table list_income
    (income_code varchar2(4)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_income ADD CONSTRAINT list_income_PK
PRIMARY KEY (income_code);
--==================================================
create table income_lang
    (income_lang_sn NUMBER(11)
    ,income_code varchar2(4) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE income_lang ADD CONSTRAINT income_lang_PK
PRIMARY KEY (income_lang_sn);
--
ALTER TABLE income_lang ADD CONSTRAINT income_lang_FK1
FOREIGN KEY (income_code) REFERENCES list_income(income_code);
--
ALTER TABLE income_lang ADD CONSTRAINT income_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX income_lang_ak1
ON income_lang (income_code,LANG_CODE);
--==================================================
create table list_working_status
    (working_status_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_working_status ADD CONSTRAINT list_working_status_PK
PRIMARY KEY (working_status_code);
--==================================================
create table working_status_lang
    (working_status_lang_sn NUMBER(11)
    ,working_status_code varchar2(3) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE working_status_lang ADD CONSTRAINT working_status_lang_PK
PRIMARY KEY (working_status_lang_sn);
--
ALTER TABLE working_status_lang ADD CONSTRAINT working_status_lang_FK1
FOREIGN KEY (working_status_code) REFERENCES list_working_status(working_status_code);
--
ALTER TABLE working_status_lang ADD CONSTRAINT working_status_lang_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX working_status_lang_ak1
ON working_status_lang (working_status_code,LANG_CODE);
--================================================================
CREATE TABLE list_cholesterol
    (cholesterol_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_cholesterol ADD CONSTRAINT list_cholesterol_PK
PRIMARY KEY (cholesterol_code);
--
CREATE TABLE cholesterol_lang
    (cholesterol_lang_sn number(11)
    ,cholesterol_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE cholesterol_lang ADD CONSTRAINT cholesterol_lang_PK
PRIMARY KEY (cholesterol_lang_sn);
--
ALTER TABLE  cholesterol_lang ADD CONSTRAINT  cholesterol_lang_FK1
FOREIGN KEY (cholesterol_code) REFERENCES list_cholesterol (cholesterol_code);
--
ALTER TABLE cholesterol_lang ADD CONSTRAINT cholesterol_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX cholesterol_lang_ak1
ON cholesterol_lang (cholesterol_code,lang_code);
--================================================================
CREATE TABLE list_systolic_bp
    (systolic_bp_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_systolic_bp ADD CONSTRAINT list_systolic_bp_PK
PRIMARY KEY (systolic_bp_code);
--
CREATE TABLE systolic_bp_lang
    (systolic_bp_lang_sn number(11)
    ,systolic_bp_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE systolic_bp_lang ADD CONSTRAINT systolic_bp_lang_PK
PRIMARY KEY (systolic_bp_lang_sn);
--
ALTER TABLE  systolic_bp_lang ADD CONSTRAINT  systolic_bp_lang_FK1
FOREIGN KEY (systolic_bp_code) REFERENCES list_systolic_bp (systolic_bp_code);
--
ALTER TABLE systolic_bp_lang ADD CONSTRAINT systolic_bp_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX systolic_bp_lang_ak1
ON systolic_bp_lang (systolic_bp_code,lang_code);
--================================================================
CREATE TABLE list_diastolic_bp
    (diastolic_bp_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_diastolic_bp ADD CONSTRAINT list_diastolic_bp_PK
PRIMARY KEY (diastolic_bp_code);
--
CREATE TABLE diastolic_bp_lang
    (diastolic_bp_lang_sn number(11)
    ,diastolic_bp_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE diastolic_bp_lang ADD CONSTRAINT diastolic_bp_lang_PK
PRIMARY KEY (diastolic_bp_lang_sn);
--
ALTER TABLE  diastolic_bp_lang ADD CONSTRAINT  diastolic_bp_lang_FK1
FOREIGN KEY (diastolic_bp_code) REFERENCES list_diastolic_bp (diastolic_bp_code);
--
ALTER TABLE diastolic_bp_lang ADD CONSTRAINT diastolic_bp_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX diastolic_bp_lang_ak1
ON diastolic_bp_lang (diastolic_bp_code,lang_code);
--================================================================
CREATE TABLE list_weight
    (weight_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_weight ADD CONSTRAINT list_weight_PK
PRIMARY KEY (weight_code);
--
CREATE TABLE weight_lang
    (weight_lang_sn number(11)
    ,weight_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE weight_lang ADD CONSTRAINT weight_lang_PK
PRIMARY KEY (weight_lang_sn);
--
ALTER TABLE  weight_lang ADD CONSTRAINT  weight_lang_FK1
FOREIGN KEY (weight_code) REFERENCES list_weight (weight_code);
--
ALTER TABLE weight_lang ADD CONSTRAINT weight_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX weight_lang_ak1
ON weight_lang (weight_code,lang_code);
--================================================================
CREATE TABLE list_height
    (height_code varchar2(2)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_height ADD CONSTRAINT list_height_PK
PRIMARY KEY (height_code);
--
CREATE TABLE height_lang
    (height_lang_sn number(11)
    ,height_code varchar2(2) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE height_lang ADD CONSTRAINT height_lang_PK
PRIMARY KEY (height_lang_sn);
--
ALTER TABLE  height_lang ADD CONSTRAINT  height_lang_FK1
FOREIGN KEY (height_code) REFERENCES list_height (height_code);
--
ALTER TABLE height_lang ADD CONSTRAINT height_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX height_lang_ak1
ON height_lang (height_code,lang_code);
--================================================================
CREATE TABLE list_blood_sugar_level
    (blood_sugar_level_code varchar2(3)
    ,order_num          NUMBER(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_blood_sugar_level ADD CONSTRAINT list_blood_sugar_level_PK
PRIMARY KEY (blood_sugar_level_code);
--
CREATE TABLE blood_sugar_level_lang
    (blood_sugar_level_lang_sn number(11)
    ,blood_sugar_level_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE blood_sugar_level_lang ADD CONSTRAINT blood_sugar_level_lang_PK
PRIMARY KEY (blood_sugar_level_lang_sn);
--
ALTER TABLE  blood_sugar_level_lang ADD CONSTRAINT  blood_sugar_level_lang_FK1
FOREIGN KEY (blood_sugar_level_code) REFERENCES list_blood_sugar_level (blood_sugar_level_code);
--
ALTER TABLE blood_sugar_level_lang ADD CONSTRAINT blood_sugar_level_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX blood_sugar_level_lang_ak1
ON blood_sugar_level_lang (blood_sugar_level_code,lang_code);
--================================================================
CREATE TABLE list_patient_orientation
    (patient_orientation_code varchar2(3)
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_patient_orientation ADD CONSTRAINT list_patient_orientation_PK
PRIMARY KEY (patient_orientation_code);
--
CREATE TABLE patient_orientation_lang
    (patient_orientation_lang_sn number(11)
    ,patient_orientation_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(200)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE patient_orientation_lang ADD CONSTRAINT patient_orientation_lang_PK
PRIMARY KEY (patient_orientation_lang_sn);
--
ALTER TABLE  patient_orientation_lang ADD CONSTRAINT  patient_orientation_lang_FK1
FOREIGN KEY (patient_orientation_code) REFERENCES list_patient_orientation (patient_orientation_code);
--
ALTER TABLE patient_orientation_lang ADD CONSTRAINT patient_orientation_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX patient_orientation_lang_ak1
ON patient_orientation_lang (patient_orientation_code,lang_code);
--==================================================================
create table patient
    (patient_sn number(11)
    ,ssn varchar2(9) not null
    ,physician_sn number(11) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,medicare_hic_num varchar2(20) not null
    ,addr_sn number(11)
    ,gender_code varchar2(3)
    ,race_code varchar2(4)
    ,ethnicity_code varchar2(4)
    ,first_name nvarchar2(100)
    ,last_name nvarchar2(100)
    ,middle_name nvarchar2(100)
    ,contact_phone_num varchar2(20)
    ,email_addr varchar2(100)
    ,skype_id varchar2(100)
    ,birth_date date not null
    ,legal_guardian_name nvarchar2(300)
    ,legal_guardian_ph varchar2(20)
    ,insurance_company_code varchar2(4)
    ,old_system_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient ADD CONSTRAINT patient_PK
PRIMARY KEY (patient_sn);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK1
FOREIGN KEY (addr_sn) REFERENCES addr(addr_sn);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK2
FOREIGN KEY (gender_code) REFERENCES list_gender(gender_code);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK3
FOREIGN KEY (ethnicity_code) REFERENCES list_ethnicity(ethnicity_code);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK9
FOREIGN KEY (race_code) REFERENCES list_race(race_code);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK11
FOREIGN KEY (physician_sn) REFERENCES physician(physician_sn);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK12
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK13
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient ADD CONSTRAINT patient_FK14
FOREIGN KEY (insurance_company_code) REFERENCES insurance_company(insurance_company_code);
--
CREATE unique INDEX patient_ak1
ON patient(ssn);
--
CREATE unique INDEX patient_ak2
ON patient(medicare_hic_num);
--
create index patient_indx1
on patient (created_by_user_role_id);
--
create index patient_indx2
on patient (updated_by_user_role_id);
----============================================================
CREATE TABLE list_frequency_unit
    (frequency_unit_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_frequency_unit ADD CONSTRAINT list_frequency_unit_PK
PRIMARY KEY (frequency_unit_code);
--
CREATE TABLE frequency_unit_lang
    (frequency_unit_lang_sn number(11)
    ,frequency_unit_code varchar2(2) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE frequency_unit_lang ADD CONSTRAINT frequency_unit_lang_PK
PRIMARY KEY (frequency_unit_lang_sn);
--
ALTER TABLE  frequency_unit_lang ADD CONSTRAINT  frequency_unit_lang_FK1
FOREIGN KEY (frequency_unit_code) REFERENCES list_frequency_unit (frequency_unit_code);
--
ALTER TABLE frequency_unit_lang ADD CONSTRAINT frequency_unit_lang_FK2
FOREIGN KEY (lang_code) REFERENCES list_lang(lang_code);
--
CREATE unique INDEX frequency_unit_lang_ak1
ON frequency_unit_lang (frequency_unit_code,lang_code);
--=================================================================
CREATE TABLE patient_medication
    (patient_medication_sn number(11)
    ,patient_sn number(11) not null
    ,name nvarchar2(200) not null
    ,medication_quantity varchar2(10)
    ,medication_unit_code varchar2(2)
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ingredients nvarchar2(200)
    ,purpose nvarchar2(200)
    ,frequency_unit_code varchar2(2)
    ,medication_current_flag varchar2(1)
    ,prescribed_med_flag varchar2(1) DEFAULT 'Y' NOT NULL
    ,notes nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient_medication ADD CONSTRAINT patient_medication_PK
PRIMARY KEY (patient_medication_sn);
--
ALTER TABLE  patient_medication ADD CONSTRAINT  patient_medication_FK1
FOREIGN KEY (patient_sn) REFERENCES patient(patient_sn);
--
ALTER TABLE  patient_medication ADD CONSTRAINT  patient_medication_FK2
FOREIGN KEY (frequency_unit_code) REFERENCES list_frequency_unit(frequency_unit_code);
--
ALTER TABLE patient_medication ADD CONSTRAINT patient_medication_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient_medication ADD CONSTRAINT patient_medication_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE  patient_medication ADD CONSTRAINT  patient_medication_FK5
FOREIGN KEY (medication_unit_code) REFERENCES list_medication_unit (medication_unit_code);
--
CREATE unique INDEX patient_medication_ak1
ON patient_medication (patient_sn,name);
--
create index patient_medication_indx1
on patient_medication (created_by_user_role_id);
--
create index patient_medication_indx2
on patient_medication (updated_by_user_role_id);
--Patient related create end--------==================================+++++++++++++++++++++++
--Patient Prev Service related create start--------==================================+++++++++++++++++++++++&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--=========================================================================
--======================================
CREATE TABLE list_hr
    (hr_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_hr ADD CONSTRAINT list_hr_PK
PRIMARY KEY (hr_code);
--======================================
CREATE TABLE list_min
    (min_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_min ADD CONSTRAINT list_min_PK
PRIMARY KEY (min_code);
--======================================
CREATE TABLE list_am_pm
    (am_pm_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_am_pm ADD CONSTRAINT list_am_pm_PK
PRIMARY KEY (am_pm_code);
--=============================
CREATE TABLE patient_prev_svc
    (patient_prev_svc_sn number(11)
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,patient_sn number(11) not null
    ,prev_svc_billing_code varchar2(5) not null
    ,svc_date date not null
    ,svc_number number(2) default 1 not null
    ,followed_rf_therapy_goals_flag VARCHAR2(1)
    ,goals_achived_flag VARCHAR2(1) DEFAULT 'Y'
    ,reason_of_not_achiving_goals nvarchar2(2000)
    ,svc_perform_date date
    ,provider_physician_sn number(11) not null
    ,physician_svc_location_sn number(11) not null
    ,g0438_comp_on_diff_sys_flag varchar2(1) default 'N' not null
    ,svc_comp_flag varchar2(1) default 'N' not null
    ,patient_signature clob
    ,physician_signature clob
    ,parent_patient_prev_svc_sn number(11)
    ,svc_hr_code varchar2(2)
    ,svc_min_code varchar2(2)
    ,svc_am_pm_code varchar2(2)
    ,request_em_perf_by_pcp_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,comment_when_deny_em nvarchar2(1000)
    ,qualify_for_em_followup_flag varchar2(1) DEFAULT 'N' NOT NULL
    ,chronic_disease_cnt number(2) DEFAULT 0 NOT NULL
    ,em_followup_svc_date date
    ,em_followup_svc_hr_code varchar2(2)
    ,em_followup_svc_min_code varchar2(2)
    ,em_followup_svc_am_pm_code varchar2(2)
    ,marital_status_code varchar2(3)
    ,working_status_code varchar2(3)
    ,education_level_code varchar2(4)
    ,financial_status_code varchar2(4)
    ,living_status_code varchar2(4)
    ,income_code varchar2(4)
    ,height_in_in number(3)
    ,weight_in_lb number(3)
    ,waist_in_in number(5,2)
    ,hdl_cholesterol_in_mg number(2)
    ,ldl_cholesterol_in_mg number(3)
    ,systolic_bp_in_mm number(3)
    ,diastolic_bp_in_mm number(3)
    ,blood_sugar_level_in_mg number(3)
    ,source_of_history_emr_flag varchar2(1) DEFAULT 'N'
    ,source_of_history_patient_flag varchar2(1) DEFAULT 'N'
    ,source_of_history_family_flag varchar2(1) DEFAULT 'N'
    ,patient_orientation_code varchar2(3)
    ,sub_prev_svc_billing_code varchar2(5)
    ,addl_sub_prev_svc_billing_code varchar2(5)
    ,inactive_reason_descr nvarchar2(1000)
    ,RX_PREV_SVC_BILLING_CODE	  VARCHAR2(5)
    ,insurance_company_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_PK
PRIMARY KEY (patient_prev_svc_sn);
--
ALTER TABLE  patient_prev_svc ADD CONSTRAINT  patient_prev_svc_FK1
FOREIGN KEY (patient_sn) REFERENCES patient (patient_sn);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK2
FOREIGN KEY (prev_svc_billing_code) REFERENCES  list_prev_svc_billing(prev_svc_billing_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK3
FOREIGN KEY (physician_svc_location_sn) REFERENCES  physician_svc_location(physician_svc_location_sn);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK4
FOREIGN KEY (provider_physician_sn) REFERENCES  provider_physician(provider_physician_sn);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK5
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK6
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK7
FOREIGN KEY (parent_patient_prev_svc_sn) REFERENCES patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK8
FOREIGN KEY (svc_hr_code) REFERENCES list_hr(hr_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK9
FOREIGN KEY (svc_min_code) REFERENCES list_min(min_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK10
FOREIGN KEY (svc_am_pm_code) REFERENCES list_am_pm(am_pm_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK11
FOREIGN KEY (em_followup_svc_hr_code) REFERENCES list_hr(hr_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK12
FOREIGN KEY (em_followup_svc_min_code) REFERENCES list_min(min_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK13
FOREIGN KEY (em_followup_svc_am_pm_code) REFERENCES list_am_pm(am_pm_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK14
FOREIGN KEY (marital_status_code) REFERENCES list_marital_status(marital_status_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK15
FOREIGN KEY (working_status_code) REFERENCES list_working_status(working_status_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK16
FOREIGN KEY (education_level_code) REFERENCES list_education_level(education_level_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK17
FOREIGN KEY (living_status_code) REFERENCES list_living_status (living_status_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK18
FOREIGN KEY (financial_status_code) REFERENCES list_financial_status (financial_status_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK19
FOREIGN KEY (income_code) REFERENCES list_income(income_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK20
FOREIGN KEY (patient_orientation_code) REFERENCES list_patient_orientation(patient_orientation_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK21
FOREIGN KEY (sub_prev_svc_billing_code) REFERENCES  list_prev_svc_billing(prev_svc_billing_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK22
FOREIGN KEY (addl_sub_prev_svc_billing_code) REFERENCES  list_prev_svc_billing(prev_svc_billing_code);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK23
FOREIGN KEY (RX_PREV_SVC_BILLING_CODE) REFERENCES  list_PREV_SVC_BILLING(PREV_SVC_BILLING_CODE);
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK24
FOREIGN KEY (insurance_company_code) REFERENCES insurance_company(insurance_company_code);
--
CREATE unique INDEX patient_prev_svc_ak1
ON patient_prev_svc (patient_sn,prev_svc_billing_code,svc_date);
--
create index patient_prev_svc_indx1
on patient_prev_svc (created_by_user_role_id);
--
create index patient_prev_svc_indx2
on patient_prev_svc (updated_by_user_role_id);
--
create index patient_prev_svc_indx3
on patient_prev_svc (provider_physician_sn);
--
create index patient_prev_svc_indx4
on patient_prev_svc (parent_patient_prev_svc_sn);
--
create index patient_prev_svc_indx5
on patient_prev_svc (qualify_for_em_followup_flag);
--
create index patient_prev_svc_indx6
on patient_prev_svc (svc_comp_flag);
--
create index patient_prev_svc_indx7
on patient_prev_svc (sub_prev_svc_billing_code);
--
create index patient_prev_svc_indx8
on patient_prev_svc (goals_achived_flag);
--======================================
CREATE TABLE list_remark_categ_grp
    (remark_categ_grp_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_remark_categ_grp ADD CONSTRAINT list_remark_categ_grp_PK
PRIMARY KEY (remark_categ_grp_code);
--
CREATE TABLE remark_categ_grp_lang
    (remark_categ_grp_lang_sn number(11)
    ,remark_categ_grp_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE remark_categ_grp_lang ADD CONSTRAINT remark_categ_grp_lang_PK
PRIMARY KEY (remark_categ_grp_lang_sn);
--
ALTER TABLE  remark_categ_grp_lang ADD CONSTRAINT  remark_categ_grp_lang_FK1
FOREIGN KEY (remark_categ_grp_code) REFERENCES list_remark_categ_grp (remark_categ_grp_code);
--
ALTER TABLE remark_categ_grp_lang ADD CONSTRAINT remark_categ_grp_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX remark_categ_grp_lang_ak1
ON remark_categ_grp_lang (remark_categ_grp_code,lang_code);
--==========================================================
create table patient_prev_svc_remark
    (patient_prev_svc_remark_sn number(11)
    ,patient_prev_svc_sn NUMBER(11) NOT NULL
    ,remark_categ_grp_code varchar2(4)
    ,remark_categ_name nvarchar2(100)
    ,remark_note nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient_prev_svc_remark ADD CONSTRAINT patient_prev_svc_remark_PK
PRIMARY KEY (patient_prev_svc_remark_sn);
--
ALTER TABLE patient_prev_svc_remark ADD CONSTRAINT patient_prev_svc_remark_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE  patient_prev_svc_remark ADD CONSTRAINT  patient_prev_svc_remark_FK2
FOREIGN KEY (remark_categ_grp_code) REFERENCES list_remark_categ_grp (remark_categ_grp_code);
--===================================================================
CREATE TABLE patient_history
    (patient_history_sn number(11)
    ,patient_sn number(11) not null
    ,question_response_code varchar2(6) not null
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient_history ADD CONSTRAINT patient_history_PK
PRIMARY KEY (patient_history_sn);
--
ALTER TABLE  patient_history ADD CONSTRAINT patient_history_FK1
FOREIGN KEY (patient_sn) REFERENCES patient(patient_sn);
--
ALTER TABLE patient_history ADD CONSTRAINT patient_history_FK2
FOREIGN KEY (question_response_code) REFERENCES question_response(question_response_code);
--
ALTER TABLE patient_history ADD CONSTRAINT patient_history_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient_history ADD CONSTRAINT patient_history_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
CREATE unique INDEX patient_history_ak1
ON patient_history (patient_sn,question_response_code);
--===================================================================
CREATE TABLE patient_response
    (patient_response_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,question_response_code varchar2(6) not null
    ,response_data  nvarchar2(100)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE patient_response ADD CONSTRAINT patient_response_PK
PRIMARY KEY (patient_response_sn);
--
ALTER TABLE  patient_response ADD CONSTRAINT patient_response_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE patient_response ADD CONSTRAINT patient_response_FK2
FOREIGN KEY (question_response_code) REFERENCES question_response(question_response_code);
--
CREATE unique INDEX patient_response_ak1
ON patient_response (patient_prev_svc_sn,question_response_code);
--Patient Prev Service related create end--------==================================+++++++++++++++++++++++
--Patient Response RESULT related create start--------==================================+++++++++++++++++++++++$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--==================================================++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--create table list_disease
--    (disease_code varchar2(5)
--    ,DISEASE_CATEG_CODE	VARCHAR2(4) not null
--    ,DISEASE_TYPE_CODE	VARCHAR2(4) not null
--    ,question_categ_code varchar2(5)
--    ,TRIGGER_CCM_FLAG	VARCHAR2(1) DEFAULT 'N' NOT NULL
--    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
--    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    );
--ALTER TABLE list_disease ADD CONSTRAINT list_disease_PK
--PRIMARY KEY (disease_code);
----
--ALTER TABLE list_disease ADD CONSTRAINT list_disease_FK1
--FOREIGN KEY (DISEASE_CATEG_CODE) REFERENCES list_DISEASE_CATEG(DISEASE_CATEG_CODE);
----
--ALTER TABLE list_disease ADD CONSTRAINT list_disease_FK2
--FOREIGN KEY (DISEASE_TYPE_CODE) REFERENCES list_DISEASE_TYPE(DISEASE_TYPE_CODE);
----
--ALTER TABLE list_disease ADD CONSTRAINT list_disease_FK3
--FOREIGN KEY (question_categ_code) REFERENCES list_question_categ(question_categ_code);
----==================================================
--create table disease_lang
--    (disease_lang_sn NUMBER(11)
--    ,disease_code varchar2(5) NOT NULL
--    ,LANG_CODE VARCHAR2(2) NOT NULL
--    ,SHORT_DESCR NVARCHAR2(100)
--    ,LONG_descr nvarchar2(1000)
--    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
--    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    );
--ALTER TABLE disease_lang ADD CONSTRAINT disease_lang_PK
--PRIMARY KEY (disease_lang_sn);
----
--ALTER TABLE disease_lang ADD CONSTRAINT disease_lang_FK1
--FOREIGN KEY (disease_code) REFERENCES list_disease(disease_code);
----
--ALTER TABLE disease_lang ADD CONSTRAINT disease_lang_FK2
--FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
----
--CREATE unique INDEX disease_lang_ak1
--ON disease_lang (disease_code,LANG_CODE);
--=================================================================
---------===================EM Service Begin--------======================
--======================================
CREATE TABLE list_em_categ_grp
    (em_categ_grp_code varchar2(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_em_categ_grp ADD CONSTRAINT list_em_categ_grp_PK
PRIMARY KEY (em_categ_grp_code);
--
CREATE TABLE em_categ_grp_lang
    (em_categ_grp_lang_sn number(11)
    ,em_categ_grp_code varchar2(3) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE em_categ_grp_lang ADD CONSTRAINT em_categ_grp_lang_PK
PRIMARY KEY (em_categ_grp_lang_sn);
--
ALTER TABLE  em_categ_grp_lang ADD CONSTRAINT  em_categ_grp_lang_FK1
FOREIGN KEY (em_categ_grp_code) REFERENCES list_em_categ_grp (em_categ_grp_code);
--
ALTER TABLE em_categ_grp_lang ADD CONSTRAINT em_categ_grp_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX em_categ_grp_lang_ak1
ON em_categ_grp_lang (em_categ_grp_code,lang_code);
--===============================
CREATE TABLE list_em_categ
    (em_categ_code varchar2(4)
    ,em_categ_grp_code varchar2(3) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_em_categ ADD CONSTRAINT list_em_categ_PK
PRIMARY KEY (em_categ_code);
--
ALTER TABLE list_em_categ ADD CONSTRAINT list_em_categ_FK1
FOREIGN KEY (em_categ_grp_code) REFERENCES list_em_categ_grp (em_categ_grp_code);
--
CREATE TABLE em_categ_lang
    (em_categ_lang_sn number(11)
    ,em_categ_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE em_categ_lang ADD CONSTRAINT em_categ_lang_PK
PRIMARY KEY (em_categ_lang_sn);
--
ALTER TABLE  em_categ_lang ADD CONSTRAINT  em_categ_lang_FK1
FOREIGN KEY (em_categ_code) REFERENCES list_em_categ (em_categ_code);
--
ALTER TABLE em_categ_lang ADD CONSTRAINT em_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX em_categ_lang_ak1
ON em_categ_lang (em_categ_code,lang_code);
--======================================
CREATE TABLE list_em_name
    (em_name_code varchar2(6)
    ,em_categ_code varchar2(4) not null
    ,order_num number(9)
    ,usda_immu_comp_flag   varchar2(1) default 'N'
    ,triggered_code        varchar2(3)
    ,usda_immu_comp_age_begin number(3)
    ,usda_immu_comp_age_end number(3)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_em_name ADD CONSTRAINT list_em_name_PK
PRIMARY KEY (em_name_code);
--
ALTER TABLE  list_em_name ADD CONSTRAINT  list_em_name_FK1
FOREIGN KEY (em_categ_code) REFERENCES list_em_categ (em_categ_code);
--
CREATE TABLE em_name_lang
    (em_name_lang_sn number(11)
    ,em_name_code varchar2(6) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,intervention_descr nvarchar2(300)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE em_name_lang ADD CONSTRAINT em_name_lang_PK
PRIMARY KEY (em_name_lang_sn);
--
ALTER TABLE  em_name_lang ADD CONSTRAINT  em_name_lang_FK1
FOREIGN KEY (em_name_code) REFERENCES list_em_name (em_name_code);
--
ALTER TABLE em_name_lang ADD CONSTRAINT em_name_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX em_name_lang_ak1
ON em_name_lang (em_name_code,lang_code);
--======================================+++++++++++++++++++++++++++
CREATE TABLE physician_em
    (physician_em_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,temp_in_fahrenheit         number(4,1) not null
    ,SYSTOLIC_BP_IN_MM	        NUMBER(3,0) not null
    ,DIASTOLIC_BP_IN_MM	        NUMBER(3,0) not null
    ,pulse_rate_in_bpm          number(3,0) not null
    ,respiratory_rate_in_bpm    number(2,0) not null
    ,rhythm_ind                 varchar2(1) not null
    ,preventative_scheduling    nvarchar2(1000)
    ,lab_and_test_prescribed    nvarchar2(1000)
    ,referrals_to_specialist    nvarchar2(1000)
    ,rx_maj_dis_or_health_event nvarchar2(1000)
    ,RX_PREV_SVC_BILLING_CODE	  VARCHAR2(5)
    ,physician_SIGNATURE	      CLOB not null                              
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE physician_em ADD CONSTRAINT physician_em_PK
PRIMARY KEY (physician_em_sn);
--
ALTER TABLE physician_em ADD CONSTRAINT physician_em_FK2
FOREIGN KEY (patient_prev_svc_sn) REFERENCES  patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE physician_em ADD CONSTRAINT physician_em_FK3
FOREIGN KEY (RX_PREV_SVC_BILLING_CODE) REFERENCES  list_PREV_SVC_BILLING(PREV_SVC_BILLING_CODE);
--
ALTER TABLE physician_em ADD CONSTRAINT physician_em_CK1 CHECK (rhythm_ind in ('R','I'));
--
ALTER TABLE physician_em ADD CONSTRAINT physician_em_CK2 CHECK (RX_PREV_SVC_BILLING_CODE in ('99490','99487'));
--
CREATE unique INDEX physician_em_ak1
ON physician_em (patient_prev_svc_sn);
--======================================
CREATE TABLE physician_em_name
    (physician_em_name_sn number(11)
    ,physician_em_sn number(11) not null
    ,em_name_code varchar2(6) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE physician_em_name ADD CONSTRAINT physician_em_name_PK
PRIMARY KEY (physician_em_name_sn);
--
ALTER TABLE  physician_em_name ADD CONSTRAINT  physician_em_name_FK1
FOREIGN KEY (em_name_code) REFERENCES list_em_name (em_name_code);
--
ALTER TABLE physician_em_name ADD CONSTRAINT physician_em_name_FK2
FOREIGN KEY (physician_em_sn) REFERENCES  physician_em(physician_em_sn);
--
CREATE unique INDEX physician_em_name_ak1
ON physician_em_name (physician_em_sn,em_name_code);
--======================================
--======================================CCM
CREATE TABLE list_ccm_question_categ
    (ccm_question_categ_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_ccm_question_categ ADD CONSTRAINT list_ccm_question_categ_PK
PRIMARY KEY (ccm_question_categ_code);
--
CREATE TABLE ccm_question_categ_lang
    (ccm_question_categ_lang_sn number(11)
    ,ccm_question_categ_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE ccm_question_categ_lang ADD CONSTRAINT ccm_question_categ_lang_PK
PRIMARY KEY (ccm_question_categ_lang_sn);
--
ALTER TABLE  ccm_question_categ_lang ADD CONSTRAINT  ccm_question_categ_lang_FK1
FOREIGN KEY (ccm_question_categ_code) REFERENCES list_ccm_question_categ (ccm_question_categ_code);
--
ALTER TABLE ccm_question_categ_lang ADD CONSTRAINT ccm_question_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX ccm_question_categ_lang_ak1
ON ccm_question_categ_lang (ccm_question_categ_code,lang_code);
--======================================
CREATE TABLE list_ccm_question
    (ccm_question_code varchar2(6)
    ,ccm_question_categ_code varchar2(4) not null
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_ccm_question ADD CONSTRAINT list_ccm_question_PK
PRIMARY KEY (ccm_question_code);
--
ALTER TABLE  list_ccm_question ADD CONSTRAINT  list_ccm_question_FK1
FOREIGN KEY (ccm_question_categ_code) REFERENCES list_ccm_question_categ (ccm_question_categ_code);
--
CREATE TABLE ccm_question_lang
    (ccm_question_lang_sn number(11)
    ,ccm_question_code varchar2(6) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE ccm_question_lang ADD CONSTRAINT ccm_question_lang_PK
PRIMARY KEY (ccm_question_lang_sn);
--
ALTER TABLE  ccm_question_lang ADD CONSTRAINT  ccm_question_lang_FK1
FOREIGN KEY (ccm_question_code) REFERENCES list_ccm_question (ccm_question_code);
--
ALTER TABLE ccm_question_lang ADD CONSTRAINT ccm_question_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX ccm_question_lang_ak1
ON ccm_question_lang (ccm_question_code,lang_code);
--===========================
CREATE TABLE provider_ccm
    (provider_ccm_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,symptom_comment nvarchar2(1000)
    ,medication_comment nvarchar2(1000)
    ,family_pmhx_comment nvarchar2(1000)
    ,rf_comment nvarchar2(1000)
    ,disease_comment nvarchar2(1000)
    ,additional_notes nvarchar2(1000)
    ,ccm_followup_svc_date date
    ,ccm_followup_svc_hr_code varchar2(2)
    ,ccm_followup_svc_min_code varchar2(2)
    ,ccm_followup_svc_am_pm_code varchar2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE provider_ccm ADD CONSTRAINT provider_ccm_PK
PRIMARY KEY (provider_ccm_sn);
--
ALTER TABLE provider_ccm ADD CONSTRAINT provider_ccm_FK2
FOREIGN KEY (patient_prev_svc_sn) REFERENCES  patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE provider_ccm ADD CONSTRAINT provider_ccm_FK3
FOREIGN KEY (ccm_followup_svc_hr_code) REFERENCES list_hr(hr_code);
--
ALTER TABLE provider_ccm ADD CONSTRAINT provider_ccm_FK4
FOREIGN KEY (ccm_followup_svc_min_code) REFERENCES list_min(min_code);
--
ALTER TABLE provider_ccm ADD CONSTRAINT provider_ccm_FK5
FOREIGN KEY (ccm_followup_svc_am_pm_code) REFERENCES list_am_pm(am_pm_code);
--
CREATE unique INDEX provider_ccm_ak1
ON provider_ccm (patient_prev_svc_sn);
--===========================
CREATE TABLE provider_ccm_question
    (provider_ccm_question_sn number(11)
    ,provider_ccm_sn number(11) not null
    ,ccm_question_code varchar2(6) not null
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE provider_ccm_question ADD CONSTRAINT provider_ccm_question_PK
PRIMARY KEY (provider_ccm_question_sn);
--
ALTER TABLE  provider_ccm_question ADD CONSTRAINT  provider_ccm_question_FK1
FOREIGN KEY (ccm_question_code) REFERENCES list_ccm_question (ccm_question_code);
--
ALTER TABLE provider_ccm_question ADD CONSTRAINT provider_ccm_question_FK2
FOREIGN KEY (provider_ccm_sn) REFERENCES  provider_ccm(provider_ccm_sn);
--
CREATE unique INDEX provider_ccm_question_ak1
ON provider_ccm_question (provider_ccm_sn,ccm_question_code);
--======================================
CREATE TABLE svc_result
    (svc_result_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,disease_code varchar2(4) not null
    ,disease_level_code varchar2(3) not null
    ,disease_severity_code varchar2(5) not null
    ,obesity_rf_avail_flag varchar2(1) DEFAULT 'N'
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE svc_result ADD CONSTRAINT svc_result_PK
PRIMARY KEY (svc_result_sn);
--
ALTER TABLE  svc_result ADD CONSTRAINT  svc_result_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc (patient_prev_svc_sn);
--
ALTER TABLE  svc_result ADD CONSTRAINT  svc_result_FK2
FOREIGN KEY (disease_code) REFERENCES list_disease (disease_code);
--
ALTER TABLE  svc_result ADD CONSTRAINT  svc_result_FK3
FOREIGN KEY (disease_level_code) REFERENCES list_disease_level (disease_level_code);
--
ALTER TABLE  svc_result ADD CONSTRAINT  svc_result_FK4
FOREIGN KEY (disease_severity_code) REFERENCES list_disease_severity (disease_severity_code);
--
CREATE unique INDEX svc_result_ak1
ON svc_result (patient_prev_svc_sn,disease_code);
--==================================
CREATE TABLE svc_result_rpt
    (svc_result_rpt_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,svc_rpt_type_code varchar2(3) not null
    ,RPT_JSON_CLOB clob
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE svc_result_rpt ADD CONSTRAINT svc_result_rpt_PK
PRIMARY KEY (svc_result_rpt_sn);
--
ALTER TABLE  svc_result_rpt ADD CONSTRAINT  svc_result_rpt_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc (patient_prev_svc_sn);
--
ALTER TABLE  svc_result_rpt ADD CONSTRAINT  svc_result_rpt_FK2
FOREIGN KEY (svc_rpt_type_code) REFERENCES list_svc_rpt_type (svc_rpt_type_code);
--
CREATE unique INDEX svc_result_rpt_ak1
ON svc_result_rpt (patient_prev_svc_sn,svc_rpt_type_code);
--======================================
CREATE TABLE list_rf_counseling_categ
    (rf_counseling_categ_code varchar2(5)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_rf_counseling_categ ADD CONSTRAINT list_rf_counseling_categ_PK
PRIMARY KEY (rf_counseling_categ_code);
--
CREATE TABLE rf_counseling_categ_lang
    (rf_counseling_categ_lang_sn number(11)
    ,rf_counseling_categ_code varchar2(5) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(300)
    ,LONG_descr nvarchar2(1000)
    ,counseling_by NVARCHAR2(100)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE rf_counseling_categ_lang ADD CONSTRAINT rf_counseling_categ_lang_PK
PRIMARY KEY (rf_counseling_categ_lang_sn);
--
ALTER TABLE  rf_counseling_categ_lang ADD CONSTRAINT  rf_counseling_categ_lang_FK1
FOREIGN KEY (rf_counseling_categ_code) REFERENCES list_rf_counseling_categ (rf_counseling_categ_code);
--
ALTER TABLE rf_counseling_categ_lang ADD CONSTRAINT rf_counseling_categ_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX rf_counseling_categ_lang_ak1
ON rf_counseling_categ_lang (rf_counseling_categ_code,lang_code);
--======================================
CREATE TABLE list_missing_goals_reason
    (missing_goals_reason_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_missing_goals_reason ADD CONSTRAINT list_missing_goals_reason_PK
PRIMARY KEY (missing_goals_reason_code);
--
CREATE TABLE missing_goals_reason_lang
    (missing_goals_reason_lang_sn number(11)
    ,missing_goals_reason_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,rpt_descr nvarchar2(100)
    ,LONG_descr nvarchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE missing_goals_reason_lang ADD CONSTRAINT missing_goals_reason_lang_PK
PRIMARY KEY (missing_goals_reason_lang_sn);
--
ALTER TABLE  missing_goals_reason_lang ADD CONSTRAINT  missing_goals_reason_lang_FK1
FOREIGN KEY (missing_goals_reason_code) REFERENCES list_missing_goals_reason (missing_goals_reason_code);
--
ALTER TABLE missing_goals_reason_lang ADD CONSTRAINT missing_goals_reason_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX missing_goals_reason_lang_ak1
ON missing_goals_reason_lang (missing_goals_reason_code,lang_code);
--======================================
CREATE TABLE rf_missing_goals_reason
    (rf_missing_goals_reason_code varchar2(3)
    ,missing_goals_reason_code varchar2(4) not null
    ,risk_factor_code varchar2(4) not null
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE rf_missing_goals_reason ADD CONSTRAINT rf_missing_goals_reason_PK
PRIMARY KEY (rf_missing_goals_reason_code);
--
ALTER TABLE  rf_missing_goals_reason ADD CONSTRAINT  rf_missing_goals_reason_FK1
FOREIGN KEY (missing_goals_reason_code) REFERENCES list_missing_goals_reason (missing_goals_reason_code);
--
ALTER TABLE rf_missing_goals_reason ADD CONSTRAINT rf_missing_goals_reason_FK2
FOREIGN KEY (risk_factor_code) REFERENCES  list_risk_factor(risk_factor_code);
--
CREATE unique INDEX rf_missing_goals_reason_ak1
ON rf_missing_goals_reason (missing_goals_reason_code,risk_factor_code);
--======================================
CREATE TABLE svc_rf_missing_goals_reason
    (patient_prev_svc_sn number(11) not null
    ,rf_missing_goals_reason_code varchar2(3) not null
    ,other_reason_text     NVARCHAR2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE svc_rf_missing_goals_reason ADD CONSTRAINT svc_rf_missing_goals_reason_PK
PRIMARY KEY (patient_prev_svc_sn,rf_missing_goals_reason_code);
--
ALTER TABLE  svc_rf_missing_goals_reason ADD CONSTRAINT  svc_rf_missing_goals_reasonFK1
FOREIGN KEY (rf_missing_goals_reason_code) REFERENCES rf_missing_goals_reason (rf_missing_goals_reason_code);
--
ALTER TABLE svc_rf_missing_goals_reason ADD CONSTRAINT svc_rf_missing_goals_reasonFK2
FOREIGN KEY (patient_prev_svc_sn) REFERENCES  patient_prev_svc(patient_prev_svc_sn);
--==================================
CREATE TABLE svc_screening
    (svc_screening_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,rf_counseling_categ_code varchar2(5) not null
    ,risk_factor_code varchar2(4) not null
    ,recommend_counseling_flag VARCHAR2(1) NOT NULL
    ,comment nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE svc_screening ADD CONSTRAINT svc_screening_PK
PRIMARY KEY (svc_screening_sn);
--
ALTER TABLE  svc_screening ADD CONSTRAINT  svc_screening_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc (patient_prev_svc_sn);
--
ALTER TABLE  svc_screening ADD CONSTRAINT  svc_screening_FK2
FOREIGN KEY (rf_counseling_categ_code) REFERENCES list_rf_counseling_categ (rf_counseling_categ_code);
--
ALTER TABLE  svc_screening ADD CONSTRAINT  svc_screening_FK3
FOREIGN KEY (risk_factor_code) REFERENCES list_risk_factor (risk_factor_code);
--
CREATE unique INDEX svc_screening_ak1
ON svc_screening (patient_prev_svc_sn,risk_factor_code,rf_counseling_categ_code);
--==================================
CREATE TABLE svc_counseling
    (svc_counseling_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,svc_screening_sn number(11) not null
    ,compliance_flag VARCHAR2(1) NOT NULL
    ,counseling_outcome nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE svc_counseling ADD CONSTRAINT svc_counseling_PK
PRIMARY KEY (svc_counseling_sn);
--
ALTER TABLE  svc_counseling ADD CONSTRAINT  svc_counseling_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc (patient_prev_svc_sn);
--
ALTER TABLE  svc_counseling ADD CONSTRAINT  svc_counseling_FK2
FOREIGN KEY (svc_screening_sn) REFERENCES svc_screening (svc_screening_sn);
--
CREATE unique INDEX svc_counseling_ak1
ON svc_counseling (patient_prev_svc_sn,svc_screening_sn);
--==========================================================
create table svc_risk_factor_remark
    (svc_risk_factor_remark_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,risk_factor_code varchar2(4) not null
    ,remark_categ_grp_code varchar2(4) not null
    ,remark_categ_name nvarchar2(200)
    ,remark_note nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE svc_risk_factor_remark ADD CONSTRAINT svc_risk_factor_remark_PK
PRIMARY KEY (svc_risk_factor_remark_sn);
--
ALTER TABLE svc_risk_factor_remark ADD CONSTRAINT svc_risk_factor_remark_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc(patient_prev_svc_sn);
--
ALTER TABLE  svc_risk_factor_remark ADD CONSTRAINT  svc_risk_factor_remark_FK2
FOREIGN KEY (risk_factor_code) REFERENCES list_risk_factor (risk_factor_code);
--
ALTER TABLE  svc_risk_factor_remark ADD CONSTRAINT  svc_risk_factor_remark_FK3
FOREIGN KEY (remark_categ_grp_code) REFERENCES list_remark_categ_grp (remark_categ_grp_code);
--
CREATE unique INDEX svc_risk_factor_remark_ak1
ON svc_risk_factor_remark (patient_prev_svc_sn,risk_factor_code,remark_categ_grp_code,upper(remark_categ_name));
---------===================EM Service End--------======================
--======================================
CREATE TABLE list_prev_plan
    (prev_plan_code varchar2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_prev_plan ADD CONSTRAINT list_prev_plan_PK
PRIMARY KEY (prev_plan_code);
--
CREATE TABLE prev_plan_lang
    (prev_plan_lang_sn number(11)
    ,prev_plan_code varchar2(4) not null
    ,lang_code varchar2(2) not null
    ,SHORT_DESCR NVARCHAR2(100)
    ,LONG_descr nvarchar2(2000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE prev_plan_lang ADD CONSTRAINT prev_plan_lang_PK
PRIMARY KEY (prev_plan_lang_sn);
--
ALTER TABLE  prev_plan_lang ADD CONSTRAINT  prev_plan_lang_FK1
FOREIGN KEY (prev_plan_code) REFERENCES list_prev_plan (prev_plan_code);
--
ALTER TABLE prev_plan_lang ADD CONSTRAINT prev_plan_lang_FK2
FOREIGN KEY (lang_code) REFERENCES  list_lang(lang_code);
--
CREATE unique INDEX prev_plan_lang_ak1
ON prev_plan_lang (prev_plan_code,lang_code);
--======================================
CREATE TABLE risk_factor_prev_plan
    (risk_factor_prev_plan_sn number(11)
    ,prev_plan_code varchar2(4) not null
    ,risk_factor_code varchar2(4) not null
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE risk_factor_prev_plan ADD CONSTRAINT risk_factor_prev_plan_PK
PRIMARY KEY (risk_factor_prev_plan_sn);
--
ALTER TABLE  risk_factor_prev_plan ADD CONSTRAINT  risk_factor_prev_plan_FK1
FOREIGN KEY (prev_plan_code) REFERENCES list_prev_plan (prev_plan_code);
--
ALTER TABLE risk_factor_prev_plan ADD CONSTRAINT risk_factor_prev_plan_FK2
FOREIGN KEY (risk_factor_code) REFERENCES  list_risk_factor(risk_factor_code);
--
CREATE unique INDEX risk_factor_prev_plan_ak1
ON risk_factor_prev_plan (prev_plan_code,risk_factor_code);
--======================================
CREATE TABLE disease_prev_plan
    (disease_prev_plan_sn number(11)
    ,prev_plan_code varchar2(4) not null
    ,disease_code varchar2(4) not null
    ,order_num number(9)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE disease_prev_plan ADD CONSTRAINT disease_prev_plan_PK
PRIMARY KEY (disease_prev_plan_sn);
--
ALTER TABLE  disease_prev_plan ADD CONSTRAINT  disease_prev_plan_FK1
FOREIGN KEY (prev_plan_code) REFERENCES list_prev_plan (prev_plan_code);
--
ALTER TABLE disease_prev_plan ADD CONSTRAINT disease_prev_plan_FK2
FOREIGN KEY (disease_code) REFERENCES  list_disease(disease_code);
--
CREATE unique INDEX disease_prev_plan_ak1
ON disease_prev_plan (prev_plan_code,disease_code);

--Patient Response RESULT related create end--------==================================+++++++++++++++++++++++$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--======================================
CREATE TABLE contact_us
    (contact_us_sn number(11)
    ,first_name varchar2(50) not null
    ,last_name varchar2(50) not null
    ,email varchar2(100) not null
    ,phone_number varchar2(20) not null
    ,subject varchar2(100) not null
    ,message varchar2(2000) not null
    ,contacted_flag varchar2(1) default 'N' not null
    ,contacted_by_user_role_id raw(16)
    ,contact_notes  varchar2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );    
ALTER TABLE contact_us ADD CONSTRAINT contact_us_PK
PRIMARY KEY (contact_us_sn);
--
ALTER TABLE contact_us ADD CONSTRAINT contact_us_FK1
FOREIGN KEY (contacted_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
-----------------
ALTER TABLE "AspNetUsers" ADD CONSTRAINT AspNetUsers_FK4
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
--=============================
CREATE TABLE deleted_patient_prev_svc
    (patient_prev_svc_sn number(11)
    ,created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    ,patient_sn number(11) not null
    ,prev_svc_billing_code varchar2(5) not null
    ,svc_date date not null
    ,svc_perform_date date
    ,provider_physician_sn number(11) not null
    ,physician_svc_location_sn number(11) not null
    ,g0438_comp_on_diff_sys_flag varchar2(1) default 'N' not null
    ,svc_comp_flag varchar2(1) default 'N' not null
    ,patient_signature clob
    ,parent_patient_prev_svc_sn number(11)
    ,svc_hr_code varchar2(2)
    ,svc_min_code varchar2(2)
    ,svc_am_pm_code varchar2(2)
    ,request_em_perf_by_pcp_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL
    ,comment_when_deny_em nvarchar2(1000)
    ,qualify_for_em_followup_flag varchar2(1) DEFAULT 'N' NOT NULL
    ,chronic_disease_cnt number(2) DEFAULT 0 NOT NULL
    ,em_followup_svc_date date
    ,em_followup_svc_hr_code varchar2(2)
    ,em_followup_svc_min_code varchar2(2)
    ,em_followup_svc_am_pm_code varchar2(2)
    ,marital_status_code varchar2(3)
    ,working_status_code varchar2(3)
    ,education_level_code varchar2(4)
    ,financial_status_code varchar2(4)
    ,living_status_code varchar2(4)
    ,income_code varchar2(4)
    ,height_in_in number(3)
    ,weight_in_lb number(3)
    ,hdl_cholesterol_in_mg number(2)
    ,ldl_cholesterol_in_mg number(3)
    ,systolic_bp_in_mm number(3)
    ,diastolic_bp_in_mm number(3)
    ,blood_sugar_level_in_mg number(3)
    ,source_of_history_emr_flag varchar2(1) DEFAULT 'N'
    ,source_of_history_patient_flag varchar2(1) DEFAULT 'N'
    ,source_of_history_family_flag varchar2(1) DEFAULT 'N'
    ,patient_orientation_code varchar2(3)
    ,sub_prev_svc_billing_code varchar2(5)
    ,addl_sub_prev_svc_billing_code varchar2(5)
    ,inactive_reason_descr nvarchar2(1000)
    ,rec_ACTIVE_FLAG           VARCHAR2(1)
    ,rec_Z_CREATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_CREATE_TMSTMP       TIMESTAMP
    ,rec_Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_UPDATE_TMSTMP       TIMESTAMP
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE deleted_patient_prev_svc ADD CONSTRAINT deleted_patient_prev_svc_PK
PRIMARY KEY (patient_prev_svc_sn);
--==========================
CREATE TABLE deleted_patient_response
    (patient_response_sn number(11)
    ,patient_prev_svc_sn number(11) not null
    ,question_response_code varchar2(6) not null
    ,response_data  nvarchar2(100)
    ,rec_ACTIVE_FLAG           VARCHAR2(1)
    ,rec_Z_CREATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_CREATE_TMSTMP       TIMESTAMP
    ,rec_Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_UPDATE_TMSTMP       TIMESTAMP
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE deleted_patient_response ADD CONSTRAINT deleted_patient_response_PK
PRIMARY KEY (patient_response_sn);
--
ALTER TABLE  deleted_patient_response ADD CONSTRAINT deleted_patient_response_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES deleted_patient_prev_svc(patient_prev_svc_sn);
--=========================
create table deleted_pps_remark
    (patient_prev_svc_remark_sn number(11)
    ,patient_prev_svc_sn NUMBER(11) NOT NULL
    ,remark_note nvarchar2(2000)
    ,rec_ACTIVE_FLAG           VARCHAR2(1)
    ,rec_Z_CREATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_CREATE_TMSTMP       TIMESTAMP
    ,rec_Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)
    ,rec_Z_UPDATE_TMSTMP       TIMESTAMP
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE deleted_pps_remark ADD CONSTRAINT deleted_pps_remark_PK
PRIMARY KEY (patient_prev_svc_remark_sn);
--
ALTER TABLE deleted_pps_remark ADD CONSTRAINT deleted_pps_remark_FK1
FOREIGN KEY (patient_prev_svc_sn) REFERENCES deleted_patient_prev_svc(patient_prev_svc_sn);

