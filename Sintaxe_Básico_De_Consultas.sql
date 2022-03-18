#!/bin/bash
####################################################################
##Instalação básico do git e github no Linux######################
###########################################33#########3#############

sudo apt-get updade
sudo apt-get install git
clear
pwd
ls
ls -a
 # configure o usuário e e-mail

git config --global user.name "wagnerrc9999"
git config --global user.email "wagnerrc9999@gmail.com"

veja se tem o arquivo

ls -a
cat .gitconfig

git clone https://github.com/wagnerrc9999/SQL-e-PLSQL

ls

cd shellscript/SQL-e-PLSQL

chmod +x #permissão de arquivo

git add #nome do arquivo
git commit -m "adicione um comentario"
git status # para ver se está tudo ok
git push

