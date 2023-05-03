-- EXEMPLOS DE CONSULTAS SQL

USE sucos_vendas;

-- DUAS FORMAS DE FAZER A MESMA CONSULTA 
SELECT CPF, NOME, ENDERECO_1, ENDERECO_2, BAIRRO,CIDADE, ESTADO, CEP, DATA_DE_NASCIMENTO, IDADE, SEXO, LIMITE_DE_CREDITO, VOLUME_DE_COMPRA, PRIMEIRA_COMPRA
FROM TABELA_DE_CLIENTES;
SELECT * FROM TABELA_DE_CLIENTES;

-- USANDO ALIAS (MUDANDO NOME DO CAMPO) 
SELECT CPF AS IDENTIFICADOR, NOME AS CLIENTE 
FROM TABELA_DE_CLIENTES;

SELECT * FROM TABELA_DE_PRODUTOS;

-- SELECIONANDO POR ID 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE CODIGO_DO_PRODUTO = '1000889';

-- SELECIONANDO POR CAMPO 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'UVA';
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'LARANJA';

-- NO MYSQL NÃO A DIFERENCIAÇÃO DE CASE SENSITIVE 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE EMBALAGEM = 'PET';

SELECT * FROM TABELA_DE_PRODUTOS
WHERE EMBALAGEM = 'pet';

-- PARA FAZER UMA CONSULTA COM O CAMPO FLOAT HA PARTICULARIDADES --
-- ESSA CONSULTA RESULTA EM NADA 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE PRECO_DE_LISTA = 19.51;
-- FORMA CERTA DE FAZER 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE PRECO_DE_LISTA BETWEEN 19.50 AND 19.52;

 -- Consultas condicionais

-- SELECIONA TODOS QUE FOREM SABOR MANGA
-- SELECIONA TAMBEM TODOS QUE O TAMANHO FOR 470 ML
-- EXECUTA AS DUAS CONDIÇÕES

SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'MANGA' OR TAMANHO = '470 ml';

-- SELECIONA APENAS OS QUE FOREM DO SABOR MANGA E TIVEREM O TAMANHO 470 ML 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'MANGA' AND TAMANHO = '470 ml';

-- SELECIONA TODOS QUE >> NÃO << FOREM DO SABOR MANGA COM TAMANHO 470 ML
SELECT * FROM TABELA_DE_PRODUTOS
WHERE NOT (SABOR = 'MANGA' AND TAMANHO = '470 ml');

-- SELECIONA TODOS QUE >> NÃO << FOREM DO SABOR MANGA E NEM TIVEREM O TAMANHO 470 ML
SELECT * FROM TABELA_DE_PRODUTOS
WHERE NOT (SABOR = 'MANGA' OR TAMANHO = '470 ml');

-- SELECIONA TODOS QUE FOREM DO SABOR MANGA E >> NÃO << TIVEREM O TAMANHO 470 ML
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR = 'MANGA' AND NOT (TAMANHO = '470 ml');

-- EQUIVALE A ESTA CONTIDO SERIA O MESMO QUE (LARANJA OR MANGA) 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR IN ('LARANJA', 'MANGA');

SELECT * FROM TABELA_DE_CLIENTES 
WHERE CIDADE IN ('RIO DE JANEIRO','SÃO PAULO') AND IDADE >= 20;

SELECT * FROM TABELA_DE_CLIENTES 
WHERE CIDADE IN ('RIO DE JANEIRO','SÃO PAULO') AND (IDADE >= 20 AND IDADE <=22);

-- LIKE 

SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR LIKE '%MAÇÂ%';

SELECT * FROM TABELA_DE_PRODUTOS
WHERE SABOR LIKE '%MAÇA%' AND EMBALAGEM = 'PET';

SELECT * FROM TABELA_DE_CLIENTES
WHERE CIDADE LIKE '%PAULO%';

-- SELECIONANDO CLIENTES COM SOBRENOME MATTOS
SELECT * FROM TABELA_DE_CLIENTES
WHERE NOME LIKE '%MATTOS';


