
--1) List five employees in highest order of salary

select  top(5) eph.EmployeeID,eph.Rate
from HumanResources.EmployeePayHistory eph
order by Rate desc

--2) List the emp details whose salary is greater than the lowest salary of an emloyee belonging to dept=1 
--'Salary'= MIN(eph.Rate) or top(1) can also be used

select  eph.EmployeeID , eph.Rate , ROW_NUMBER() over(order by eph.Rate asc) as [rnk]
from HumanResources.EmployeePayHistory eph
where eph.EmployeeID 
in 
		(
				select edh.EmployeeID 
				from HumanResources.EmployeeDepartmentHistory edh 
				where edh.DepartmentID=1
		)
order by eph.Rate asc


with CTE as
(
select  eph.EmployeeID , eph.Rate , ROW_NUMBER() over(order by eph.Rate asc) as [rnk]
from HumanResources.EmployeePayHistory eph
where eph.EmployeeID 
in 
		(
				select edh.EmployeeID 
				from HumanResources.EmployeeDepartmentHistory edh 
				where edh.DepartmentID=1
		)
)
select * from CTE where [rnk]=2

--Answer
select  eph.EmployeeID , eph.Rate
from HumanResources.EmployeePayHistory eph
where eph.EmployeeID 
in 
		(
				select edh.EmployeeID 
				from HumanResources.EmployeeDepartmentHistory edh 
				where edh.DepartmentID=1
		)
AND eph.Rate >
(
select  min( eph.Rate)
from HumanResources.EmployeePayHistory eph
where eph.EmployeeID 
 in 
		(
				select edh.EmployeeID 
				from HumanResources.EmployeeDepartmentHistory edh 
				where edh.DepartmentID=1
		)
)

--3) list the employee details if and only if more than 10 employees are there in that department

select  edh.DepartmentID , COUNT(edh.EmployeeID) as 'EmpCount' 
from HumanResources.EmployeeDepartmentHistory edh
where edh.DepartmentID 
in
(
	select d.DepartmentID from HumanResources.Department d
)
group by edh.DepartmentID
having COUNT(edh.EmployeeID) >10


--4) list out all the jobs unique to departments

select distinct  e.Title , edh.DepartmentID , d.Name,d.GroupName  from HumanResources.Employee e 
join HumanResources.EmployeeDepartmentHistory edh
on e.EmployeeID=edh.EmployeeID
join HumanResources.Department d
on edh.DepartmentID=d.DepartmentID
where e.EmployeeID
in
(
select edh.EmployeeID from HumanResources.EmployeeDepartmentHistory edh
where DepartmentID in (1,3,5,7,9,11,13,15)
except
select edh.EmployeeID from HumanResources.EmployeeDepartmentHistory edh
where DepartmentID in (2,4,6,8,10,12,14)
)
order by edh.DepartmentID

--5) list the jobs common to dept 10 and 15

select distinct e.Title , edh.DepartmentID, e.EmployeeID from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory  edh
on e.EmployeeID =edh.EmployeeID
where edh.DepartmentID =10
intersect
select distinct e.Title , edh.DepartmentID, e.EmployeeID from HumanResources.Employee e
join HumanResources.EmployeeDepartmentHistory  edh
on e.EmployeeID =edh.EmployeeID
where edh.DepartmentID =15

--6) list the employees whose salary is greater than or equal to average salary of dept=10

select e.EmployeeID,e.ContactID,e.Title,e.Gender , eph.Rate from HumanResources.Employee e
join HumanResources.EmployeePayHistory eph
on e.EmployeeID=eph.EmployeeID
where eph.Rate >=
(
		select  AVG( eph.Rate) 
		from HumanResources.EmployeePayHistory eph
		where eph.EmployeeID 
		in
			(
				select edh.EmployeeID  from HumanResources.EmployeeDepartmentHistory  edh
				where edh.DepartmentID=10
			)
)

select e.EmployeeID,e.ContactID,e.Title,e.Gender , eph.Rate from HumanResources.Employee e
join HumanResources.EmployeePayHistory eph
on e.EmployeeID=eph.EmployeeID
where eph.Rate >=
(
		select  AVG( eph.Rate) 
		from HumanResources.EmployeePayHistory eph
		join HumanResources.EmployeeDepartmentHistory  edh
		on  eph.EmployeeID =edh.EmployeeID
		where edh.DepartmentID=10
)

