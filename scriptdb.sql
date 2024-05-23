--------------------------------------------------------------------------------------------------
-- 1.CRIAÇÃO DAS BANCO DE DADOS
--------------------------------------------------------------------------------------------------

CREATE DATABASE EcommerceDB;

--------------------------------------------------------------------------------------------------
-- 2.CRIAÇÃO DAS TABELAS
--------------------------------------------------------------------------------------------------

-- 2.Clientes
CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

-- Categorias
CREATE TABLE Categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

-- Produtos
CREATE TABLE Produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

-- Pedidos
CREATE TABLE Pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE NOT NULL,
    status VARCHAR(20),
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Itens_Pedido
CREATE TABLE Itens_Pedido (
    item_pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Pagamentos
CREATE TABLE Pagamentos (
    pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    data_pagamento DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id)
);

-- Fornecedores
CREATE TABLE Fornecedores (
    fornecedor_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

-- Compras
CREATE TABLE Compras (
    compra_id INT AUTO_INCREMENT PRIMARY KEY,
    fornecedor_id INT,
    data_compra DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedores(fornecedor_id)
);

-- Itens_Compra
CREATE TABLE Itens_Compra (
    item_compra_id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (compra_id) REFERENCES Compras(compra_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Transportadoras
CREATE TABLE Transportadoras (
    transportadora_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    endereco VARCHAR(255),
    telefone VARCHAR(20)
);

-- Envios
CREATE TABLE Envios (
    envio_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    transportadora_id INT,
    data_envio DATE NOT NULL,
    data_entrega DATE,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (transportadora_id) REFERENCES Transportadoras(transportadora_id)
);

-- Avaliacoes
CREATE TABLE Avaliacoes (
    avaliacao_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Cupons
CREATE TABLE Cupons (
    cupom_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    desconto DECIMAL(5, 2) NOT NULL,
    data_validade DATE NOT NULL
);

-- Pedidos_Cupons
CREATE TABLE Pedidos_Cupons (
    pedido_cupom_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    cupom_id INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (cupom_id) REFERENCES Cupons(cupom_id)
);

-- Estoque
CREATE TABLE Estoque (
    estoque_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    localizacao VARCHAR(100),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Devolucoes
CREATE TABLE Devolucoes (
    devolucao_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    data_devolucao DATE NOT NULL,
    motivo TEXT,
    quantidade INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Categorias_Pais
CREATE TABLE Categorias_Pais (
    categoria_pais_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

-- Categorias_Subcategorias
CREATE TABLE Categorias_Subcategorias (
    categoria_id INT,
    categoria_pais_id INT,
    PRIMARY KEY (categoria_id, categoria_pais_id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id),
    FOREIGN KEY (categoria_pais_id) REFERENCES Categorias_Pais(categoria_pais_id)
);

-- Enderecos_Clientes
CREATE TABLE Enderecos_Clientes (
    endereco_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    cep VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Metodos_Pagamento
CREATE TABLE Metodos_Pagamento (
    metodo_id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100)
);

-- Cartoes_Credito
CREATE TABLE Cartoes_Credito (
    cartao_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    numero_cartao VARCHAR(20) NOT NULL,
    nome_titular VARCHAR(100) NOT NULL,
    data_validade DATE NOT NULL,
    codigo_seguranca VARCHAR(10) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Carrinhos
CREATE TABLE Carrinhos (
    carrinho_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_criacao DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Itens_Carrinho
CREATE TABLE Itens_Carrinho (
    item_carrinho_id INT AUTO_INCREMENT PRIMARY KEY,
    carrinho_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (carrinho_id) REFERENCES Carrinhos(carrinho_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Favoritos
CREATE TABLE Favoritos (
    favorito_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto_id INT,
    data_adicao DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);


-- Logs_Acesso
CREATE TABLE Logs_Acesso (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_acesso TIMESTAMP NOT NULL,
    ip_acesso VARCHAR(45),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Mensagens
CREATE TABLE Mensagens (
    mensagem_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Notificacoes
CREATE TABLE Notificacoes (
    notificacao_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Reembolsos
CREATE TABLE Reembolsos (
    reembolso_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    data_reembolso DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    motivo TEXT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id)
);

-- Enderecos_Transportadoras
CREATE TABLE Enderecos_Transportadoras (
    endereco_id INT AUTO_INCREMENT PRIMARY KEY,
    transportadora_id INT,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(100),
    cep VARCHAR(20),
    FOREIGN KEY (transportadora_id) REFERENCES Transportadoras(transportadora_id)
);

-- Logs_Envios
CREATE TABLE Logs_Envios (
    log_envio_id INT AUTO_INCREMENT PRIMARY KEY,
    envio_id INT,
    data_log TIMESTAMP NOT NULL,
    descricao TEXT,
    FOREIGN KEY (envio_id) REFERENCES Envios(envio_id)
);

-- Historico_Pedidos
CREATE TABLE Historico_Pedidos (
    historico_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    data_status TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id)
);

-- Categorias_Produtos
CREATE TABLE Categorias_Produtos (
    categoria_id INT,
    produto_id INT,
    PRIMARY KEY (categoria_id, produto_id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

-- Descontos_Produtos
CREATE TABLE Descontos_Produtos (
    desconto_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    percentual_desconto DECIMAL(5, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

CREATE TABLE Logs_Transacoes (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    transacao_tipo VARCHAR(50) NOT NULL,
    entidade_id INT,
    data_hora TIMESTAMP NOT NULL,
    descricao TEXT
);

-- Modificação da tabela Logs_Transacoes com chave estrangeira
ALTER TABLE Logs_Transacoes
ADD COLUMN cliente_id INT,
ADD FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id);

CREATE TABLE Entidades (
    entidade_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_entidade VARCHAR(100) NOT NULL,
    tipo_entidade VARCHAR(50)
);

-- Modificação da tabela Logs_Transacoes
ALTER TABLE Logs_Transacoes
ADD COLUMN entidade_id INT,
ADD FOREIGN KEY (entidade_id) REFERENCES Entidades(entidade_id);



CREATE TABLE Perfis_Usuarios (
    perfil_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    preferencia_json JSON,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

CREATE TABLE Historico_Precos (
    historico_preco_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    preco_anterior DECIMAL(10, 2) NOT NULL,
    preco_novo DECIMAL(10, 2) NOT NULL,
    data_alteracao DATE NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

CREATE TABLE Historico_Estoque (
    historico_estoque_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade_anterior INT NOT NULL,
    quantidade_nova INT NOT NULL,
    data_alteracao DATE NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

CREATE TABLE Promocoes (
    promocao_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Promocoes_Produtos (
    promocao_id INT,
    produto_id INT,
    PRIMARY KEY (promocao_id, produto_id),
    FOREIGN KEY (promocao_id) REFERENCES Promocoes(promocao_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

CREATE TABLE Historico_Pagamentos (
    historico_pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    pagamento_id INT,
    data_pagamento TIMESTAMP NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    FOREIGN KEY (pagamento_id) REFERENCES Pagamentos(pagamento_id)
);

--------------------------------------------------------------------------------------------------
-- 3.INSERÇÃO DOS DADOS
--------------------------------------------------------------------------------------------------

-- Inserts
INSERT INTO Clientes (nome, email, data_nascimento, endereco, telefone)
VALUES
('João Silva', 'joao@example.com', '1990-05-15', 'Rua A, 123', '(11) 98765-4321'),
('Maria Santos', 'maria@example.com', '1985-10-20', 'Av. B, 456', '(21) 98765-1234'),
('Pedro Oliveira', 'pedro@example.com', '1992-03-08', 'Rua C, 789', '(31) 98765-5678'),
('Ana Souza', 'ana@example.com', '1988-12-12', 'Rua D, 321', '(41) 98765-8765'),
('Carlos Ferreira', 'carlos@example.com', '1995-07-25', 'Av. E, 654', '(51) 98765-2345'),
('Juliana Lima', 'juliana@example.com', '1993-02-18', 'Rua F, 987', '(62) 98765-6789'),
('Lucas Martins', 'lucas@example.com', '1990-09-03', 'Av. G, 234', '(71) 98765-5432'),
('Camila Rocha', 'camila@example.com', '1987-06-30', 'Rua H, 876', '(81) 98765-9876'),
('Mariana Costa', 'mariana@example.com', '1991-04-21', 'Av. I, 345', '(91) 98765-3456'),
('Rafael Almeida', 'rafael@example.com', '1984-11-14', 'Rua J, 678', '(32) 98765-6543'),
('Fernanda Oliveira', 'fernanda@example.com', '1994-08-07', 'Av. K, 987', '(12) 98765-8765'),
('Gabriel Santos', 'gabriel@example.com', '1997-01-26', 'Rua L, 210', '(82) 98765-2345'),
('Laura Pereira', 'laura@example.com', '1989-07-01', 'Av. M, 543', '(92) 98765-6789'),
('Diego Costa', 'diego@example.com', '1993-05-12', 'Rua N, 876', '(42) 98765-5432'),
('Carolina Lima', 'carolina@example.com', '1986-03-17', 'Av. O, 234', '(61) 98765-9876'),
('Thiago Oliveira', 'thiago@example.com', '1990-12-08', 'Rua P, 345', '(31) 98765-3456'),
('Patrícia Silva', 'patricia@example.com', '1983-09-24', 'Av. Q, 678', '(21) 98765-6543'),
('Luciana Fernandes', 'luciana@example.com', '1995-04-03', 'Rua R, 987', '(82) 98765-8765'),
('Rodrigo Pereira', 'rodrigo@example.com', '1988-02-15', 'Av. S, 210', '(92) 98765-2345'),
('Isabela Martins', 'isabela@example.com', '1992-10-29', 'Rua T, 543', '(42) 98765-6789');

INSERT INTO Categorias (nome, descricao)
VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Moda', 'Roupas, acessórios e calçados'),
('Decoração', 'Artigos de decoração para casa'),
('Alimentos', 'Produtos alimentícios e bebidas'),
('Esportes', 'Equipamentos e acessórios esportivos'),
('Livros', 'Livros de diversos gêneros'),
('Beleza', 'Produtos de beleza e cuidados pessoais'),
('Brinquedos', 'Brinquedos para crianças e bebês'),
('Móveis', 'Móveis para casa e escritório'),
('Jardinagem', 'Utensílios e ferramentas para jardinagem');
INSERT INTO Categorias (nome, descricao)
VALUES
('Ferramentas', 'Diversos tipos de ferramentas manuais e elétricas'),
('Cosméticos', 'Produtos de cuidados pessoais e beleza'),
('Perfumes', 'Fragrâncias masculinas e femininas'),
('Bebês', 'Produtos para bebês e crianças pequenas'),
('Escolar', 'Materiais escolares e artigos de papelaria'),
('Outros Eletrônicos', 'Outros produtos eletrônicos'),
('Acessórios', 'Diversos tipos de acessórios'),
('Informática', 'Produtos relacionados à informática e tecnologia'),
('Outros Esportes', 'Outros equipamentos esportivos'),
('Outros Móveis', 'Outros móveis para casa e escritório');

INSERT INTO Produtos (nome, descricao, preco, estoque, categoria_id)
VALUES
('Smartphone Samsung Galaxy S20', 'Smartphone top de linha com câmera de 64MP', 2999.99, 50, 1),
('Notebook Dell Inspiron 15', 'Notebook com processador Core i5 e 8GB de RAM', 3499.99, 30, 1),
('Camiseta Polo Lacoste', 'Camiseta Polo de algodão piqué', 129.99, 100, 2),
('Vaso Decorativo Cerâmica', 'Vaso decorativo para plantas', 79.99, 200, 3),
('Cerveja Artesanal IPA', 'Cerveja artesanal estilo India Pale Ale', 19.99, 500, 4),
('Bola de Futebol Nike', 'Bola oficial Nike para futebol', 79.99, 50, 5),
('Livro "O Príncipe" - Maquiavel', 'Livro clássico sobre política', 29.99, 80, 6),
('Shampoo Pantene 400ml', 'Shampoo para cabelos danificados', 15.99, 150, 7),
('Boneca Barbie', 'Boneca Barbie com acessórios', 99.99, 30, 8),
('Sofá Retrátil Reclinável', 'Sofá com assentos retráteis e encosto reclinável', 1999.99, 20, 9),
('Kit Ferramentas Jardinagem', 'Kit completo de ferramentas para jardinagem', 149.99, 10, 10);

INSERT INTO Produtos (nome, descricao, preco, estoque, categoria_id)
VALUES
('Smart TV Samsung 55"', 'TV 4K com tecnologia HDR', 2999.99, 20, 1),
('Tênis Nike Air Max', 'Tênis esportivo com tecnologia de amortecimento', 399.99, 50, 5),
('Perfume Chanel No. 5', 'Perfume clássico com fragrância floral', 199.99, 100, 3),
('Fraldas Pampers Premium Care', 'Fraldas descartáveis para bebês', 59.99, 200, 4),
('Conjunto Escolar Completo', 'Kit escolar com mochila, estojo e material', 79.99, 150, 5),
('Monitor Dell Ultrasharp 27"', 'Monitor IPS com resolução QHD', 599.99, 30, 8),
('Pulseira de Prata com Diamantes', 'Jóia de prata com detalhes em diamantes', 999.99, 10, 7),
('Teclado Mecânico Gamer RGB', 'Teclado mecânico para jogos com iluminação RGB', 149.99, 20, 8),
('Bicicleta Mountain Bike', 'Bicicleta para trilhas e aventuras off-road', 799.99, 15, 10),
('Cadeira Executiva Ergonômica', 'Cadeira de escritório com design ergonômico', 299.99, 25, 9);

-- Inserções para os primeiros 10 pedidos (clientes de 1 a 5)
INSERT INTO Pedidos (cliente_id, data_pedido, status, valor_total)
VALUES
(1, '2024-05-10', 'Em processamento', 399.99),
(2, '2024-05-11', 'Aguardando pagamento', 199.99),
(3, '2024-05-12', 'Enviado', 59.99),
(4, '2024-05-13', 'Concluído', 799.99),
(5, '2024-05-14', 'Em processamento', 599.99),
(1, '2024-05-15', 'Aguardando envio', 149.99),
(2, '2024-05-16', 'Em processamento', 2999.99),
(3, '2024-05-17', 'Concluído', 999.99),
(4, '2024-05-18', 'Aguardando pagamento', 399.99),
(5, '2024-05-19', 'Enviado', 79.99);

-- Inserções para os próximos 10 pedidos (clientes de 6 a 10)
INSERT INTO Pedidos (cliente_id, data_pedido, status, valor_total)
VALUES
(6, '2024-05-20', 'Em processamento', 499.99),
(7, '2024-05-21', 'Aguardando pagamento', 299.99),
(8, '2024-05-22', 'Concluído', 199.99),
(9, '2024-05-23', 'Aguardando envio', 899.99),
(10, '2024-05-24', 'Em processamento', 349.99),
(6, '2024-05-25', 'Concluído', 599.99),
(7, '2024-05-26', 'Aguardando pagamento', 129.99),
(8, '2024-05-27', 'Enviado', 999.99),
(9, '2024-05-28', 'Em processamento', 449.99),
(10, '2024-05-29', 'Aguardando pagamento', 349.99);

-- Inserções para os próximos 10 pedidos (clientes de 11 a 20)
INSERT INTO Pedidos (cliente_id, data_pedido, status, valor_total)
VALUES
(11, '2024-05-30', 'Em processamento', 799.99),
(12, '2024-06-01', 'Aguardando pagamento', 399.99),
(13, '2024-06-02', 'Concluído', 199.99),
(14, '2024-06-03', 'Aguardando envio', 899.99),
(15, '2024-06-04', 'Em processamento', 349.99),
(11, '2024-06-05', 'Concluído', 599.99),
(12, '2024-06-06', 'Aguardando pagamento', 129.99),
(13, '2024-06-07', 'Enviado', 999.99),
(14, '2024-06-08', 'Em processamento', 449.99),
(15, '2024-06-09', 'Aguardando pagamento', 349.99),
(16, '2024-06-10', 'Em processamento', 499.99),
(17, '2024-06-11', 'Aguardando pagamento', 299.99),
(18, '2024-06-12', 'Concluído', 199.99),
(19, '2024-06-13', 'Aguardando envio', 899.99),
(20, '2024-06-14', 'Em processamento', 349.99),
(16, '2024-06-15', 'Concluído', 599.99),
(17, '2024-06-16', 'Aguardando pagamento', 129.99),
(18, '2024-06-17', 'Enviado', 999.99),
(19, '2024-06-18', 'Em processamento', 449.99),
(20, '2024-06-19', 'Aguardando pagamento', 349.99);


-- Inserções na tabela Itens_Pedido
INSERT INTO Itens_Pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
(1, 1, 2, 199.99),
(1, 3, 1, 59.99),
(2, 2, 1, 399.99),
(2, 4, 3, 79.99),
(3, 5, 2, 599.99),
(3, 1, 1, 199.99),
(4, 4, 2, 399.99),
(4, 2, 1, 199.99),
(5, 3, 1, 59.99),
(5, 5, 4, 239.96),
(6, 1, 3, 599.97),
(6, 2, 1, 399.99),
(7, 3, 2, 119.98),
(7, 4, 1, 199.99),
(8, 5, 1, 59.99),
(8, 1, 2, 399.98),
(9, 2, 1, 399.99),
(9, 3, 3, 179.97),
(10, 4, 1, 199.99),
(10, 5, 2, 119.98),
(11, 1, 1, 199.99),
(11, 2, 2, 799.98),
(12, 3, 1, 59.99),
(12, 4, 1, 199.99),
(13, 5, 3, 179.97),
(13, 1, 2, 399.98),
(14, 2, 1, 399.99),
(14, 3, 2, 119.98),
(15, 4, 1, 199.99),
(15, 5, 1, 59.99),
(16, 1, 3, 599.97),
(16, 2, 1, 399.99),
(17, 3, 1, 59.99),
(17, 4, 2, 399.98),
(18, 5, 1, 59.99),
(18, 1, 2, 399.98),
(19, 2, 1, 399.99),
(19, 3, 3, 179.97),
(20, 4, 1, 199.99),
(20, 5, 2, 119.98);

-- Inserções na tabela Pagamentos
-- Inserções na tabela Pagamentos (continuação)
INSERT INTO Pagamentos (pedido_id, data_pagamento, valor, metodo_pagamento)
VALUES
(20, '2024-05-29', 499.96, 'Cartão de débito'),
(1, '2024-05-30', 799.98, 'Cartão de crédito'),
(2, '2024-06-01', 399.98, 'Boleto bancário'),
(3, '2024-06-02', 999.97, 'Pix'),
(4, '2024-06-03', 999.97, 'Transferência bancária'),
(5, '2024-06-04', 399.96, 'Cartão de débito'),
(6, '2024-06-05', 999.96, 'Cartão de crédito'),
(7, '2024-06-06', 129.99, 'Boleto bancário'),
(8, '2024-06-07', 899.96, 'Pix'),
(9, '2024-06-08', 449.97, 'Transferência bancária'),
(10, '2024-06-09', 349.98, 'Cartão de débito'),
(11, '2024-06-10', 499.99, 'Cartão de crédito'),
(12, '2024-06-11', 199.99, 'Boleto bancário'),
(13, '2024-06-12', 239.96, 'Pix'),
(14, '2024-06-13', 599.97, 'Transferência bancária'),
(15, '2024-06-14', 419.97, 'Cartão de débito'),
(16, '2024-06-15', 999.96, 'Cartão de crédito'),
(17, '2024-06-16', 129.99, 'Boleto bancário'),
(18, '2024-06-17', 999.97, 'Pix'),
(19, '2024-06-18', 629.97, 'Transferência bancária'),
(20, '2024-06-19', 499.96, 'Cartão de débito');

-- Inserções na tabela Fornecedores
INSERT INTO Fornecedores (nome, contato, endereco, telefone)
VALUES
('Fornecedor A', 'João Silva', 'Rua dos Fornecedores, 123', '(11) 98765-4321'),
('Fornecedor B', 'Maria Souza', 'Av. das Indústrias, 456', '(11) 12345-6789'),
('Fornecedor C', 'Carlos Oliveira', 'Travessa dos Comerciantes, 789', '(11) 54321-9876'),
('Fornecedor D', 'Ana Pereira', 'R. dos Produtores, 321', '(11) 45678-1234'),
('Fornecedor E', 'José Santos', 'Av. das Vendas, 654', '(11) 87654-3210'),
('Fornecedor F', 'Mariana Costa', 'R. das Mercadorias, 987', '(11) 23456-7890'),
('Fornecedor G', 'Pedro Carvalho', 'Av. dos Fornecedores, 234', '(11) 76543-2109'),
('Fornecedor H', 'Amanda Rocha', 'R. das Indústrias, 789', '(11) 98765-4321'),
('Fornecedor I', 'Lucas Oliveira', 'Travessa das Empresas, 987', '(11) 12345-6789'),
('Fornecedor J', 'Camila Santos', 'R. das Negociações, 654', '(11) 54321-9876'),
('Fornecedor K', 'Gabriel Silva', 'Av. dos Produtos, 321', '(11) 45678-1234'),
('Fornecedor L', 'Carolina Pereira', 'R. das Vendas, 654', '(11) 87654-3210'),
('Fornecedor M', 'Fernando Costa', 'Av. dos Comerciantes, 234', '(11) 23456-7890'),
('Fornecedor N', 'Isabela Carvalho', 'R. dos Fornecedores, 789', '(11) 76543-2109'),
('Fornecedor O', 'Rafael Rocha', 'Av. das Indústrias, 987', '(11) 98765-4321'),
('Fornecedor P', 'Luiza Oliveira', 'Travessa dos Empresários, 987', '(11) 12345-6789'),
('Fornecedor Q', 'Marcos Santos', 'R. das Negociações, 654', '(11) 54321-9876'),
('Fornecedor R', 'Beatriz Silva', 'Av. dos Produtores, 321', '(11) 45678-1234'),
('Fornecedor S', 'Thiago Pereira', 'R. das Vendas, 654', '(11) 87654-3210'),
('Fornecedor T', 'Laura Costa', 'Av. dos Comerciantes, 234', '(11) 23456-7890'),
('Fornecedor U', 'Guilherme Carvalho', 'R. dos Fornecedores, 789', '(11) 76543-2109'),
('Fornecedor V', 'Juliana Rocha', 'Av. das Indústrias, 987', '(11) 98765-4321'),
('Fornecedor W', 'Ricardo Oliveira', 'Travessa dos Empresários, 987', '(11) 12345-6789'),
('Fornecedor X', 'Patrícia Santos', 'R. das Negociações, 654', '(11) 54321-9876'),
('Fornecedor Y', 'Rodrigo Silva', 'Av. dos Produtores, 321', '(11) 45678-1234'),
('Fornecedor Z', 'Marina Pereira', 'R. das Vendas, 654', '(11) 87654-3210');

-- Inserções na tabela Compras
INSERT INTO Compras (fornecedor_id, data_compra, valor_total)
VALUES
(1, '2024-05-25', 1500.00),
(2, '2024-05-26', 2500.00),
(3, '2024-05-27', 1800.00),
(4, '2024-05-28', 3000.00),
(5, '2024-05-29', 2000.00),
(6, '2024-05-30', 2800.00),
(7, '2024-05-31', 2200.00),
(8, '2024-06-01', 1950.00),
(9, '2024-06-02', 1750.00),
(10, '2024-06-03', 3000.00),
(11, '2024-06-04', 2100.00),
(12, '2024-06-05', 2800.00),
(13, '2024-06-06', 1500.00),
(14, '2024-06-07', 2200.00),
(15, '2024-06-08', 2600.00),
(16, '2024-06-09', 1750.00),
(17, '2024-06-10', 1950.00),
(18, '2024-06-11', 3100.00),
(19, '2024-06-12', 1850.00),
(20, '2024-06-13', 2400.00);

-- Inserções na tabela Itens_Compra
INSERT INTO Itens_Compra (compra_id, produto_id, quantidade, preco_unitario)
VALUES
(1, 1, 10, 50.00),
(1, 2, 5, 30.00),
(2, 3, 8, 45.00),
(2, 4, 12, 60.00),
(3, 5, 15, 40.00),
(3, 6, 7, 35.00),
(4, 7, 20, 50.00),
(4, 8, 10, 65.00),
(5, 9, 12, 55.00),
(5, 10, 6, 40.00),
(6, 11, 18, 50.00),
(6, 12, 9, 55.00),
(7, 13, 10, 48.00),
(7, 14, 15, 42.00),
(8, 15, 12, 58.00),
(8, 16, 8, 70.00),
(9, 17, 20, 45.00),
(9, 18, 10, 60.00),
(10, 19, 15, 42.00),
(10, 20, 7, 38.00),
(11, 1, 10, 48.00),
(11, 2, 5, 36.00),
(12, 3, 8, 50.00),
(12, 4, 12, 65.00),
(13, 5, 15, 40.00),
(13, 6, 7, 35.00),
(14, 7, 20, 52.00),
(14, 8, 10, 68.00),
(15, 9, 12, 55.00),
(15, 10, 6, 42.00),
(16, 11, 18, 52.00),
(16, 12, 9, 57.00),
(17, 13, 10, 45.00),
(17, 14, 15, 40.00),
(18, 15, 12, 60.00),
(18, 16, 8, 70.00),
(19, 17, 20, 45.00),
(19, 18, 10, 58.00),
(20, 19, 15, 42.00),
(20, 20, 7, 38.00);

-- Inserções na tabela Transportadoras
INSERT INTO Transportadoras (nome, contato, endereco, telefone)
VALUES
('Transportadora A', 'Carlos Silva', 'Av. das Entregas, 123', '(11) 12345-6789'),
('Transportadora B', 'Ana Souza', 'Rua das Logísticas, 456', '(11) 98765-4321'),
('Transportadora C', 'Márcio Oliveira', 'Alameda dos Envios, 789', '(11) 23456-7890'),
('Transportadora D', 'Juliana Santos', 'Av. dos Despachos, 321', '(11) 87654-3210'),
('Transportadora E', 'Lucas Costa', 'Praça das Entregas, 654', '(11) 34567-8901'),
('Transportadora F', 'Carolina Pereira', 'R. das Logísticas, 987', '(11) 65432-1098'),
('Transportadora G', 'Roberto Oliveira', 'Av. dos Envios, 654', '(11) 89012-3456'),
('Transportadora H', 'Patrícia Lima', 'Rua dos Despachos, 321', '(11) 21098-7654'),
('Transportadora I', 'Daniel Fernandes', 'Praça das Entregas, 987', '(11) 56789-0123'),
('Transportadora J', 'Amanda Vieira', 'Alameda dos Envios, 456', '(11) 43210-9876'),
('Transportadora K', 'Gustavo Santos', 'Av. dos Despachos, 789', '(11) 67890-1234'),
('Transportadora L', 'Larissa Oliveira', 'Rua das Entregas, 654', '(11) 90123-4567'),
('Transportadora M', 'Rafael Lima', 'Praça dos Despachos, 321', '(11) 34567-8901'),
('Transportadora N', 'Mariana Vieira', 'Alameda das Logísticas, 987', '(11) 78901-2345'),
('Transportadora O', 'Pedro Fernandes', 'Av. dos Envios, 654', '(11) 10987-6543'),
('Transportadora P', 'Fernanda Costa', 'Rua dos Despachos, 321', '(11) 98765-4321'),
('Transportadora Q', 'Bruno Santos', 'Praça das Entregas, 987', '(11) 56789-0123'),
('Transportadora R', 'Vanessa Vieira', 'Alameda dos Envios, 456', '(11) 43210-9876'),
('Transportadora S', 'Diego Fernandes', 'Av. dos Despachos, 789', '(11) 67890-1234'),
('Transportadora Z', 'Dinis Fernandes', 'Av. dos Despachos, 790', '(11) 67890-1334');

-- Inserções na tabela Envios
INSERT INTO Envios (pedido_id, transportadora_id, data_envio, data_entrega)
VALUES
(1, 1, '2024-05-25', '2024-05-28'),
(2, 2, '2024-05-26', '2024-05-29'),
(3, 3, '2024-05-27', '2024-05-30'),
(4, 4, '2024-05-28', '2024-05-31'),
(5, 5, '2024-05-29', '2024-06-01'),
(6, 6, '2024-05-30', '2024-06-02'),
(7, 7, '2024-05-31', '2024-06-03'),
(8, 8, '2024-06-01', '2024-06-04'),
(9, 9, '2024-06-02', '2024-06-05'),
(10, 10, '2024-06-03', '2024-06-06'),
(11, 11, '2024-06-04', '2024-06-07'),
(12, 12, '2024-06-05', '2024-06-08'),
(13, 13, '2024-06-06', '2024-06-09'),
(14, 14, '2024-06-07', '2024-06-10'),
(15, 15, '2024-06-08', '2024-06-11'),
(16, 16, '2024-06-09', '2024-06-12'),
(17, 17, '2024-06-10', '2024-06-13'),
(18, 18, '2024-06-11', '2024-06-14'),
(19, 19, '2024-06-12', '2024-06-15'),
(20, 20, '2024-06-13', '2024-06-16');

-- Inserções na tabela Envios
INSERT INTO Envios (pedido_id, transportadora_id, data_envio, data_entrega)
VALUES
(1, 1, '2024-05-25', '2024-05-28'),
(2, 2, '2024-05-26', '2024-05-29'),
(3, 3, '2024-05-27', '2024-05-30'),
(4, 4, '2024-05-28', '2024-05-31'),
(5, 5, '2024-05-29', '2024-06-01'),
(6, 6, '2024-05-30', '2024-06-02'),
(7, 7, '2024-05-31', '2024-06-03'),
(8, 8, '2024-06-01', '2024-06-04'),
(9, 9, '2024-06-02', '2024-06-05'),
(10, 10, '2024-06-03', '2024-06-06'),
(11, 11, '2024-06-04', '2024-06-07'),
(12, 12, '2024-06-05', '2024-06-08'),
(13, 13, '2024-06-06', '2024-06-09'),
(14, 14, '2024-06-07', '2024-06-10'),
(15, 15, '2024-06-08', '2024-06-11'),
(16, 16, '2024-06-09', '2024-06-12'),
(17, 17, '2024-06-10', '2024-06-13'),
(18, 18, '2024-06-11', '2024-06-14'),
(19, 19, '2024-06-12', '2024-06-15'),
(20, 20, '2024-06-13', '2024-06-16');

-- Inserções na tabela Avaliacoes
INSERT INTO Avaliacoes (cliente_id, produto_id, nota, comentario, data_avaliacao)
VALUES
(1, 1, 5, 'Ótimo produto, recomendo!', '2024-05-10'),
(2, 2, 4, 'Boa qualidade, entrega rápida.', '2024-05-12'),
(3, 3, 3, 'Produto satisfatório, poderia melhorar.', '2024-05-15'),
(4, 4, 5, 'Excelente atendimento, produto de qualidade.', '2024-05-18'),
(5, 5, 2, 'Produto chegou com atraso, não recomendo.', '2024-05-20'),
(6, 6, 4, 'Bom produto, bom custo-benefício.', '2024-05-22'),
(7, 7, 5, 'Muito satisfeito com a compra.', '2024-05-25'),
(8, 8, 3, 'Produto danificado, esperava melhor.', '2024-05-28'),
(9, 9, 4, 'Entrega rápida, produto conforme descrição.', '2024-05-30'),
(10, 10, 1, 'Decepcionado com a qualidade.', '2024-06-01'),
(11, 11, 5, 'Recomendo! Produto excelente.', '2024-06-03'),
(12, 12, 4, 'Boa experiência de compra.', '2024-06-05'),
(13, 13, 2, 'Produto não atendeu minhas expectativas.', '2024-06-07'),
(14, 14, 3, 'Demorou para chegar, produto ok.', '2024-06-09'),
(15, 15, 5, 'Muito satisfeito com a qualidade.', '2024-06-11'),
(16, 16, 4, 'Entrega dentro do prazo.', '2024-06-13'),
(17, 17, 3, 'Poderia ter sido melhor.', '2024-06-15'),
(18, 18, 5, 'Produto excelente, recomendo!', '2024-06-17'),
(19, 19, 4, 'Boa qualidade, preço justo.', '2024-06-19'),
(20, 20, 2, 'Não gostei do produto, muito frágil.', '2024-06-21');

-- Inserções na tabela Cupons
INSERT INTO Cupons (codigo, desconto, data_validade)
VALUES
('DESC10', 10.00, '2024-12-31'),
('SUMMER20', 20.00, '2024-08-31'),
('SALE15', 15.00, '2024-10-31'),
('SPRING25', 25.00, '2024-09-30'),
('WELCOME5', 5.00, '2024-12-31'),
('FREESHIP', 30.00, '2024-06-30'),
('VIP20', 20.00, '2024-12-31'),
('SAVE10', 10.00, '2024-11-30'),
('SPECIAL30', 30.00, '2024-07-31'),
('HOLIDAY10', 10.00, '2024-12-25'),
('SPRINGSALE', 25.00, '2024-09-15'),
('NEWUSER15', 15.00, '2024-12-31'),
('BIRTHDAY20', 20.00, '2024-06-30'),
('FALL25', 25.00, '2024-11-30'),
('FREESHIP50', 50.00, '2024-08-15'),
('WINTER10', 10.00, '2024-12-31'),
('SHOP20', 20.00, '2024-10-31'),
('BONUS15', 15.00, '2024-09-30'),
('GIFT25', 25.00, '2024-12-31'),
('FLASHSALE', 30.00, '2024-07-31');

-- Inserções na tabela Pedidos_Cupons
INSERT INTO Pedidos_Cupons (pedido_id, cupom_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

-- Inserções na tabela Estoque
INSERT INTO Estoque (produto_id, quantidade, localizacao)
VALUES
(1, 50, 'Prateleira A'),
(2, 30, 'Prateleira B'),
(3, 20, 'Prateleira C'),
(4, 40, 'Prateleira D'),
(5, 60, 'Prateleira E'),
(6, 25, 'Prateleira F'),
(7, 35, 'Prateleira G'),
(8, 45, 'Prateleira H'),
(9, 55, 'Prateleira I'),
(10, 65, 'Prateleira J'),
(11, 70, 'Prateleira K'),
(12, 80, 'Prateleira L'),
(13, 90, 'Prateleira M'),
(14, 75, 'Prateleira N'),
(15, 85, 'Prateleira O'),
(16, 95, 'Prateleira P'),
(17, 100, 'Prateleira Q'),
(18, 110, 'Prateleira R'),
(19, 120, 'Prateleira S'),
(20, 130, 'Prateleira T');

-- Inserções na tabela Devolucoes
INSERT INTO Devolucoes (pedido_id, produto_id, data_devolucao, motivo, quantidade)
VALUES
(1, 1, '2024-05-20', 'Produto com defeito', 1),
(2, 2, '2024-05-22', 'Tamanho errado', 1),
(3, 3, '2024-05-25', 'Não era o esperado', 2),
(4, 4, '2024-05-28', 'Não gostei da qualidade', 1),
(5, 5, '2024-05-30', 'Produto danificado', 1),
(6, 6, '2024-06-01', 'Não atendeu às expectativas', 2),
(7, 7, '2024-06-03', 'Não era o que eu queria', 1),
(8, 8, '2024-06-05', 'Outro motivo', 1),
(9, 9, '2024-06-07', 'Produto com problema', 1),
(10, 10, '2024-06-09', 'Não era o que eu esperava', 2),
(11, 11, '2024-06-11', 'Tamanho incorreto', 1),
(12, 12, '2024-06-13', 'Produto não funcional', 1),
(13, 13, '2024-06-15', 'Não era o que eu queria', 2),
(14, 14, '2024-06-17', 'Decepcionado com a qualidade', 1),
(15, 15, '2024-06-19', 'Produto quebrado', 1),
(16, 16, '2024-06-21', 'Não gostei do material', 2),
(17, 17, '2024-06-23', 'Tamanho não correspondente', 1),
(18, 18, '2024-06-25', 'Outro motivo de devolução', 1),
(19, 19, '2024-06-27', 'Defeito no produto', 1),
(20, 20, '2024-06-29', 'Não satisfeito com a compra', 2);

-- Inserções na tabela Categorias_Pais
INSERT INTO Categorias_Pais (nome, descricao)
VALUES
('Brasil', 'País localizado na América do Sul.'),
('Estados Unidos', 'País localizado na América do Norte.'),
('Canadá', 'País localizado na América do Norte.'),
('México', 'País localizado na América do Norte.'),
('Argentina', 'País localizado na América do Sul.'),
('Chile', 'País localizado na América do Sul.'),
('Reino Unido', 'País localizado na Europa.'),
('França', 'País localizado na Europa.'),
('Alemanha', 'País localizado na Europa.'),
('Espanha', 'País localizado na Europa.'),
('Itália', 'País localizado na Europa.'),
('Portugal', 'País localizado na Europa.'),
('Japão', 'País localizado na Ásia.'),
('China', 'País localizado na Ásia.'),
('Coreia do Sul', 'País localizado na Ásia.'),
('Índia', 'País localizado na Ásia.'),
('Austrália', 'País localizado na Oceania.'),
('Nova Zelândia', 'País localizado na Oceania.'),
('África do Sul', 'País localizado na África.'),
('Egito', 'País localizado na África.');

-- Inserções na tabela Categorias_Subcategorias
INSERT INTO Categorias_Subcategorias (categoria_id, categoria_pais_id)
VALUES
(1, 1),  -- Eletrônicos no Brasil
(2, 1),  -- Moda no Brasil
(3, 1),  -- Casa e Decoração no Brasil
(4, 2),  -- Esportes nos Estados Unidos
(5, 2),  -- Livros e Filmes nos Estados Unidos
(6, 3),  -- Beleza e Cuidados Pessoais no Canadá
(7, 3),  -- Alimentos e Bebidas no Canadá
(8, 4),  -- Brinquedos e Jogos no México
(9, 4),  -- Automotivo no México
(10, 5), -- Jardinagem e Agricultura na Argentina
(11, 5), -- Informática na Argentina
(12, 6), -- Móveis no Chile
(13, 6), -- Instrumentos Musicais no Chile
(14, 7), -- Saúde e Bem-Estar no Reino Unido
(15, 7), -- Arte e Artesanato no Reino Unido
(16, 8), -- Viagem e Lazer na França
(17, 8), -- Pet Shop na França
(18, 9), -- Fotografia na Alemanha
(19, 9), -- Culinária e Gastronomia na Alemanha
(20, 10); -- Telefonia na Espanha

-- Inserções na tabela Enderecos_Clientes
INSERT INTO Enderecos_Clientes (cliente_id, endereco, cidade, estado, cep)
VALUES
(1, 'Rua A, 123', 'São Paulo', 'SP', '01000-000'),
(2, 'Avenida B, 456', 'Rio de Janeiro', 'RJ', '20000-000'),
(3, 'Travessa C, 789', 'Belo Horizonte', 'MG', '30000-000'),
(4, 'Praça D, 101', 'Porto Alegre', 'RS', '90000-000'),
(5, 'Rua E, 202', 'Curitiba', 'PR', '80000-000'),
(6, 'Avenida F, 303', 'Florianópolis', 'SC', '88000-000'),
(7, 'Travessa G, 404', 'Salvador', 'BA', '40000-000'),
(8, 'Praça H, 505', 'Fortaleza', 'CE', '60000-000'),
(9, 'Rua I, 606', 'Brasília', 'DF', '70000-000'),
(10, 'Avenida J, 707', 'Manaus', 'AM', '69000-000'),
(11, 'Travessa K, 808', 'Recife', 'PE', '50000-000'),
(12, 'Praça L, 909', 'Belém', 'PA', '66000-000'),
(13, 'Rua M, 1010', 'Goiânia', 'GO', '74000-000'),
(14, 'Avenida N, 1111', 'Natal', 'RN', '59000-000'),
(15, 'Travessa O, 1212', 'Campo Grande', 'MS', '79000-000'),
(16, 'Praça P, 1313', 'Maceió', 'AL', '57000-000'),
(17, 'Rua Q, 1414', 'João Pessoa', 'PB', '58000-000'),
(18, 'Avenida R, 1515', 'São Luís', 'MA', '65000-000'),
(19, 'Travessa S, 1616', 'Aracaju', 'SE', '49000-000'),
(20, 'Praça T, 1717', 'Teresina', 'PI', '64000-000');

-- Inserções na tabela Metodos_Pagamento
INSERT INTO Metodos_Pagamento (descricao)
VALUES
('Cartão de Crédito'),
('Cartão de Débito'),
('Boleto Bancário'),
('PayPal'),
('Transferência Bancária'),
('PIX'),
('Apple Pay'),
('Google Pay'),
('Mercado Pago'),
('PagSeguro'),
('Stripe'),
('Crédito em Loja'),
('Débito Automático'),
('BitCoin'),
('AliPay'),
('WeChat Pay'),
('Payoneer'),
('Cheque'),
('Vale Refeição'),
('Criptomoeda');

-- Inserções na tabela Cartoes_Credito
INSERT INTO Cartoes_Credito (cliente_id, numero_cartao, nome_titular, data_validade, codigo_seguranca)
VALUES
(1, '4111111111111111', 'João Silva', '2025-06-30', '123'),
(2, '4111111111111112', 'Maria Souza', '2026-07-31', '234'),
(3, '4111111111111113', 'Carlos Oliveira', '2024-08-31', '345'),
(4, '4111111111111114', 'Ana Pereira', '2027-09-30', '456'),
(5, '4111111111111115', 'José Costa', '2023-10-31', '567'),
(6, '4111111111111116', 'Paula Fernandes', '2025-11-30', '678'),
(7, '4111111111111117', 'Ricardo Almeida', '2026-12-31', '789'),
(8, '4111111111111118', 'Sandra Lima', '2024-01-31', '890'),
(9, '4111111111111119', 'Fernando Ribeiro', '2027-02-28', '901'),
(10, '4111111111111120', 'Patrícia Castro', '2025-03-31', '012'),
(11, '4111111111111121', 'Gabriel Dias', '2026-04-30', '123'),
(12, '4111111111111122', 'Larissa Gomes', '2024-05-31', '234'),
(13, '4111111111111123', 'Rodrigo Melo', '2027-06-30', '345'),
(14, '4111111111111124', 'Juliana Martins', '2025-07-31', '456'),
(15, '4111111111111125', 'Marcos Rocha', '2026-08-31', '567'),
(16, '4111111111111126', 'Renata Azevedo', '2024-09-30', '678'),
(17, '4111111111111127', 'Thiago Sousa', '2027-10-31', '789'),
(18, '4111111111111128', 'Isabela Campos', '2025-11-30', '890'),
(19, '4111111111111129', 'Lucas Barbosa', '2026-12-31', '901'),
(20, '4111111111111130', 'Aline Santos', '2024-01-31', '012');

-- Inserções na tabela Carrinhos
INSERT INTO Carrinhos (cliente_id, data_criacao)
VALUES
(1, '2024-01-01'),
(2, '2024-01-02'),
(3, '2024-01-03'),
(4, '2024-01-04'),
(5, '2024-01-05'),
(6, '2024-01-06'),
(7, '2024-01-07'),
(8, '2024-01-08'),
(9, '2024-01-09'),
(10, '2024-01-10'),
(11, '2024-01-11'),
(12, '2024-01-12'),
(13, '2024-01-13'),
(14, '2024-01-14'),
(15, '2024-01-15'),
(16, '2024-01-16'),
(17, '2024-01-17'),
(18, '2024-01-18'),
(19, '2024-01-19'),
(20, '2024-01-20');

-- Inserções na tabela Itens_Carrinho
INSERT INTO Itens_Carrinho (carrinho_id, produto_id, quantidade, preco_unitario)
VALUES
(1, 1, 2, 50.00),
(2, 2, 1, 30.00),
(3, 3, 1, 15.00),
(4, 4, 3, 20.00),
(5, 5, 1, 100.00),
(6, 6, 2, 25.00),
(7, 7, 1, 70.00),
(8, 8, 5, 10.00),
(9, 9, 2, 40.00),
(10, 10, 3, 60.00),
(11, 11, 1, 80.00),
(12, 12, 2, 90.00),
(13, 13, 4, 30.00),
(14, 14, 2, 50.00),
(15, 15, 1, 110.00),
(16, 16, 2, 35.00),
(17, 17, 3, 45.00),
(18, 18, 1, 20.00),
(19, 19, 1, 55.00),
(20, 20, 2, 25.00),
(1, 1, 1, 12.00),
(2, 2, 3, 18.00),
(3, 3, 2, 22.00),
(4, 4, 4, 8.00),
(5, 5, 1, 33.00),
(6, 6, 5, 11.00),
(7, 7, 3, 29.00),
(8, 8, 1, 45.00),
(9, 9, 4, 19.00),
(10, 10, 2, 26.00);


-- Inserções na tabela Favoritos
INSERT INTO Favoritos (cliente_id, produto_id, data_adicao)
VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-02'),
(3, 3, '2024-02-03'),
(4, 4, '2024-02-04'),
(5, 5, '2024-02-05'),
(6, 6, '2024-02-06'),
(7, 7, '2024-02-07'),
(8, 8, '2024-02-08'),
(9, 9, '2024-02-09'),
(10, 10, '2024-02-10'),
(11, 11, '2024-02-11'),
(12, 12, '2024-02-12'),
(13, 13, '2024-02-13'),
(14, 14, '2024-02-14'),
(15, 15, '2024-02-15'),
(16, 16, '2024-02-16'),
(17, 17, '2024-02-17'),
(18, 18, '2024-02-18'),
(19, 19, '2024-02-19'),
(20, 20, '2024-02-20');

-- Inserções na tabela Logs_Acesso
INSERT INTO Logs_Acesso (cliente_id, data_acesso, ip_acesso)
VALUES
(1, '2024-03-01 08:00:00', '192.168.1.1'),
(2, '2024-03-01 08:05:00', '192.168.1.2'),
(3, '2024-03-01 08:10:00', '192.168.1.3'),
(4, '2024-03-01 08:15:00', '192.168.1.4'),
(5, '2024-03-01 08:20:00', '192.168.1.5'),
(6, '2024-03-01 08:25:00', '192.168.1.6'),
(7, '2024-03-01 08:30:00', '192.168.1.7'),
(8, '2024-03-01 08:35:00', '192.168.1.8'),
(9, '2024-03-01 08:40:00', '192.168.1.9'),
(10, '2024-03-01 08:45:00', '192.168.1.10'),
(11, '2024-03-01 08:50:00', '192.168.1.11'),
(12, '2024-03-01 08:55:00', '192.168.1.12'),
(13, '2024-03-01 09:00:00', '192.168.1.13'),
(14, '2024-03-01 09:05:00', '192.168.1.14'),
(15, '2024-03-01 09:10:00', '192.168.1.15'),
(16, '2024-03-01 09:15:00', '192.168.1.16'),
(17, '2024-03-01 09:20:00', '192.168.1.17'),
(18, '2024-03-01 09:25:00', '192.168.1.18'),
(19, '2024-03-01 09:30:00', '192.168.1.19'),
(20, '2024-03-01 09:35:00', '192.168.1.20');

-- Inserções na tabela Mensagens
INSERT INTO Mensagens (cliente_id, mensagem, data_envio)
VALUES
(1, 'Olá, tudo bem?', '2024-03-01 08:00:00'),
(2, 'Preciso de ajuda com um pedido.', '2024-03-01 08:05:00'),
(3, 'Gostaria de mais informações sobre um produto.', '2024-03-01 08:10:00'),
(4, 'Como faço para alterar meu endereço de entrega?', '2024-03-01 08:15:00'),
(5, 'Recebi um produto errado.', '2024-03-01 08:20:00'),
(6, 'Quando será feita a entrega do meu pedido?', '2024-03-01 08:25:00'),
(7, 'O produto que recebi veio danificado.', '2024-03-01 08:30:00'),
(8, 'Gostaria de solicitar um reembolso.', '2024-03-01 08:35:00'),
(9, 'Fiz um pedido há muito tempo e ainda não recebi.', '2024-03-01 08:40:00'),
(10, 'Como faço para rastrear meu pedido?', '2024-03-01 08:45:00'),
(11, 'Estou com dificuldades para finalizar minha compra.', '2024-03-01 08:50:00'),
(12, 'Qual é o prazo de entrega?', '2024-03-01 08:55:00'),
(13, 'O produto que recebi não corresponde à descrição.', '2024-03-01 09:00:00'),
(14, 'Gostaria de cancelar um pedido.', '2024-03-01 09:05:00'),
(15, 'Houve um problema com o pagamento.', '2024-03-01 09:10:00'),
(16, 'Não consigo acessar minha conta.', '2024-03-01 09:15:00'),
(17, 'Onde posso encontrar informações sobre trocas?', '2024-03-01 09:20:00'),
(18, 'Como faço para entrar em contato com o suporte?', '2024-03-01 09:25:00'),
(19, 'Gostaria de fazer uma reclamação sobre um produto.', '2024-03-01 09:30:00'),
(20, 'Qual é o horário de funcionamento da loja?', '2024-03-01 09:35:00'),
(1, 'Recebi meu pedido e estou muito satisfeito.', '2024-03-01 09:40:00'),
(2, 'Obrigado pela rápida resposta.', '2024-03-01 09:45:00'),
(3, 'As informações fornecidas foram muito úteis.', '2024-03-01 09:50:00'),
(4, 'Fui bem atendido pelo suporte.', '2024-03-01 09:55:00'),
(5, 'Estou muito feliz com minha compra.', '2024-03-01 10:00:00'),
(6, 'Vocês têm previsão de receber mais produtos?', '2024-03-01 10:05:00'),
(7, 'Gostei muito do produto que comprei.', '2024-03-01 10:10:00'),
(8, 'Como faço para deixar uma avaliação?', '2024-03-01 10:15:00'),
(9, 'Obrigado pela atenção.', '2024-03-01 10:20:00'),
(10, 'Vocês têm algum desconto para clientes fiéis?', '2024-03-01 10:25:00');

-- Inserções na tabela Notificacoes
INSERT INTO Notificacoes (cliente_id, mensagem, data_envio)
VALUES
(1, 'Seu pedido foi despachado e está a caminho!', '2024-03-01 08:00:00'),
(2, 'Promoção imperdível! Confira já em nosso site!', '2024-03-01 08:05:00'),
(3, 'Lançamento exclusivo! Aproveite antes que acabe!', '2024-03-01 08:10:00'),
(4, 'Aproveite nosso cupom de desconto exclusivo!', '2024-03-01 08:15:00'),
(5, 'Atualize seu perfil e ganhe pontos de fidelidade!', '2024-03-01 08:20:00'),
(6, 'Confira nossos produtos mais vendidos da semana!', '2024-03-01 08:25:00'),
(7, 'Novidades chegaram! Não perca tempo e confira já!', '2024-03-01 08:30:00'),
(8, 'Seu reembolso foi processado com sucesso!', '2024-03-01 08:35:00'),
(9, 'Confira nosso horário de funcionamento durante feriados!', '2024-03-01 08:40:00'),
(10, 'Agradecemos pela sua compra! Volte sempre!', '2024-03-01 08:45:00'),
(11, 'Recebemos sua mensagem e logo entraremos em contato.', '2024-03-01 08:50:00'),
(12, 'Parabéns! Você ganhou um cupom de desconto especial!', '2024-03-01 08:55:00'),
(13, 'Participe da nossa pesquisa de satisfação e ganhe brindes!', '2024-03-01 09:00:00'),
(14, 'Sua opinião é muito importante para nós. Deixe sua avaliação!', '2024-03-01 09:05:00'),
(15, 'Aproveite nosso frete grátis por tempo limitado!', '2024-03-01 09:10:00'),
(16, 'Atualize seus dados cadastrais e ganhe um brinde!', '2024-03-01 09:15:00'),
(17, 'Confira nossas ofertas exclusivas para clientes VIP!', '2024-03-01 09:20:00'),
(18, 'Estamos sempre trabalhando para melhor atendê-lo.', '2024-03-01 09:25:00'),
(19, 'Agradecemos por fazer parte da nossa comunidade!', '2024-03-01 09:30:00'),
(20, 'Promoção relâmpago! Aproveite agora mesmo!', '2024-03-01 09:35:00'),
(1, 'Confira nosso novo catálogo de produtos!', '2024-03-01 09:40:00'),
(2, 'Sua opinião nos ajuda a melhorar. Deixe seu feedback!', '2024-03-01 09:45:00'),
(3, 'Promoção de primavera! Descontos em diversos produtos!', '2024-03-01 09:50:00'),
(4, 'Fique por dentro das últimas tendências de moda!', '2024-03-01 09:55:00'),
(5, 'Novidades chegaram! Não deixe de conferir!', '2024-03-01 10:00:00'),
(6, 'Você é nosso cliente VIP! Aproveite benefícios exclusivos!', '2024-03-01 10:05:00'),
(7, 'Participe do nosso programa de fidelidade e ganhe prêmios!', '2024-03-01 10:10:00'),
(8, 'Promoção de lançamento! Descontos especiais por tempo limitado!', '2024-03-01 10:15:00'),
(9, 'Obrigado por fazer parte da nossa família!', '2024-03-01 10:20:00'),
(10, 'Estamos sempre trabalhando para oferecer o melhor para você!', '2024-03-01 10:25:00');
;

INSERT INTO Mensagens (cliente_id, mensagem, data_envio)
VALUES
(1, 'Olá, tudo bem?', '2024-03-01 08:00:00'),
(2, 'Preciso de ajuda com um pedido.', '2024-03-01 08:05:00'),
(3, 'Gostaria de mais informações sobre um produto.', '2024-03-01 08:10:00'),
(4, 'Como faço para alterar meu endereço de entrega?', '2024-03-01 08:15:00'),
(5, 'Recebi um produto errado.', '2024-03-01 08:20:00'),
(6, 'Quando será feita a entrega do meu pedido?', '2024-03-01 08:25:00'),
(7, 'O produto que recebi veio danificado.', '2024-03-01 08:30:00'),
(8, 'Gostaria de solicitar um reembolso.', '2024-03-01 08:35:00'),
(9, 'Fiz um pedido há muito tempo e ainda não recebi.', '2024-03-01 08:40:00'),
(10, 'Como faço para rastrear meu pedido?', '2024-03-01 08:45:00'),
(11, 'Estou com dificuldades para finalizar minha compra.', '2024-03-01 08:50:00'),
(12, 'Qual é o prazo de entrega?', '2024-03-01 08:55:00'),
(13, 'O produto que recebi não corresponde à descrição.', '2024-03-01 09:00:00'),
(14, 'Gostaria de cancelar um pedido.', '2024-03-01 09:05:00'),
(15, 'Houve um problema com o pagamento.', '2024-03-01 09:10:00'),
(16, 'Não consigo acessar minha conta.', '2024-03-01 09:15:00'),
(17, 'Onde posso encontrar informações sobre trocas?', '2024-03-01 09:20:00'),
(18, 'Como faço para entrar em contato com o suporte?', '2024-03-01 09:25:00'),
(19, 'Gostaria de fazer uma reclamação sobre um produto.', '2024-03-01 09:30:00'),
(20, 'Qual é o horário de funcionamento da loja?', '2024-03-01 09:35:00')
;

-- Inserções na tabela Reembolsos
INSERT INTO Reembolsos (pedido_id, data_reembolso, valor, motivo)
VALUES
(1, '2024-03-01', 50.00, 'Produto com defeito'),
(2, '2024-03-02', 20.00, 'Troca de produto'),
(3, '2024-03-03', 30.00, 'Insatisfação com o produto'),
(4, '2024-03-04', 25.00, 'Atraso na entrega'),
(5, '2024-03-05', 40.00, 'Produto não corresponde à descrição'),
(6, '2024-03-06', 35.00, 'Problemas de qualidade'),
(7, '2024-03-07', 45.00, 'Tamanho incorreto'),
(8, '2024-03-08', 30.00, 'Arrependimento da compra'),
(9, '2024-03-09', 20.00, 'Troca por outro produto'),
(10, '2024-03-10', 15.00, 'Produto danificado'),
(11, '2024-03-11', 25.00, 'Devolução não autorizada'),
(12, '2024-03-12', 30.00, 'Outro motivo'),
(13, '2024-03-13', 35.00, 'Produto fora de estoque'),
(14, '2024-03-14', 40.00, 'Desistência da compra'),
(15, '2024-03-15', 45.00, 'Problemas com a entrega'),
(16, '2024-03-16', 50.00, 'Produto não funcional'),
(17, '2024-03-17', 20.00, 'Troca por tamanho diferente'),
(18, '2024-03-18', 25.00, 'Produto usado'),
(19, '2024-03-19', 30.00, 'Insatisfação com o serviço'),
(20, '2024-03-20', 35.00, 'Problemas de logística');

-- Inserções na tabela Enderecos_Transportadoras
INSERT INTO Enderecos_Transportadoras (transportadora_id, endereco, cidade, estado, cep)
VALUES
(1, 'Av. das Nações Unidas, 123', 'São Paulo', 'SP', '04578-000'),
(2, 'Rua Comendador Araújo, 456', 'Curitiba', 'PR', '80420-000'),
(3, 'Av. Paulista, 789', 'São Paulo', 'SP', '01311-000'),
(4, 'Av. Rio Branco, 101', 'Rio de Janeiro', 'RJ', '20040-004'),
(5, 'Rua Augusta, 1234', 'São Paulo', 'SP', '01305-000'),
(6, 'Av. Tancredo Neves, 567', 'Salvador', 'BA', '41820-020'),
(7, 'Rua da Consolação, 678', 'São Paulo', 'SP', '01301-000'),
(8, 'Av. Goiás, 123', 'Goiânia', 'GO', '74000-000'),
(9, 'Rua XV de Novembro, 456', 'Curitiba', 'PR', '80020-310'),
(10, 'Av. Sete de Setembro, 789', 'Salvador', 'BA', '40010-001');

INSERT INTO Enderecos_Transportadoras (transportadora_id, endereco, cidade, estado, cep)
VALUES
(11, 'Av. Brasil, 123', 'Rio de Janeiro', 'RJ', '20040-020'),
(12, 'Av. República Argentina, 456', 'Curitiba', 'PR', '80220-210'),
(13, 'Rua da Aurora, 789', 'Recife', 'PE', '50050-000'),
(14, 'Av. Santos Dumont, 101', 'Fortaleza', 'CE', '60150-160'),
(15, 'Rua Conselheiro Mafra, 1234', 'Florianópolis', 'SC', '88010-100'),
(16, 'Av. Atlântica, 567', 'Balneário Camboriú', 'SC', '88330-000'),
(17, 'Av. Boa Viagem, 678', 'Recife', 'PE', '51021-000'),
(18, 'Rua dos Andradas, 123', 'Porto Alegre', 'RS', '90020-007'),
(19, 'Av. Juracy Magalhães Jr., 456', 'Salvador', 'BA', '41750-020'),
(20, 'Rua Itapeva, 789', 'São Paulo', 'SP', '01332-000');

-- Inserções na tabela Logs_Envios
INSERT INTO Logs_Envios (envio_id, data_log, descricao)
VALUES
(1, '2024-03-01 09:15:00', 'Pacote coletado do armazém'),
(1, '2024-03-02 12:30:00', 'Pacote em trânsito para a transportadora'),
(1, '2024-03-03 10:45:00', 'Pacote entregue ao destinatário'),
(2, '2024-03-01 10:20:00', 'Pacote coletado do armazém'),
(2, '2024-03-02 14:50:00', 'Pacote em trânsito para a transportadora'),
(2, '2024-03-03 11:40:00', 'Pacote entregue ao destinatário'),
(3, '2024-03-02 08:30:00', 'Pacote coletado do armazém'),
(3, '2024-03-03 13:20:00', 'Pacote em trânsito para a transportadora'),
(3, '2024-03-04 09:10:00', 'Pacote entregue ao destinatário'),
(4, '2024-03-03 11:10:00', 'Pacote coletado do armazém'),
(4, '2024-03-04 15:40:00', 'Pacote em trânsito para a transportadora'),
(4, '2024-03-05 12:30:00', 'Pacote entregue ao destinatário'),
(5, '2024-03-04 07:40:00', 'Pacote coletado do armazém'),
(5, '2024-03-05 11:20:00', 'Pacote em trânsito para a transportadora'),
(5, '2024-03-06 08:10:00', 'Pacote entregue ao destinatário'),
(6, '2024-03-05 08:50:00', 'Pacote coletado do armazém'),
(6, '2024-03-06 12:30:00', 'Pacote em trânsito para a transportadora'),
(6, '2024-03-07 10:20:00', 'Pacote entregue ao destinatário'),
(7, '2024-03-06 09:30:00', 'Pacote coletado do armazém'),
(7, '2024-03-07 13:10:00', 'Pacote em trânsito para a transportadora'),
(7, '2024-03-08 11:00:00', 'Pacote entregue ao destinatário'),
(8, '2024-03-07 10:10:00', 'Pacote coletado do armazém'),
(8, '2024-03-08 14:40:00', 'Pacote em trânsito para a transportadora'),
(8, '2024-03-09 12:30:00', 'Pacote entregue ao destinatário'),
(9, '2024-03-08 11:20:00', 'Pacote coletado do armazém'),
(9, '2024-03-09 15:50:00', 'Pacote em trânsito para a transportadora'),
(9, '2024-03-10 13:40:00', 'Pacote entregue ao destinatário'),
(10, '2024-03-09 12:30:00', 'Pacote coletado do armazém'),
(10, '2024-03-10 16:10:00', 'Pacote em trânsito para a transportadora'),
(10, '2024-03-11 14:00:00', 'Pacote entregue ao destinatário');
-- Inserções adicionais na tabela Logs_Envios
INSERT INTO Logs_Envios (envio_id, data_log, descricao)
VALUES
(11, '2024-03-10 08:40:00', 'Pacote coletado do armazém'),
(11, '2024-03-11 12:20:00', 'Pacote em trânsito para a transportadora'),
(11, '2024-03-12 09:10:00', 'Pacote entregue ao destinatário'),
(12, '2024-03-11 09:30:00', 'Pacote coletado do armazém'),
(12, '2024-03-12 13:10:00', 'Pacote em trânsito para a transportadora'),
(12, '2024-03-13 10:00:00', 'Pacote entregue ao destinatário'),
(13, '2024-03-12 10:50:00', 'Pacote coletado do armazém'),
(13, '2024-03-13 14:30:00', 'Pacote em trânsito para a transportadora'),
(13, '2024-03-14 11:20:00', 'Pacote entregue ao destinatário'),
(14, '2024-03-13 11:40:00', 'Pacote coletado do armazém'),
(14, '2024-03-14 15:20:00', 'Pacote em trânsito para a transportadora'),
(14, '2024-03-15 12:10:00', 'Pacote entregue ao destinatário'),
(15, '2024-03-14 12:30:00', 'Pacote coletado do armazém'),
(15, '2024-03-15 16:10:00', 'Pacote em trânsito para a transportadora'),
(15, '2024-03-16 14:00:00', 'Pacote entregue ao destinatário'),
(16, '2024-03-15 13:50:00', 'Pacote coletado do armazém'),
(16, '2024-03-16 17:30:00', 'Pacote em trânsito para a transportadora'),
(16, '2024-03-17 15:20:00', 'Pacote entregue ao destinatário'),
(17, '2024-03-16 14:40:00', 'Pacote coletado do armazém'),
(17, '2024-03-17 18:20:00', 'Pacote em trânsito para a transportadora'),
(17, '2024-03-18 16:10:00', 'Pacote entregue ao destinatário'),
(18, '2024-03-17 15:30:00', 'Pacote coletado do armazém'),
(18, '2024-03-18 19:10:00', 'Pacote em trânsito para a transportadora'),
(18, '2024-03-19 17:00:00', 'Pacote entregue ao destinatário'),
(19, '2024-03-18 16:20:00', 'Pacote coletado do armazém'),
(19, '2024-03-19 20:00:00', 'Pacote em trânsito para a transportadora'),
(19, '2024-03-20 17:50:00', 'Pacote entregue ao destinatário'),
(20, '2024-03-19 17:10:00', 'Pacote coletado do armazém'),
(20, '2024-03-20 20:50:00', 'Pacote em trânsito para a transportadora'),
(20, '2024-03-21 18:40:00', 'Pacote entregue ao destinatário');

-- Inserções na tabela Historico_Pedidos
INSERT INTO Historico_Pedidos (pedido_id, data_status, status)
VALUES
(1, '2024-03-01 10:00:00', 'Pedido recebido'),
(1, '2024-03-02 09:00:00', 'Em preparação'),
(1, '2024-03-03 11:00:00', 'Enviado'),
(1, '2024-03-05 12:00:00', 'Entregue'),
(2, '2024-03-01 11:00:00', 'Pedido recebido'),
(2, '2024-03-03 10:00:00', 'Em preparação'),
(2, '2024-03-04 12:00:00', 'Enviado'),
(2, '2024-03-06 13:00:00', 'Entregue'),
(3, '2024-03-02 12:00:00', 'Pedido recebido'),
(3, '2024-03-04 11:00:00', 'Em preparação'),
(3, '2024-03-05 13:00:00', 'Enviado'),
(3, '2024-03-07 14:00:00', 'Entregue'),
(4, '2024-03-03 13:00:00', 'Pedido recebido'),
(4, '2024-03-05 12:00:00', 'Em preparação'),
(4, '2024-03-06 14:00:00', 'Enviado'),
(4, '2024-03-08 15:00:00', 'Entregue'),
(5, '2024-03-04 14:00:00', 'Pedido recebido'),
(5, '2024-03-06 13:00:00', 'Em preparação'),
(5, '2024-03-07 15:00:00', 'Enviado'),
(5, '2024-03-09 16:00:00', 'Entregue');

-- Inserções adicionais na tabela Historico_Pedidos
INSERT INTO Historico_Pedidos (pedido_id, data_status, status)
VALUES
(6, '2024-03-05 15:00:00', 'Pedido recebido'),
(6, '2024-03-07 14:00:00', 'Em preparação'),
(6, '2024-03-08 16:00:00', 'Enviado'),
(6, '2024-03-10 17:00:00', 'Entregue'),
(7, '2024-03-06 16:00:00', 'Pedido recebido'),
(7, '2024-03-08 15:00:00', 'Em preparação'),
(7, '2024-03-09 17:00:00', 'Enviado'),
(7, '2024-03-11 18:00:00', 'Entregue'),
(8, '2024-03-07 17:00:00', 'Pedido recebido'),
(8, '2024-03-09 16:00:00', 'Em preparação'),
(8, '2024-03-10 18:00:00', 'Enviado'),
(8, '2024-03-12 19:00:00', 'Entregue'),
(9, '2024-03-08 18:00:00', 'Pedido recebido'),
(9, '2024-03-10 17:00:00', 'Em preparação'),
(9, '2024-03-11 19:00:00', 'Enviado'),
(9, '2024-03-13 20:00:00', 'Entregue'),
(10, '2024-03-09 19:00:00', 'Pedido recebido'),
(10, '2024-03-11 18:00:00', 'Em preparação'),
(10, '2024-03-12 20:00:00', 'Enviado'),
(10, '2024-03-14 21:00:00', 'Entregue');

-- Inserções adicionais na tabela Historico_Pedidos
INSERT INTO Historico_Pedidos (pedido_id, data_status, status)
VALUES
(11, '2024-03-10 20:00:00', 'Pedido recebido'),
(11, '2024-03-12 19:00:00', 'Em preparação'),
(11, '2024-03-13 21:00:00', 'Enviado'),
(11, '2024-03-15 22:00:00', 'Entregue'),
(12, '2024-03-11 21:00:00', 'Pedido recebido'),
(12, '2024-03-13 20:00:00', 'Em preparação'),
(12, '2024-03-14 22:00:00', 'Enviado'),
(12, '2024-03-16 23:00:00', 'Entregue'),
(13, '2024-03-12 22:00:00', 'Pedido recebido'),
(13, '2024-03-14 21:00:00', 'Em preparação'),
(13, '2024-03-15 23:00:00', 'Enviado'),
(13, '2024-03-17 00:00:00', 'Entregue'),
(14, '2024-03-13 23:00:00', 'Pedido recebido'),
(14, '2024-03-15 22:00:00', 'Em preparação'),
(14, '2024-03-16 00:00:00', 'Enviado'),
(14, '2024-03-18 01:00:00', 'Entregue'),
(15, '2024-03-14 00:00:00', 'Pedido recebido'),
(15, '2024-03-16 23:00:00', 'Em preparação'),
(15, '2024-03-17 01:00:00', 'Enviado'),
(15, '2024-03-19 02:00:00', 'Entregue');

-- Inserções adicionais na tabela Historico_Pedidos
INSERT INTO Historico_Pedidos (pedido_id, data_status, status)
VALUES
(16, '2024-03-15 01:00:00', 'Pedido recebido'),
(16, '2024-03-17 00:00:00', 'Em preparação'),
(16, '2024-03-18 02:00:00', 'Enviado'),
(16, '2024-03-20 03:00:00', 'Entregue'),
(17, '2024-03-16 02:00:00', 'Pedido recebido'),
(17, '2024-03-18 01:00:00', 'Em preparação'),
(17, '2024-03-19 03:00:00', 'Enviado'),
(17, '2024-03-21 04:00:00', 'Entregue'),
(18, '2024-03-17 03:00:00', 'Pedido recebido'),
(18, '2024-03-19 02:00:00', 'Em preparação'),
(18, '2024-03-20 04:00:00', 'Enviado'),
(18, '2024-03-22 05:00:00', 'Entregue'),
(19, '2024-03-18 04:00:00', 'Pedido recebido'),
(19, '2024-03-20 03:00:00', 'Em preparação'),
(19, '2024-03-21 05:00:00', 'Enviado'),
(19, '2024-03-23 06:00:00', 'Entregue'),
(20, '2024-03-19 05:00:00', 'Pedido recebido'),
(20, '2024-03-21 04:00:00', 'Em preparação'),
(20, '2024-03-22 06:00:00', 'Enviado'),
(20, '2024-03-24 07:00:00', 'Entregue');

-- Inserções na tabela Categorias_Produtos
INSERT INTO Categorias_Produtos (categoria_id, produto_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(9, 17),
(9, 18),
(10, 19),
(10, 20);

-- Inserções na tabela Descontos_Produtos
INSERT INTO Descontos_Produtos (produto_id, percentual_desconto, data_inicio, data_fim)
VALUES
(1, 10.00, '2024-05-01', '2024-05-15'),
(2, 15.00, '2024-05-05', '2024-05-20'),
(3, 20.00, '2024-05-10', '2024-05-25'),
(4, 25.00, '2024-05-15', '2024-06-01'),
(5, 30.00, '2024-05-20', '2024-06-05'),
(6, 35.00, '2024-05-25', '2024-06-10'),
(7, 40.00, '2024-06-01', '2024-06-15'),
(8, 45.00, '2024-06-05', '2024-06-20'),
(9, 50.00, '2024-06-10', '2024-06-25'),
(10, 55.00, '2024-06-15', '2024-07-01'),
(11, 60.00, '2024-06-20', '2024-07-05'),
(12, 65.00, '2024-06-25', '2024-07-10'),
(13, 70.00, '2024-07-01', '2024-07-15'),
(14, 75.00, '2024-07-05', '2024-07-20'),
(15, 80.00, '2024-07-10', '2024-07-25'),
(16, 85.00, '2024-07-15', '2024-08-01'),
(17, 90.00, '2024-07-20', '2024-08-05'),
(18, 95.00, '2024-07-25', '2024-08-10'),
(19, 100.00, '2024-08-01', '2024-08-15'),
(20, 105.00, '2024-08-05', '2024-08-20');

-- Inserts na tabela Entidades
INSERT INTO Entidades (nome_entidade, tipo_entidade)
VALUES
('Produto X', 'Produto'),
('Fornecedor Y', 'Fornecedor'),
('Sistema', 'Sistema'),
('Pedido 1', 'Pedido'),
('Pagamento 1', 'Pagamento');


-- Inserções na tabela Logs_Transacoes
INSERT INTO Logs_Transacoes (transacao_tipo, entidade_id, data_hora, descricao, cliente_id)
VALUES
('Venda', 1, '2024-05-01 08:00:00', 'Venda do produto X', 1),
('Compra', 1, '2024-05-02 10:00:00', 'Compra do fornecedor Y', 2),
('Acesso', 1, '2024-05-03 12:00:00', 'Acesso ao sistema', 3),
('Erro', 2, '2024-05-04 14:00:00', 'Erro ao processar pedido', 4),
('Venda', 2, '2024-05-05 16:00:00', 'Venda do produto Y', 5),
('Compra', 2, '2024-05-06 18:00:00', 'Compra do fornecedor Z', 6),
('Acesso', 2, '2024-05-07 20:00:00', 'Acesso ao sistema', 7),
('Erro', 3, '2024-05-08 22:00:00', 'Erro ao processar pagamento', 8),
('Venda', 3, '2024-05-09 08:00:00', 'Venda do produto Z', 9),
('Compra', 3, '2024-05-10 10:00:00', 'Compra do fornecedor X', 10),
('Acesso', 3, '2024-05-11 12:00:00', 'Acesso ao sistema', 11),
('Erro', 4, '2024-05-12 14:00:00', 'Erro ao processar envio', 12),
('Venda', 4, '2024-05-13 16:00:00', 'Venda do produto W', 13),
('Compra', 4, '2024-05-14 18:00:00', 'Compra do fornecedor Y', 14),
('Acesso', 4, '2024-05-15 20:00:00', 'Acesso ao sistema', 15),
('Erro', 5, '2024-05-16 22:00:00', 'Erro ao processar pedido', 16),
('Venda', 5, '2024-05-17 08:00:00', 'Venda do produto V', 17),
('Compra', 5, '2024-05-18 10:00:00', 'Compra do fornecedor Z', 18),
('Acesso', 5, '2024-05-19 12:00:00', 'Acesso ao sistema', 19),
('Erro', 5, '2024-05-20 14:00:00', 'Erro ao processar pagamento', 20);

INSERT INTO Perfis_Usuarios (cliente_id, preferencia_json)
VALUES
(1, '{"idioma": "pt-br", "tema": "claro"}'),
(2, '{"idioma": "en-us", "tema": "escuro"}'),
(3, '{"idioma": "es-es", "tema": "claro"}'),
(4, '{"idioma": "pt-br", "tema": "escuro"}'),
(5, '{"idioma": "pt-br", "tema": "claro"}'),
(6, '{"idioma": "en-us", "tema": "escuro"}'),
(7, '{"idioma": "es-es", "tema": "claro"}'),
(8, '{"idioma": "pt-br", "tema": "escuro"}'),
(9, '{"idioma": "pt-br", "tema": "claro"}'),
(10, '{"idioma": "en-us", "tema": "escuro"}'),
(11, '{"idioma": "es-es", "tema": "claro"}'),
(12, '{"idioma": "pt-br", "tema": "escuro"}'),
(13, '{"idioma": "pt-br", "tema": "claro"}'),
(14, '{"idioma": "en-us", "tema": "escuro"}'),
(15, '{"idioma": "es-es", "tema": "claro"}'),
(16, '{"idioma": "pt-br", "tema": "escuro"}'),
(17, '{"idioma": "pt-br", "tema": "claro"}'),
(18, '{"idioma": "en-us", "tema": "escuro"}'),
(19, '{"idioma": "es-es", "tema": "claro"}'),
(20, '{"idioma": "pt-br", "tema": "escuro"}');

INSERT INTO Historico_Precos (produto_id, preco_anterior, preco_novo, data_alteracao)
VALUES
(1, 50.00, 45.00, '2024-05-01'),
(2, 35.00, 30.00, '2024-05-02'),
(3, 70.00, 65.00, '2024-05-03'),
(4, 25.00, 20.00, '2024-05-04'),
(5, 40.00, 35.00, '2024-05-05'),
(6, 45.00, 40.00, '2024-05-06'),
(7, 30.00, 25.00, '2024-05-07'),
(8, 65.00, 60.00, '2024-05-08'),
(9, 20.00, 15.00, '2024-05-09'),
(10, 35.00, 30.00, '2024-05-10'),
(11, 40.00, 35.00, '2024-05-11'),
(12, 25.00, 20.00, '2024-05-12'),
(13, 60.00, 55.00, '2024-05-13'),
(14, 15.00, 10.00, '2024-05-14'),
(15, 30.00, 25.00, '2024-05-15'),
(16, 35.00, 30.00, '2024-05-16'),
(17, 20.00, 15.00, '2024-05-17'),
(18, 55.00, 50.00, '2024-05-18'),
(19, 10.00, 5.00, '2024-05-19'),
(20, 25.00, 20.00, '2024-05-20');

INSERT INTO Historico_Estoque (produto_id, quantidade_anterior, quantidade_nova, data_alteracao)
VALUES
(1, 100, 95, '2024-05-01'),
(2, 80, 75, '2024-05-02'),
(3, 120, 115, '2024-05-03'),
(4, 150, 145, '2024-05-04'),
(5, 200, 195, '2024-05-05'),
(6, 95, 90, '2024-05-06'),
(7, 75, 70, '2024-05-07'),
(8, 115, 110, '2024-05-08'),
(9, 145, 140, '2024-05-09'),
(10, 195, 190, '2024-05-10'),
(11, 90, 85, '2024-05-11'),
(12, 70, 65, '2024-05-12'),
(13, 110, 105, '2024-05-13'),
(14, 140, 135, '2024-05-14'),
(15, 190, 185, '2024-05-15'),
(16, 85, 80, '2024-05-16'),
(17, 65, 60, '2024-05-17'),
(18, 105, 100, '2024-05-18'),
(19, 135, 130, '2024-05-19'),
(20, 185, 180, '2024-05-20');

INSERT INTO Promocoes (nome, descricao, data_inicio, data_fim)
VALUES
('Desconto de Verão', 'Promoção de verão com descontos em vários produtos', '2024-06-01', '2024-06-30'),
('Oferta Especial', 'Oferta especial em produtos selecionados', '2024-06-15', '2024-07-15'),
('Queima de Estoque', 'Grande queima de estoque com descontos imperdíveis', '2024-06-10', '2024-07-10'),
('Dia dos Namorados', 'Promoção especial para o Dia dos Namorados', '2024-06-01', '2024-06-12'),
('Volta às Aulas', 'Descontos em materiais escolares para a volta às aulas', '2024-07-01', '2024-07-31'),
('Promoção de Primavera', 'Ofertas especiais para celebrar a chegada da primavera', '2024-09-01', '2024-09-30'),
('Black Friday Antecipada', 'Descontos incríveis em preparação para a Black Friday', '2024-10-01', '2024-10-15'),
('Oferta Relâmpago', 'Ofertas relâmpago por tempo limitado', '2024-11-01', '2024-11-07'),
('Semana do Consumidor', 'Ofertas exclusivas durante a Semana do Consumidor', '2024-03-01', '2024-03-07'),
('Descontos de Fim de Ano', 'Grandes descontos para celebrar o fim do ano', '2024-12-01', '2024-12-31'),
('Dia do Consumidor', 'Ofertas especiais em comemoração ao Dia do Consumidor', '2024-03-15', '2024-03-16'),
('Promoção de Inverno', 'Descontos imperdíveis para se preparar para o inverno', '2024-06-20', '2024-07-20'),
('Liquidação de Verão', 'Liquidação de verão com descontos de até 50%', '2024-01-15', '2024-02-15'),
('Ofertas de Aniversário', 'Ofertas especiais em comemoração ao aniversário da loja', '2024-08-01', '2024-08-07'),
('Desconto Exclusivo', 'Desconto exclusivo para clientes cadastrados', '2024-05-01', '2024-05-31'),
('Oferta de Lançamento', 'Ofertas especiais para novos produtos', '2024-04-01', '2024-04-30'),
('Promoção Relâmpago', 'Promoção relâmpago com descontos de até 70%', '2024-09-10', '2024-09-12'),
('Ofertas de Natal', 'Ofertas especiais para o período de Natal', '2024-12-10', '2024-12-24'),
('Descontos de Outono', 'Descontos especiais para celebrar a chegada do outono', '2024-03-20', '2024-04-20'),
('Promoção de Aniversário', 'Ofertas especiais em comemoração ao aniversário da loja', '2024-10-20', '2024-10-27');

INSERT INTO Promocoes_Produtos (promocao_id, produto_id)
VALUES
(1, 1),  -- Desconto de Verão para Produto 1
(2, 2),  -- Oferta Especial para Produto 2
(3, 3),  -- Queima de Estoque para Produto 3
(4, 4),  -- Dia dos Namorados para Produto 4
(5, 5),  -- Volta às Aulas para Produto 5
(6, 6),  -- Promoção de Primavera para Produto 6
(7, 7),  -- Black Friday Antecipada para Produto 7
(8, 8),  -- Oferta Relâmpago para Produto 8
(9, 9),  -- Semana do Consumidor para Produto 9
(10, 10),  -- Descontos de Fim de Ano para Produto 10
(11, 11),  -- Dia do Consumidor para Produto 11
(12, 12),  -- Promoção de Inverno para Produto 12
(13, 13),  -- Liquidação de Verão para Produto 13
(14, 14),  -- Ofertas de Aniversário para Produto 14
(15, 15),  -- Desconto Exclusivo para Produto 15
(16, 16),  -- Oferta de Lançamento para Produto 16
(17, 17),  -- Promoção Relâmpago para Produto 17
(18, 18),  -- Ofertas de Natal para Produto 18
(19, 19),  -- Descontos de Outono para Produto 19
(20, 20);  -- Promoção de Aniversário para Produto 20

INSERT INTO Historico_Pagamentos (pagamento_id, data_pagamento, valor, metodo_pagamento)
VALUES
(1, '2024-05-01 10:00:00', 120.50, 'Cartão de Crédito'),
(2, '2024-05-02 11:30:00', 75.80, 'PayPal'),
(3, '2024-05-03 09:45:00', 200.00, 'Boleto Bancário'),
(4, '2024-05-04 14:20:00', 150.25, 'Transferência Bancária'),
(5, '2024-05-05 16:00:00', 180.00, 'Cartão de Débito'),
(6, '2024-05-06 13:15:00', 90.50, 'PayPal'),
(7, '2024-05-07 08:30:00', 210.75, 'Boleto Bancário'),
(8, '2024-05-08 17:45:00', 95.20, 'Transferência Bancária'),
(9, '2024-05-09 09:00:00', 120.00, 'Cartão de Crédito'),
(10, '2024-05-10 11:10:00', 60.75, 'Cartão de Débito'),
(11, '2024-05-11 12:30:00', 180.90, 'PayPal'),
(12, '2024-05-12 14:40:00', 100.25, 'Boleto Bancário'),
(13, '2024-05-13 15:50:00', 250.00, 'Transferência Bancária'),
(14, '2024-05-14 16:15:00', 130.50, 'Cartão de Crédito'),
(15, '2024-05-15 18:20:00', 70.80, 'PayPal'),
(16, '2024-05-16 09:00:00', 190.25, 'Boleto Bancário'),
(17, '2024-05-17 10:30:00', 220.00, 'Transferência Bancária'),
(18, '2024-05-18 11:45:00', 150.75, 'Cartão de Débito'),
(19, '2024-05-19 13:10:00', 80.90, 'PayPal'),
(20, '2024-05-20 14:30:00', 200.25, 'Boleto Bancário');

ALTER TABLE Pagamentos
ADD COLUMN metodo_pagamento_id INT,
ADD FOREIGN KEY (metodo_pagamento_id) REFERENCES Metodos_Pagamento(metodo_id);

--------------------------------------------------------------------------------------------------
-- 4.CONSULTAS BASICAS - SELECT, WHERE, AND, OR, ORDER BY, LIMIT - DML
--------------------------------------------------------------------------------------------------

-- SELECT - Listar todos os produtos de uma determinada categoria com preço maior que um valor específico:
SELECT p.nome AS nome_produto,
       p.preco
FROM Produtos AS p
JOIN Categorias_Produtos AS cp ON p.produto_id = cp.produto_id
WHERE cp.categoria_id = 1 AND p.preco > 50.00;
-- WHERE - Listar todos os produtos que estão em promoção:
SELECT p.nome AS nome_produto,
       p.preco,
       dp.percentual_desconto
FROM Produtos AS p
JOIN Descontos_Produtos AS dp ON p.produto_id = dp.produto_id
WHERE dp.data_inicio <= CURDATE() AND dp.data_fim >= CURDATE();
-- AND - Listar todos os produtos vendidos em uma determinada data:
SELECT p.nome AS nome_produto,
       lt.data_hora
FROM Produtos AS p
JOIN Logs_Transacoes AS lt ON p.produto_id = lt.entidade_id
WHERE lt.transacao_tipo = 'Venda' AND DATE(lt.data_hora) = '2024-05-01';
-- OR - Listar todos os produtos com preço menor que R$50 OU que tenham um desconto de pelo menos 20%:
SELECT p.nome AS nome_produto,
       p.preco,
       dp.percentual_desconto
FROM Produtos AS p
LEFT JOIN Descontos_Produtos AS dp ON p.produto_id = dp.produto_id
WHERE p.preco < 50 OR dp.percentual_desconto >= 20;
-- ORDER BY - Listar todos os produtos com estoque inferior a 100 unidades, ordenados pelo nome do produto:
SELECT p.nome AS nome_produto,
       he.quantidade_nova
FROM Produtos AS p
JOIN Historico_Estoque AS he ON p.produto_id = he.produto_id
WHERE he.quantidade_nova < 100
ORDER BY p.nome;
-- LIMIT - Listar todos os produtos com desconto maior que 30%, limitando o resultado aos 5 primeiros:
SELECT p.nome AS nome_produto,
       dp.percentual_desconto
FROM Produtos AS p
JOIN Descontos_Produtos AS dp ON p.produto_id = dp.produto_id
WHERE dp.percentual_desconto > 30
LIMIT 5;

--------------------------------------------------------------------------------------------------
-- 5.MANIPULACAO DE DADOS - INSERT INTO, UPDATE, DELETE - DDL
--------------------------------------------------------------------------------------------------

-- INSERT INTO
INSERT INTO Produtos (nome, preco, categoria_id)
VALUES ('Novo Produto', 25.00, 2);
-- UPDATE
UPDATE Produtos
SET preco = 30.00
WHERE produto_id = 3;
-- DELETE
DELETE FROM Pedidos
WHERE status = 'Cancelado';

--------------------------------------------------------------------------------------------------
-- 6.CONSULTAS AVANÇADAS - MIN, MAX, COUNT, AVG, SUM
--------------------------------------------------------------------------------------------------

-- COUNT - Encontrar o produto mais vendido
SELECT p.nome AS nome_produto,
       COUNT(*) AS total_vendas
FROM Produtos p
JOIN Itens_Pedido ip ON p.produto_id = ip.produto_id
GROUP BY p.nome
ORDER BY COUNT(*) DESC
LIMIT 1;
-- AVG - Encontrar a média de preços dos produtos
SELECT AVG(preco) AS media_precos
FROM Produtos;
-- SUM - Encontrar o número total de produtos em estoque
SELECT SUM(quantidade_nova) AS total_estoque
FROM Historico_Estoque;
-- MIN E MAX - Encontrar o menor e o maior preço entre os produtos
SELECT MIN(preco) AS menor_preco,
       MAX(preco) AS maior_preco
FROM Produtos;

--------------------------------------------------------------------------------------------------
-- 7.UTILIZAÇÃO DE LIKE, WILDCARD, IN, BETWEEN
--------------------------------------------------------------------------------------------------

-- LIKE - Encontrar clientes cujos nomes começam com uma determinada letra A
SELECT *
FROM clientes
WHERE nome LIKE 'A%';
-- WILDCARD - Encontrar produtos com nomes que contenham uma determinada sequência de caracteres
SELECT *
FROM Produtos
WHERE nome LIKE '%camiseta%';
-- IN - Selecionar produtos de categorias específicas
SELECT *
FROM Produtos
WHERE categoria_id IN (1, 2, 3);
-- BETWEEN - Selecionar produtos com preços dentro de um determinado intervalo:
SELECT *
FROM Produtos
WHERE preco BETWEEN 50.00 AND 100.00;

--------------------------------------------------------------------------------------------------
-- 9.ALIASES E JOIN - INNER JOIN, LEFT JOIN, RIGHT JOIN, CROSS JOIN, SELF JOIN
--------------------------------------------------------------------------------------------------

-- INNER JOIN - Listar todos os pedidos juntamente com o nome do cliente e o status do pedido:
SELECT P.*,
       c.nome,
       P.status
FROM Pedidos P
INNER JOIN clientes c ON P.cliente_id = c.cliente_id;
-- LEFT JOIN - Listar todos os produtos juntamente com suas categorias, mesmo que não haja uma correspondência na tabela de categorias
SELECT p.*,
       ct.nome
FROM Produtos p
LEFT JOIN Categorias ct ON p.categoria_id = ct.categoria_id;
-- CROSS JOIN - Retorna uma combinação produto x categoria por cada categoria
SELECT p.*,
       ct.nome
FROM Produtos p
CROSS JOIN Categorias ct;
-- SELF JOIN - Lista produtos que pertencem a mesma categoria
SELECT P1.nome,
       P2.nome AS produto_relacionado
FROM Produtos P1
INNER JOIN Produtos P2 ON P1.categoria_id = P2.categoria_id
WHERE P1.produto_id <> P2.produto_id;


--------------------------------------------------------------------------------------------------
-- 10.UNION E AGRUPAMENTO - UNION, GROUP BY, HAVING
--------------------------------------------------------------------------------------------------

-- UNION
        -- Consulta 1: Produtos vendidos antes de maio de 2024
        SELECT produto_id,
               data_inicio
        FROM Descontos_Produtos
        WHERE data_inicio < '2024-05-01'

        UNION

        -- Consulta 2: Produtos vendidos após julho de 2024
        SELECT produto_id,
               data_inicio
        FROM Descontos_Produtos
        WHERE data_inicio > '2024-07-31';

-- GROUP BY - Consulta: Quantidade de vendas por mês
SELECT
    DATE_FORMAT(data_hora, '%M') AS mes,
    COUNT(*) AS total_vendas
FROM Logs_Transacoes
WHERE transacao_tipo = 'Venda'
GROUP BY mes;

-- HAVING - Consulta: Categorias com mais de 1 produtos vendidos
SELECT Categorias.nome,
       COUNT(*) AS total_produtos_vendidos
FROM Categorias
INNER JOIN Categorias_Produtos ON Categorias.categoria_id = Categorias_Produtos.categoria_id
INNER JOIN Logs_Transacoes ON Categorias_Produtos.produto_id = Logs_Transacoes.entidade_id
WHERE Logs_Transacoes.transacao_tipo = 'Venda'
GROUP BY Categorias.nome
HAVING COUNT(*) > 1;

-- TODAS
SELECT Categorias.nome,
       COUNT(*) AS quantidade_vendida
FROM Categorias
INNER JOIN Categorias_Produtos ON Categorias.categoria_id = Categorias_Produtos.categoria_id
INNER JOIN Descontos_Produtos ON Categorias_Produtos.produto_id = Descontos_Produtos.produto_id
INNER JOIN Logs_Transacoes ON Descontos_Produtos.produto_id = Logs_Transacoes.entidade_id
WHERE Logs_Transacoes.transacao_tipo = 'Venda'
GROUP BY Categorias.nome
HAVING COUNT(*) > 0

UNION

SELECT 'Sem Categoria',
       COUNT(*)
FROM Descontos_Produtos
LEFT JOIN Categorias_Produtos ON Descontos_Produtos.produto_id = Categorias_Produtos.produto_id
WHERE Categorias_Produtos.produto_id IS NULL
AND Descontos_Produtos.produto_id NOT IN (
    SELECT produto_id FROM Categorias_Produtos
)
AND Descontos_Produtos.produto_id IN (
    SELECT entidade_id FROM Logs_Transacoes WHERE transacao_tipo = 'Venda'
);



--------------------------------------------------------------------------------------------------
-- 11.SUBCONSULTAS E OPERADORES - EXISTS, ANY, ALL
--------------------------------------------------------------------------------------------------

-- EXISTS - Retorna true se a subconsulta retornar uma ou mais linhas.
SELECT *
FROM Produtos p
WHERE EXISTS (
    SELECT 1
    FROM Avaliacoes a
    WHERE a.produto_id = p.produto_id
);

-- NOT EXISTS - Listar os produtos que nunca receberam avaliações
SELECT *
FROM Produtos p
WHERE NOT EXISTS (
    SELECT 1
    FROM Avaliacoes a
    WHERE a.produto_id = p.produto_id
);

-- ANY - Retorna true se algum dos valores na subconsulta satisfizer a condição.
SELECT *
FROM Produtos
WHERE preco > ANY (
    SELECT preco
    FROM Produtos
    WHERE categoria_id = 1
);

-- ALL - Retorna true se todos os valores na subconsulta satisfizerem a condição.
SELECT *
FROM Produtos
WHERE preco > ALL (
    SELECT preco
    FROM Produtos
    WHERE categoria_id = 1
);

--------------------------------------------------------------------------------------------------
-- 12.INSERÇÃO E SELEÇÃO AVANÇADA - INSERT SELECT, CASE, CONSULTAS NULAS(IFNULL, COALASCE)
--------------------------------------------------------------------------------------------------

-- INSERTS
INSERT INTO Categorias (nome, descricao)
VALUES
('Ferramentas', 'Diversos tipos de ferramentas manuais e elétricas');

-- INSERT SELECT com CASE e IFNULL
INSERT INTO Logs_Transacoes (transacao_tipo, total_transacoes, descricao)
SELECT
    transacao_tipo,
    COUNT(*) AS total_transacoes,
    CASE
        WHEN descricao IS NULL THEN 'Não especificado'
        ELSE descricao
    END AS descricao_resumida
FROM Logs_Transacoes
GROUP BY transacao_tipo, descricao;
-- IF NULL - sE O RESULTADO DA CONTAGEM FOR NUL RETORNE 0
SELECT
    transacao_tipo,
    IFNULL(COUNT(*), 0) AS total_transacoes
FROM Logs_Transacoes
GROUP BY transacao_tipo;

--------------------------------------------------------------------------------------------------
-- 13.GERENCIAMENTO DE BANCO DE DADOS - CREATE DB, DROP DB, CREATE TABLE, DROP TABLE, ALTER TABLE
--------------------------------------------------------------------------------------------------

-- USE
USE EcommerceDB;
-- CREATE DB
create database EcommerceDB;
-- DROP DB
drop database EcommerceDB;
-- CREATE TABLE
CREATE TABLE Categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);
-- DROP TABLE
DROP TABLE Categorias;
-- ALTER TABLE
ALTER TABLE Categorias
    ADD COLUMN TIPOS INT;

--------------------------------------------------------------------------------------------------
-- 14.CONSTRAINS - NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT
--------------------------------------------------------------------------------------------------

-- NOT NULL: Para garantir que um campo não possa conter valores nulos.
ALTER TABLE Produtos MODIFY COLUMN nome VARCHAR(100) NOT NULL;

-- UNIQUE: Para garantir que os valores em uma coluna sejam exclusivos.
ALTER TABLE Clientes ADD CONSTRAINT unique_email UNIQUE (email);

-- PRIMARY KEY: Para definir uma chave primária única para cada linha da tabela.
ALTER TABLE Pedidos ADD CONSTRAINT pk_pedido_id PRIMARY KEY (pedido_id);

-- FOREIGN KEY: Para garantir a integridade referencial entre duas tabelas.
ALTER TABLE Pedidos ADD CONSTRAINT fk_cliente_id FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id);

-- CHECK: Para impor condições específicas em valores de coluna.
ALTER TABLE Produtos ADD CONSTRAINT check_preco CHECK (preco > 0);

-- DEFAULT: Para fornecer um valor padrão quando nenhum valor é especificado para uma coluna.
ALTER TABLE Pedidos MODIFY COLUMN status VARCHAR(20) DEFAULT 'Pendente';

--------------------------------------------------------------------------------------------------
-- 15.INDECES E INCREMENTOS - CREATE INDEX, AUTO INCREMENT
--------------------------------------------------------------------------------------------------

-- INDEX - NAS TABELAS MAIS USADAS
CREATE INDEX idx_produto_id ON Produtos (produto_id);
CREATE INDEX idx_cliente_id ON Clientes (cliente_id);

-- AUTO INCREMENT
ALTER TABLE Pedidos MODIFY COLUMN pedido_id INT AUTO_INCREMENT PRIMARY KEY;

--------------------------------------------------------------------------------------------------
-- 16.DATAS E VISÕES
--------------------------------------------------------------------------------------------------
-- VIEW - Crie uma visão para listar todas as vendas do mês atual.
CREATE VIEW Vendas_Mes_Atual AS
SELECT *
FROM Logs_Transacoes
WHERE transacao_tipo = 'Venda'
AND MONTH(data_hora) = MONTH(CURRENT_DATE())
AND YEAR(data_hora) = YEAR(CURRENT_DATE());
--------------------------------------------------------------------------------------------------
-- 16.LOGS e TRIGGERS
--------------------------------------------------------------------------------------------------
