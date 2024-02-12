DROP TABLE APPLICATION_CONTROL_VALUE purge;
DROP TABLE APPLICATION_CONTROL purge;
DROP TABLE APPLICATION_PROCESS_LOG purge;
DROP TABLE LIST_ERROR_SEVERITY purge;
DROP TABLE HISTORY_DATA purge;
DROP TABLE APPL_HIST_COL purge;
DROP TABLE APPL_HIST_TABLE purge;
CREATE TABLE APPLICATION_CONTROL
(
  APPLICATION_CONTROL_SN  NUMBER,
  APPLICATION_NAME             VARCHAR2(30 BYTE),
  DESCRIPTION                  VARCHAR2(100 BYTE),
  EFF_DATE                     DATE,
  INACTIVE_DATE                DATE,
  LAST_RUN_TMSTMP              TIMESTAMP(6),
  Z_CREATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_CREATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_UPDATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL
);
--
ALTER TABLE APPLICATION_CONTROL ADD 
  CONSTRAINT APPLICATION_CONTROL_PK
  PRIMARY KEY (APPLICATION_CONTROL_SN)
  ENABLE VALIDATE
;
ALTER TABLE APPLICATION_CONTROL ADD
  CONSTRAINT APPLICATION_CONTROL_UNQ1
  UNIQUE (APPLICATION_NAME)
;
--
--******************************************************************************
CREATE TABLE APPLICATION_CONTROL_VALUE
(
  ACV_SN                  NUMBER,
  APPLICATION_CONTROL_SN  NUMBER,
  CONTROL_VALUE_NAME           VARCHAR2(30 BYTE),
  CONTROL_VALUE_ALPHA          VARCHAR2(500 BYTE),
  CONTROL_VALUE_DATE           DATE,
  CONTROL_VALUE_TIMESTAMP      TIMESTAMP(6),
  CONTROL_VALUE_NUMBER         NUMBER,
  CONTROL_VALUE_CLOB           CLOB,
  EFF_DATE                     DATE,
  INACTIVE_DATE                DATE,
  LAST_RUN_TMSTMP              TIMESTAMP(6),
  Z_CREATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_CREATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_UPDATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL
);
--
ALTER TABLE APPLICATION_CONTROL_VALUE ADD 
  CONSTRAINT APPLICATION_CONTROL_VALUE_PK
  PRIMARY KEY(ACV_SN)
  ENABLE VALIDATE
;
  ALTER TABLE APPLICATION_CONTROL_VALUE ADD
  CONSTRAINT APPLICATION_CONTROL_VALUE_UNQ1
  UNIQUE (APPLICATION_CONTROL_SN, CONTROL_VALUE_NAME)
;

ALTER TABLE APPLICATION_CONTROL_VALUE ADD (
  CONSTRAINT APPLICATION_CONTROL_VALUE_FK1 
  FOREIGN KEY (APPLICATION_CONTROL_SN) 
  REFERENCES APPLICATION_CONTROL (APPLICATION_CONTROL_SN)
  ENABLE VALIDATE);
--
--******************************************************************************
CREATE TABLE LIST_ERROR_SEVERITY
(
  ERROR_SEVERITY_CODE  CHAR(1 BYTE),
  DESCR                VARCHAR2(30 BYTE)        NOT NULL,
  ACTIVE_FLAG          CHAR(1 BYTE)             DEFAULT 'Y'                   NOT NULL,
  Z_CREATE_USER_ID     VARCHAR2(20 BYTE)        DEFAULT SUBSTR (USER
                                           ,1
                                           ,20) NOT NULL,
  Z_CREATE_TMSTMP      TIMESTAMP(6)             DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID     VARCHAR2(20 BYTE)        DEFAULT SUBSTR (USER
                                           ,1
                                           ,20) NOT NULL,
  Z_UPDATE_TMSTMP      TIMESTAMP(6)             DEFAULT SYSTIMESTAMP          NOT NULL
);
--
ALTER TABLE LIST_ERROR_SEVERITY ADD 
  CONSTRAINT LIST_ERROR_SEVERITY_PK
  PRIMARY KEY
  (ERROR_SEVERITY_CODE)
  ENABLE VALIDATE;
--
--******************************************************************************
CREATE TABLE APPLICATION_PROCESS_LOG
(
  APPL_PROCESS_LOG_SN  NUMBER(9),
  ERROR_SEVERITY_CODE       CHAR(1 BYTE)        NOT NULL,
  NOTES                     VARCHAR2(500 BYTE),
  PACKAGE_NAME              VARCHAR2(30 BYTE),
  PROCEDURE_NAME            VARCHAR2(30 BYTE),
  INPUT_CLOB                CLOB,
  INPUT_BLOB                BLOB,
  ERROR_MSG                 VARCHAR2(1000 BYTE),
  ACTIVE_FLAG               CHAR(1 BYTE)        DEFAULT 'Y'                   NOT NULL,
  Z_CREATE_USER_ID          VARCHAR2(20 BYTE)   DEFAULT SUBSTR (USER
                                                ,1
                                                ,20) NOT NULL,
  Z_CREATE_TMSTMP           TIMESTAMP(6)        DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID          VARCHAR2(20 BYTE)   DEFAULT SUBSTR (USER
                                                ,1
                                                ,20) NOT NULL,
  Z_UPDATE_TMSTMP           TIMESTAMP(6)        DEFAULT SYSTIMESTAMP          NOT NULL
);
--
--
ALTER TABLE APPLICATION_PROCESS_LOG ADD (
  CONSTRAINT APPLICATION_PROCESS_LOG_PK
  PRIMARY KEY(APPL_PROCESS_LOG_SN)
  ENABLE VALIDATE)
