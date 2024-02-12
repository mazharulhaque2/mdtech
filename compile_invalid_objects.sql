set serveroutput on
spool compile_invalid_objects.log
DECLARE
    str varchar2(100);
    v_owner varchar2(30);
BEGIN
  select sys_context( 'userenv', 'current_schema' )
  into v_owner
  from dual
  ;
   FOR obj IN (select object_name
                    ,object_type
                    ,owner
              from dba_objects
              where owner = v_owner
              and status <> 'VALID'
              and object_type in ('PACKAGE','PACKAGE BODY','FUNCTION','PROCEDURE','TRIGGER','VIEW')
              )
   LOOP
      if obj.object_type = 'PACKAGE BODY' then
        str := 'alter package'||' "'|| obj.owner||'"."'||obj.object_name ||'" compile body';
      else
        str := 'alter '|| obj.object_type ||' "'|| obj.owner||'"."'||obj.object_name ||'" compile';
      end if;
      EXECUTE IMMEDIATE str;
   END LOOP;
END;
/
show errors
spool off