$ORACLE_HOME/bin/sqlplus /nolog <<EOF
   set feedback off heading off verify off
   set pagesize 0 linesize 200
   clear scre
   conn /as sysdba
   !rm -rf /u01/app/oracle/oradata/orcl/tbdr201.dbf
   shutdown abort;
EOF
clear
