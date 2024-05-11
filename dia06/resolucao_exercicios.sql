-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC # Exercícios de Fixação
-- MAGIC
-- MAGIC ![Banco de dados Olist](https://github.com/TeoMeWhy/descomplicando-sql/blob/main/img/banco_olist.png?raw=true)
-- MAGIC
-- MAGIC 1. Quais são os Top 5 vendedores campeões de vendas de cada UF?
-- MAGIC 2. Quais são os Top 5 vendedores campeões de vendas em cada categoria?
-- MAGIC 3. Qual é a Top 1 categoria de cada vendedor?
-- MAGIC 4. Quais são as Top 2 categorias que mais vendem para clientes de cada estado?
-- MAGIC 5. Quantidade acumulada de itens vendidos por categoria ao longo do tempo.
-- MAGIC 6. Receita acumulada por categoria ao longo do tempo.
-- MAGIC 7. **PLUS:** Selecione um dia de venda aleatório de cada vendedor.

-- COMMAND ----------

-- DBTITLE 1,Exercício 01
-- Quais são os Top 5 vendedores campeões de vendas de cada UF?

WITH tb_venda AS (

  SELECT 
         t1.idVendedor,
         t2.descUF,
         sum(t1.vlPreco) AS receitaVendedor,
         count(*) AS qtVendaItens,
         count(distinct idPedido) AS qtVendaPedido

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.vendedor AS t2
  ON t1.idVendedor = t2.idVendedor

  GROUP BY t1.idVendedor, t2.descUF
)

SELECT *,
       row_number() OVER (PARTITION BY descUF ORDER BY qtVendaPedido DESC) AS rnPedidos,
       row_number() OVER (PARTITION BY descUF ORDER BY receitaVendedor DESC) AS rnReceita

FROM tb_venda

QUALIFY rnPedidos <= 5

-- COMMAND ----------

-- DBTITLE 1,Exercício 02
-- Quais são os Top 5 vendedores campeões de vendas em cada categoria?

WITH tb_pedidos AS (

  SELECT idVendedor,
         descCategoria,
         count(distinct idPedido) AS qtPedido,
         count(*) AS qtItens

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto
  
  WHERE descCategoria IS NOT null

  GROUP BY idVendedor, descCategoria

)

SELECT *,
       row_number() OVER (PARTITION BY descCategoria ORDER BY qtItens DESC) AS rnItens

FROM tb_pedidos

QUALIFY rnItens <= 5

-- COMMAND ----------

-- DBTITLE 1,Exercício 03
-- Qual é a Top 1 categoria de cada vendedor?

WITH tb_itens AS (

  SELECT t1.idVendedor,
         t2.descCategoria,
         count(*) AS qtItem

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  WHERE t2.descCategoria IS NOT NULL

  GROUP BY t1.idVendedor, t2.descCategoria

)

SELECT *,
       row_number() OVER (PARTITION BY idVendedor ORDER BY qtItem DESC) AS rnItem

FROM tb_itens

QUALIFY rnItem = 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 04
-- Quais são as Top 2 categorias que mais vendem para clientes de cada estado?

WITH tb_completa AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  LEFT JOIN silver.olist.cliente AS t4
  ON t3.idCliente = t4.idCliente
  
  WHERE descCategoria IS NOT null

),

tb_group AS (

  SELECT descUF,
         descCategoria,
         count(*) AS qtItens

  FROM tb_completa

  GROUP BY descUF, descCategoria
  ORDER BY descUF, descCategoria

)

SELECT *,
       row_number() OVER (PARTITION BY descUF ORDER BY qtItens DESC, descCategoria ASC) AS rnItens

FROM tb_group

QUALIFY rnItens <= 2

-- COMMAND ----------

-- DBTITLE 1,Exercício 05
-- Quantidade acumulada de itens vendidos por categoria ao longo do tempo.

WITH tb_vendas AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE descCategoria IS NOT null

),

tb_group AS (

  SELECT descCategoria,
         date(dtPedido) as dataPedido,
         count(*) AS qtItens

  FROM tb_vendas

  GROUP BY descCategoria, dataPedido
  ORDER BY descCategoria, dataPedido

)

SELECT *,
       SUM(qtItens) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS qtAcumItens

FROM tb_group

-- COMMAND ----------

-- DBTITLE 1,Exercício 06
-- Receita acumulada por categoria ao longo do tempo

WITH tb_vendas AS (

  SELECT *

  FROM silver.olist.item_pedido AS t1

  LEFT JOIN silver.olist.produto AS t2
  ON t1.idProduto = t2.idProduto

  INNER JOIN silver.olist.pedido AS t3
  ON t1.idPedido = t3.idPedido

  WHERE descCategoria IS NOT null

),

tb_group AS (

  SELECT descCategoria,
         date(dtPedido) as dataPedido,
         sum(vlPreco) AS vlReceita

  FROM tb_vendas

  GROUP BY descCategoria, dataPedido
  ORDER BY descCategoria, dataPedido

)

SELECT *,
       SUM(vlReceita) OVER (PARTITION BY descCategoria ORDER BY dataPedido ASC) AS receitaAcum

FROM tb_group

-- COMMAND ----------

-- DBTITLE 1,Exercício 07 - PLUS
-- Selecione um dia de venda aleatório de cada vendedor.

WITH tb_dia_vendedor AS (

  SELECT DISTINCT t1.idVendedor,
        date(t2.dtPedido) AS dtPedido

  FROM silver.olist.item_pedido AS t1

  INNER JOIN silver.olist.pedido AS t2
  ON t1.idPedido = t2.idPedido

)

SELECT *,
       row_number() OVER (PARTITION BY idVendedor ORDER BY RAND()) AS rnVendedor

FROM tb_dia_vendedor

QUALIFY rnVendedor <= 2
