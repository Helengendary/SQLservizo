--create function fMesAno (@Data DateTime)
--returns varchar(7) as
--begin 
--	return(substring(convert(varchar(10), @Data, 103), 3, 10))
--end

--create function fEventoAntigo(@descEvento Varchar(255))
--returns table as
--return(select E.Descricao, S.Nome, sum(convert(int, EP.Presenca)) 'Qtd de pessoas', E.DtHrInicio, E.DtHrFim
--from Evento E
--	inner join EventoPessoa EP on E.IDEvento = EP.IDEvento
--	inner join Sala s on E.IDSala = S.IDSala
--where convert(varchar(10), DtHrInicio, 103) = (select top 1 convert(varchar(10), DtHrInicio, 103) from Evento where Descricao like '%'+@descEvento+'%' order by DtHrInicio asc) 
--and  Descricao like '%'+@descEvento+'%'
--group by E.Descricao, E.DtHrInicio, E.DtHrFim, S.Nome)

Select * from fEventoAntigo('Aula')
