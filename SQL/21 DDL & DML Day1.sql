-- DDl  (data definition Language) ==>use for structure change 
-- create  (table)
--  drop . truncate , alter 

 create table test13(col int);
 
 -- create a table using select (CTAS) 
 create table actor_cp as 
 select first_name, last_name from sakila.actor;
 
 select * from actor_cp;
 
 -- delete a table  and data 
 drop table actor_cp;
 
 create table actor_cp as 
 select first_name as fname , last_name as last from sakila.actor
 where actor_id between 10 and 14;
 
 select * from actor_cp;
 
 -- Alter 
 
 alter table actor_cp add column (salary int);
 alter table actor_cp add constraint new_key primary key(fname); --  primary key added 
 alter table actor_cp drop column last;
 desc actor_cp;
 
 -- Rename columnn  
 alter table actor_cp rename column salary to newsalary;
desc actor_cp;

select * from actor_cp;

-- DML statements   => change in data 
-- insert 
-- update 

set sql_safe_updates=0;
update actor_cp set newsalary=900; 

 update actor_cp set newsalary=888 where fname='uma';
select * from actor_cp;

