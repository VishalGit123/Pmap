GO
/****** Object:  StoredProcedure [dbo].[CreateFilelist_SP]    Script Date: 11/14/2013 20:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[CreateFilelist_SP]  
--(  
--@Filepath nvarchar(max)  
--)  
as  
begin  
  
truncate table ExcelPathList  
insert into ExcelPathList(SubDirectoryList,depth,filecount) EXEC xp_dirtree 'D:\Excelfolder', 10, 3  
select * from ExcelPathList  
end
