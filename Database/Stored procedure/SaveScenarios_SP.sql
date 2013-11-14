USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[SaveScenarios_SP]    Script Date: 11/14/2013 20:56:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[SaveScenarios_SP]  
(  
@Scname nvarchar(max),  
@scTypeId int,  
--@Tagname nvarchar(max),  
@Subarea_id int,  
@status nvarchar(50)  
)  
as  
begin  
insert into tblScenarioName (SC_Name,SCType_Id,Subareaid,[status])  
values(@Scname,@scTypeId,@Subarea_id,@status)  
end
