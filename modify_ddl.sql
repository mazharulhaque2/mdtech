----This is the script to modify any existing DDL
----alter table priviledge_ui drop column prev_svc_billing_code;
------
----CREATE unique INDEX priviledge_ui_ak1
----ON priviledge_ui (priviledge_code,ui_code);
------
----alter table roles_priviledge_grouping drop column prev_svc_billing_code;
--alter table list_priviledge add (href varchar2(50));
--alter table list_ui add (href varchar2(50));
----
----
--create index patient_prev_svc_indx1
--on patient_prev_svc (created_by_user_role_id);
----
--create index patient_prev_svc_indx2
--on patient_prev_svc (updated_by_user_role_id);
----
--create index patient_prev_svc_indx3
--on patient_prev_svc (provider_physician_sn);
----
--create index company_indx1
--on company (created_by_user_role_id);
----
--create index company_indx2
--on company (updated_by_user_role_id);
----
--create index physician_indx1
--on physician (created_by_user_role_id);
----
--create index physician_indx2
--on physician (updated_by_user_role_id);
----
--create index provider_physician_indx1
--on provider_physician (created_by_user_role_id);
----
--create index provider_physician_indx2
--on provider_physician (updated_by_user_role_id);
----
--create index svc_location_indx1
--on svc_location (created_by_user_role_id);
----
--create index svc_location_indx2
--on svc_location (updated_by_user_role_id);
----
--create index physician_svc_location_indx1
--on physician_svc_location (created_by_user_role_id);
----
--create index physician_svc_location_indx2
--on physician_svc_location (updated_by_user_role_id);
----
--create index patient_indx1
--on patient (created_by_user_role_id);
----
--create index patient_indx2
--on patient (updated_by_user_role_id);
----
--create index patient_medication_indx1
--on patient_medication (created_by_user_role_id);
----
--create index patient_medication_indx2
--on patient_medication (updated_by_user_role_id);
----
--alter table categ_score_eval add(trigger_further_categ_flag VARCHAR2(1)   DEFAULT 'N');
