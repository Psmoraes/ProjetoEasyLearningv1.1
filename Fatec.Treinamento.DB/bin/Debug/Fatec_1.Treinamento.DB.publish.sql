﻿/*
Script de implantação para master

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "master"
:setvar DefaultFilePrefix "master"
:setvar DefaultDataPath "G:\Users\Fábio\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "G:\Users\Fábio\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Detecta o modo SQLCMD e desabilita a execução do script se o modo SQLCMD não tiver suporte.
Para reabilitar o script após habilitar o modo SQLCMD, execute o comando a seguir:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'O modo SQLCMD deve ser habilitado para executar esse script com êxito.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'A operação de refatoração Renomear com chave 86c58755-6927-4c88-936d-6d33d9d2742a foi ignorada; o elemento [dbo].[Video].[CodigoYouTube] (SqlSimpleColumn) não será renomeado para CodigoYoutube';


GO
PRINT N'Criando [dbo].[Assunto]...';


GO
CREATE TABLE [dbo].[Assunto] (
    [Id]   INT           IDENTITY (1, 1) NOT NULL,
    [Nome] VARCHAR (100) NULL,
    CONSTRAINT [PK_Assunto] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Capitulo]...';


GO
CREATE TABLE [dbo].[Capitulo] (
    [Id]      INT          IDENTITY (1, 1) NOT NULL,
    [Nome]    VARCHAR (50) NOT NULL,
    [IdCurso] INT          NOT NULL,
    [Pontos]  INT          NOT NULL,
    CONSTRAINT [PK_Capitulo] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Curso]...';


GO
CREATE TABLE [dbo].[Curso] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [Nome]          VARCHAR (100) NOT NULL,
    [IdAutor]       INT           NOT NULL,
    [IdAssunto]     INT           NOT NULL,
    [Classificacao] INT           NULL,
    [DataCriacao]   DATETIME      NOT NULL,
    CONSTRAINT [PK_Curso] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Documento]...';


GO
CREATE TABLE [dbo].[Documento] (
    [Id]           INT             IDENTITY (1, 1) NOT NULL,
    [IdCurso]      INT             NOT NULL,
    [Descricao]    VARCHAR (MAX)   NOT NULL,
    [DataCadastro] DATETIME        NOT NULL,
    [Arquivo]      VARBINARY (MAX) NULL,
    CONSTRAINT [PK_Documento] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Funcionalidade]...';


GO
CREATE TABLE [dbo].[Funcionalidade] (
    [Id]   INT          NOT NULL,
    [Nome] VARCHAR (50) NULL,
    CONSTRAINT [PK_Funcionalidade] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Perfil]...';


GO
CREATE TABLE [dbo].[Perfil] (
    [Id]   INT          NOT NULL,
    [Nome] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Perfil] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Permissao]...';


GO
CREATE TABLE [dbo].[Permissao] (
    [IdPerfil]         INT NOT NULL,
    [IdFuncionalidade] INT NOT NULL,
    CONSTRAINT [PK_Permissao] PRIMARY KEY CLUSTERED ([IdPerfil] ASC, [IdFuncionalidade] ASC)
);


GO
PRINT N'Criando [dbo].[Treinamento]...';


GO
CREATE TABLE [dbo].[Treinamento] (
    [IdUsuario]     INT      NOT NULL,
    [IdCurso]       INT      NOT NULL,
    [DataInicio]    DATETIME NOT NULL,
    [UltimoAcesso]  DATETIME NOT NULL,
    [DataConclusao] DATETIME NULL,
    CONSTRAINT [PK_Treinamento] PRIMARY KEY CLUSTERED ([IdUsuario] ASC, [IdCurso] ASC)
);


GO
PRINT N'Criando [dbo].[Treinamento_Capitulo]...';


GO
CREATE TABLE [dbo].[Treinamento_Capitulo] (
    [IdUsuario]     INT      NOT NULL,
    [IdCurso]       INT      NOT NULL,
    [IdCapitulo]    INT      NOT NULL,
    [Pontos]        INT      NOT NULL,
    [DataConclusao] DATETIME NULL,
    CONSTRAINT [PK_Treinamento_Capitulo] PRIMARY KEY CLUSTERED ([IdUsuario] ASC, [IdCurso] ASC, [IdCapitulo] ASC)
);


GO
PRINT N'Criando [dbo].[Trilha]...';


GO
CREATE TABLE [dbo].[Trilha] (
    [Id]    INT           IDENTITY (1, 1) NOT NULL,
    [Nome]  VARCHAR (100) NOT NULL,
    [Ativa] BIT           NOT NULL,
    CONSTRAINT [PK_Trilha] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Trilha_Curso]...';


GO
CREATE TABLE [dbo].[Trilha_Curso] (
    [IdTrilha] INT NOT NULL,
    [IdCurso]  INT NOT NULL,
    CONSTRAINT [PK_Trilha_Curso] PRIMARY KEY CLUSTERED ([IdTrilha] ASC, [IdCurso] ASC)
);


GO
PRINT N'Criando [dbo].[Usuario]...';


GO
CREATE TABLE [dbo].[Usuario] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Nome]     VARCHAR (100) NOT NULL,
    [Email]    VARCHAR (100) NOT NULL,
    [Senha]    VARCHAR (100) NOT NULL,
    [Ativo]    BIT           NOT NULL,
    [IdPerfil] INT           NOT NULL,
    CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[Video]...';


GO
CREATE TABLE [dbo].[Video] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [Nome]          VARCHAR (50)  NOT NULL,
    [Duracao]       INT           NOT NULL,
    [IdCapitulo]    INT           NOT NULL,
    [CodigoYoutube] VARCHAR (100) NULL,
    CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Criando [dbo].[DF_Curso_DataCriacao]...';


GO
ALTER TABLE [dbo].[Curso]
    ADD CONSTRAINT [DF_Curso_DataCriacao] DEFAULT (getdate()) FOR [DataCriacao];


GO
PRINT N'Criando [dbo].[DF_Documento_DataCadastro]...';


GO
ALTER TABLE [dbo].[Documento]
    ADD CONSTRAINT [DF_Documento_DataCadastro] DEFAULT (getdate()) FOR [DataCadastro];


GO
PRINT N'Criando [dbo].[DF_Treinamento_DataInicio]...';


GO
ALTER TABLE [dbo].[Treinamento]
    ADD CONSTRAINT [DF_Treinamento_DataInicio] DEFAULT (getdate()) FOR [DataInicio];


GO
PRINT N'Criando [dbo].[DF_Trilha_Ativa]...';


GO
ALTER TABLE [dbo].[Trilha]
    ADD CONSTRAINT [DF_Trilha_Ativa] DEFAULT ((1)) FOR [Ativa];


GO
PRINT N'Criando [dbo].[DF_Usuario_Ativo]...';


GO
ALTER TABLE [dbo].[Usuario]
    ADD CONSTRAINT [DF_Usuario_Ativo] DEFAULT ((1)) FOR [Ativo];


GO
PRINT N'Criando [dbo].[FK_Capitulo_Curso]...';


GO
ALTER TABLE [dbo].[Capitulo] WITH NOCHECK
    ADD CONSTRAINT [FK_Capitulo_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Curso_Assunto]...';


GO
ALTER TABLE [dbo].[Curso] WITH NOCHECK
    ADD CONSTRAINT [FK_Curso_Assunto] FOREIGN KEY ([IdAssunto]) REFERENCES [dbo].[Assunto] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Curso_Usuario]...';


GO
ALTER TABLE [dbo].[Curso] WITH NOCHECK
    ADD CONSTRAINT [FK_Curso_Usuario] FOREIGN KEY ([IdAutor]) REFERENCES [dbo].[Usuario] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Documento_Curso]...';


GO
ALTER TABLE [dbo].[Documento] WITH NOCHECK
    ADD CONSTRAINT [FK_Documento_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Permissao_Funcionalidade]...';


GO
ALTER TABLE [dbo].[Permissao] WITH NOCHECK
    ADD CONSTRAINT [FK_Permissao_Funcionalidade] FOREIGN KEY ([IdFuncionalidade]) REFERENCES [dbo].[Funcionalidade] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Permissao_Perfil]...';


GO
ALTER TABLE [dbo].[Permissao] WITH NOCHECK
    ADD CONSTRAINT [FK_Permissao_Perfil] FOREIGN KEY ([IdPerfil]) REFERENCES [dbo].[Perfil] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Curso]...';


GO
ALTER TABLE [dbo].[Treinamento] WITH NOCHECK
    ADD CONSTRAINT [FK_Treinamento_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Usuario]...';


GO
ALTER TABLE [dbo].[Treinamento] WITH NOCHECK
    ADD CONSTRAINT [FK_Treinamento_Usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuario] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Capitulo_Capitulo]...';


GO
ALTER TABLE [dbo].[Treinamento_Capitulo] WITH NOCHECK
    ADD CONSTRAINT [FK_Treinamento_Capitulo_Capitulo] FOREIGN KEY ([IdCapitulo]) REFERENCES [dbo].[Capitulo] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Capitulo_Treinamento]...';


GO
ALTER TABLE [dbo].[Treinamento_Capitulo] WITH NOCHECK
    ADD CONSTRAINT [FK_Treinamento_Capitulo_Treinamento] FOREIGN KEY ([IdUsuario], [IdCurso]) REFERENCES [dbo].[Treinamento] ([IdUsuario], [IdCurso]);


GO
PRINT N'Criando [dbo].[FK_Trilha_Curso_Curso]...';


GO
ALTER TABLE [dbo].[Trilha_Curso] WITH NOCHECK
    ADD CONSTRAINT [FK_Trilha_Curso_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Trilha_Curso_Trilha]...';


GO
ALTER TABLE [dbo].[Trilha_Curso] WITH NOCHECK
    ADD CONSTRAINT [FK_Trilha_Curso_Trilha] FOREIGN KEY ([IdTrilha]) REFERENCES [dbo].[Trilha] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Usuario_Perfil]...';


GO
ALTER TABLE [dbo].[Usuario] WITH NOCHECK
    ADD CONSTRAINT [FK_Usuario_Perfil] FOREIGN KEY ([IdPerfil]) REFERENCES [dbo].[Perfil] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Video_Capitulo]...';


GO
ALTER TABLE [dbo].[Video] WITH NOCHECK
    ADD CONSTRAINT [FK_Video_Capitulo] FOREIGN KEY ([IdCapitulo]) REFERENCES [dbo].[Capitulo] ([Id]);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '86c58755-6927-4c88-936d-6d33d9d2742a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('86c58755-6927-4c88-936d-6d33d9d2742a')

GO

GO
/* Usuarios e permissões */
GO



