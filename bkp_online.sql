/*
 Esse script tem por finalidade construir os comandos de copy
 da estrutura física do banco de dados para que seja realizado
 o backup online
 Autor: Alexandre Barcelos
 Data: 03/03/2018
*/

set feedback off heading off verify off
set pagesize 0 linesize 200

-- Define a variável com o caminho de destino para o backup
   define directory = '/home/oracle/scripts/backup/orcl/ONLINE'

-- Define o local onde o script com os comando de copy será gerado
   define script = '/home/oracle/scripts/backup/bkp_online_list.sql'

spool &script
-- Constroi a lista para a copia de datafiles
   select 'host cp '|| name ||' &directory' from v$datafile order by 1;
-- Constroi a lista para a copia de tempfiles
   select 'host cp '|| name ||' &directory' from v$tempfile order by 1;
-- Constroi o comando para a copia do server parameter file
   select 'host cp '||value ||' &directory' from v$parameter where name='spfile';
spool off;
-- Coloca o Banco de Dados em modo de Backup
   alter database begin backup;
-- Executa o backup
   @&script
-- Retira o Banco de Dados em modo de Backup
   alter database end backup;
-- Faz backup do control file em formato binário
   alter system ckeckpoint;
   alter system switch logfile;
   ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS '&directory/control.bkp' REUSE;
-- Faz backup do control file em formato texto
   ALTER DATABASE BACKUP CONTROLFILE TO TRACE;
