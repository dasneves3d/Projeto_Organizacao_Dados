CREATE INDEX idx_vendas_data_recente
ON Vendas (quantidade)
WHERE quantidade >= 10;
