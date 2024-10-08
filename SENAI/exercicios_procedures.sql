-- Criação do banco de dados


CREATE DATABASE DetranDB;
drop database detrandb;
USE DetranDB;

-- Tabela para registrar proprietários
CREATE TABLE Proprietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    pontos_cartreira INT DEFAULT 0
);

-- Tabela para registrar veículos
CREATE TABLE Veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(255) NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    placa VARCHAR(7) UNIQUE NOT NULL,
    ano INT,
    proprietario_id INT,
    FOREIGN KEY (proprietario_id) REFERENCES Proprietarios(id)
		on delete set null
);

-- Tabela para registrar infrações de trânsito
CREATE TABLE Infracoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    gravidade ENUM('Leve', 'Média', 'Grave', 'Gravíssima'),
    data_ocorrencia DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
);

-- Tabela para registrar licenciamentos dos veículos
CREATE TABLE Licenciamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_validade DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
		on delete set null
);

-- Tabela para registrar multas aplicadas
CREATE TABLE Multas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    pontos INT DEFAULT 0,
    data_aplicacao DATE NOT NULL,
    infracao_id INT,
    FOREIGN KEY (infracao_id) REFERENCES Infracoes(id)
);

CREATE TABLE Notificacoes(
	id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem varchar(255),
    data date
);

-- Inserção de dados nas tabelas
-- Proprietarios
INSERT INTO Proprietarios (nome, cpf, endereco, telefone) VALUES
('João Silva', '12345678901', 'Rua A, 123', '(11) 1234-5678'),
('Maria Oliveira', '98765432101', 'Rua B, 456', '(11) 9876-5432'),
('Carlos Souza', '11122233344', 'Rua C, 789', '(11) 1111-2222'),
('Ana Lima', '55566677788', 'Rua D, 1011', '(11) 5555-6666'),
('Pedro Costa', '99988877766', 'Rua E, 1213', '(11) 9999-8888');

-- Veiculos
INSERT INTO Veiculos (marca, modelo, placa, ano, proprietario_id) VALUES
('Fiat', 'Uno', 'ABC1234', 2020, 1),
('Volkswagen', 'Gol', 'DEF5678', 2018, 2),
('Chevrolet', 'Onix', 'GHI9101', 2021, 3),
('Ford', 'Ka', 'JKL1112', 2019, 4),
('Honda', 'Civic', 'MNO1314', 2022, 5),
('Toyota', 'Corolla', 'PQR1516', 2020, 1),
('Hyundai', 'HB20', 'STU1718', 2017, 2),
('Renault', 'Kwid', 'VWX1920', 2018, 3),
('Nissan', 'Versa', 'YZA2122', 2019, 4),
('Jeep', 'Compass', 'BCD2324', 2021, 5);

-- Infracoes
INSERT INTO Infracoes (descricao, gravidade, data_ocorrencia, veiculo_id) VALUES
('Excesso de velocidade', 'Média', '2024-04-20', 1),
('Estacionamento irregular', 'Leve', '2024-04-21', 2),
('Ultrapassagem em local proibido', 'Grave', '2024-04-22', 3),
('Falta de cinto de segurança', 'Leve', '2024-04-23', 4),
('Dirigir sob efeito de álcool', 'Gravíssima', '2024-04-24', 5),
('Uso de celular ao volante', 'Média', '2024-04-25', 6),
('Não respeitar a sinalização', 'Grave', '2024-04-26', 7),
('Estacionamento em vaga de idoso', 'Leve', '2024-04-27', 8),
('Falta de inspeção veicular', 'Grave', '2024-04-28', 9),
('Excesso de lotação', 'Média', '2024-04-29', 10);

-- Licenciamentos
INSERT INTO Licenciamentos (data_validade, veiculo_id) VALUES
('2024-04-30', 1),
('2023-05-01', 2),
('2023-05-02', 3),
('2024-05-03', 4),
('2023-05-04', 5),
('2024-05-05', 6),
('2025-05-06', 7),
('2012-05-07', 8),
('2022-05-08', 9),
('2008-05-09', 10);

-- Multas
INSERT INTO Multas (valor, pontos, data_aplicacao, infracao_id) VALUES
(150.00, 5, '2024-04-20', 1),
(100.00, 3, '2024-04-21', 2),
(500.00, 7, '2024-04-22', 3),
(80.00, 2, '2024-04-23', 4),
(2000.00, 10, '2024-04-24', 5),
(130.00, 4, '2024-04-25', 6),
(500.00, 7, '2024-04-26', 7),
(50.00, 2, '2024-04-27', 8),
(250.00, 6, '2024-04-28', 9),
(120.00, 4, '2024-04-29', 10);



-- Inserir um novo veículo e seu proprietário (com trigger)
DELIMITER //
create procedure inserir_veiculo(marca varchar(30), modelo varchar(30), placa varchar(8), ano int, proprietario_id int)
begin
	insert into veiculos (id, marca, modelo, placa, ano, proprietario_id) values (default, marca, modelo, placa, ano, proprietario_id);
end
// DELIMITER ;

