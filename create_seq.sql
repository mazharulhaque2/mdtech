SET SERVEROUTPUT ON;
DECLARE
  v_owner varchar2(30);
  --
  cursor c_Seq is
  select distinct col.column_name||'G' seq_name
    from dba_tables tab,
    dba_tab_columns col
  where tab.table_name = col.table_name
    and col.column_name like '%_SN'
    and tab.owner = v_owner
    order by 1
  ;
  --
  cursor c_Trg is
  select distinct tab.table_name||'_BUR' as trg_name,
         tab.table_name as tab_name
    from dba_tables tab,
         dba_tab_columns col
  where tab.table_name = col.table_name
    and col.column_name like 'Z_UPD%'
    and tab.owner = v_owner
  ;
  l_seq_cnt pls_integer;
  l_trg_cnt pls_integer;
BEGIN
  select sys_context( 'userenv', 'current_schema' )
  into v_owner
  from dual
  ;
  for v_Seq in c_Seq loop
    --check if the sequence already exist. 
    select count(*)
    into l_seq_cnt
    from dba_sequences
    where sequence_owner = v_owner
    and sequence_name = v_Seq.seq_name
    ;
    if l_seq_cnt = 0 then
    --drop the sequences
--    begin
--      execute immediate 'drop sequence '||v_Seq.seq_name;
--    exception
--      when others then
--        dbms_output.put_line(SQLERRM);
--    end;
    --Create sequence
      begin    
      execute immediate 'create sequence '||v_Seq.seq_name||' MINVALUE 1 MAXVALUE 99999999999 
                          INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE';
      exception
        when others then
          dbms_output.put_line(SQLERRM);
      end;
    end if;
  end loop;
  --Sequence creation ends.
  for v_trg in c_trg loop 
    --check if the sequence already exist. 
    select count(*)
    into l_trg_cnt
    from dba_triggers
    where owner = v_owner
    and trigger_name = v_trg.trg_name
    ;
    if l_trg_cnt = 0 then
--    --drop trigger
--    --
--    begin
--      execute immediate 'drop trigger '||v_trg.trg_name;    
--    exception
--      when others then
--        dbms_output.put_line(SQLERRM);
--    end;
    --create trigger
      if length(v_trg.trg_name) < 31 then
       begin
          execute immediate 'CREATE OR REPLACE TRIGGER '||v_trg.trg_name||'
         BEFORE UPDATE
         ON '||v_trg.tab_name||' FOR EACH ROW
          BEGIN
             --to capture the update time and updated by during any update on the table
             :NEW.Z_UPDATE_USER_ID := SUBSTR (USER, 1, 20);
             :NEW.Z_UPDATE_TMSTMP := SYSTIMESTAMP;
          END;
        ';    
        exception
          when others then
            dbms_output.put_line(SQLERRM);
        end;  
      end if;
    end if;
  end loop;--v_trg
  --Trigger creation ends.
END;
/