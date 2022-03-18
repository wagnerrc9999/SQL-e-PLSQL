clear
echo  'Restaurando Arquivos do BD'
cp /home/oracle/scripts/backup/orcl/ONLINE/sysaux01.dbf   /u01/app/oracle/oradata/orcl/sysaux01.dbf    
cp /home/oracle/scripts/backup/orcl/ONLINE/system01.dbf   /u01/app/oracle/oradata/orcl/system01.dbf    
cp /home/oracle/scripts/backup/orcl/ONLINE/tbdr201.dbf    /u01/app/oracle/oradata/orcl/tbdr201.dbf     
cp /home/oracle/scripts/backup/orcl/ONLINE/undotbs01.dbf  /u01/app/oracle/oradata/orcl/undotbs01.dbf   
cp /home/oracle/scripts/backup/orcl/ONLINE/users01.dbf    /u01/app/oracle/oradata/orcl/users01.dbf     
cp /home/oracle/scripts/backup/orcl/ONLINE/temp01.dbf     /u01/app/oracle/oradata/orcl/temp01.dbf    
#cp /home/oracle/scripts/backup/orcl/ONLINE/control.bkp    /u01/app/oracle/oradata/orcl/control01.ctl
echo 'Restauração Finalizada'
