USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[Save_SubArea_SP]    Script Date: 11/14/2013 20:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Save_SubArea_SP]  
(

@areaid int,
@subareaAreaename as nvarchar(max)  
)
AS  
Begin  
INSERT INTO TblSubArea(AreaId,SubAreaName)VALUES(@areaid,@subareaAreaename)  
END
