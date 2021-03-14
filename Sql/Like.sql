SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'kim'              					--NAME LIKE kim

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'kIM'              					--NAME LIKE kim

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '%K'               					--NAME ENDS WITH K

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE 'K%'				  			--NAME STARTS WITH K


SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '%KK%'             					--GROUPED KK WITH IN STRING

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]%'			  				--STARTS WITH GROUPED A TO D 

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]___'	                  		        --STARTS WITH GROUPED A TO D WITH TWO LETTERS ONLY

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '___[A-D]'         					--ENDS WITH GROUPED A TO D ALONG WITH TWO LETTERS ONLY

SELECT P.FirstName FROM Person.Person P
WHERE P.FirstName LIKE '[A-D]___[X-Z]'    					--STARTING WITH A TO D ALONG AND END WITH X AND Z WITH TWO LETTERS ONLY

SELECT * FROM Person.PersonPhone
WHERE PhoneNumber LIKE '[987]%'          					--STARTING WITH 987 

SELECT P.FirstName FROM Person.Person P
WHERE SOUNDEX(P.FirstName) = SOUNDEX('Mary') 

SELECT P.FirstName FROM Person.Person P
WHERE SOUNDEX(P.FirstName) = SOUNDEX('Reena') 
