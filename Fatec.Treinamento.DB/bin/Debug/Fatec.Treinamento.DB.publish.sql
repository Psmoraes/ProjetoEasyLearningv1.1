/*
Script de implantação para base

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "base"
:setvar DefaultFilePrefix "base"
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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Criando $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'As configurações de banco de dados não podem ser modificadas. Você deve ser um SysAdmin para aplicar essas configurações.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'As configurações de banco de dados não podem ser modificadas. Você deve ser um SysAdmin para aplicar essas configurações.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


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
ALTER TABLE [dbo].[Capitulo]
    ADD CONSTRAINT [FK_Capitulo_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Curso_Assunto]...';


GO
ALTER TABLE [dbo].[Curso]
    ADD CONSTRAINT [FK_Curso_Assunto] FOREIGN KEY ([IdAssunto]) REFERENCES [dbo].[Assunto] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Curso_Usuario]...';


GO
ALTER TABLE [dbo].[Curso]
    ADD CONSTRAINT [FK_Curso_Usuario] FOREIGN KEY ([IdAutor]) REFERENCES [dbo].[Usuario] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Documento_Curso]...';


GO
ALTER TABLE [dbo].[Documento]
    ADD CONSTRAINT [FK_Documento_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Permissao_Funcionalidade]...';


GO
ALTER TABLE [dbo].[Permissao]
    ADD CONSTRAINT [FK_Permissao_Funcionalidade] FOREIGN KEY ([IdFuncionalidade]) REFERENCES [dbo].[Funcionalidade] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Permissao_Perfil]...';


GO
ALTER TABLE [dbo].[Permissao]
    ADD CONSTRAINT [FK_Permissao_Perfil] FOREIGN KEY ([IdPerfil]) REFERENCES [dbo].[Perfil] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Curso]...';


GO
ALTER TABLE [dbo].[Treinamento]
    ADD CONSTRAINT [FK_Treinamento_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Usuario]...';


GO
ALTER TABLE [dbo].[Treinamento]
    ADD CONSTRAINT [FK_Treinamento_Usuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuario] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Capitulo_Capitulo]...';


GO
ALTER TABLE [dbo].[Treinamento_Capitulo]
    ADD CONSTRAINT [FK_Treinamento_Capitulo_Capitulo] FOREIGN KEY ([IdCapitulo]) REFERENCES [dbo].[Capitulo] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Treinamento_Capitulo_Treinamento]...';


GO
ALTER TABLE [dbo].[Treinamento_Capitulo]
    ADD CONSTRAINT [FK_Treinamento_Capitulo_Treinamento] FOREIGN KEY ([IdUsuario], [IdCurso]) REFERENCES [dbo].[Treinamento] ([IdUsuario], [IdCurso]);


GO
PRINT N'Criando [dbo].[FK_Trilha_Curso_Curso]...';


GO
ALTER TABLE [dbo].[Trilha_Curso]
    ADD CONSTRAINT [FK_Trilha_Curso_Curso] FOREIGN KEY ([IdCurso]) REFERENCES [dbo].[Curso] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Trilha_Curso_Trilha]...';


GO
ALTER TABLE [dbo].[Trilha_Curso]
    ADD CONSTRAINT [FK_Trilha_Curso_Trilha] FOREIGN KEY ([IdTrilha]) REFERENCES [dbo].[Trilha] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Usuario_Perfil]...';


GO
ALTER TABLE [dbo].[Usuario]
    ADD CONSTRAINT [FK_Usuario_Perfil] FOREIGN KEY ([IdPerfil]) REFERENCES [dbo].[Perfil] ([Id]);


GO
PRINT N'Criando [dbo].[FK_Video_Capitulo]...';


GO
ALTER TABLE [dbo].[Video]
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
/* Usuarios e permissões */USE [Treinamento]
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

USE [Treinamento]GO
SET NOCOUNT ONMERGE INTO [dbo].[Funcionalidade] AS TargetUSING (VALUES  (1,'Cadastrar Curso') ,(2,'Manutenção Usuarios')) AS Source ([Id],[Nome])ON (Target.[Id] = Source.[Id])WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL) THEN UPDATE SET  [Nome] = Source.[Nome]WHEN NOT MATCHED BY TARGET THEN INSERT([Id],[Nome]) VALUES(Source.[Id],Source.[Nome])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Funcionalidade]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Funcionalidade] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONMERGE INTO [dbo].[Permissao] AS TargetUSING (VALUES  (1,1) ,(3,1) ,(1,2)) AS Source ([IdPerfil],[IdFuncionalidade])ON (Target.[IdFuncionalidade] = Source.[IdFuncionalidade] AND Target.[IdPerfil] = Source.[IdPerfil])WHEN NOT MATCHED BY TARGET THEN INSERT([IdPerfil],[IdFuncionalidade]) VALUES(Source.[IdPerfil],Source.[IdFuncionalidade])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Permissao]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Permissao] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET NOCOUNT OFFGO

