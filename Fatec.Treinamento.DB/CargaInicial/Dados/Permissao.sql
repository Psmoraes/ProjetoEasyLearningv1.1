USE [Treinamento]GOSET NOCOUNT ONMERGE INTO [dbo].[Permissao] AS TargetUSING (VALUES  (1,1) ,(3,1) ,(1,2)) AS Source ([IdPerfil],[IdFuncionalidade])ON (Target.[IdFuncionalidade] = Source.[IdFuncionalidade] AND Target.[IdPerfil] = Source.[IdPerfil])WHEN NOT MATCHED BY TARGET THEN INSERT([IdPerfil],[IdFuncionalidade]) VALUES(Source.[IdPerfil],Source.[IdFuncionalidade])WHEN NOT MATCHED BY SOURCE THEN  DELETE;GODECLARE @mergeError int , @mergeCount intSELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNTIF @mergeError != 0 BEGIN PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Permissao]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected ENDELSE BEGIN PRINT '[dbo].[Permissao] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100)); ENDGOSET NOCOUNT OFFGO