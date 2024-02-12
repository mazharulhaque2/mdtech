CREATE OR REPLACE PACKAGE mbr_trans_pkg IS
  v_pkg_name    varchar2 (30) := upper('mbr_trans_pkg');
  v_proc_name   varchar2(30);
  v_msg         varchar2 (1000);
  v_err_msg     VARCHAR2 (1000);
  v_error_rec   VARCHAR2 (1000);
  v_input_str   CLOB;
  v_global_user_name "AspNetUsers"."UserName"%type;
  v_global_role_name "AspNetRoles"."Name"%type;
  --
  function json_str(p_str varchar2) return varchar2;
  --
  procedure create_mbr_role;
  PROCEDURE i_mbr (p_mbr_info in varchar2
                    ,p_role_name IN "AspNetRoles"."Name"%type
                    ,p_mbr_addr_info in varchar2
                    ,p_USER_ROLE_ID out "AspNetUserRoles".user_role_id%type
                    ,p_out out varchar2
                    );
  PROCEDURE iu_mbr_role  (p_user_name in "AspNetUsers"."UserName"%type
                          ,p_role_name in "AspNetRoles"."Name"%type
                          ,p_mbr_role_rec in out "AspNetUserRoles"%rowtype
                          );
  --
  PROCEDURE create_custom_mbr (p_mbr_rec in "AspNetUsers"%rowtype
                              ,p_role_name IN "AspNetRoles"."Name"%type
                              ,p_mbr_role_rec in "AspNetUserRoles"%rowtype
                              ,p_USER_ROLE_ID out "AspNetUserRoles".user_role_id%type
                              );
