create database floricultutra;
use floricultutra;

create table cliente (
idCliente int not null primary key auto_increment,
RG varchar(10) not null,
Nome varchar(255) not null,
Telefone varchar(11) not null,
Endereco varchar(255)
) default charset utf8;

create table Produto (
idProduto int not null primary key auto_increment,
Tipo varchar(10) not null,
Preco float not null,
QtdEstoque int,
Nome varchar(255)
) default charset utf8;

create table notaFiscal(
idNota int not null primary key auto_increment,
idCliente int not null,
foreign key (idCliente) references cliente(idCliente),
idProduto int not null,
foreign key (idProduto) references Produto(idProduto),
Quantidade int not null,
ValorTotal float
) default charset utf8;

show tables;