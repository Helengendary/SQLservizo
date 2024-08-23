create database db_loja;

use db_loja;
-- Estrutura da tabela `marcas`
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `marcas`
INSERT INTO `marcas` (`id`, `nome`) VALUES
(1, 'Toyota'),
(2, 'Honda'),
(3, 'Volkswagen'),
(4, 'Ford'),
(5, 'Chevrolet'),
(6, 'Mercedes-Benz'),
(7, 'BMW');

-- Estrutura da tabela `veiculos`
CREATE TABLE IF NOT EXISTS `veiculos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_marca` int(11) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `cor` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `veiculos`
INSERT INTO `veiculos` (`id`, `id_marca`, `modelo`, `ano`, `preco`, `cor`) VALUES
(1, 1, 'Corolla', 2020, '85000.00', 'Prata'),
(2, 2, 'Civic', 2019, '78000.00', 'Preto'),
(3, 3, 'Golf', 2018, '72000.00', 'Branco'),
(4, 4, 'Fusion', 2019, '79000.00', 'Azul'),
(5, 5, 'Cruze', 2021, '82000.00', 'Vermelho'),
(6, 6, 'Classe A', 2020, '90000.00', 'Branco'),
(7, 7, 'Série 3', 2019, '85000.00', 'Preto'),
(8, 1, 'Etios', 2017, '60000.00', 'Azul'),
(9, 4, 'Focus', 2018, '67000.00', NULL),
(10, 3, 'Gol', 2017, '55000.00', 'Vermelho'),
(11, 5, 'Onix', 2018, '63000.00', 'Preto'),
(12, 6, 'C180', 2019, '98000.00', 'Prata'),
(13, 7, 'X1', 2020, '93000.00', 'Branco'),
(14, 4, 'Ranger', 2019, '90000.00', NULL),
(15, 2, 'Civic', 2017, '70000.00', 'Prata');

-- Estrutura da tabela `clientes`
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `clientes`
INSERT INTO `clientes` (`id`, `nome`, `email`, `telefone`) VALUES
(1, 'João', 'joao@example.com', '(11) 9999-8888'),
(2, 'Maria', 'maria@example.com', '(11) 7777-6666'),
(3, 'Pedro', 'pedro@example.com', '(11) 5555-4444'),
(4, 'Ana', 'ana@example.com', '(11) 3333-2222'),
(5, 'Paula', NULL, '(11) 1111-0000'),
(6, 'Carlos', 'carlos@example.com', NULL);

-- Estrutura da tabela `vendas`
CREATE TABLE IF NOT EXISTS `vendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_veiculo` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `data_venda` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_veiculo` (`id_veiculo`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id`),
  CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dados da tabela `vendas`
INSERT INTO `vendas` (`id`, `id_veiculo`, `id_cliente`, `data_venda`) VALUES
(1, 1, 1, '2023-05-10'),
(2, 2, 3, '2023-06-15'),
(3, 3, 2, '2023-07-20'),
(4, 4, 4, '2023-08-25'),
(5, 5, 5, '2023-09-30'),
(6, 6, 6, '2023-10-05'),
(7, 7, 4, '2023-11-10'),
(8, 8, 2, '2023-12-15'),
(9, 9, 1, '2024-01-20'),
(10, 10, 3, '2024-02-25'),
(11, 11, 5, '2024-03-30'),
(12, 12, 6, '2024-04-05'),
(13, 13, 4, '2024-05-10'),
(14, 14, 2, '2024-06-15'),
(15, 15, 1, '2024-07-20');



DELIMITER // 
create procedure update_preco(idvei int)
begin
	start transaction;
		update veiculos set preco = 88000 where id = idvei;
    if ((select preco from veiculos where id = idvei) < 85000) then
		commit;
	else 
		rollback;
	end if;    
end
// DELIMITER ;

drop procedure update_preco;
call update_preco(8);
select * from veiculos;





DELIMITER //
create procedure inserir_cliente()
begin
	start transaction;
    
end
// DELIMITER ;