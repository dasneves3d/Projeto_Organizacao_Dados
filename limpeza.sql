UPDATE Utilizadores
SET email = 'novo.joao@email.com'
WHERE nome = 'João Silva';

DELETE FROM Vendas
WHERE quantidade = 0;

ALTER TABLE Produtos
ADD CONSTRAINT preco_positivo CHECK (preco >= 0);
