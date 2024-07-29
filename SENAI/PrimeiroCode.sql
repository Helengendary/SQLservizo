# create database dbAulita;

use dbAulita;

create table aluno (
idAluno int not null primary key auto_increment,
Nome varchar(255) not null,
Sobrenome varchar(255) not null,
DataNascimento datetime not null
) default charset utf8;

create table professor (
idProfessor int not null primary key auto_increment,
Nome varchar(255) not null,
Sobrenome varchar(255) not null,
DataNascimento datetime not null
) default charset utf8;

create table turmo (
idTurma int not null primary key auto_increment,
idAluno int not null,
foreign key (idAluno) references aluno(idAluno),
idProfessor int not null,
foreign key (idProfessor) references professor(idProfessor)
) default charset utf8;

select * from professor;
select * from turmo;