USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Show_Module_SP]    Script Date: 11/14/2013 20:57:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Show_Module_SP]
AS
BEGIN
SELECT Root_id,root_name FROM tblroot
END
