USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GetSearchScenarios_SP]    Script Date: 11/14/2013 20:54:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetSearchScenarios_SP]-- null,'project'  
(  
@strtagname nvarchar(max),  
@scenario nvarchar(max)  
)  
as  
begin  

select R.root_name as Root_Name,subR.subroot_name as SubRootName,a.Areaname,suba.SubAreaName,sc.SC_Name,sc.TagName,sc.[status]
from tblroot as R inner join tblSubroot as SubR
on R.Root_id=subR.root_id
inner join tblArea as A on
subR.subroot_id=a.Subrootid
inner join TblSubArea as SubA on
a.Area_id=suba.AreaId
inner join tblScenarioName as SC on
sc.Subareaid=suba.SubAreaId where   
 sc.SC_Name like '%'+@scenario+'%'  -- or TagName like '%@strtagname%'  
end
