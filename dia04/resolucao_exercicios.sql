-- Databricks notebook source
-- MAGIC %md
-- MAGIC 
-- MAGIC # Exercícios de Fixação
-- MAGIC 
-- MAGIC ![Banco de dados Olist](https://github.com/TeoMeWhy/descomplicando-sql/blob/main/img/banco_olist.png?raw=true)
-- MAGIC 
-- MAGIC 1. Qual categoria tem mais produtos vendidos?
-- MAGIC 2. Qual categoria tem produtos mais caros, em média? E Mediana?
-- MAGIC 3. Qual categoria tem maiores fretes, em média?
-- MAGIC 4. Os clientes de qual estado pagam mais frete, em média?
-- MAGIC 5. Clientes de quais estados avaliam melhor, em média? Proporção de 5?
-- MAGIC 6. Vendedores de quais estados têm as piores reputações?
-- MAGIC 7. Quais estados de clientes levam mais tempo para a mercadoria chegar?
-- MAGIC 8. Qual meio de pagamento é mais utilizado por clientes do RJ?
-- MAGIC 9. Qual estado sai mais ferramentas?
-- MAGIC 10. Qual estado tem mais compras por cliente?

-- COMMAND ----------

-- DBTITLE 1,Exercício 01
-- Qual categoria tem mais produtos vendidos?

SELECT t2.descCategoria,
       count(*) as qtdeCategoria
--        count(distinct idPedido) as qtdePedidos

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria
ORDER BY qtdeCategoria DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 02
-- Qual categoria tem produtos mais caros, em média? E Mediana?

SELECT t2.descCategoria,
       avg(vlPreco) AS avgPreco,
       percentile(vlPreco, 0.5) AS medianPreco

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria
ORDER BY medianPreco DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 03
-- Qual categoria tem maiores fretes, em média?

SELECT t2.descCategoria,
       avg(vlFrete) AS avgFrete

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

GROUP BY t2.descCategoria
ORDER BY avgFrete DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 04
-- Os clientes de qual estado pagam mais frete, em média?

SELECT 
       t3.descUF,
       sum(t1.vlFrete) / count(distinct t1.idPedido) as avgFrete,
       avg(t1.vlFrete) as avgFreteItem,
       sum(t1.vlFrete) / count(distinct t2.idCliente) as avgFreteCliente

FROM silver.olist.item_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF
ORDER BY avgFrete DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 05
-- Clientes de quais estados avaliam melhor, em média? Proporção de 5?

SELECT
      t3.descUF,
      avg(t1.vlNota) AS avgNota,
      avg(CASE WHEN t1.vlNota = 5 THEN 1 ELSE 0 END) AS prop5

FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

GROUP BY t3.descUF
ORDER BY avgNota DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 06
-- Vendedores de quais estados têm as piores reputações?

SELECT 
       t3.descUF,
       avg(t1.vlNota) AS avgNota
       
FROM silver.olist.avaliacao_pedido AS t1

INNER JOIN silver.olist.item_pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN silver.olist.vendedor AS t3
ON t2.idVendedor = t3.idVendedor

GROUP BY t3.descUF
ORDER BY avgNota

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 07
-- Quais estados de clientes levam mais tempo para a mercadoria chegar?

SELECT t2.descUF,
       avg(datediff(t1.dtEntregue, t1.dtPedido)) AS qtdeDias
       
FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

WHERE t1.dtEntregue IS NOT NULL

GROUP BY t2.descUF
ORDER BY qtdeDias DESC

-- COMMAND ----------

-- DBTITLE 1,Exercício 08
-- Qual meio de pagamento é mais utilizado por clientes do RJ?

SELECT 
      t1.descTipoPagamento,
      count(distinct t1.idPedido) AS qtdePedidos
      
FROM silver.olist.pagamento_pedido AS t1

INNER JOIN silver.olist.pedido AS t2
ON t1.idPedido = t2.idPedido

LEFT JOIN  silver.olist.cliente AS t3
ON t2.idCliente = t3.idCliente

WHERE t3.descUF = 'RJ'

GROUP BY t1.descTipoPagamento

ORDER BY qtdePedidos DESC

LIMIT 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 09
-- Qual estado sai mais ferramentas?

SELECT 
       t3.descUF,
       count(*) as qtdeProdutoVendido

FROM silver.olist.item_pedido AS t1

LEFT JOIN silver.olist.produto AS t2
ON t1.idProduto = t2.idProduto

LEFT JOIN silver.olist.vendedor AS t3
ON t1.idVendedor = t3.idVendedor

WHERE t2.descCategoria LIKE '%ferramentas%'

GROUP BY t3.descUF
ORDER BY qtdeProdutoVendido DESC

-- COMMAND ----------

-- DBTITLE 1,Exercício 10
-- Qual estado tem mais compras por cliente?

SELECT t2.descUF,
       count(distinct t1.idPedido) AS qtdePedido,
       count(distinct t2.idClienteUnico) AS qtdeClienteUnico,
       count(distinct t1.idPedido) / count(distinct t2.idClienteUnico) AS avgPedidoCliente

FROM silver.olist.pedido AS t1

LEFT JOIN silver.olist.cliente AS t2
ON t1.idCliente = t2.idCliente

GROUP BY t2.descUF
ORDER BY avgPedidoCliente DESC
