CREATE DATABASE db_loja_eletronicos;
drop database db_loja_eletronicos;
USE db_loja_eletronicos;

-- Tabela `produtos`
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    preco_medio DECIMAL(10, 2),
    valor_venda_total decimal(10,2)
);

-- Tabela `clientes`
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    valor_total_compras DECIMAL(10, 2) DEFAULT 0.00
);

-- Tabela `promocoes`
CREATE TABLE promocoes (
    id_promocao INT PRIMARY KEY AUTO_INCREMENT,
    nome_promocao VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Tabela `vendas`
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    id_promocao int,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_promocao) REFERENCES promocoes(id_promocao)
);

-- Tabela `notificacoes`
CREATE TABLE notificacoes (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO produtos (nome_produto, categoria, preco, quantidade_estoque, preco_medio, valor_venda_total) VALUES
('Produto A', 'Categoria 1', 29.99, 100, 25.00, 2999.00),
('Produto B', 'Categoria 2', 49.99, 50, 45.00, 2499.50),
('Produto C', 'Categoria 3', 19.99, 200, 15.00, 3998.00),
('Produto D', 'Categoria 1', 99.99, 75, 85.00, 7499.25),
('Produto E', 'Categoria 2', 39.99, 120, 35.00, 4798.80),
('Produto F', 'Categoria 3', 9.99, 300, 7.00, 2997.00),
('Produto G', 'Categoria 1', 89.99, 60, 80.00, 5399.40),
('Produto H', 'Categoria 2', 59.99, 80, 50.00, 4799.20),
('Produto I', 'Categoria 3', 14.99, 150, 12.00, 2248.50),
('Produto J', 'Categoria 1', 24.99, 90, 20.00, 2249.10);

INSERT INTO clientes (nome, email, telefone, valor_total_compras) VALUES
('Cliente A', 'clientea@example.com', '111-111-1111', 300.00),
('Cliente B', 'clienteb@example.com', '222-222-2222', 450.50),
('Cliente C', 'clientec@example.com', '333-333-3333', 100.00),
('Cliente D', 'cliented@example.com', '444-444-4444', 250.75),
('Cliente E', 'clientee@example.com', '555-555-5555', 600.00),
('Cliente F', 'clientef@example.com', '666-666-6666', 75.25),
('Cliente G', 'clienteg@example.com', '777-777-7777', 150.00),
('Cliente H', 'clienteh@example.com', '888-888-8888', 380.10),
('Cliente I', 'clientei@example.com', '999-999-9999', 200.00),
('Cliente J', 'clientej@example.com', '000-000-0000', 500.00);

INSERT INTO promocoes (nome_promocao, data_inicio, data_fim, desconto) VALUES
('Promoção de Verão', '2024-07-01', '2024-08-31', 15.00),
('Promoção de Outono', '2024-09-01', '2024-10-31', 10.00),
('Promoção de Natal', '2024-12-01', '2024-12-31', 20.00),
('Promoção de Ano Novo', '2024-12-26', '2025-01-10', 25.00),
('Promoção de Páscoa', '2024-03-01', '2024-04-15', 18.00),
('Promoção de Black Friday', '2024-11-01', '2024-11-30', 30.00),
('Promoção de Primavera', '2024-03-20', '2024-06-20', 12.00),
('Promoção de Halloween', '2024-10-01', '2024-10-31', 22.00),
('Promoção de Dia dos Namorados', '2024-06-01', '2024-06-14', 14.00),
('Promoção de Aniversário da Loja', '2024-05-01', '2024-05-31', 8.00);

INSERT INTO vendas (id_produto, id_cliente, data_venda, quantidade, valor_total, id_promocao) VALUES
(1, 1, '2024-08-01', 2, 59.98, NULL),
(2, 2, '2024-08-02', 1, 49.99, NULL),
(3, 3, '2024-08-03', 5, 99.95, 1),
(4, 4, '2024-08-04', 3, 299.97, NULL),
(5, 5, '2024-08-05', 4, 159.96, 2),
(6, 6, '2024-08-06', 10, 99.90, NULL),
(7, 7, '2024-08-07', 1, 89.99, NULL),
(8, 8, '2024-08-08', 2, 119.98, 1),
(9, 9, '2024-08-09', 3, 44.97, NULL),
(10, 10, '2024-08-10', 4, 99.96, 2);


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
end
// DELIMITER ;
drop trigger tr_nova_venda;
-- teste
INSERT INTO vendas (id_venda, id_produto, id_cliente, data_venda, quantidade, valor_total, id_promocao) VALUES
(default,2, 1, '2024-08-15', 3, 149.97, NULL);

-- 2
DELIMITER //
create trigger tr_aplicar_desconto
after insert on vendas for each row
begin
    
	update vendas
		set valor_total = valor_total - (select desconto from promocoes where id_promocao = new.id_promocao)
	where id_venda = new.id_venda;

end
// DELIMITER ;
drop trigger tr_aplicar_desconto;
-- teste
INSERT INTO vendas (id_venda, id_produto, id_cliente, data_venda, quantidade, valor_total, id_promocao) VALUES
(default,2, 1, '2024-08-15', 3, 149.97, 1);




-- 3
DELIMITER //
create trigger tr_add_preco_medio
after insert on vendas for each row
begin
	update produtos
		set preco_medio = (select avg(valor_total) from vendas where id_produto = new.id_produto)
	where id_produto = new.id_produto;
end
// DELIMITER ;

-- 4
DELIMITER //
create trigger tr_alteracao_estoque
before update on produtos for each row
begin

	if (select quantidade_estoque from produtos where id_produto = new.id_produto) != new.quantidade_estoque
        then insert into notificacoes (mensagem, data_notificacao) values ('Mudança no estoque', now());
	end if;
end
// DELIMITER ;

-- 5 
DELIMITER //
create trigger tr_novo_cliente
after insert on clientes for each row
begin
	insert into notificacoes (mensagem, data_notificacao) values ('Novo Cliente', now());
end
// DELIMITER ;

-- 6
DELIMITER //
create trigger tr_add_promo 
after insert on vendas for each row
begin
	if new.id_promocao != null then
		insert into notificacoes (mensagem, data_notificacao) values ('Venda com promocao', now());
	end if;
end
// DELIMITER ;

-- 7
DELIMITER //
create trigger tr_falta_estoque
before update on produtos for each row
begin

	if (select quantidade_estoque from produtos where id_produto = new.id_produto) <= 0
        then insert into notificacoes (mensagem, data_notificacao) values ('Falta no estoque', now());
	end if;
end
// DELIMITER ;

-- 8
DELIMITER //
create trigger tr_nova_venda_produto
before insert on vendas for each row
begin
	update produtos
		set valor_venda_total = valor_venda_total + new.valor_total
    where id_produto = new.id_produto;
end
// DELIMITER ;

-- 9
DELIMITER //
create trigger tr_alteracao_preco
before update on produtos for each row
begin

	if (select preco from produtos where id_produto = new.id_produto) != new.preco
        then insert into notificacoes (mensagem, data_notificacao) values ('Mudança no preço', now());
	end if;
end
// DELIMITER ;