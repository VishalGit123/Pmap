USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GetScenarioData]    Script Date: 11/14/2013 20:54:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetScenarioData]        
--@SubAreaId int        
as        
Begin        
select R.root_name as Root_Name,subR.subroot_name as SubRootName,a.Areaname,suba.SubAreaName,sc.SC_id,sc.SC_Name,sc.TagName,sc.[status]    
from tblroot as R inner join tblSubroot as SubR    
on R.Root_id=subR.root_id    
inner join tblArea as A on    
subR.subroot_id=a.Subrootid    
inner join TblSubArea as SubA on    
a.Area_id=suba.AreaId    
inner join tblScenarioName as SC on    
sc.Subareaid=suba.SubAreaId       
 where SUBA.checked=1        
End
