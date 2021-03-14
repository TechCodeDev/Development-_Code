SELECT GETDATE() AS 'Resut'
DECLARE @Today DATETIME = GETDATE();								--2021-03-10 00:07:19.273
PRINT @Today

SELECT CURRENT_TIMESTAMP  AS 'Resut'								--2021-03-10 00:07:43.540

SELECT DATEFROMPARTS(2020,01,30) AS 'Resut'							--2020-01-30

SELECT DATETIMEFROMPARTS(2020,01,30,11,10,15,0) AS 'Resut'					--2020-01-30 11:10:15.000

SELECT DATETIME2FROMPARTS(2020,01,30,11,10,15,0,0) AS 'Resut'   				--2020-01-30 11:10:15

SELECT TIMEFROMPARTS(14,15,30,0,0)  AS 'Resut'                 					--14:15:30

SELECT DATENAME(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT DATENAME(MONTH,GETDATE()) AS 'Resut'							--March

SELECT DATENAME(DAY,GETDATE()) AS 'Resut'							--10

SELECT DATENAME(QUARTER,GETDATE()) AS 'Resut'							--1

SELECT DATENAME(DAYOFYEAR,GETDATE()) AS 'Resut'							--69

SELECT DATENAME(WEEK,GETDATE()) AS 'Resut'							--11

SELECT DATENAME(WEEKDAY,GETDATE()) AS 'Resut'							--Wednesday

SELECT DATENAME(HOUR,GETDATE()) AS 'Resut'                      				--21

SELECT DATENAME(MINUTE,GETDATE()) AS 'Resut'							--56
												
SELECT DATENAME(SECOND,GETDATE()) AS 'Resut'							--41varies

SELECT DATEPART(SECOND,GETDATE()) AS 'Resut'							--41varies

SELECT DATEPART(MONTH,GETDATE()) AS 'Resut'							--3

SELECT DATEPART(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT DATEPART(YEAR,GETDATE()) AS 'Resut'							--2021

SELECT YEAR(GETDATE()) AS 'Resut'								--2021

SELECT MONTH(GETDATE()) AS 'Resut'								--3

SELECT DAY(GETDATE()) AS 'Resut'								--10

SELECT EOMONTH(GETDATE()) AS 'Resut'								--Every end of Month based upon the month

SELECT ISDATE('2020/01/30') AS 'Resut'								--return 1 because jan 30th day

SELECT ISDATE('2020/02/30') AS 'Resut'								--return 0 because Feb 30th day

SELECT ISDATE(NULL) AS 'Resut'

SELECT DATEADD(YEAR,1,GETDATE()) AS 'Resut'							--2022-03-10 22:27:08.640

SELECT DATEADD(YEAR,10,GETDATE()) AS 'Resut'							--2031-03-10 22:30:00.683

SELECT DATEADD(MONTH,6,GETDATE()) AS 'Resut'							--2021-09-10 22:33:50.450

SELECT DATEADD(DAY,10,GETDATE()) AS 'Resut'							--2021-03-20 22:34:45.660

SELECT DATEADD(DAY,-10,GETDATE()) AS 'Resut'							--2021-02-28 22:34:58.823

SELECT DATEDIFF(YEAR,'2000-01-30',GETDATE()) AS 'Resut'						--21

SELECT DATEDIFF(YEAR,'2019-12-30',GETDATE()) AS 'Resut'						--2

SELECT DATEDIFF(MONTH,'2019-11-30',GETDATE()) AS 'Resut'					--16

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE MONTH(E.BirthDate)=2

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE MONTH(E.BirthDate)=1  AND  DAY(E.BirthDate)=29 

SELECT E.BusinessEntityID , 
	   E.BirthDate 
	   FROM HumanResources.Employee E
	   WHERE DATEDIFF(YEAR,E.BirthDate,GETDATE()) > 60

SELECT E.BusinessEntityID , 
	   E.BirthDate FROM HumanResources.Employee E
	   WHERE DATEDIFF(YEAR,E.BirthDate,GETDATE()) < 30
