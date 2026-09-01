-- Criacao do historico de execucao de tarefas automáticas
CREATE TABLE IF NOT EXISTS log_tarefas_agendadas (
 id SERIAL PRIMARY KEY,
 nome_tarefa VARCHAR(100) NOT NULL,
 data_execucao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 estado VARCHAR(20) NOT NULL CHECK (estado IN ('SUCESSO', 'ERRO',
'ALERTA')),
 mensagem TEXT NOT NULL,
 registos_afetados INT DEFAULT 0
); 


-- Script de Execucao da Auditoria Diaria de Vendas
WITH analise_vendas AS (
 SELECT COUNT(*) AS total_vendas
 FROM Vendas
)
INSERT INTO log_tarefas_agendadas (nome_tarefa, estado, mensagem,
registos_afetados)
SELECT
 'Auditoria e Verificacao Diaria de Vendas',
 CASE
 WHEN total_vendas > 0 THEN 'SUCESSO'
 ELSE 'ALERTA'
 END,
 CASE
 WHEN total_vendas > 0 THEN CONCAT('Auditoria concluida com êxito.
Total de registos validados: ', total_vendas)
 ELSE 'ALERTA: Nenhuma venda encontrada na tabela para o periodo
analisado!'
 END,
 total_vendas
FROM analise_vendas; 


SELECT
 id,
 nome_tarefa,
 TO_CHAR(data_execucao, 'YYYY-MM-DD HH24:MI:SS') AS data_formatada,
 estado,
 mensagem,
 registos_afetados
FROM log_tarefas_agendadas
ORDER BY data_execucao DESC;