--7) list 5 employees in lowest order of salary

select distinct top(5)  eph.Rate 
from HumanResources.EmployeePayHistory eph 
order by eph.Rate asc

select top(5) eph.Rate , COUNT(eph.EmployeeID) as 'EmpCount'
from HumanResources.EmployeePayHistory eph
where eph.Rate
in
(
	select e.Rate from HumanResources.EmployeePayHistory e
)
group by eph.Rate having COUNT(eph.EmployeeID)>1 

select * from HumanResources.EmployeePayHistory
where Rate
in
(
select top(5) eph.Rate  
from HumanResources.EmployeePayHistory eph
where eph.Rate
in
(
	select  e.Rate from HumanResources.EmployeePayHistory e 
)
group by eph.Rate having COUNT(eph.EmployeeID)>1 
)
order by Rate

--8) list last five recods from emp table

select top(5) * from HumanResources.Employee order by EmployeeID desc

select  top (5)ROW_NUMBER() over(order by e.EmployeeID) as [rowno],e.* 
from HumanResources.Employee e
order by rowno desc

with CTE as
(
select ROW_NUMBER() over(order by e.EmployeeID) as [rowno],e.* 
from HumanResources.Employee e
)
select top(5) * from CTE order by rowno desc

--9) Display the year and no of employees for the year in which more than one employee was hired

select   DATEPART(year, e.HireDate)   , COUNT(e.EmployeeID) as 'no of emp hired'
from HumanResources.Employee e
where e.HireDate
in
(
	select ee.HireDate from HumanResources.Employee ee
)
group by DATEPART(year, e.HireDate)
having COUNT( e.EmployeeID)>=1
order by DATEPART(year, e.HireDate) desc


--10)count the number of male and female employees

select COUNT(e.Gender) as 'CountGender'
from HumanResources.Employee e
where e.Gender ='F'
union
select COUNT(e.Gender) 
from HumanResources.Employee e
where e.Gender='M'

select  e.Gender, count(*) as 'Count' from HumanResources.Employee e
where e.Gender
in
(
	select ee.Gender from HumanResources.Employee ee
)
group by e.Gender
having COUNT(*) >1

--11) query department wise maximum , minimum, average salary 

--answer
select edh.DepartmentID,  MAX(eph.Rate) as'MaxSalary' ,MIN(eph.Rate) as'MinSalary' , AVG(eph.Rate) as'AvgSalary' 
from HumanResources.EmployeePayHistory eph
join  HumanResources.EmployeeDepartmentHistory edh
on eph.EmployeeID = edh.EmployeeID
group by edh.DepartmentID


select edh.DepartmentID,  MAX(eph.Rate) as'MaxSalary' ,MIN(eph.Rate) as'MinSalary' , AVG(eph.Rate) as'AvgSalary' 
from HumanResources.EmployeePayHistory eph
join  HumanResources.EmployeeDepartmentHistory edh
on eph.EmployeeID = edh.EmployeeID
where edh.DepartmentID
in
(
		select d.DepartmentID from HumanResources.EmployeeDepartmentHistory d
)
group by edh.DepartmentID
having COUNT(edh.EmployeeID) >1

select edh.DepartmentID,  MAX(eph.Rate) as'MaxSalary' ,MIN(eph.Rate) as'MinSalary' , AVG(eph.Rate) as'AvgSalary' 
from HumanResources.EmployeePayHistory eph
join  HumanResources.EmployeeDepartmentHistory edh
on eph.EmployeeID = edh.EmployeeID
group by edh.DepartmentID
having COUNT(edh.EmployeeID) >1

select  MAX(eph.Rate) as'MaxSalary' ,MIN(eph.Rate) as'MinSalary' , AVG(eph.Rate) as'AvgSalary' 
from HumanResources.EmployeePayHistory eph

--12)  list the department in which there is more than one salesman;
--list the department and count of jobs in which there is more than one salesman;

