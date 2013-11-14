USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[ShowSUBArea_SP]    Script Date: 11/14/2013 20:58:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[ShowSUBArea_SP]    
as    
begin    

select tblroot.Root_id,tblroot.root_name,tblSubroot.subroot_id,tblSubroot.subroot_name,tblArea.Area_id,tblArea.Areaname
,TblSubArea.SubAreaId,TblSubArea.SubAreaName from TblSubArea
inner join tblArea on
TblSubArea.AreaId=TblSubArea.AreaId
inner join tblSubroot on
tblArea.Subrootid=tblSubroot.subroot_id
inner join tblroot on
tblSubroot.root_id=tblroot.Root_id


end 