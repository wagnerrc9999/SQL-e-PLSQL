-- criação de usuários e privilégios no oracle.

-- Esquemas: Um esquema é uma coleção de objetos de banco de dados pertencentes a um
--usuário de banco de dados. Os objetos de um esquema são as estruturas lógicas que fazem
--referência direta aos dados do banco de dados. Esses objetos incluem estruturas como
--tabelas, views, sequências, procedures armazenados, sinônimos, índices, clusters e links de
--banco de dados. Em geral, os objetos do esquema incluem tudo que a aplicação cria no
--banco de dados.

-- Autenticação: é um processo que verifica a identidade do usuário. Muitas vezes
--depende de algumas variáveis, como, login e senha, biometria (digital, iris, etc), token.
--Autorização: é o processo que verifica quais as permissões que o usuário possui,
--determinando quais ações ele pode executar no sistema.

-- exemplo de criação de usuário no sql oracle.

create user loja_virtual
identified by joao
default tablespace tb_loja_virtual_joao
temporary tablespace tb_loja _virtual_temp
quota 100 M on tb_lojavirtual_joao
account unlock;

-- exemplo de alteração de usuário.
alter user loja_virtual
identified by nova_senha
default tablespace tb_loja_virtual_joao_novo
temporary tablespace TEMP
quota 100 M on tb_lojavirtual_dados_novo
account unlock;

-- remoção de de um usuário.
drop user loja_virtual cascade; 

-- Concedendo e revogando privilégios

-- grant
grant create table to loja_virutal_joao_novo;
grant create procedure to loja_virutal;
grant create tablespace to joao_dba;
grant create user to joao_dba;

--revoke
revoke create table from lojavirutal_joao_novo;
revoke create procedure from loja_virutal;
revoke create tablespace from joao_dba;
revoke create user from joao_dba;


--Privilégios de Objeto

--grant
grant select, insert on loja_virtual.pedido to wagner, maria, rafael;
grant insert on loja_virtual.pedido to loja_virtual_app;
grant all on loja_virtual.cliente to wagner;
grant select on loja_virtual.cliente to maria;
--revoke
revoke select, insert on loja_virtual.pedido from wagner, maria, rafael;
revoke insert on loja_virtual.pedido from loja_virtual;
revoke all on loja_virtual.cliente from wagner;
revoke select on loja_virtual.cliente from maria;


--Uma ROLE é um conjunto de privilégios que pode ser atribuído para um usuário. 


-- criando uma ROLE
create role super_loja;

--grant
grant create table to super_loja;
grant select, insert, update, delete on loja_virtual.venda to super_loja;

grant super_loja to super_loja_app;
revoke super_loja from super_loja_app;
--revoke
revoke create table from super_loja;
revoke select, insert, update, delete on loja_virtual.venda from super_loja;

-- é importando dar os privilégios para o usuário ja que o oracle sempre da o menor
-- privilégio possivel para o usúrio.





