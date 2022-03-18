
drop tablespace tbdr2 including contents and datafiles cascade constraints;
drop table hr.tbdr2 purge;

create tablespace tbdr2
    datafile '/u01/app/oracle/oradata/orcl/tbdr201.dbf' size 1m;

 create table hr.tbdr2
      (cod int,
      data date)
      tablespace tbdr2;

begin
     for i in 1..1000 loop
        insert into hr.tbdr2
        values (i,sysdate);
     end loop;
     commit;
     end;
    /

