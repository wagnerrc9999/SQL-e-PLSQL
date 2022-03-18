#/bin/sh
clear
echo 'Antes de executar o cenário faça o BACKUP ONLINE'

$ORACLE_HOME/bin/sqlplus /nolog <<EOF
conn / as sysdba
set feedback off heading off verify off
set pagesize 0 linesize 200

prompt  'Criando a tabela country'
create table hr.country
(country_name varchar(50));

prompt 'Inserindo o pais Brasil'
insert into hr.country values ('Brasil');
commit;
prompt 'Fazendo swith no redo'

alter system switch logfile;

prompt 'Inserindo o pais Austrália'
insert into hr.country values ('Austrália');
commit;
prompt 'Fazendo swith no redo'
alter system switch logfile;


prompt 'Inserindo o pais Portugal'
insert into hr.country values ('Portugal');
prompt 'Fazendo swith no redo'

commit;

PROMPT 'Conferindo os archivelogs gerados'
! ls -lhtr /u01/app/oracle/fast_recovery_area/orcl/ORCL/archivelog/2020_04_08

prompt 'Contando as linhas da tabela COUNTRY'
select * from hr.country;

prompt 'Derrubando BD'
alter system switch logfile;
alter system checkpoint;
alter system switch logfile;
alter system checkpoint;
alter system archive log current;
alter system archive log all;

shutdown immediate;

EOF
echo  'Simulando falha no STORAGE. Deletando Datafiles e Redos'
rm -rf /u01/app/oracle/oradata/orcl/system01.dbf
rm -rf /u01/app/oracle/oradata/orcl/sysaux01.dbf
rm -rf /u01/app/oracle/oradata/orcl/undotbs01.dbf
rm -rf /u01/app/oracle/oradata/orcl/users01.dbf
rm -rf /u01/app/oracle/oradata/orcl/tbdr201.dbf  
rm -rf /u01/app/oracle/oradata/orcl/temp01.dbf
rm -rf /u01/app/oracle/oradata/orcl/redo02.log
rm -rf /u01/app/oracle/oradata/orcl/redo01.log
rm -rf /u03/app/oracle/oradata/orcl/redo01_b.log
rm -rf /u03/app/oracle/oradata/orcl/redo02_b.log
clear
echo 'Simulação de falha concluída'

