clear
echo  'Restaurando Arquivos do BD'
cp /home/oracle/scripts/backup/orcl/OFFLINE/*.log   /u01/app/oracle/oradata/orcl/    
cp /home/oracle/scripts/backup/orcl/OFFLINE/*.dbf /u01/app/oracle/oradata/orcl/
cp /home/oracle/scripts/backup/orcl/OFFLINE/control01.ctl /u01/app/oracle/oradata/orcl/control01.ctl
echo 'Restauração Finalizada'
