--select * from TABELA_DE_CLIENTES
--select * from TABELA_DE_PRODUTOS
--select * from TABELA_DE_VENDEDORES
--select * from ITENS_NOTAS_FISCAIS
--select * from NOTAS_FISCAIS

-- DESAFIO 1
--alter function fMesAnoUltrapassado(@AnoMes varchar(7))
--returns table as
--return(
--select NT.CPF, C.NOME, 
--	C.VOLUME_DE_COMPRA,
--	convert(varchar(7), NT.DATA_VENDA, 23) 'Mês ano', 
--	sum(I.QUANTIDADE) 'Quantidade Total',
--	case when sum(I.QUANTIDADE) > C.VOLUME_DE_COMPRA then 'VENDAS INVÁLIDAS' else 'VENDAS VÁLIDAS' end 'Resultado'
--from NOTAS_FISCAIS NT
--	inner join ITENS_NOTAS_FISCAIS I on NT.NUMERO = I.NUMERO
--	inner join TABELA_DE_CLIENTES C on NT.CPF = C.CPF
--where convert(varchar(7), NT.DATA_VENDA, 23) = @AnoMes
--group by NT.CPF, convert(varchar(7), NT.DATA_VENDA, 23), C.NOME, C.VOLUME_DE_COMPRA)
--select * from fMesAnoUltrapassado('2015-01')

-- DESAFIO 2

--alter function fqua ()
--returns float as
--begin 
--	return(select sum(QUANTIDADE) from ITENS_NOTAS_FISCAIS I inner join NOTAS_FISCAIS N on I.NUMERO = N.NUMERO where convert(varchar(4), N.DATA_VENDA, 23) = '2015')
--end

select P.SABOR, '2015' 'Ano', 
	sum(I.QUANTIDADE) 'Venda ano', 
	convert(dec(10,2), (sum(I.QUANTIDADE)*100)/dbo.fqua()) 'Percentual'
from TABELA_DE_PRODUTOS P
	inner join ITENS_NOTAS_FISCAIS I on P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
	inner join NOTAS_FISCAIS N on I.NUMERO = N.NUMERO
where convert(varchar(4), N.DATA_VENDA, 23) = '2015'
group by P.SABOR
order by sum(I.QUANTIDADE) desc