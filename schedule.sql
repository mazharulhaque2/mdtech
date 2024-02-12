begin
  --========================================
  Dbms_scheduler.create_schedule
    (schedule_name => 'DAILY_2AM_SCH',
    Repeat_interval => 'FREQ=DAILY; BYHOUR=2; INTERVAL=1',
    Comments => 'Execute this task everyday at 2 am.');
--  --
--  Dbms_scheduler.create_schedule
--    (schedule_name => 'DAILY_15MIN_SCH',
--    Repeat_interval => 'FREQ=MINUTELY; INTERVAL=15',
--    Comments => 'Execute this task every 15 min.');
--  --
--  Dbms_scheduler.create_schedule
--    (schedule_name => 'DAILY_2MIN_SCH',
--    Repeat_interval => 'FREQ=MINUTELY; INTERVAL=2',
--    Comments => 'Execute this task every 2 min.');

  --========================================
  Dbms_scheduler.create_program
    (program_name => 'DELETE_PENDING_SVC',
    Program_type =>'STORED_PROCEDURE',
    Program_action => 'scheduler_pkg.delete_old_pending_svc',
    Enabled => TRUE,
    Comments => 'This program will deleted old pending services');
  --=========================================
  --when we don't need to run a program, we only needs to disable the job which is scheduling 
  --the program.
  --When we need any changes on the job, this job needs to be dropped and created.
  --when we needs to run the program with different freq, use respective schedule.
  Dbms_scheduler.create_job
    (Job_name => 'DELETE_PENDING_SVC_JOB',
    Program_name => 'DELETE_PENDING_SVC',
    Schedule_name => 'DAILY_2AM_SCH',
    Enabled => TRUE,
    Comments => 'This job will run the DELETE_PENDING_SVC program according to the DAILY_2AM_SCH schedule.');
--  --
--  Dbms_scheduler.create_job
--    (Job_name => 'DAILY_15MIN_JOB',
--    Program_name => 'PMDS_SERVICE_EMAIL_SEND',
--    Schedule_name => 'DAILY_15MIN_SCH',
--    Enabled => FALSE,
--    Comments => 'This job will run the PMDS_SERVICE_EMAIL_SEND program according to the DAILY_15MIN_SCH schedule.');

  --
  --dbms_scheduler.enable('DAILY_15MIN_JOB');
  --dbms_scheduler.disable('DAILY_15MIN_JOB');
end;
/