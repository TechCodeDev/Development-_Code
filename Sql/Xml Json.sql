DECLARE @XML_DOC VARCHAR(MAX);
DECLARE @Doc_Pointer INT;
SET @XML_DOC ='<root>
		     <row>
			  <DepartmentID>17</DepartmentID>
			  <Name>FSP</Name>
			  <GroupName>SD</GroupName>
			  <ModifiedDate>2020-02-17</ModifiedDate>
	   	    </row>
		    <row>
			   <DepartmentID>18</DepartmentID>
			   <Name>SD</Name>
			   <GroupName>SD</GroupName>
			   <ModifiedDate>2020-02-17</ModifiedDate>
		    </row>
		    <row>
			  <DepartmentID>19</DepartmentID>
			  <Name>QA</Name>
			  <GroupName>Testing</GroupName>
			  <ModifiedDate>2020-02-17</ModifiedDate>
		   </row>
		   <row>
			 <DepartmentID>20</DepartmentID>
			 <Name>QC</Name>
			 <GroupName>Testing</GroupName>
			 <ModifiedDate>2020-02-17</ModifiedDate>
		  </row>
		  <row>
			<DepartmentID>21</DepartmentID>
			<Name>CS</Name>
			<GroupName>CS</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		 </row>
	</root>' 
EXEC sp_xml_preparedocument  @Doc_Pointer OUTPUT , @XML_DOC
SELECT * FROM OPENXML(@Doc_Pointer,'/root/row',2) 
WITH (DepartmentID INT , Name VARCHAR(50) , GroupName VARCHAR(50), ModifiedDate DATE)
EXEC sp_xml_removedocument  @Doc_Pointer 
GO


-- select and insert
DECLARE @XML_DOC VARCHAR(MAX);
DECLARE @Doc_Pointer INT;
SET @XML_DOC ='<root>
		  <row>
			<DepartmentID>17</DepartmentID>
			<Name>FSP</Name>
			<GroupName>SD</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		  </row>
                  <row>
 			<DepartmentID>18</DepartmentID>
			<Name>SD</Name>
			<GroupName>SD</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>19</DepartmentID>
		   	<Name>QA</Name>
			<GroupName>Testing</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>20</DepartmentID>
			<Name>QC</Name>
			<GroupName>Testing</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
		<row>
			<DepartmentID>21</DepartmentID>
			<Name>CS</Name>
			<GroupName>CS</GroupName>
			<ModifiedDate>2020-02-17</ModifiedDate>
		</row>
	     </root>' 
EXEC sp_xml_preparedocument  @Doc_Pointer OUTPUT , @XML_DOC
INSERT INTO HumanResources.Department(Name,GroupName,ModifiedDate)
SELECT Name,GroupName,ModifiedDate FROM OPENXML(@Doc_Pointer,'/root/row',2) 
WITH (Name VARCHAR(50) , GroupName VARCHAR(50), ModifiedDate DATE)
EXEC sp_xml_removedocument  @Doc_Pointer 
GO

------------------------------------- INSERT ----------------------------------

drop  PROCEDURE [dbo].InsertEmployee
CREATE PROCEDURE [dbo].InsertEmployee(	
	@XmlDocument nvarchar(max) )
	AS
BEGIN
DECLARE @DepartmentID int 
	SET NOCOUNT ON		
		BEGIN
			EXEC sp_xml_preparedocument @DepartmentID OUTPUT,@XmlDocument
			INSERT INTO [dbo].Department (Name,GroupName)
			SELECT  *
			FROM OPENXML(@DepartmentID,'/Root/Department',1)
			WITH	(	Name varchar(50),
						GroupName varchar(50)
					)
		    EXEC sp_xml_removedocument @DepartmentID 		
		END
END


select * from [dbo].Department



------------------------------------- Update ----------------------------------
drop PROCEDURE [dbo].UpdateEmployee

CREATE PROCEDURE [dbo].UpdateEmployee(   
	@XmlDocument nvarchar(max) )
	AS
BEGIN
DECLARE @DepartmentIDDs int 
	SET NOCOUNT ON		
		BEGIN
			EXEC sp_xml_preparedocument @DepartmentIDDs OUTPUT,@XmlDocument
			Update [dbo].Department
			SET
			    Department.Name=XMLDepartment.Name,
			    Department.GroupName=XMLDepartment.GroupName			
			FROM OPENXML(@DepartmentIDDs,'/Root/Department')
			WITH	(	
			            DepartmentID  INT,        
			            Name varchar(50),
						GroupName varchar(50)
					) XMLDepartment
			where Department.DepartmentID=XMLDepartment.DepartmentID		 	
		END
END


select * from [dbo].Department

---------------------------------------------------------


------------------------------------- Delete ----------------------------------
drop PROCEDURE [dbo].DeleteEmployee

CREATE PROCEDURE [dbo].DeleteEmployee(   
	@XmlDocument nvarchar(max) )
	AS
BEGIN
DECLARE @DepartmentIDDs int 
	SET NOCOUNT ON		
		BEGIN
			EXEC sp_xml_preparedocument @DepartmentIDDs OUTPUT,@XmlDocument
			Delete [dbo].Department						
			FROM OPENXML(@DepartmentIDDs,'/Root/Department')
			WITH	(	
			            DepartmentID  INT       
			           
					) XMLDepartment
			where Department.DepartmentID=XMLDepartment.DepartmentID		 	
		END
END


select * from [dbo].Department

---------------------------------------------------------

