-- 1. Criar a tabela do livro de visitas
CREATE TABLE Auditoria_Precos (
produto_id INT,
preco_antigo DECIMAL,
preco_novo DECIMAL,
data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 2. O Porteiro (Trigger)
CREATE OR REPLACE FUNCTION registar_alteracao()
RETURNS TRIGGER AS $$
BEGIN
INSERT INTO Auditoria_Precos (produto_id, preco_antigo, preco_novo)
VALUES (OLD.id, OLD.preco, NEW.preco);
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER porteiro_precos
AFTER UPDATE ON Produtos
FOR EACH ROW EXECUTE FUNCTION registar_alteracao();

UPDATE Produtos SET preco = 25.00 WHERE id = 1;

SELECT * FROM Auditoria_Precos;
