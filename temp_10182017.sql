--delete from disease_prev_plan where disease_code in ('CHFD','AFIB','HATK');
--delete from disease_risk_factor where disease_code in ('CHFD','AFIB','HATK');
--delete from disease_symptom where disease_code in ('CHFD','AFIB','HATK');
--delete from svc_result where disease_code in ('CHFD','AFIB','HATK');
--commit;
--delete from patient_response
--where question_response_code in (select question_response_code 
--                                from question_response 
--                                where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--                                and RESPONSE_CODE = 'CBX'
--                                )
--                                ;
--delete from question_response 
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--and RESPONSE_CODE = 'CBX'
--;
--delete from question_lang
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--and lang_code = 'en'
--;
--delete from question
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1010')
--;
--update question_response
--set disease_code = null --AFIB
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1011')
--and RESPONSE_CODE = 'CBX'
--;
--update question_response
--set disease_code = null --CHFD
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1009')
--and RESPONSE_CODE = 'CBX'
--;
--delete from disease_lang where disease_code in ('CHFD','AFIB','HATK');
--delete from list_disease where disease_code in ('CHFD','AFIB','HATK');
--commit;
--
--begin
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/

--update question_response
--set disease_level_code = 'LOW'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'LTW'
--;
--update question_response
--set disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'MTW'
--;
--update question_response
--set disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'MTM'
--;
--commit;

--update question_lang
--set short_descr = 'Disability due to Major Health Event'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Lung Disease COPD (Emphysema) or Other'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1013')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Major Depression'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1020')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Limiting Stress'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1026')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Limiting Anxiety (GAD)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1025')
--and lang_code = 'en'
--;
--commit;
--alter table question modify (order_num number(10,1));
--update question_lang
--set short_descr = 'Cancer History'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1012')
--and lang_code = 'en'
--;
--commit;
--select * from list_response where response_code in ('HBP','HCO','HSG');
--update question_response
--set response_code = 'HBP'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set response_code = 'HSG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set response_code = 'HCO'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'NOO'
--;
--commit;
--delete from patient_response
--where question_response_code in (select question_response_code 
--                                from question_response 
--                                where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1020')
--                                --and RESPONSE_CODE = 'CBX'
--                                )
--                                ;
--delete from question_response 
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1020')
----and RESPONSE_CODE = 'CBX'
--;
--delete from question_lang
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1020')
--and lang_code = 'en'
--;
--delete from question
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1020')
--;
--commit;
--delete from patient_response
--where question_response_code in (select question_response_code 
--                                from question_response 
--                                where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1023')
--                                --and RESPONSE_CODE = 'CBX'
--                                )
--                                ;
--delete from question_response 
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1023')
----and RESPONSE_CODE = 'CBX'
--;
--delete from question_lang
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1023')
--and lang_code = 'en'
--;
--delete from question
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1023')
--;
--commit;
--update question
--set order_num = 15.1
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1015')
--;
--update question_lang
--set short_descr = 'Diabetes Acquired (Diabetes Mellitus -DM2)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1015')
--and lang_code = 'en'
--;
--commit;
--begin
--  list_trans_pkg.load_disease_symptom;
--end;
--/
--update question_lang
--set long_descr = 'ER or Hospitalization due to Injury/Fall'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1023')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Recent Hospitalization'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and lang_code = 'en'
--;
--commit;
--begin
--  list_trans_pkg.load_disease;
--end;
--/
--update question_response
--set disease_code = 'SFTY'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1018')
--;
--update question_response
--set risk_factor_code = 'SFTY'
--    ,disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1018')
--and RESPONSE_CODE = 'IDK'
--;
--commit;
--update question_lang
--set long_descr = 'Health Status'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLTY' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in Stooping, Crouching or Kneeling'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in lifting, or carrying objects'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in reaching or extending arms above shoulder level'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in writing, or handling and grasping small objects'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in walking'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1005')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in heavy housework'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT1' and question_code = '1006')
--and lang_code = 'en'
--;
----
--update question_lang
--set long_descr = 'Difficulty in shopping for personal items'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in managing money'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in walking across the room'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in doing light housework'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Difficulty in bathing or showering'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1005')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Need help performing daily activities'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FRLT2' and question_code = '1006')
--and lang_code = 'en'
--;
--commit;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1018')
--;
--commit;
--update question_response
--set disease_code = 'CHDE'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1009')
--and RESPONSE_CODE = 'CBX'
--;
--update question_response
--set disease_code = 'CHDE'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1011')
--and RESPONSE_CODE = 'CBX'
--;
--commit;
--set serveroutput on
--declare    
--  v_em_flag varchar2(1);
--  v_chronic_disease_cnt number;
--begin
--  for i in (select patient_prev_svc_sn
--            from patient_prev_svc_vw
--            where svc_type_code = 'AWV'
--            and completed_flag = 'Y'
--            and patient_prev_svc_sn = 33
--            )
--  loop
--    begin
--      svc_eval_pkg.svc_result_prc (i.patient_prev_svc_sn,v_em_flag,v_chronic_disease_cnt);
--      update patient_prev_svc
--      set CHRONIC_DISEASE_CNT = v_chronic_disease_cnt
--        ,QUALIFY_FOR_EM_FOLLOWUP_FLAG = v_em_flag
--      where patient_prev_svc_sn = i.patient_prev_svc_sn
--      ;
--      commit;
--    exception
--      when others then
--        dbms_output.put_line ('patient_prev_svc_sn: '||i.patient_prev_svc_sn);
--    end;
--  end loop;
--end;
--/
--delete from disease_risk_factor where disease_code = 'CNCR' and risk_factor_code in ('INAC','DIET');
--commit;
--begin
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/
--update question_response
--set disease_code = 'CNCR'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FHNMR' and question_code = '1014')
----and RESPONSE_CODE = 'CBX'
--;
--commit;
--delete from disease_symptom where disease_code = 'CNCR' and symptom_code = 'BPAN';
--commit;
--update disease_lang
--set short_descr = 'Home Safety Concern'
--where disease_code = 'HOME'
--and lang_code = 'en'
--;
--commit;
--delete from disease_risk_factor where disease_code = 'OBES' and risk_factor_code in ('MEDI');
--commit;
--update question_lang
--set long_descr = 'Fall'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FALLR' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Dizziness (morning or evening)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FALLR' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Hearing loss'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FALLR' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Poor vision due to cataract'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FALLR' and question_code = '1006')
--and lang_code = 'en'
--;
--commit;
--update question_lang
--set short_descr = 'Do you know if you have a history of Blood Pressure?'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'Y05'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'Y03'
--;
--update question_response
--set risk_factor_code = 'HBPR'
--    ,disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'IDK'
--;
-----------------
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'Y05'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'Y03'
--;
--update question_response
--set risk_factor_code = 'DIAB'
--    ,disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'IDK'
--;
-----------------
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'Y05'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'Y03'
--;
--update question_response
--set risk_factor_code = 'HCHO'
--    ,disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'IDK'
--;
-------------------
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1005')
--and RESPONSE_CODE = 'Y08'
--;
-------------------
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1006')
--and RESPONSE_CODE = 'Y11'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1006')
--and RESPONSE_CODE = 'Y12'
--;
--commit;
--update question_lang
--set long_descr = 'Uncontrolled Blood Pressure'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Uncontrolled Blood Sugar'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Uncontrolled Cholesterol'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Uncontrolled Alcohol Consumption'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1006')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Habit of excessive Soda'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1010')
--and lang_code = 'en'
--;
--commit;
--delete from disease_risk_factor where disease_code = 'PNEU' and risk_factor_code in ('AGEE','HOSP');
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE in ('HBP','IDK')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE in ('HSG','IDK')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE in ('HCO','IDK')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1007')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1008')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1017')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1021')
--and RESPONSE_CODE in ('NOO','IDK')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1022')
--;
--update question_response
--set disease_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1024')
--and RESPONSE_CODE in ('NOO')
--;
--update response_lang
--set short_descr = 'Less than a Month ago'
--where response_code = 'LTW'
--and lang_code = 'en'
--;
--update response_lang
--set short_descr = 'More than a Month ago'
--where response_code = 'MTM'
--and lang_code = 'en'
--;
--update response_lang
--set short_descr = 'More than a Year ago'
--where response_code = 'MTW'
--and lang_code = 'en'
--;
--update question_response
--set order_num = 3
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'MTW'
--;
--update question_response
--set order_num = 2
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'MTM'
--;
--update question_response
--set risk_factor_code = null
--    ,disease_level_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--;
--update question_response
--set risk_factor_code = 'HOSP'
--    ,disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'LTW'
--;
--update question_response
--set risk_factor_code = 'HOSP'
--    ,disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HSURA' and question_code = '1002')
--and RESPONSE_CODE = 'MTM'
--;
--commit;
--begin
--  list_trans_pkg.load_risk_factor;
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/
--update question_lang
--set long_descr = 'Lack of Activities/Exercise'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1009')
--and lang_code = 'en'
--;
--commit;
----------------------------------10232017
--Do you regularly drink sodas or packed drinks?	Away (CHDE) DTDR
--Do you regularly eat fast food? Away (HCHO) (CHDE) DTFF
--Do you regularly consume high refined sugar content foods? Home (Diab/Obesity) DTSG
--Do you regularly consume high salt content food? (BP) DTST
--Do you regularly eat fresh fruits? (Home) (CHDE) DTFR
--Do you regularly eat fresh vegetables? (Home) (CHDE) DTVG
--Do you regularly eat grain products? (Home) (CHDE) DTGR