select e.Title , e.EmployeeID,edh.DepartmentID from HumanResources.Employee e 
join HumanResources.EmployeeDepartmentHistory edh
on edh.EmployeeID=e.EmployeeID 
where e.Title like 'Sales Representative'

select edh.DepartmentID,  COUNT(e.Title) as 'count title' from HumanResources.Employee e 
join HumanResources.EmployeeDepartmentHistory edh
on edh.EmployeeID=e.EmployeeID 
where e.Title like '%Sales%'
group by edh.DepartmentID

--13) list the department that has no employees

select d.DepartmentID , d.Name from HumanResources.Department d
where d.DepartmentID 
not in
(
	select edh.DepartmentID from HumanResources.EmployeeDepartmentHistory edh
)

--14) list emp details whose salary is same as that of  Amy or Ashvini

select * from HumanResources.EmployeePayHistory eph1
where eph1.Rate in
(
select  eph.Rate  from HumanResources.EmployeePayHistory eph
join HumanResources.Employee e
on eph.EmployeeID=e.EmployeeID
join Person.Contact c
on e.ContactID=c.ContactID
where c.FirstName in ( 'Amy','Ashvini')
)

select * from HumanResources.EmployeePayHistory eph1
where exists
(
select  eph.Rate  from HumanResources.EmployeePayHistory eph
join HumanResources.Employee e
on eph.EmployeeID=e.EmployeeID
join Person.Contact c
on e.ContactID=c.ContactID
where c.FirstName in ( 'Amy','Ashvini')
)

select eph.EmployeeID , eph.Rate , e.Title,e.Gender,c.FirstName from HumanResources.EmployeePayHistory eph
join HumanResources.Employee e
on eph.EmployeeID=e.EmployeeID
join Person.Contact c
on e.ContactID=c.ContactID
where c.FirstName in ( 'Amy','Ashvini')

--15) list the employees in dept=10 with the same job as anyone in sales dept , 3, 10  Sales, Finance

select e.EmployeeID,e.Title,edh.DepartmentID from  HumanResources.Employee e
join  HumanResources.EmployeeDepartmentHistory edh
on e.EmployeeID=edh.EmployeeID
where edh.DepartmentID=10
and e.Title in 
(
				select distinct e1.Title from  HumanResources.Employee e1
				join  HumanResources.EmployeeDepartmentHistory edh1
				on e1.EmployeeID=edh1.EmployeeID
				join HumanResources.Department d
				on d.DepartmentID=edh1.DepartmentID
				where d.Name like '%a%'
)

--16) display the information of employees who are also managers
select * from HumanResources.Employee e1
where e1.EmployeeID in
(
	select e2.ManagerID from HumanResources.Employee e2
)
order by e1.EmployeeID

--17) display  the information of employees wheo earn more than any employee in dept=10

select * from HumanResources.Employee e
join HumanResources.EmployeePayHistory eph1
on e.EmployeeID=eph1.EmployeeID
where eph1.Rate >
(
		select max(eph2.Rate)
		from HumanResources.EmployeePayHistory eph2
		where  eph2.EmployeeID
		in
		(
				select edh.EmployeeID
				from HumanResources.EmployeeDepartmentHistory edh 
				where edh.DepartmentID=10
		)
)

--18) list manager's names and employees names that belongs to their managers

--Employee Names
select c.FirstName + SPACE(2)+ c.LastName as 'Emp Name'
from Person.Contact c
join HumanResources.Employee e
on c.ContactID=e.ContactID

--Manager Names
select c.FirstName + SPACE(2)+ c.LastName as 'Manager Name' from Person.Contact c
join HumanResources.Employee e1
on c.ContactID=e1.ContactID
where e1.EmployeeID 
in
(
	select  e2.ManagerID  from HumanResources.Employee e2
)

--using temp tables
select e.EmployeeID , c.ContactID , c.FirstName into #Emp
from HumanResources.Employee e
join Person.Contact c
on c.ContactID=e.ContactID
go
select e.EmployeeID , e.ManagerID  into #Emp_Mgr
from HumanResources.Employee e
go

