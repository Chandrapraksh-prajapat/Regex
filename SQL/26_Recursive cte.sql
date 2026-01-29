
-- Recursive cte

-- set operators are use to combine two or more quries

-- union (combine) => duplicate value once
-- union all => can be duplicate value\
  
select actor_id,first_name from sakila.actor where actor_id between 1 and 4
union 
select actor_id,first_name from sakila.actor where actor_id between 3 and 5;


select actor_id,first_name from sakila.actor where actor_id between 1 and 4
union all
select actor_id,first_name from sakila.actor where actor_id between 3 and 5;


with recursive CTE as(
select 10  as num     -- assigning values to this num column (starting point ) 
union all
select num+1 from cte   --  call cte 
where num<15)  -- terminating condition(stop point)

select * from cte;



CREATE TABLE employees (
    employeeid INT PRIMARY KEY,
    name VARCHAR(50),
    managerid INT
);


INSERT INTO employees (employeeid, name, managerid) VALUES
(1, 'Alice', NULL),      -- CEO
(2, 'Bob', 1),           -- Reports to Alice
(3, 'Charlie', 2),       -- Reports to Bob
(4, 'Diana', 2),         -- Reports to Bob
(5, 'Eve', 3);           -- Reports to Charlie

select * from employees;

-- Q. find out the employee hierarchy

with recursive cte as(
select employeeid,name, name as hierarchy_path from employees 
	where managerid is null
union all
	select e.employeeid, e.name, concat(e.name,'->',cte.hierarchy_path)
		from employees as e 
			join cte where e.managerid=cte.employeeid and e.employeeid<5) 

select * from cte;

with recursive cte as(
select employeeid,name, 1 as level from employees 
	where managerid is null
union all
	select e.employeeid, e.name, level+1
		from employees as e 
			join cte where e.managerid=cte.employeeid and e.employeeid<5) 

select * from cte;




 
-- Learning assignment :

-- Q. What are view in SQL

-- A VIEW is a virtual table that stores a SQL query and 
-- 		provides abstraction, security, and simplicity.
-- Stores query, not data
-- A VIEW is a virtual table created using a SELECT query.
--   physical table => Virtual table => Query 
--    its like a abstraction layeer between user and real table 

-- Types of VIEWS (Interview Important)
-- 1️.Simple VIEW => Single table
-- 					No aggregation
-- 					Updatable

-- 2️.Complex VIEW => Multiple tables
-- 					 JOIN, GROUP BY
-- 					 Not updatable

-- 3️.Materialized VIEW => Stores data physically
-- 							Faster performance
-- 							Needs refresh


-- Q. Materialized vs Non-Materialized view(Imp for data science )

-- A Materialized View is a database object that stores the 
-- result of a query physically on disk.
-- it stores data, not just the query.
-- It improves performance for complex queries but
--  requires refresh to stay up to date

-- Normal View: A virtual table that stores only a query and always shows live data.

-- Materialized View: A physical copy of query results that improves performance but requires refresh.



-- Q. How to create a new user in SQL

-- A database user is an account that allows a person or application to log in to the database 
-- 	and access objects such as tables, views, and procedures.

-- A user does not get access automatically after creation.
-- Permissions must be explicitly granted.

--  STEP 1: Create the User
-- 			CREATE USER username IDENTIFIED BY password;
-- 
--  STEP 2: Grant Required Privileges
-- 			GRANT SELECT, INSERT, UPDATE ON database_name.table_name TO username;
-- 			or
-- 		Or grant full access:
-- 			GRANT ALL PRIVILEGES ON database_name.* TO username;


-- Q. how to assign DML permission to a user 

-- DML permissions are assigned using the GRANT command to allow users 
-- 	to read or modify data in database tables.