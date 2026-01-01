use sakila;

select * from payment;
select amount from payment where amount >0.90;
select amount from payment where payment_id=25;


select * from payment where amount >(select amount from payment where payment_id=20																																																																																																																																																																																																																																																																	);

select payment_id,payment_date, month(payment_date) from payment where payment_id=15;
select * from payment where month(payment_date)=7;

select * from payment where 
month(payment_date)=(select month(payment_date) 
						from payment where payment_id=15);
                        
s


