USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GETSUBMODULEDDL_SP]    Script Date: 11/14/2013 20:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GETSUBMODULEDDL_SP]
@SELECTED_MODULE_ID AS INT
AS
BEGIN
	SELECT [subroot_id],[subroot_name] FROM [tblSubroot] where root_id=@SELECTED_MODULE_ID
END
