CREATE DATABASE db_biblioteca_jogos

USE db_biblioteca_jogos

CREATE TABLE Jogo(
	ID_Jogo INT PRIMARY KEY NOT NULL,
	Nome_Jogo VARCHAR(30) NOT NULL,
	ID_Tipo INT NOT NULL,
	ID_Empresa INT NOT NULL,
	ID_Modelo INT NOT NULL,
	Pre�o_Jogo FLOAT NOT NULL,
)
CREATE TABLE Tipo(
	ID_Tipo INT PRIMARY KEY NOT NULL,
	Nome_Tipo VARCHAR(30) NOT NULL,
	Classifica��o_Indicativa VARCHAR(10) NOT NULL
)

CREATE TABLE Empresa(
	ID_Empresa INT PRIMARY KEY NOT NULL,
	Nome_Empresa VARCHAR(30) NOT NULL
)

CREATE TABLE Modelo(
	ID_Modelo INT PRIMARY KEY NOT NULL,
	Tipo_Modelo VARCHAR(30) NOT NULL
)

INSERT INTO Tipo(ID_Tipo, Nome_Tipo, Classifica��o_Indicativa) VALUES
(1, 'Mundo Aberto', 'Livre'),
(2, 'FPS', '14'),
(3, 'Corrida', 'Livre'),
(4, 'Mundo Aberto / Viol�ncia', '18')

INSERT INTO Empresa(ID_Empresa, Nome_Empresa) VALUES
(1, 'Sony'),
(2, 'Microsoft'),
(3, 'Riot Games'),
(4, 'Mojang'),
(5, 'Rockstar Games'),
(6, 'Nintendo')

INSERT INTO Modelo(ID_Modelo, Tipo_Modelo) VALUES
(1, 'M�dia F�sica'),
(2, 'M�dia Digital')

INSERT INTO Jogo (ID_Jogo, Nome_Jogo, ID_Tipo, ID_Empresa, ID_Modelo, Pre�o_Jogo) VALUES
(1, 'God Of War 3', 4, 1, 2, 200.00),
(2, 'Call Of Duty Black Ops 6', 2, 2, 1, 300.00),
(3, 'Mario Kart', 3, 6, 2, 150.00),
(4, 'Valorant', 2, 3, 2, 0.00),
(5, 'Minecraft', 1, 4, 1, 0.00),
(6, 'GTA V', 4, 5, 1, 150.00)

ALTER TABLE Jogo
ADD CONSTRAINT FK_Jogo_Tipo FOREIGN KEY (ID_Tipo)
REFERENCES Tipo(ID_Tipo);

ALTER TABLE Jogo
ADD CONSTRAINT FK_Jogo_Empresa FOREIGN KEY (ID_Empresa)
REFERENCES Empresa(ID_Empresa);

ALTER TABLE Jogo
ADD CONSTRAINT FK_Jogo_Modelo FOREIGN KEY (ID_Modelo)
REFERENCES Modelo(ID_Modelo);

---------------------------------------------------------------------------------------------------------------

--VIEW
CREATE VIEW V_Empresas AS
SELECT
	E.Nome_Empresa,
	J.Nome_Jogo
FROM
	Empresa AS E
INNER JOIN
	Jogo AS J
	ON J.ID_Empresa = E.ID_Empresa

SELECT * FROM V_Empresas
--Cria uma View que mostra todos os jogos e suas respectivas empresas

--CTE's
WITH Pre�o_Total_Jogos([Pre�o Total])
AS
(
SELECT
	SUM(Pre�o_Jogo)
FROM
	Jogo
WHERE ID_Modelo = 2
)

SELECT * FROM Pre�o_Total_Jogos
--Cria um CTE que faz a soma do pre�o de todos os jogos que s�o de m�dia digital

--Functions
CREATE FUNCTION fn_JogosMundoAberto()
RETURNS TABLE
AS
RETURN(
	SELECT
		Nome_Jogo AS Nome,
		Pre�o_Jogo AS Pre�o
	FROM
		Jogo
	WHERE ID_Tipo = 1 OR ID_TIPO = 4
)

SELECT * FROM fn_JogosMundoAberto()
--Cria uma fun��o que mostra os nomes e os pre�os de jogos que sejam mundo aberto

--TRIGGERS
CREATE OR ALTER TRIGGER tg_mostra_inser��o
ON Jogo
	AFTER INSERT
AS
BEGIN
	DECLARE @jogo VARCHAR(30)
	SELECT @jogo = Nome_Jogo FROM Jogo ORDER BY ID_Jogo ASC

	PRINT CONCAT('O jogo ', @jogo, ' foi adicionado')
END

INSERT INTO Jogo(ID_Jogo, Nome_Jogo, ID_Tipo, ID_Empresa, ID_Modelo, Pre�o_Jogo) VALUES
(7, 'Hollow Knight', 1, 2, 2, 60.00)
--Cria um trigger em que ap�s adicionar um jogo no banco de dados mostra uma mensagem

--LOOPS
DECLARE @contador INT = 0
WHILE EXISTS (SELECT Nome_Jogo FROM Jogo WHERE Pre�o_Jogo > 150.00)
BEGIN
	DELETE 
	FROM Jogo
	WHERE Pre�o_Jogo > 150.00
	PRINT 'Jogos Deletados'
	SET @contador = @contador + 1
END
--Cria um Loop que deleta todos os jogos que custam mais de 150 reais

--WINDOWS FUNCTIONS
SELECT 
	DISTINCT Tipo.ID_Tipo,
	Tipo.Nome_Tipo,
	SUM(Jogo.Pre�o_Jogo) OVER (PARTITION BY Tipo.ID_Tipo) AS 'Soma Pre�os'
FROM
	Tipo
INNER JOIN Jogo
	ON Jogo.ID_Tipo = Tipo.ID_Tipo
--Cria um Windows Function que mostra a soma de pre�os de todos os jogos de cada categoria

--SUBQUERY


SELECT * FROM Jogo
SELECT * FROM Tipo
SELECT * FROM Empresa
SELECT * FROM Modelo