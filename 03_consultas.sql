-- =========================================================
-- PROJETO SQL | DISTRIBUIDORA ALPHA
-- CONSULTAS ANALÍTICAS
-- Autora: Karol Antunes

-- 1. CONSULTAS BÁSICAS DE EXPLORAÇÃO
-- =========================================================

-- Consulta inicial para visualizar os clientes cadastrados
SELECT * FROM cliente;

-- Consulta inicial para visualizar os produtos cadastrados
SELECT * FROM produto;

-- Consulta inicial para visualizar os pedidos registrados
SELECT * FROM pedido;

-- Visualização resumida dos vendedores
SELECT
    id_vendedor,
    nome_vendedor
FROM vendedor;

-- Visualização resumida dos supervisores
SELECT
    id_supervisor,
    nome_supervisor
FROM supervisor;


-- 2. INDICADORES GERAIS DE VENDAS
-- =========================================================

-- Faturamento total
-- Nesta análise, considerei apenas os pedidos faturados,
-- pois são eles que representam venda efetivamente realizada.
SELECT
    SUM(p.valor_total) AS faturamento_total
FROM pedido p
WHERE p.status_pedido = 'Faturado';

-- Quantidade total de pedidos faturados
-- Aqui, o objetivo é medir o volume de pedidos concluídos,
-- separando essa medida do valor financeiro das vendas.
SELECT
    COUNT(*) AS quantidade_total_pedidos
FROM pedido p
WHERE p.status_pedido = 'Faturado';

-- Ticket médio
-- O ticket médio ajuda a entender o valor médio dos pedidos faturados.
-- Essa medida é importante para acompanhar o perfil das vendas realizadas.
SELECT
    AVG(p.valor_total) AS ticket_medio
FROM pedido p
WHERE p.status_pedido = 'Faturado';


-- 3. ANÁLISE POR VENDEDOR E SUPERVISOR
-- =========================================================

-- Faturamento por vendedor
-- Para chegar a esse resultado, relacionei os pedidos aos vendedores
-- responsáveis e somei o valor dos pedidos faturados de cada um.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    SUM(p.valor_total) AS total_vendedor
FROM vendedor v
JOIN pedido p
    ON v.id_vendedor = p.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY total_vendedor DESC;

-- Quantidade de pedidos por vendedor
-- Nesta consulta, mantive a mesma lógica da anterior,
-- mas trocando a medida de valor pela quantidade de pedidos.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    COUNT(p.id_pedido) AS pedidos_vendedor
FROM vendedor v
JOIN pedido p
    ON v.id_vendedor = p.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY pedidos_vendedor DESC;

-- Vendedores e seus respectivos supervisores
-- Esta consulta foi pensada para visualizar a estrutura comercial,
-- mostrando o vínculo entre cada vendedor e seu supervisor.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    s.id_supervisor,
    s.nome_supervisor
FROM vendedor v
JOIN supervisor s
    ON v.id_supervisor = s.id_supervisor
ORDER BY s.nome_supervisor, v.nome_vendedor;

-- Total por supervisor
-- Como o supervisor não registra pedidos diretamente,
-- segui o caminho supervisor -> vendedor -> pedido
-- para consolidar o faturamento da equipe sob sua gestão.
SELECT
    s.id_supervisor,
    s.nome_supervisor,
    SUM(p.valor_total) AS valor_total_supervisor
FROM pedido p
JOIN vendedor v
    ON v.id_vendedor = p.id_vendedor
JOIN supervisor s
    ON s.id_supervisor = v.id_supervisor
WHERE p.status_pedido = 'Faturado'
GROUP BY s.id_supervisor, s.nome_supervisor
ORDER BY valor_total_supervisor DESC;

-- Ranking de supervisores
-- Aqui, a mesma lógica anterior foi mantida,
-- mas com foco em comparação de desempenho entre supervisores.
SELECT
    s.id_supervisor,
    s.nome_supervisor,
    SUM(p.valor_total) AS valor_supervisor
FROM supervisor s
JOIN vendedor v
    ON s.id_supervisor = v.id_supervisor