-- SELECIONANDO APENAS VALORES DIFERENTES DISTINCT 
SELECT EMBALAGEM, TAMANHO FROM TABELA_DE_PRODUTOS; -- SELECIONA TUDO 
SELECT DISTINCT EMBALAGEM, TAMANHO FROM TABELA_DE_PRODUTOS; -- SELECIONA APENAS OS COM VALORES DIFERENTES 

SELECT DISTINCT EMBALAGEM, TAMANHO, SABOR FROM TABELA_DE_PRODUTOS;

-- Quais são os bairros da cidade do Rio de Janeiro que possuem clientes? 
SELECT DISTINCT BAIRRO FROM tabela_de_clientes
WHERE CIDADE = 'RIO DE JANEIRO';

-- LIMITANDO SAIDA DA CONSULTA 
SELECT * FROM TABELA_DE_PRODUTOS;

-- SELECIONA APENAS OS 5 PRIMEIROS DADOS
SELECT * FROM TABELA_DE_PRODUTOS
LIMIT 5;

-- SELECIONANDO 3 RESULTADOS A PARTIR DO SEGUNDO (CONTAGEM COMEÇA DO ZERO) 
SELECT * FROM TABELA_DE_PRODUTOS 
LIMIT 2,3;

-- Queremos obter as 10 primeiras vendas do dia 01/01/2017. Qual seria o comando SQL para obter este resultado?
SELECT * FROM notas_fiscais
WHERE DATA_VENDA = '2017-01-01'
LIMIT 10;

-- ORDENANDO A SAIDA DA CONSULTA
SELECT * FROM TABELA_DE_PRODUTOS;

SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY PRECO_DE_LISTA; -- POR PADRÃO É (ASC) DO MENOR PARA O MAIOR

SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY PRECO_DE_LISTA DESC; -- DO MAIOR PARA O MENOR

SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY NOME_DO_PRODUTO;

SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY NOME_DO_PRODUTO DESC;

SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY EMBALAGEM, SABOR, PRECO_DE_LISTA; -- ORDENANDO POR EMBALAGEM, SABOR E PREÇO

-- EXEMPLO DE MISTURA DE ASC DESC
SELECT * FROM TABELA_DE_PRODUTOS
ORDER BY EMBALAGEM DESC, NOME_DO_PRODUTO ASC;


-- Qual (ou quais) foi (foram) a(s) maior(es) venda(s) 
-- do produto “Linha Refrescante - 1 Litro - Morango/Limão”, 
-- em quantidade? (Obtenha este resultado usando 2 SQLs).

-- LOCALIZANDO CODIGO DO PRODUTO 
SELECT * FROM TABELA_DE_PRODUTOS
WHERE NOME_DO_PRODUTO =  'Linha Refrescante - 1 Litro - Morango/Limão';

-- CODIGO ENCONTRADO 1101035 
-- OBTENDO A QUANTIDADE 
SELECT * FROM itens_notas_fiscais
WHERE CODIGO_DO_PRODUTO = '1101035'
ORDER BY QUANTIDADE DESC;

-- AGRUPANDO RESULTADOS 
SELECT * FROM TABELA_DE_CLIENTES;

SELECT ESTADO, LIMITE_DE_CREDITO FROM tabela_de_clientes;

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL -- ESCOLHE A COLUNA, A FUNÇÃO SUM(QUAL COLUNA SERÁ EXECUTADA A FUNÇÃO) E DEVE SER DADO UM NOME PARA NOVA COLUNA
FROM tabela_de_clientes -- DE QUAL TABELA SERA FEITA
GROUP BY ESTADO; -- POR QUAL COLUNA SERÁ AGRUPADA

SELECT EMBALAGEM, PRECO_DE_LISTA FROM tabela_de_produtos;

-- PEGANDO O MAIOR PREÇO POR EMBALAGEM
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA)  AS MAIOR_PRECO
FROM tabela_de_produtos
GROUP BY EMBALAGEM;
-- AJUSTANDO O ANTERIOR PARA PODER VER O NOME DO PRODUTO TAMBÉM
SELECT EMBALAGEM, NOME_DO_PRODUTO, MAX(PRECO_DE_LISTA)  AS MAIOR_PRECO
FROM tabela_de_produtos
GROUP BY EMBALAGEM;


