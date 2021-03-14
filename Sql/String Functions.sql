SELECT ASCII('Q') AS 'Result'										--81

SELECT ASCII('Quest') AS 'Result'									--81

SELECT CHAR(65) AS 'Result'										--A

SELECT CHAR(97) AS 'Result'										--a

SELECT CHAR(123) AS 'Result'										--{

SELECT CHARINDEX('t','Quest') AS 'Result'								--5

SELECT CHARINDEX('Q','Quqest') AS 'Result'								--1

SELECT CHARINDEX('Q','Quqest',4) AS 'Result'								--0

SELECT CHARINDEX('Q','Quqest',2) AS 'Result'								--3

SELECT CONCAT('India','-','Bangalore') AS 'Result'							--India-Bangalore

SELECT CONCAT('India','-','Bangalore') AS 'Result'

SELECT CONCAT(',', 'Bangalore','Chennai') AS 'Result'							--,BangaloreChennai

SELECT DIFFERENCE(SOUNDEX('Ram'),SOUNDEX('Shyam'))							--3

print SOUNDEX('Quest')

SELECT FORMAT(GETDATE(),'yyyy-dd-MM') AS 'Result'							--2021-10-03

SELECT FORMAT(GETDATE(),'yyyy-dd-MMM') AS 'Result'							--2021-10-Mar

SELECT FORMAT(GETDATE(),'yyyy-dd-MMMM') AS 'Result'							--2021-10-March

SELECT FORMAT(500,'C') AS 'Result'									--$500.00

SELECT FORMAT(500,'c') AS 'Result'									--$500.00

SELECT LEFT('Quest',2) AS 'Result'									--Qu

SELECT RIGHT('Quest',2) AS 'Result'									--st

SELECT LEN('Quest') AS 'Result'										--5

SELECT LOWER('Quest') AS 'Result'									--quest

SELECT UPPER('Quest') AS 'Result'									--QUEST

SELECT LTRIM('      Quest') AS 'Result'									--Quest

SELECT RTRIM('Quest     ') AS 'Result'									--Quest

SELECT NCHAR(65) AS 'Result'										--A

SELECT PATINDEX('%st%','Quest') AS 'Result'								--4

SELECT  PATINDEX('%en_ure%', 'Please ensure the door is locked!') AS 'Result'--8

SELECT QUOTENAME('Employee') AS 'Result'								--[Employee]

SELECT REPLACE('Employee','E','X') AS 'Result'								--XmployXX

SELECT REPLACE('968961111','1','X') AS 'Result'								--96896XXXX

SELECT REPLICATE('Q',3) AS 'Result'									--QQQ

SELECT REPLICATE('Quest',3) AS 'Result'									--QuestQuestQuest

SELECT REVERSE('Quest') AS 'Result'									--tseuQ

SELECT STR(12.36) AS 'Result'										--12

SELECT STR(12.31,6,2) AS 'Result'									--12.31

SELECT SUBSTRING('Quest Informatics',6,3) AS 'Result'							--In

SELECT SUBSTRING('Quest Informatics',7,4) AS 'Result'							--Info

SELECT STUFF('ABCDEFGH',0,0,'-XYZ-') AS 'Result'							--NULL

SELECT STUFF('ABCDEFGH',1,0,'-XYZ-') AS 'Result'							---XYZ-ABCDEFGH

SELECT STUFF('ABCDEFGH',1,4,'-XYZ-') AS 'Result'							---XYZ-EFGH

SELECT STUFF('ABCDEFGH',8,0,'-XYZ-') AS 'Result'							--ABCDEFG-XYZ-H

SELECT STUFF('ABCDEFGH',8,1,'-XYZ-') AS 'Result'							--ABCDEFG-XYZ-

SELECT STUFF('ABCDEFGH',9,0,'-XYZ-') AS 'Result'							--NULL

--SELECT STRING_SPLIT('D:\MR_files\Mphasis_MLA .NET', ' ') AS 'Result'

--SELECT STRING_AGG('Quest',',') AS 'Result'