--Medication: Need to show patient name
--Medication unit: Not all the units are showing
--Ingredient Amt: Allow to enter - (varchar2 from number)
--Micrograms
--Spoon
--Amount 0.25 is rounding to zero
--
--Remarks: remove remark sn
------------------
--ALTER TABLE patient_medication add(medication_quantity2 varchar2(10));
--update patient_medication set medication_quantity2 = medication_quantity;
--commit;
--ALTER TABLE patient_medication drop column medication_quantity;
--ALTER TABLE patient_medication rename column medication_quantity2 to medication_quantity;
--13% probability of hearing impairment (no handicap)  --Low
--50% probability of hearing impairment (mild-moderate handicap) --Moderate
--84% probability of hearing impairment (severe handicap) -- Severe
-------------------
--delete from disease_risk_factor where disease_code = 'STRK';
--delete from disease_risk_factor where risk_factor_code = 'DIET';
--delete from patient_response
--where question_response_code in (select question_response_code 
--                                from question_response 
--                                where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1027')
--                                and RESPONSE_CODE = 'CBX'
--                                )
--                                ;
--delete from question_response 
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1027')
--and RESPONSE_CODE = 'CBX'
--;
--delete from question_lang
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1027')
--and lang_code = 'en'
--;
--delete from question
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1027')
--;
--commit;
----
----ALTER TABLE list_risk_factor_categ add (diet_categ_flag       VARCHAR2(1)   DEFAULT 'N' NOT NULL);
--begin
--  list_trans_pkg.load_disease;
--  list_trans_pkg.load_risk_factor_categ;
--  list_trans_pkg.load_risk_factor;
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/
--update question_response
--set risk_factor_code = 'DTDR'
--    ,disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1010')
--and RESPONSE_CODE = 'YES'
--;
--update question_response
--set risk_factor_code = 'DTFF'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1011')
--and RESPONSE_CODE = 'YES'
--;
--update question_response
--set risk_factor_code = 'DTSG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1012')
--and RESPONSE_CODE = 'YES'
--;
--update question_response
--set risk_factor_code = 'DTST'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1013')
--and RESPONSE_CODE = 'YES'
--;
--update question_response
--set risk_factor_code = 'DTFR'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1014')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set risk_factor_code = 'DTVG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1015')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set risk_factor_code = 'DTGR'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1016')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'IDK'
--;
--update question_response
--set disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'IDK'
--;
--update question_response
--set disease_level_code = 'MOD'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'IDK'
--;
--update question_lang
--set long_descr = 'Lack daily consumption of grain products'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1016')
--and lang_code = 'en'
--;
--update categ_score_eval_lang
--set short_descr = short_descr||' with Rx meds taken'
--where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where question_categ_code = 'MEDCP')
--;
--update categ_score_eval_lang
--set short_descr = 'Low (no Hearing Loss)'
--where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where question_categ_code = 'HHISQ' and QUESTION_SUB_CATEG_CODE is null and SCORE_RANGE_BEGIN = 0)
--;
--update categ_score_eval_lang
--set short_descr = 'Moderate'
--where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where question_categ_code = 'HHISQ' and QUESTION_SUB_CATEG_CODE is null and SCORE_RANGE_BEGIN = 10)
--;
--update categ_score_eval_lang
--set short_descr = 'Severe'
--where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where question_categ_code = 'HHISQ' and QUESTION_SUB_CATEG_CODE is null and SCORE_RANGE_BEGIN = 26)
--;
--update question_lang
--set long_descr = 'Lack of interest to lose weight'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1008')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Hypertension (HBP)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1008')
--and lang_code = 'en'
--;
--commit;
---------------------------============================disease replace of ELNL and SLNL with LONL
--delete from disease_risk_factor where risk_factor_code = 'HOSP';
--delete from disease_risk_factor where risk_factor_code = 'OBES';
--delete from disease_risk_factor where DISEASE_CODE = 'CHDE' and risk_factor_code in ('DTDR','DTFF','DTFR','DTVG','DTGR');
--delete from disease_risk_factor where DISEASE_CODE = 'HBPR' and risk_factor_code = 'HBPR';
--begin
--  list_trans_pkg.load_disease_categ;
--  list_trans_pkg.load_disease;
--  list_trans_pkg.load_disease_prev_plan;
--  list_trans_pkg.load_risk_factor;
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/
--update question_response
--set risk_factor_code = 'WEIT'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1008')
--and RESPONSE_CODE = 'NOO'
--;
----
--update question_lang
--set short_descr = 'Parkinson'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FHNMR' and question_code = '1010')
--and lang_code = 'en'
--;
--update question_response
--set disease_level_code = 'HIG'
--    ,risk_factor_code = 'FMHX'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FHNMR')
--;
--update question_response
--set disease_code = 'CLDE'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FHNMR' and question_code = '1007')
--;
--update question_response
--set disease_code = 'PARK'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FHNMR' and question_code = '1010')
--;
------
--update question_lang
--set short_descr = 'Lung Disease COPD (Emphysema)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1013')
--and lang_code = 'en'
--;
--update question_response
--set disease_level_code = 'SEV'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1007')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set disease_level_code = 'HIG'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1019')
--and RESPONSE_CODE = 'NOO'
--;
--update question
--set question_sub_categ_code = null
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS')
--;
--delete from svc_result where disease_code in ('ELNL','SLNL','OBES');
--delete from categ_score_eval_lang where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where QUESTION_CATEG_CODE = 'LONLS');
--delete from categ_score_eval where QUESTION_CATEG_CODE = 'LONLS';
--delete from disease_prev_plan where disease_code in ('ELNL','SLNL');
--delete from disease_lang where disease_code in ('ELNL','SLNL');
--delete from list_disease where disease_code in ('ELNL','SLNL');
--delete from question_sub_categ_lang where question_sub_categ_code in (select question_sub_categ_code from list_question_sub_categ where question_sub_categ_code in ('EML','SCL'));
--delete from list_question_sub_categ where question_sub_categ_code in ('EML','SCL');
----
--commit;
----
----ALTER TABLE disease_risk_factor ADD(PRIMARY_RISK_FACTOR_FLAG VARCHAR2(1)   DEFAULT 'N' NOT NULL);
----
--begin
--  list_trans_pkg.load_disease_categ;
--  list_trans_pkg.load_disease;
--  list_trans_pkg.load_disease_prev_plan;
--  list_trans_pkg.load_categ_score_eval;
--  list_trans_pkg.load_question_sub_categ;
--  list_trans_pkg.load_risk_factor_categ;
--  list_trans_pkg.load_risk_factor;
--  list_trans_pkg.load_disease_risk_factor;
--end;
--/
--delete from disease_risk_factor where DISEASE_CODE = 'CHDE' and risk_factor_code in ('DTDR','DTFF','DTFR','DTVG','DTGR');
--commit;
----------------------------------
--Slow pace to cognitive decline
--Age >= 80
--Sev schycosocial disorder (Major Dep)
--Slow pace or slow movement
--IADL
--Any MDQ (SCHI) --Additional
--Poor memory (symptom)
--Cognitive decline - Poor memory
--
--
--Functional
--Age >= 80
--Any Neg ADL
--Go to symptom (
----Joint pain
----Loss of balance and slow movement
----BMI
----Inactive
--
--
--Your health is at Risk to become Frail (remove the severity)
--
--Patient AWV HRA outcome and PPP
--Physician HRA Outcome Clinical Report
-----------------------------------
--delete from categ_score_eval_lang where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where question_categ_code = 'PSYSD') and lang_code = 'en';
--delete from categ_score_eval where question_categ_code = 'PSYSD';
--commit;
--begin
--  list_trans_pkg.load_disease_level;
--end;
--/
-----------------11/6/2017=============================================================================================
--begin
--  list_trans_pkg.load_svc_rpt_type;
--end;
--/
--update question_response
--set score_value = 0
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HOMES' and question_code = '1008')
--and RESPONSE_CODE = 'NOO'
--;
--update question_response
--set score_value = 1
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HOMES' and question_code = '1008')
--and RESPONSE_CODE = 'YES'
--;
--commit;
--update question_lang
--set long_descr = 'Needs to keep emergency alert device or cell phone always'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HOMES' and question_code = '1009')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'Keep pets inside of the house at all times without taking outside for elimination purpose'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'HOMES' and question_code = '1008')
--and lang_code = 'en'
--;
--commit;
----=============================================================
--Title AWV/HRA Q&A
--CLINICIAN INTERVIEWER: instead of PROVIDER PHYSICIAN NAME:
--Add signature at the bottom
--Add Remark
--Add Medication
----==========================================================
--update disease_lang
--set short_descr = 'Home Lack of Safety'
--where disease_code = 'HOME'
--and lang_code = 'en'
--;
--commit;
--begin
--  list_trans_pkg.load_svc_rpt_type;
--end;
--/
--update svc_rpt_type_lang
--set SHORT_DESCR = 'Patient AWV/HRA Outcome and PPP'
--where svc_rpt_type_code = 'HRA'
--and LANG_CODE = 'en'
--;
--commit;
--delete from categ_score_eval_lang where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where QUESTION_CATEG_CODE = 'IADLB');
--delete from categ_score_eval where QUESTION_CATEG_CODE = 'IADLB';
--delete from categ_score_eval_lang where categ_score_eval_code in (select categ_score_eval_code from categ_score_eval where QUESTION_CATEG_CODE = 'ADLBF');
--delete from categ_score_eval where QUESTION_CATEG_CODE = 'ADLBF';
--commit;
--declare
--begin
--  for i in (select '1001'	question_code, 'You are not satisfied with your life' long_descr, 'GERDS' category_code from dual union
--            select '1002'	question_code, 'You dropped many of your activities and interests' long_descr, 'GERDS' category_code from dual union
--            select '1003'	question_code, 'You feel that your life is empty' long_descr, 'GERDS' category_code from dual union
--            select '1004'	question_code, 'You often get bored' long_descr, 'GERDS' category_code from dual union
--            select '1005'	question_code, 'You are not in a good mood most of the time' long_descr, 'GERDS' category_code from dual union
--            select '1006'	question_code, 'You constantly worry something bad is going to happen to you' long_descr, 'GERDS' category_code from dual union
--            select '1007'	question_code, 'You don''t feel happy most of the time' long_descr, 'GERDS' category_code from dual union
--            select '1008'	question_code, 'You often feel helpless' long_descr, 'GERDS' category_code from dual union
--            select '1009'	question_code, 'You prefer to stay at home rather than going out and doing new things' long_descr, 'GERDS' category_code from dual union
--            select '1010'	question_code, 'You feel that you have more memory problems than most people around you' long_descr, 'GERDS' category_code from dual union
--            select '1011'	question_code, 'You don''t think it is wonderful to be alive now' long_descr, 'GERDS' category_code from dual union
--            select '1012'	question_code, 'You feel pretty worthless the way you are right now' long_descr, 'GERDS' category_code from dual union
--            select '1013'	question_code, 'You don''t feel full of energy' long_descr, 'GERDS' category_code from dual union
--            select '1014'	question_code, 'You feel that your situation is hopeless' long_descr, 'GERDS' category_code from dual union
--            select '1015'	question_code, 'You think that most people are better off than you are' long_descr, 'GERDS' category_code from dual union
--            --		
--            select '1001'	question_code, 'Excessively worries' long_descr, 'ANXIT' category_code from dual union
--            select '1002'	question_code, 'Fear of a fall' long_descr, 'ANXIT' category_code from dual union
--            select '1003'	question_code, 'Fear to die' long_descr, 'ANXIT' category_code from dual union
--            select '1004'	question_code, 'Don''t know' long_descr, 'ANXIT' category_code from dual union
--            select '1005'	question_code, 'You been concerned about or fretted over a number of things' long_descr, 'ANXIT' category_code from dual union
--            select '1006'	question_code, 'There is something going on in your life that is causing you concern' long_descr, 'ANXIT' category_code from dual union
--            select '1007'	question_code, 'You find that you have a hard time putting things out of your mind' long_descr, 'ANXIT' category_code from dual union
--            select '1008'	question_code, 'You have felt anxious for more than a year' long_descr, 'ANXIT' category_code from dual
--            )
--  loop
--    update question_lang
--    set long_descr = i.long_descr
--    where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = i.category_code and question_code = i.question_code)
--    and lang_code = 'en'
--    ;
--  end loop;
--  commit;
--end;
--/
--declare
--begin
--  for i in (select '1001'	question_code, 'You were so hyper that you got into trouble or you were not your normal self' long_descr, 'MOOD1' category_code from dual union
--            select '1002'	question_code, 'You were so irritable that you shouted at people or started fights or arguments' long_descr, 'MOOD1' category_code from dual union
--            select '1003'	question_code, 'You felt much more self-confident than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1004'	question_code, 'You got much less sleep than usual and found you didn''t really miss it' long_descr, 'MOOD1' category_code from dual union
--            select '1005'	question_code, 'You were much more talkative or spoke much faster than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1006'	question_code, 'You couldn''t slow your mind down' long_descr, 'MOOD1' category_code from dual union
--            select '1007'	question_code, 'You were so easily distracted by things around you that you had trouble concentrating or staying on track' long_descr, 'MOOD1' category_code from dual union
--            select '1008'	question_code, 'You had much more energy than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1009'	question_code, 'You were much more active or did many more things than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1010'	question_code, 'You were much more social or outgoing than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1011'	question_code, 'You were much more interested in sex than usual' long_descr, 'MOOD1' category_code from dual union
--            select '1012'	question_code, 'You did things that were unusual for you or that other people might have thought were excessive, foolish, or risky' long_descr, 'MOOD1' category_code from dual union
--            select '1013'	question_code, 'Spending money got you or your family into trouble' long_descr, 'MOOD1' category_code from dual
--            )
--  loop
--    update question_lang
--    set long_descr = i.long_descr
--    where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = i.category_code and question_code = i.question_code)
--    and lang_code = 'en'
--    ;
--  end loop;
--  commit;
--end;
--/
------=========================11/17/2017============
--ALTER TABLE list_svc_rpt_type add(used_for_template_only_flag           VARCHAR2(1)   DEFAULT 'N' NOT NULL);
--begin
--  list_trans_pkg.load_svc_rpt_type;
--end;
--/
--drop TABLE svc_result_rpt purge;
--CREATE TABLE svc_result_rpt
--    (svc_result_rpt_sn number(11)
--    ,patient_prev_svc_sn number(11) not null
--    ,svc_rpt_type_code varchar2(3) not null
--    ,RPT_JSON_CLOB clob
--    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
--    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
--    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
--    );    
--ALTER TABLE svc_result_rpt ADD CONSTRAINT svc_result_rpt_PK
--PRIMARY KEY (svc_result_rpt_sn);
----
--ALTER TABLE  svc_result_rpt ADD CONSTRAINT  svc_result_rpt_FK1
--FOREIGN KEY (patient_prev_svc_sn) REFERENCES patient_prev_svc (patient_prev_svc_sn);
----
--ALTER TABLE  svc_result_rpt ADD CONSTRAINT  svc_result_rpt_FK2
--FOREIGN KEY (svc_rpt_type_code) REFERENCES list_svc_rpt_type (svc_rpt_type_code);
----
--CREATE unique INDEX svc_result_rpt_ak1
--ON svc_result_rpt (patient_prev_svc_sn,svc_rpt_type_code);
--
--begin
--  for i in (select patient_prev_svc_sn
--            from patient_prev_svc
--            where prev_svc_billing_code in ('G0438','G0439')
--            and svc_comp_flag = 'Y'
--            )
--  loop
--    mdtech_trans_pkg.awv_rpt_json_clob(i.patient_prev_svc_sn);
--  end loop;
--end;
--/
--begin
--  for i in (select patient_prev_svc_sn
--            from patient_prev_svc
--            where prev_svc_billing_code in ('99202','99212')
--            and svc_comp_flag = 'Y'
--            )
--  loop
--    mdtech_trans_pkg.eev_rpt_json_clob(i.patient_prev_svc_sn);
--  end loop;
--end;
--/
--begin
--  for i in (select patient_prev_svc_sn
--            from patient_prev_svc
--            where prev_svc_billing_code in ('99487','99490')
--            )
--  loop
--    mdtech_trans_pkg.csv_rpt_json_clob(i.patient_prev_svc_sn);
--  end loop;
--end;
--/
--begin
--  for i in (select patient_prev_svc_sn
--            from patient_prev_svc
--            where prev_svc_billing_code in ('99487','99490')
--            and svc_comp_flag = 'Y'
--            )
--  loop
--    mdtech_trans_pkg.cev_rpt_json_clob(i.patient_prev_svc_sn);
--  end loop;
--end;
--/
--update application_control_value
--set control_value_alpha = '305-934-9297'
--where acv_sn = (select acv_sn from application_control_value where control_value_name = 'CONTACT_PH')
--;
--commit;
--======================12/05/2017
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Metformin','500','MG','1D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Lovastatin','20','MG','1D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Ramipril','2.5','MG','1D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Zipsor','25','MG','2D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Diclofenac Sodium','50','MG','2D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Glucosamine-Chondroitin-man','375','MG','1D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--insert into patient_medication(PATIENT_MEDICATION_SN,PATIENT_SN,NAME,MEDICATION_QUANTITY,MEDICATION_UNIT_CODE,FREQUENCY_UNIT_CODE,MEDICATION_CURRENT_FLAG,PRESCRIBED_MED_FLAG,PURPOSE,NOTES,CREATED_BY_USER_ROLE_ID,UPDATED_BY_USER_ROLE_ID)
--values (PATIENT_MEDICATION_SNG.nextval,31,'Pennsaid','2','PT','2D','Y','Y',null,null,'5B5268524B1335E7E0530100007F6E6C','5B5268524B1335E7E0530100007F6E6C');
--commit;
--
---------===================================12/7/2017
--set define off
--  BEGIN
--    for i in (select 'SIB' response_code,'en' lang_code,'Sibling' short_descr,null long_descr from dual union
--              select 'FAS' response_code,'en' lang_code,'Father & Sibling' short_descr,null long_descr from dual union
--              select 'MAS' response_code,'en' lang_code,'Mother & Sibling' short_descr,null long_descr from dual union
--              select 'FMS' response_code,'en' lang_code,'Father, Mother & Sibling' short_descr,null long_descr from dual
--              )
--    loop
--      begin
--        INSERT INTO list_response (response_code                                        
--                                        )
--                                VALUES (i.response_code
--                                        );
--      exception 
--        when dup_val_on_index then
--          null;
--        when others then
--          null;
--      end;
--      begin
--        INSERT INTO response_lang (response_lang_SN
--                                        ,response_CODE
--                                        ,LANG_CODE
--                                        ,SHORT_DESCR
--                                        ,LONG_DESCR
--                                        )
--        VALUES (response_lang_SNG.nextval
--                ,i.response_CODE
--                ,i.LANG_CODE
--                ,i.SHORT_DESCR
--                ,i.LONG_DESCR
--               );
--      exception 
--        when dup_val_on_index then
--          update response_lang
--          set SHORT_DESCR = i.SHORT_DESCR
--              ,LONG_DESCR = i.LONG_DESCR
--          where response_CODE = i.response_CODE
--          and LANG_CODE = i.LANG_CODE
--          ;
--        when others then null;
--      end;
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--  /
  --
