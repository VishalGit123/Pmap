USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GET_SUBMODULEData_SP]    Script Date: 11/14/2013 20:53:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GET_SUBMODULEData_SP]
AS
BEGIN
SELECT tblSubroot.subroot_id,tblroot.root_name,tblSubroot.subroot_name FROM tblroot INNER JOIN tblSubroot 
ON tblroot.Root_id=tblSubroot.root_id
END
