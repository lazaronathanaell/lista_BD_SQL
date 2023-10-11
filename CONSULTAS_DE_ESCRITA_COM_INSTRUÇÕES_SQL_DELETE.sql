/*1. Remova todos os itens de vendas do cliente de nome 'Antonio José da Silva'. Após isso, remova todas as
vendas que foram feitas para o cliente de nome 'Antonio José da Silva'. Suponha que não existem dois
usuários com o mesmo nome.*/
DELETE FROM venda_item WHERE venda_id = 
(SELECT v.id  
 FROM venda AS v, cliente AS c, usuario AS U
 WHERE v.cliente_id = c.usuario_id AND u.id = c.usuario_id
 AND u.nome = 'Antonio José da Silva'
);

DELETE FROM venda WHERE id = (Select v.id
from cliente as c, usuario as u, venda as v
where v.cliente_id = c.usuario_id 
and c.usuario_id = u.id 
AND u.nome = 'Antonio José da Silva0'); 
/*2. Remova todos os itens de vendas onde os produtos estão vinculados a mais de uma categoria.*/

DELETE FROM venda_item WHERE produto_id IN
(SELECT pc.produto_id 
 FROM produto_categoria AS pc 
GROUP BY pc.produto_id 
 HAVING COUNT(pc.categoria_id) > 1);


DELETE FROM venda WHERE id =
((SELECT v.id FROM venda AS v) EXCEPT 
 (SELECT vi.venda_id FROM venda_item AS vi));