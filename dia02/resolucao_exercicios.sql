-- Databricks notebook source
-- MAGIC %md
-- MAGIC 
-- MAGIC # Exercícios de Fixação
-- MAGIC 
-- MAGIC ![Banco de dados Olist](https://github.com/TeoMeWhy/descomplicando-sql/blob/main/img/banco_olist.png?raw=true)
-- MAGIC 
-- MAGIC 1. Selecione todos os clientes paulistanos.
-- MAGIC 2. Selecione todos os clientes paulistas.
-- MAGIC 3. Selecione todos os vendedores cariocas e paulistas.
-- MAGIC 4. Selecione produtos de perfumaria e bebes com altura maior que 5cm.
-- MAGIC 5. Selecione os pedidos com mais de um item.
-- MAGIC 6. Selecione os pedidos que o frete é mais caro que o item.
-- MAGIC 7. Lista de pedidos que ainda não foram enviados.
-- MAGIC 8. Lista de pedidos que foram entregues com atraso.
-- MAGIC 9. Lista de pedidos que foram entregues com 2 dias de antecedência.
-- MAGIC 10. Selecione os pedidos feitos em dezembro de 2017 e entregues com atraso.
-- MAGIC 11. Selecione os pedidos com avaliação maior ou igual que 4.
-- MAGIC 12. Selecione pedidos pagos com cartão de crédito com duas ou mais parcelas menores que R$40,00.

-- COMMAND ----------

-- DBTITLE 1,Exercício 01
-- 1. Selecione todos os clientes paulistanos.

SELECT *

FROM silver.olist.cliente

WHERE descCidade = 'sao paulo'

-- COMMAND ----------

-- DBTITLE 1,Exercício 02
-- 2. Selecione todos os clientes paulistas.

SELECT *

FROM silver.olist.cliente

WHERE descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,Exercício 03
-- 3. Selecione todos os vendedores cariocas e paulistas.

SELECT *

FROM silver.olist.vendedor

WHERE descCidade = 'rio de janeiro'
OR descUF = 'SP'

-- COMMAND ----------

-- DBTITLE 1,Exercício 04
-- 4. Selecione produtos de perfumaria e bebes com altura maior que 5cm.

SELECT *

FROM silver.olist.produto

WHERE descCategoria IN ('perfumaria', 'bebes')
AND vlAlturaCm > 5

-- COMMAND ----------

-- DBTITLE 1,Exercício 05
-- 5. Selecione os pedidos com mais de um item.

SELECT *

FROM silver.olist.item_pedido

WHERE idPedidoItem > 1

-- COMMAND ----------

-- DBTITLE 1,Exercício 06
-- 6. Selecione os pedidos que o frete é mais caro que o item.

SELECT *

FROM silver.olist.item_pedido

WHERE vlFrete > vlPreco

-- COMMAND ----------

-- DBTITLE 1,Exercício 07
-- 7. Lista de pedidos que ainda não foram enviados.

SELECT *

FROM silver.olist.pedido

WHERE dtEnvio IS NULL

-- COMMAND ----------

-- DBTITLE 1,Exercício 08
-- 8. Lista de pedidos que foram entregues com atraso.

SELECT *

FROM silver.olist.pedido

WHERE date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,Exercício 09
-- 9. Lista de pedidos que foram entregues com 2 dias de antecedência.

SELECT *

FROM silver.olist.pedido

WHERE datediff(date(dtEstimativaEntrega), date(dtEntregue)) = 2

-- COMMAND ----------

-- DBTITLE 1,Exercício 10
-- 10. Selecione os pedidos feitos em dezembro de 2017 e entregues com atraso.

SELECT *

FROM silver.olist.pedido

WHERE year(dtPedido) = 2017
AND month(dtPedido) = 12
AND date(dtEntregue) > date(dtEstimativaEntrega)

-- COMMAND ----------

-- DBTITLE 1,Exercício 11
-- 11. Selecione os pedidos com avaliação maior ou igual que 4.

SELECT *
FROM silver.olist.avaliacao_pedido
WHERE vlNota >= 4

-- COMMAND ----------

-- DBTITLE 1,Exercício 12
-- 12. Selecione pedidos pagos com cartão de crédito com duas ou mais parcelas menores que R$40,00.

SELECT *

FROM silver.olist.pagamento_pedido

WHERE descTipoPagamento = 'credit_card'
AND nrPacelas >= 2
AND vlPagamento / nrPacelas < 40
