use Aula

--select *from Evento E
--	left join Sala A
--	on E.IDEvento = A.IDSala

--select * from Evento

-- BEM ESPECIFICO
--SELECT
--	E.IDEvento,
--	E.Descricao 'Descrição do Evento',
--	CONVERT(VARCHAR(10), E.DtHrInicio, 103) 'Data Início',
--  CONVERT(VARCHAR(5), E.DtHrInicio, 108) 'Hora Iníco',
--	CONVERT(VARCHAR(10), E.DtHrFim, 103) 'Data Fim',
--	CONVERT(VARCHAR(5), E.DtHrFim, 108) 'Hora Fim',
--	S.Nome 'Nome da Sala'
--FROM Evento E
--    LEFT JOIN Sala S
--    ON E.IDSala = S.IDSala
--WHERE GETDATE() between DtHrInicio and DtHrFim

-- TOP 3 MAIORES SALAS
--SELECT TOP 3 Nome 'Nome da sala', Capacidade FROM Sala ORDER BY Capacidade DESC 

-- MUDANDO PARA ALGUMA SALA SER USADA
--update Evento
--set DtHrFim = '07-16-2024 12:00',
--	DtHrInicio = '07-16-2024 08:00'
--where IDEvento = '09ZPN89RXV5B'

--select  P.Nome 'Nome do Responsável', 
--	E.Descricao	'Descrição do Evento', 
--	CONVERT(VARCHAR(10), E.DtHrInicio, 103) 'Data Início',
--	CONVERT(VARCHAR(5), E.DtHrInicio, 108) 'Hora Iníco',
--	CONVERT(VARCHAR(10), E.DtHrFim, 103) 'Data Fim',
--	CONVERT(VARCHAR(5), E.DtHrFim, 108) 'Hora Fim',
--	S.Nome 'Nome da Sala'
--from EventoPessoa EP
--	inner join Pessoa P on EP.IDPessoa = P.IDPessoa
--	inner join Evento E on EP.IDEvento = E.IDEvento
--	inner join Sala S on E.IDSala = S.IDSala
--WHERE EP.PapelEvento = 'Responsavel'

--select S.Nome 'Nome da Sala',
--	E.Descricao,
--	CONVERT(VARCHAR(10), E.DtHrInicio, 103) 'Data Início',
--	CONVERT(VARCHAR(10), E.DtHrFim, 103) 'Data Fim',
--	DATEDIFF(minute, E.DtHrInicio, E.DtHrFim) 'Minutos utilizados'
--from Evento E
--	inner join Sala S on E.IDSala = S.IDSala

-- Exercicio 3
--select S.Nome,
--	sum(DATEDIFF(minute, E.DtHrInicio, E.DtHrFim)) 'Minutos utilizados' 
--from Evento E
--	inner join Sala S on E.IDSala = S.IDSala
--group by S.Nome


-- Exercicio 4
--select P.Nome, 
--	sum(CONVERT(int, EP.Presenca)) 'Quantidade de Presença'
--from EventoPessoa EP
--	inner join Pessoa P on EP.IDPessoa = P.IDPessoa
--group by P.Nome

-- Exercicio 5
--select E.Descricao, S.Nome, sum(convert(int, EP.Presenca)) 'qtd presença',
--	case when sum(convert(int, EP.Presenca)) <= S.Capacidade  then 'Limite ok' else 'Ultrapassou o limite' end 'verificação'
--from EventoPessoa EP
--	inner join Evento E on EP.IDEvento = E.IDEvento
--	inner join Sala s on E.IDSala = S.IDSala
--group by S.Nome, S.Capacidade, E.Descricao

-- Exercicio 7
select E.IDEvento, E.Descricao, S.Nome, count(EP.presenca) 'qtd convites', sum(convert(int, EP.Presenca)) 'Qts presentes',
	case when sum(convert(int, EP.Presenca)) <= S.Capacidade  then 'Limite ok' else 'Ultrapassou o limite' end 'verificação',
	case when sum(convert(int, EP.Presenca)) <= S.Capacidade  and count(EP.Presenca) <= S.Capacidade  then 'Não passaria' else 'Passaria' end 'Passa ou não'
from EventoPessoa EP
	inner join Evento E on EP.IDEvento = E.IDEvento
	inner join Sala s on E.IDSala = S.IDSala
group by S.Nome, S.Capacidade, E.Descricao, E.IDEvento