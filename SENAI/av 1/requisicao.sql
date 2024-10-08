create database autorizacao;

use autorizacao;

CREATE TABLE Cargos (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Cargo VARCHAR(255) NOT NULL
) DEFAULT CHARSET UTF8;

CREATE TABLE Perfil (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(255) NOT NULL,
Cargo INT NOT NULL,
FOREIGN KEY (Cargo) REFERENCES Cargos(ID),
Responsavel INT,
FOREIGN KEY (Responsavel) REFERENCES Perfil(ID)
) DEFAULT CHARSET UTF8;

CREATE TABLE Permissoes (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Perfil INT NOT NULL,
FOREIGN KEY (Perfil) REFERENCES Perfil(ID),
CargoAutorizado INT NOT NULL,
FOREIGN KEY (CargoAutorizado) REFERENCES Cargos(ID)
) DEFAULT CHARSET UTF8;

CREATE TABLE Requisicao (
ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Pedinte INT NOT NULL,
FOREIGN KEY (Pedinte) REFERENCES Perfil(ID),
PermissaoResponsavel INT NOT NULL,
FOREIGN KEY (PermissaoResponsavel) REFERENCES Permissoes(ID),
Valida VARCHAR(10) NOT NULL
) DEFAULT CHARSET UTF8;

SELECT * FROM Cargos;
SELECT * FROM Perfil;
SELECT * FROM Permissoes;
SELECT * FROM Requisicao;