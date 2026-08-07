-- 1. Limpeza total (Cuidado: isto apaga tudo!)
DROP TABLE IF EXISTS Vendas;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Utilizadores;
-- 2. Criação da estrutura
CREATE TABLE Utilizadores (id SERIAL PRIMARY KEY, nome VARCHAR(100), email
VARCHAR(100) UNIQUE);
CREATE TABLE Produtos (id SERIAL PRIMARY KEY, titulo VARCHAR(200), preco
DECIMAL(10, 2), stock INT);
CREATE TABLE Vendas (id SERIAL PRIMARY KEY, utilizador_id INT REFERENCES
Utilizadores(id), produto_id INT REFERENCES Produtos(id), quantidade INT);
-- 3. Aceleração
CREATE INDEX idx_utilizador_nome ON Utilizadores(nome);
-- 4. Segurança
CREATE ROLE estagiario_leitor;
GRANT SELECT ON Utilizadores TO estagiario_leitor;
