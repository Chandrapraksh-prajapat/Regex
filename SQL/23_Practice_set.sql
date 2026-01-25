CREATE TABLE drivers (
  driver_id   INT PRIMARY KEY,
  driver_name VARCHAR(50) NOT NULL,
  base_area   VARCHAR(50) NOT NULL
);

CREATE TABLE trips (
  trip_id      INT PRIMARY KEY,
  driver_id    INT NOT NULL,
  trip_date    DATE NOT NULL,
  distance_km  DECIMAL(5,1) NOT NULL,
  fare         INT NOT NULL,
  rating       DECIMAL(3,1) NOT NULL,
  CONSTRAINT fk_trips_driver
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);


INSERT INTO drivers (driver_id, driver_name, base_area) VALUES
(1, 'Asha',  'Indiranagar'),
(2, 'Ravi',  'Koramangala'),
(3, 'Meera', 'Whitefield'),
(4, 'Kabir', 'HSR Layout');

INSERT INTO trips (trip_id, driver_id, trip_date, distance_km, fare, rating) VALUES
(101, 1, '2025-11-01', 12.0, 350, 4.8),
(102, 1, '2025-11-02',  5.5, 180, 4.6),
(103, 2, '2025-11-01',  8.0, 260, 4.9),
(104, 2, '2025-11-03', 15.0, 500, 4.7),
(105, 3, '2025-11-02',  3.0, 120, 4.2),
(106, 3, '2025-11-04', 22.0, 780, 4.9),
(107, 4, '2025-11-01',  6.0, 210, 4.5),
(108, 4, '2025-11-03',  9.0, 300, 4.4),
(109, 4, '2025-11-04',  4.0, 150, 4.8),
(110, 1, '2025-11-04', 18.0, 620, 4.9);


-- 1. For each trip_date, show number of trips, total fare, and average rating. 
-- trip_date 	trips_count 	total_fare 	avg_rating
-- 2025-11-01 		3 				820 	4.733333
-- 2025-11-02 		2 				300 	4.400000
-- 2025-11-03 		2 				800 	4.550000
-- 2025-11-04 		3 				1550 	4.866667

select trip_date,count(trip_id) as trip_count, 
	sum(fare) as total_fare,avg(rating) as avg_rating
    from trips group by trip_date;
    
    
-- 2. By base_area, show total trips, total fare, and average distance.
--  base_area 	trips 	total_fare 		avg_distance
-- 	HSR Layout	 3 			660 		6.333333
-- 	Indiranagar	 3 			1150 		11.833333
-- 	Koramangala	 2 			760 		11.500000
-- 	Whitefield 	 2 			900 		12.500000-- 

select d.base_area, count(trip_id) as trips, 
 sum(fare) as total_fare, avg(distance_km) as avg_distance
    from trips as t 
		join drivers as d 
			on d.driver_id = t.driver_id 
				group by base_area 
					order by base_area;
                    
                    
-- Days where total fare >= 800 (GROUP BY + HAVING)
-- trip_date 	total_fare
-- 2025-11-01	 820
-- 2025-11-03 	 800
-- 2025-11-04 	 1550
select * from trips;
select trip_date , sum(fare)as total_fare from trips 
group by trip_date having total_fare >=800;


-- Base-area average rating, only areas with avg rating >= 4.7 (HAVING)
-- base_area 	avg_rating
-- Indiranagar 	4.766667
-- Koramangala	4.800000
-- Whitefield 	4.550000

select d.base_area,	avg(rating) as avg_rating 
	from drivers as d
	join trips as t 
		on d.driver_id = t.driver_id 
        group by base_area
		having avg_rating >=4.7;
        
        
-- Trips with fare greater than the overall average fare (single-row subquery)
-- trip_id 	driver_id 	fare
-- 101 			1 		350
-- 104 			2 		500
-- 106 			3 		780
-- 110 			1 		620
select trip_id,driver_id,fare from trips where fare >
(select avg(fare) from trips) ;


-- Drivers who have at least one trip rated 4.9 (multi-row IN subquery)
-- driver_id 	driver_name
-- 	1 			Asha
-- 	2 			Ravi
-- 	3 			Meera

select * from drivers;
select * from trips;

select d.driver_id,d.driver_name 
	from drivers as d
		where driver_id in (select driver_id from trips 
							where rating=4.9);
                            

-- Drivers whose total fare is greater than the average total fare per driver
-- Hint: (subquery on aggregated derived table) Hard level

