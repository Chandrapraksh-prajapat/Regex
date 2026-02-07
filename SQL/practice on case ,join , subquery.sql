 use sakila;
 
 show tables;
 select * from customer ;
 
select first_name , active ,
	case 
		 when active=1  then 'Active customer'
         when active=0 then 'Inactive customer'
	end as customer 
        from customer;
        
        
        
select * from film;

select film_id, title, length, rating ,
case 
	when length <60 then 'short movie'
    when length between 60 and 120 then 'Medium movie'
    when length >120 then 'Long movie'
end as movie_length
 from film;
 
 
 -- Q. count film per rating , label them 
 
 select rating,count(*) as total from film group by rating;
 
 select rating, count(*) as total,
 case 
	when count(*)<200 then 'Low count'
    when count(*) between 200 and 400 then 'Medium count'
    when count(*) >400 then 'Long count'
end as movie_length
 from film group by rating;
 
 
 
-- Q. calculate the total payment and classify  

select * from payment;
select * from customer;


select c.customer_id,concat(c.first_name,' ',c.last_name) as customer_name,
	sum(p.amount) as total_amount,
	case 
		when sum(p.amount) <90 then 'Low Spend'
        else 'High spend'
	end as Spending
 from customer as c 
	join payment as p 
		on p.customer_id=c.customer_id
        group by c.customer_id, c.first_name;
        
        
        
-- Q. find how many times each has been rented 


select * from film;
select * from inventory;
select * from rental;
desc film;
desc inventory;
desc rental;

select title ,count(rental_id) from film as f 
 join inventory as i 
	on f.film_id=i.film_id
		join rental as r 
         on r.inventory_id = i.inventory_id
	group by title;
    
    
    
-- Q. List pairs of customers belong to the same store 

select * from customer;
desc customer;

select c1.customer_id,c1.first_name as customer1,c1.store_id, c2.first_name as customer2, c2.store_id 
	from customer as c1
		join customer as c2
			on c1.store_id = c2.store_id
				and c1.customer_id<>c2.customer_id;



-- Q. Find customer whose total payment is greater than the avg total payment of all customer 

select * from customer;
select * from payment; 


select c.customer_id, c.first_name, sum(p.amount) from payment as p 
		join customer as c 
			where p.customer_id=c.customer_id
            group by c.customer_id, c.first_name
            having sum(p.amount)> ( select avg(total_payment) from (
									select sum(amount) as total_payment 
									from payment group by customer_id) as total);
                                    
                                    
                                    
--  Q. find films whose rental count is greater than the average rentals per film 

select * from film;
select * from inventory;
select * from rental;

select f.film_id, title, count(rental_id) from film as f 
 join inventory as i 
  on f.film_id =i.film_id
	join rental as r
     on i.inventory_id = r.inventory_id 
      group by title, f.film_id;
      
select count(rental_id) from rental;