USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Delete_SubModule_SP]    Script Date: 11/14/2013 20:52:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Delete_SubModule_SP]  
(
@subroot_ID INT,  
@subroot_name nvarchar(200)
)
AS  
BEGIN  


declare @mpath nvarchar(200)=''
declare @root_id int
declare @root_name nvarchar(200)=''
 
set @root_id=(select max(root_id) from tblSubroot where subroot_id=@subroot_ID )
print @root_id
set @root_name=(select root_name from tblroot where Root_id=@root_id)
print @root_name
set @mpath='rd  D:\Excelfolder\'+ @root_name +'\'+@subroot_name
delete from tblSubroot where subroot_id=@subroot_ID
print @mpath
exec master..xp_cmdshell @mpath  

END
