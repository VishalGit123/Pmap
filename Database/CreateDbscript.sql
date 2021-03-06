USE [master]
GO
/****** Object:  Database [ProductMap]    Script Date: 11/14/2013 19:34:40 ******/
CREATE DATABASE [ProductMap] ON  PRIMARY 
( NAME = N'ProductMap', FILENAME = N'D:\Productmap_DB\ProductMap.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ProductMap_log', FILENAME = N'D:\Productmap_DB\ProductMap_1.ldf' , SIZE = 4672KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ProductMap] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductMap].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductMap] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ProductMap] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ProductMap] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ProductMap] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ProductMap] SET ARITHABORT OFF
GO
ALTER DATABASE [ProductMap] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [ProductMap] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ProductMap] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ProductMap] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ProductMap] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ProductMap] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ProductMap] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ProductMap] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ProductMap] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ProductMap] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ProductMap] SET  DISABLE_BROKER
GO
ALTER DATABASE [ProductMap] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ProductMap] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ProductMap] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ProductMap] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ProductMap] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ProductMap] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ProductMap] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [ProductMap] SET  READ_WRITE
GO
ALTER DATABASE [ProductMap] SET RECOVERY FULL
GO
ALTER DATABASE [ProductMap] SET  MULTI_USER
GO
ALTER DATABASE [ProductMap] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ProductMap] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProductMap', N'ON'
GO
USE [ProductMap]
GO
/****** Object:  Table [dbo].[tblroot]    Script Date: 11/14/2013 19:34:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblroot](
	[Root_id] [int] IDENTITY(1,1) NOT NULL,
	[root_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblroot] PRIMARY KEY CLUSTERED 
(
	[Root_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Split](@String varchar(8000), @Delimiter char(1))     
returns @temptable TABLE (items varchar(8000))     
as     
begin     
declare @idx int     
declare @slice varchar(8000)     

select @idx = 1     
    if len(@String)<1 or @String is null  return     

while @idx!= 0     
begin     
    set @idx = charindex(@Delimiter,@String)     
    if @idx!=0     
        set @slice = left(@String,@idx - 1)     
    else     
        set @slice = @String     

    if(len(@slice)>0)
        insert into @temptable(Items) values(@slice)     

    set @String = right(@String,len(@String) - @idx)     
    if len(@String) = 0 break     
end 
return     
end
GO
/****** Object:  Table [dbo].[DirectoryTreetest]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryTreetest](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullpath] [varchar](2000) NULL,
	[subdirectory] [nvarchar](512) NULL,
	[depth] [int] NULL,
	[isfile] [bit] NULL,
 CONSTRAINT [PK_DirectoryTree] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirectoryTree]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryTree](
	[DirectoryTreeID] [int] IDENTITY(1,1) NOT NULL,
	[Root] [varchar](100) NULL,
	[Level1] [varchar](100) NOT NULL,
	[Level2] [varchar](100) NOT NULL,
	[Level3] [varchar](100) NOT NULL,
	[Level4] [varchar](100) NOT NULL,
	[Level5] [varchar](100) NOT NULL,
	[Level6] [varchar](100) NOT NULL,
	[Level7] [varchar](100) NOT NULL,
	[Level8] [varchar](100) NOT NULL,
	[Level9] [varchar](100) NOT NULL,
	[Level10] [varchar](100) NOT NULL,
	[Level11] [varchar](100) NOT NULL,
	[Level12] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExcelPathList]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExcelPathList](
	[SubDirectoryList] [nvarchar](max) NULL,
	[depth] [int] NULL,
	[filecount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[excelfilelist]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[excelfilelist](
	[filename] [nvarchar](max) NULL,
	[sheetname] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductMapTree]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductMapTree](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubDir] [varchar](100) NULL,
	[Depth] [int] NULL,
	[ParentID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[myFileList]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[myFileList](
	[FileNumber] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblScenarioType]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScenarioType](
	[SC_Typeid] [int] IDENTITY(1,1) NOT NULL,
	[SC_TypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblScenarioType] PRIMARY KEY CLUSTERED 
(
	[SC_Typeid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblScenarioName_test]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScenarioName_test](
	[sc] [nvarchar](max) NULL,
	[status] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temppathlist]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temppathlist](
	[pathlist] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp]    Script Date: 11/14/2013 19:34:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp](
	[sc_id] [int] NULL,
	[sc_name] [nvarchar](max) NULL,
	[sctype_id] [int] NULL,
	[subareaid] [int] NULL,
	[SC_status] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTree_statusOnLoad_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[UpdateTree_statusOnLoad_SP]
as
begin
update dbo.TblSubArea set checked=0
end
GO
/****** Object:  Table [dbo].[tblSubroot]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSubroot](
	[subroot_id] [int] IDENTITY(1,1) NOT NULL,
	[subroot_name] [nvarchar](50) NULL,
	[root_id] [int] NULL,
 CONSTRAINT [PK_tblSubroot] PRIMARY KEY CLUSTERED 
(
	[subroot_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetScenario_ID]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fnGetScenario_ID]
(
 @SubAreaname nvarchar(50)

)
returns int
As
Begin
		return (select SubAreaId from TblSubArea where SubAreaName= (select max(level4) from DirectoryTree where level5=@SubAreaname))


END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetRootID]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnGetRootID]
(
 @Subrootname nvarchar(50)

)
returns int
As
Begin
	return (select root_id from tblroot where root_name=(select level1 from DirectoryTree where level2=@Subrootname))
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetRoot_ID]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnGetRoot_ID]
(
 @Subrootname nvarchar(50)

)
returns int
As
Begin
	return (select root_id from tblroot where root_name=(select max(level1) from DirectoryTree where level2=@Subrootname))
end
GO
/****** Object:  StoredProcedure [dbo].[GETSUBMODULEDDL_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GETSUBMODULEDDL_SP]
@SELECTED_MODULE_ID AS INT
AS
BEGIN
	SELECT [subroot_id],[subroot_name] FROM [tblSubroot] where root_id=@SELECTED_MODULE_ID
END
GO
/****** Object:  StoredProcedure [dbo].[GetSearchScenarios_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetSearchScenarios_SP]-- null,'project'  
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
GO
/****** Object:  StoredProcedure [dbo].[GetScenarioData]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetScenarioData]        
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
GO
/****** Object:  StoredProcedure [dbo].[getname]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getname]
as
select top 1 [filename] from excelfilelist
GO
/****** Object:  StoredProcedure [dbo].[GetListOfExcelfile_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetListOfExcelfile_SP]    
as    
begin    
truncate table Temppathlist    
    
DECLARE    
       @BasePath varchar(1000)    
      ,@Path varchar(1000)    
      ,@FullPath varchar(2000)    
      ,@Id int;    
    
--This is your starting point.    
SET @BasePath = 'D:\Excelfolder';    
    
--Create a temp table to hold the results.    
IF OBJECT_ID('tempdb..#DirectoryTree') IS NOT NULL    
      DROP TABLE #DirectoryTree;    
    
CREATE TABLE #DirectoryTree (    
       id int IDENTITY(1,1)    
      ,fullpath varchar(2000)    
      ,subdirectory nvarchar(512)    
      ,depth int    
      ,isfile bit);    
    
--Create a clustered index to keep everything in order.    
ALTER TABLE #DirectoryTree    
ADD CONSTRAINT PK_DirectoryTree PRIMARY KEY CLUSTERED (id);    
    
--Populate the table using the initial base path.    
INSERT #DirectoryTree (subdirectory,depth,isfile)    
EXEC master.sys.xp_dirtree @BasePath,1,1;    
    
UPDATE #DirectoryTree SET fullpath = @BasePath;    
    
--Loop through the table as long as there are still folders to process.    
WHILE EXISTS (SELECT id FROM #DirectoryTree WHERE isfile = 0)    
BEGIN    
      --Select the first row that is a folder.    
      SELECT TOP (1)    
             @Id = id    
            ,@FullPath = fullpath    
            ,@Path = @BasePath + '\' + subdirectory    
      FROM #DirectoryTree WHERE isfile = 0;    
    
      IF @FullPath = @Path    
      BEGIN    
            --Do this section if the we are still in the same folder.    
            INSERT #DirectoryTree (subdirectory,depth,isfile)    
            EXEC master.sys.xp_dirtree @Path,1,1;    
    
            UPDATE #DirectoryTree    
            SET fullpath = @Path    
            WHERE fullpath IS NULL;    
    
            --Delete the processed folder.    
            DELETE FROM #DirectoryTree WHERE id = @Id;    
      END    
      ELSE    
      BEGIN    
            --Do this section if we need to jump down into another subfolder.    
            SET @BasePath = @FullPath;    
    
            --Select the first row that is a folder.    
            SELECT TOP (1)    
                   @Id = id    
                  ,@FullPath = fullpath    
                  ,@Path = @BasePath + '\' + subdirectory    
            FROM #DirectoryTree WHERE isfile = 0;    
    
            INSERT #DirectoryTree (subdirectory,depth,isfile)    
            EXEC master.sys.xp_dirtree @Path,1,1;    
    
            UPDATE #DirectoryTree    
            SET fullpath = @Path    
            WHERE fullpath IS NULL;    
    
            --Delete the processed folder.    
            DELETE FROM #DirectoryTree WHERE id = @Id;    
      END    
END    
    
--Output the results.    
insert into Temppathlist (pathlist)    
SELECT fullpath + '\' + subdirectory AS 'CompleteFileList'    
--,depth,subdirectory,id,fullpath,isfile    
FROM #DirectoryTree    
ORDER BY fullpath,subdirectory;    
select pathlist from Temppathlist where SUBSTRING(pathlist,len(pathlist)-3,len(pathlist)) ='xlsx'  

----Cleanup.    
--IF OBJECT_ID('tempdb..#DirectoryTree') IS NOT NULL    
--      DROP TABLE #DirectoryTree;    
--GO    
end    
    
--Create table Temppathlist(pathlist nvarchar(max))    
    
--EXEC master.sys.xp_dirtree 'D:\Excel folder',0,1;
GO
/****** Object:  StoredProcedure [dbo].[GetExcelDataToImport_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetExcelDataToImport_SP] --'D:\Excelfolder\Anshul-Root\Anshul-Subroot\75.xlsx','[Sheet1$]','75'        
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
GO
/****** Object:  StoredProcedure [dbo].[GET_SUBMODULEData_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_SUBMODULEData_SP]
AS
BEGIN
SELECT tblSubroot.subroot_id,tblroot.root_name,tblSubroot.subroot_name FROM tblroot INNER JOIN tblSubroot 
ON tblroot.Root_id=tblSubroot.root_id
END
GO
/****** Object:  StoredProcedure [dbo].[GET_MODULEDDL_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_MODULEDDL_SP]
AS
BEGIN
SELECT [Root_id],[root_name] FROM [tblroot]
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetSubRoot_ID]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnGetSubRoot_ID]  
(  
 @Areaname nvarchar(50)  
  
)  
returns int  
As  
Begin  
  return (select subroot_id from tblSubroot where subroot_name= (select max(level2) from DirectoryTree where level3=@Areaname))  
  
  
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetArea_ID]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnGetArea_ID]
(
 @SubAreaname nvarchar(50)

)
returns int
As
Begin
		return (select area_id from tblArea where Areaname= (select max(level3) from DirectoryTree where level4=@SubAreaname))


END
GO
/****** Object:  StoredProcedure [dbo].[DirTree]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DirTree] @Folder varchar(100)      
AS      
BEGIN       
--drop table #DirTree    
-- Get row folder map into a temporary table      
CREATE TABLE #DirTree (ID int IDENTITY(1,1),SubDir varchar(100), Depth int, ParentID int default(1),isfile int)      
INSERT #DirTree (SubDir, Depth, ParentID,isfile)       
SELECT @Folder,0,0,0      
INSERT #DirTree(SubDir,Depth,isfile)      
EXEC master.sys.xp_dirtree  'D:\Excelfolder' ,0,1;     
      
-- Update ParentID      
UPDATE #DirTree set ParentID=b.ID      
FROM #DirTree, #DirTree b      
WHERE #DirTree.ID > b.ID      
and b.ID = (SELECT max(ID) FROM #DirTree c      
WHERE c.ID < #DirTree.ID and #DirTree.Depth = c.Depth+1);      
      
-- Create a table for results      
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects       
WHERE id = OBJECT_ID(N'[dbo].[DirectoryTree]')       
AND OBJECTPROPERTY(id, N'IsUserTable') = 1)      
BEGIN      
CREATE TABLE [dbo].[DirectoryTree](      
[DirectoryTreeID] [int] IDENTITY(1,1) NOT NULL,      
[Root] [varchar](100) NULL,      
[Level1] [varchar](100) NOT NULL,      
[Level2] [varchar](100) NOT NULL,      
[Level3] [varchar](100) NOT NULL,      
[Level4] [varchar](100) NOT NULL,      
[Level5] [varchar](100) NOT NULL,      
[Level6] [varchar](100) NOT NULL,      
[Level7] [varchar](100) NOT NULL,      
[Level8] [varchar](100) NOT NULL,      
[Level9] [varchar](100) NOT NULL,      
[Level10] [varchar](100) NOT NULL,      
[Level11] [varchar](100) NOT NULL,      
[Level12] [varchar](100) NOT NULL      
) ON [PRIMARY]      
END ;      
      
DELETE DirectoryTree WHERE Root=@Folder;      
      
-- Recursive CTE      
WITH cteDirTree(FolderID, Name, ParentID, Level)      
AS(       
-- Anchor Member (AM)       
SELECT ID, SubDir, ParentID, 0       
FROM #DirTree      
WHERE ParentID = 0      
UNION ALL       
-- Recursive Member (RM)       
SELECT ID, SubDir, D.ParentID, C.Level+1       
FROM #DirTree D      
JOIN cteDirTree AS C      
ON D.ParentID = C.FolderID)       
      
      
      
-- Tree builder from one level to next       
INSERT INTO [DirectoryTree]([Root],[Level1],[Level2],[Level3],      
[Level4],[Level5],[Level6],[Level7],[Level8],[Level9],      
[Level10],[Level11],[Level12])      
SELECT Root=l0.Name, Level1=isnull(l1.Name, ''),      
Level2=isnull(l2.Name,''), Level3=isnull(l3.Name,''), Level4=isnull(l4.Name,''),      
Level5=isnull(l5.Name,''),Level6=isnull(l6.Name,''), Level7=isnull(l7.Name,''),      
Level8=isnull(l8.Name,''), Level9=isnull(l9.Name,''), Level10=isnull(l10.Name,''),      
Level11=isnull(l11.Name,''), Level12=isnull(l12.Name,'')      
FROM       
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=0) l0      
LEFT JOIN       
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=1) l1      
ON l1.ParentID =l0.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=2) l2      
ON l2.ParentID = l1.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=3) l3      
ON l3.ParentID = l2.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=4) l4      
ON l4.ParentID = l3.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=5) l5      
ON l5.ParentID = l4.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=6) l6      
ON l6.ParentID = l5.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=7) l7      
ON l7.ParentID = l6.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=8) l8      
ON l8.ParentID = l7.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=9) l9      
ON l9.ParentID = l8.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=10) l10      
ON l10.ParentID = l9.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=11) l11      
ON l11.ParentID = l10.FolderID      
LEFT JOIN      
(SELECT Name, FolderID, ParentID FROM cteDirTree where Level=12) l12      
ON l12.ParentID = l11.FolderID      
ORDER BY l1.Name, l2.Name, l3.Name, l4.Name, l5.Name, l6.Name, l7.Name,      
l8.Name, l9.Name, l10.Name, l11.Name, l12.Name      
      
SELECT * FROM DirectoryTree WHERE ROOT=@Folder ORDER BY DirectoryTreeID    
if exists ( select level1 from DirectoryTree where level1 not in (select root_name from tblroot ) )     
begin     
 insert into tblroot (root_name) select distinct level1 from DirectoryTree where level1 not in (select root_name from tblroot )      
end    
--if exists ( select Level2 from DirectoryTree where Level2 not in (select subroot_name from tblSubroot )  )    
begin    
 insert into tblsubroot(subroot_name) select distinct Level2 from DirectoryTree where Level2 not in (select subroot_name from tblSubroot )      
 --delete from tblSubroot where root_id is null    
end    
--if exists ( (select root_id from tblroot where root_name=(select max(Level1) from DirectoryTree)))    
--begin    
 --update tblSubroot set root_id= (select Root_id from tblroot where root_name in (select (Level1) from DirectoryTree)) where  subroot_name=((select max(level2) from DirectoryTree))    
     
--end    
--if exists (select distinct level3 from DirectoryTree where Level3 not in (select areaname from tblArea) )    
begin    
 insert into tblArea (Areaname) select distinct level3 from DirectoryTree where Level3 not in (select areaname from tblArea)     
 --update tblArea set Subrootid=(select subroot_id from tblSubroot where subroot_name in (select level2 from DirectoryTree))    
end    
--delete from tblSubroot where root_id is null    
 update tblSubroot set root_id=DBO.fnGetRoot_ID(subroot_name)  
 update tblArea set Subrootid=DBO.fnGetSubRoot_ID (Areaname)  
 update TblSubArea set AreaId=dbo.fnGetArea_ID(SubAreaName)  
 --update tblScenarioName set Subareaid=dbo.fnGetScenario_ID(  
   
END      
    
--exec [DirTree]'D:\Excel folder'    
--select * from dbo.tblroot    
--select * from tblsubroot    
--select * from DirectoryTree    
--SELECT * FROM dbo.tblArea    
--select * from dbo.TblSubArea  
--select * from dbo.tblScenarioName
GO
/****** Object:  StoredProcedure [dbo].[DirTreetempnew]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DirTreetempnew] @Folder varchar(100)  
AS  
BEGIN  
-- Source: www.sqlusa.com  
-- Author: Kalman Toth  
-- November 7, 2005  
  
  
-- Get row folder map into a temporary table  
CREATE TABLE DirTreetempnew (ID int IDENTITY(1,1),SubDir varchar(100), Depth int, ParentID int default(1))  
INSERT DirTreetempnew (SubDir, Depth, ParentID)  
SELECT @Folder,0,0  
INSERT DirTreetempnew(SubDir,Depth)  
EXEC master.sys.xp_DirTreetempnew @Folder  
  
-- Update ParentID  
UPDATE DirTreetempnew set ParentID=b.ID  
FROM DirTreetempnew, DirTreetempnew b  
WHERE DirTreetempnew.ID > b.ID  
and b.ID = (SELECT max(ID) FROM DirTreetempnew c  
WHERE c.ID < DirTreetempnew.ID and DirTreetempnew.Depth = c.Depth+1);  
  
-- Create a table for results  
IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects  
WHERE id = OBJECT_ID(N'[dbo].[DirectoryTree]')  
AND OBJECTPROPERTY(id, N'IsUserTable') = 1)  
BEGIN  
CREATE TABLE [dbo].[DirectoryTree](  
[DirectoryTreeID] [int] IDENTITY(1,1) NOT NULL,  
[Root] [varchar](100) NULL,  
[Level1] [varchar](100) NOT NULL,  
[Level2] [varchar](100) NOT NULL,  
[Level3] [varchar](100) NOT NULL,  
[Level4] [varchar](100) NOT NULL,  
[Level5] [varchar](100) NOT NULL,  
[Level6] [varchar](100) NOT NULL,  
[Level7] [varchar](100) NOT NULL,  
[Level8] [varchar](100) NOT NULL,  
[Level9] [varchar](100) NOT NULL,  
[Level10] [varchar](100) NOT NULL,  
[Level11] [varchar](100) NOT NULL,  
[Level12] [varchar](100) NOT NULL  
) ON [PRIMARY]  
END ;  
  
DELETE DirectoryTree WHERE Root=@Folder;  
  
-- Recursive CTE  
WITH cteDirTreetempnew(FolderID, Name, ParentID, Level)  
AS(  
-- Anchor Member (AM)  
SELECT ID, SubDir, ParentID, 0  
FROM DirTreetempnew  
WHERE ParentID = 0  
UNION ALL  
-- Recursive Member (RM)  
SELECT ID, SubDir, D.ParentID, C.Level+1  
FROM DirTreetempnew D  
JOIN cteDirTreetempnew AS C  
ON D.ParentID = C.FolderID)  
  
  
-- Tree builder from one level to next  
INSERT INTO [DirectoryTree]([Root],[Level1],[Level2],[Level3],  
[Level4],[Level5],[Level6],[Level7],[Level8],[Level9],  
[Level10],[Level11],[Level12])  
SELECT Root=l0.Name, Level1=isnull(l1.Name, ''),  
Level2=isnull(l2.Name,''), Level3=isnull(l3.Name,''), Level4=isnull(l4.Name,''),  
Level5=isnull(l5.Name,''),Level6=isnull(l6.Name,''), Level7=isnull(l7.Name,''),  
Level8=isnull(l8.Name,''), Level9=isnull(l9.Name,''), Level10=isnull(l10.Name,''),  
Level11=isnull(l11.Name,''), Level12=isnull(l12.Name,'')  
FROM  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=0) l0  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=1) l1  
ON l1.ParentID =l0.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=2) l2  
ON l2.ParentID = l1.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=3) l3  
ON l3.ParentID = l2.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=4) l4  
ON l4.ParentID = l3.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=5) l5  
ON l5.ParentID = l4.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=6) l6  
ON l6.ParentID = l5.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=7) l7  
ON l7.ParentID = l6.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=8) l8  
ON l8.ParentID = l7.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=9) l9  
ON l9.ParentID = l8.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=10) l10  
ON l10.ParentID = l9.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=11) l11  
ON l11.ParentID = l10.FolderID  
LEFT JOIN  
(SELECT Name, FolderID, ParentID FROM cteDirTreetempnew where Level=12) l12  
ON l12.ParentID = l11.FolderID  
ORDER BY l1.Name, l2.Name, l3.Name, l4.Name, l5.Name, l6.Name, l7.Name,  
l8.Name, l9.Name, l10.Name, l11.Name, l12.Name  
  
SELECT * FROM DirectoryTree WHERE ROOT=@Folder ORDER BY DirectoryTreeID  
END  
  
exec [DirTreetempnew]'D:\Excelfolder'
GO
/****** Object:  StoredProcedure [dbo].[Delete_SubModule_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_SubModule_SP]  
(
@subroot_ID INT,  
@subroot_name nvarchar(200)
)
AS  
BEGIN  


declare @mpath nvarchar(200)=''
declare @root_id int
declare @root_name nvarchar(200)=''
 
set @root_id=(select max(root_id) from tblSubroot where subroot_id=@subroot_ID )
print @root_id
set @root_name=(select root_name from tblroot where Root_id=@root_id)
print @root_name
set @mpath='rd  D:\Excelfolder\'+ @root_name +'\'+@subroot_name
delete from tblSubroot where subroot_id=@subroot_ID
print @mpath
exec master..xp_cmdshell @mpath  

END
GO
/****** Object:  StoredProcedure [dbo].[Delete_SUBAREA_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Delete_SUBAREA_SP]
(
@SubAreaId INT     

)
as
begin
delete from TblSubArea where SubAreaId=@SubAreaId
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_Module_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Module_SP]
@moduleid INT
AS
BEGIN
declare @root_name nvarchar(200)
declare @mpath nvarchar(200)

set @root_name=(select root_name from tblroot where Root_id=@moduleid)
set @mpath='rd  D:\Excelfolder\'+ @root_name
exec master..xp_cmdshell @mpath
delete FROM tblroot where Root_id=@moduleid
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_AREA_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_AREA_SP]
(
@subroot_ID INT,    
@subroot_name nvarchar(200) ,
@AREA_NAME nvarchar(200),
@AREA_ID INT
)
AS
BEGIN

declare @mpath nvarchar(200)=''  
declare @root_id int  
declare @root_name nvarchar(500)=''  
  
set @root_id=(select max(root_id) from tblSubroot where subroot_id=@subroot_ID )  
set @root_name=(select root_name from tblroot where Root_id=@root_id)  
print @mpath
set @mpath='del  D:\Excelfolder\'+ @root_name +'\'+@subroot_name+'\'+@AREA_NAME
print @mpath
delete from tblArea where Area_id=@AREA_ID  
exec master..xp_cmdshell @mpath  

END
GO
/****** Object:  StoredProcedure [dbo].[CreateFilelist_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CreateFilelist_SP]  
--(  
--@Filepath nvarchar(max)  
--)  
as  
begin  
  
truncate table ExcelPathList  
insert into ExcelPathList(SubDirectoryList,depth,filecount) EXEC xp_dirtree 'D:\Excelfolder', 10, 3  
select * from ExcelPathList  
end
GO
/****** Object:  StoredProcedure [dbo].[ShowSUBArea_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ShowSUBArea_SP]    
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
GO
/****** Object:  StoredProcedure [dbo].[ShowArea_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ShowArea_SP]  
as  
begin  
select tblSubroot.root_id,tblSubroot.subroot_id,tblSubroot.subroot_name,tblArea.Area_id,tblArea.Areaname from tblArea  
inner join tblSubroot on tblSubroot.subroot_id=tblArea.Subrootid  
where subroot_name<>''  
end
GO
/****** Object:  StoredProcedure [dbo].[Show_Module_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Show_Module_SP]
AS
BEGIN
SELECT Root_id,root_name FROM tblroot
END
GO
/****** Object:  StoredProcedure [dbo].[SaveScenarios_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SaveScenarios_SP]  
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
GO
/****** Object:  StoredProcedure [dbo].[Save_SubModule_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Save_SubModule_SP]      
(    
@moduleid int,    
@submodulename as nvarchar(max)      
)    
AS      
Begin 
declare @stringpath as nvarchar(200)=''   
declare @modulename as nvarchar(200)=''   
INSERT INTO [tblSubroot]([subroot_name],[root_id])VALUES(@submodulename,@moduleid)   
set @modulename=(select root_name from tblroot where Root_id=@moduleid)
set @stringpath='MD D:\Excelfolder\'+ @modulename +'\'+  @submodulename
exec master..xp_cmdshell @stringpath  
END
GO
/****** Object:  StoredProcedure [dbo].[Save_SubArea_SP]    Script Date: 11/14/2013 19:34:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Save_SubArea_SP]  
(

@areaid int,
@subareaAreaename as nvarchar(max)  
)
AS  
Begin  
INSERT INTO TblSubArea(AreaId,SubAreaName)VALUES(@areaid,@subareaAreaename)  
END
GO
/****** Object:  StoredProcedure [dbo].[Save_Module_SP]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Save_Module_SP]    
@modulename as varchar(200)
  
AS    
Begin
declare @stringpath as nvarchar(200)=''     
INSERT INTO [tblroot]([root_name])VALUES(@modulename)   
set @stringpath='MD D:\Excelfolder\'+ @modulename

exec master..xp_cmdshell @stringpath

END
GO
/****** Object:  StoredProcedure [dbo].[Save_Area_SP]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Save_Area_SP]        
(      
      
@Submoduleid int,      
@Areaename as nvarchar(max) ,  
@selectedModule  as nvarchar(max),  
@selectedsubmodule as nvarchar(max)  
)      
AS        
Begin       
--DECLARE @cmd sysname ='copy D:\ProductMapExcelTemplate\Template.xlsx D:\Excelfolder\'+@selectedModule +'\'+ @selectedsubmodule + '\'+ @Areaename +'\' +'.xlsx'   
  
DECLARE @cmd sysname ='copy D:\ProductMapExcelTemplate\Template.xlsx D:\Excelfolder\'+@selectedModule +'\'+ @selectedsubmodule + '\'+ @Areaename +'.xlsx'   
INSERT INTO [tblArea](Subrootid,Areaname)VALUES(@Submoduleid,@Areaename+'.xlsx')    
EXEC master..xp_cmdshell @cmd    
END  

select * from [tblArea]
GO
/****** Object:  StoredProcedure [dbo].[Returenrootid_SP]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure  [dbo].[Returenrootid_SP] --'Roll-Forword'
(
	-- Add the parameters for the function here
	@childname nvarchar(max)
)
--RETURNS int 
AS
BEGIN
	 (select max(root_id) from tblroot where root_name = (select level1 from DirectoryTree where Level2=@childname))


END
GO
/****** Object:  UserDefinedFunction [dbo].[Returenrootid_FN]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Returenrootid_FN]
(
	-- Add the parameters for the function here
	@childname nvarchar(max)
)
RETURNS int 
AS
BEGIN
	return (select root_id from tblroot where root_name= (select level1 from DirectoryTree where Level2=@childname))


END
GO
/****** Object:  Table [dbo].[tblArea]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArea](
	[Area_id] [int] IDENTITY(1,1) NOT NULL,
	[Areaname] [nvarchar](50) NULL,
	[Subrootid] [int] NULL,
 CONSTRAINT [PK_tblArea] PRIMARY KEY CLUSTERED 
(
	[Area_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblSubArea]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblSubArea](
	[SubAreaId] [int] IDENTITY(1,1) NOT NULL,
	[SubAreaName] [nvarchar](max) NULL,
	[AreaId] [int] NULL,
	[checked] [int] NULL,
 CONSTRAINT [PK_TblSubArea] PRIMARY KEY CLUSTERED 
(
	[SubAreaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblScenarioName]    Script Date: 11/14/2013 19:34:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblScenarioName](
	[SC_id] [int] IDENTITY(1,1) NOT NULL,
	[SC_Name] [nvarchar](max) NULL,
	[SCType_Id] [int] NULL,
	[TagName] [nvarchar](max) NULL,
	[Subareaid] [int] NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblScenarioName] PRIMARY KEY CLUSTERED 
(
	[SC_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF__ProductMa__Paren__2E1BDC42]    Script Date: 11/14/2013 19:34:43 ******/