-- PEGANDO A CONTAGEM DE CADA TIPO DE EMBALAGEM
SELECT EMBALAGEM, COUNT(*) AS CONTADOR
FROM tabela_de_produtos
GROUP BY EMBALAGEM;

-- SOMANDO O LIMITE DE CREDITO POR BAIRRO E FILTRANDO APENAS PARA CIDADE DO RIO DE JANEIRO
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE
FROM tabela_de_clientes
WHERE CIDADE = 'RIO DE JANEIRO'
GROUP BY BAIRRO;

-- SOMANDO O LIMITE DE CREDITO E MOSTRANDO AGRUPADO POR ESTADO E BAIRRO
SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE
FROM tabela_de_clientes
GROUP BY ESTADO, BAIRRO;

-- SOMANDO O LIMITE DE CREDITO E MOSTRANDO FILTRADO POR CIDADE, AGRUPADO POR ESTADO E BAIRRO E ORDENADO POR BAIRRO
SELECT ESTADO, BAIRRO, SUM(LIMITE_DE_CREDITO) AS LIMITE
FROM tabela_de_clientes
WHERE CIDADE = 'RIO DE JANEIRO'
GROUP BY ESTADO, BAIRRO
ORDER BY BAIRRO;

-- Quantos itens de venda existem para o produto '1101035' ?
SELECT * FROM itens_notas_fiscais;
-- descobrindo a maior quantidade de produtos em um pedido
SELECT MAX(QUANTIDADE) AS MAIOR_QUANTIDADE
FROM itens_notas_fiscais 
WHERE CODIGO_DO_PRODUTO = '1101035';
-- passando no parâmetro quantidade o valor encontrado no código anterior
SELECT COUNT(*) AS CONTAGEM
FROM itens_notas_fiscais 
WHERE codigo_do_produto = '1101035' AND QUANTIDADE = 99;



-- AGRUPANDO E FILTRANDO USANDO A CONDIÇÃO HAVING
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE FROM tabela_de_clientes
GROUP BY ESTADO;

-- NÃO FUNCIONARÁ POIS AO FAZER O WHERE OS VALORES NÃO FORAM AGRUPADOS AINDA
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE
FROM tabela_de_clientes
WHERE SOMA_LIMITE > 900000
GROUP BY ESTADO; 

-- SOLUÇÃO
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SOMA_LIMITE
FROM tabela_de_clientes
GROUP BY ESTADO
HAVING SUM(LIMITE_DE_CREDITO) > 900000;

SELECT EMBALAGEM, 
	MAX(PRECO_DE_LISTA) AS MAIOR_PRECO,
	MIN(PRECO_DE_LISTA) AS MENOR_PRECO
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM;

SELECT EMBALAGEM,
	MAX(PRECO_DE_LISTA),
    MIN(PRECO_DE_LISTA)
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM
HAVING SUM(PRECO_DE_LISTA) <= 80 AND MAX(PRECO_DE_LISTA) >= 5;

-- Quais foram os clientes que fizeram mais de 2000 compras em 2016?
-- ENCONTRANDO OS CPFS DOS CLIENTES

SELECT CPF, COUNT(*) FROM NOTAS_FISCAIS
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000;

-- ENCONTRANDO O NOME DOS CLIENTES
SELECT NOME, CPF FROM tabela_de_clientes
WHERE CPF = '3623344710' OR CPF = '492472718' OR CPF = '50534475787';


-- CASE (SUBSTITUINDO VALORES DA SAIDA)
SELECT * FROM tabela_de_produtos;

SELECT NOME_DO_PRODUTO, PRECO_DE_LISTA,
CASE 
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	ELSE 'PRODUTO BARATO'
END AS STATUS_PRECO
FROM tabela_de_produtos;


SELECT EMBALAGEM,
CASE 
	WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
	ELSE 'PRODUTO BARATO'
END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM tabela_de_produtos
GROUP BY EMBALAGEM,
		CASE 
			WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
			WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
			ELSE 'PRODUTO BARATO'
		END;


-- Veja o ano de nascimento dos clientes e classifique-os como: 
-- Nascidos antes de 1990 são velhos, 
-- nascidos entre 1990 e 1995 são jovens 
-- e nascidos depois de 1995 são crianças. 
-- Liste o nome do cliente e esta classificação.

