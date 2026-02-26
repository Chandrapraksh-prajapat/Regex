# LeetCode SQL Practice

## 262. Trips and Users (Hard)

### Problem Summary  
Calculate daily cancellation rate for unbanned users between  
2013-10-01 and 2013-10-03.

---

### SQL Solution

```sql
SELECT
    request_at AS Day,
        ROUND(AVG(status != 'completed'), 2) AS 'Cancellation Rate'
            FROM Trips AS t
                JOIN Users AS u1 ON (t.client_id = u1.users_id AND u1.banned = 'No')
                JOIN Users AS u2 ON (t.driver_id = u2.users_id AND u2.banned = 'No')
                    WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
                GROUP BY request_at;


---

##  585. Investments in 2016 (Medium)

###  Problem Summary  
Find the sum of all `tiv_2016` values for policyholders who:

- Have the same `tiv_2015` as at least one other policyholder  
- Have unique `(lat, lon)` location  

---

###  SQL Solution

```sql
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
    FROM Insurance
    WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance
                        GROUP BY tiv_2015 HAVING COUNT(*) > 1)
                    AND (lat, lon) IN (SELECT lat, lon FROM Insurance
                                        GROUP BY lat, lon HAVING COUNT(*) = 1);



---

##  1068. Product Sales Analysis I (Easy)

###  Problem Summary  
Return product name, year, and price for each sale by joining `Sales` and `Product` tables.

---

###  SQL Solution

```sql
SELECT 
    p.product_name,
    s.year,
    s.price
FROM Sales s
INNER JOIN Product p
    ON s.product_id = p.product_id;


---

##  1075. Project Employees I (Easy)

### Problem Summary  
Find the average experience years of employees for each project, rounded to 2 decimal places.

---

###  SQL Solution

```sql
SELECT 
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project p
INNER JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY p.project_id;
