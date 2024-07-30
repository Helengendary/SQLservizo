create database escola;
use escola;

create table Aluno(
idAluno int not null primary key auto_increment,
Nome varchar(255) not null,
Idade int not null,
Sexo varchar(50) not null,
Instituicao varchar(255) not null,
Telefone varchar(20) not null) default charset utf8;

create table Professor(
idProfessor int not null primary key auto_increment,
Nome varchar(255) not null,
Sobrenome varchar(255) not null,
Telefone varchar(20) not null);

create table Aula(
idAula int not null primary key auto_increment,
idProfessor int not null,
foreign key (idProfessor) references Professor(idProfessor),
Dificuldade varchar(10) not null,
idSala int not null);