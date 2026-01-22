
CREATE TABLE events (
  event_id   INT PRIMARY KEY,
  event_name VARCHAR(100) NOT NULL,
  city       VARCHAR(50)  NOT NULL
);


CREATE TABLE ticket_sales (
  sale_id          INT PRIMARY KEY,
  event_id         INT NOT NULL,
  sale_date        DATE NOT NULL,
  ticket_type      VARCHAR(20) NOT NULL,
  qty              INT NOT NULL,
  price_per_ticket INT NOT NULL,
  CONSTRAINT fk_ticket_sales_event
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

INSERT INTO events (event_id, event_name, city) VALUES
(1, 'Music Fest', 'Mumbai'),
(2, 'Tech Summit', 'Bengaluru'),
(3, 'Food Carnival', 'Delhi'),
(4, 'Startup Meetup', 'Mumbai');


INSERT INTO ticket_sales (sale_id, event_id, sale_date, ticket_type, qty, price_per_ticket) VALUES
(101, 1, '2025-01-05', 'Regular', 2, 1500),
(102, 1, '2025-01-10', 'VIP',     1, 5000),
(103, 2, '2025-02-03', 'Regular', 3, 2000),
(104, 2, '2025-02-10', 'VIP',     1, 6000),
(105, 3, '2025-03-01', 'Regular', 5,  800),
(106, 3, '2025-03-15', 'VIP',     2, 2500),
(107, 4, '2025-01-20', 'Regular', 4, 1200),
(108, 4, '2025-02-05', 'Regular', 1, 1200);

show tables;


select * from events;
SELECT * FROM events ORDER BY event_id;

select * from ticket_sales;
SELECT * FROM ticket_sales ORDER BY sale_id;


-- Q. Find the total quantity sold per event_id.
select *from events; 
select * from ticket_sales;

select event_id,sum(qty) as Total_quantity from ticket_sales group by event_id;

-- Q. Find the total revenue per event_id.
--  event_id 	total_revenue
-- 		1 			8000
-- 		2 			12000
-- 		3 			9000
-- 		4 			6000

 select * from ticket_sales;
 select event_id , sum(qty*price_per_ticket)from ticket_sales
			 group by event_id;
             

-- Q. Find monthly total revenue (group by month of sale_date). 
-- 	sale_month 	total_revenue

-- 		1 			18800
-- 		2 			13200
-- 		3 			9000
select * from events;
select * from ticket_sales;
select month(sale_date) as sale_month , sum(qty*price_per_ticket) as total_revenue
			from ticket_sales group by  sale_month;
            

-- Q. Find the maximum price_per_ticket per event_id.
-- 	event_id   	max_price
-- 		1 			5000
-- 		2 			6000
-- 		3 			2500
-- 		4 			1200
 select * from ticket_sales;
 
 select event_id,max(price_per_ticket) from ticket_sales group by event_id;
 
 
--  Find total revenue per month and ticket_type. 
-- 	sale_month 		ticket_type 	total_revenue
-- 		1 				Regular 		7800
-- 		1 				VIP 			11000
-- 		2 				Regular 		7200
-- 		2 				VIP 			6000
-- 		3 				Regular 		4000
-- 		3 				VIP 			5000
select * from ticket_sales;
select month(sale_date) as sale_month , ticket_type,sum(qty*price_per_ticket) as total_revenue
			from ticket_sales group by sale_month,ticket_type;
            
            
-- List all sales with event_name and sale_date. 
-- sale_id 	event_name 		sale_date
-- 101 		Music Fest	 	2025-01-05
-- 102 		Music Fest 		2025-01-10
-- 103 		Tech Summit 	2025-02-03
-- 104 		Tech Summit		2025-02-10
-- 105 		Food Carnival 	2025-03-01
-- 106 		Food Carnival 	2025-03-15
-- 107 		Startup Meetup 	2025-01-20
-- 108 		Startup Meetup 	202	5-02-05

select * from events;
select * from ticket_sales;
select sale_id , event_name, sale_date from ticket_sales as t 
  inner join events as e on e.event_id=t.event_id order by sale_id;
  
-- Q. Show event_name, ticket_type, qty for each sale.
 
-- 	event_name 	ticket_type 	qty

-- 	Music Fest 		Regular 	2
-- 	Music Fest 		VIP 		1
-- 	Tech Summit 	Regular 	3
-- 	Tech Summit 	VIP 		1
-- 	Food Carnival 	Regular 	5
-- 	Food Carnival 	VIP 		2
-- 	Startup Meetup 	Regular 	4
-- 	Startup Meetup 	Regular 	1

select event_name, ticket_type, qty 
	from ticket_sales as t
		 inner join events as e on e.event_id=t.event_id;
		

-- Show sales where the event city is Mumbai.
--  sale_id 	event_name 		city 	sale_date
-- 	101 		Music Fest 		Mumbai 	2025-01-05
-- 	102 		Music Fest 		Mumbai 	2025-01-10
-- 	107 		Startup Meetup 	Mumbai 	2025-01-20
-- 	108 		Startup Meetup 	Mumbai 	2025-02-05
 select * from ticket_sales;
 
 select sale_id, event_name , city , sale_date 
	 from ticket_sales as t 
		 join events as e 
          on e.event_id=t.event_id where city='mumbai';
          
          
-- Show all events and matching sales
-- event_name  	  sale_id 	sale_date
-- Music Fest 		101 	2025-01-05
-- Music Fest 		102 	2025-01-10
-- Tech Summit 		103 	2025-02-03
-- Tech Summit 		104 	2025-02-10
-- Food Carnival 	105 	2025-03-01
-- Food Carnival 	106 	2025-03-15
-- Startup Meetup 	107 	2025-01-20
-- Startup Meetup 	108 	2025-02-05

select * from ticket_sales;
select e.event_name,t.sale_id,t.sale_date from ticket_sales as t 
		 inner join events as e on e.event_id=t.event_id;
         

-- Show distinct event names that have at least one sale.
--  event_name
-- Music Fest
-- Tech Summit
-- Food Carnival
-- Startup Meetup

select * from events;
select * from ticket_sales;

select distinct e.event_name
	from events as e 
 join ticket_sales as t 
  on e.event_id=t.event_id;
  
  
-- Show each sale’s computed revenue with event name.
-- sale_id 		event_name 			revenue
-- 101 			Music Fest 			3000
-- 102 			Music Fest 			5000
-- 103 			Tech Summit 		6000
-- 104 			Tech Summit 		6000
-- 105 			Food Carnival 		4000
-- 106 			Food Carnival 		5000
-- 107 			Startup Meetup 		4800
-- 108 			Startup Meetup 		1200

select * from ticket_sales;
select sale_id,event_name, (qty*price_per_ticket)as revenue from ticket_sales as t 
 inner join  events as e 
 on e.event_id = t.event_id ;
 
 
 
-- Find total quantity per event_name. 
-- 	event_name 		total_qty
-- 	Music Fest 			3
-- 	Tech Summit 		4
-- 	Food Carnival 		7
-- 	Startup Meetup 		5

select * from ticket_sales;
select e.event_name, sum(t.qty) as total_qty from events as e 
join ticket_sales as t 
		 on e.event_id=t.event_id group by e.event_name;



-- Find total VIP revenue per event_name. 
-- event_name 		vip_revenue
-- Food Carnival 	5000
-- Music Fest 		5000
-- Tech Summit 		6000

select e.event_name ,t.qty*t.price_per_ticket as vip_revenue 
	from ticket_sales as t 
    join events as e 
    on e.event_id=t.event_id
    where t.ticket_type="VIP" order by vip_revenue;
    
         
-- Find monthly revenue per city.
--  city 	sale_month 	total_revenue
-- Bengaluru 	2 			12000
-- Delhi 		3 			9000
-- Mumbai 		1 			12800
-- Mumbai 		2 			1200

select * from events;
select * from ticket_sales;
select e.city,
	month(t.sale_date) as sale_month,
		sum(t.qty*t.price_per_ticket) as Total_revenue
        from events as e 
			join ticket_sales as t
				on e.event_id=t.event_id 
                group by e.city, sale_month order by city;
                
                
-- Find total quantity per city and ticket_type.
 
-- city 		ticket_type 	total_qty
-- Bengaluru 	Regular 			3
-- Bengaluru 	VIP 				1
-- Delhi 		Regular 			5
-- Delhi 		VIP 				2
-- Mumbai 		Regular 			7
-- Mumbai 		VIP 				1


select e.city, t.ticket_type,sum(qty) as  total_qty 
	from events as e join ticket_sales as t 
		on e.event_id=t.event_id 
			group by city,ticket_type 
				order by city;
                

-- Find sales that happened on the latest sale_date in the table.
 
-- sale_id 	event_id 	sale_date 	ticket_type 	qty	 price_per_ticket
-- 106 			3 		2025-03-15 		VIP 		2 		2500                
        
select * from ticket_sales;
select * from ticket_sales where sale_date=(
				select max(sale_date)from ticket_sales);         
                
                
-- Find sales where revenue is greater than the overall average sale revenue.

--  sale_id 	event_id 	revenue
-- 	102 			1 		5000
-- 	103 			2 		6000
-- 	104 			2 		6000
-- 	106 			3 		5000
-- 	107 			4 		4800

select sale_id , event_id , qty * price_per_ticket as revenue 
	from ticket_sales
		where (qty*price_per_ticket) >(select avg(qty*price_per_ticket) 
										from ticket_sales);
                                        
                                        
-- Find events that have at least one VIP sale.
-- event_id 	event_name
-- 	1 			Music Fest
-- 	2 			Tech Summit
-- 	3 			Food Carnival

select e.event_id,e.event_name from events as e 
 join ticket_sales as t 
  on e.event_id=t.event_id
			where t.ticket_type="VIP";
            
		
-- Find events in cities that have at least one VIP sale. 
-- Hint: subquery will use the joins

-- event_id 	event_name 		city
-- 	1 			Music Fest 		Mumbai
-- 	2 			Tech Summit 	Bengaluru
-- 	3 			Food Carnival 	Delhi
-- 	4 			Startup Meetup 	Mumbai

select * from events;
select * from ticket_sales;
select e.event_id,e.event_name,e.city,t.ticket_type from events as e 
 join ticket_sales as t 
  on e.event_id=t.event_id
			where t.ticket_type="VIP";
            
-- using Subquery 
select event_id,event_name,city 
	from events where event_id in 
		(select distinct event_id from 
			ticket_sales where ticket_type='vip');


-- Find events that have at least one sale in February 2025.
--  event_id 	event_name 		city
-- 		2 		Tech Summit 	Bengaluru
-- 		4 		Startup Meetup 	Mumbai

select * from ticket_sales;
-- using joins
select distinct e.event_id ,e.event_name ,e.city from events as e
	 join ticket_sales as t on e.event_id=t.event_id
     where month(sale_date)=2;
     
-- using subQuery  
select event_id, event_name,city from events 
	where event_id in (select distinct event_id from ticket_sales 
					where month(sale_date)=2); 
                    

-- For each event, return the highest price_per_ticket sale row. 
-- Hint: read the question twice

-- sale_id 	event_id 	sale_date 	ticket_type 	qty 	price_per_ticket
-- 	102 		1 		2025-01-10 		VIP 		1 			5000
-- 	104 		2 		2025-02-10 		VIP 		1 			6000
-- 	106 		3 		2025-03-15 		VIP 		2 			2500
-- 	107 		4 		2025-01-20 		Regular 	4 			1200
-- 	108 		4 		2025-02-05 		Regular 	1 			1200


select * from ticket_sales as t1 
	where price_per_ticket=(select max(price_per_ticket) 
							from ticket_sales as t2 
								where t1.event_id=t2.event_id);


select * from ticket_sales where (event_id,price_per_ticket) in 
(select event_id,max(price_per_ticket) from ticket_sales group by event_id);


select * from ticket_sales 
	where price_per_ticket in 
		(select max(price_per_ticket) from 	
			ticket_sales group by event_id);
            
        --     
-- Show monthly total revenue and monthly total quantity, but only include months
-- where total revenue is at least 10,000.

--  sale_month 	total_qty 	total_revenue
-- 		1 			7 			18800
-- 		2 			5 			13200

select month(sale_date) as sale_month,sum(qty),
	sum(qty*price_per_ticket) as total_revenue 
		from ticket_sales 
			group by sale_month 
				having total_revenue >=10000 ; 
                
                
-- Show month-wise count of sales rows, but only include months that have at least 3
-- sales rows. 

-- sale_month 	sales_rows
-- 		2 			3

select * from ticket_sales;
select month(sale_date) as sale_month, 	
		count(*) as sale_rows 
			from ticket_sales
				group by sale_month 
					having sale_rows >=3;
                    
-- Show average revenue per sale row per month, but only include months where
-- average sale revenue is above 4000.

-- 	sale_month 	avg_sale_revenue
-- 		1 			6266.6667
-- 		2 			4400

select * from ticket_sales order by month(sale_date);
select month(sale_date) as sale_month,
	avg(qty*price_per_ticket) as sale_revenue from ticket_sales
    group by sale_month 
    having sale_revenue >=4000;
    
    
-- Show revenue per month and ticket_type, but only include groups where total
-- revenue is at least 5000. 
-- sale_month 	ticket_type 	total_revenue
-- 		1 		Regular 		7800
-- 		1 		VIP 			11000
-- 		2 		Regular 		7200
-- 		2 		VIP 			6000
-- 		3 		VIP 			5000

select month(sale_date)as sale_month,
	ticket_type,sum(qty*price_per_ticket) as total_revenue 
    from ticket_sales
		group by sale_month,ticket_type
			having total_revenue >=5000;