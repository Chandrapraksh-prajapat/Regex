use sakila;

-- multi-row subQuery (we can't use >,<,=,!= operator) return more than 1 row 
--  We use => in ,
			-- less than any
			-- greater than any 
			-- Equals to any (=any) 
            -- greater than max value of subQuery (all operator )

-- Q. -- get amount where payment_id=2 or payment_id=3  
select amount from payment where payment_id=2 or payment_id=3;

select * from payment where 
	amount in (select amount from payment 	
				where payment_id=2 or payment_id=3);
                

select * from payment;

 -- less than any
 -- greater than any 
 -- Equals to any
 
-- use (any),(< any),(> any) operator 
select * from payment where 
	amount =any (select amount from payment 	
				where payment_id=2 or payment_id=3);
                
                
-- use all operator     
-- greater than max value of subQuery (> all)           
-- less than min value of subQuery (< all) 

select * from payment where 
	amount >all (select amount from payment 	
				where payment_id=2 or payment_id=3);
                
