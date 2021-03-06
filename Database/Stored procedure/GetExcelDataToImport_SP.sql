USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GetExcelDataToImport_SP]    Script Date: 11/14/2013 20:53:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[GetExcelDataToImport_SP] --'D:\Excelfolder\Anshul-Root\Anshul-Subroot\75.xlsx','[Sheet1$]','75'        
(            
@datafile nvarchar(max),            
@sheetpath nvarchar(max) ,        
@lastexcelfilename  nvarchar(max)         
            
)            
as            
begin             
declare @sql nvarchar(MAX)        
declare @areaid int          
declare @subareaid int        
declare @sctypeid int        
        
if not exists (select areaname from tblArea where Areaname=@lastexcelfilename)        
 begin        
  insert into tblArea (Areaname, Subrootid) values (@lastexcelfilename,DBO.fnGetSubRoot_ID (@lastexcelfilename))        
 end        
--if not exists (select SubAreaName from TblSubArea where SubAreaName=@sheetpath)        
 begin        
  set @areaid=(select max(area_id) from tblArea where Areaname=@lastexcelfilename)        
  insert into TblSubArea (SubAreaName,AreaId) values(@sheetpath,@areaid)        
 end        
  --Create table temp (sc_id int,sc_name nvarchar(max),sctype_id int,subareaid int,SC_status nvarchar(max))        
 set @subareaid=(select max(SubAreaId) from TblSubArea where SubAreaName=@sheetpath)        
 print @subareaid        
--SELECT @sql = 'insert into temp(sc_name,SC_status) select scenarios,result FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0;Database=' + @datafile + ''', '+@sheetpath+')'            
SELECT @sql = 'insert into temp(sc_name,SC_status) select scenarios,Result FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0;Database=' + @datafile + ''', '+@sheetpath+')'
EXEC sp_executesql @sql            
update  temp set subareaid=@subareaid        
update  temp set sctype_id=1        
if not exists (select sc_name from temp where sc_name in (select sc_name from tblScenarioName))      
begin      
insert into tblScenarioName(SC_Name,SCType_Id,Subareaid,[status]) select sc_name,sctype_id,subareaid,SC_status from temp        
end      
truncate table temp        
--update TblSubArea set AreaId=(select max(area_id) from tblArea where Areaname=@lastexcelfilename)        
select * from dbo.tblScenarioName     
end          
--select * from temp        
--select * from dbo.tblScenarioName         
--select * from dbo.tblroot          
--select * from tblsubroot          
--select * from DirectoryTree          
--SELECT * FROM dbo.tblArea         
--select * from dbo.TblSubArea        
--select * from dbo.tblScenarioName         
--GetExcelDataToImport_SP 'D:\Excel folder\\Practice-Root\\Time Capture- Subroot\\Daily Entry','Rebill' ,'Daily Entry '        
--declare @sql nvarchar(MAX)        
--SELECT @sql = 'insert into tblScenarioName(sc_name,status)select scenarios,result FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',''Excel 12.0;Database=' + 'D:\\Excel folder\\Practice-Root\\Time Capture- Subroot\\Daily Entry.xlsx' + ''', '+'Rebill$'+')'   
  
    
      
         
--PRINT @sql            
--EXEC sp_executesql @sql         
--delete from TblSubArea where AreaId is null        
--truncate table tblScenarioName        
--sp_helptext GetListOfExcelfile_SP        
--select * from Temppathlist        
--truncate table tblScenarioName 


--Truncate table dbo.tblScenarioName         
--delete from dbo.tblroot          
--delete from tblsubroot          
--delete from DirectoryTree          
--delete from dbo.tblArea         
--delete from  dbo.TblSubArea  
--Truncate table tblScenarioType      
--Truncate table dbo.tblScenarioName 
--select * from tblScenarioType
