
-- CTE : Common table expression
-- A temporary name of your sql query
-- they are not store permanent basis only temporary
-- it help to break complex query into readable form

-- It’s a temporary, named result set that you can reference 
-- within a single SQL statement, making queries cleaner, more readable, and easier to maintain.

with tushar_cte as (select * from sakila.actor)

select count(*) from tushar_cte;


WITH cte AS (
  SELECT *, MONTH(payment_date) AS payment_month
  FROM sakila.payment)
SELECT payment_month, COUNT(*)
FROM cte
GROUP BY payment_month;



WITH cte AS (
  SELECT *,DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rankings
  FROM sakila.payment)
SELECT *FROM cte WHERE rankings = 2;


create database test90;
use test90;

CREATE TABLE employee (
    emp_id     INT PRIMARY KEY,
    emp_name   VARCHAR(50),
    department VARCHAR(30),
    salary     INT,
    manager_id INT
);

INSERT INTO employee (emp_id, emp_name, department, salary, manager_id) VALUES
(1, 'Alice',   'HR',      50000, NULL),
(2, 'Bob',     'HR',      45000, 1),
(3, 'Charlie', 'HR',      55000, 1),

(4, 'David',   'IT',      70000, NULL),
(5, 'Eva',     'IT',      65000, 4),
(6, 'Frank',   'IT',      72000, 4),
(7, 'Grace',   'IT',      68000, 4),

(8, 'Henry',   'Sales',   60000, NULL),
(9, 'Irene',   'Sales',   58000, 8),
(10,'Jack',    'Sales',   62000, 8);


select * from employee;

select department, avg(salary) from employee group by department;
-- correlated
select emp_id, emp_name,department,salary from employee as e
where salary>( select avg(salary) from employee where department=e.department);

-- cte
with cte as (
select department as dept, avg(salary) as deptsalary from employee group by department)

select  emp_id, emp_name,department,salary, dept, deptsalary
from employee as e join cte where e.department=cte.dept
and salary>deptsalary;



-- CTE is a logical, short-lived result set used for readability,

-- while a temporary table is a physical table used for performance and reuse across multiple querie 

-- | Feature    | CTE                                      | Temporary Table                             |
-- | ---------- | ---------------------------------------- | ------------------------------------------- |
-- | What it is | A **temporary named result set**         | A **physical table** stored in temp storage |
-- | Scope      | Exists only for **one SQL statement**    | Exists for the **session or transaction**   |
-- | Storage    | Logical (usually in memory / query plan) | Physically stored in temp database          |



-- DCL (Data Control Language) in SQL

-- DCL is used to control access and permissions in a database.
-- It decides who can do what on database objects like tables, views, and procedures.

-- Main DCL Commands

-- GRANT – Give permissions
-- REVOKE – Remove permissions

-- (Some databases like SQL Server also support DENY)



-- Authentication and Authorization:
-- 1️. Authentication (Who are you?)

-- Authentication is the process of verifying the identity of a user.

-- 2. Authorization (What are you allowed to do?)

-- Authorization decides what actions an authenticated user can perform.