JOIN pedido p
    ON p.id_vendedor = v.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY s.id_supervisor, s.nome_supervisor
ORDER BY valor_supervisor DESC;

-- Vendedor que mais vendeu
-- Esta consulta organiza os vendedores em ordem descrecente de faturamento,
-- permitindo identificar os destaques comerciais no período analisado.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    SUM(p.valor_total) AS valor_vendedor
FROM vendedor v
JOIN pedido p
    ON v.id_vendedor = p.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY valor_vendedor DESC;

-- Ticket médio por vendedor
-- Além do valor total vendido, esta consulta ajuda a observar
-- o tamanho médio dos pedidos de cada vendedor.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    AVG(p.valor_total) AS ticket_medio
FROM vendedor v
JOIN pedido p
    ON v.id_vendedor = p.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY ticket_medio DESC;


-- 4. CLIENTES, CARTEIRA E RELACIONAMENTOS
-- =========================================================

-- Clientes com seus respectivos vendedores
-- Esta consulta mostra como a carteira está distribuída entre os vendedores.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    c.id_cliente,
    c.nome_fantasia
FROM cliente c
JOIN vendedor v
    ON c.id_vendedor = v.id_vendedor
ORDER BY v.nome_vendedor, c.nome_fantasia;

-- Clientes com as suas cidades
-- Para localizar a cidade do cliente, foi necessário seguir
-- a relação entre cliente, endereço e cidade.
SELECT
    c.id_cliente,
    c.nome_fantasia,
    e.id_endereco,
    ci.id_cidade,
    ci.nome_cidade,
    ci.uf
FROM cliente c
JOIN endereco e
    ON c.id_endereco = e.id_endereco
JOIN cidade ci
    ON ci.id_cidade = e.id_cidade
ORDER BY ci.nome_cidade, c.nome_fantasia;

-- Pedidos com cliente e vendedor
-- Esta consulta reúne os principais elementos de uma venda,
-- facilitando leituras mais detalhadas sobre cada pedido.
SELECT
    p.id_pedido,
    c.id_cliente,
    c.nome_fantasia,
    v.id_vendedor,
    v.nome_vendedor,
    p.data_pedido,
    p.valor_total,
    p.status_pedido
FROM pedido p
JOIN vendedor v
    ON p.id_vendedor = v.id_vendedor
JOIN cliente c
    ON c.id_cliente = p.id_cliente
ORDER BY p.data_pedido, p.id_pedido;

-- Clientes atendidos por vendedor
-- Aqui, a análise considera a carteira cadastrada,
-- ou seja, quantos clientes estão vinculados a cada vendedor.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    COUNT(c.id_cliente) AS total_clientes
FROM vendedor v
JOIN cliente c
    ON v.id_vendedor = c.id_vendedor
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY total_clientes DESC;

-- Clientes que realmente compraram
-- Diferente da carteira cadastrada, esta consulta mede
-- quantos clientes distintos efetivamente fizeram pedidos faturados.
SELECT
    v.id_vendedor,
    v.nome_vendedor,
    COUNT(DISTINCT p.id_cliente) AS clientes_atendidos
FROM vendedor v
JOIN pedido p
    ON v.id_vendedor = p.id_vendedor
WHERE p.status_pedido = 'Faturado'
GROUP BY v.id_vendedor, v.nome_vendedor
ORDER BY clientes_atendidos DESC;

-- Clientes que mais compram por valor
-- Nesta análise, o foco é identificar os clientes
-- com maior participação no faturamento.
SELECT
    c.id_cliente,
    c.nome_fantasia,
    SUM(p.valor_total) AS valor_cliente
FROM cliente c
JOIN pedido p
    ON p.id_cliente = c.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY c.id_cliente, c.nome_fantasia
ORDER BY valor_cliente DESC;

-- Clientes que mais fazem pedidos
-- Aqui, a prioridade é observar recorrência de compra,
-- usando a quantidade de pedidos como critério.
SELECT
    c.id_cliente,
    c.nome_fantasia,
    COUNT(p.id_pedido) AS pedidos_cliente
