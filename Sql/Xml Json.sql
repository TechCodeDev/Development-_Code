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

select * from HumanResources.Department
