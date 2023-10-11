/*1. Insira um novo cliente com nome 'Antonio José da Silva', endereço 'Rua X, 123', e-mail
'ajsilva@provedor.com', login 'ajsilva' e senha 'ajs123'. Observe que para inserir um cliente, um usuário
correspondente a esse cliente deve ser criado primeiro. Após a inserção do novo usuário, verifique o id
que foi atribuído e vincule esse id ao cliente 'Antonio José da Silva'. Suponha que não existam dois
usuários com o mesmo nome.*/

INSERT INTO usuario(nome, endereco, email, login, senha)
VALUES ('Antonio José da Silva','Rua X 123', 'ajsilva@provedor.com', 'ajsilva','ajs123');

insert into cliente(usuario_id) select usuario.id as usuario_id from usuario where usuario.login = 'ajsilva';


/*2. Insira um novo funcionário com nome 'Rafael João da Costa', endereço 'Rua Y, 456', e-mail
'rjcosta@provedor.com', login 'rjcosta', senha 'rjc456' e salário 2500. Observe que para inserir um
funcionário, um usuário correspondente a esse funcionário deve ser criado primeiro. Após a inserção do
novo usuário, verifique o id que foi atribuído e vincule esse id ao funcionário ‘Rafael João da Costa’.
Suponha que não existam dois usuários com o mesmo nome.*/
INSERT INTO usuario(nome, endereco, email, login, senha) 
VALUES( 'Rafael João da Costa', 'Rua Y, 456', 'rjcosta@provedor.com', 'rjcosta', 'rjc456');
INSERT INTO funcionario(usuario_id, salario) 
SELECT usuario.id as usuario_id, 2500 as salario FROM usuario WHERE login = 'rjcosta';

/*3. Insira três telefones para o cliente 'Antonio José da Silva'. Os telefones são: DDD 85, número 98765432;
DDD 85, número 99754208; e DDD 85, número 98639121. Suponha que não existam dois usuários com
o mesmo nome.*/

/*primeiro telefone*/
insert into usuario_telefone(usuario_id, ddd, numero) 
select usuario.id as usuario_id, 85 as ddd, 98765432 as numero
from usuario where usuario.login = 'ajsilva';
/*segundo telefone*/
insert into usuario_telefone(usuario_id, ddd, numero) 
select usuario.id as usuario_id, 85 as ddd, 99754208 as numero
from usuario where usuario.login = 'ajsilva';
/*terceiro telefone*/
insert into usuario_telefone(usuario_id, ddd, numero) 
select usuario.id as usuario_id, 85 as ddd, 98639121 as numero
from usuario where usuario.login = 'ajsilva';

select usuario.id, ut.usuario_id, ut.ddd, ut.numero from usuario, usuario_telefone as ut where usuario.id = ut.usuario_id and usuario.login = 'ajsilva';

/*4. Insira dois telefones para o funcionário 'Rafael João da Costa'. Os telefones são: DDD 85, número
91290507 e DDD 81, número 90871001. Suponha que não existam dois usuários com o mesmo nome.*/

/*primeiro telefone*/
insert into usuario_telefone(usuario_id, ddd, numero) 
select usuario.id as usuario_id, 85 as ddd, 91290507 as numero
from usuario where usuario.login = 'rjcosta';
/*segundo telefone*/
insert into usuario_telefone(usuario_id, ddd, numero) 
select usuario.id as usuario_id, 81 as ddd, 90871001 as numero
from usuario where usuario.login = 'rjcosta';
/*5. Insira um novo produto de descrição 'Produto X' e preço 23.5. Após a inserção, verifique o id que foi
atribuído ao novo produto 'Produto X'. Suponha que não existam dois produtos com a mesma
descrição. Associe o produto de descrição 'Produto X' a duas categorias existentes.*/
INSERT INTO produto(descricao, preco) VALUES('Produto X', 23.5);
INSERT INTO produto_categoria(produto_id, categoria_id) 
SELECT produto.id as produto_id, categoria.id as categoria_id
FROM categoria, produto 
WHERE produto.descricao = 'Produto X' AND categoria.id = 1;
 
INSERT INTO produto_categoria(produto_id, categoria_id) 
SELECT produto.id as produto_id, categoria.id as categoria_id
FROM categoria, produto 
WHERE produto.descricao = 'Produto X' AND categoria.id = 26;
;
 
