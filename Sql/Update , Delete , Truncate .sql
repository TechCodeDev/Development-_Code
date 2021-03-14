UPDATE dbo.Department_2 
SET Name = 'pqr'
WHERE DepartmentID = 64


UPDATE dbo.Department_2
SET Name = 'Raj', GroupName ='Raj'
WHERE DepartmentID = 66


UPDATE 
    D3
SET 
    D3.Name = D2.Name,
	D3.GroupName = D2.GroupName
FROM  
	dbo.Department_3 D3
	JOIN dbo.Department_2 D2
    ON D2.DepartmentID = D3.DepartmentID

select * from dbo.Department_2
select * from dbo.Department_3

-- TRUCNCATE

DELETE FROM dbo.Department_3
WHERE DepartmentID = 76


-- delete all rec but not droop table
DELETE FROM dbo.Department_3

-- delete all rec and reset identity to default
truncate table dbo.Department_2

select * from dbo.Department_2

select * from dbo.Department_3

-- delete with join 

DELETE D2
       FROM dbo.Department_2 D2
	   JOIN dbo.Department_3  D3
	   ON D2.DepartmentID = D3.DepartmentID
