-- Consulta otimizada para alimentar a folha de relatorio e captura visual
SELECT
v.data_venda::DATE AS data_referencia,
COUNT(v.id) AS total_transacoes,
SUM(v.quantidade * p.preco) AS faturacao_total,
CASE
WHEN SUM(v.quantidade * p.preco) > 1000 THEN 'SUCESSO: Meta
Atingida'
ELSE 'ATENCAO: Faturacao Baixa'
END AS estado_desempenho
FROM Vendas v
JOIN Produtos p ON v.produto_id = p.id
WHERE v.data_venda::DATE = CURRENT_DATE - INTERVAL '1 day'
GROUP BY v.data_venda::DATE;
