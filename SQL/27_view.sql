-- view: view is the virtual table
--  	do not store data physicall but will access the data from the existing table  

		-- make complex query into simpler 
		-- help in security
        
use regex;

create table newactor as 
select actor_id,first_name from sakila.actor where actor_id between 1 and 3;

select * from newactor;

create view actor_v as 
select *,substr(first_name,2)from newactor;

select * from actor_v;
select first_name from actor_v;


select * from newactor; --  3rows, 2 columns
insert into newactor values(4,'riya'); --  4row table
select * from newactor;

select * from actor_v;

-- SIMPLE VIEW => any DML change will be visible on original table where view is created
--  view is not updated when there is  => aggregration , group , having distinct ,union , subquery 

create view actor_v2 as 
select * from newactor where actor_id in(1,2);

select * from newactor;
insert into newactor values(5,'sakshi');

select * from actor_v2;

-- insert into view 
insert into actor_v2 values(6,'newdata of view'); 
select * from actor_v2;
select * from newactor;



create table newpayment as 
select payment_id,amount from sakila.payment where payment_id between 1 and 7;

select * from newpayment;


create view payment_v as 
select count(*) from newpayment;

select * from payment_v;
insert into payment_v values(10);  --  Error 







-- DDL
-- DML
-- TCL 
-- DQL

-- DCL :
--  	permission which user can accessbility
--      Authentication: identify the user  
--      Authorization : what action user can perform

--  user => create > permission 

create user regex identified by 'regex';

select * from mysql.user;

create database tushardb;

create table tushardb.actor as select actor_id,first_name from sakila.actor where actor_id between 1 and 5;

create table tushardb.actor2 as select actor_id,first_name from sakila.actor where actor_id between 3 and 7;

show grants for regex;

grant select on tushardb.actor2 to regex; -- grant permission on database to username

grant select on tushardb.* to regex; -- grant all permission on database to username 

grant all privileges on tushardb.actor to regex;



-- give the privileges to two column
-- privileges are permissions that control what a user is allowed to do in a database.
-- 								CREATE VIEW table_view AS
-- 								SELECT column1, column2
-- 								FROM table_name;

-- 								GRANT SELECT ON table_view TO user_name;

-- select, delete permisssion
-- 							GRANT SELECT, DELETE
-- 							ON table_name
-- 							TO user_name;


-- try to revoke those privileges
							-- REVOKE SELECT, DELETE
							-- ON table_name
							-- FROM user_name;


-- what is role ? 

-- In SQL, a role is a named group of privileges that you can assign to users.
-- Instead of giving permissions one by one to each person, you give them a role.