--  update question
--  set order_num = 10.1
--  where question_categ_code = 'FHNMR'
--  and question_code = '1015'
--  ;
--  commit;
--  
--If a patient is taking 2 meds ( vitamins does not count as meds) mean PT  has two chronic conditions.
--
--Aging ( after 80 years old need EM all time)
--
--In addition 79 & less yo if exist 2 of the 3 following RF:
--
--1st RF related Family PMHx with the disease that required the med(S)
--In other word if patient is taking per example Propalonol ( for HBP) and any of the  immediate Family has a Hx of suffering of HBP then this patient need an EM
--
--2nd RF Patient Report  wrong symptoms related with the 2 conditions treated with the 2 meds per example is taking Meds  for OA ( Arthritis) and his ADL Test showed any restriction
--or his Depression linking with the related Meds and Patient showed side effects related with Depression likes insomnia or some other known Factors
--
--3RF patient reported that had  undesirable side effect from Meds or Med
--that it is not  resolving the purpose of the  use  of the Med
--
--Then any of 2 RF of the above mentioned 3 PMHx call for an EM
--
--ALTER TABLE patient ADD (old_system_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL);
--update patient
--set OLD_SYSTEM_FLAG = 'Y'
--where patient_sn in (62
--        ,33
--        ,55
--        ,74
--        ,72
--        ,73)
--;
--commit;
--CKD LOGIC:
----Non modifiable RF  
--    --AGE 
--    --Family PMHx
----Modifiable RF
--    --HBP  
--    --DM  
--    --Smoking  
--    --high Chol. 
--    --Heart Disease  
--    --blood disorders like anemia,
----Additional factors
--    --Lack of water consumption and two or more conditions or comobird (please clarify)
--
--New formula:
--
--Uncontrolled HBP or DM
----SEVERE RISK the Two non modifiable (AGE and Family PMHx) + DM  and any one of the additional factor
----HIGH RISK ?
----MODERATE RISK. one non modifiable (AGE and Family PMHx) + two modifiable  or lack of water consumption
--
----When the condition is acquired the exacerbation CKD risk Factors are either DM or HBP uncontrolled and Smoking as the latest finding

