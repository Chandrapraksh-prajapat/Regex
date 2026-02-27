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


---

## ✅ 1141. User Activity for the Past 30 Days I (Easy)

### 📝 Problem Summary  
Find the daily active users for a period of 30 days ending on 2019-07-27 (inclusive).  
A user is considered active if they made at least one activity on that day.

---

### 💡 SQL Solution

```sql
SELECT 
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;



---

## ✅ 1148. Article Views I (Easy)

### 📝 Problem Summary  
Find all authors who viewed at least one of their own articles.  
Return the result sorted by id in ascending order.

---

### 💡 SQL Solution

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;



---

## ✅ 1179. Reformat Department Table (Easy)

### 📝 Problem Summary  
Reformat the table so that each department id has separate revenue columns for each month (Jan to Dec).

---

### 💡 SQL Solution

```sql
SELECT
    id,
    SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
    SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
    SUM(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
    SUM(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
    SUM(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
    SUM(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
    SUM(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
    SUM(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
    SUM(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
    SUM(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
    SUM(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
    SUM(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;
