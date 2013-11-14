USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[ShowArea_SP]    Script Date: 11/14/2013 20:57:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[ShowArea_SP]  
as  
begin  
select tblSubroot.root_id,tblSubroot.subroot_id,tblSubroot.subroot_name,tblArea.Area_id,tblArea.Areaname from tblArea  
inner join tblSubroot on tblSubroot.subroot_id=tblArea.Subrootid  
where subroot_name<>''  
end  

         