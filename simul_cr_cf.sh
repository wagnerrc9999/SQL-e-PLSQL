clear
$ORACLE_HOME/bin/sqlplus /nolog <<EOF
   conn /as sysdba
   @/home/oracle/scripts/backup/simul_cr_cf.sql
EOF
clear
