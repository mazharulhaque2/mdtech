set serveroutput on
declare
  v_USER_ROLE_ID "AspNetUserRoles".user_role_id%type;
  v_out varchar2(32767);
begin
  mbr_trans_pkg.i_mbr (return_json_pkg.mbr,'Service Provider',null,v_USER_ROLE_ID,v_out);
  dbms_output.put_line(v_out);
end;
/