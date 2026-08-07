CREATE INDEX idx_utilizador_nome ON Utilizadores(nome);

EXPLAIN SELECT * FROM Utilizadores WHERE nome = 'João Silva';