/* Cursos */USE [Treinamento]GO
SET NOCOUNT ONSET IDENTITY_INSERT [dbo].[Assunto] ONMERGE INTO [dbo].[Assunto] AS TargetUSING (VALUES  (2,'Finanças') ,(3,'SQL Server') ,(4,'ASP.NET') ,(5,'Sistema de Apontamento de Horas') ,(6,'RH') ,(7,'Diversos') ,(8,'VENDAS')) AS Source ([Id],[Nome])ON (Target.[Id] = Source.[Id])WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL) THEN UPDATE SET  [Nome] = Source.[Nome]WHEN NOT MATCHED BY TARGET THEN INSERT([Id],[Nome]) VALUES(Source.[Id],Source.[Nome])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Assunto]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Assunto] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET IDENTITY_INSERT [dbo].[Assunto] OFFGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONSET IDENTITY_INSERT [dbo].[Curso] ONMERGE INTO [dbo].[Curso] AS TargetUSING (VALUES  (1,'Introdução ao SQL Server',1,3,NULL,'2017-01-12T00:00:00') ,(2,'Como fazer o apontamento de horas',3,5,4,'2017-01-06T00:00:00') ,(3,'Web API',2,4,4,'2017-01-12T00:00:00') ,(4,'Integração de Novos Funcionários',3,6,3,'2017-01-02T00:00:00') ,(5,'Como ser um youtuber',4,7,5,'2017-01-01T00:00:00')) AS Source ([Id],[Nome],[IdAutor],[IdAssunto],[Classificacao],[DataCriacao])ON (Target.[Id] = Source.[Id])WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[IdAutor], Target.[IdAutor]) IS NOT NULL OR NULLIF(Target.[IdAutor], Source.[IdAutor]) IS NOT NULL OR 
	NULLIF(Source.[IdAssunto], Target.[IdAssunto]) IS NOT NULL OR NULLIF(Target.[IdAssunto], Source.[IdAssunto]) IS NOT NULL OR 
	NULLIF(Source.[Classificacao], Target.[Classificacao]) IS NOT NULL OR NULLIF(Target.[Classificacao], Source.[Classificacao]) IS NOT NULL OR 
	NULLIF(Source.[DataCriacao], Target.[DataCriacao]) IS NOT NULL OR NULLIF(Target.[DataCriacao], Source.[DataCriacao]) IS NOT NULL) THEN UPDATE SET  [Nome] = Source.[Nome], 
  [IdAutor] = Source.[IdAutor], 
  [IdAssunto] = Source.[IdAssunto], 
  [Classificacao] = Source.[Classificacao], 
  [DataCriacao] = Source.[DataCriacao]WHEN NOT MATCHED BY TARGET THEN INSERT([Id],[Nome],[IdAutor],[IdAssunto],[Classificacao],[DataCriacao]) VALUES(Source.[Id],Source.[Nome],Source.[IdAutor],Source.[IdAssunto],Source.[Classificacao],Source.[DataCriacao])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Curso]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Curso] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET IDENTITY_INSERT [dbo].[Curso] OFFGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONSET IDENTITY_INSERT [dbo].[Capitulo] ONMERGE INTO [dbo].[Capitulo] AS TargetUSING (VALUES  (1,'Intro',1,5) ,(2,'Conceitos basicos',1,3) ,(3,'Linguagem sql',1,6) ,(4,'Comandos DDL',1,5) ,(5,'Intro',2,5) ,(6,'Apontamento diario',2,5) ,(7,'Como fazer o relatório mensal',2,3)) AS Source ([Id],[Nome],[IdCurso],[Pontos])ON (Target.[Id] = Source.[Id])WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[IdCurso], Target.[IdCurso]) IS NOT NULL OR NULLIF(Target.[IdCurso], Source.[IdCurso]) IS NOT NULL OR 
	NULLIF(Source.[Pontos], Target.[Pontos]) IS NOT NULL OR NULLIF(Target.[Pontos], Source.[Pontos]) IS NOT NULL) THEN UPDATE SET  [Nome] = Source.[Nome], 
  [IdCurso] = Source.[IdCurso], 
  [Pontos] = Source.[Pontos]WHEN NOT MATCHED BY TARGET THEN INSERT([Id],[Nome],[IdCurso],[Pontos]) VALUES(Source.[Id],Source.[Nome],Source.[IdCurso],Source.[Pontos])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Capitulo]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Capitulo] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET IDENTITY_INSERT [dbo].[Capitulo] OFFGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONSET IDENTITY_INSERT [dbo].[Trilha] ONMERGE INTO [dbo].[Trilha] AS TargetUSING (VALUES  (1,'Trilha de Integração',1) ,(2,'Trilha Técnica',1) ,(3,'Diversos',1) ,(4,'Triha FrontEnd',1) ,(5,'Trilha DB',1) ,(6,'Trilha Web',1) ,(7,'Trilha Raspberry PI',1) ,(8,'Trilha Financeiro',0) ,(9,'Trilha Vendas',1)) AS Source ([Id],[Nome],[Ativa])ON (Target.[Id] = Source.[Id])WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[Ativa], Target.[Ativa]) IS NOT NULL OR NULLIF(Target.[Ativa], Source.[Ativa]) IS NOT NULL) THEN UPDATE SET  [Nome] = Source.[Nome], 
  [Ativa] = Source.[Ativa]WHEN NOT MATCHED BY TARGET THEN INSERT([Id],[Nome],[Ativa]) VALUES(Source.[Id],Source.[Nome],Source.[Ativa])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Trilha]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Trilha] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET IDENTITY_INSERT [dbo].[Trilha] OFFGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONMERGE INTO [dbo].[Trilha_Curso] AS TargetUSING (VALUES  (2,1) ,(1,2) ,(2,3) ,(1,4) ,(3,5)) AS Source ([IdTrilha],[IdCurso])ON (Target.[IdCurso] = Source.[IdCurso] AND Target.[IdTrilha] = Source.[IdTrilha])WHEN NOT MATCHED BY TARGET THEN INSERT([IdTrilha],[IdCurso]) VALUES(Source.[IdTrilha],Source.[IdCurso])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Trilha_Curso]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Trilha_Curso] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONMERGE INTO [dbo].[Treinamento] AS TargetUSING (VALUES  (5,1,'2016-12-06T00:00:00','2017-01-10T00:00:00','2017-01-16T00:00:00') ,(1,2,'2017-01-01T00:00:00','2017-01-03T00:00:00',NULL)) AS Source ([IdUsuario],[IdCurso],[DataInicio],[UltimoAcesso],[DataConclusao])ON (Target.[IdCurso] = Source.[IdCurso] AND Target.[IdUsuario] = Source.[IdUsuario])WHEN MATCHED AND (
	NULLIF(Source.[DataInicio], Target.[DataInicio]) IS NOT NULL OR NULLIF(Target.[DataInicio], Source.[DataInicio]) IS NOT NULL OR 
	NULLIF(Source.[UltimoAcesso], Target.[UltimoAcesso]) IS NOT NULL OR NULLIF(Target.[UltimoAcesso], Source.[UltimoAcesso]) IS NOT NULL OR 
	NULLIF(Source.[DataConclusao], Target.[DataConclusao]) IS NOT NULL OR NULLIF(Target.[DataConclusao], Source.[DataConclusao]) IS NOT NULL) THEN UPDATE SET  [DataInicio] = Source.[DataInicio], 
  [UltimoAcesso] = Source.[UltimoAcesso], 
  [DataConclusao] = Source.[DataConclusao]WHEN NOT MATCHED BY TARGET THEN INSERT([IdUsuario],[IdCurso],[DataInicio],[UltimoAcesso],[DataConclusao]) VALUES(Source.[IdUsuario],Source.[IdCurso],Source.[DataInicio],Source.[UltimoAcesso],Source.[DataConclusao])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Treinamento]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Treinamento] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET NOCOUNT OFFGO

