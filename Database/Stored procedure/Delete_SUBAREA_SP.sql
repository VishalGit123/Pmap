USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Delete_SUBAREA_SP]    Script Date: 11/14/2013 20:52:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[Delete_SUBAREA_SP]
(
@SubAreaId INT     

)
as
begin
delete from TblSubArea where SubAreaId=@SubAreaId
end