USE ExemplosDapper
GO

CREATE TABLE dbo.Regioes(
	IdRegiao int NOT NULL,
	NomeRegiao varchar(20) NOT NULL,
	CONSTRAINT PK_Regioes PRIMARY KEY (IdRegiao)
)
GO

INSERT INTO dbo.Regioes(IdRegiao, NomeRegiao)
VALUES (1, 'Centro-Oeste')

INSERT INTO dbo.Regioes(IdRegiao, NomeRegiao)
VALUES (2, 'Nordeste')

INSERT INTO dbo.Regioes(IdRegiao, NomeRegiao)
VALUES (3, 'Norte')

INSERT INTO dbo.Regioes(IdRegiao, NomeRegiao)
VALUES (4, 'Sudeste')

INSERT INTO dbo.Regioes(IdRegiao, NomeRegiao)
VALUES (5, 'Sul')

GO

CREATE TABLE dbo.Estados(
	SiglaEstado char(2) NOT NULL,
	NomeEstado varchar(20) NOT NULL,
	NomeCapital varchar(20) NOT NULL,
	IdRegiao int NOT NULL,
	CONSTRAINT PK_Estados PRIMARY KEY (SiglaEstado),
	CONSTRAINT FK_Estado_Regiao FOREIGN KEY (IdRegiao) REFERENCES dbo.Regioes(IdRegiao)
)
GO

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('AC', 'Acre', 'Rio Branco', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('AL', 'Alagoas', 'Macei�', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('AP', 'Amap�', 'Macap�', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('AM', 'Amazonas', 'Manaus', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('BA', 'Bahia', 'Salvador', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('CE', 'Cear�', 'Fortaleza', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('DF', 'Distrito Federal', 'Bras�lia', 1)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('ES', 'Esp�rito Santo', 'Vit�ria', 4)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('GO', 'Goi�s', 'Goi�nia', 1)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('MA', 'Maranh�o', 'S�o Lu�s', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('MT', 'Mato Grosso', 'Cuiab�', 1)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('MS', 'Mato Grosso do Sul', 'Campo Grande', 1)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('MG', 'Minas Gerais', 'Belo Horizonte', 4)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('PA', 'Par�', 'Bel�m', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('PB', 'Para�ba', 'Jo�o Pessoa', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('PR', 'Paran�', 'Curitiba', 5)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('PE', 'Pernambuco', 'Recife', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('PI', 'Piau�', 'Teresina', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('RJ', 'Rio de Janeiro', 'Rio de Janeiro', 4)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('RN', 'Rio Grande do Norte', 'Natal', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('RS', 'Rio Grande do Sul', 'Porto Alegre', 5)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('RO', 'Rond�nia', 'Porto Velho', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('RR', 'Roraima', 'Boa Vista', 3)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('SC', 'Santa Catarina', 'Florian�polis', 5)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('SP', 'S�o Paulo', 'S�o Paulo', 4)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('SE', 'Sergipe', 'Aracaju', 2)

INSERT INTO dbo.Estados(SiglaEstado, NomeEstado, NomeCapital, IdRegiao)
VALUES ('TO', 'Tocantins', 'Palmas', 3)

GO


CREATE VIEW dbo.VW_DETALHESREGIOES
AS
SELECT R.IdRegiao, R.NomeRegiao, QtdEstados = COUNT(1)
FROM dbo.Regioes R
INNER JOIN dbo.Estados E ON E.IdRegiao = R.IdRegiao
GROUP BY R.IdRegiao, R.NomeRegiao
GO


CREATE PROCEDURE dbo.PRC_SEL_DETALHES_ESTADO
(
	@CodEstado char(2)
)
AS
BEGIN

	SELECT E.SiglaEstado, E.NomeEstado, E.NomeCapital,
	       R.NomeRegiao
	FROM dbo.Estados E
	INNER JOIN dbo.Regioes R ON R.IdRegiao = E.IdRegiao
	WHERE E.SiglaEstado = @CodEstado

END
GO


CREATE TABLE dbo.Produtos(
	IdProduto int IDENTITY(1,1) NOT NULL,
	NomeProduto varchar(50) NOT NULL,
	Preco numeric(10,2) NOT NULL,
	PrecoAnterior numeric(10,2) NULL,
	CONSTRAINT PK_Produtos PRIMARY KEY (IdProduto)
)
GO


CREATE PROCEDURE dbo.PRC_INS_PRODUTO
(
	@NomeProduto varchar(50),
	@Preco numeric(10,2),
	@IdProduto int OUTPUT
)
AS
BEGIN
	
	INSERT INTO dbo.Produtos(NomeProduto, Preco)
	VALUES(@NomeProduto, @Preco)

	SET @IdProduto = SCOPE_IDENTITY()

END
GO
