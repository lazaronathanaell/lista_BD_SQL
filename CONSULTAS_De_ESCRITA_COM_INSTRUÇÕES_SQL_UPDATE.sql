/*1. Atualize, aumentando em 10 unidades na tabela estoque, a quantidade dos produtos que foram
vendidos para o cliente de id igual a 226.*/
UPDATE estoque SET quantidade = quantidade + 10 WHERE produto_id IN (SELECT venda_item.produto_id FROM venda_item, venda WHERE venda.venda_id = venda AND venda.cliente_id = 226)
/*2. Atualize, aumentando em uma unidade, a quantidade de cada produto existente no estoque da filial de id igual a 1.*/
UPDATE estoque SET quantidade = quantidade + 1 WHERE filial_id = 1;
/*3. Atualize, aumentando em 10%, o salário de cada funcionário que realizou pelo menos uma venda.*/
UPDATE funcionario SET salario = salario+(salario*0.1) WHERE usuario_id IN 
(SELECT venda.funcionario_id FROM venda_item, venda 
 WHERE venda_item.venda_id = venda.id AND  venda_item.quantidade >=1);