SET NOCOUNT ON

MERGE INTO [dbo].[Perfil] AS Target
USING (VALUES
  (1,'Administrador')
 ,(2,'Usuario')
 ,(3,'Instrutor')
) AS Source ([Id],[Nome])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL) THEN
 UPDATE SET
  [Nome] = Source.[Nome]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Nome])
 VALUES(Source.[Id],Source.[Nome])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
;
GO
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Perfil]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[dbo].[Perfil] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
GO
SET NOCOUNT OFF
GO

USE [Treinamento]
GO



SET NOCOUNT ON

SET IDENTITY_INSERT [dbo].[Usuario] ON

MERGE INTO [dbo].[Usuario] AS Target
USING (VALUES
  (1,'Fernando Barbieri','fbarbieri@live.com','4QrcOUm6Wau+VuBX8g+IPg==',1,1)
 ,(2,'Fernando Mendes','fmendes@viceri.com.br','4QrcOUm6Wau+VuBX8g+IPg==',1,2)
 ,(3,'Mariane Castellano','mcastellano@viceri.com.br','4QrcOUm6Wau+VuBX8g+IPg==',1,2)
 ,(4,'Monica Mesquita','mmesquita@viceri.com.br','4QrcOUm6Wau+VuBX8g+IPg==',1,2)
 ,(5,'Mayara Marin','mmarin@viceri.com.br','4QrcOUm6Wau+VuBX8g+IPg==',1,1)
) AS Source ([Id],[Nome],[Email],[Senha],[Ativo],[IdPerfil])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[Email], Target.[Email]) IS NOT NULL OR NULLIF(Target.[Email], Source.[Email]) IS NOT NULL OR 
	NULLIF(Source.[Senha], Target.[Senha]) IS NOT NULL OR NULLIF(Target.[Senha], Source.[Senha]) IS NOT NULL OR 
	NULLIF(Source.[Senha], Target.[Senha]) IS NOT NULL OR NULLIF(Target.[IdPerfil], Source.[IdPerfil]) IS NOT NULL OR 
	NULLIF(Source.[Ativo], Target.[Ativo]) IS NOT NULL OR NULLIF(Target.[Ativo], Source.[Ativo]) IS NOT NULL) THEN
 UPDATE SET
  [Nome] = Source.[Nome], 
  [Email] = Source.[Email], 
  [Senha] = Source.[Senha], 
  [Ativo] = Source.[Ativo],
  [IdPerfil] = Source.[IdPerfil]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Nome],[Email],[Senha],[Ativo],[IdPerfil])
 VALUES(Source.[Id],Source.[Nome],Source.[Email],Source.[Senha],Source.[Ativo], Source.[IdPerfil])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