select t1.FirstName as 'EmpName' , t2.FirstName as 'MgrName'	
from #Emp as t1
join #Emp_Mgr as temp on t1.EmployeeID=temp.EmployeeID
join #Emp as t2 on temp.ManagerID=t2.EmployeeID
order by t2.FirstName
go

--with out temp tables
select empTable.EmployeeID, empTable.[EmpFirstName],mgrTable.ManagerId,mgrTable.ManagerFirstName from
(
		select c1.FirstName + SPACE(2)+ c1.LastName as 'EmpFirstName', e1.ManagerID , e1.EmployeeID
		from Person.Contact c1
		inner join HumanResources.Employee e1
		on c1.ContactID=e1.ContactID
)  as empTable
JOIN
(
		select tempTable.EmployeeID as 'ManagerId',c.FirstName as 'ManagerFirstName' 
		from
		(
				select DISTINCT e3.EmployeeID,e3.ContactID from HumanResources.Employee e2
				inner join HumanResources.Employee e3
				on e2.ManagerID=e3.EmployeeID
		) as  tempTable
				inner join 	Person.Contact c
				on 
				tempTable.ContactID=c.ContactID

) as mgrTable
on empTable.ManagerID=mgrTable.ManagerId 

--19) list the total salary of each department
		
		select SUM(eph.Rate) from HumanResources.EmployeePayHistory eph
		join HumanResources.EmployeeDepartmentHistory edh
		on eph.EmployeeID=edh.EmployeeID
		where edh.DepartmentID=1

		select edh.DepartmentID , SUM(eph.Rate) as 'TotalSalary' from HumanResources.EmployeePayHistory eph
		join HumanResources.EmployeeDepartmentHistory edh
		on edh.EmployeeID=eph.EmployeeID
		group by edh.DepartmentID

--20)list department name , employee name , emp id 
		
		select d.Name as 'DeptName' , e.EmployeeID , p.FirstName +SPACE(2)+p.LastName  as 'EmpName' 
		from HumanResources.Department d
		join HumanResources.EmployeeDepartmentHistory edh
		on edh.DepartmentID=d.DepartmentID
		join HumanResources.Employee e
		on e.EmployeeID=edh.EmployeeID
		join Person.Contact p
		on p.ContactID=e.ContactID
		order by d.Name


--21) display entire employee details where salary > lowest salary of employees in dept=10

			select * from HumanResources.Employee e
			join HumanResources.EmployeePayHistory eph1
			on eph1.EmployeeID=e.EmployeeID
			where eph1.Rate >(
						select MIN(eph2.Rate) from HumanResources.EmployeePayHistory eph2
						where eph2.EmployeeID 
						in
						(
							select edh.EmployeeID 
							from HumanResources.EmployeeDepartmentHistory edh 
							where edh.DepartmentID=10
						) 
			)


			select * from HumanResources.Employee e
			join HumanResources.EmployeePayHistory eph1
			on eph1.EmployeeID=e.EmployeeID
			where eph1.Rate >(
						select MIN(eph2.Rate) from HumanResources.EmployeePayHistory eph2
					     join HumanResources.EmployeeDepartmentHistory edh
						 on eph2.EmployeeID=edh.EmployeeID 
						where edh.DepartmentID=10
			)

--22) display details of all the employees whose salary is > average salary of employees in respective departments
		

select distinct a.Dept , a.AvgSalary, b.Sal,b.EmployeeID,b.Gender,b.BirthDate,b.MaritalStatus,b.Title,b.ManagerID,b.ContactID from 
(
	select edh.DepartmentID as 'Dept',  AVG(eph.Rate) as'AvgSalary' 
	from HumanResources.EmployeePayHistory eph
	join  HumanResources.EmployeeDepartmentHistory edh
	on eph.EmployeeID = edh.EmployeeID
	group by edh.DepartmentID  
) a
join
(
	select edh1.DepartmentID as 'empDeptID', eph1.Rate as 'Sal', e.*  from HumanResources.Employee e
	join HumanResources.EmployeeDepartmentHistory edh1
	on e.EmployeeID=edh1.EmployeeID 
	join HumanResources.EmployeePayHistory eph1
	on eph1.EmployeeID=edh1.EmployeeID 
) b
on a.Dept=b.empDeptID 
where b.Sal > a.AvgSalary

