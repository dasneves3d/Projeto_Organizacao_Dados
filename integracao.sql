SELECT json_build_object(
'id', id,
'titulo', titulo,
'preco', preco
) AS resposta_para_o_site
FROM Produtos
WHERE id = 1;