;
GO
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Usuario]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[dbo].[Usuario] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
GO

SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET NOCOUNT OFF
GO

USE [Treinamento]

	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL) THEN
DECLARE @mergeError int


USE [Treinamento]

DECLARE @mergeError int




	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL) THEN
DECLARE @mergeError int

SET NOCOUNT OFF

USE [Treinamento]

	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[IdAutor], Target.[IdAutor]) IS NOT NULL OR NULLIF(Target.[IdAutor], Source.[IdAutor]) IS NOT NULL OR 
	NULLIF(Source.[IdAssunto], Target.[IdAssunto]) IS NOT NULL OR NULLIF(Target.[IdAssunto], Source.[IdAssunto]) IS NOT NULL OR 
	NULLIF(Source.[Classificacao], Target.[Classificacao]) IS NOT NULL OR NULLIF(Target.[Classificacao], Source.[Classificacao]) IS NOT NULL OR 
	NULLIF(Source.[DataCriacao], Target.[DataCriacao]) IS NOT NULL OR NULLIF(Target.[DataCriacao], Source.[DataCriacao]) IS NOT NULL) THEN
  [IdAutor] = Source.[IdAutor], 
  [IdAssunto] = Source.[IdAssunto], 
  [Classificacao] = Source.[Classificacao], 
  [DataCriacao] = Source.[DataCriacao]
