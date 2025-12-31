-- functions (date, string , number)

-- Aggregate functions ==> to perform the calculation on multiple rows 

-- commmon aggregate function

-- count()
use world;

select *from country; 
select count(*) from country;

select count(*),count(indepyear) from country;

select distinct continent,region from country; 

select count(population),sum(population),avg(population)from country;

select count(distinct governmentform)from country;

select count(governmentform),count(distinct governmentform),sum(governmentform) 
from country where continent='Asia';

select sum(population),Continent from country where continent='Africa';

select count(Name),sum(Population),count(distinct IndepYear)
 from country where continent='Africa';


-- Q. get the total countries, the average surfacearea and the total population
--  for the countries which has got their independence from year 1947 to 1998.

select count(Name),avg(surfaceArea),sum(Population) 
from country where indepyear > 1947 and indepyear< 1998;  


-- Q. get the total number of countries and the number of unique continents 
-- along with the avergae population and the total number of capitals 
-- for the countries starting with 'a' or 'd'

select * from country;
select count(name), count(distinct continent), avg(population) , sum(capital) 
from country where name like'A%' or name like 'D%';

select count(name)from country where continent='Africa'; 
select count(name)from country where continent='Asia'; 
select count(name)from country where continent='Europe';

select Continent,count(*) from country group by Continent;

select indepyear,count(*) from country group by indepyear;

select governmentform, count(*) from country group by governmentform; 

select continent, count( name), sum(population), avg(population),
max(population), min(population), max(indepyear), min(indepyear)
from country group by continent;

select * from city;
-- Q.  from the city table you have to find , total district , unique district, 
--  	total population 

select countrycode, count(*), count(district),count(distinct district) , 
sum(population) from city group by countrycode ; 