drop table "OAuth_RefreshTokens" purge;
drop table "OAuth_Clients" purge;
drop table "AspNetUserClaims" purge;
drop table "AspNetUserLogins" purge;
drop table "AspNetUserRoles" purge;
drop table "AspNetUsers" purge;
drop table ADDR purge;
--
drop table POSTAL purge;
drop table CITY purge;
drop table STATE purge;
drop table COUNTRY purge;
--
drop table list_location_type purge;
drop table LIST_ADDR_TYPE purge;
drop table "AspNetRoles" purge;
--==================================================
drop table TRANS_LANG purge;
drop table APPLICATION_TRACKING purge;

drop table LIST_APPL_FUNCTIONALITY purge;
drop table CALENDAR purge;
drop table LIST_YEAR purge;
drop table LIST_MONTH_LANG purge;
drop table LIST_MONTH purge;
--
drop table APPLICATION_ERROR_MSG_LANG purge;
drop table APPLICATION_ERROR_MSG purge;
drop table list_lang purge;
drop table LIST_APPLICATION purge;
drop table LIST_FILE_TYPE purge;
--==================================================
create table list_lang
    (LANG_CODE  VARCHAR2(2)
    ,ISO_639_2 VARCHAR2(3)
    ,ISO_639_3 VARCHAR2(3)
    ,DESCR VARCHAR2(100)
    ,supported_lang_flag   varchar2(1) DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_lang ADD CONSTRAINT list_lang_PK
PRIMARY KEY (lang_code);
--==================================================
create table LIST_FILE_TYPE
    (FILE_TYPE_CODE VARCHAR2(10)
    ,FILE_CONTENT_TYPE VARCHAR2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_FILE_TYPE ADD CONSTRAINT LIST_FILE_TYPE_PK
PRIMARY KEY (FILE_TYPE_CODE);
--
create table LIST_APPLICATION
    (APPLICATION_CODE VARCHAR2(4)
    ,DESCR VARCHAR2(50)
    ,image blob
    ,file_name varchar2(200)
    ,file_type_code varchar2(10)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_APPLICATION ADD CONSTRAINT LIST_APPLICATION_PK
PRIMARY KEY (APPLICATION_CODE);
--
ALTER TABLE LIST_APPLICATION ADD CONSTRAINT LIST_APPLICATION_FK1
FOREIGN KEY (FILE_TYPE_CODE) REFERENCES LIST_FILE_TYPE(FILE_TYPE_CODE);
--==================================================
create table APPLICATION_ERROR_MSG
    (APPLICATION_ERROR_MSG_CODE VARCHAR2(5)
    ,APPLICATION_CODE VARCHAR2(4) NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE APPLICATION_ERROR_MSG ADD CONSTRAINT APPLICATION_ERROR_MSG_PK
PRIMARY KEY (APPLICATION_ERROR_MSG_CODE);
--
--
ALTER TABLE APPLICATION_ERROR_MSG ADD CONSTRAINT APPLICATION_ERROR_MSG_FK1
FOREIGN KEY (APPLICATION_CODE) REFERENCES LIST_APPLICATION(APPLICATION_CODE);
--==================================================
create table APPLICATION_ERROR_MSG_LANG
    (APPLICATION_ERROR_MSG_LANG_SN NUMBER(11)
    ,APPLICATION_ERROR_MSG_CODE VARCHAR2(5) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,DESCR NVARCHAR2(200)
    ,LONG_DESCR NVARCHAR2(1000)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE APPLICATION_ERROR_MSG_LANG ADD CONSTRAINT APPLICATION_ERROR_MSG_LANG_PK
PRIMARY KEY (APPLICATION_ERROR_MSG_LANG_SN);
--
ALTER TABLE APPLICATION_ERROR_MSG_LANG ADD CONSTRAINT APPLICATION_ERROR_MSG_LANG_FK1
FOREIGN KEY (APPLICATION_ERROR_MSG_CODE) REFERENCES APPLICATION_ERROR_MSG(APPLICATION_ERROR_MSG_CODE);
--
ALTER TABLE APPLICATION_ERROR_MSG_LANG ADD CONSTRAINT APPLICATION_ERROR_MSG_LANG_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX APPLICATION_ERROR_MSG_LANG_ak1
ON APPLICATION_ERROR_MSG_LANG (APPLICATION_ERROR_MSG_CODE,LANG_CODE);
--
--==================================================
create table LIST_MONTH
    (MONTH_CODE VARCHAR2(2)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_MONTH ADD CONSTRAINT LIST_MONTH_PK
PRIMARY KEY (MONTH_CODE);
--==================================================
create table LIST_MONTH_LANG
    (MONTH_LANG_SN NUMBER(11)
    ,MONTH_CODE VARCHAR2(2) NOT NULL
    ,LANG_CODE VARCHAR2(2) NOT NULL
    ,DESCR NVARCHAR2(200)
    ,short_descr nvarchar2(100)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_MONTH_LANG ADD CONSTRAINT LIST_MONTH_LANG_PK
PRIMARY KEY (MONTH_LANG_SN);
--
ALTER TABLE LIST_MONTH_LANG ADD CONSTRAINT LIST_MONTH_LANG_FK1
FOREIGN KEY (MONTH_CODE) REFERENCES LIST_MONTH(MONTH_CODE);
--
ALTER TABLE LIST_MONTH_LANG ADD CONSTRAINT LIST_MONTH_LANG_FK2
FOREIGN KEY (LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
CREATE unique INDEX LIST_MONTH_LANG_ak1
ON LIST_MONTH_LANG (MONTH_CODE,LANG_CODE);
--==================================================
create table LIST_YEAR
    (YEAR_CODE VARCHAR2(4)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_YEAR ADD CONSTRAINT LIST_YEAR_PK
PRIMARY KEY (YEAR_CODE);
--==================================================
create table LIST_APPL_FUNCTIONALITY
    (APPL_FUNCTIONALITY_CODE VARCHAR2(4)
    ,DESCR                 VARCHAR2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_APPL_FUNCTIONALITY ADD CONSTRAINT LIST_APPL_FUNCTIONALITY_PK
PRIMARY KEY (APPL_FUNCTIONALITY_CODE);
--==================================================
---========Mbr and Location DDL
--==================================================
create table "AspNetRoles"
    ("Id" NVARCHAR2(128)
    ,"Name" NVARCHAR2(256) not null
    ,"Discriminator" VARCHAR2(200)
    ,service_provider_flag varchar2(1) DEFAULT 'N' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE "AspNetRoles" ADD CONSTRAINT AspNetRoles_PK
PRIMARY KEY ("Id");
--
CREATE UNIQUE index AspNetRoles_AK1 on "AspNetRoles" ("Name");
--
create or replace TRIGGER AspNetRoles_BUR BEFORE UPDATE ON "AspNetRoles" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
create table LIST_ADDR_TYPE
    (ADDR_TYPE_CODE  VARCHAR2(2)
    ,DESCR VARCHAR2(50)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE LIST_ADDR_TYPE ADD CONSTRAINT LIST_ADDR_TYPE_PK
PRIMARY KEY (ADDR_TYPE_CODE);
--==================================================
create table list_location_type
    (LOCATION_TYPE_CODE  VARCHAR2(15)
    ,NAME VARCHAR2(50)
    ,DESCR VARCHAR2(300)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE list_location_type ADD CONSTRAINT list_location_type_PK
PRIMARY KEY (location_type_code);
--==================================================
create table COUNTRY
    (COUNTRY_CODE VARCHAR2(2)
    ,COUNTRY_CODE_ISO3 VARCHAR2(3)
    ,COUNTRY_CODE_ISO_NUMERIC VARCHAR2(3)
    ,COUNTRY_CODE_FIPS VARCHAR2(2)
    ,NAME VARCHAR2(50)
    ,CAPITAL_NAME VARCHAR2(50)
    ,AREA_SQ_KM NUMBER(8)
    ,TLD VARCHAR2(3)
    ,PHONE_COUNTRY_CODE VARCHAR2(20)
    ,POSTAL_CODE_FORMAT VARCHAR2(100)
    ,POSTAL_CODE_REGEX VARCHAR2(200)
    ,NEIGHBOURS VARCHAR2(50)
    ,EQUIVALENT_FIPS_CODE VARCHAR2(3)
    ,FLAG_IMAGE_FILE_NAME_16 VARCHAR2(100)
    ,FLAG_IMAGE_16 BLOB
    ,FLAG_IMAGE_FILE_NAME_24 VARCHAR2(100)
    ,FLAG_IMAGE_24 BLOB
    ,FLAG_IMAGE_FILE_NAME_32 VARCHAR2(100)
    ,FLAG_IMAGE_32 BLOB
    ,FLAG_IMAGE_FILE_NAME_48 VARCHAR2(100)
    ,FLAG_IMAGE_48 BLOB
    ,FLAG_IMAGE_FILE_NAME_64 VARCHAR2(100)
    ,FLAG_IMAGE_64 BLOB
    ,GEOJSON  CLOB
    ,LATITUDE  NUMBER(9,6)
    ,LONGITUDE  NUMBER(9,6)
    ,ALT_COUNTRY_CODE VARCHAR2(100)
    ,POPULATION NUMBER(10)
    ,ELEV_IN_M NUMBER(6)
    ,DIG_ELEV_MODEL_IN_M NUMBER(5)
    ,MODIFICATION_DATE DATE
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE COUNTRY ADD CONSTRAINT COUNTRY_PK
PRIMARY KEY (COUNTRY_CODE);
--==================================================
create table STATE
    (STATE_SN NUMBER(11)
    ,COUNTRY_CODE VARCHAR2(2) NOT NULL
    ,STATE_CODE VARCHAR2(30) NOT NULL
    ,NAME VARCHAR2(200)
    ,LATITUDE  NUMBER(9,6)
    ,LONGITUDE  NUMBER(9,6)
    ,POPULATION NUMBER(10)
    ,ELEV_IN_M NUMBER(6)
    ,DIG_ELEV_MODEL_IN_M NUMBER(5)
    ,MODIFICATION_DATE DATE
    ,SOURCE_FROM_GOOGLE_API_FLAG VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE STATE ADD CONSTRAINT STATE_PK
PRIMARY KEY (STATE_SN);
--
ALTER TABLE STATE ADD CONSTRAINT STATE_FK1
FOREIGN KEY (COUNTRY_CODE) REFERENCES COUNTRY(COUNTRY_CODE);
--
CREATE unique INDEX STATE_ak1 
ON STATE (COUNTRY_CODE,STATE_CODE);
--==================================================
create table CITY
    (CITY_SN NUMBER(11)
    ,STATE_SN NUMBER(11) NOT NULL
    ,NAME VARCHAR2(200) NOT NULL
    ,LOCATION_TYPE_CODE VARCHAR2(15)
    ,LATITUDE  NUMBER(9,6)
    ,LONGITUDE  NUMBER(9,6)
    ,POPULATION NUMBER(10)
    ,ELEV_IN_M NUMBER(6)
    ,DIG_ELEV_MODEL_IN_M NUMBER(5)
    ,MODIFICATION_DATE DATE
    ,SOURCE_FROM_GOOGLE_API_FLAG VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE CITY ADD CONSTRAINT CITY_PK
PRIMARY KEY (CITY_SN);
--
ALTER TABLE CITY ADD CONSTRAINT CITY_FK1
FOREIGN KEY (STATE_SN) REFERENCES STATE(STATE_SN);
--
ALTER TABLE CITY ADD CONSTRAINT CITY_FK3
FOREIGN KEY (LOCATION_TYPE_CODE) REFERENCES LIST_LOCATION_TYPE(LOCATION_TYPE_CODE);
--
CREATE unique INDEX CITY_ak1 
ON CITY (STATE_SN,NAME);
--
create index city_indx1
on city (upper(name))
;
--==================================================
create table POSTAL
    (POSTAL_SN NUMBER(11)
    ,CITY_SN NUMBER(11) NOT NULL
    ,POSTAL_CODE VARCHAR2(20) NOT NULL
    ,COUNTY_NAME VARCHAR2(200)
    ,LATITUDE  NUMBER(9,6)
    ,LONGITUDE  NUMBER(9,6)
    ,SOURCE_FROM_GOOGLE_API_FLAG VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE POSTAL ADD CONSTRAINT POSTAL_PK
PRIMARY KEY (POSTAL_SN);
--
ALTER TABLE POSTAL ADD CONSTRAINT POSTAL_FK1
FOREIGN KEY (CITY_SN) REFERENCES CITY(CITY_SN);
--
CREATE unique INDEX POSTAL_ak1 
ON POSTAL (CITY_SN,POSTAL_CODE);
--==================================================
create table ADDR
    (ADDR_SN NUMBER(11)
    ,ADDR_TYPE_CODE VARCHAR2(2) NOT NULL
    ,CITY_SN NUMBER(11) NOT NULL
    --,POSTAL_SN NUMBER(11) NOT NULL
    ,FORMATTED_ADDR VARCHAR2(2000) NOT NULL
    ,JSON_ADDR CLOB
    ,ADDR_1 VARCHAR2(200) NOT NULL
    ,ADDR_2 VARCHAR2(200)
    ,POSTAL_CODE VARCHAR2(20)
    ,COUNTY_NAME VARCHAR2(200)
    ,RECIPIENT_1 VARCHAR2(200)
    ,RECIPIENT_2 VARCHAR2(200)
    ,RECIPIENT_3 VARCHAR2(200)
    ,LATITUDE  NUMBER(9,6)
    ,LONGITUDE  NUMBER(9,6)
    ,SOURCE_FROM_GOOGLE_API_FLAG VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE ADDR ADD CONSTRAINT ADDR_PK
PRIMARY KEY (ADDR_SN);
----
--ALTER TABLE ADDR ADD CONSTRAINT ADDR_FK1
--FOREIGN KEY (POSTAL_SN) REFERENCES POSTAL(POSTAL_SN);
--
ALTER TABLE ADDR ADD CONSTRAINT ADDR_FK1
FOREIGN KEY (CITY_SN) REFERENCES CITY(CITY_SN);
--
ALTER TABLE ADDR ADD CONSTRAINT ADDR_FK2
FOREIGN KEY (ADDR_TYPE_CODE) REFERENCES LIST_ADDR_TYPE(ADDR_TYPE_CODE);
--
CREATE unique INDEX ADDR_ak1 
ON ADDR (ADDR_TYPE_CODE,FORMATTED_ADDR);
--==================================================
CREATE TABLE "AspNetUsers" 
   (           "Id" NVARCHAR2(128) NOT NULL
                ,"Email" NVARCHAR2(256)
                ,"EmailConfirmed" number(1) default 0 NOT NULL
                ,"PasswordHash" NVARCHAR2(1000)
                ,"SecurityStamp" NVARCHAR2(1000) 
                ,"PhoneNumber" NVARCHAR2(1000)
                ,"PhoneNumberConfirmed" number(1) default 0 NOT NULL
                ,"TwoFactorEnabled" number(1) default 0 NOT NULL
                ,"LockoutEndDateUtc" DATE
                ,"LockoutEnabled" number(1) default 0 NOT NULL
                ,"AccessFailedCount" NUMBER(10,0) default 0 NOT NULL
                ,"UserName" NVARCHAR2(256) NOT NULL
                ,"Discriminator" VARCHAR2(200)
                ,PARENT_ID NVARCHAR2(128)
                ,PREF_LANG_CODE VARCHAR2(2)
                ,HOME_PHONE_NUM VARCHAR2(20)
                ,BUSINESS_PHONE_NUM VARCHAR2(20)
                ,FIRST_NAME VARCHAR2(50)
                ,LAST_NAME VARCHAR2(50)
                ,MIDDLE_NAME VARCHAR2(50)
                ,GENDER_CODE VARCHAR2(1)
                ,ABOUT_PROV VARCHAR2(500)
                ,BIRTH_DATE date
                ,RESPONSE_RATE NUMBER(5)
                ,RESPONSE_TIME date
                ,HOSTING_STORY VARCHAR2(500)
                ,ADDR_SN NUMBER(11)
                ,TERMS_AND_COND_ACCEPTANCE number(1) default 0
                ,RECEIVE_NEWS_LETTER number(1) default 0
                ,ALT_EMAIL nvarchar2(200)
                ,EFF_DATE DATE
                ,INACTIVE_DATE DATE
                ,USER_ROLE VARCHAR2(30)
                ,USER_CREATED_REC_FLAG VARCHAR2(1)   DEFAULT 'Y' NOT NULL
                ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
                ,company_SN NUMBER(11)
                ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
                ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
                ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
                ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
                );
ALTER TABLE "AspNetUsers" ADD CONSTRAINT AspNetUsers_PK
PRIMARY KEY ("Id");
--
ALTER TABLE "AspNetUsers"  ADD CONSTRAINT AspNetUsers_FK1
FOREIGN KEY (ADDR_SN) REFERENCES ADDR(ADDR_SN);
--
ALTER TABLE "AspNetUsers"  ADD CONSTRAINT AspNetUsers_FK2
FOREIGN KEY (PARENT_ID) REFERENCES "AspNetUsers"("Id");
--
ALTER TABLE "AspNetUsers" ADD CONSTRAINT AspNetUsers_FK3
FOREIGN KEY (PREF_LANG_CODE) REFERENCES LIST_LANG(LANG_CODE);
--
ALTER TABLE "AspNetUsers" ADD CONSTRAINT AspNetUsers_FK4
FOREIGN KEY (company_SN) REFERENCES company(company_SN);
--
--ALTER TABLE "AspNetUsers"  ADD CONSTRAINT AspNetUsers_CK1
--CHECK (nvl(TERMS_AND_COND_ACCEPTANCE,0) = 1);
--
CREATE unique INDEX AspNetUsers_ak1 
ON "AspNetUsers" ("UserName");
--
create or replace TRIGGER AspNetUsers_BUR BEFORE UPDATE ON "AspNetUsers" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE "AspNetUserRoles"
   (User_Role_ID raw(16) default sys_guid()
    ,"UserId" NVARCHAR2(128) NOT NULL
    ,"RoleId" NVARCHAR2(128) NOT NULL
    ,"Discriminator" VARCHAR2(200)
    ,REGISTRATION_DATE DATE DEFAULT sysdate
    ,AUTO_PAYMENT_FLAG varchar2(1) default 'N'
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table "AspNetUserRoles" add constraint AspNetUserRoles_pk
primary key (User_Role_ID);  
--
ALTER TABLE "AspNetUserRoles"  ADD CONSTRAINT AspNetUserRoles_FK1
FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id");
--
ALTER TABLE "AspNetUserRoles"  ADD CONSTRAINT AspNetUserRoles_FK2
FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles"("Id");
--
CREATE unique INDEX AspNetUserRoles_ak1 
ON "AspNetUserRoles" ("UserId", "RoleId");
--
create or replace TRIGGER AspNetUserRoles_BUR BEFORE UPDATE ON "AspNetUserRoles" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE "AspNetUserLogins" 
   (user_login_id raw(16) default sys_guid()
    ,"LoginProvider" NVARCHAR2(128) NOT NULL
    ,"ProviderKey" NVARCHAR2(128) NOT NULL
    ,"UserId" NVARCHAR2(128) NOT NULL
    ,"Discriminator" VARCHAR2(200)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table "AspNetUserLogins" add constraint AspNetUserLogins_pk
primary key (user_login_id);  
--
ALTER TABLE "AspNetUserLogins"  ADD CONSTRAINT AspNetUserLogins_FK1
FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id");
--
CREATE unique INDEX AspNetUserLogins_ak1 
ON "AspNetUserLogins" ("LoginProvider", "ProviderKey", "UserId");
--
create or replace TRIGGER AspNetUserLogins_BUR BEFORE UPDATE ON "AspNetUserLogins" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE "AspNetUserClaims" 
   ("Id" NUMBER(10,0) NOT NULL
    ,"UserId" NVARCHAR2(128) NOT NULL
    ,"ClaimType" NVARCHAR2(1000) 
    ,"ClaimValue" NVARCHAR2(1000)
    ,"Discriminator" VARCHAR2(200)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table "AspNetUserClaims" add constraint AspNetUserClaims_pk
primary key ("Id");  
--
ALTER TABLE "AspNetUserClaims"  ADD CONSTRAINT AspNetUserClaims_FK1
FOREIGN KEY ("UserId") REFERENCES "AspNetUsers"("Id");
--
create or replace TRIGGER AspNetUserClaims_BUR BEFORE UPDATE ON "AspNetUserClaims" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE "OAuth_Clients" 
   (           "Id" NVARCHAR2(128) NOT NULL
               ,"Secret" NVARCHAR2(2000) NOT NULL
               ,"Name" VARCHAR2(200 BYTE) NOT NULL
               ,"ApplicationType" NUMBER NOT NULL
               ,"Active" CHAR(5 BYTE) NOT NULL
               ,"RefreshTokenLifeTime" NUMBER NOT NULL
               ,"AllowedOrigin" VARCHAR2(200 BYTE)
               ,"Discriminator" VARCHAR2(200)
              ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
              ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
              ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table "OAuth_Clients" add constraint OAuth_Clients_pk
primary key ("Id");
--
create or replace TRIGGER OAuth_Clients_BUR BEFORE UPDATE ON "OAuth_Clients" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE "OAuth_RefreshTokens" 
   (           "Id" NVARCHAR2(128) NOT NULL
               ,"Subject" VARCHAR2(100 BYTE) NOT NULL
               ,"ClientId" VARCHAR2(100 BYTE) NOT NULL
               ,"IssuedUtc" DATE NOT NULL
               ,"ExpiresUtc" DATE NOT NULL
               ,"ProtectedTicket" NVARCHAR2(2000) NOT NULL
               ,"Discriminator" VARCHAR2(200)
              ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
              ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
              ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table "OAuth_RefreshTokens" add constraint OAuth_RefreshTokens_pk
primary key ("Id");
--
create or replace TRIGGER OAuth_RefreshTokens_BUR BEFORE UPDATE ON "OAuth_RefreshTokens" FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--==================================================
CREATE TABLE TRANS_LANG 
   (          trans_lang_id varchar2(32) default sys_guid()
              ,CULTURE VARCHAR2(2) not null
              ,NAME VARCHAR2(50) not null
              ,APPL_FUNCTIONALITY_CODE VARCHAR2(4) not null
              ,VALUE NVARCHAR2(2000) not null
              ,LONG_VALUE NCLOB
              ,TITLE_1 NVARCHAR2(400)
              ,TITLE_2 NVARCHAR2(400)
              ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
              ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
              ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
              ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
  );
alter table TRANS_LANG add constraint TRANS_LANG_pk
primary key (trans_lang_id);
--
CREATE unique INDEX TRANS_LANG_ak1
on TRANS_LANG(APPL_FUNCTIONALITY_CODE,CULTURE,name);
--
ALTER TABLE TRANS_LANG ADD CONSTRAINT TRANS_LANG_FK2
FOREIGN KEY (CULTURE) REFERENCES LIST_LANG(LANG_CODE);
--
ALTER TABLE TRANS_LANG ADD CONSTRAINT TRANS_LANG_FK3
FOREIGN KEY (APPL_FUNCTIONALITY_CODE) REFERENCES LIST_APPL_FUNCTIONALITY(APPL_FUNCTIONALITY_CODE);
--
create or replace TRIGGER TRANS_LANG_BUR BEFORE UPDATE ON TRANS_LANG FOR EACH ROW
BEGIN
  --to capture the update time and updated by during any update on the table
  :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
  :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
END;
/
--*/
---=================Property DDL
--
--==================================================

----------------+++++++++++++++++-------------Prov Billing======================***********************

--------------*****************************************---------------------------------------

--==================================================
--======================================================
create table APPLICATION_TRACKING
    (APPLICATION_TRACKING_SN NUMBER(11)
    ,APPLICATION_CODE VARCHAR2(4) NOT NULL
    ,IP_ADDR VARCHAR2(200)
    ,BROWSER_NAME VARCHAR2(200)
    ,BROWSER_VERSION VARCHAR2(100)
    ,CURRENT_PAGE VARCHAR2(200)
    ,USER_COUNTRY VARCHAR2(200)
    ,USER_CITY VARCHAR2(200)
    ,USER_REGION VARCHAR2(200)
    ,USER_LATITUDE VARCHAR2(100)
    ,USER_LONGITUDE VARCHAR2(100)
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE APPLICATION_TRACKING ADD CONSTRAINT APPLICATION_TRACKING_PK
PRIMARY KEY (APPLICATION_TRACKING_SN);
--
ALTER TABLE APPLICATION_TRACKING ADD CONSTRAINT APPLICATION_TRACKING_FK1
FOREIGN KEY (APPLICATION_CODE) REFERENCES LIST_APPLICATION(APPLICATION_CODE);
--=================================================
create table CALENDAR
    (CALENDAR_SN NUMBER(11)
    ,YEAR_CODE VARCHAR2(4) NOT NULL
    ,MONTH_CODE VARCHAR2(2) NOT NULL
    ,DAY_NUM VARCHAR2(2) not null
    ,DAY_LONG_DESCR VARCHAR2(10)
    ,DAY_SHORT_DESCR VARCHAR2(3)
    ,CALENDAR_DATE DATE NOT NULL
    ,ACTIVE_FLAG           VARCHAR2(1)   DEFAULT 'Y' NOT NULL
    ,Z_CREATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_CREATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    ,Z_UPDATE_USER_ID      VARCHAR2(20 BYTE)  DEFAULT substr(user,1,20)   NOT NULL
    ,Z_UPDATE_TMSTMP       TIMESTAMP          DEFAULT systimestamp        NOT NULL
    );
ALTER TABLE CALENDAR ADD CONSTRAINT CALENDAR_PK
PRIMARY KEY (CALENDAR_SN);
--
ALTER TABLE CALENDAR ADD CONSTRAINT CALENDAR_FK1
FOREIGN KEY (YEAR_CODE) REFERENCES LIST_YEAR(YEAR_CODE);
--
ALTER TABLE CALENDAR ADD CONSTRAINT CALENDAR_FK2
FOREIGN KEY (MONTH_CODE) REFERENCES LIST_MONTH(MONTH_CODE);
--
CREATE unique INDEX CALENDAR_ak1 
ON CALENDAR (YEAR_CODE,MONTH_CODE,DAY_NUM);
--
CREATE unique INDEX CALENDAR_ak2 
ON CALENDAR (CALENDAR_DATE);