--23) display all the details of employees  where department is either sales or research

	select edh.DepartmentID, e.* from HumanResources.Employee e
	join HumanResources.EmployeeDepartmentHistory edh
	on e.EmployeeID=edh.EmployeeID
	where edh.DepartmentID in (
		select DepartmentID from HumanResources.Department where Name in ('Research and Development' , 'Sales and Marketing')	
	)
--24) list all the details of employees who have joined on the same date as that of Ruth Ann Ellerbrock

   select * from HumanResources.Employee e 
   where e.HireDate=(
		select  e1.HireDate from HumanResources.Employee e1 
		join Person.Contact c
		on e1.ContactID=c.ContactID
		where c.FirstName='Ruth' and c.MiddleName='Ann' and c.LastName='Ellerbrock'
   )
 
--25) list details of employees where salary is greater than "Ruth Ann Ellerbrock" and who arre in sales department
		
		select * from HumanResources.Employee e1
		join HumanResources.EmployeePayHistory eph1
		on e1.EmployeeID=eph1.EmployeeID
		join HumanResources.EmployeeDepartmentHistory edh1
		on eph1.EmployeeID=edh1.EmployeeID
		where eph1.Rate>
		(
					select eph2.Rate from HumanResources.EmployeePayHistory eph2
					where eph2.EmployeeID=
					(
							select e2.EmployeeID from HumanResources.Employee e2
							where e2.ContactID=
							(
										select  distinct  c.ContactID from Person.Contact c
										where c.FirstName='Ruth' and c.MiddleName='Ann' and c.LastName='Ellerbrock'
							)
					)
	)
and edh1.DepartmentID=(select DepartmentID from HumanResources.Department where Name='Sales')
	
--26) list the details of employees who are getting maximum salary 
	

	select * from HumanResources.Employee e
	join HumanResources.EmployeePayHistory eph1
	on e.EmployeeID=eph1.EmployeeID
	where eph1.Rate >=
	(
			select MAX(eph2.Rate) from HumanResources.EmployeePayHistory eph2
	)

--27) list out all the employees who are reporting to Manager Jo A Brown

select * from HumanResources.Employee e1
where e1.ManagerID=
(
		select e2.EmployeeID from HumanResources.Employee e2
		join Person.Contact c 
		on e2.ContactID=c.ContactID
		where  c.FirstName='Jo' and  c.MiddleName='A' and c.LastName='Brown'
)

--28) list out all the employees from Department to which " Michael I Sullivan "  belonging 

		select * from HumanResources.Employee e1
		join HumanResources.EmployeeDepartmentHistory edh1
		on e1.EmployeeID=edh1.EmployeeID
		 where edh1.DepartmentID=
		(
				select edh2.DepartmentID from HumanResources.EmployeeDepartmentHistory edh2
				join HumanResources.Employee e2
				on edh2.EmployeeID=e2.EmployeeID
				join Person.Contact c1
				on e2.ContactID=c1.ContactID
				where c1.FirstName='Michael' and c1.MiddleName='I' and c1.LastName='Sullivan' 
		)

--29) list out the details of employees whos designation is same as that of " Gail A  Erickson"

select * from HumanResources.Employee e1
where e1.Title=(
		select e2.Title from HumanResources.Employee e2
		join Person.Contact c 
		on e2.ContactID=c.ContactID
		where c.FirstName='Gail' and c.MiddleName='A' and c.LastName='Erickson' 
)

--30) find the second highest salary of employee 139 ,98

select MAX(eph1.Rate)
from HumanResources.EmployeePayHistory eph1 
where eph1.Rate not in
(
		select MAX(eph2.Rate)
		from HumanResources.EmployeePayHistory eph2 
)

with temp as
(
		select eph1.Rate , ROW_NUMBER()  over( order by eph1.Rate desc) as [rnk] 
		from HumanResources.EmployeePayHistory eph1
)
select * from temp where rnk=2


select b.* from  
(
		select eph1.Rate , ROW_NUMBER()  over( order by eph1.Rate desc) as [rnk]  
		from HumanResources.EmployeePayHistory eph1
) b
where b.rnk=2