SELECT * FROM tabela_de_clientes;

-- SOLUÇÃO PROPOSTA

SELECT NOME,
CASE WHEN YEAR(data_de_nascimento) < 1990 THEN 'Velho'
WHEN YEAR(data_de_nascimento) >= 1990 AND
YEAR(data_de_nascimento) <= 1995 THEN 'Jovens' 
ELSE 'Crianças' 
END  AS "CLASSIFICAÇÃO POR IDADE"
FROM tabela_de_clientes;

-- MINHA SOLUÇÃO (COMPOSTA)

SELECT NOME, YEAR(DATA_DE_NASCIMENTO) AS ANO,
CASE
	WHEN YEAR(DATA_DE_NASCIMENTO) <= '1990' THEN 'VELHOS'
    WHEN YEAR(DATA_DE_NASCIMENTO) <= '1995' AND YEAR(DATA_DE_NASCIMENTO) > '1990' THEN 'JOVENS'
    ELSE 'CRIANÇAS'
END AS 'CLASSIFICAÇÃO POR IDADE'
FROM tabela_de_clientes
ORDER BY YEAR(DATA_DE_NASCIMENTO), NOME;


-- JOIN'S
SELECT * FROM tabela_de_vendedores;
SELECT * FROM notas_fiscais;

-- INNER JOIN 
-- TRAZ APENAS O QUE TIVER RELAÇÃO NAS DUAS TABELAS
SELECT * FROM tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA;

SELECT A.MATRICULA, A.NOME, COUNT(*) 
FROM tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.MATRICULA, A.NOME;

-- Obtenha o faturamento anual da empresa. 
-- Leve em consideração que o valor financeiro das vendas consiste em 
-- multiplicar a quantidade pelo preço.

SELECT year(DATA_VENDA), SUM(QUANTIDADE * PRECO) AS FATURAMENTO
FROM notas_fiscais AS NF
INNER JOIN itens_notas_fiscais AS INF
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA_VENDA);

-- LEFT JOIN
-- MOSTRA TODOS OS RESULTADOS DA PRIMEIRA COM APENAS OS CORRESPONDENTES DA SEGUNDA TABELA

-- CONTANDO O NUMERO DE CLIENTES CADASTRADOS (15)
SELECT COUNT(*) FROM tabela_de_clientes;

-- CONTANDO O NÚMERO DE NOTAS (14) OU SEJA 01 CLIENTE NUNCA COMPROU NADA
SELECT CPF, COUNT(*) FROM notas_fiscais
GROUP BY CPF;

-- SOLUÇÃO NÃO PERFEITA (POIS SO APARECEÇA QUEM TEM RELAÇÃO NAS DUAS TABELAS)
SELECT DISTINCT A.CPF, A.NOME, B.CPF
FROM tabela_de_clientes A
INNER JOIN notas_fiscais B 
ON A.CPF = B.CPF;

-- APLICANDO O LEFT INNER JOIN ( ACHANDO O CLIENTE QUE NÃO TEM NOTA FISCAL)
SELECT DISTINCT A.CPF, A.NOME, B.CPF
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B 
ON A.CPF = B.CPF;

-- OUTRA FORMA MAIS ACERTIVA AINDA
SELECT DISTINCT A.CPF, A.NOME, B.CPF
FROM tabela_de_clientes A
LEFT JOIN notas_fiscais B
ON A.CPF = B.CPF
WHERE B.CPF IS NULL; -- PROCURAR CPFS QUE ESTÃO NULOS (CLIENTES CADASTRADOS QUE NÃO TEM NOTAS)

-- FULL E CROSS JOIN

SELECT * FROM tabela_de_vendedores;
SELECT * FROM tabela_de_clientes;

SELECT *FROM tabela_de_vendedores
INNER JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
INNER JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO; -- TRAZ OS APENAS VENDEDORES COM CLIENTES EM SEUS RESPECTIVOS BAIRROS

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
LEFT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO; -- TRAZ TODOS OS VENDEDORES MESMO OS QUE NÃO TEM CLIENTES EM SEUS BAIRROS

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
RIGHT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO; -- TRAZ TODOS OS CLIENTES MESMO OS QUE NÃO TEM VENDEDORES NOS SEU BAIRROS

