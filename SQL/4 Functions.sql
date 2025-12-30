-- select ==>data retrive/access
-- query => multiple line and not case-sensitive 
-- where(filter) and or between in like  
-- between , in , like (%,_) 

 -- functions
 /*
 set of statement
 fucntions
 
 code reusable
 
 scaler function ==> row by row (result for each row)
 Multi line function => multiple line ->apply and give 1 output
 
 scaler can apply: date,int, float,string
 
 */
 
-- string functions 

-- case conversion

use world;

select name,continent, upper(name), lower(name) from country;

-- 1.concat( important function)

select name,continent, concat(continent,"-",code ) from country;

select name,continent, concat_ws("-",continent,code,"regex" ) from country;

-- 2.substring(substr.)==> character extract based on the position(important fucntion)

select name, substr(name,1) from country;
select name, substr(name,2) from country;
select name, substr(name,3) from country;

select name, substr(name,1,3) from country;

-- 2 se start krke total 5 character tk
-- agar charcter kam h to jitne available h utne print honge 

select name, substr(name,1,4),substr(name,2,5) from country;

-- reverse side se bhi print ho skta h 
-- agar position nhi h to empty string   
-- select name, substr(name,1,4),substr(name,-4,1) from country;

select name, continent from country
where substr(name,1,1)=substr(continent,1,1);

-- print country name which statring character is "alg" 
select name,continent from country
where substr(name,1,3)="alg";

-- like operator se 
select name,continent from country
where name like "Alg%";


-- 3.instr ==> search position of character

select name , instr(name,"e") from country; 


-- 4.length() ===> kitna byte use hua 
-- total character find krne ke liye char_length function use krte h  
select char_length("yash");

select name, char_length(name)from country;

-- 5. trim=> extra whitespaces ya character ko remove krna 
-- ltrim(left se remove krta h ),
-- rtrim(right se remove krta h )

select '     yash.   ';
select char_length('     yash.    ');
select trim('     yash.   ');
select char_length(trim('     yash.    '));
select ltrim('     yashggggg');
select rtrim('     yashggggg       ');

-- character remove krne ke liye   
select trim(both'g'from '     yashgggg');  
select name,trim(both'a'from name)from country ;  
select name,trim(both'A'from name)from country ;  


-- 6. lapd and rpad  
select name , population , lpad(population, 9,'0') from country ; 

select name , population , rpad(population, 9,'*') from country ; 








