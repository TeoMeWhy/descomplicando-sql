# Aula ao vivo!!

Aula ministrada no dia 11/05 ao vivo na LinuxTips.

Baixe os dados [aqui](https://drive.google.com/file/d/1YEohXFk7zSajy3Nitzi_svDnu9x4ZFn8/view?usp=sharing)!

## Sobre

Vamos explorar maneiras de se trabalhar com SQL em sua máquina local. A ideia é utilizar o VSCode como ambiente de programação, não apenas com SQL mas também com linguagem de programação, Python caso.

Essas dicas serão muito úteis para pessoas que buscam maior autonomia e indepedência em seus projetos na áera de dados. Isto é, conseguir realizar um fluxo (pipeline) de dados de início ao fim para agregar valor nos negócios.

## Notas

String de conexão
```python
str_con = "driver://user:pass@ip:port/schema"
```

Para SQLite:
```python
str_con = "sqlite:///database.db"
```

Para MariaDB/MySQL:
```python
str_con = "pymysql+pymysql://user:pass@ip:port/schema"
```