-- ATENÇÃO NO FULL JOIN POIS O MYSQL NÃO SUPORTA CÓDIGO NÃO FUNCIONARÁ)
SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
FULL JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO; -- TRAZ TODOS OS CLIENTES MESMO OS QUE NÃO TEM VENDEDORES NOS SEU BAIRROS

-- FULL JOIN (USANDO UNION) FAZER O LEFT JOIN E DEPOIS UM RIGHT JOIN

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
LEFT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO -- TRAZ TODOS OS VENDEDORES MESMO OS QUE NÃO TEM CLIENTES EM SEUS BAIRROS
UNION
SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, tabela_de_vendedores.DE_FERIAS
FROM tabela_de_vendedores
RIGHT JOIN tabela_de_clientes
ON tabela_de_vendedores.BAIRRO = tabela_de_clientes.BAIRRO; -- TRAZ TODOS OS CLIENTES MESMO OS QUE NÃO TEM VENDEDORES NOS SEU BAIRROS


-- CROSS JOIN FAZ UMA ANALISE COMBINATORIA DE TODOS OS BAIRROS DE VENDEDORES COM OS BAIRROS DE CLIENTES
SELECT tabela_de_vendedores.BAIRRO, 
tabela_de_vendedores.NOME, DE_FERIAS,
tabela_de_clientes.BAIRRO, 
tabela_de_clientes.NOME 
FROM tabela_de_vendedores, tabela_de_clientes; -- JUNTA AS DUAS TABELAS


-- UNION (JA APLICA O DISTINCT SOZINHO POR PADRÃO)

SELECT DISTINCT BAIRRO FROM TABELA_DE_CLIENTES;
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

-- APLICANDO UNION
SELECT  BAIRRO FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

-- APLICANDO UNION ALL (APARECERÁ AS REPETIÇÕES)
SELECT  BAIRRO FROM TABELA_DE_CLIENTES
UNION ALL
SELECT DISTINCT BAIRRO FROM TABELA_DE_VENDEDORES;

-- SEPARANDO OS TIPOS DIFERENTES
SELECT  BAIRRO, NOME, 'CLIENTE' AS TIPO FROM TABELA_DE_CLIENTES
UNION
SELECT DISTINCT BAIRRO, NOME, 'VENDEDOR' AS TIPO FROM TABELA_DE_VENDEDORES;


-- SUBCONSULTAS CONSULTA DENTRO DE OUTRA CONSULTA
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

-- VAI SELECIONAR APENAS OS CLIENTES QUE MORAM NOS BAIRROS ONDE HA ESCRITORIO DOS VENDEDORES
SELECT * FROM tabela_de_clientes
WHERE BAIRRO IN(SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);

SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS PRECO_MAXIMO FROM tabela_de_produtos
GROUP BY EMBALAGEM) X WHERE X.PRECO_MAXIMO >= 10;

-- Qual seria a consulta usando subconsulta que seria equivalente a:
  SELECT CPF, COUNT(*) FROM notas_fiscais
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF
  HAVING COUNT(*) > 2000;

-- RESPOSTA   
SELECT X.CPF, X.CONTADOR FROM 
(SELECT CPF, COUNT(*) AS CONTADOR FROM notas_fiscais
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF) X WHERE X.CONTADOR > 2000;
  
-- VIEWS (TABELA LÓGICA)
-- CRIADO A VIEW vw_maiores_embalagens A APARTIR DO SELECT ABAIXO
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO
FROM TABELA_DE_PRODUTOS
GROUP BY EMBALAGEM;

-- EXEMPLOS DE USO DA VIEW 
SELECT X.EMBALAGEM, X.MAIOR_PRECO 
FROM VW_MAIORES_EMBALAGENS X WHERE X.MAIOR_PRECO >=10;

SELECT A.NOME_DO_PRODUTO, A.PRECO_DE_LISTA, X.MAIOR_PRECO,
((A.PRECO_DE_LISTA / X.MAIOR_PRECO)-1) * 100 AS PERCENTUAL
FROM tabela_de_produtos AS A
INNER JOIN VW_MAIORES_EMBALAGENS AS X
ON A.EMBALAGEM = X.EMBALAGEM;