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


---

## ✅ 1251. Average Selling Price (Easy)

### 📝 Problem Summary  
Find the average selling price for each product.  
The average price should be weighted by the number of units sold.  
Return 0 if a product has no sales.

---

### 💡 SQL Solution

```sql
SELECT 
    p.product_id,
    IFNULL(
        ROUND(SUM(p.price * u.units) / SUM(u.units), 2),
        0
    ) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;



---

## ✅ 1280. Students and Examinations (Easy)

### 📝 Problem Summary  
For each student and each subject, return the number of exams attended.  
If a student did not attend an exam for a subject, return 0.

---

### 💡 SQL Solution

```sql
SELECT 
    s.student_id,
    s.student_name,
    sb.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
JOIN Subjects sb
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
    AND sb.subject_name = e.subject_name
GROUP BY s.student_id, sb.subject_name
ORDER BY s.student_id ASC, sb.subject_name ASC;




### Q. Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

----

### SQL solution :-

select patient_id,patient_name,conditions from patients where conditions like "% DIAB1%" or conditions like "DIAB1%";




### Q. Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

#### SQL solution :

select customer_id , count(visit_id) as count_no_trans from visits  where visit_id not in (select visit_id from transactions) group by customer_id;



### Q. Write a solution to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.


---

### SQL Solution :

select u.name , sum(t.amount) as BALANCE from transactions as t 
    join users as u on u.account=t.account 
        group by t.account having sum(t.amount)>10000 ;



### Q. Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.


---

#### SQL Solution -->>

select 
contest_id, 
round(count(distinct user_id) * 100 /(select count(user_id) from Users) ,2) as percentage
from  Register
group by contest_id
order by percentage desc,contest_id
