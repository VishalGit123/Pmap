USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Save_Module_SP]    Script Date: 11/14/2013 20:55:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_Module_SP]    
@modulename as varchar(200)
  
AS    
Begin
declare @stringpath as nvarchar(200)=''     
INSERT INTO [tblroot]([root_name])VALUES(@modulename)   
set @stringpath='MD D:\Excelfolder\'+ @modulename

exec master..xp_cmdshell @stringpath

END
