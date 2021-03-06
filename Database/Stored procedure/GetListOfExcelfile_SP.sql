USE [ProductMap]
GO
/****** Object:  StoredProcedure [dbo].[GetListOfExcelfile_SP]    Script Date: 11/14/2013 20:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetListOfExcelfile_SP]    
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
