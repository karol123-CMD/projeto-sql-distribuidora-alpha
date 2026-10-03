PRAGMA foreign_keys = ON;

CREATE TABLE cidade (
    id_cidade INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_cidade TEXT NOT NULL,
    uf TEXT NOT NULL CHECK (length(uf) = 2)
);

CREATE TABLE endereco (
    id_endereco INTEGER PRIMARY KEY AUTOINCREMENT,
    rua TEXT NOT NULL,
    numero TEXT NOT NULL,
    bairro TEXT NOT NULL,
    cep TEXT NOT NULL,
    id_cidade INTEGER NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

CREATE TABLE supervisor (
    id_supervisor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_supervisor TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    telefone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    id_endereco INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE vendedor (
    id_vendedor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_vendedor TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    telefone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    id_endereco INTEGER NOT NULL UNIQUE,
    id_supervisor INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_supervisor) REFERENCES supervisor(id_supervisor)
);

CREATE TABLE cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    razao_social TEXT NOT NULL,
    nome_fantasia TEXT NOT NULL,
    cnpj TEXT NOT NULL UNIQUE,
    segmento TEXT NOT NULL,
    telefone TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    data_cadastro TEXT NOT NULL CHECK (date(data_cadastro) IS NOT NULL),
    status_cliente TEXT NOT NULL CHECK (status_cliente IN ('Ativo', 'Inativo')),
    id_endereco INTEGER NOT NULL UNIQUE,
    id_vendedor INTEGER NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

CREATE TABLE categoria (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_categoria TEXT NOT NULL UNIQUE
);

CREATE TABLE produto (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_produto TEXT NOT NULL,
    marca TEXT NOT NULL,
    unidade_medida TEXT NOT NULL,
    preco_unitario REAL NOT NULL CHECK (preco_unitario >= 0),
    status_produto TEXT NOT NULL CHECK (status_produto IN ('Ativo', 'Inativo')),
    id_categoria INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE forma_de_pagamento (
    id_forma_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    descricao_forma_pagamento TEXT NOT NULL UNIQUE
);

CREATE TABLE pedido (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    data_pedido TEXT NOT NULL CHECK (date(data_pedido) IS NOT NULL),
    valor_total REAL NOT NULL CHECK (valor_total >= 0),
    status_pedido TEXT NOT NULL CHECK (status_pedido IN ('Faturado', 'Cancelado', 'Pendente')),
    id_cliente INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    id_forma_pagamento INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor),
    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_de_pagamento(id_forma_pagamento)
);

CREATE TABLE item_pedido (
    id_item_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario_item REAL NOT NULL CHECK (preco_unitario_item >= 0),
    subtotal_item REAL NOT NULL CHECK (subtotal_item >= 0),
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);
