--CREATE TABLE aulas.aluno( 
--	idAluno int identity(1,1) primary key not null,
--	nome varchar(255) not null,
--	idade int,
--	nacionalidade varchar(255) default 'Brasil',
--	check (idade>=18))

--insert into aulas.aluno values ('Helena', 18, 'au')
--insert into aulas.aluno (nome, idade) values ('JUJU', 38)
--insert into aulas.aluno (nome, idade) values ('Mari', 2)
--insert into aulas.aluno (nome, idade) values ('Ingri', 19)
--insert into aulas.aluno values ('Mile', 22, 'Hellolandia')
--insert into aulas.aluno values ('Mari', 18, 'barbielandia')

select * from aulas.aluno