select database();

-- change to world database 
use world;

-- to print current database 
select database(); 

-- to see tables 
show tables;

-- to see the structure of table
describe city;

-- to print data of a table  
select * from city;

-- to access specific column 
select name,countrycode from city;

-- columns can be print in any order
select population , name ,district from city;

-- you can apply any mathematical operation on column 
select name , population , population+10 from city;

-- query can be written in multiple lines 
-- SQL is not case-sensitive
SELECT name , population ,district,
countrycode,population
FROM city;

-- alias (nickname) 
select * ,population,population+10+12+2 as NEWpopulation from country;


-- what is database
-- what is file system and how it is different from DBMS
-- type of DBMS
-- DBMS vs RDBMS
-- where clause
