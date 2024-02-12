set serveroutput on
declare
  v_mbr_in varchar2(32767);
  v_addr_in varchar2(32767);
  v_size pls_integer;
  v_mbr_rec  "AspNetUsers"%rowtype;
  v_USER_ROLE_ID "AspNetUserRoles".user_role_id%type;
  v_out varchar2(32767);
begin
  v_mbr_in := '{
              "EMAIL" : "mazharul.haque2@gmail.com"
              ,"EMAILCONFIRMED" : "1"
              ,"PASSWORDHASH" : "afjadfjkadfjkadl"
              ,"SECURITYSTAMP" : null
              ,"PHONENUMBER" : "9549993333"
              ,"PHONENUMBERCONFIRMED" : null
              ,"TWOFACTORENABLED" : null
              ,"LOCKOUTENDDATEUTC" : null
              ,"LOCKOUTENABLED" : null
              ,"ACCESSFAILEDCOUNT" : null
              ,"USERNAME" : "mazharul.haque2@gmail.com"
              ,"PARENT_ID" : null
              ,"HOME_PHONE_NUM" : null
              ,"BUSINESS_PHONE_NUM" : null
              ,"FIRST_NAME" : "Mazharul"
              ,"LAST_NAME" : "Haque"
              ,"MIDDLE_NAME" : null
              ,"GENDER_CODE" : "M"
              ,"ABOUT_PROV" : null
              ,"BIRTH_DATE" : null
              ,"ADDR_SN" : null
              ,"RESPONSE_RATE" : null
              ,"RESPONSE_TIME" : null
              ,"HOSTING_STORY" : null
              ,"TERMS_AND_COND_ACCEPTANCE" : null
              ,"RECEIVE_NEWS_LETTER" : null
              ,"ALT_EMAIL" : null
              ,"USER_CREATED_REC" : "Y" 
      }';
  mbr_trans_pkg.i_mbr (v_mbr_in,'Super Admin',v_addr_in,v_USER_ROLE_ID,v_out);
  dbms_output.put_line(v_out);
end;
/

