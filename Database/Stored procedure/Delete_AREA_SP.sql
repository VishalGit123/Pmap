USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Delete_AREA_SP]    Script Date: 11/14/2013 20:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Delete_AREA_SP]
(
@subroot_ID INT,    
@subroot_name nvarchar(200) ,
@AREA_NAME nvarchar(200),
@AREA_ID INT
)
AS
BEGIN

declare @mpath nvarchar(200)=''  
declare @root_id int  
declare @root_name nvarchar(500)=''  
  
set @root_id=(select max(root_id) from tblSubroot where subroot_id=@subroot_ID )  
set @root_name=(select root_name from tblroot where Root_id=@root_id)  
print @mpath
set @mpath='del  D:\Excelfolder\'+ @root_name +'\'+@subroot_name+'\'+@AREA_NAME
print @mpath
delete from tblArea where Area_id=@AREA_ID  
exec master..xp_cmdshell @mpath  

END