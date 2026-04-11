PRAGMA foreign_keys = ON;


INSERT INTO cidade (id_cidade, nome_cidade, uf) VALUES
(1, 'Vitória da Conquista', 'BA'),
(2, 'Itapetinga', 'BA'),
(3, 'Jequié', 'BA'),
(4, 'Brumado', 'BA');

INSERT INTO endereco (id_endereco, rua, numero, bairro, cep, id_cidade) VALUES
(1,  'Av. Olívia Flores',   '1200', 'Candeias',        '45028-100', 1),
(2,  'Rua da Granja',       '85',   'Brasil',          '45051-000', 1),
(3,  'Rua das Acácias',     '210',  'Recreio',         '45020-320', 1),
(4,  'Av. Juracy Magalhães','450',  'Jurema',          '45023-490', 1),
(5,  'Rua A',               '34',   'Centro',          '45700-000', 2),
(6,  'Rua B',               '112',  'Primavera',       '45700-120', 2),
(7,  'Rua C',               '56',   'Centro',          '45200-000', 3),
(8,  'Rua D',               '900',  'Jequiezinho',     '45206-210', 3),
(9,  'Rua E',               '40',   'Centro',          '46100-000', 4),
(10, 'Rua F',               '78',   'São Félix',       '46100-120', 4),
(11, 'Rua Góes Calmon',     '210',  'Centro',          '45000-100', 1),
(12, 'Av. Alagoas',         '455',  'Ibirapuera',      '45075-210', 1),
(13, 'Rua do Cruzeiro',     '88',   'Centro',          '45700-090', 2),
(14, 'Rua da Feira',        '140',  'Nova Itapetinga', '45700-220', 2),
(15, 'Rua do Mercado',      '60',   'Centro',          '45200-120', 3),
(16, 'Av. Lomanto Júnior',  '900',  'Centro',          '45200-300', 3),
(17, 'Praça da Matriz',     '15',   'Centro',          '46100-050', 4),
(18, 'Av. Centenário',      '320',  'Olhos D''Água',   '46100-180', 4);

INSERT INTO supervisor (id_supervisor, nome_supervisor, cpf, telefone, email, id_endereco) VALUES
(1, 'Marcos Andrade', '11111111111', '77999990001', 'marcos.andrade@alpha.com', 1),
(2, 'Renata Souza',   '22222222222', '77999990002', 'renata.souza@alpha.com',   2);

INSERT INTO vendedor (id_vendedor, nome_vendedor, cpf, telefone, email, id_endereco, id_supervisor) VALUES
(1, 'Carlos Lima',     '33333333331', '77999991001', 'carlos.lima@alpha.com',     3, 1),
(2, 'Patrícia Gomes',  '33333333332', '77999991002', 'patricia.gomes@alpha.com',  4, 1),
(3, 'João Mendes',     '33333333333', '77999991003', 'joao.mendes@alpha.com',     5, 1),
(4, 'Fernanda Alves',  '33333333334', '77999991004', 'fernanda.alves@alpha.com',  6, 2),
(5, 'Lucas Rocha',     '33333333335', '77999991005', 'lucas.rocha@alpha.com',     7, 2),
(6, 'Bianca Santos',   '33333333336', '77999991006', 'bianca.santos@alpha.com',   8, 2);

