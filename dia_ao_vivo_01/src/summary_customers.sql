SELECT t1.Name,
       count(distinct t2.IdTransaction) AS qtTransacao,
       sum(t2.Points) AS qtdPontos,
       sum(case when t2.Points > 0 then t2.Points else 0 end) AS qtdPontosPositivos,
       sum(case when t2.Points < 0 then t2.Points else 0 end) AS qtdPontosNegativos

FROM customers AS t1

LEFT JOIN transactions AS t2
ON t1.IdCustomer = t2.IdCustomer

WHERE t1.Name <> 'teomewhy'

GROUP BY t1.Name