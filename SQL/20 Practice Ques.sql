
show tables;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary INT
);

INSERT INTO Employees (emp_id, name, department_id, salary) VALUES
(1, 'Alice', 1, 50000),
(2, 'Bob', 2, 40000),
(3, 'Charlie', 1, 60000),
(4, 'Diana', NULL, 45000);

select * from employees;



create table departments(
			department_id int primary key,
            department_name varchar(20));
		
insert into departments values(1,'Hr');
insert into departments values(2,'IT');
insert into departments values(3,'Finance');

select * from departments;



-- customer_id customer_name
-- 101 John
-- 102 Emma
 drop table customers;
create table customers( customer_id int primary key , customer_name varchar(30));

insert into customers values(101,'john');
insert into customers values(102,'Emma');

select * from customers;
desc customers;


-- order_id customer_id amount
-- 1 101 200
-- 2 101 300
-- 3 102 150


create table orders( order_id int primary key , customer_id int, amount int);

INSERT INTO Orders (order_id, customer_id, amount) VALUES
(1, 101, 200),
(2, 101, 300),
(3, 102, 150);

select * from orders;

-- SQL Practice Questions (up to Joins & Subqueries)


-- Q1. Select all employees from the Employees table who work in the 'HR' department.
select * from employees;
select * from departments;


select * from employees as e
	join departments as d
    on e.department_id=d.department_id
     where d.department_name='Hr';

-- Q2. Display employee names and salaries where salary is greater than 40000.
select * from employees;

select name, salary  from employees where salary > 40000;


-- Q3. Find the total salary paid per department.
select * from employees;
select * from departments;

select sum(salary) as Total_salary from employees group by department_id;


-- Q4. List departments having more than 2 employees.

select department_id ,count(*) from employees 
	group by department_id having count(*) > 2;

-- Q5. Display employee name and department name using INNER JOIN.

select e.name, d.department_name from employees as e 
	 inner join departments as d on e.department_id=d.department_id;
     
-- Q6. Show employees who do not belong to any department.

select * from employees where department_id is null;

-- Q7. Find the highest paid employee in each department.

select * from employees;
select * from departments;

select * from employees as e 
where salary =(select max(salary)from employees 
			   where department_id=e.department_id);
               
-- Q8. Display employees earning more than the average salary.
select * from employees;
select * from departments;

select avg(salary) as ass from employees;

select * from employees as e 
where salary > (select avg(salary) as ass from employees);

-- Q9. Find customers who placed more than 1 order.

select * from customers;
select * from orders; 

select customer_id , count(*) from orders 
	group by customer_id
		having count(*) >1;
        
        
-- Q10. Display customer name and total order amount using JOIN and GROUP BY
        
select * from customers;
select * from orders; 

select c.customer_name , sum(o.amount) from customers as c
	 inner join orders as o 
		on c.customer_id=o.customer_id
			group by c.customer_id; 
            
	
-- practice joins 

-- Q1. Show employee names along with their department names.         

select e.name , d.department_name from employees as e 	
			left join departments as d 
             on e.department_id = d.department_id;

-- Q2. Show only employees whose department exists.

select * from employees as e
	join departments as d 
    on e.department_id=d.department_id;
    
-- Q3. Display customers and their order amounts.
    
    select c.customer_name,o.amount from customers as c 
     join orders as o 
      on c.customer_id=o.customer_id;
      
-- Q4. Show departments that have no employees.

select d.department_name from departments as d 
	left join employees as e 
    on d.department_id = e.department_id 
    where emp_id is NULL;


-- Q5. Display employees and departments using RIGHT JOIN.

select e.name, d.department_name from employees as e 
	right join departments as d 
		on e.department_id=d.department_id;
        
-- Group by
 
-- Q6. Find total salary for each department.

select department_id,sum(salary) from employees as e 
group by department_id;


-- Q7. Find total order amount for each customer.

select customer_id,sum(amount) from orders group by customer_id;

-- Q8. Count employees in each department.
	
select department_id , count(*) from employees group by department_id;

-- Q9. Find average salary per department

select department_id,avg(salary) from employees group by department_id;

-- Q10. Show customers who placed more than one order

select customer_id, count(customer_id) from orders
group by customer_id 
having count(customer_id)>1; 



-- SubQuery

-- Q11. Find the employee with the highest salary

select * from employees where salary=(select max(salary) from employees);
 
-- Q12. Find employees earning more than average salary.

select * from employees where salary> (select avg(salary) from employees);

-- Q13. Find customers who have not placed any orders.

SELECT * FROM customers 
	WHERE customer_id NOT IN (
		SELECT customer_id FROM orders);
        
-- Q14. Find department that has the highest paid employee.
 
 select department_id from employees where salary = (select max(salary) from employees);  
 
-- Q15. Find employees who do not belong to Finance department.

select * from employees 
	where department_id <>(
			select department_id from departments 
				where department_name='Finance'); 

 
 
-- INTERVIEW QUESTIONS 
 
-- Q16. Find employees with NULL department

select emp_id, name from employees where department_id is null;
 
-- Q17. Find second highest salary 

select max(salary) from employees where salary < (select max(salary) from employees );
 
 
-- Q18. Find customers whose total order amount is greater than 200.

select customer_id, sum(amount) from orders 
	group by customer_id having sum(amount)>200; 

-- Q19. Display employees sorted by salary in descending order

select  * from employees order by salary desc; 

-- Q20. Show department-wise employee names

 SELECT d.department_name,group_concat(e.name) FROM departments d
	LEFT JOIN employees e 
		ON d.department_id = e.department_id 
			GROUP BY d.department_name;
 

select * from customers;
select * from orders; 
    
select * from employees;
select * from departments;