-- constraints : rules that we applied to limit the data in table

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


-- create Table   
-- structure (DDL => create ,Alter,Drop,Truncate)
  use regex_l4;
  
  create table test1(sno int);
  
-- DML(insert , update , delete)
insert into test1 values(10);
insert into test1(sno) values(20);
insert into test1(sno) values(null), (30);

select count(sno),count(*) from test1;


select * from test1;
  desc test1;

-- create test 2
-- not null constraints 
  
create table test2 (sno int not null,salary int);
insert into test2(sno,salary) values(20,1000);
insert into test2(sno,salary) values(20,null);
insert into test2(sno,salary) values(null,1000);
insert into test2(sno,salary) values(20,1000);  -- Error 
insert into test2(salary) values(1000); -- Error 

select * from test2;


-- create test3
-- default constraints

create table test3 (sno int not null default 80,salary int);
insert into test3(salary) values(1000);
insert into test3(sno) values(5000);

select * from test3;

--  create test4
--  unique constraints
create table test4 (sno int not null, salary int  unique default 100);
insert into test4(sno,salary) values(1000,20000);
insert into test4(sno,salary) values(1001,20000);  -- duplicate value error  
insert into test4(sno) values(1000);

insert into test4(sno) values(1500);  -- error default 1000 already in table 
insert into test4(sno,salary) values(1500,null);
insert into test4(sno,salary) values(1600,null);
select * from test4;


-- check constraints

-- create test5 

create table test6 (sno int ,salary int,
	constraint regex_test6_sno_check check(sno between 1 and 100),    
 constraint regex_test6_salary_check check(salary in (1000,2000))); -- give constraints name
    
insert into test6(sno,salary) values(4,1000);
insert into test6(sno,salary) values(150,1000); -- error 
insert into test6(sno,salary) values(90,1500);  -- error
insert into test6(sno,salary) values(123,1500); -- error 

select * from test6;
 
-- primary key constraints 

create table test7 (sno int primary key ,salary int);
	insert into test7(sno,salary) values(4,1000);
    insert into test8(sno,salary) values(null,12233);

-- foreign key constraints

create table customer1 (cid int primary key , cname varchar(20)); 
insert into customer1 values(10,'aman'),(11,'abhishek');
select * from customer1;
 
drop table order1;
 
create table order1(order_no int primary key , city varchar(20), cid int,
	foreign key (cid) references customer1 (cid) );
    
insert into order1 values(1007,'jaipur', 10),(1008,'Goa',11),(1009,'Mumbai',10);
insert into order1 values(10010,'j&k',25); -- error as 25 cid is not in customer table 
select * from order1;

