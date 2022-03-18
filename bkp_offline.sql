/*
 Esse script tem por finalidade construir os comandos de copy
 da estrutura física do banco de dados para que seja realizado
 o backup offline
 Autor: Alexandre Barcelos
 Data: 03/03/2018
*/

set feedback off heading off verify off
set pagesize 0 linesize 200

-- Define a variável com o caminho de destino para o backup
   define directory = '/home/oracle/scripts/backup/orcl/OFFLINE'

-- Define o local onde o script com os comando de copy será gerado
   define script = '/home/oracle/scripts/backup/bkp_offline_list.sql'

spool &script
-- Constroi a lista para a copia de datafiles
   select 'host cp '|| name ||' &directory' from v$datafile order by 1;
-- Constroi a lista para a copia de redo log files
   select 'host cp '|| member ||' &directory' from v$logfile order by 1;
-- Constroi a lista para a copia de control files
   select 'host cp '|| name ||' &directory' from v$controlfile order by 1;
-- Constroi a lista para a copia de tempfiles
   select 'host cp '|| name ||' &directory' from v$tempfile order by 1;
-- Constroi o comando para a copia do server parameter file
   select 'host cp '||value ||' &directory' from v$parameter where name='spfile';
spool off;

-- Derruba o banco de dados
   shutdown immediate;
-- Executa o backup
   @&script
-- Inicia o banco de dados
   startup;

