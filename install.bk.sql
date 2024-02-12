--Installation steps:
--sqlplus mdtech/Mdtech9591@orcl
--SQL> prompt, type "@install.sql "
--Pre-req of this script is to load all the stagging tables (ext_file) and load json package (json_v1_0_5\json_v1_0_5\install.sql)
spool install.log
@create_common_tables.sql
@mdtech_ddl.sql
@general_ddl.sql
@mdtech_types.typ.sql
@modify_ddl.sql
@create_seq.sql
@mdtech.trg.sql
------------------------------------------
@common.pkg.sql
@send_mail.pkg.sql
@mail.pkg.sql
@web_services.pkg.sql
@common_dml.pkg.sql
@history.pkg.sql
@mdtech_view.sql
@loc_trans.pkg.sql
@loc_inq.pkg.sql
--@admin_inq.pkg.sql
--@admin_trans.pkg.sql
@mbr_inq.pkg.sql
@mbr_trans.pkg.sql
@qnr_inq.pkg.sql
@common_inq.pkg.sql
@common_trans.pkg.sql
@list_trans.pkg.sql
@load_location.sql
@load_list_trans.sql
spool off