--31)  find out the name of department which is not allocated to Gail A Erickson

		select distinct d.Name from HumanResources.Department d
		join HumanResources.EmployeeDepartmentHistory edh1
		on d.DepartmentID=edh1.DepartmentID
		where edh1.DepartmentID not in
		(
				select edh2.DepartmentID from HumanResources.EmployeeDepartmentHistory edh2
				join HumanResources.Employee e1
				on edh2.EmployeeID=e1.EmployeeID
				join Person.Contact c
				on e1.ContactID=c.ContactID
				where c.FirstName='Gail' and c.MiddleName='A' and c.LastName='Erickson'
		) order by d.Name

--32) find out the second lowest salary of dept=10

	with temp as
	(
			select eph2.Rate, ROW_NUMBER() over(order by eph2.Rate asc) as 'rnk'
			 from HumanResources.EmployeePayHistory eph2
			join HumanResources.EmployeeDepartmentHistory edh1
			on eph2.EmployeeID=edh1.EmployeeID
			where edh1.DepartmentID=10
	)
	select * from temp where rnk=2

--33) find out the second highest salary of dept=10

with temp as
	(
			select eph2.Rate, ROW_NUMBER() over(order by eph2.Rate desc) as 'rnk'
			 from HumanResources.EmployeePayHistory eph2
			join HumanResources.EmployeeDepartmentHistory edh1
			on eph2.EmployeeID=edh1.EmployeeID
			where edh1.DepartmentID=10
	)
	select * from temp where rnk=2

--34) list empName , DeptNo, Avg Salary of their respective department

select a.* , b.EmployeeID,b.ContactID,b.FirstName from 
(
		select edh.DepartmentID,  AVG(eph.Rate) as'AvgSalary' 
		from HumanResources.EmployeePayHistory eph
		join  HumanResources.EmployeeDepartmentHistory edh
		on eph.EmployeeID = edh.EmployeeID
		group by edh.DepartmentID
) a
join
(
		select e.EmployeeID , e.ContactID, c.FirstName , edh.DepartmentID  from HumanResources.Employee e
		join Person.Contact c
		on e.ContactID=c.ContactID
		join HumanResources.EmployeeDepartmentHistory edh
		on e.EmployeeID=edh.EmployeeID
) b
on a.DepartmentID=b.DepartmentID
order by a.DepartmentID

--35) find out employees who earn highet salary in each job type sort by descending salary

	with temp as
	(
			select   max(eph1.Rate) as 'MaxSalary' , e1.Title from HumanResources.EmployeePayHistory eph1
			join HumanResources.Employee e1
			on e1.EmployeeID=eph1.EmployeeID
			group by e1.Title
	)
	select * from temp order by MaxSalary desc

--36) display the employee names who are the managers 
			
			select e1.EmployeeID as 'ManagerID', c.FirstName+SPACE(2)+ c.LastName as 'Name' 
			from Person.Contact c
			join HumanResources.Employee e1
			on e1.ContactID=c.ContactID
			where e1.EmployeeID in
			(
				select distinct  e2.ManagerID  from HumanResources.Employee e2
			)

--37)  Find the employees who joined after 15-March-2000

		
		select HireDate from HumanResources.Employee where HireDate > '2000-03-15'

--38) Display Manager and number of employees working under him
		
		    select ManagerID,COUNT(*) as 'No Emp Working' from HumanResources.Employee 
			group by ManagerID

			 select e1.ManagerID,COUNT(*) as 'No Emp Working' 
			 from HumanResources.Employee e1, HumanResources.Employee  e2
			 where e2.EmployeeID=e1.ManagerID
			group by e1.ManagerID

--39) display all the employee with out any manager

		select * from HumanResources.Employee where ManagerID is null

--40) display employess who are not managers 
		
			 select e1.* from HumanResources.Employee e1
			 where e1.EmployeeID not in
			  (
					select e2.EmployeeID from HumanResources.Employee e2
					where e2.EmployeeID in
					(
							select distinct e3.ManagerID from HumanResources.Employee e3
					)
			  )

