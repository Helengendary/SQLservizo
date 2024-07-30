create database hospital;

use hospital;

show tables;

create table Medico(
Nome varchar(255) not null,
CRM int primary key not null,
Especialidade varchar(255) not null);

create table Paciente (
Endereco varchar(255) not null,
Nome varchar(255) not null,
idPaciente int primary key auto_increment not null,
idade int not null,
Registro varchar(255) not null) default charset utf8;

create table Receita(
idMedico int not null,
foreign key (idMedico) references Medico(CRM),
idPaciente int not null,
foreign key (idPaciente) references Paciente(idPaciente),
idReceita int not null primary key auto_increment,
Descricao varchar(255) not null,
DataRealizacao datetime not null);

create table Medicamentos (
Numero int not null,
foreign key (Numero) references Receita(idReceita),
Medicamento varchar(255) not null,
Quantidade int not null) default charset utf8;