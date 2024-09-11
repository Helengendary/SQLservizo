create database provaBanco;
use provaBanco;

CREATE TABLE Permissao (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(255),
    Nivel_permissao INTEGER
);

insert into Permissao values (default, "Permissao 1", 1), (default, "Permissao 2", 2), (default, "Permissao 3", 3), (default, "Permissao 4", 4), (default, "Permissao 5", 5);

CREATE TABLE Funcionario (
    id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    CPF VARCHAR(20) NOT NULL,
    Permissao INTEGER NOT NULL,
    FOREIGN KEY (Permissao) REFERENCES Permissao (id)
		ON DELETE SET NULL
);

insert into Funcionario values (default, 'Fulano', '12312312312', 1), (default, 'Ciclano', '32132132132', 5), (default, 'Beltrano', '21321321321', 2); 

CREATE TABLE Produtos (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255),
    Disponivel VARCHAR(20),
    DataInsercao DATE,
    quem_cadastrou INTEGER,
    FOREIGN KEY (quem_cadastrou) REFERENCES Funcionario (id)
		ON DELETE SET NULL
);

insert into Produtos values (default, 'Produto 1', 'disponivel', date(now()), 1), (default, 'Produto 2', 'indisponivel', date(now()), 1);

CREATE TABLE Vendas (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    quantidade_produto_vendido INTEGER,
    quem_vendeu INTEGER,
    FOREIGN KEY (quem_vendeu) REFERENCES Funcionario (id)
		ON DELETE SET NULL,
    produto_vendido INTEGER,
    FOREIGN KEY (produto_vendido) REFERENCES Produtos (id)
    ON DELETE SET NULL
);

insert into Vendas values (default, 2, 1, 2), (default, 1, 1, 1);

CREATE TABLE Solicitacao (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    Solicitou INTEGER,
    FOREIGN KEY (Autorizou) REFERENCES Funcionario (id)
		ON DELETE SET NULL,
    Descricao VARCHAR(255)
);

CREATE TABLE Autorizacao (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    Autorizou INTEGER,
    FOREIGN KEY (Autorizou) REFERENCES Funcionario (id)
		ON DELETE SET NULL,
    Autorizado INTEGER,
    FOREIGN KEY (Autorizado) REFERENCES Fucionario (id)
    ON DELETE SET NULL
);
  
insert into Autorizacao values (default, 2, 1);
  
  
-- Professor nenhuma dessas procedures vai funcionar, pois eu esqueci a sintace de como declarar um variável e de um update. Porém, a lógica funciona.
  
DELIMITER //
create procedure pr_insert_funcionario(nomei varchar(255), cpfi varchar(20), permissaoi int)
begin
	
declare 
	veri varchar(20);
    
    select @veri = cpfi;

start transaction;
	insert into funcionario values (default, nomei, cpfi, permissaoi);
	
    if veri in (select cpf from funcionario) then 
		select 'Não foi possível inserir';
		rollback;
	else
		select 'Inserido';
		commit;
	end if;
end
// DELIMITER ;

call  pr_insert_funcionario('Helena', '12312312312', 1);

select * from funcionario;





DELIMITER //
create procedure pr_disponibilidade(idFuncionario int, disponibilidade varchar(20), idProduto int)
begin
declare 
	permissao int;
    
    select @permissao = (select permissao from funcionario where id = idFuncionario);

start transaction;

update produtos
set Disponivel = disponibilidade
where id = idProduto;

if permissao > 2 then 
	commit;
else 
	rollback;
end if;
end
// DELIMITER ;

call pr_dispnibilidade(1, 'indisponível', 1);

select * from produtos;




DELIMITER //
create procedure pr_update_vendas(quem int)
begin

declare
	permissaoAutorizado int;
declare
    permissaoAutorizar int;

	permissaoAutorizado = (select permissao from funcionario where id = quem);
	permissaoAutorizar = (select permissao from funcionario where id = (select F.permissao from Autorizacao A inner join funcionario F on F.id = A.Autorizou where A.Autorizado = quem);

start transaction;

insert into Solicitacao values (default, quem, 'Atualizar vendas');

if permissaoAutorizado = 5 and permissaoAutorizar = 5 then 
	select 'Não tem autorização';
	rollback;
else 
	commit;
end if;
end
// DELIMITER ;

call pr_update_vendas(1);




DELIMITER //
create procedure pr_insert_produto(nomei varchar(255), disponibilidade varchar(20), quemi int, datainsei date)
begin
	
declare
	dataveri date;
    
    select @dataveri = datainsei;	
    
start transaction;
insert into produto values (dafault, disponibilidade, quemi, datainsei);

if dataveri = date(now()) then
	commit;
else
	rollback;
end if;
end
// DELIMITER ;

call pr_insert_produto('Produto 3', 'disponível', 2, 2021-09-11);
select * from produtos;



DELIMITER //
create procedure pr_nova_venda(quanti int, quem int, produtoi int)
begin
	
declare 
	veri varchar(20);
    select @veri = (select Disponivel from produtos where id = produtoi);

start transaction;
	insert into venda values (default, nomei, cpfi, permissaoi);
	
    if veri = 'indisponível' then 
		select 'Produto Indisponível';
		rollback;
	else
		select 'Venda realizado';
		commit;
	end if;
end
// DELIMITER ;

call pr_nova_venda(2,2,2);