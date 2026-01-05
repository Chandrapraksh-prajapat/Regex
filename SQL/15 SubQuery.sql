-- SubQuery
-- Query within a Query 
-- SubQuery is used to perform calculations based on related tables  
-- filter the record dynamically
use sakila;
show tables;
select * from payment;
select amount from payment where payment_id=5;

-- SubQuery  
select * from payment 
where amount=(select amount from payment where payment_id=7);

-- get all the payment information where the staff serving fro payment_id should be same; 

select * from payment where payment_id=1;

select * from payment where payment_id=(select staff_id from payment where payment_id=2);

-- get payment_id,amount,payment_date, month sholud be same as of payment_id 20  


select * from payment where payment_id=20;

select payment_id, amount,payment_date
 from payment where 
 month(payment_date)=(select month(payment_date) from payment where payment_id=22);
 
 select * from payment;
-- Q. get the amount and the total number of payments done 
-- where the amount sholud be less then amount of rental id 10725

select amount from payment where rental_id=1725;  

select amount,count(*) 
	from payment where 
	amount<(select amount from payment where rental_id=1725) group by amount;
    
-- Q. get the month and total amount spend from payment
-- where month > month(customer_id=1) with the payment_id=3 

select * from payment;

select month(payment_date)
 from payment where  customer_id and payment_id=3;  
 
 -- Single row subQuery (subQuery will return 1 row)
 
select month(payment_date), sum(amount) 
from payment where 
month(payment_date) >(select month(payment_date) from payment where customer_id and payment_id=3)
group by month(payment_date);


-- get amount where payment_id=2 or payment_id=3 

-- multi-row subQuery (we can't use >,<,=,!= operator) 
--  We use => in ,any ,all 
select amount from payment where payment_id=2 or payment_id=3;

select * from payment where 
amount in (select amount from payment where payment_id=2 or payment_id=3);


-- 