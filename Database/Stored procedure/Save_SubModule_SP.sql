USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Save_SubModule_SP]    Script Date: 11/14/2013 20:56:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_SubModule_SP]      
(    
@moduleid int,    
@submodulename as nvarchar(max)      
)    
AS      
Begin 
declare @stringpath as nvarchar(200)=''   
declare @modulename as nvarchar(200)=''   
INSERT INTO [tblSubroot]([subroot_name],[root_id])VALUES(@submodulename,@moduleid)   
set @modulename=(select root_name from tblroot where Root_id=@moduleid)
set @stringpath='MD D:\Excelfolder\'+ @modulename +'\'+  @submodulename
exec master..xp_cmdshell @stringpath  
END
