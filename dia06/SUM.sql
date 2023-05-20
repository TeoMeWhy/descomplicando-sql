-- Databricks notebook source
WITH tb_receita_diaria AS (

  SELECT date(dtPedido) as dataPedido,
         sum(vlPreco) AS receitaDia

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

  GROUP BY dataPedido
  ORDER BY dataPedido

)

SELECT *,
       sum(receitaDia) OVER (PARTITION BY 1 ORDER BY dataPedido) AS receitaAcum
    

FROM tb_receita_diaria

-- COMMAND ----------

WITH tb_vendedor_dia AS (

  SELECT date(dtPedido) AS dataPedido,
         idVendedor,
         sum(vlPreco) AS vlReceita

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

  GROUP BY dataPedido, idVendedor
  ORDER BY idVendedor, dataPedido

)

SELECT *,
       sum(vlReceita) OVER (PARTITION BY idVendedor ORDER BY dataPedido) AS receitaAcum

FROM tb_vendedor_dia


