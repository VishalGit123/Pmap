USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Save_Area_SP]    Script Date: 11/14/2013 20:55:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_Area_SP]        
(      
      
@Submoduleid int,      
@Areaename as nvarchar(max) ,  
@selectedModule  as nvarchar(max),  
@selectedsubmodule as nvarchar(max)  
)      
AS        
Begin       
--DECLARE @cmd sysname ='copy D:\ProductMapExcelTemplate\Template.xlsx D:\Excelfolder\'+@selectedModule +'\'+ @selectedsubmodule + '\'+ @Areaename +'\' +'.xlsx'   
  
DECLARE @cmd sysname ='copy D:\ProductMapExcelTemplate\Template.xlsx D:\Excelfolder\'+@selectedModule +'\'+ @selectedsubmodule + '\'+ @Areaename +'.xlsx'   
INSERT INTO [tblArea](Subrootid,Areaname)VALUES(@Submoduleid,@Areaename+'.xlsx')    
EXEC master..xp_cmdshell @cmd    
END  

select * from [tblArea]