----------Remove Alcohol Consumption,BMI and Race. Add high chol, Anemia and comorbidy
--Change lack of water and comorbidy as additional rf
---=======================================12/15/2017
--Package to implement
----common_inq.pkg.sql
----report.pkg.sql
----svc_eval.pkg.sql
----list_trans.pkg.sql
--Scripts to implement
------ins_upd_question.sql
------ins_upd_question_response.sql
------temp_10182017.sql
--Run
--------esv_rpt_json_clob.sql
--=====================Disease category
--  BEGIN
--    for i in (select 'ACON' disease_categ_code,'en' lang_code,'Excessive Alcohol Consumption' short_descr,'Excessive Alcohol Consumption.' long_descr from dual union
--              select 'BLOD' disease_categ_code,'en' lang_code,'Blood Disorder' short_descr,'A blood cell disorder is a condition in which there''s a problem with red/white cells, or the smaller circulating cells called platelets, which are critical for clot formation. All three cell types form in the bone marrow.' long_descr from dual
--              )
--    loop
--      begin
--        INSERT INTO list_disease_categ (disease_categ_code
--                                        )
--        VALUES (i.disease_categ_code
--               );
--      exception 
--        when dup_val_on_index then
--          null;
--        when others then null;
--      end;
--      begin
--        INSERT INTO disease_categ_lang (disease_categ_lang_sn
--                                        ,disease_categ_code
--                                        ,LANG_CODE
--                                        ,SHORT_DESCR
--                                        ,LONG_DESCR
--                                        )
--        VALUES (disease_categ_lang_SNG.nextval
--                ,i.disease_categ_code
--                ,i.LANG_CODE
--                ,i.SHORT_DESCR
--                ,i.LONG_DESCR
--               );
--      exception 
--        when dup_val_on_index then
--          update disease_categ_lang
--          set SHORT_DESCR = i.SHORT_DESCR
--              ,LONG_DESCR = i.LONG_DESCR
--          where disease_categ_code = i.disease_categ_code
--          and LANG_CODE = i.LANG_CODE
--          ;
--        when others then null;
--      end;      
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--/
-----====================Disease
--  declare
--    v_err_msg varchar2(1000);
--  BEGIN
--    for i in (select 'OBES' disease_code,'BDWT' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Obesity' short_descr,'A disorder involving excessive body fat that increases the risk of health problems.' long_descr from dual union
--              select 'BDIS' disease_code,'BLOD' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Blood Disorder' short_descr,'Common blood disorders include anemia, bleeding disorders such as hemophilia, blood clots, and blood cancers such as leukemia, lymphoma, and myeloma.' long_descr from dual union
--              select 'ALCO' disease_code,'ACON' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Alcoholism' short_descr,'A chronic disease characterized by uncontrolled drinking and preoccupation with alcohol.' long_descr from dual
--              )
--    loop
--      begin
--        INSERT INTO list_disease (disease_code
--                                 ,disease_categ_code
--                                 ,disease_type_code
--                                 ,trigger_ccm_flag
--                                 ,question_categ_code
--                                 )
--        VALUES (i.disease_code
--               ,i.disease_categ_code
--               ,i.disease_type_code
--               ,i.trigger_ccm_flag
--               ,i.question_categ_code
--               );
--      exception 
--        when dup_val_on_index then
--          update list_disease
--          set disease_categ_code = i.disease_categ_code
--            ,disease_type_code = i.disease_type_code
--            ,trigger_ccm_flag = i.trigger_ccm_flag
--            ,question_categ_code = i.question_categ_code
--          where disease_code = i.disease_code
--          ;
--        when others then
--          v_err_msg := SUBSTR (SQLERRM,1,1000);
--      end;
--      begin
--        INSERT INTO disease_lang (disease_lang_sn
--                                        ,disease_code
--                                        ,LANG_CODE
--                                        ,SHORT_DESCR
--                                        ,LONG_DESCR
--                                        )
--        VALUES (disease_lang_SNG.nextval
--                ,i.disease_code
--                ,i.LANG_CODE
--                ,i.SHORT_DESCR
--                ,i.LONG_DESCR
--               );
--      exception 
--        when dup_val_on_index then
--          update disease_lang
--          set SHORT_DESCR = i.SHORT_DESCR
--              ,LONG_DESCR = i.LONG_DESCR
--          where disease_code = i.disease_code
--          and LANG_CODE = i.LANG_CODE
--          ;
--        when others then
--          v_err_msg := SUBSTR (SQLERRM,1,1000);
--      end;      
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--/
----==================Risk factor
--  BEGIN
--    --v_proc_name := upper('load_risk_factor');
--    for i in (select 'COMO' risk_factor_code,'NMD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Comorbidity' short_descr,null long_descr from dual union
--              select 'BDIS' risk_factor_code,'MOD' risk_factor_categ_code,'Y' risk_factor_is_a_disease_flag,'en' lang_code,'Blood Disorder' short_descr,null long_descr from dual
--              )
--    loop
--      begin
--        INSERT INTO list_risk_factor (risk_factor_code
--                                 ,risk_factor_categ_code
--                                 ,risk_factor_is_a_disease_flag
--                                 )
--        VALUES (i.risk_factor_code
--               ,i.risk_factor_categ_code
--               ,i.risk_factor_is_a_disease_flag
--               );
--      exception 
--        when dup_val_on_index then
--          update list_risk_factor
--          set risk_factor_categ_code = i.risk_factor_categ_code
--              ,risk_factor_is_a_disease_flag = i.risk_factor_is_a_disease_flag
--          where risk_factor_code = i.risk_factor_code
--          ;
--        when others then null;
--      end;
--      begin
--        INSERT INTO risk_factor_lang (risk_factor_lang_sn
--                                        ,risk_factor_code
--                                        ,LANG_CODE
--                                        ,SHORT_DESCR
--                                        ,LONG_DESCR
--                                        )
--        VALUES (risk_factor_lang_SNG.nextval
--                ,i.risk_factor_code
--                ,i.LANG_CODE
--                ,i.SHORT_DESCR
--                ,i.LONG_DESCR
--               );
--      exception 
--        when dup_val_on_index then
--          update risk_factor_lang
--          set SHORT_DESCR = i.SHORT_DESCR
--              ,LONG_DESCR = i.LONG_DESCR
--          where risk_factor_code = i.risk_factor_code
--          and LANG_CODE = i.LANG_CODE
--          ;
--        when others then null;
--      end;      
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--  /
----================disease risk factor
--  BEGIN
--    for i in (select 'CKDE' DISEASE_CODE,'AGEE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'BDIS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'COMO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union              
--              select 'CKDE' DISEASE_CODE,'WATR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CKDE' DISEASE_CODE,'CHDE' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual
--              )
--    loop
--      begin
--        INSERT INTO disease_risk_factor (DISEASE_RISK_FACTOR_SN
--                                        ,DISEASE_CODE
--                                        ,RISK_FACTOR_CODE
--                                        ,severity_CODE
--                                        ,PRIMARY_RISK_FACTOR_FLAG
--                                        )
--        VALUES (DISEASE_RISK_FACTOR_SNG.nextval
--               ,i.DISEASE_CODE
--               ,i.RISK_FACTOR_CODE
--               ,i.severity_CODE
--               ,i.PRIMARY_RISK_FACTOR_FLAG
--               );
--      exception 
--        when dup_val_on_index then
--          update disease_risk_factor
--          set severity_CODE = i.severity_CODE
--              ,PRIMARY_RISK_FACTOR_FLAG = i.PRIMARY_RISK_FACTOR_FLAG
--          where DISEASE_CODE = i.DISEASE_CODE
--          and RISK_FACTOR_CODE = i.RISK_FACTOR_CODE
--          ;
--        when others then null;
--      end;
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--  /
--delete from disease_risk_factor where disease_code = 'CKDE' and risk_factor_code in ('BMIR','ALCO','RACE');
--commit;
----ALTER TABLE physician ADD(dr_type varchar2(30));
----ALTER TABLE provider_physician ADD(dr_type varchar2(30));
----update physician
----set dr_type = 'DO'
----where dr_type is null
----;
----update provider_physician
----set dr_type = 'DO'
----where provider_physician_sn = 4
----;
----COMMIT;
--update question_lang
--set long_descr = 'Poor Vision'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'FALLR' and question_code = '1006')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Stroke (Cerebrovascular Accident -CVA)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1007')
--and lang_code = 'en'
--;
--update disease_lang
--set short_descr = 'Stroke (Cerebrovascular Accident -CVA)'
--where disease_code = 'STRK'
--and lang_code = 'en'
--;
--update risk_factor_lang
--set short_descr = 'Stroke (Cerebrovascular Accident -CVA)'
--where risk_factor_code = 'STRK'
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Mini Stroke (Transient Ischemic Attack -TIA)'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BMEDH' and question_code = '1028')
--and lang_code = 'en'
--;
--update prev_plan_lang
--set LONG_DESCR = 'In view, your alcohol drinking Habits we recommend getting into in-patient or even outpatient Rehabilitation Alcohol detox center or your close community Hospital that has an Alcohol treatment program.'
--where prev_plan_code = '7601'
--and LANG_CODE = 'en'
--;
--commit;
----Obesity Report
--select pat_name patient_name
--      ,pat_medicare_hic_num hic_num
--      ,svc_perform_date service_date
--      ,pat_age age
--      ,pat_bmi
--      ,pv.chronic_disease_cnt chronic_disease      
--      ,svc_location_name service_location
--      ,provider_physician_name interviewer
--from patient_prev_svc_vw pv
--    ,svc_result_vw srv
--where pv.patient_prev_svc_sn = srv.patient_prev_svc_sn
--and pv.completed_flag = 'Y'
--and srv.disease_code = 'OBES'
--and srv.disease_level_code <> 'LOW'
--;
----Alcohol and Smoking report
--select pat_name patient_name
--      ,pat_medicare_hic_num hic_num
--      ,svc_perform_date service_date
--      ,pat_age age
--      ,pat_bmi
--      ,pv.chronic_disease_cnt chronic_disease
--      ,prv.response
--      ,svc_location_name service_location
--      ,provider_physician_name interviewer
--from patient_prev_svc_vw pv
--    ,patient_response_vw prv
--where pv.patient_prev_svc_sn = prv.patient_prev_svc_sn
--and pv.completed_flag = 'Y'
--and prv.category_code = 'BEHVT'
--and prv.question_code = '1005' --1005 is Smoking; 1006 is Alcohol
--and prv.risk_factor_code is not null
--;
------------OBES/ALCO RF
--Age ===============
--BMI
--Diabetes (High Blood Sugar)
--Diet related to High Sugar=================
--Family History
--Physical Inactivity
--Social and economic issues=================
--Tobacco
--Weight
-----------------------
--BMI
--Major Disease (1-Heart Disease, 2-Cancer & Hx, 3-CKD, 4- Liver Disease or 5 CVA, TIA or Myocardial Infarction Hx. (heart attack)============
--Family History
--Tobacco
--Diabetes (High Blood Sugar)
--HBP================
--Alcohol===================
--Wrong Nutrition habit (High sugar - DTSG, High salt - DTST or Fast food - DTFF, Sodas - DTDR) (2points)=============  
--Physical Inactivity
--===================================12/28/2017
--update question_lang
--set long_descr = 'You miss having people around you'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'There are few people you can trust'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'You are experiencing a general sense of emptiness'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'There are not enough people you feel close to'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'You often feel rejected'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1005')
--and lang_code = 'en'
--;
--update question_lang
--set long_descr = 'When you have problems, there are few people you can rely on'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'LONLS' and question_code = '1006')
--and lang_code = 'en'
--;
--update list_disease
--set trigger_ccm_flag = 'Y'
--where disease_code in ('LONL','FALL')
--;
--update question_lang
--set short_descr = 'Can you say what triggers your feeling anxious(Excessively worries?)'
--    ,long_descr = 'Excessively worries triggers your anxious feeling'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'ANXIT' and question_code = '1001')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Can you say what triggers your feeling anxious(Fear of a fall?)'
--    ,long_descr = 'Fear of a fall triggers your anxious feeling'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'ANXIT' and question_code = '1002')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Can you say what triggers your feeling anxious(Fear to die?)'
--    ,long_descr = 'Fear to die triggers your anxious feeling'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'ANXIT' and question_code = '1003')
--and lang_code = 'en'
--;
--update question_lang
--set short_descr = 'Can you say what triggers your feeling anxious(Don''t know?)'
--    ,long_descr = 'You Don''t know what triggers your anxious feeling'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'ANXIT' and question_code = '1004')
--and lang_code = 'en'
--;
--update question_response
--set score_value = 0
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'ANXIT' and question_code = '1004')
--and RESPONSE_CODE = 'YES'
--;
--commit;
--Factors that individuall will trigger CVD IBT
--TBCO
--BMIR
--ALCO
--HBPR --Hx (Mod) Uncontrolled (HIG/SEV)
--DIAB --Hx
--DEPR
--AFIB =========
--FRLT =========
--STRK
--HCHO --(only uncontrolled)
-------------
---===========================================01/04/2018=====================
--update physician and location
--begin
--  for i in (select patient_prev_svc_sn,patient_sn 
--            from pps_simplified_vw 
--            where patient_prev_svc_sn in (23,26,28,29,48,97,50,67,70,99,106,116,110)
--            )
--  loop
--    update patient
--    set physician_sn = 4
--    where patient_sn = i.patient_sn
--    ;
--    update patient_prev_svc
--    set physician_svc_location_sn = 4
--    where patient_prev_svc_sn = i.patient_prev_svc_sn
--    ;
--  end loop;
--  commit;
--end;
--/
---------------=========================01092018=====================
--update question_response
--set disease_level_code = 'SEV'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1002')
--and RESPONSE_CODE = 'Y04'
--;
--update question_response
--set disease_level_code = 'SEV'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1003')
--and RESPONSE_CODE = 'Y04'
--;
--update question_response
--set disease_level_code = 'SEV'
--where question_sn in (select question_sn from question where QUESTION_CATEG_CODE = 'BEHVT' and question_code = '1004')
--and RESPONSE_CODE = 'Y04'
--;
----
--delete from disease_risk_factor where disease_code = 'CHDE';
--commit;
----
--  BEGIN
--    --v_proc_name := upper('load_disease_risk_factor');
--    for i in (select 'CHDE' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'FRLT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'HCHO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'DEPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
--              select 'CHDE' DISEASE_CODE,'STRK' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual
--              )
--    loop
--      --v_error_rec := i.disease_code;
--      begin
--        INSERT INTO disease_risk_factor (DISEASE_RISK_FACTOR_SN
--                                        ,DISEASE_CODE
--                                        ,RISK_FACTOR_CODE
--                                        ,severity_CODE
--                                        ,PRIMARY_RISK_FACTOR_FLAG
--                                        )
--        VALUES (DISEASE_RISK_FACTOR_SNG.nextval
--               ,i.DISEASE_CODE
--               ,i.RISK_FACTOR_CODE
--               ,i.severity_CODE
--               ,i.PRIMARY_RISK_FACTOR_FLAG
--               );
--      exception 
--        when dup_val_on_index then
--          update disease_risk_factor
--          set severity_CODE = i.severity_CODE
--              ,PRIMARY_RISK_FACTOR_FLAG = i.PRIMARY_RISK_FACTOR_FLAG
--          where DISEASE_CODE = i.DISEASE_CODE
--          and RISK_FACTOR_CODE = i.RISK_FACTOR_CODE
--          ;
--        when others then null;
--      end;
--    end loop;
--    commit;
--  exception
--    when others then
--      raise_application_error(-20026,sqlerrm);
--  END;
--/
--compile patient_vw, patient_prev_svc_vw, pps_simplified_vw
------------------------------------------------01112018============================
--==================Obesity IBT design
--Add:
----RX to RF
----Column circumference to patient_prev_svc
----Thyroid deficiency in the PMHx (include this in the Major Disease RF)
--
--Advise: personalized behavior change advice (multirow in patient_prev_svc_remark)
--Treatment Goal: based on the patient’s interest in and willingness to change the behavior. (multirow in patient_prev_svc_remark)
--Recommended Medical Treatment: (multirow in patient_prev_svc_remark)
--Recommended Referral: (multirow in patient_prev_svc_remark)
--Additional Notes: (multirow in patient_prev_svc_remark)
--
---------------------Rx
--Antidepressant (ziprexa , Paxil, Zoloft, Elavil & tofranil ) 
--Anti- seizure meds. ( Depakote) 
--Some DM drugs ( diabeta or Diabinese ) 
--HBP drugs (Cardura & inderal) 
--Heartburn drugs (Prevacid & nexium) 
--Steroid ( cortisone) 
---------------------
--To group the patient_prev_svc_remark, add category group code column in patient_prev_svc_remark
------------Follow the previous plan (bring the data from the last Obesity IBT service and let service provider edit/add)

