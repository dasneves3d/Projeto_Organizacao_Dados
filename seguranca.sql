-- Criar o perfil de Leitor
CREATE ROLE leitor_Organizacao;
-- Criar o perfil de Editor
CREATE ROLE editor_Organizacao;

-- O Leitor só pode ver (SELECT) as tabelas
GRANT SELECT ON Utilizadores TO leitor_Organizacao;
GRANT SELECT ON Vendas TO leitor_Organizacao;
-- O Editor pode inserir dados (INSERT) e mudar coisas (UPDATE)
GRANT SELECT, INSERT, UPDATE ON Produtos TO editor_Organizacao;
