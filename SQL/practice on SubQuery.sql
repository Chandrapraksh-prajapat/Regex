
-- drop database corredb;
create database corredb;

use corredb;

CREATE TABLE departments (
    dept_id     INT PRIMARY KEY,
    dept_name   VARCHAR(50)
);

CREATE TABLE employees (
    emp_id      INT PRIMARY KEY,
    emp_name    VARCHAR(50),
    dept_id     INT,
    salary      INT,
    job_title   VARCHAR(50),
    hire_date   DATE,
    CONSTRAINT fk_dept
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance'),
(40, 'Sales'),
(50, 'Marketing');


INSERT INTO employees (emp_id, emp_name, dept_id, salary, job_title, hire_date) VALUES
(101, 'Alice',   10, 40000, 'HR Executive',      '2018-03-12'),
(102, 'Bob',     20, 60000, 'Software Eng',      '2019-07-19'),
(103, 'Charlie', 20, 75000, 'Senior Dev',        '2017-01-10'),
(104, 'David',   30, 50000, 'Accountant',        '2020-11-01'),
(105, 'Eva',     30, 90000, 'Finance Manager',   '2016-06-23'),
(106, 'Frank',   40, 45000, 'Sales Rep',         '2019-02-15'),
(107, 'Grace',   40, 70000, 'Sales Manager',     '2015-09-30'),
(108, 'Hannah',  50, 48000, 'Marketing Exec',    '2021-04-18'),
(109, 'Ian',     50, 65000, 'Marketing Lead',    '2018-12-07'),
(110, 'Jack',    20, 55000, 'QA Engineer',       '2020-08-25'),
(111, 'Karen',   10, 42000, 'HR Analyst',        '2019-05-14'),
(112, 'Leo',     30, 52000, 'Auditor',            '2021-09-09'),
(113, 'Mona',    40, 48000, 'Sales Exec',        '2022-01-03'),
(114, 'Nina',    20, 80000, 'Tech Lead',         '2016-10-11'),
(115, 'Oscar',   50, 47000, 'Content Writer',    '2020-06-17'),
(116, 'Paul',    10, 39000, 'Recruiter',         '2022-07-20'),
(117, 'Queen',   30, 61000, 'Financial Analyst', '2018-02-28'),
(118, 'Rick',    40, 53000, 'Sales Analyst',     '2019-09-05'),
(119, 'Steve',   20, 67000, 'DevOps Eng',        '2017-04-14'),
(120, 'Tina',    50, 72000, 'Brand Manager',     '2016-12-01');



-- Q. find employee whose salary is greater then average salary
select* from employees 
	where salary >(select avg(salary) from employees); -- using subQuery  
                                    
-- or 
                                     
with cte as(select avg(salary) from employees)     -- using CTE 
select * from employees where salary >(select * from cte);


-- Q.find the employee who earn the maximum salary 
                      
select * from employees 
	where salary = (select max(salary) from employees);
    
  with cte as (select max(salary) from employees)
 select * from employees where salary= (select * from cte);
  
  
-- IMPORTANT  ( OFF SET nhi use krne )
-- Q.find employee who have second highest salary
               
(select max(salary) from employees);  -- highest  

select max(salary) from employees where salary<(select max(salary) from employees); -- second highest 

select * from employees 
	where salary =( select max(salary) from employees
			where salary<(select max(salary) from employees));

--  Using CTE
with cte as (select max(salary) from employees where salary<(select max(salary) from employees))
select * from employees where salary =(select * from cte);



-- Q.find the employee who in finance or IT department 
select * from employees;
select * from departments;

select * from employees where dept_id  in(
select dept_id from departments where dept_name='IT' or dept_name='Finance'); 


-- Q. Find  employee whose salary is greater then  all employee of HR department 

select * from departments where dept_name= 'HR';
select * from departments where dept_id=10;

--  using SubQuery 
select * from employees where salary >all
(select salary from employees where dept_id=10);

--  using SubQuery 
select * from employees where salary >all(
		select max(salary) from employees where 
           dept_id=(select dept_id from departments where dept_name='HR'));
           
--  using join            
select * from employees where salary >all(
    select salary from employees as e 
        join departments as d 
          on d.dept_id=e.dept_id 
             where dept_name='HR');
             

-- Q.   find the employee who earn the same salary  as any employee in sales department

select * from departments where dept_name='sales';
select * from employees where dept_id=40;

select * from employees where salary =any
				( select salary from employees where dept_id=
		(select dept_id from departments where dept_name ='sales'));

with cte as (
   select d.dept_id,salary from employees as e join departments as d 
   where e.dept_id=d.dept_id and d.dept_name='sales')
   
select * from employees where salary in (select salary from cte)
     and dept_id not in (select dept_id from cte);


-- Q. find employees who earn more than the avg salary of their own department

select dept_id, avg(salary) from employees group by dept_id ;


select emp_id,emp_name, dept_id, salary from employees as eout 
where salary > (select avg(salary) from employees where dept_id = eout.dept_id);


-- using cte 
with cte as (
select dept_id, avg(salary) as salary from employees group by dept_id)
select * from employees as e join cte where e.dept_id= cte.dept_id
and e.salary > cte.salary ;

-- Q. FInd employee who have the highest salary in their department  

select * from employees;

select dept_id, max(salary) as salary  from employees group by dept_id;

with cte as (select dept_id, max(salary) as salary  from employees group by dept_id)
select * from employees as e join cte where e.dept_id=cte.dept_id and e.salary=cte.salary;


-- Q. find department whose avg salary is greater the overall average salary of all employees 

select * from employees;
select * from departments;

 select dept_id, avg(salary) from employees group by dept_id
 having avg(salary) > (select avg(salary) from employees);
 
 -- Q. find the department  with the maximum total salary 
 
 select dept_id, sum(salary) as total from employees group by dept_id order by total desc limit 1;
 
 -- new  
 select sum(salary) as total from employees group by dept_id ;

select dept_id, sum(salary) as total from employees 
	group by dept_id
       having total >=all (select sum(salary) as total from employees group by dept_id);
       
       
	
-- Q. Find departments whose minimum salary is 
--   greater than the minimum salary of the sales departments

select dept_id , min(salary) from employees group by dept_id; 

select dept_id from departments where dept_name ='Sales';

select min(salary) from employees as e join departments as d 
 where d.dept_id =e.dept_id  and d.dept_name='sales';


select dept_id, min(salary)  as minsalary from employees group by dept_id 
 having minsalary >  (
select min(salary) from employees as e join departments as d 
 where d.dept_id =e.dept_id  and d.dept_name='sales');


-- no aggregate functions here 
select dept_id , min(salary) as minsalary from employees group by dept_id 
having minsalary > any (select salary from employees as e join departments as d 
    where e.dept_id=d.dept_id and dept_name='sales'); 
    


CREATE TABLE food (
    f_id INT PRIMARY KEY,
    f_name TEXT,
    f_cost INT,
    f_type TEXT
);
INSERT INTO food VALUES
(1, 'Pizza', 200, 'FastFood'),
(2, 'Burger', 150, 'FastFood'),
(3, 'Tacos', 180, 'Mexican'),
(4, 'Pasta', 400, 'Continental'),
(5, 'Steak', 500, 'Continental');



-- Q. Write a query to retrieve the names of food items which cost less than the average cost of 'Continental' food type(f_type).

select * from food;
select f_type,avg(f_cost) from food where f_type='Continental';

select f_name,f_cost from food where f_cost< (select avg(f_cost) as avgcost from food where f_type='Continental');