--Display Weight, Circumference, BMI and previous data (Advise, Treatment Goal, Medical Treatment and Referral). Previous data will be in a 
--link. When clicked will be displayed on a new window/tab.
--
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
--------
ALTER TABLE patient_prev_svc_remark ADD (remark_categ_grp_code varchar2(4)
                                        ,remark_categ_name nvarchar2(100));
--
ALTER TABLE  patient_prev_svc_remark ADD CONSTRAINT  patient_prev_svc_remark_FK2
FOREIGN KEY (remark_categ_grp_code) REFERENCES list_remark_categ_grp (remark_categ_grp_code);
--
ALTER TABLE patient_prev_svc ADD (waist_in_in number(5,2)
                                 ,svc_number number(2) default 1 not null
                                 ,followed_rf_therapy_goals_flag VARCHAR2(1)
                                 ,goals_achived_flag VARCHAR2(1) DEFAULT 'Y'
                                 ,reason_of_not_achiving_goals nvarchar2(2000)
                                 ,physician_signature clob
                                 ,RX_PREV_SVC_BILLING_CODE	  VARCHAR2(5)
                                 );
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK23
FOREIGN KEY (RX_PREV_SVC_BILLING_CODE) REFERENCES  list_PREV_SVC_BILLING(PREV_SVC_BILLING_CODE);
--
create index patient_prev_svc_indx8
on patient_prev_svc (goals_achived_flag);
--                                 
ALTER TABLE svc_result ADD (obesity_rf_avail_flag varchar2(1) DEFAULT 'N');
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
-----------------
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
---------------------------
ALTER TABLE patient ADD (insurance_company_code varchar2(4));
--
ALTER TABLE patient ADD CONSTRAINT patient_FK14
FOREIGN KEY (insurance_company_code) REFERENCES insurance_company(insurance_company_code);
-------
ALTER TABLE patient_prev_svc ADD (insurance_company_code varchar2(4));
--
ALTER TABLE patient_prev_svc ADD CONSTRAINT patient_prev_svc_FK24
FOREIGN KEY (insurance_company_code) REFERENCES insurance_company(insurance_company_code);
----------------------
@create_seq.sql
@list_trans.pkg.sql
begin
  list_trans_pkg.load_dr_type;
  list_trans_pkg.load_report_template;
  list_trans_pkg.load_report;
  list_trans_pkg.load_insurance_company;
