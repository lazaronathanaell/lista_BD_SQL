/*1. Encontre todos os nomes dos clientes que iniciam com 'Antonio'.*/
SELECT nome FROM usuario AS u, cliente AS c1 WHERE u.nome LIKE '%Antonio%' AND (u.id = c1.usuario_id);


/*2. Quais os nomes e telefones (DDD e número) dos clientes com nomes que terminam com 'Cooper'?*/
SELECT usuario.nome, usuario_telefone.ddd, usuario_telefone.numero  FROM usuario, usuario_telefone WHERE usuario.nome LIKE '% Cooper' AND usuario.id = usuario_telefone.usuario_id;


/*3. Quais os nomes dos usuários registrados na tabela de usuario e que não são clientes? Podem ser
retornados um ou mais nomes de usuários.
*/
(SELECT usuario.nome FROM usuario)
EXCEPT ALL
(SELECT usuario.nome FROM usuario, cliente WHERE usuario.id = cliente.usuario_id);


/*4. Quais as descrições e preços dos produtos que não estão disponíveis na filial cujo identificador é 1?
*/
SELECT produto.descricao,  produto.preco, estoque.filial_id  FROM produto, estoque WHERE  estoque.produto_id = produto.id AND estoque.filial_id != 1;



/*5. Quais os nomes dos funcionários que começam com 'Julie' e que possuem telefones com DDD 81? A
consulta deverá retornar, também, o DDD e número do telefone do funcionário.*/
SELECT usuario.nome, usuario_telefone.ddd, usuario_telefone.numero 
FROM funcionario, usuario, usuario_telefone
WHERE ((usuario.id = funcionario.usuario_id) 
AND (usuario.nome LIKE 'Julie %')) 
AND ((funcionario.usuario_id = usuario_telefone.usuario_id)
AND (usuario_telefone.ddd = 81));



/*6. Quais os identificadores e descrições dos produtos que estão faltando em estoque na filial de razão
social 'THOUSAND OAKS'?*/

SELECT DISTINCT produto.id, produto.descricao FROM produto, estoque
WHERE produto.id = estoque.produto_id 
AND estoque.filial_id != (SELECT filial.id FROM filial 
WHERE filial.razao_social = 'THOUSAND OAKS');

/*7. Qual o preço do produto mais caro que faz parte da categoria de descrição 'RAM'?*/

SELECT MAX(produto.preco) AS mais_caro FROM produto, produto_categoria
WHERE produto.id = produto_categoria.produto_id 
AND produto_categoria.categoria_id = (SELECT categoria.id FROM categoria 
WHERE categoria.descricao = 'RAM');

/*8. Elabore uma consulta que mostre as descrições e preços dos produtos que possuem mais de uma categoria associada.*/
SELECT b.descricao, b.preco FROM 
(SELECT pc.produto_id FROM produto_categoria AS pc 
GROUP BY pc.produto_id HAVING COUNT(pc.categoria_id) > 1) 
AS a,produto as b WHERE a.produto_id = b.id;

/*9. Elabore uma consulta que mostre o valor total vendido por razão social de cada filial. A consulta deve levar em consideração todas vendas registradas na tabela venda.*/


SELECT f.razao_social, SUM(a.preco)
FROM filial AS f,
(SELECT  v.filial_id, vi.produto_id, p.preco
FROM venda AS v, venda_item AS vi, produto AS p
WHERE v.id = vi.venda_id AND vi.produto_id = p.id 
ORDER BY v.filial_id ASC) AS a
WHERE a.filial_id = f.id 
GROUP BY f.razao_social;

/*10. Quantos clientes compraram uma quantidade total de unidades de produtos acima da média da quantidade total de unidades compradas por todos os clientes? A consulta deve levar em consideração todas vendas registradas na tabela venda.*/

SELECT COUNT(*) AS total_clientes_acima_media
FROM (
    SELECT v.cliente_id, SUM(vi.quantidade) AS quantidade_total
    FROM venda v, venda_item vi
    WHERE v.id = vi.venda_id
    GROUP BY v.cliente_id
    HAVING SUM(vi.quantidade) > (
        SELECT AVG(quantidade_total) AS media
        FROM (
            SELECT SUM(vi.quantidade) AS quantidade_total
            FROM venda v, venda_item vi
            WHERE v.id = vi.venda_id
            GROUP BY v.cliente_id
        ) AS subquery
    )
) AS subquery; 
