set feedback off heading off verify off
set pagesize 0 linesize 200

define script = '/home/oracle/scripts/backup/crssh_cf.sql'

spool &script
select 'host rm '|| name  from v$controlfile order by 1;
spool off;

@&script
clear scre
shutdown abort;
clear scre

