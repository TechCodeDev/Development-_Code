--1)To get many statistics about your Microsoft SQL Server installation

	exec sys.sp_monitor
	go

	exec sys.sp_server_info


--2) to know who is currently connected to your Microsoft SQL Server
--arguments that can be passed are login name, sessid, processid, active

	exec sys.sp_who  
	exec sys.sp_who2


--3) to rename an object(Table Name , View Name , SPs, Triggers, Functions or Database) in a database

	use eLearningDB;
	go

	exec sys.sp_rename  [dbo.Trainers], 'Tutors' 
	print "Success"


	exec sys.sp_renamedb 'Demo' ,'DemoDB'

--4) To get information about a database,
--arguments passed are database name, 

	exec sys.sp_helpdb 
	exec sys.sp_helpdb 'DemoDB'

exec sys.sp_helpfile 
exec sys.sp_helpfile eLearningDB_log


exec sys.sp_helpfilegroup 


--5) To get information about a object/database,
--arguments passed are database name,Table Name, View Name, SPs etc 

exec sys.sp_help sp_columns



--6) to get the size of an object

exec sys.sp_spaceused 

--7)To get details about the columns of a table
-- arguments passed are @table_name , @column_name, 

exec sys.sp_columns Courses

--9) to refresh or update the metadata of a view

use AdventureWorks;
go
exec sys.sp_refreshview [Sales.vSalesPerson]

--10) To get information about a trigger
--arguments that can be passed are 
exec sys.sp_helptrigger [HumanResources.Department]

--11) To get information about the constraints in a database

exec sys.sp_helpconstraint [HumanResources.Department]


--12) to get dependencies details of an object

exec sys.sp_depends [HumanResources.Department]

--13) to see the coode of SPs

exec sp_helptext spname

exec sys.sp_help

--14) to Execute dynamic SQL 

exec sp_executesql StringSQL

DECLARE @SQLString nvarchar(500);
DECLARE @ParmDefinition nvarchar(500);

SET @SQLString =   ' select * from AdventureWorks.HumanResources.Department where DepartmentID=@ID ';
SET @ParmDefinition = N'@ID tinyint';

SET @IntVariable = 1;
EXEC sp_executesql @SQLString, @ParmDefinition, @ID = @IntVariable;


--15) to make a stored procedure auto execute

exec sp_procoption  [dbo.Up_SelName]

--16) to get the details of data type
exec sp_datatype_info

--17)to get details of foreign key

exec sys.sp_fkeys

--18) to get details of primary  key

exec sys.sp_pkeys


--19)  to know  columns automatically updated when any value in the row is updated

exec sys.sp_special_columns

--20)to Lists databases that reside in an instance of Microsoft� SQL Server

exec sys.sp_databases

--21)to get column information for a single stored procedure or user-defined function 

exec sys.sp_sproc_columns

--22) to get  indexes and statistics on a specified table or indexed view.

exec sys.sp_statistics

--23) to get a list of stored procedures in the current environment.
exec sys.sp_stored_procedures

--24)to get aa list of table permissions 
exec sys.sp_table_privileges

--24) to get a list of a list of objects  tables

exec sys.sp_tables


--25) to atach a database 

exec sys.sp_attach_db


--26) Removes a database and all files associated with that database.

exec sys.sp_dbremove


--27) to Detaches a database from a server and,

exec sys.sp_detach_db

--28) to set AFTER trigger order 
exec sys.sp_settriggerorder

--29) to recompaile procedures and trigger

exec sys.sp_recompile

--30) to get  statistics information about columns and indexes on the specified table.

exec sys.sp_helpstats

--31) to get information about the indexes on a table or view.
sp_helpindex

--31) to recomplie sp
 sp_recompile
 
 
 

