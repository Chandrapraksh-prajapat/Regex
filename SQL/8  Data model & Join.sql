use world;

select * from city;
-- city (id => primary key), countrycode is the foreign key 
describe city;
select * from country;
-- code => primary key 
select count(code),count(distinct code) from country;


select* from city;

select ct.id,ct.name,ct.countrycode,
cnt.code,cnt.name,cnt.continent
from city as ct
join country as cnt
where ct.countrycode=cnt.code;

-- Q. find the city name , population , the country name 
-- along with a govt form for each city 

select * from city;

select ct.name,ct.population,cnt.name,cnt.governmentform 
from city as ct
join country as cnt
where ct.countrycode=cnt.code;   

select * from country;
select * from countrylanguage;
-- Q. get the country name , population and
--  the lang spoke with the % of each language.

select cnt.name, cnt.population,cntl.language,cntl.percentage
from country as cnt
join countrylanguage as cntl
where cnt.Code=cntl.countrycode;

