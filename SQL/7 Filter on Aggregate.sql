show databases;
use world;
show tables;

select * from city;
select region, count(name) from  country group by region;

select region , avg(population) from country group by region;

--  count city which have population of more than 1 lakh 
--  where sbse phle execute ==> group by ==> count()

select district, count(name) as TotalCity from city group by district;

select district, count(name) from city where population>100000 group by district;


-- get total countries which got independence after 1950 in each continent  
select continent, count(name) from country where indepyear>1950 group by continent;

-- having to filter bdata based on aggregate column like sum, count, max 

select continent ,sum(population) from country group by continent
having sum(population)>30401150;

-- lifeexpectancy > 35.0%
 
select continent,sum(Population) from country
where lifeexpectancy>35.0 group by continent;  

-- Q. find out the total countries for each governmentform 
-- where the total number of countries >30

select GovernmentForm,count(name)from country
group by GovernmentForm having count(name)>30;
 
-- Q. find out the total countries for each governmentform 
-- only for the countries having their capital >30 and total population>3 lakh 

select GovernmentForm,count(name),sum(population) from country
where capital>30 group by GovernmentForm having sum(population)>300000;

select * from country;

select continent,region,indepyear, count(name) from country group by continent,region,indepyear; 