DECLARE @mergeError int

SET NOCOUNT OFF

USE [Treinamento]

	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[IdCurso], Target.[IdCurso]) IS NOT NULL OR NULLIF(Target.[IdCurso], Source.[IdCurso]) IS NOT NULL OR 
	NULLIF(Source.[Pontos], Target.[Pontos]) IS NOT NULL OR NULLIF(Target.[Pontos], Source.[Pontos]) IS NOT NULL) THEN
  [IdCurso] = Source.[IdCurso], 
  [Pontos] = Source.[Pontos]
DECLARE @mergeError int

SET NOCOUNT OFF



	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[Ativa], Target.[Ativa]) IS NOT NULL OR NULLIF(Target.[Ativa], Source.[Ativa]) IS NOT NULL) THEN
  [Ativa] = Source.[Ativa]
DECLARE @mergeError int

SET NOCOUNT OFF

USE [Treinamento]

DECLARE @mergeError int




	NULLIF(Source.[DataInicio], Target.[DataInicio]) IS NOT NULL OR NULLIF(Target.[DataInicio], Source.[DataInicio]) IS NOT NULL OR 
	NULLIF(Source.[UltimoAcesso], Target.[UltimoAcesso]) IS NOT NULL OR NULLIF(Target.[UltimoAcesso], Source.[UltimoAcesso]) IS NOT NULL OR 
	NULLIF(Source.[DataConclusao], Target.[DataConclusao]) IS NOT NULL OR NULLIF(Target.[DataConclusao], Source.[DataConclusao]) IS NOT NULL) THEN
  [UltimoAcesso] = Source.[UltimoAcesso], 
  [DataConclusao] = Source.[DataConclusao]
DECLARE @mergeError int


