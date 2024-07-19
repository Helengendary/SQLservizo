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
--select E.IDEvento, E.Descricao, S.Nome, S.Capacidade, count(EP.presenca) 'qtd convites', sum(convert(int, EP.Presenca)) 'Qts presentes',
--from EventoPessoa EP
--	inner join Evento E on EP.IDEvento = E.IDEvento
--	inner join Sala s on E.IDSala = S.IDSala
--group by S.Nome, S.Capacidade, E.Descricao, E.IDEvento
--having sum(convert(int, EP.Presenca)) <= S.Capacidade  and count(EP.Presenca) >= S.Capacidade

-- Exercicio de modelagem - escola de música