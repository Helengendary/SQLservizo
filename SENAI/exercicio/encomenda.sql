create database ecommerce;
use ecommerce;

create table caminhao(
idCaminhao int not null primary key auto_increment,
Placa varchar(10) not null);

create table Viagem(
idViagem int not null primary key auto_increment,
idCaminhao int not null,
foreign key (idCaminhao) references caminhao(idCaminhao),
dataInicio datetime);

create table Loja(
idLoja int not null primary key auto_increment,
Nome varchar(50) not null,
Lugar varchar(255) not null);

create table LojaViagem(
idLojaViagem int not null,
idViagem int not null,
foreign key (idViagem) references Viagem(idViagem),
idLoja int not null,
foreign key (idLoja) references Loja(idLoja));

create table Encomenda(
idEncomenda int not null primary key auto_increment,
peso float not null,
dia datetime not null,
idViagem int not null,
foreign key (idViagem) references Viagem(idViagem));