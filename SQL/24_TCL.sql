-- TCL
-- Transaction control language( use to maintain data consistancy) 
-- transaction => set of logical statement (not permanent)
-- update

use regex;
create table actor_cp2 as select actor_id, first_name from sakila.actor
where actor_id between 1 and 5;

select * from actor_cp2;
insert into actor_cp2 values(6,'Tushar');

-- autocommit =>enable

set @@autocommit=0;
select @@autocommit;
insert into actor_cp2 values(7,'Vishal');
select * from actor_cp2;  
insert into actor_cp2 values(8,'mahendra');
insert into actor_cp2 values(9,'ravindra');
insert into actor_cp2 values(10,'ravi');
insert into actor_cp2 values(11,'mahi');
insert into actor_cp2 values(12,'mahihbad');
insert into actor_cp2 values(13,'mahigvdv');
rollback;
select * from actor_cp2;
rollback;
-- in case if you run any dml operation or you write down start transaction 
-- so transaction start
 
-- trancation are auto close , when use tcl statement(commit, rollback,savepoint) or   
-- in case run any ddl operation (create , alter , drop ,truncate) 


-- 
set @@autocommit=1;
select @@autocommit; 
start transaction;  -- (statement pending ) 
insert into actor_cp2 values(14,'amazon');
insert into actor_cp2 values(15,'flipkart');
insert into actor_cp2 values(16,'meesho');
commit;
select * from actor_cp2;
create table xyz(id int);



start transaction;
insert into actor_cp2 values(17,'abc');
insert into actor_cp2 values(20,'cdf');
set SQL_SAFE_UPDATES=0;

savepoint db_actor_cp2_checkpoint1;
savepoint db_actor_cp2_checkpoint2;

delete from actor_cp2 where actor_id in (16,17);
select * from actor_cp2;
rollback to db_actor_cp2_checkpoint2;








-- 
  