INSERT INTO cliente (
    id_cliente,
    razao_social,
    nome_fantasia,
    cnpj,
    segmento,
    telefone,
    email,
    data_cadastro,
    status_cliente,
    id_endereco,
    id_vendedor
) VALUES
(1,  'Mercadinho Boa Compra Ltda',        'Boa Compra',           '10101010000101', 'Supermercado de Bairro', '7734210001', 'compras@boacompra.com',     '2024-01-10', 'Ativo',   9,  1),
(2,  'Padaria Pão Quente Ltda',           'Pão Quente',           '10101010000102', 'Padaria',                '7734210002', 'contato@paoquente.com',      '2024-02-15', 'Ativo',   10, 1),
(3,  'Lanchonete Sabor & Cia Ltda',       'Sabor & Cia',          '10101010000103', 'Lanchonete',             '7734210003', 'financeiro@saborecia.com',   '2024-03-08', 'Ativo',   11, 2),
(4,  'Restaurante Tempero Bom Ltda',      'Tempero Bom',          '10101010000104', 'Restaurante',            '7734210004', 'compras@temperobom.com',     '2024-04-12', 'Ativo',   12, 2),
(5,  'Conveniência Central Ltda',         'Central Conveniência', '10101010000105', 'Conveniência',           '7734210005', 'central@conv.com',           '2024-05-20', 'Ativo',   13, 3),
(6,  'Mercado Econômico Ltda',            'Econômico',            '10101010000106', 'Supermercado de Bairro', '7734210006', 'econ@mercado.com',           '2024-06-18', 'Ativo',   14, 4),
(7,  'Padaria Massa Nobre Ltda',          'Massa Nobre',          '10101010000107', 'Padaria',                '7734210007', 'massa@nobre.com',            '2024-07-22', 'Ativo',   15, 5),
(8,  'Restaurante Sabor Mineiro Ltda',    'Sabor Mineiro',        '10101010000108', 'Restaurante',            '7734210008', 'mineiro@rest.com',           '2024-08-30', 'Inativo', 16, 5),
(9,  'Mini Mercado Ideal Ltda',           'Ideal',                '10101010000109', 'Supermercado de Bairro', '7734210009', 'ideal@mercado.com',          '2024-09-05', 'Ativo',   17, 6),
(10, 'Lanchonete Ponto Certo Ltda',       'Ponto Certo',          '10101010000110', 'Lanchonete',             '7734210010', 'contato@pontocerto.com',     '2024-10-01', 'Ativo',   18, 6);

INSERT INTO categoria (id_categoria, nome_categoria) VALUES
(1, 'Mercearia Seca'),
(2, 'Bebidas'),
(3, 'Biscoitos e Snacks'),
(4, 'Enlatados e Conservas'),
(5, 'Laticínios Básicos');

INSERT INTO produto (
    id_produto,
    nome_produto,
    marca,
    unidade_medida,
    preco_unitario,
    status_produto,
    id_categoria
) VALUES
(1,  'Arroz Tipo 1 5kg',              'Bom Grão',   'UN', 24.90, 'Ativo', 1),
(2,  'Feijão Carioca 1kg',            'Campo Nobre','UN',  8.50, 'Ativo', 1),
(3,  'Macarrão Espaguete 500g',       'Saborita',   'UN',  4.20, 'Ativo', 1),
(4,  'Açúcar Cristal 1kg',            'Doce Vida',  'UN',  4.90, 'Ativo', 1),
(5,  'Água Mineral 500ml',            'Fonte Leve', 'UN',  1.80, 'Ativo', 2),
(6,  'Refrigerante Cola 2L',          'Refrix',     'UN',  8.99, 'Ativo', 2),
(7,  'Suco de Uva 1L',                'Frutal',     'UN',  7.50, 'Ativo', 2),
(8,  'Biscoito Cream Cracker 400g',   'Croki',      'UN',  5.30, 'Ativo', 3),
(9,  'Salgadinho de Milho 90g',       'Snakitos',   'UN',  3.20, 'Ativo', 3),
(10, 'Milho Verde 200g',              'Da Terra',   'UN',  3.80, 'Ativo', 4),
(11, 'Molho de Tomate 300g',          'Tomatino',   'UN',  2.90, 'Ativo', 4),
(12, 'Leite Integral 1L',             'ValeLeite',  'UN',  5.60, 'Ativo', 5);

INSERT INTO forma_de_pagamento (id_forma_pagamento, descricao_forma_pagamento) VALUES
(1, 'À vista'),
(2, 'Pix'),
(3, 'Boleto 14 dias'),
(4, 'Boleto 28 dias');

