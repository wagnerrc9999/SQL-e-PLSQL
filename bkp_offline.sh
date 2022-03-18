######################################################################################
# Esse script tem por objetivo realizar o backup offline do banco de dados           #
# conforme a configuração da variável ORACLE_SID.                                    #
# Ele foi criado para ser utilizado como suporte na aula de Segurança e Desempenho   #
# em Ambientes de Alta Escalabilidade do curso de Tecnologia em Banco de Dados.      #
# IMPORTANTE: Caso os arquivos existam no destino eles serão sobrescritos!           #
# Autor: Alexandre Barcelos                                                          #
# Data: 03/03/2018 - Criação                                                         #
#       13/04/2019 - Alteração de Destino de backup                                  #
#       07/04/2020 - Ajuste para Oracle 12C                                          #
#                                                                                    #
# Para utilizar execute os seguintes passos:                                         #
# =========================================                                          #
# 1- Crie os diretórios para o backup:                                               #
# mkdir -p /home/oracle/scripts/backup/<ORACLE_SID>/OFFLINE                          #
#                                                                                    #
# 2- Copie os scripts bkp_offline.sql e bkp_offline.sh para o seguinte local:        #
# cd /home/oracle/scripts/backup/                                                    #
#                                                                                    #
# 3- Mude a permissão do arquivo bkp_offline.sh                                      #
# chmod 733 bkp_offline.sh                                                           #
#                                                                                    #
# 4- Execute o script de backup                                                      #
# ./bkp_offline.sh                                                                   #
#                                                                                    #
######################################################################################

clear
# Configura o interpretador de comandos
#!/bin/sh
# Define variaveis para data e hora
ANO=`date "+%Y"`
MES=`date "+%m"`
DIA=`date "+%d"`
HOR=`date "+%H"`
MIN=`date "+%M"`
SEG=`date "+%S"`

# +----------------------------------------------------------------------------+
# | VARIAVEIS "PADRAO" PARA DIRETORIOS DE SCRIPTS E DE LOG                     |
# +----------------------------------------------------------------------------+
BIN_DIR=$HOME/scripts/backup
LOG_DIR=$HOME/scripts/backup/log


# Verifica se a instance foi informada como parâmetro
if [ -z "$1" ]; then
   echo 'Atenção: Informe o SID do banco de dados.'
   echo
   echo 'Sintaxe: bkp_offline.sh <SID>'
   echo 'Onde: <SID> é o nome do banco de dados'
   echo
   echo 'Exemplo: bkp_offline.sh orcl'
   exit 0
fi
# Configura variável para armazenar o SID
ORACLE_SID=$1
# Configura variável para armazenar o nome do processo PMON
SERVICE=pmon_$ORACLE_SID
# Pega o nome do processo
ps aux | grep -v grep | grep $SERVICE  > /dev/null
result=$?
if [ "${result}" -ne "0" ] ; then
   
   echo "`date`: Oracle Database is DOWN. Startup Database"
   exit 0
else
   # Configura a variável que armazena o destino dos arquivos de backup
   export BKP_DIR=/home/oracle/scripts/backup/$ORACLE_SID/OFFLINE
   # Configura a variável que armazena o destino dos arquivo de network
   export ORA_NET_DIR=$ORACLE_HOME/network/admin
   echo '************************** Backup Iniciado **************************'
   # Chama o sqlplus
   $ORACLE_HOME/bin/sqlplus /nolog <<EOF
   conn /as sysdba
   -- Executa o script bkp_offline.sql para preparar os comandos de copy
   @/home/oracle/scripts/backup/bkp_offline.sql
EOF
   # Realiza a cópia dos arquivos de TNSNAMES e LISTENER
   cp $ORA_NET_DIR/tnsnames.ora $BKP_DIR
   cp $ORA_NET_DIR/listener.ora $BKP_DIR
	   clear
   echo ''
   echo ''
   echo '************************** Backup Finalizado **************************'
   echo ''
   echo 'Lista de arquivos copiados:'
   echo ''
   ls -latr $BKP_DIR
   rm $BIN_DIR/bkp_offline_list.sql
fi

