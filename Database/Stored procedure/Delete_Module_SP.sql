USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Delete_Module_SP]    Script Date: 11/14/2013 20:51:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Delete_Module_SP]
@moduleid INT
AS
BEGIN
declare @root_name nvarchar(200)
declare @mpath nvarchar(200)

set @root_name=(select root_name from tblroot where Root_id=@moduleid)
set @mpath='rd  D:\Excelfolder\'+ @root_name
exec master..xp_cmdshell @mpath
delete FROM tblroot where Root_id=@moduleid
END