ALTER TABLE [dbo].[ProductMapTree] ADD  DEFAULT ((1)) FOR [ParentID]
GO
/****** Object:  ForeignKey [FK_tblSubroot_tblroot]    Script Date: 11/14/2013 19:34:46 ******/
ALTER TABLE [dbo].[tblSubroot]  WITH CHECK ADD  CONSTRAINT [FK_tblSubroot_tblroot] FOREIGN KEY([root_id])
REFERENCES [dbo].[tblroot] ([Root_id])
GO
ALTER TABLE [dbo].[tblSubroot] CHECK CONSTRAINT [FK_tblSubroot_tblroot]
GO
/****** Object:  ForeignKey [FK_tblArea_tblSubroot]    Script Date: 11/14/2013 19:34:47 ******/
ALTER TABLE [dbo].[tblArea]  WITH CHECK ADD  CONSTRAINT [FK_tblArea_tblSubroot] FOREIGN KEY([Subrootid])
REFERENCES [dbo].[tblSubroot] ([subroot_id])
GO
ALTER TABLE [dbo].[tblArea] CHECK CONSTRAINT [FK_tblArea_tblSubroot]
GO
/****** Object:  ForeignKey [FK_TblSubArea_tblArea]    Script Date: 11/14/2013 19:34:47 ******/
ALTER TABLE [dbo].[TblSubArea]  WITH CHECK ADD  CONSTRAINT [FK_TblSubArea_tblArea] FOREIGN KEY([AreaId])
REFERENCES [dbo].[tblArea] ([Area_id])
GO
ALTER TABLE [dbo].[TblSubArea] CHECK CONSTRAINT [FK_TblSubArea_tblArea]
GO
/****** Object:  ForeignKey [FK_tblScenarioName_tblSubAreaType]    Script Date: 11/14/2013 19:34:47 ******/
ALTER TABLE [dbo].[tblScenarioName]  WITH CHECK ADD  CONSTRAINT [FK_tblScenarioName_tblSubAreaType] FOREIGN KEY([Subareaid])
REFERENCES [dbo].[TblSubArea] ([SubAreaId])
GO
ALTER TABLE [dbo].[tblScenarioName] CHECK CONSTRAINT [FK_tblScenarioName_tblSubAreaType]
GO
