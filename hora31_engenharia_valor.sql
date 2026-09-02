-- Criacao da View Executiva adaptada a estrutura do curso
CREATE OR REPLACE VIEW View_Painel_Executivo AS
WITH VendasHoje AS (
 SELECT COALESCE(SUM(v.quantidade * p.preco), 0) AS total_vendas_hoje
 FROM Vendas v
 JOIN Produtos p ON v.produto_id = 
p.id

 WHERE v.data_venda::DATE = CURRENT_DATE),
NovosClientes AS (
 SELECT COUNT(*) AS clientes_novos_mes
 FROM Utilizadores
 -- Nota: Se a tabela Utilizadores tiver uma coluna de data de registo
 -- (ex: data_registo ou created_at), remova os '--' da linha abaixo:
 -- WHERE date_trunc('month', data_registo) = date_trunc('month',CURRENT_DATE)
),
EstadoBackup AS (
 SELECT
 CASE
 WHEN MAX(data_execucao) >= NOW() - INTERVAL '24 hours' AND
estado = 'SUCESSO'
 THEN 'VERDE: Sistema Protegido'
 ELSE 'VERMELHO: Atencao Necessaria'
 END AS status_seguranca
 FROM log_tarefas_agendadas
 WHERE nome_tarefa LIKE '%Backup%' OR nome_tarefa LIKE
'%Auditoria%' OR nome_tarefa LIKE '%Eliminação%'
 GROUP BY estado
 ORDER BY MAX(data_execucao) DESC
   LIMIT 1
)
SELECT
 v.total_vendas_hoje,
 c.clientes_novos_mes,
 COALESCE(b.status_seguranca, 'VERMELHO: Sem Registos') AS
estado_backup,
 TO_CHAR(NOW(), 'YYYY-MM-DD HH24:MI:SS') AS ultima_atualizacao
FROM VendasHoje v
CROSS JOIN NovosClientes c
LEFT JOIN EstadoBackup b ON TRUE; 

-- 1. Adiciona a coluna com um limite por defeito (ex: 5 unidades)
ALTER TABLE Produtos
ADD COLUMN quantidade_minima INT DEFAULT 5; 

-- 3. Executar a consulta do "Semáforo" (agora funciona sem erros)
SELECT
 id,
 titulo,
 stock,
 quantidade_minima,
 CASE
 WHEN stock <= quantidade_minima THEN 'PRECISA DE REPOSICAO'
 ELSE 'ESTA BEM'
 END AS estado_stock
FROM Produtos
WHERE stock <= quantidade_minima
