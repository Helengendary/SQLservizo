create database Familia;
use Familia;

create table tb_Pai (
	id int primary Key auto_increment,
    Nome varchar(255) not null);
    
create table tb_Filho (
	id int primary key auto_increment,
    Nome varchar(255) not null,
    pai int not null,
    foreign key (pai) references tb_pai(id)
		on delete cascade
        on update cascade);
        
insert into tb_Pai values (1, "Darth Vader"),
(2, "Goku"),
(3, "Vegeta"),
(4, "Seu Cebola"),
(5, "Zurg"),
(6, "Neymar");

insert into tb_Filho values (1, "Luke Skywalker", 1),
(2, 'Gohan', 2),
(3, 'Trunks', 3),
(4, 'Cebolinha', 4),
(5, 'Buzz Ligthyear', 5),
(6, 'Neymar Jr', 6);

drop table tb_filho;
drop table tb_pai;

select * from tb_pai;
select * from tb_filho; 

delete from tb_Filho where id = 4;
-- 1) não aconteceu nada com o Seu Cabola.

delete from tb_pai where id=6;
-- 2) apagou todos os filhos que estavam relacionados ao pai.alter

-- 3)
create table tb_Filho (
	id int primary key auto_increment,
    Nome varchar(255) not null,
    pai int,
    foreign key (pai) references tb_pai(id)
		on delete set null
        on update set null);
        
delete from tb_Filho where id = 4;
-- 4) Não aconteceu nada com o Seu Cebola

delete from tb_pai where id=1;
-- 5) O id do pai do luke ficou null

-- 6)
create table tb_Filho (
	id int primary key auto_increment,
    Nome varchar(255) not null,
    pai int not null,
    foreign key (pai) references tb_pai(id)
		on delete restrict
        on update restrict);
      
delete from tb_Filho where id = 4;
-- 7) Não aconteceu nada com o Seu Cebola

delete from tb_Pai where id=1;
-- 8) Não dá para apagar, pois tem uma restrição de chave estrangeira