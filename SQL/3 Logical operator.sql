use world;
-- operator in sql
-- and , or 
-- and => condi1 and condi2   
-- or  => condi1 or condi2 

select name ,continent from country where continent='Asia' or continent ='Africa'; 
 
select name ,continent,region from country where continent="Africa" or region="Middle east";
 
select name ,continent from country;
 
select * from country;

select name , code, concat(name," ",code)from country; 