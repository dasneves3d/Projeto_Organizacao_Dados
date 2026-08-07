SELECT id, utilizador_id, produto_id, quantidade
FROM Vendas
WHERE quantidade > 1;

SELECT Vendas.id, Utilizadores.nome, Produtos.titulo, Vendas.quantidade
FROM Vendas
JOIN Utilizadores ON Vendas.utilizador_id = Utilizadores.id
JOIN Produtos ON Vendas.produto_id = Produtos.id;
