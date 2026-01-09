-- correlated subqueries

-- What is a correlated subquery in SQL?

-- A correlated subquery is a subquery that depends on values 
-- from the outer (main) query.
-- Because of this dependency, the subquery cannot be executed independently
-- it is evaluated once for each row processed by the outer query.

-- Outer query row → passed into subquery → subquery result affects that row 
        
-- What are constraints in SQL?

-- => SQL constraints are rules enforced on table columns to ensure 
-- 			data integrity and enforce business rules in a database.

-- Constraints are rules applied to table columns that control 
-- what data is allowed to be stored in a database.
-- They help maintain data integrity, accuracy, and consistency. 


-- Q.Why constraints are important

-- Ensure correct data
-- Enforce business rules
-- Maintain relationships between tables
-- Prevent data corruption

-- | Constraint  | Purpose                |
-- | ----------- | ---------------------- |
-- | NOT NULL    | No NULL values         |
-- | UNIQUE      | No duplicate values    |
-- | PRIMARY KEY | Unique row identifier  |
-- | FOREIGN KEY | Enforces relationships |
-- | CHECK       | Validates data         |
-- | DEFAULT     | Sets default value     |


create database regexcorr;
use regexcorr;

CREATE TABLE employee (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    salary INT,
    department_name VARCHAR(50)
);

INSERT INTO employee (eid, ename, salary, department_name) VALUES
(1,  'Emp1',  30000, 'HR'),
(2,  'Emp2',  32000, 'HR'),
(3,  'Emp3',  34000, 'HR'),
(4,  'Emp4',  36000, 'HR'),
(5,  'Emp5',  38000, 'HR'),

(6,  'Emp6',  50000, 'IT'),
(7,  'Emp7',  52000, 'IT'),
(8,  'Emp8',  54000, 'IT'),
(9,  'Emp9',  56000, 'IT'),
(10, 'Emp10', 58000, 'IT'),

(11, 'Emp11', 60000, 'Finance'),
(12, 'Emp12', 62000, 'Finance'),
(13, 'Emp13', 64000, 'Finance'),
(14, 'Emp14', 66000, 'Finance'),
(15, 'Emp15', 68000, 'Finance'),

(16, 'Emp16', 40000, 'Sales'),
(17, 'Emp17', 42000, 'Sales'),
(18, 'Emp18', 44000, 'Sales'),
(19, 'Emp19', 46000, 'Sales'),
(20, 'Emp20', 48000, 'Sales');


select * from employee;

select department_name,avg(salary) from employee group by department_name;

select avg(ein.salary) from employee as ein where ein.department_name='Hr';

select employee.ename,employee.salary,employee.department_name 
	from employee where employee.salary >all(
    select avg(ein.salary) from employee as ein where ein.department_name=employee.department_name);


-- common table expression 
with xyz as 
( select department_name,avg(salary) from employee group by department_name)
 
 
select employee.ename,employee.salary,employee.department_name from employee
join xyz on employee.department_name = xyz.department_name 
where employee.salary>xyz.salary;

select * from xyz;


-- Q. Employees whose salary is greater than average salary of their department

SELECT e1.eid, e1.ename, e1.salary, e1.department_name
	FROM employee e1
	WHERE e1.salary >
	 (SELECT AVG(e2.salary)
		FROM employee e2
       WHERE e2.department_name = e1.department_name);
       
       