-- driver_id 	driver_name 	total_fare
-- 	1 				Asha 		1150
-- 	3 				Meera 		900

select * from trips;
select d.driver_name, sum(fare) as total_fare 
	from drivers as d join trips as t 
    on d.driver_id=t.driver_id
    group by driver_name;


-- Latest trip per driver
-- driver_id 	trip_id 	trip_date 	fare
-- 	1 			110 		2025-11-04 	620
-- 	2 			104 		2025-11-03 	500
-- 	3 			106 		2025-11-04 	780
-- 	4 			109 		2025-11-04 	150

select driver_id,trip_id,trip_date,fare 
	from trips where (driver_id,trip_date)in(
											select driver_id,max(trip_date) as trip_date 
											from trips group by driver_id)
												order by driver_id;
                                                
										
                                        
-- Row number of trips per driver ordered by date (then trip_id)
-- driver_id 	trip_id 	trip_date 	rn
-- 		1 		101 	2025-11-01 		1
-- 		1 		102 	2025-11-02 		2
-- 		1 		110 	2025-11-04 		3
-- 		2 		103 	2025-11-01 		1
-- 		2 		104 	2025-11-03 		2
-- 		3 		105 	2025-11-02 		1
-- 		3 		106 	2025-11-04 		2
-- 		4 		107 	2025-11-01 		1
-- 		4 		108 	2025-11-03 		2
-- 		4 		109 	2025-11-04 		3

select driver_id,trip_id,trip_date ,
 row_number() over(partition by driver_id order by trip_date,trip_id)
 from trips;
 
 
-- Running total fare per driver over time

-- driver_id 	trip_id	 trip_date 	fare 	running_fare
-- 	1 			101 	2025-11-01 	350 	350
-- 	1 			102 	2025-11-02 	180 	530
-- 	1 			110 	2025-11-04 	620 	1150
-- 	2 			103 	2025-11-01 	260 	260
-- 	2 			104 	2025-11-03 	500 	760
-- 	3 			105 	2025-11-02 	120 	120
-- 	3 			106 	2025-11-04 	780 	900
-- 	4 			107 	2025-11-01 	210 	210
-- 	4 			108 	2025-11-03 	300 	510
-- 	4 			109 	2025-11-04 	150 	660

select * from drivers;
select * from trips;

select driver_id,trip_id, trip_date,fare , sum(fare)
	over(partition by driver_id order by trip_date,trip_id)
    as running_fare from trips;
    
    
    
-- Rank trips by fare within each driver (highest fare rank 1)
-- driver_id trip_id fare fare_rank
-- 1 110 620 1
-- 1 101 350 2
-- 1 102 180 3
-- 2 104 500 1
-- 2 103 260 2
-- 3 106 780 1
-- 3 105 120 2
-- 4 108 300 1
-- 4 107 210 2
-- 4 109 150 3

select driver_id,trip_id,fare,
rank() over(partition by driver_id order by fare desc) as fare_rank from trips;


-- Show each trip’s fare minus the driver’s average fare (window AVG)
-- driver_id 	trip_id 	fare 	diff_from_avg
-- 		1 		101 		350 	-33.333
-- 		1 		102 		180 	-203.333
-- 		1 		110 		620 	236.667
-- 		2 		103 		260 	-120.000
-- 		2 		104 		500 	120.000
-- 		3 		105 		120 	-330.000
-- 		3 		106 		780 	330.000
-- 		4 		107 		210 	-10.000
-- 		4 		108 		300 	80.000
-- 		4 		109 		150 	-70.000

select driver_id, trip_id,fare, fare-avg(fare) 
	over(partition by driver_id) as diff_from_avg
    from trips;


-- For each driver, show the previous trip’s fare (LAG) ordered by date

-- driver_id trip_id trip_date fare prev_fare
-- 	1 		101 	2025-11-01 	350 	NULL
-- 	1 		102 	2025-11-02 	180 	350
-- 	1 		110 	2025-11-04 	620 	180
-- 	2 		103 	2025-11-01 	260 	NULL
-- 	2 		104 	2025-11-03 	500 	260
-- 	3 		105 	2025-11-02 	120 	NULL
-- 	3 		106 	2025-11-04 	780 	120
-- 	4 		107 	2025-11-01 	210 	NULL
-- 	4 		108 	2025-11-03 	300 	210
-- 	4 		109 	2025-11-04 	150 	300

select  driver_id ,trip_id ,trip_date, fare,
	lag(fare) over(partition by driver_id order by trip_date)
		as prev_fare from trips;