DELIMITER //
create trigger tr_novo_veiculo
after insert on veiculos for each row
begin
	insert into notificacoes values (default, concat(new.modelo , " cadastrado pelo proprietário ", (select nome from proprietarios where new.proprietario_id = id)), now());
end
// DELIMITER ;

call inserir_veiculo("Ford", "Fiesta", "abc3333", 3000, 1);
select * from notificacoes;


-- Deletar um veículo e suas multas associadas (com trigger)
DELIMITER //
create procedure deletar_veiculos(id_vei int)
begin
	delete from veiculos where id = id_vei;	
end
// DELIMITER ;

DELIMITER //
create trigger tr_deletar_multas
before delete on infracoes for each row
begin
	delete from multas where infracao_id = old.id;
end
// DELIMITER ;

DELIMITER //
create trigger tr_deletar_infracao
before delete on veiculos for each row
begin 
	delete from infracoes where veiculo_id = old.id;
end
// DELIMITER ;

drop trigger tr_deletar_multas;
drop trigger tr_deletar_infracao;

select * from veiculos;
call deletar_veiculos(1);
select * from infracoes;
select * from multas;


-- Inserir uma nova infração e atualizar multas associadas (com trigger)
DELIMITER //
// DELIMITER ;

-- Atualizar pontos na carteira de um proprietário específico que levou uma multa(com trigger)
DELIMITER //

// DELIMITER ;

-- Deletar um proprietário e seus veículos associados (com trigger)
DELIMITER //
// DELIMITER ;

-- Selecionar veículos com licenciamento expirado

DELIMITER //
create procedure licenciamento_vencido ()
begin
	select V.modelo, L.data_validade from licenciamentos L
		inner join veiculos V on L.veiculo_id = V.id
	where curdate() > L.data_validade;
end
// DELIMITER ;

call licencimento_vencido();

-- Selecionar veículos que possuem multas graves
DELIMITER //
create procedure graves()
begin
	select V.modelo, I.descricao from infracoes I 
		inner join veiculos V on I.veiculo_id = V.id
	where I.gravidade = 'Grave';
end
// DELIMITER ;

call graves();



-- Selecionar veículos acima de 2021 
DELIMITER //
create procedure acima_21()
begin
	select * from veiculos where ano > 2021;
end
// DELIMITER ;

select * from veiculos;
call acima_21();





-- Selecionar multas de veículos abaixo de 2020
DELIMITER //
create procedure multas_baixo_20 ()
begin 
	select I.descricao from infracoes I
		inner join veiculos V on I.veiculo_id = V.id
	where V.ano < 2020;
end
// DELIMITER ;

call multas_baixo_20();



-- Selecionar todos os veículos com multas pendentes
DELIMITER //
create procedure multas_pendentes ()
begin
	select * from multas
	where data_aplicacao < now();
end
// DELIMITER ;

call multas_pendentes();






-- Inserir um novo proprietário
DELIMITER //
create procedure novo_propri(nome varchar(255), cpf varchar(11), endereco varchar(255), telefone varchar(20), pontos_carteira int)
begin
	insert into proprietarios values (default, nome, cpf, endereco, telefone, pontos_carteira);
end
// DELIMITER ;

call novo_propri('Helena de Lima', '12345678910', 'Rua da alegria', '91234-1234', 20);
select * from proprietarios;




-- Atualizar informações de um proprietário
DELIMITER //
create procedure update_propri (objeto varchar(255), valor varchar(255), idpro int)
begin 
	update proprietarios
	set objeto = valor
    where id = idpro;
end
// DELIMITER ;







-- Deletar um proprietário
DELIMITER //
create procedure deletar_propri (idpro int)
begin
	delete from proprietarios where id = idpro;
end
// DELIMITER ;






-- Selecionar todos os proprietários
DELIMITER //
create procedure all_propri ()
begin 
	select * from proprietarios;
end
// DELIMITER ;

call all_propri();




-- Inserir uma nova infração
DELIMITER //
create procedure nova_infracao (descricao varchar(255), gravidade ENUM('Leve', 'Média', 'Grave', 'Gravíssima'), dataoc DATE, veiculo INT)
begin 
	insert into infracoes values (default, descricao, gravidade, dataoc, veiculo);
end
// DELIMITER ;





-- Atualizar informações de uma infração
DELIMITER //
create procedure update_infracao (coluna varchar(30), valor varchar (255), idinfra int)
begin
	update infracao 
    set coluna = valor
    where id = idinfra;
end
// DELIMITER ;




-- Deletar uma infração
DELIMITER //
create procedure deletar_infracao(idinfra int)
begin
	delete from infracoes where id = idinfra;
end
// DELIMITER ;





-- Selecionar todas as infrações
DELIMITER //
create procedure all_infracao ()
begin
	select * from infracoes;
end
// DELIMITER 






-- Inserir um novo licenciamento
DELIMITER //
create procedure novo_licenciamento(dataval date, veiculo int)
begin
	insert into licenciamento values (default, dataval, veiculo);
end
// DELIMITER ;






-- Atualizar informações de um licenciamento
DELIMITER //
create procedure update_licenciamento (coluna varchar(20), valor varchar(20), idlic int)
begin
	update licenciamentos 
    set coluna = valor 
    where id = idlic;
end
// DELIMITER ;