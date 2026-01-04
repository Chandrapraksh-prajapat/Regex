
-- if (condintin ,true, false)  
select count(*),
case 
	when population>100000 then 'Large population'
	when population>50000 then 'Medium population'
	when population>8000 then 'small population'
	else 'Very small'
end as 'status' from world.country
group by status;


select continent,
count(case 
		when population >=50000 then 1 else 0 
        end) from world.country
        group by continent;
        
        
        