FROM cliente c
JOIN pedido p
    ON p.id_cliente = c.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY c.id_cliente, c.nome_fantasia
ORDER BY pedidos_cliente DESC;

-- Frequência de compras por cliente
-- Esta leitura reforça a análise de recorrência,
-- ajudando a identificar clientes mais ativos.
SELECT
    c.nome_fantasia,
    COUNT(p.id_pedido) AS frequencia_compra
FROM cliente c
JOIN pedido p
    ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY c.nome_fantasia
ORDER BY frequencia_compra DESC;

-- Clientes inativos pelo status cadastral
-- Primeiro recorte de inatividade:
-- clientes marcados como inativos no cadastro.
SELECT
    nome_fantasia,
    id_cliente,
    status_cliente
FROM cliente
WHERE status_cliente = 'Inativo';

-- Clientes inativos pela ausência de compras
-- Segundo recorte de inatividade:
-- clientes sem nenhum pedido faturado associado.
SELECT
    c.id_cliente,
    c.nome_fantasia
FROM cliente c
LEFT JOIN pedido p
    ON c.id_cliente = p.id_cliente
   AND p.status_pedido = 'Faturado'
WHERE p.id_pedido IS NULL;


-- 5. ANÁLISES TEMPORAIS
-- =========================================================

-- Faturamento por mês
-- Como a base está em SQLite, utilizei strftime para consolidar
-- os pedidos faturados em grupos mensais.
SELECT
    strftime('%Y-%m', data_pedido) AS mes,
    SUM(valor_total) AS faturamento
FROM pedido
WHERE status_pedido = 'Faturado'
GROUP BY strftime('%Y-%m', data_pedido)
ORDER BY mes;

-- Quantidade de pedidos por mês
-- Nesta leitura, mantenho a lógica temporal
-- e substituo a soma pela contagem de pedidos.
SELECT
    strftime('%Y-%m', data_pedido) AS mes,
    COUNT(id_pedido) AS quantidade_pedidos
FROM pedido
WHERE status_pedido = 'Faturado'
GROUP BY strftime('%Y-%m', data_pedido)
ORDER BY mes;


-- 6. FORMAS DE PAGAMENTO
-- =========================================================

-- Forma de pagamento mais utilizada
-- O objetivo aqui é identificar a forma de pagamento
-- mais frequente entre os pedidos faturados.
SELECT
    fp.descricao_forma_pagamento,
    COUNT(p.id_pedido) AS uso_forma_pagamento
FROM forma_de_pagamento fp
JOIN pedido p
    ON p.id_forma_pagamento = fp.id_forma_pagamento
WHERE p.status_pedido = 'Faturado'
GROUP BY fp.descricao_forma_pagamento
ORDER BY uso_forma_pagamento DESC;

-- Faturamento por forma de pagamento
-- Nesta análise, a mesma dimensão é mantida,
-- mas o foco passa a ser o valor total movimentado por cada forma.
SELECT
    fp.id_forma_pagamento,
    fp.descricao_forma_pagamento,
    SUM(p.valor_total) AS valores_forma_pagamento
FROM forma_de_pagamento fp
JOIN pedido p
    ON fp.id_forma_pagamento = p.id_forma_pagamento
WHERE p.status_pedido = 'Faturado'
GROUP BY fp.id_forma_pagamento, fp.descricao_forma_pagamento
ORDER BY valores_forma_pagamento DESC;


-- 7. CATEGORIAS, PRODUTOS E MARCAS
-- =========================================================

-- Total por categoria
-- Para chegar ao faturamento por categoria, foi necessário
-- percorrer a relação entre pedido, item do pedido, produto e categoria.
SELECT
    c.id_categoria,
    c.nome_categoria,
    SUM(ip.subtotal_item) AS total_categoria
FROM categoria c
JOIN produto pr
    ON pr.id_categoria = c.id_categoria
JOIN item_pedido ip
    ON ip.id_produto = pr.id_produto
JOIN pedido p
    ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY c.id_categoria, c.nome_categoria
