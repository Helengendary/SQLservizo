create database exercito;

use exercito;

create table soldado(
RM int not null primary key,
Nome varchar(255) not null,
DataNascimento datetime not null
) default charset utf8;

create table municao(
Municao varchar(255) not null,
idMunicao int not null primary key auto_increment
) default charset utf8;

create table arma(
idArma int not null primary key auto_increment,
Serie int not null,
Tipo varchar(255) not null,
Calibre float,
Municao int not null,
foreign key (Municao) references Municao(idMunicao)
)default charset utf8;

create table Limpar (
idSoldado int not null,
foreign key (idSoldado) references soldado(RM),
idArma int not null,
foreign key (idArma) references arma(idArma)
) default charset utf8;