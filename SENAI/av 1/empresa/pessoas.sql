create database Empresa;

use Empresa;

CREATE TABLE Pessoas (
    ID INTEGER NOT NULL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
) DEFAULT CHARSET UTF8;

CREATE TABLE Telefones (
    ID INTEGER PRIMARY KEY NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Pessoa INTEGER NOT NULL,
    FOREIGN KEY (Pessoa) REFERENCES Pessoa(ID)
) DEFAULT CHARSET UTF8;

CREATE TABLE Locais (
    ID INTEGER PRIMARY KEY NOT NULL,
    Local VARCHAR(255) NOT NULL,
    Pessoa INTEGER NOT NULL,
    FOREIGN KEY (Pessoa) REFERENCES Pessoa(ID)
) DEFAULT CHARSET UTF8;