END mbr_trans_pkg;
/
SHOW ERRORS
--
CREATE OR REPLACE PACKAGE BODY mbr_trans_pkg IS
  function json_str (p_str varchar2) return varchar2 is
      v_str1 varchar2(32767) := '{
              "ID" : "123"
              ,"EMAIL" : "dlopez66@gmail.com"
              ,"EMAILCONFIRMED" : "0"
              ,"PASSWORDHASH" : "afjadfjkadfjkadl"
              ,"SECURITYSTAMP" : null
              ,"PHONENUMBER" : "9549993333"
              ,"PHONENUMBERCONFIRMED" : null
              ,"TWOFACTORENABLED" : null
              ,"LOCKOUTENDDATEUTC" : null
              ,"LOCKOUTENABLED" : null
              ,"ACCESSFAILEDCOUNT" : null
              ,"USERNAME" : "dlopez66@gmail.com"
              ,"PARENT_ID" : null
              ,"HOME_PHONE_NUM" : null
              ,"BUSINESS_PHONE_NUM" : null
              ,"FIRST_NAME" : "David"
              ,"LAST_NAME" : "Lopez"
              ,"MIDDLE_NAME" : null
              ,"GENDER_CODE" : "M"
              ,"ABOUT_PROV" : null
              ,"BIRTH_DATE" : "01-JAN-1965"
              ,"ADDR_SN" : null
              ,"RESPONSE_RATE" : null
              ,"RESPONSE_TIME" : null
              ,"HOSTING_STORY" : "TEST STORY"
              ,"TERMS_AND_COND_ACCEPTANCE" : null
              ,"RECEIVE_NEWS_LETTER" : null
              ,"ALT_EMAIL" : null
              ,"USER_CREATED_REC" : "N" 
      }';
      v_str2 varchar2(32767) := '{  
                                   "customerProfileId":"1200130728",
                                   "customerPaymentProfileIdList":[  
                                      "1200072712"
                                   ],
                                   "customerShippingAddressIdList":[  
                                      "1200072713"
                                   ],
                                   "validationDirectResponseList":[  
                                      "test"
                                   ],
                                   "messages":{  
                                      "resultCode":"Ok",
                                      "message":[  
                                         {  
                                            "code":"I00001",
                                            "text":"Successful."
                                         }
                                      ]
                                   }
                                }';
      v_str3 varchar2(32767) := '{
                                    "customerProfileId": "1200130728",
                                    "customerPaymentProfileId": "1200072712",
                                    "validationDirectResponse": null,
                                    "refId": null,
                                    "messages": {
                                      "resultCode": 0,
                                      "message": [{
                                        "code": "I00001",
                                        "text": "Successful."
                                      }]
                                    },
                                    "sessionToken": null
                                  }';                                                                  
  begin
    if p_str = 'mbr' then
      return v_str1;
    elsif p_str = 'cust_profile' then
      return v_str2;
    elsif p_str = 'pmt_profile' then
      return v_str3;
    end if;
  end json_str;
  --
  procedure create_mbr_role 
  is
    v_user_id "AspNetUsers"."Id"%type;
    v_role_id "AspNetRoles"."Id"%type;
  begin
    --
    select "Id"
    into v_user_id
    from "AspNetUsers"
    where upper("UserName") = upper(v_global_user_name)
    ;
    select "Id"
    into v_role_id
    from "AspNetRoles"
    where "Name" = v_global_role_name
    ;
    insert into "AspNetUserRoles"
        ("UserId"
        ,"RoleId"
        )
    values
        (v_user_id
        ,v_role_id
        );
  exception
    when others then
      null;
  end create_mbr_role;    
  --
  PROCEDURE iu_mbr_role  (p_user_name in "AspNetUsers"."UserName"%type
                          ,p_role_name in "AspNetRoles"."Name"%type
                          ,p_mbr_role_rec in out "AspNetUserRoles"%rowtype
                          )
  is
  begin
    --create provider role since whoever try to create property is defaulted to Provider role
    --first find the role id by name
    select "Id"
    into p_mbr_role_rec."RoleId"
    from "AspNetRoles"
    where "Name" = p_role_name
    ;
    select "Id"
    into p_mbr_role_rec."UserId"
    from "AspNetUsers"
    where "UserName" = p_user_name
    ;
    common_dml_pkg.ins_mbr_role(p_mbr_role_rec);
  end iu_mbr_role;
  --
  PROCEDURE create_custom_mbr (p_mbr_rec in "AspNetUsers"%rowtype
                              ,p_role_name IN "AspNetRoles"."Name"%type
                              ,p_mbr_role_rec in "AspNetUserRoles"%rowtype
                              ,p_USER_ROLE_ID out "AspNetUserRoles".user_role_id%type
                              )
  as
    v_mbr_rec       "AspNetUsers"%rowtype := p_mbr_rec;
    v_mbr_role_rec  "AspNetUserRoles"%rowtype;
  begin
    v_proc_name := upper('create_custom_mbr');
    --
    --When user/customer record is being created by a rep, rather than the user it self
    --the "UserName" will be null. In this situation system will generate a random user id/username.
    --For rep version of customer record creation, Email is optional and user_created_rec_flag should be N
    v_mbr_rec."Id" := sys_guid();
    --
    if v_mbr_rec."UserName" is null then
      v_mbr_rec.user_created_rec_flag := 'N';
      v_mbr_rec."UserName" := dbms_random.string('X', 30);
    else
      v_mbr_rec.user_created_rec_flag := 'Y';
    end if;
    --
    --create mbr
    common_dml_pkg.ins_mbr(v_mbr_rec);
    --create mbr role
    v_mbr_role_rec."UserId" := v_mbr_rec."Id";
    mbr_trans_pkg.iu_mbr_role  (v_mbr_rec."UserName",p_role_name,v_mbr_role_rec);
    p_USER_ROLE_ID := v_mbr_role_rec.user_role_id;
    --
    commit;
  exception
    when others then
        v_err_msg := SUBSTR (SQLERRM,1,1000);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
  end create_custom_mbr;
  --
  PROCEDURE i_mbr (p_mbr_info in varchar2
                    ,p_role_name IN "AspNetRoles"."Name"%type
                    ,p_mbr_addr_info in varchar2
                    ,p_USER_ROLE_ID out "AspNetUserRoles".user_role_id%type
                    ,p_out out varchar2
                    )
  as
    v_mbr_rec       "AspNetUsers"%rowtype;
    v_mbr_role_rec  "AspNetUserRoles"%rowtype;
    --
    l_obj           json := json();
    --
    v_state_rec     state%rowtype;
    v_city_rec      city%rowtype;
    v_addr_rec      addr%rowtype;  
    v_status_code   VARCHAR2(30);
  begin
    v_proc_name := upper('i_mbr');
    v_input_str := 'MBR: '||p_mbr_info||'-ADDR: '||p_mbr_addr_info;
    --Insert as part of testing. Should be commented in prod env
    common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'N',null,null,v_input_str,null);
    --
    --Parse json obj p_property_info and  and p_property_addr_info, then perform insert/update into property
    --
    parse_json_pkg.mbr_parsing(p_mbr_info,v_mbr_rec);
    --
    --When user/customer record is being created by a rep, rather than the user it self
    --the "UserName" will be null. In this situation system will generate a random user id/username.
    --For rep version of customer record creation, Email is optional and user_created_rec_flag should be N
    if nvl(v_mbr_rec.USER_CREATED_REC_FLAG,'N') = 'N' then
      v_mbr_rec.user_created_rec_flag := 'N';
      v_mbr_rec."UserName" := dbms_random.string('X', 10);
    else
      v_mbr_rec.user_created_rec_flag := 'Y';
    end if;
    --
    if p_mbr_addr_info is not null then
      --parse addr json
      common_dml_pkg.custom_addr_parsing_prc(p_mbr_addr_info,'personal_addr',v_state_rec,v_city_rec,v_addr_rec,v_status_code);
      --
      v_addr_rec.ADDR_TYPE_CODE := 'PR';
      common_dml_pkg.get_addr_sn (v_addr_rec.ADDR_TYPE_CODE,v_state_rec,v_city_rec,v_addr_rec,v_mbr_rec.addr_sn);
    end if;
    --
    v_mbr_rec."Id" := sys_guid();
    --create mbr
    common_dml_pkg.ins_mbr(v_mbr_rec);
    --create mbr role
    v_mbr_role_rec."UserId" := v_mbr_rec."Id";
    --mbr_trans_pkg.iu_mbr_role  (v_mbr_rec."UserName",p_role_name,v_mbr_role_rec);
    p_USER_ROLE_ID := v_mbr_role_rec.user_role_id;
    --
    commit;
    --
    --Build output record
    --
    l_obj.put('ID',v_mbr_rec."Id");
    l_obj.put('STATUS','SUCCESSFUL');
    --
    p_out := l_obj.to_char;
  exception
    when others then
        v_err_msg := SUBSTR (SQLERRM,1,1000);
        common_pkg.ins_appl_process_log(v_pkg_name,v_proc_name,'E',v_err_msg,null,v_input_str,null);
        --
        l_obj.put('ID',v_mbr_rec."Id");
        l_obj.put('STATUS','FAILED');
        --
        p_out := l_obj.to_char;
  end i_mbr;
END mbr_trans_pkg;
/
SHOW ERRORS
