-- Databricks notebook source
-- MAGIC %md
-- MAGIC
-- MAGIC ## Exercícios de fixação
-- MAGIC
-- MAGIC ### 1. Crie uma tabela em sandbox.linuxtips com o seu nome. Exemplo: sandbox.linuxtips.teo_calvo. Esta tabela contém os seguintes campos:
-- MAGIC 	1. id -> inteiro
-- MAGIC 	2. nome -> string
-- MAGIC 	3. dt_nascimento -> date
-- MAGIC 	4. profissao -> string
-- MAGIC 	5. renda -> float
-- MAGIC 	6. uf -> string
-- MAGIC 	7. nacionalidade -> string
-- MAGIC
-- MAGIC ### 2. Insira nesta tabela criada os seguintes registros utilizando a cláusula INSERT INTO:
-- MAGIC
-- MAGIC - (1, Maria, 1989-01-18, Artesã, 1450.90, MG, Brasileira )
-- MAGIC - (2, José, 1987-06-25, Mecânico, 2756.87, SP, Brasileira )
-- MAGIC - (3, Manoel, 1995-09-13, Operador de máquinas pesadas, 3245.53, SP, Brasileira )
-- MAGIC - (4, Antônia, 1991-02-29, Tratorista, 3135.47, SC, Brasileira )
-- MAGIC - (5, Maria Eduarda, 1985-12-29, Serviço gerais, 1649.21, BA, Brasileira)
-- MAGIC - (6, João de Deus, 1999-03-14, Manobrista, 2375.78, PE, Brasileira)
-- MAGIC - (7, Eduardo, 2003-05-04, Atendente, 3157.06, AM, Haiti)
-- MAGIC - (8, Mônica, 2006-10-09, Estudante, 550.00, SP, Brasileira)
-- MAGIC - (9, Bruno, 1998-02-26, Encanador, 1459.98, MG, Brasileira)
-- MAGIC - (10, Letícia, 1982-04-01, Marceneira, 1698.74, SP, Angolana)
-- MAGIC - (11, Tomé, 1971-07-31, Porteiro, 2670.32, SP, Brasileira)
-- MAGIC
-- MAGIC ### 3. O atendente Eduardo, id=7, ganhou um aumento de 15% em seu salário. Precisamos atualizar seus dados. Pode fazer isso?
-- MAGIC ### 4. Maria Eduarda, id=5 foi promovida à copeira e seu novo salário será de R$2150,00. Vamos atualizar seus dados?
-- MAGIC ### 5. Manoel, id=3, saiu da empresa e solicitou a exclusão de seus dados. Como podemos fazer essa operação?
-- MAGIC ### 6. O salário mínimo nacional aumentou 5%, como podemos atualizar todos os salários da tabela?
-- MAGIC ### 7. O governo brasileiro está dando incentivo para empresas que valorizam a mão de obra imigrante. Portanto, todas as pessoas não brasileiras receberam um aumento de 2,5% em seus respectivos salários.## 

-- COMMAND ----------

-- DBTITLE 1,Exercício 01
DROP TABLE IF EXISTS sandbox.linuxtips.teo_calvo;

CREATE TABLE IF NOT EXISTS sandbox.linuxtips.teo_calvo (
  id int,
  nome string,
  dt_nascimento date,
  profissao string,
  renda float,
  uf string,
  nacionalidade string
);

-- COMMAND ----------

INSERT INTO sandbox.linuxtips.teo_calvo
VALUES
(1, "Maria", "1989-01-18", "Artesã", 1450.90, "MG", "Brasileira" ),
(2, "José", "1987-06-25", "Mecânico", 2756.87, "SP", "Brasileira" ),
(3, "Manoel", "1995-09-13", "Operador de máquinas pesadas", 3245.53, "SP", "Brasileira" ),
(4, "Antônia", "1991-02-28", "Tratorista", 3135.47, "SC", "Brasileira" ),
(5, "Maria Eduarda", "1985-12-29", "Serviço gerais", 1649.21, "BA", "Brasileira"),
(6, "João de Deus", "1999-03-14", "Manobrista", 2375.78, "PE", "Brasileira"),
(7, "Eduardo", "2003-05-04", "Atendente", 3157.06, "AM", "Haiti"),
(8, "Mônica", "2006-10-09", "Estudante", 550.00, "SP", "Brasileira"),
(9, "Bruno", "1998-02-26", "Encanador", 1459.98, "MG", "Brasileira"),
(10, "Letícia", "1982-04-01", "Marceneira", 1698.74, "SP", "Angolana"),
(11, "Tomé", "1971-07-31", "Porteiro", 2670.32, "SP", "Brasileira")

-- COMMAND ----------

-- DBTITLE 1,Exercício 03
UPDATE sandbox.linuxtips.teo_calvo SET renda = (select round(1.15*renda,2) from sandbox.linuxtips.teo_calvo where id=7)
WHERE id = 7

-- COMMAND ----------

-- DBTITLE 1,Exercício 04
UPDATE sandbox.linuxtips.teo_calvo SET renda = 2150, profissao = 'Copeira'
WHERE id = 5

-- COMMAND ----------

-- DBTITLE 1,Exercício 05
DELETE FROM sandbox.linuxtips.teo_calvo WHERE id=3

-- COMMAND ----------

-- DBTITLE 1,Exercício 06
UPDATE sandbox.linuxtips.teo_calvo SET renda = ROUND(renda * 1.05,2)

-- COMMAND ----------

-- DBTITLE 1,Exercício 07
UPDATE sandbox.linuxtips.teo_calvo SET renda = ROUND(renda * 1.025, 2)
WHERE nacionalidade != 'Brasileira'

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.teo_calvo
