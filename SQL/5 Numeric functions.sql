-- numeric functions , dates 

use world;

select lifeexpectancy, round(lifeexpectancy) from country; 

select 83.62, round(83.687,2);

select 456.23 , round(476.23,-2);

-- mod is use to find the remainder after division 
select 456.67, round(456.68,1),truncate(456.67,1),mod(43.6,3);


-- pow => calculate power
-- ceil => upper conversion
-- floor => lower conversion 
select pow(2,3),ceil(3.00008),floor(3.999999);

-- date 
-- inbuilt date or time print krna

select now(),curdate(),current_timestamp(),current_time(),current_date(); 

-- add date

select now(),adddate(now(),2),adddate(now(),interval 3 month);

-- subtract date  
select now(), subdate(now(),2); 

select now(), extract(week from now());

select now(),date_format(now(),'Month is %m & year is %y' );

select distinct continent from country;

select count(continent),count(distinct(continent)) from country;
