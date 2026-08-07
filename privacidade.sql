CREATE TABLE Log_Acessos (
quem_fez_o_select TEXT,
data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE FUNCTION registar_acesso() RETURNS
TRIGGER AS $$
BEGIN
INSERT INTO Log_Acessos (quem_fez_o_select) VALUES
(current_user);
RETURN NULL;
END;
$$ LANGUAGE plpgsql;
-- Associar o porteiro (Trigger) à tabela de clientes para alterações
CREATE TRIGGER trigger_auditoria_clientes
AFTER UPDATE ON utilizadores
FOR EACH ROW
EXECUTE FUNCTION registar_alteracao();


DELETE FROM Utilizadores WHERE id = 123;
