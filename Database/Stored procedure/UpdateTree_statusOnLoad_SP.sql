USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTree_statusOnLoad_SP]    Script Date: 11/14/2013 20:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[UpdateTree_statusOnLoad_SP]
as
begin
update dbo.TblSubArea set checked=0
end
