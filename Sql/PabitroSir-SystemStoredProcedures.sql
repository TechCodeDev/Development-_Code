--System Procedures
--

--1) To get Statistics about your Microsoft SQL Server Initialization
		
		exec sys.sp_monitor
		go

		exec sys.sp_server_info

--2)To know who is curently connected to your Microsoft SQL Server
	--arguments that can be passed are login name, processid,

		exec sys.sp_who
		exec sys.sp_who2

--3)

--4) To get information about a database
	--arguments passed are database name

		exec sys.sp_helpdb
		exec sys.sp_helpdb 'DemoDB'

		exec sys.sp_helpfile
 		exec sys.sp_helpfile  -------------

		exec sys.sp_helpfilegroup

--5)To get infromation about object/database ,
 

