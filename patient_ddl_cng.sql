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
    ,patient_orientation_code varchar(3) not null
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
--==============
ALTER TABLE  patient_prev_svc ADD (    marital_status_code varchar2(3)
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
    ,source_of_history_emr_flag varchar2(1)  DEFAULT 'N'
    ,source_of_history_patient_flag varchar2(1) DEFAULT 'N'
    ,source_of_history_family_flag varchar2(1) DEFAULT 'N'
    ,patient_orientation_code varchar2(3)
);
--
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
begin
  for i in (select patient_sn
                  ,marital_status_code
                  ,working_status_code
                  ,education_level_code
                  ,financial_status_code
                  ,living_status_code
                  ,income_code
                  ,height_in_in
                  ,weight_in_lb
                  ,hdl_cholesterol_in_mg
                  ,ldl_cholesterol_in_mg
                  ,systolic_bp_in_mm
                  ,diastolic_bp_in_mm
                  ,blood_sugar_level_in_mg
            from patient
            )
  loop
    for j in (select patient_prev_svc_sn
              from patient_prev_svc
              where patient_sn = i.patient_sn
              and prev_svc_billing_code in ('G0438','G0439')
              )
    loop
      update patient_prev_svc
      set marital_status_code = i.marital_status_code
          ,working_status_code = i.working_status_code
          ,education_level_code = i.education_level_code
          ,financial_status_code = i.financial_status_code
          ,living_status_code = i.living_status_code
          ,income_code = i.income_code
          ,height_in_in = i.height_in_in
          ,weight_in_lb = i.weight_in_lb
          ,hdl_cholesterol_in_mg = i.hdl_cholesterol_in_mg
          ,ldl_cholesterol_in_mg = i.ldl_cholesterol_in_mg
          ,systolic_bp_in_mm = i.systolic_bp_in_mm
          ,diastolic_bp_in_mm = i.diastolic_bp_in_mm
          ,blood_sugar_level_in_mg = i.blood_sugar_level_in_mg
      where patient_prev_svc_sn = j.patient_prev_svc_sn
      ;
    end loop;
  end loop;
  commit;
end;
/
--
--ALTER TABLE  patient drop column marital_status_code;
--ALTER TABLE  patient drop column working_status_code;
--ALTER TABLE  patient drop column education_level_code;
--ALTER TABLE  patient drop column financial_status_code;
--ALTER TABLE  patient drop column living_status_code;
--ALTER TABLE  patient drop column income_code;
--Dropped forever
--ALTER TABLE  patient drop column age;
--ALTER TABLE  patient drop column bmi;
--ALTER TABLE  patient drop column need_ccm_flag;
--
--ALTER TABLE  patient drop column height_in_in;
--ALTER TABLE  patient drop column weight_in_lb;
--ALTER TABLE  patient drop column hdl_cholesterol_in_mg;
--ALTER TABLE  patient drop column ldl_cholesterol_in_mg;
--ALTER TABLE  patient drop column systolic_bp_in_mm;
--ALTER TABLE  patient drop column diastolic_bp_in_mm;
--ALTER TABLE  patient drop column blood_sugar_level_in_mg;


