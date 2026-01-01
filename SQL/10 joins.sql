use world;

-- 2table => data extract (join)
select * from city;
describe city;
-- id=> primary key

select count(id), count(distinct id), count(population),
count(distinct population) from city;


select * from country;
-- code=> primary key

-- find city and their respective country name  
select ct.name,ct.CountryCode, cnt.code,cnt.name from city as ct 
join country as cnt
where ct.CountryCode=cnt.code;


-- name, popualtion of city along with the govt, form  with the population 
-- from highest to lowest 

select ct.name,ct.Population, cnt.GovernmentForm from city as ct 
join country as cnt
where ct.CountryCode=cnt.code order by ct.Population desc;

-- country
-- countrylanguage 
describe country;
describe countrylanguage;

-- Q. country name , country population and language for each country 
 
select cnt.name , cnt.population,cntl.language,cntl.CountryCode  from country as cnt
join countrylanguage as cntl
where cnt.code=cntl.countrycode;


use sakila;
select * from actor;
select * from film_actor;
describe actor;
describe film_actor;
-- find out actor id , first name along with its film id 

select act.actor_id, act.first_name,flm.film_id from actor as act
join film_actor as flm
where act.actor_id=flm.actor_id;


-- actor ,film_actor, film   
select * from actor;
select * from film_actor;
select * from film;
describe actor;  -- actor => pk
describe film_actor; -- act_id, film_id => pk 
describe film; -- film_id =>pk 

-- Q. get actor name along with the movie name 

select act.first_name,act.last_name,f.title from actor as act
join film_actor as fac on act.actor_id=fac.actor_id 
join film as f on fac.film_id=f.film_id;