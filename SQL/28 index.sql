
-- index :
-- indexes is like a data structure which is use to accces the data in a faster way 
-- An index is a data structure that speeds up data retrieval from a table—similar to an index in a book.
-- Instead of scanning every row, the database uses the index to jump directly to the data.
			
-- Type of index : 
-- 				Clustered => Stores data in order (primary key) , physically stored 
-- 							There is only one clustered per table 

-- 				Non-clustered => index points to sorted data
--  							Many allowed 

-- 				Composite (multi-column) index

 
use sakila;

create table test100 as select actor_id, first_name from actor where actor_id between 1 and 10;
insert into test100 values(14,'abc'),(13,'def'),(11,'aman'),(12,'shubham');

-- clustered
-- alter 
alter table test100 add primary key(actor_id); 

select * from test100;

desc test100;  -- no primary key 

select * from  test100 where actor_id=5;

explain select  * from  test100 where actor_id=5;  

explain select  * from  test100 where first_name='NICK';  



-- Non-clustered :

create table test101 as select actor_id, first_name from actor where actor_id between 1 and 10;
insert into test101 values(14,'abc'),(13,'def'),(11,'aman'),(12,'shubham');

select * from test101;
create index index_1 on test101(actor_id); 
show index from test101;


explain select * from test101 where actor_id=5;
 
explain select * from test101 where first_name='aman';
insert into test101 values(12,'abc');
insert into test101 values(15 ,'abc');

select * from test101;
show  index from test101;
 
explain select * from test101 where actor_id=14;
explain select * from test101 where actor_id=12;


drop index index_1 on test101;

-- Composite (multi-column) index


create index index_composite on test101(actor_id,first_name);

show index from test101;

explain select * from test101 where actor_id=3;

explain select * from test101 where first_name=3;

explain select * from test101 where actor_id>10 and first_name='abc';

select * from test101;

insert into test101 values(16,'johgy');
insert into test101 values(17 ,'jeny');

drop index index_composite on test101;
show index from test101;

-- partial index  
create index index_3chr on test101(first_name(3) ); 
explain select * from test101 where first_name='johnny';
 
explain select * from test101 where first_name like'joh%';
explain select * from test101 where first_name like'abc%';


-- 03/FEB/2026
-- Q. Create a role , add a user after that give a permission to the role 
--    and then check the permission of user , login   

-- A role is a named collection of permissions (privileges)
-- Instead of giving permissions directly to every user
-- 		Give permissions to a role
-- 		Then assign that role to users

CREATE TABLE employee (
  id INT,
  name VARCHAR(50)
);

CREATE ROLE manager;

CREATE USER rahul identified by 'rahul123';

GRANT manager TO rahul;

GRANT SELECT, INSERT ON sakila.employee TO manager;

show grants for rahul;

show grants for manager;

select * from employee;








-- Q. Read about index in SQL 