USE [Treinamento]GO
SET NOCOUNT ONMERGE INTO [dbo].[Treinamento_Capitulo] AS TargetUSING (VALUES  (5,1,1,5,'2017-01-03T00:00:00') ,(5,1,2,6,'2017-01-10T00:00:00') ,(5,1,3,4,'2017-01-13T00:00:00') ,(5,1,4,7,'2017-01-15T00:00:00') ,(1,2,5,5,'2017-01-02T00:00:00') ,(1,2,6,3,'2017-01-03T00:00:00')) AS Source ([IdUsuario],[IdCurso],[IdCapitulo],[Pontos],[DataConclusao])ON (Target.[IdCapitulo] = Source.[IdCapitulo] AND Target.[IdCurso] = Source.[IdCurso] AND Target.[IdUsuario] = Source.[IdUsuario])WHEN MATCHED AND (
	NULLIF(Source.[Pontos], Target.[Pontos]) IS NOT NULL OR NULLIF(Target.[Pontos], Source.[Pontos]) IS NOT NULL OR 
	NULLIF(Source.[DataConclusao], Target.[DataConclusao]) IS NOT NULL OR NULLIF(Target.[DataConclusao], Source.[DataConclusao]) IS NOT NULL) THEN UPDATE SET  [Pontos] = Source.[Pontos], 
  [DataConclusao] = Source.[DataConclusao]WHEN NOT MATCHED BY TARGET THEN INSERT([IdUsuario],[IdCurso],[IdCapitulo],[Pontos],[DataConclusao]) VALUES(Source.[IdUsuario],Source.[IdCurso],Source.[IdCapitulo],Source.[Pontos],Source.[DataConclusao])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GO
DECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Treinamento_Capitulo]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Treinamento_Capitulo] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGO
SET NOCOUNT OFFGO

USE [Treinamento]
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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Atualização concluída.';


GO
