CREATE DATABASE db_loja_eletronicos;

USE db_loja_eletronicos;

-- Tabela `produtos`
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    preco_medio DECIMAL(10, 2)
);

-- Tabela `clientes`
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    valor_total_compras DECIMAL(10, 2) DEFAULT 0.00
);

-- Tabela `vendas`
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    id_promocao decimal(10,2),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela `promocoes`
CREATE TABLE promocoes (
    id_promocao INT PRIMARY KEY AUTO_INCREMENT,
    nome_promocao VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Tabela `notificacoes`
CREATE TABLE notificacoes (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO produtos (nome_produto, categoria, preco, quantidade_estoque) VALUES
('Camiseta Polo', 'Roupas', 49.90, 100),
('Calça Jeans', 'Roupas', 89.90, 50),
('Tênis Esportivo', 'Calçados', 129.90, 30),
('Relógio Digital', 'Acessórios', 199.90, 20),
('Óculos de Sol', 'Acessórios', 79.90, 40),
('Smartphone', 'Eletrônicos', 899.90, 15),
('Tablet', 'Eletrônicos', 499.90, 25),
('Cadeira Gamer', 'Móveis', 299.90, 10),
('Mesa de Escritório', 'Móveis', 199.90, 5),
('Luminária LED', 'Iluminação', 59.90, 60);

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Ana Silva', 'ana.silva@example.com', '1111-2222', 350.00),
('Bruno Costa', 'bruno.costa@example.com', '1111-3333', 150.00),
('Carla Oliveira', 'carla.oliveira@example.com', '1111-4444', 500.00),
('Daniela Santos', 'daniela.santos@example.com', '1111-5555', 200.00),
('Eduardo Almeida', 'eduardo.almeida@example.com', '1111-6666', 0.00),
('Fernanda Lima', 'fernanda.lima@example.com', '1111-7777', 75.00),
('Gabriel Martins', 'gabriel.martins@example.com', '1111-8888', 120.00),
('Helena Rocha', 'helena.rocha@example.com', '1111-9999', 300.00),
('Igor Ferreira', 'igor.ferreira@example.com', '1111-0000', 450.00),
('Juliana Mendes', 'juliana.mendes@example.com', '1111-1111', 600.00);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total, id_promocao) VALUES
(1, 1, '2024-08-01', 2, 99.80, null),
(2, 2, '2024-08-02', 1, 89.90, null),
(3, 3, '2024-08-03', 1, 129.90, null),
(4, 4, '2024-08-04', 1, 199.90, null),
(5, 5, '2024-08-05', 1, 79.90, null),
(6, 6, '2024-08-06', 1, 899.90, null),
(7, 7, '2024-08-07', 1, 499.90, null),
(8, 8, '2024-08-08', 1, 299.90, null),
(9, 9, '2024-08-09', 1, 199.90, null),
(10, 10, '2024-08-10', 1, 59.90, null);

INSERT INTO promocoes (nome_promocao, data_inicio, data_fim, desconto) VALUES
('Promoção de Verão', '2024-07-01', '2024-07-31', 10.00),
('Liquidação de Julho', '2024-07-15', '2024-08-15', 15.00),
('Desconto de Aniversário', '2024-08-01', '2024-08-31', 20.00),
('Promoção Back to School', '2024-08-15', '2024-09-15', 12.00),
('Oferta Relâmpago', '2024-08-20', '2024-08-20', 25.00),
('Desconto em Eletrônicos', '2024-08-01', '2024-08-10', 18.00),
('Semana do Cliente', '2024-08-05', '2024-08-12', 10.00),
('Feirão de Móveis', '2024-08-01', '2024-08-20', 15.00),
('Promoção de Fim de Semana', '2024-08-09', '2024-08-11', 30.00),
('Festival de Ofertas', '2024-08-01', '2024-08-15', 12.00);

select * from clientes;
select * from notificacoes;
select * from produtos;
select * from promocoes;
select * from vendas;

-- 1.Registrar uma nova venda e atualizar o valor total de compras por cliente.
-- 2.Trigger para aplicar desconto de promoção em vendas
-- 3.Atualizar o preço médio de um produto após uma nova venda.
-- 4.Rastrear alterações no estoque de produtos e registrar uma notificação dentro de um log.
-- 5.Registrar novos clientes e gerar uma mensagem de usuário cadastrado dentro de um log.
-- 6.Monitorar vendas de produtos em promoção e registrar uma notificação.
-- 7.Registrar produtos em falta no estoque e gerar uma notificação.
-- 8.Atualizar o valor total de vendas de um produto após uma nova venda.
-- 9.Rastrear alterações no valor de produtos e registrar uma notificação.

-- 1
DELIMITER //
create trigger tr_nova_venda
after insert on vendas for each row
begin
	update clientes
		set valor_total_compras = valor_total_compras + new.valor_total
	where id_cliente = new.id_cliente;
end;
// DELIMITER ;

-- 2
DELIMITER //
create trigger tr_aplicar_desconto
after insert on vendas for each row
begin
	update vendas
		set new.valor_total = new.valor_total - promocao.desconto
	where promocao.id_promocao = new.id_promocao;
end;
// DELIMITER ;

-- 3
DELIMITER //
create trigger tr_add_preco_medio
after insert on vendas for each row
begin
	update produtos
		set preco_medio = (select sum(valor_total) from vendas where id_produto = new.id_produto) / count(new.id_produto)
	where id_produto = new.id_produto;
end;
// DELIMITER ;

-- 4
DELIMITER //
create trigger tr_alteracao_estoque
before update on produtos for each row
begin

	case 
		when (select quantidade from produtos where id_produto = new.id_produto) != new.quantidade
        then insert into notificacoes (mensagem, data_notificacao) values ('Mudança no estoque', now());
end;
// DELIMITER ;