--41) select employess who are managers 

					select e2.* from HumanResources.Employee e2
					where e2.EmployeeID in
					(
							select distinct e3.ManagerID from HumanResources.Employee e3
					)

--42) select common jobs from depart no 3 and 4
	use AdventureWorks
	select  distinct e1.Title from HumanResources.Employee e1
	join HumanResources.EmployeeDepartmentHistory edh1
	on e1.EmployeeID=edh1.EmployeeID
	where edh1.DepartmentID in (3,4)

	--43) display the namagers name who manages the maximum numbers of employees
	
--using >=ALL
		select c1.FirstName from Person.Contact c1
		join HumanResources.Employee e1
		on c1.ContactID=e1.ContactID
		where e1.EmployeeID in
		 (
					select e2.ManagerID from HumanResources.Employee e2
					group by e2.ManagerID having count(*)>=ALL
					(
							select COUNT(*) from HumanResources.Employee E3 group by E3.ManagerID
					)
		)

--using max
		select * from Person.Contact c
		join HumanResources.Employee e1
		on c.ContactID=e1.ContactID
		where e1.EmployeeID=(
				select ManagerID from HumanResources.Employee
				 group by ManagerID having count(EmployeeID) =
				(
					select max(tempTable.countEMP) from 
					(
					select count(EmployeeID)  as 'countEMP'
					from HumanResources.Employee group by ManagerID
					) as tempTable
				) 
		)

--using row_number
		select * from Person.Contact c
		join HumanResources.Employee e1
		on c.ContactID=e1.ContactID
		where e1.EmployeeID=(
				select TempTable.ManagerID from 
				(
					select e2.ManagerID,count(*) as CountEMP , ROW_NUMBER() over( order by count(*) DESC ) as Rnk 
					from HumanResources.Employee e2  group by e2.ManagerID 
				) as TempTable
				where TempTable.Rnk=1
		)

--44) Display Employee Names whos manager is Peter

		select c1.FirstName 'Emp Name'   from Person.Contact c1
		join HumanResources.Employee e1
		on c1.ContactID=e1.ContactID
		where e1.ManagerID in(
			select e2.EmployeeID from HumanResources.Employee e2 
			join Person.Contact c2 
			on c2.ContactID=e2.ContactID where c2.FirstName='Peter'
		)

--45) Display the Employee who is working in the same department where his manager is working

SELECT a.EmployeeID,
b.EmployeeID ManagerId,
c.DepartmentID EmployeeDepartment,
d.DepartmentID ManagerDepartment
FROM HumanResources.Employee a
join 
HumanResources.Employee b
ON a.ManagerID=b.EmployeeID
JOIN HumanResources.EmployeeDepartmentHistory c
on a.EmployeeID=c.EmployeeID
join HumanResources.EmployeeDepartmentHistory d
on b.EmployeeID=d.EmployeeID
where c.DepartmentID=d.DepartmentID

		
		select distinct MgrTable.ManagerID , EmpTbl.EmployeeID , MgrTable.DepartmentID , EmpTbl.DepartmentID from 
		(
		(
			select e1.EmployeeID , e1.ManagerID , edh1.DepartmentID  from HumanResources.Employee e1
			join HumanResources.EmployeeDepartmentHistory edh1
			on e1.EmployeeID=edh1.EmployeeID 
		) as EmpTbl
		join
		(
		select  e2.EmployeeID , e2.ManagerID , edh2.DepartmentID from HumanResources.Employee e2
		join HumanResources.EmployeeDepartmentHistory edh2
		on e2.EmployeeID=edh2.EmployeeID
		where e2.EmployeeID IN
				(
					select e3.ManagerID from HumanResources.Employee e3
				)
		) as MgrTable
		on EmpTbl.ManagerID=MgrTable.ManagerID
		) 
		where MgrTable.DepartmentID=EmpTbl.DepartmentID
		and MgrTable.EmployeeID=EmpTbl.EmployeeID
		and EmpTbl.ManagerID=MgrTable.ManagerID
		order by MgrTable.ManagerID asc


