USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GET_MODULEDDL_SP]    Script Date: 11/14/2013 20:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GET_MODULEDDL_SP]
AS
BEGIN
SELECT [Root_id],[root_name] FROM [tblroot]
END
