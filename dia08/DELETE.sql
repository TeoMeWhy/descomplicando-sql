-- Databricks notebook source
DROP TABLE IF EXISTS sandbox.linuxtips.usuarios;

CREATE TABLE sandbox.linuxtips.usuarios (
    id int,
    nome string,
    idade int,
    profissao string
);

INSERT INTO sandbox.linuxtips.usuarios
VALUES (1, 'Téo', 31, 'Streamer'),
       (2, 'Nah', 32, 'Artesã'),
       (3, 'Mah', 17, 'Estudante'),
       (4, 'Ana', 27, 'Dev'),
       (5, 'João', 45, 'Dev'),
       (6, 'Marcelo', 12, 'Eng. Mecânico'),
       (7, 'Zé', 41, 'Streamer'),
       (8, 'Diná', 33, 'Eng. Mecânico'),
       (9, 'Carlos', 51, 'Analista Financeiro'),
       (10, 'Jeff', 23, 'Cientista de Dados'),
       (11, 'Alex', 18, 'Analista de Dados')
;

SELECT * FROM sandbox.linuxtips.usuarios;

-- COMMAND ----------

-- DBTITLE 1,DELETE SEM WHERE
DELETE FROM sandbox.linuxtips.usuarios

-- COMMAND ----------

-- DBTITLE 1,DELETE FROM WHERE
DELETE FROM sandbox.linuxtips.usuarios WHERE idade < 18

-- COMMAND ----------

DELETE FROM sandbox.linuxtips.usuarios WHERE idade > 40 and profissao = 'Streamer'

-- COMMAND ----------

DELETE FROM sandbox.linuxtips.usuarios WHERE idade > (SELECT AVG(idade) from sandbox.linuxtips.usuarios)

-- COMMAND ----------

SELECT * FROM sandbox.linuxtips.usuarios