USE [Treinamento]

	NULLIF(Source.[Pontos], Target.[Pontos]) IS NOT NULL OR NULLIF(Target.[Pontos], Source.[Pontos]) IS NOT NULL OR 
	NULLIF(Source.[DataConclusao], Target.[DataConclusao]) IS NOT NULL OR NULLIF(Target.[DataConclusao], Source.[DataConclusao]) IS NOT NULL) THEN
  [DataConclusao] = Source.[DataConclusao]
DECLARE @mergeError int



GO



SET NOCOUNT ON

SET IDENTITY_INSERT [dbo].[Video] ON

MERGE INTO [dbo].[Video] AS Target
USING (VALUES
  (1,'Introducao',180,1,'r122rNpobmw')
 ,(2,'SQL Server capitulo 1',400,1,'rkrYgICjrww')
 ,(3,'Sql server capitulo 2',300,2,'X2Vo-i54c2o')
 ,(4,'Sql server capitulo 3',200,3,'Zy60yku7bxs')
) AS Source ([Id],[Nome],[Duracao],[IdCapitulo],[CodigoYoutube])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[Duracao], Target.[Duracao]) IS NOT NULL OR NULLIF(Target.[Duracao], Source.[Duracao]) IS NOT NULL OR 
	NULLIF(Source.[IdCapitulo], Target.[IdCapitulo]) IS NOT NULL OR NULLIF(Target.[IdCapitulo], Source.[IdCapitulo]) IS NOT NULL OR 
	NULLIF(Source.[CodigoYoutube], Target.[CodigoYoutube]) IS NOT NULL OR NULLIF(Target.[CodigoYoutube], Source.[CodigoYoutube]) IS NOT NULL) THEN
 UPDATE SET
  [Nome] = Source.[Nome], 
  [Duracao] = Source.[Duracao], 
  [IdCapitulo] = Source.[IdCapitulo], 
  [CodigoYoutube] = Source.[CodigoYoutube]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Nome],[Duracao],[IdCapitulo],[CodigoYoutube])
 VALUES(Source.[Id],Source.[Nome],Source.[Duracao],Source.[IdCapitulo],Source.[CodigoYoutube])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
;
GO
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Video]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[dbo].[Video] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
GO

SET IDENTITY_INSERT [dbo].[Video] OFF
GO
SET NOCOUNT OFF
GO

GO

GO
PRINT N'Verificando os dados existentes em restrições recém-criadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Capitulo] WITH CHECK CHECK CONSTRAINT [FK_Capitulo_Curso];

ALTER TABLE [dbo].[Curso] WITH CHECK CHECK CONSTRAINT [FK_Curso_Assunto];

ALTER TABLE [dbo].[Curso] WITH CHECK CHECK CONSTRAINT [FK_Curso_Usuario];

ALTER TABLE [dbo].[Documento] WITH CHECK CHECK CONSTRAINT [FK_Documento_Curso];

ALTER TABLE [dbo].[Permissao] WITH CHECK CHECK CONSTRAINT [FK_Permissao_Funcionalidade];

ALTER TABLE [dbo].[Permissao] WITH CHECK CHECK CONSTRAINT [FK_Permissao_Perfil];

ALTER TABLE [dbo].[Treinamento] WITH CHECK CHECK CONSTRAINT [FK_Treinamento_Curso];

ALTER TABLE [dbo].[Treinamento] WITH CHECK CHECK CONSTRAINT [FK_Treinamento_Usuario];

ALTER TABLE [dbo].[Treinamento_Capitulo] WITH CHECK CHECK CONSTRAINT [FK_Treinamento_Capitulo_Capitulo];

ALTER TABLE [dbo].[Treinamento_Capitulo] WITH CHECK CHECK CONSTRAINT [FK_Treinamento_Capitulo_Treinamento];

ALTER TABLE [dbo].[Trilha_Curso] WITH CHECK CHECK CONSTRAINT [FK_Trilha_Curso_Curso];

ALTER TABLE [dbo].[Trilha_Curso] WITH CHECK CHECK CONSTRAINT [FK_Trilha_Curso_Trilha];

ALTER TABLE [dbo].[Usuario] WITH CHECK CHECK CONSTRAINT [FK_Usuario_Perfil];

ALTER TABLE [dbo].[Video] WITH CHECK CHECK CONSTRAINT [FK_Video_Capitulo];


GO
PRINT N'Atualização concluída.';


GO