end;
/
---------update insurance_company_code in patient and patient_prev_svc
begin
  for i in (select pps.patient_prev_svc_sn
                  ,pps.patient_sn
                  ,case 
                    when report_pkg.medicare_ins_by_hic_flag(p.medicare_hic_num) = 'Y' then 'MEDB'
                    else 'OTHR'
                    end insurance_company_code
            from patient_prev_svc pps
                ,patient p
            where pps.patient_sn = p.patient_sn
            )
  loop
    update patient_prev_svc
    set insurance_company_code = i.insurance_company_code
    where patient_prev_svc_sn = i.patient_prev_svc_sn
    ;
    update patient
    set insurance_company_code = i.insurance_company_code
    where patient_sn = i.patient_sn
    ;
  end loop;
  commit;
end;
/
------
ALTER TABLE physician ADD CONSTRAINT physician_FK5
FOREIGN KEY (dr_type) REFERENCES list_dr_type(dr_type_code);
--
alter table "AspNetUsers" add(svc_provider_flag VARCHAR2(1)   DEFAULT 'N' NOT NULL);
-----------================================svc_location alter begin=================
ALTER TABLE svc_location ADD(company_SN NUMBER(11));
--
ALTER TABLE svc_location ADD CONSTRAINT svc_location_FK5
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
begin
  for i in (select distinct svc_location_sn,company_sn 
            from physician_svc_location_vw
            )
  loop            
    update svc_location
    set company_SN = i.company_sn
    where svc_location_sn = i.svc_location_sn
    ;
  end loop;
  commit;
