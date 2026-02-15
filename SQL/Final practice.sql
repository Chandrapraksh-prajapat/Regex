use regex_L4;
 show tables;
 
 drop table employees;
 CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT,
    hire_date DATE
);


drop table departments;
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

 drop table orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer VARCHAR(50),
    amount INT,
    order_date DATE
);

INSERT INTO employees VALUES
(1,'John','IT',60000,NULL,'2020-01-10'),
(2,'Sara','HR',50000,1,'2021-03-15'),
(3,'Mike','IT',70000,1,'2019-07-23'),
(4,'Anna','Finance',65000,3,'2022-05-01'),
(5,'Tom','IT',55000,3,'2021-11-19');

INSERT INTO departments VALUES
(10,'IT'),
(20,'HR'),
(30,'Finance');

INSERT INTO orders VALUES
(101,'Alex',2000,'2024-01-10'),
(102,'Bob',3000,'2024-01-11'),
(103,'Alex',1500,'2024-01-12'),
(104,'Chris',4000,'2024-01-13');





-- 1. Display employee name with their managername.

 select e.emp_name as employee , m.emp_name as Manager
	from employees as e 
		left join employees as m 
			on e.manager_id=m.emp_id;

-- 2. Find employees who do not have a manager.
 select * from employees where manager_id is null;

-- 3. Find managers who manage more than one employee.

select manager_id, count(*) from employees 
	group by manager_id having count(*)>1;


-- 4. Display department name with total salary.

select department, sum(salary) from employees group by department;

-- 5. Show departments that have no employees

select department from employees where emp_id is null;


-- 6. Find employees earning more than their manager.

select * from employees as e 
	join employees as m 
		on e.manager_id=m.emp_id
			where e.salary >m.salary;
			

-- 7. Find employee name, department name, and salary.


select emp_name , department, salary from employees;

-- 8. Find the department that has the highest total salary.

select department , sum(salary) as salary from employees group by department order by salary desc limit 1;

-- 9. Find employees earning more than average salary.

SELECT * FROM employees WHERE salary>(SELECT AVG(salary) FROM employees);


-- 10. Find second highest salary.

select max(salary)from employees where salary <(select max(salary) from employees); 

-- 11. Find 3rd highest salary.

SELECT DISTINCT salary FROM employees ORDER BY salary DESC LIMIT 1 OFFSET 2;

-- 12. Find employees whose salary equals max salary of their department.

select * from employees as e where salary = (select max(salary) from employees 
where department =e.department);

-- 13. Find employees working in department with highest average salary.

SELECT * FROM employees WHERE department=(SELECT department FROM employees
GROUP BY department ORDER BY AVG(salary) DESC LIMIT 1);

-- 14. Find customers placing more orders than average.

SELECT customer FROM orders GROUP BY customer 
	HAVING COUNT(*)>(SELECT AVG(c)FROM (SELECT COUNT(*)  as c FROM orders GROUP BY customer) as t);
select * from orders;

-- 15. Find latest hired employee in each department.

SELECT * FROM employees e WHERE hire_date=(SELECT MAX(hire_date) FROM employees
WHERE department=e.department);


-- 16. Rank employees by salary.

select *, rank() over(order by salary desc) from employees; 

-- 17. Dense rank employees by salary.

select*, dense_rank() over(order by salary desc) from employees;

-- 18. Row number by department.

select *, row_number() over(partition by department) from employees;

-- 19. Top 2 salaries per department.

SELECT * FROM (SELECT * , row_number() OVER(PARTITION BY department ORDER BY salary DESC) as  r FROM employees)t WHERE r<=2;

-- 20. Second highest salary using window.

select * from(select *, rank() over(order by salary desc )  as highest from employees) as t where highest=2 ;

-- 21. Running total of salary by hire date.

select * , sum(salary) over(order by hire_date)  from employees;

-- 22. Salary difference using LAG.

SELECT emp_name,salary, salary-LAG(salary) OVER(ORDER BY salary) FROM employees;

-- 23. CTE: employees earning more than department average.

with cte as (select department , avg(salary) as salary from employees group by department)

select e.* from employees as e join cte  ON e.department=cte.department WHERE e.salary>cte.salary; 

-- 24. Recursive CTE hierarchy.

WITH RECURSIVE h AS(SELECT emp_id,emp_name,manager_id FROM employees WHERE
manager_id IS NULL UNION ALL SELECT e.emp_id,e.emp_name,e.manager_id FROM
employees e JOIN h ON e.manager_id=h.emp_id) SELECT * FROM h;

-- 25. CTE department with highest total salary.

with cte as (select department, sum(salary) as s from employees group by department)
select * from cte order by s desc limit 1;


-- 26. Create View for high paid employees.

CREATE VIEW high_paid AS SELECT * FROM employees WHERE salary>60000;

-- 27. Create Index on salary column.

 create index idx_salary on employees(salary);
 
-- 28. Check index exists.

show index from employees;

-- 29. Find median salary.

SELECT AVG(salary) FROM (SELECT salary, ROW_NUMBER() OVER(ORDER BY salary) as rn ,
							COUNT(*) OVER() as  c FROM employees)as t WHERE rn IN((c+1)/2,(c+2)/2);


-- 30. Find employees joined consecutively

SELECT e1.emp_name,e2.emp_name FROM employees e1 JOIN employees e2 ON
e2.hire_date=DATE_ADD(e1.hire_date,INTERVAL 1 DAY);

select * from employees;
