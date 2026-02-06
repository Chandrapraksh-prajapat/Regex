use regex;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id)
);
INSERT INTO employee (emp_id, emp_name, job_title, manager_id, salary) VALUES
(1, 'Alice', 'CEO', NULL, 120000),

(2, 'Bob', 'CTO', 1, 95000),
(3, 'Carol', 'CFO', 1, 90000),
(4, 'David', 'HR Manager', 1, 85000),

(5, 'Eve', 'Tech Lead', 2, 75000),
(6, 'Frank', 'Senior Developer', 2, 72000),
(7, 'Grace', 'Senior Developer', 2, 71000),

(8, 'Heidi', 'Developer', 5, 60000),
(9, 'Ivan', 'Developer', 5, 58000),
(10, 'Judy', 'Developer', 6, 59000),

(11, 'Mallory', 'Accountant', 3, 65000),
(12, 'Niaj', 'Financial Analyst', 3, 62000),

(13, 'Olivia', 'HR Executive', 4, 55000),
(14, 'Peggy', 'HR Executive', 4, 54000),

(15, 'Sybil', 'Intern', 8, 35000);

select * from employee;

-- Q. List each employee along with their manager’s name.

select e.emp_name as employee , m.emp_name as manager 
from employee as e
   left join employee as m 
     on e.manager_id=m.emp_id;

-- Q.  Show only employees who earn LESS than their manager.
select e.emp_name,e.salary  as employee_salary ,m.emp_name as manager,  m.salary as manager_salary 
	from employee as e 
		join employee as m 
			on e.manager_id=m.emp_id
				where e.salary < m.salary;
                
--  Q. Find employees who share the SAME job title
select * from employee;

select e1.emp_name as emp_1,sssere1.job_title, e2.emp_name as emp_2,
	e2.job_title from employee as e1
		join employee as e2
			on e1.job_title = e2.job_title
				and e1.emp_id<>e2.emp_id;

-- Q. Find employees having SAME job title but DIFFERENT salaries
select e1.emp_name as emp_1,e2.emp_name as emp_2, e1.job_title 
	from employee as e1
		join employee as e2
			on e1.job_title = e2.job_title and e1.salary<>e2.salary
				and e1.emp_id<e2.emp_id;
                
-- Q. Find pairs of employees whose salary difference is LESS than 2000
select * from employee;
SELECT 
    e1.emp_name AS employee_1,
    e2.emp_name AS employee_2,
		(e1.salary - e2.salary) AS salary_diff
FROM employee e1
JOIN employee e2
ON e1.emp_id <> e2.emp_id
WHERE (e1.salary - e2.salary) < 2000;
 
-- IMPORTANT :
-- Q. Q5 — Find the SECOND highest salary (using self join)

SELECT DISTINCT e1.salary
FROM employee e1
WHERE 1 = (
    SELECT COUNT(DISTINCT e2.salary)
    FROM employee e2
    WHERE e2.salary > e1.salary
);


-- Q. (Cross join )Pair every employee with every other employee.

select * from employee;
select e1.emp_name,e2.emp_name  from employee as e1  
cross join employee as e2; 