end;
/
--
ALTER TABLE svc_location modify(company_SN NOT NULL);
--
drop index svc_location_ak1;
--
CREATE unique INDEX svc_location_ak1
ON svc_location (company_SN,addr_sn);
-----------================================svc_location alter end=================
--
  BEGIN
    --v_proc_name := upper('load_disease_categ');
    for i in (select 'THRD' disease_categ_code,'en' lang_code,'Thyroid Disease' short_descr,'Any dysfunction of the butterfly-shaped gland at the base of the neck (thyroid).' long_descr from dual
              )
    loop
      --v_error_rec := i.disease_categ_code;
      begin
        INSERT INTO list_disease_categ (disease_categ_code
                                        )
        VALUES (i.disease_categ_code
               );
      exception 
        when dup_val_on_index then
          null;
      end;
      --v_error_rec := i.disease_categ_code||'-'||i.lang_code;
      begin
        INSERT INTO disease_categ_lang (disease_categ_lang_sn
                                        ,disease_categ_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_categ_lang_SNG.nextval
                ,i.disease_categ_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_categ_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_categ_code = i.disease_categ_code
          and LANG_CODE = i.LANG_CODE
          ;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  BEGIN
    --v_proc_name := upper('load_disease');
    for i in (select 'TDIS' disease_code,'THRD' disease_categ_code,'DISE' disease_type_code,'Y' trigger_ccm_flag,null question_categ_code,'en' lang_code,'Thyroid disorder (Hyperthyroidism)' short_descr,'The overproduction of a hormone by the butterfly-shaped gland in the neck (thyroid).' long_descr from dual
              )
    loop
      begin
        INSERT INTO list_disease (disease_code
                                 ,disease_categ_code
                                 ,disease_type_code
                                 ,trigger_ccm_flag
                                 ,question_categ_code
                                 )
        VALUES (i.disease_code
               ,i.disease_categ_code
               ,i.disease_type_code
               ,i.trigger_ccm_flag
               ,i.question_categ_code
               );
      exception 
        when dup_val_on_index then
          update list_disease
          set disease_categ_code = i.disease_categ_code
            ,disease_type_code = i.disease_type_code
            ,trigger_ccm_flag = i.trigger_ccm_flag
            ,question_categ_code = i.question_categ_code
          where disease_code = i.disease_code
          ;
      end;
      begin
        INSERT INTO disease_lang (disease_lang_sn
                                        ,disease_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (disease_lang_SNG.nextval
                ,i.disease_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update disease_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where disease_code = i.disease_code
          and LANG_CODE = i.LANG_CODE
          ;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
--Load risk_factor
  BEGIN
    --v_proc_name := upper('load_risk_factor');
    for i in (select 'MDIS' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Major Diseases' short_descr,'Major Diseases (e.g. CVD, CKD, CLD, TIA, Thyroid Deficiencies, Cancer & Hx etc.)' long_descr from dual union
              select 'MDRX' risk_factor_code,'MOD' risk_factor_categ_code,'N' risk_factor_is_a_disease_flag,'en' lang_code,'Prescribed (Rx) Meds' short_descr,null long_descr from dual
              )
    loop
      --v_error_rec := i.risk_factor_code;
      begin
        INSERT INTO list_risk_factor (risk_factor_code
                                 ,risk_factor_categ_code
                                 ,risk_factor_is_a_disease_flag
                                 )
        VALUES (i.risk_factor_code
               ,i.risk_factor_categ_code
               ,i.risk_factor_is_a_disease_flag
               );
      exception 
        when dup_val_on_index then
          update list_risk_factor
          set risk_factor_categ_code = i.risk_factor_categ_code
              ,risk_factor_is_a_disease_flag = i.risk_factor_is_a_disease_flag
          where risk_factor_code = i.risk_factor_code
          ;
        when others then null;
      end;
      --v_error_rec := i.risk_factor_code||'-'||i.lang_code;
      begin
        INSERT INTO risk_factor_lang (risk_factor_lang_sn
                                        ,risk_factor_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (risk_factor_lang_SNG.nextval
                ,i.risk_factor_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update risk_factor_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where risk_factor_code = i.risk_factor_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then null;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
delete from disease_risk_factor where disease_code = 'OBES';
commit;
--load_disease_risk_factor
  BEGIN
    --v_proc_name := upper('load_disease_risk_factor');
    for i in (select 'OBES' DISEASE_CODE,'ALCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'FMHX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'MDRX' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'WEIT' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'BMIR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'INAC' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'MDIS' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'TBCO' RISK_FACTOR_CODE,'PRMY' severity_CODE,'N' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTSG' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTST' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTFF' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DTDR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'DIAB' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual union
              select 'OBES' DISEASE_CODE,'HBPR' RISK_FACTOR_CODE,'PRMY' severity_CODE,'Y' PRIMARY_RISK_FACTOR_FLAG from dual
              )
    loop
      --v_error_rec := i.disease_code;
      begin
        INSERT INTO disease_risk_factor (DISEASE_RISK_FACTOR_SN
                                        ,DISEASE_CODE
                                        ,RISK_FACTOR_CODE
                                        ,severity_CODE
                                        ,PRIMARY_RISK_FACTOR_FLAG
                                        )
        VALUES (DISEASE_RISK_FACTOR_SNG.nextval
               ,i.DISEASE_CODE
               ,i.RISK_FACTOR_CODE
               ,i.severity_CODE
               ,i.PRIMARY_RISK_FACTOR_FLAG
               );
      exception 
        when dup_val_on_index then
          update disease_risk_factor
          set severity_CODE = i.severity_CODE
              ,PRIMARY_RISK_FACTOR_FLAG = i.PRIMARY_RISK_FACTOR_FLAG
          where DISEASE_CODE = i.DISEASE_CODE
          and RISK_FACTOR_CODE = i.RISK_FACTOR_CODE
          ;
        when others then null;
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
/
--------------load_prev_svc_type
  BEGIN
    --v_proc_name := upper('load_prev_svc_type');
    for i in (select 'IBT' prev_svc_type_code from dual
              )
    loop
      --v_error_rec := i.prev_svc_type_code;
      begin
        INSERT INTO list_prev_svc_type(prev_svc_type_code
                                      )
        VALUES (i.prev_svc_type_code
               );
      exception 
        when dup_val_on_index then
          null;
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  BEGIN
    --v_proc_name := upper('load_prev_svc_type_lang');
    for i in (select 'IBT' prev_svc_type_code,'en' lang_code,'Intensive Behavioral Therapy' short_descr,null long_descr from dual
              )
    loop
      --v_error_rec := i.PREV_SVC_TYPE_CODE||'-'||i.lang_code;
      begin
        INSERT INTO prev_svc_type_lang (prev_svc_type_lang_SN
                                        ,PREV_SVC_TYPE_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (prev_svc_type_lang_SNG.nextval
                ,i.PREV_SVC_TYPE_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update prev_svc_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where PREV_SVC_TYPE_CODE = i.PREV_SVC_TYPE_CODE
          and LANG_CODE = i.LANG_CODE
          ;
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  BEGIN
    --v_proc_name := upper('load_prev_svc_billing');
    for i in (select 'G0449' prev_svc_billing_code,'IBT' prev_svc_type_code,'HCPCS' billing_type_code,7 order_num from dual union
              select 'G0447' prev_svc_billing_code,'IBT' prev_svc_type_code,'HCPCS' billing_type_code,8 order_num from dual
              )
    loop
      --v_error_rec := i.prev_svc_billing_code;
      begin
        INSERT INTO list_prev_svc_billing (prev_svc_billing_code
                                          ,prev_svc_type_code
                                          ,billing_type_code
                                          ,order_num
                                          )
                                  VALUES  (i.prev_svc_billing_code
                                          ,i.prev_svc_type_code
                                          ,i.billing_type_code
                                          ,i.order_num
                                          );
      exception 
        when dup_val_on_index then
          update list_prev_svc_billing
          set order_num = i.order_num
          where prev_svc_billing_code = i.prev_svc_billing_code
          ;
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  --
  BEGIN
    --v_proc_name := upper('load_prev_svc_billing_lang');
    for i in (select 'G0449' prev_svc_billing_code,'en' lang_code,'Obesity Screening, 15 min/year' short_descr,'Annual Face-To-Face Obesity Screening, 15 minutes' long_descr from dual union
              select 'G0447' prev_svc_billing_code,'en' lang_code,'Obesity Counseling, 15 min/visit' short_descr,'Face-to-Face Behavioral Counseling for Obesity, 15 minutes' long_descr from dual
              )
    loop
      --v_error_rec := i.PREV_svc_billing_CODE||'-'||i.lang_code;
      begin
        INSERT INTO prev_svc_billing_lang (prev_svc_billing_lang_SN
                                        ,PREV_svc_billing_CODE
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (prev_svc_billing_lang_SNG.nextval
                ,i.PREV_svc_billing_CODE
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update prev_svc_billing_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where PREV_svc_billing_CODE = i.PREV_svc_billing_CODE
          and LANG_CODE = i.LANG_CODE
          ;
      end;
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
--setting obesity_rf_avail_flag
begin
  for i in (select pps.patient_prev_svc_sn
                  ,sr.svc_result_sn
            from patient p
                ,patient_prev_svc pps
                ,svc_result sr
            where p.patient_sn = pps.patient_sn
            and pps.patient_prev_svc_sn = sr.patient_prev_svc_sn
            and sr.disease_code = 'OBES'
            and sr.disease_severity_code = 'EXCBT'
            and pps.svc_comp_flag = 'Y'
            and pps.prev_svc_billing_code in ('G0438','G0439')
            )
  loop
    if obes_counseling_pkg.primary_rf_avail_flag(i.patient_prev_svc_sn) = 'Y' or obes_counseling_pkg.additional_rf_avail_flag(i.patient_prev_svc_sn) = 'Y' then
      update svc_result
      set obesity_rf_avail_flag = 'Y'
      where svc_result_sn = i.svc_result_sn
      ;
    end if;
  end loop;
  commit;
end;
/
  --load_svc_rpt_type
  BEGIN
    --v_proc_name := upper('load_svc_rpt_type');
    for i in (select 'ORF' svc_rpt_type_code,'IBT' prev_svc_type_code,1 order_num,'Y' used_for_template_only_flag,'en' lang_code,'Patient Obesity Risk Factor JSON' short_descr,'Patient Obesity Risk Factor JSON which will be added to template and Report' long_descr from dual union
              select 'OSC' svc_rpt_type_code,'IBT' prev_svc_type_code,2 order_num,'N' used_for_template_only_flag,'en' lang_code,'Obesity Screening Outcome' short_descr,'Obesity Screening' long_descr from dual union
              select 'OEV' svc_rpt_type_code,'IBT' prev_svc_type_code,3 order_num,'N' used_for_template_only_flag,'en' lang_code,'Obesity Counseling Outcome' short_descr,'Obesity Counseling' long_descr from dual
              )
    loop
      --v_error_rec := i.svc_rpt_type_code;
      begin
        INSERT INTO list_svc_rpt_type (svc_rpt_type_code
                                      ,prev_svc_type_code
                                      ,order_num
                                      ,used_for_template_only_flag
                                        )
        VALUES (i.svc_rpt_type_code
               ,i.prev_svc_type_code
               ,i.order_num
               ,i.used_for_template_only_flag
               );
      exception 
        when dup_val_on_index then
          update list_svc_rpt_type
          set prev_svc_type_code = i.prev_svc_type_code
              ,order_num = i.order_num
              ,used_for_template_only_flag = i.used_for_template_only_flag
          where svc_rpt_type_code = i.svc_rpt_type_code
          ;
      end;
      --v_error_rec := i.svc_rpt_type_code||'-'||i.lang_code;
      begin
        INSERT INTO svc_rpt_type_lang (svc_rpt_type_lang_sn
                                        ,svc_rpt_type_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (svc_rpt_type_lang_sng.nextval
                ,i.svc_rpt_type_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update svc_rpt_type_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where svc_rpt_type_code = i.svc_rpt_type_code
          and LANG_CODE = i.LANG_CODE
          ;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  ----------------
  --PROCEDURE load_medication_unit
  BEGIN 
    --v_proc_name := upper('load_medication_unit');
    for i in (select 'MN' medication_unit_code,'en' lang_code,'milliequivalents' short_descr,null long_descr from dual
              )
    loop
      --v_error_rec := i.medication_unit_code;
      begin
        INSERT INTO list_medication_unit (medication_unit_code
                                        )
        VALUES (i.medication_unit_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then null;
      end;
      --v_error_rec := i.medication_unit_code||'-'||i.lang_code;
      begin
        INSERT INTO medication_unit_lang (medication_unit_lang_sn
                                        ,medication_unit_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (medication_unit_lang_SNG.nextval
                ,i.medication_unit_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update medication_unit_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where medication_unit_code = i.medication_unit_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then null;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
  --PROCEDURE load_frequency_unit
  BEGIN
    --v_proc_name := upper('load_frequency_unit');
    for i in (select 'EW' frequency_unit_code,'en' lang_code,'Every Week' short_descr,null long_descr from dual union
              select 'EM' frequency_unit_code,'en' lang_code,'Every Month' short_descr,null long_descr from dual
              )
    loop
      --v_error_rec := i.frequency_unit_code;
      begin
        INSERT INTO list_frequency_unit (frequency_unit_code
                                        )
        VALUES (i.frequency_unit_code
               );
      exception 
        when dup_val_on_index then
          null;
        when others then null;
      end;
      --v_error_rec := i.frequency_unit_code||'-'||i.lang_code;
      begin
        INSERT INTO frequency_unit_lang (frequency_unit_lang_sn
                                        ,frequency_unit_code
                                        ,LANG_CODE
                                        ,SHORT_DESCR
                                        ,LONG_DESCR
                                        )
        VALUES (frequency_unit_lang_SNG.nextval
                ,i.frequency_unit_code
                ,i.LANG_CODE
                ,i.SHORT_DESCR
                ,i.LONG_DESCR
               );
      exception 
        when dup_val_on_index then
          update frequency_unit_lang
          set SHORT_DESCR = i.SHORT_DESCR
              ,LONG_DESCR = i.LONG_DESCR
          where frequency_unit_code = i.frequency_unit_code
          and LANG_CODE = i.LANG_CODE
          ;
        when others then null;
      end;      
    end loop;
    commit;
  exception
    when others then
      raise_application_error(-20026,sqlerrm);
  END;
  /
---------------update 439 parent
declare
  v_parent_patient_prev_svc_sn number(11);
begin
  for i in (select patient_prev_svc_sn
                  ,patient_sn
            from pps_simplified_vw 
            where prev_svc_billing_code = 'G0439' 
            and parent_patient_prev_svc_sn is null
            )
  loop
    select nvl(max(patient_prev_svc_sn),0)
    into v_parent_patient_prev_svc_sn
    from patient_prev_svc
    where patient_sn = i.patient_sn
    and prev_svc_billing_code in ('G0438','G0439')
    and svc_comp_flag = 'Y'
    ;
    update patient_prev_svc 
    set parent_patient_prev_svc_sn = v_parent_patient_prev_svc_sn
    where patient_prev_svc_sn = i.patient_prev_svc_sn
    ;
    commit;
  end loop;
end;
/
--Set non service provider flag
update "AspNetUsers"
set svc_provider_flag = 'Y'
where lower("UserName") not in ('rpwjr@ommdoc.com','edhoffus@aol.com','im_apu@yahoo.com','mazharul.haque2@gmail.com')
;
commit;
------------==============================---------------
delete from roles_priviledge where priviledge_code = 'RMGM';
delete from priviledge_ui where priviledge_code = 'RMGM';
delete from ui_lang where ui_code = 'RMGM';
delete from list_ui where ui_code = 'RMGM';
delete from priviledge_lang where priviledge_code = 'RMGM';
delete from list_priviledge where priviledge_code = 'RMGM';
delete from priviledge_ui where priviledge_code = 'DENT' and ui_code = 'PSVL';
--
delete from priviledge_ui where priviledge_code = 'UMGM' and ui_code = 'PMGM';
delete from ui_lang where ui_code = 'PMGM';
delete from list_ui where ui_code = 'PMGM';
commit;
@list_trans.pkg.sql
begin
  list_trans_pkg.load_priviledge;
  list_trans_pkg.load_ui;
  list_trans_pkg.load_priviledge_ui;
  list_trans_pkg.load_roles_priviledge;
end;
/
-------------Patient_history ddl
alter table patient_history add
    (created_by_user_role_id raw(16) not null
    ,updated_by_user_role_id raw(16) not null
    );
--
ALTER TABLE patient_history ADD CONSTRAINT patient_history_FK3
FOREIGN KEY (created_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
--
ALTER TABLE patient_history ADD CONSTRAINT patient_history_FK4
FOREIGN KEY (updated_by_user_role_id) REFERENCES "AspNetUserRoles"(user_role_id);
----Move patient history data from patient_response to patient_history
declare
  v_user_role_id "AspNetUserRoles".user_role_id%type;
begin
  select user_role_id
  into v_user_role_id
  from user_vw 
  where user_name = 'mazharul.haque2@gmail.com'
  ;
  for i in (select distinct patient_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('G0438','G0439')
            )
  loop            
    for j in (select distinct question_response_code
              from patient_response_vw
              where category_code in ('BMEDH','HSURA','HVACN','HVART','FHNMR')
              and patient_sn = i.patient_sn
              )
    loop
      begin
        insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
        values (patient_history_sng.nextval,i.patient_sn,j.question_response_code,v_user_role_id,v_user_role_id);
      exception
        when dup_val_on_index then null;
      end;
    end loop;
  end loop;
  commit;
end;
/
----Move patient history data from patient_response to patient_history
--Alzheimer's Disease and Dementia was added later. If there was no record then enter default response code of None
declare
  v_cnt pls_integer;
  v_user_role_id "AspNetUserRoles".user_role_id%type;
begin
  select user_role_id
  into v_user_role_id
  from user_vw 
  where user_name = 'mazharul.haque2@gmail.com'
  ;
  for i in (select distinct patient_sn
            from patient_prev_svc
            where prev_svc_billing_code in ('G0438','G0439')
            )
  loop            
    select count(*)
    into v_cnt
    from patient_response_vw
    where patient_sn = i.patient_sn
    and question_response_code in (select question_response_code from hx_question_response_vw where category_code = 'FHNMR' and question_code = '1015')
    ;
    if v_cnt = 0 then --no Alzheimer response. Insert default
      begin
        insert into patient_history (patient_history_sn,patient_sn,question_response_code,created_by_user_role_id,updated_by_user_role_id)
        values (patient_history_sng.nextval,i.patient_sn,'106099',v_user_role_id,v_user_role_id);
      exception
        when dup_val_on_index then null;
      end;
    end if;
  end loop;
  commit;
end;
/
--------------Run the views below
--view patient_vw
--View patient_prev_svc_vw
--View PPS_SIMPLIFIED_VW
--View rf_missing_goals_reason_vw
--view user_vw
--view active_user_vw
--view svc_location_vw
--view active_user_vw
--view user_svc_location_vw
--view hx_question_response_vw
--view patient_history_vw
--view patient_response_vw
--view svc_result_vw
---------------
@create_seq.sql
@list_trans.pkg.sql
@list_item.pkg.sql
@mbr_inq.pkg.sql
@common.pkg.sql
@common_dml.pkg.sql
@common_inq.pkg.sql
@svc_eval.pkg.sql
@report.pkg.sql
@obes_counseling.pkg.sql
@obes_counseling_trans.pkg.sql
@parse_json.pkg.sql
@mdtech_trans.pkg.sql
@qnr_inq.pkg.sql
@admin_inq.pkg.sql
@mgmt_report.pkg.sql
@ins_upd_question.sql
@ins_upd_question_response.sql
@compile_invalid_objects.sql
--
begin
  for i in (select patient_prev_svc_sn
            from svc_result
            where obesity_rf_avail_flag = 'Y'
            )
  loop
    svc_eval_pkg.create_obesity_rf_json (i.patient_prev_svc_sn);
  end loop;
end;
/
begin
  list_trans_pkg.load_missing_goals_reason;
  list_trans_pkg.load_rf_missing_goals_reason;
  list_trans_pkg.load_remark_categ_grp;
  list_trans_pkg.load_rf_counseling_categ;
  list_trans_pkg.load_report;
  list_trans_pkg.load_priviledge_report;
end;
/
----------------
------------Things to do
--rename svc_counselling to svc_screening (create a copy of svc_counselling_bk before renaming)
--create new table svc_counseling
--move data from svc_counselling_bk to svc_screening
--make all the reference changes in package and document
---------------Other changes
--Remove ITHEALTH from homepage
--Remove ITHEALTH from About US
--Remove ITHEALTH from Terms and Condition
--Change the web title from "Health Risk Finder" to "Health Risk Prevention"
--Change logo from "Health Risk Finder" to "Health Risk Prevention"
--Add HL7 integration using 3rd party tool
--Add Subscription billing software (3rd party tool)