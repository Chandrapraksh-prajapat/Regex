show databases;
use world;
show tables;

select * from city;
select name, id from city;

-- using where clause we will filter the data 

select name , countrycode, id from city where id='4';

select * from city where district='Zuid-Holland';

-- != ,  <>  not equals to 
select * from city where countrycode !="ARG"; 

select * from city where population>600000; 

select * from country where continent="Europe"; 

-- in operator is use to filter the data in  specific set of values  
select * from country where continent in ('North America','Europe', 'Asia');

-- filter indepyear 
select name, continent,indepyear from country where indepyear in (1901, 1960);

select name, continent,indepyear from country where indepyear not in (1901, 1960);

-- between operator is use to filter the data in a given range 
select name, continent, indepyear from country where indepyear between 1901 and 1960;

select name, continent, indepyear from country where indepyear not between 1901 and 1960;



-- Q1. get the code, name and the region where the region is not middle east
-- Q2. name, indepyear and population along with the 10% expected population 
-- Q3. get all the columns of country where life expentcy is 38.3 or 66.4
-- Q4. get name ,continet, population, gnp where the population is not from 5000 to 200000 

select code, name ,region from country where region !='Middle east';
select name ,indepyear, population, population*1.1 from country;
select  name ,LifeExpectancy from country where LifeExpectancy between 38.3 and 66.4;
select name, continent, population ,gnp from country where population not between 5000 and 200000;


-- like operator 
-- find pattern
-- special character is called (wildcard character)
--  % zero or more characters 
select name, continent from country;

select name, continent from country where name like 'A%';
select name, continent from country where name like 'da%';
select name, continent from country where name like '%A%';
select name, continent from country where name like '%Ad%';

-- (_)underscore => one character

 -- Q1. name , continent and region where the continent same as Europe.
 -- Q2. get the country name , where the second letter of a region is 'a' 
 -- Q3. where the continent the last third charcter is 'i' 
 -- Q4. where the continent should be of minimum 5 characters
 -- Q5. where in the continet the second letter is 'c' and last second is 'i'
 -- Q6. where 2a should be there seprated with a charcter   
 
 use world;
 
 select name ,continent,region from country where continent='Europe';
 
select name ,continent,region from country where region like'_A%';
 
select name ,continent,region from country where continent like'%i__';
 
select name ,continent,region from country where continent like'_____%';
 
select name ,continent,region from country where continent like'_c%i_';
  
select name ,continent,region from country where name like'%a_a%';