;
--
ALTER TABLE APPLICATION_PROCESS_LOG ADD (
  CONSTRAINT APPLICATION_PROCESS_LOG_FK1 
  FOREIGN KEY (ERROR_SEVERITY_CODE) 
  REFERENCES LIST_ERROR_SEVERITY (ERROR_SEVERITY_CODE)
  ENABLE VALIDATE);
--
CREATE INDEX APPLICATION_PROCESS_LOG_INDX1 ON APPLICATION_PROCESS_LOG
(PACKAGE_NAME);
--
CREATE INDEX APPLICATION_PROCESS_LOG_INDX2 ON APPLICATION_PROCESS_LOG
(PROCEDURE_NAME);
--
--******************************************************************************
CREATE TABLE APPL_HIST_TABLE
(
  APPL_HIST_TABLE_NUM  NUMBER(3)                NOT NULL,
  NAME                 VARCHAR2(30 BYTE)        NOT NULL,
  DESCR                VARCHAR2(30 BYTE),
  HIST_FLAG            VARCHAR2(1 BYTE),
  Z_CREATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_CREATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_UPDATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL  
);
--
ALTER TABLE APPL_HIST_TABLE ADD (
  CONSTRAINT APPL_HIST_TABLE_PK
  PRIMARY KEY(APPL_HIST_TABLE_NUM)
  ENABLE VALIDATE)
;
--******************************************************************************
CREATE TABLE APPL_HIST_COL
(
  APPL_HIST_TABLE_NUM  NUMBER(3)                NOT NULL,
  APPL_HIST_COL_NUM    NUMBER(3)                NOT NULL,
  DATA_TYPE_CODE       VARCHAR2(2 BYTE)         NOT NULL,
  TABLE_NAME           VARCHAR2(30 BYTE)        NOT NULL,
  COL_NAME             VARCHAR2(30 BYTE)        NOT NULL,
  DESCR                VARCHAR2(100 BYTE),
  HIST_FLAG            VARCHAR2(1 BYTE),
  Z_CREATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_CREATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL,
  Z_UPDATE_USER_ID             VARCHAR2(20 BYTE) DEFAULT SUBSTR (USER, 1, 20) NOT NULL,
  Z_UPDATE_TMSTMP              TIMESTAMP(6)   DEFAULT SYSTIMESTAMP          NOT NULL    
);
--
ALTER TABLE APPL_HIST_COL ADD (
  CONSTRAINT APPL_HIST_COL_PK
  PRIMARY KEY
  (APPL_HIST_TABLE_NUM, APPL_HIST_COL_NUM)
  ENABLE VALIDATE);

ALTER TABLE APPL_HIST_COL ADD (
  CONSTRAINT APPL_HIST_COL_FK1 
  FOREIGN KEY (APPL_HIST_TABLE_NUM) 
  REFERENCES APPL_HIST_TABLE(APPL_HIST_TABLE_NUM)
  ENABLE VALIDATE);
--
--******************************************************************************
CREATE TABLE HISTORY_DATA
(
  APPL_HIST_TABLE_NUM  NUMBER(3)                NOT NULL,
  PARENT_UNIQUE_KEY    VARCHAR2(30 BYTE)        NOT NULL,
  APPL_HIST_COL_NUM    NUMBER(3)                NOT NULL,
  DATA_TYPE_CODE       VARCHAR2(2 BYTE),
  ALPHA_FROM_VALUE     VARCHAR2(512 BYTE),
  ALPHA_TO_VALUE       VARCHAR2(512 BYTE),
  DATE_FROM_VALUE      DATE,
  DATE_TO_VALUE        DATE,
  NUM_FROM_VALUE       NUMBER(16,4),
  NUM_TO_VALUE         NUMBER(16,4),
  Z_CREATE_USER_ID     VARCHAR2(20 BYTE)        DEFAULT SUBSTR (USER
                                           ,1
                                           ,20) NOT NULL,
  Z_CREATE_TMSTMP      TIMESTAMP(6)             DEFAULT SYSTIMESTAMP          NOT NULL
);
--
CREATE INDEX HISTORY_DATA_INDX1 ON HISTORY_DATA
(PARENT_UNIQUE_KEY, APPL_HIST_TABLE_NUM, APPL_HIST_COL_NUM);
--
CREATE INDEX HISTORY_DATA_INDX2 ON HISTORY_DATA
(APPL_HIST_TABLE_NUM, APPL_HIST_COL_NUM);
--******************************************************************************
DROP TYPE tab_number;
CREATE OR REPLACE TYPE tab_number IS TABLE OF NUMBER;
/