ORDER BY total_categoria DESC;

-- Média por categoria
-- Aqui, mantive a mesma estrutura relacional,
-- observando agora o valor médio dos itens vendidos por categoria.
SELECT
    c.id_categoria,
    c.nome_categoria,
    AVG(ip.subtotal_item) AS media_categoria
FROM categoria c
JOIN produto pr
    ON pr.id_categoria = c.id_categoria
JOIN item_pedido ip
    ON ip.id_produto = pr.id_produto
JOIN pedido p
    ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY c.id_categoria, c.nome_categoria
ORDER BY media_categoria DESC;

-- Produtos mais vendidos em quantidade
-- Nesta consulta, a análise está voltada ao volume vendido,
-- por isso a métrica utilizada é a soma das quantidades.
SELECT
    pr.id_produto,
    pr.nome_produto,
    SUM(ip.quantidade) AS quantidade_vendida_produto
FROM produto pr
JOIN item_pedido ip
    ON pr.id_produto = ip.id_produto
JOIN pedido p
    ON ip.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY pr.id_produto, pr.nome_produto
ORDER BY quantidade_vendida_produto DESC;

-- Produtos que mais faturam
-- Aqui, o objetivo é identificar os produtos
-- com maior participação no faturamento.
SELECT
    pr.id_produto,
    pr.nome_produto,
    SUM(ip.subtotal_item) AS faturamento_produto
FROM produto pr
JOIN item_pedido ip
    ON pr.id_produto = ip.id_produto
JOIN pedido p
    ON ip.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY pr.id_produto, pr.nome_produto
ORDER BY faturamento_produto DESC;

-- Categorias com maior faturamento
-- Esta leitura retoma a análise por categoria,
-- agora organizada em formato de ranking.
SELECT
    c.nome_categoria,
    SUM(ip.subtotal_item) AS faturamento_categoria
FROM categoria c
JOIN produto pr
    ON c.id_categoria = pr.id_categoria
JOIN item_pedido ip
    ON ip.id_produto = pr.id_produto
JOIN pedido p
    ON ip.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY c.nome_categoria
ORDER BY faturamento_categoria DESC;

-- Marcas mais vendidas
-- Nesta consulta, a análise é feita diretamente por marca,
-- sem necessidade de passar pela categoria.
SELECT
    pr.marca,
    SUM(ip.subtotal_item) AS marcas_vendidas
FROM produto pr
JOIN item_pedido ip
    ON pr.id_produto = ip.id_produto
JOIN pedido p
    ON ip.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Faturado'
GROUP BY pr.marca
ORDER BY marcas_vendidas DESC;


-- 8. ANÁLISES GEOGRÁFICAS E DE SEGMENTAÇÃO
-- =========================================================

-- Cidades com maior faturamento
-- Para identificar o faturamento por cidade,
-- segui o relacionamento entre cidade, endereço, cliente e pedido.
SELECT
    ci.nome_cidade,
    ci.uf,
    SUM(p.valor_total) AS valor_cidade
FROM cidade ci
JOIN endereco e
    ON ci.id_cidade = e.id_cidade
JOIN cliente c
    ON c.id_endereco = e.id_endereco
JOIN pedido p
    ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY ci.nome_cidade, ci.uf
ORDER BY valor_cidade DESC;

-- Segmentos que mais compram
-- Aqui, a comparação entre segmentos é feita
-- pela quantidade de pedidos faturados.
SELECT
    c.segmento,
    COUNT(p.id_pedido) AS total_segmento
FROM cliente c
JOIN pedido p
    ON p.id_cliente = c.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY c.segmento
ORDER BY total_segmento DESC;

-- Segmentos que mais faturam
-- Complementando a análise anterior,
-- nesta consulta observo o valor total vendido por segmento.
SELECT
    c.segmento,
    SUM(p.valor_total) AS faturamento
FROM cliente c
JOIN pedido p
    ON c.id_cliente = p.id_cliente
WHERE p.status_pedido = 'Faturado'
GROUP BY c.segmento
ORDER BY faturamento DESC;