INSERT INTO pedido (
    id_pedido,
    data_pedido,
    valor_total,
    status_pedido,
    id_cliente,
    id_vendedor,
    id_forma_pagamento
) VALUES
(1,  '2025-01-05', 103.60, 'Faturado',  1, 1, 2),
(2,  '2025-01-08',  89.70, 'Faturado',  2, 1, 1),
(3,  '2025-01-15', 121.10, 'Faturado',  3, 2, 3),
(4,  '2025-02-03', 147.40, 'Faturado',  4, 2, 4),
(5,  '2025-02-10',  96.50, 'Faturado',  5, 3, 2),
(6,  '2025-02-14', 133.80, 'Faturado',  6, 4, 3),
(7,  '2025-03-02', 118.20, 'Faturado',  7, 5, 1),
(8,  '2025-03-06',  74.76, 'Cancelado', 7, 5, 4),
(9,  '2025-03-10', 159.60, 'Faturado',  9, 6, 2),
(10, '2025-03-18', 111.40, 'Faturado', 10, 6, 3),
(11, '2025-04-04', 182.70, 'Faturado',  1, 1, 4),
(12, '2025-04-09', 128.90, 'Faturado',  6, 4, 2),
(13, '2025-04-20',  65.00, 'Pendente',  4, 2, 1);

INSERT INTO item_pedido (
    id_item_pedido,
    quantidade,
    preco_unitario_item,
    subtotal_item,
    id_pedido,
    id_produto
) VALUES
(1,  2, 24.90, 49.80, 1,  1),
(2,  4,  8.50, 34.00, 1,  2),
(3,  4,  4.95, 19.80, 1,  4),
(4,  6,  5.30, 31.80, 2,  8),
(5,  5,  3.20, 16.00, 2,  9),
(6,  7,  5.60, 39.20, 2, 12),
(7,  1,  2.70,  2.70, 2, 11),
(8,  10, 4.20, 42.00, 3,  3),
(9,   6, 7.50, 45.00, 3,  7),
(10,  7, 4.30, 30.10, 3,  4),
(11,  1, 4.00,  4.00, 3, 10),
(12,  5, 24.90, 124.50, 4, 1),
(13,  3,  7.50,  22.50, 4, 7),
(14,  1,  0.40,   0.40, 4, 5),
(15,  8, 1.80, 14.40, 5,  5),
(16,  6, 8.99, 53.94, 5,  6),
(17,  8, 3.20, 25.60, 5,  9),
(18,  1, 2.56,  2.56, 5, 10),
(19, 12, 8.50, 102.00, 6, 2),
(20,  6, 5.30,  31.80, 6, 8),
(21, 10, 5.60, 56.00, 7, 12),
(22, 12, 3.80, 45.60, 7, 10),
(23,  4, 4.15, 16.60, 7,  3),
(24,  4, 8.99, 35.96, 8, 6),
(25,  8, 4.85, 38.80, 8, 4),
(26,  4, 24.90, 99.60, 9,  1),
(27,  6,  5.60, 33.60, 9, 12),
(28,  6,  4.40, 26.40, 9,  3),
(29, 10, 2.90, 29.00, 10, 11),
(30,  8, 5.30, 42.40, 10, 8),
(31, 10, 4.00, 40.00, 10, 10),
(32,  3, 24.90, 74.70, 11, 1),
(33,  6,  8.50, 51.00, 11, 2),
(34,  4,  8.99, 35.96, 11, 6),
(35,  6,  3.20, 19.20, 11, 9),
(36,  1,  1.84,  1.84, 11, 5),
(37,  5, 7.50, 37.50, 12,  7),
(38,  8, 5.60, 44.80, 12, 12),
(39,  8, 5.30, 42.40, 12,  8),
(40,  1, 4.20,  4.20, 12,  3),
(41,  5, 5.30, 26.50, 13, 8),
(42,  5, 3.80, 19.00, 13, 10),
(43,  5, 3.90, 19.50, 13, 4);

