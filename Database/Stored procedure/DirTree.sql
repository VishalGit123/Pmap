USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[DirTree]    Script Date: 11/14/2013 20:52:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[DirTree] @Folder varchar(100)      
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
