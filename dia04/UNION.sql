-- Databricks notebook source
-- QUERY SP
(SELECT t2.idVendedor,
        t3.descUF,
        count(t1.idPedido),
        sum(t2.vlPreco)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'SP'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY count(t1.idPedido) DESC

LIMIT 5)

UNION ALL

-- QUERY RJ
(SELECT t2.idVendedor,
        t3.descUF,
        sum(t2.vlPreco),
        count(t1.idPedido)

FROM silver.olist.pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

WHERE year(dtPedido) = 2017
AND t3.descUF = 'RJ'

GROUP BY t2.idVendedor, t3.descUF

ORDER BY count(t1.idPedido) DESC

LIMIT 5)
