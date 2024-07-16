--create database helendis
--use helendis

-- CRIAR TABELA
--create table colaborador (
--edv int not null primary key,
--nome varchar(60) not null, 
--idade int not null,
--salario float)

-- EXCLUIR TABELA
--drop table financeiro.colaborador

-- CRIAR ESQUEMA
 --create schema financeiro

-- CRIAR COM ESQUEMA
--create table financeiro.colaborador (
--edv int not null primary key,
--nome varchar(60) not null, 
--idade int not null,
--salario float)

--create schema aulas

--create table aulas.sala(
--idSala int not null primary key,
--nome varchar(60) not null, 
--capacidade int)

--insert into aulas.sala (idSala, nome, capacidade) values (1, 'sala de ti', 20)
--insert into aulas.sala values (2, 'sala reunião' , 10)
--insert into aulas.sala values (3, 'sala de palestras', 30), (4, 'sala de aula', 15)

--select * from aulas.sala order by capacidade desc

--create table aulas.evento (
--	idEvento int not null primary key,
--	idSala int not null foreign key references aulas.sala(idSala),
--	descricao varchar(255) not null,
--	inicio datetime not null,
--	fim datetime)

--insert into aulas.evento values (
--(select isnull(max(idEvento), 0) from aulas.evento)+ 1,
--4,
--'Aula de Iot',
-- mes antes do dia
--'03-26-2022 19:00', 
--'03-26-2022 22:30'
--)

--create table aulas.pessoa (
--	idPessoa int not null primary key, 
--	nome varchar(255),
--	categoria varchar(60))

--insert into aulas.pessoa values (
--	(select isnull(max(idEvento), 0) from aulas.evento) + 1,
--	'Helena Picinin de Lima',
--	'Documentação')

--create table aulas.eventoPessoa (
--	idEP int not null primary key,
--	idEvento int not null foreign key references aulas.evento(idEvento),
--	idPessoa int not null foreign key references aulas.pessoa(idPessoa),
--	papel varchar(255) not null,
--	presenca bit)

--insert into aulas.eventoPessoa values (
--	(select ISNULL(max(idEP), 0) from aulas.eventoPessoa)+1,
--	1,
--	2,
--	'Documentar',
--	1)

--create table aulas.equipamento (
--	idEquipamento int not null primary key,
--	idSala int foreign key references aulas.sala(idSala),
--	nome varchar(50),
--	tipo varchar(100))

--create table aulas.eventoEquipamento (
--	idEE int not null primary key,
--	idEquipamento int not null foreign key references aulas.equipamento(idEquipamento),
--	idEvento int not null foreign key references aulas.evento(idEvento))

select * from aulas.eventoEquipamento