--manager and the Department he is in
select  e1.EmployeeID as'MgrID' , edh1.DepartmentID  from HumanResources.Employee e1
join HumanResources.EmployeeDepartmentHistory edh1
on e1.EmployeeID=edh1.EmployeeID
where e1.EmployeeID in(
select e2.ManagerID from HumanResources.Employee e2
)
order by MgrID asc


--manager handeling number of department
select edh1.EmployeeID as 'MgrID' , COUNT(edh1.DepartmentID) as 'NoOfDeptHandling'from HumanResources.EmployeeDepartmentHistory edh1
where edh1.EmployeeID in (
	select e1.ManagerID from HumanResources.Employee e1
)
group by edh1.EmployeeID
order by edh1.EmployeeID asc

--46) display the employee whos salary is greater than  his manager
select * from 
(
select ephemp.EmployeeID as 'EMPID' , e1.ManagerID as'mgrid', ephemp.Rate from HumanResources.EmployeePayHistory ephemp
join HumanResources.Employee e1
on e1.EmployeeID=ephemp.EmployeeID
) as tempEmp
join
(
select ephmgr.EmployeeID as 'MGRID', ephmgr.Rate from HumanResources.EmployeePayHistory ephmgr
where ephmgr.EmployeeID in (
select distinct mgr.ManagerID from HumanResources.Employee mgr
)
) as TempMgr
on  tempEmp.mgrid=TempMgr.MGRID
where tempEmp.Rate >TempMgr.Rate

--47) Display department wise max salary
				
				select edh1.DepartmentID , max(eph1.Rate) as 'MaxSalary', min(eph1.Rate) as 'MinSalary' from HumanResources.EmployeePayHistory eph1
				join HumanResources.EmployeeDepartmentHistory edh1 
				on eph1.EmployeeID=edh1.EmployeeID
				group by edh1.DepartmentID
				order by MaxSalary desc 

--48) display the 1st  and 2nd highest salary from each dept
				
				with Temp_Table as
				(
				select edh1.DepartmentID , eph1.Rate  , dense_rank() over(  partition by edh1.DepartmentID order by eph1.Rate Desc  )   as 'rnk'
				from HumanResources.EmployeePayHistory eph1
				join HumanResources.EmployeeDepartmentHistory edh1
				on eph1.EmployeeID=edh1.EmployeeID
				)select * from Temp_Table where rnk in ( 1,2)

--49) Find the Department which is not allocated 
			
			select * from HumanResources.Department
			where DepartmentID not in(
				select DepartmentID from HumanResources.EmployeeDepartmentHistory 
			)

--50)Display the details of all employees whose salary is greater than average salary of employees 
           --in respective department
					
					select Temp1.DepartmentID , Temp1.AvgSal , Temp2.EmpSal , Temp2.EmployeeID from
					(
						select edh1.DepartmentID , AVG(eph1.Rate)  as 'AvgSal'
						from HumanResources.EmployeePayHistory eph1
						join HumanResources.EmployeeDepartmentHistory edh1
						on eph1.EmployeeID=edh1.EmployeeID
						group by edh1.DepartmentID
					) as Temp1
					join
					( 
						 select edh1.DepartmentID , eph1.Rate as 'EmpSal' , edh1.EmployeeID
						  from HumanResources.EmployeePayHistory eph1
						join HumanResources.EmployeeDepartmentHistory edh1
						on eph1.EmployeeID=edh1.EmployeeID
					) as Temp2
					on Temp1.DepartmentID=Temp2.DepartmentID
					where Temp2.EmpSal >=Temp1.AvgSal
					order by Temp1.DepartmentID

--51) display all the details of employees where salary >= lowest salary of employees in deptno 10
			use AdvenTureworks
			
			select * from HumanResources.Employee e
			join HumanResources.EmployeePayHistory eph1
			on e.EmployeeID=eph1.EmployeeID
			where eph1.Rate>=
			(select min(eph.Rate) from HumanResources.EmployeePayHistory eph
			join HumanResources.EmployeeDepartmentHistory edh
			on eph.EmployeeID=edh.EmployeeID
			where edh.DepartmentID=10)


--52) find the job which is not allocated any one in 
			
			select * from HumanResources.Employee		
			select Title from HumanResources.Employee		

			


--53) find the nth maximum salary








 










