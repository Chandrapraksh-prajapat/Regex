use regex; 
create table department(
dept_id int primary key,
dept_name varchar(50)
);

drop table employees;
CREATE TABLE employees(
 emp_id INT PRIMARY KEY,
 emp_name VARCHAR(50), 
 salary INT,
 dept_id INT,
 manager_id INT,

 FOREIGN KEY (dept_id) REFERENCES department(dept_id),
 FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);
INSERT INTO employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(1,'Alice',120000,1,NULL),

(2,'Bob',95000,2,1),
(3,'Carol',90000,3,1),
(4,'David',85000,4,1),

(5,'Eve',75000,2,2),
(6,'Frank',72000,2,2),
(7,'Grace',71000,2,2),

(8,'Heidi',60000,2,5),
(9,'Ivan',58000,2,5),
(10,'Judy',59000,2,6),

(11,'Mallory',65000,3,3),
(12,'Niaj',62000,3,3),

(13,'Olivia',55000,4,4),
(14,'Peggy',54000,4,4),

(15,'Sybil',35000,2,8);

INSERT INTO department VALUES
(1,'Management'),
(2,'Technology'),
(3,'Finance'),
(4,'HR');


 
desc department;
 
desc employees;

select * from department;
select * from employees;

-- Q. Show employee name with department name.

SELECT e.emp_name, d.dept_name
	FROM employees e
		JOIN department d
			ON e.dept_id = d.dept_id;


-- Q2. Show ALL employees even if department missing
SELECT e.emp_name, d.dept_name
	FROM employees e
		left JOIN department d
			ON e.dept_id = d.dept_id;
            
            
            
-- Q3️. Count employees per department
select * from employees;

SELECT d.dept_name, COUNT(e.emp_id) AS total_emp
	FROM department d
		LEFT JOIN employees e
			ON d.dept_id = e.dept_id
				GROUP BY d.dept_name;

-- Q4. Departments having MORE than 3 employees

SELECT d.dept_name, COUNT(e.emp_id) AS total_emp
	FROM department d
		LEFT JOIN employees e
			ON d.dept_id = e.dept_id
				GROUP BY d.dept_name 
                having total_emp>3;
                
                
-- Q. Highest salary in each department

SELECT d.dept_name, max(salary) AS total_emp
	FROM department d
		LEFT JOIN employees e
			ON d.dept_id = e.dept_id
				GROUP BY d.dept_name ; 
                
--  Q. Employees earning MORE than department average

select * from department;
select * from employees;

select dept_id , avg(salary)
 from employees group by dept_id;
 
select emp_name,dept_id , salary from employees as e1
							where salary >(
									select avg(salary)
										from employees as e2 where  e1.dept_id=e2.dept_id);


--  Managers who manage MORE than 2 employees

select * from employees;

select manager_id ,count(emp_id) from employees 
		group by manager_id 
			having count(emp_id) >2;
            
            
-- Department with highest TOTAL salary

select * from employees; 

select dept_id , sum(salary) as total_salary from employees group by dept_id order by total_salary desc limit 1;



SELECT d.dept_name, SUM(e.salary) AS total_salary
	FROM department d
		JOIN employees e
			ON d.dept_id = e.dept_id
				GROUP BY d.dept_name
					ORDER BY total_salary DESC
						LIMIT 1;
                        

-- Q. Employees who are NOT managers

SELECT e.emp_name
	FROM employees e
		LEFT JOIN employees x
			ON e.emp_id = x.manager_id
				WHERE x.emp_id IS NULL;

