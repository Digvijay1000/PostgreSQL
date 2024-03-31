-- DAY 3

/* 1. Aggregation Functions

> Aggregate values in multiple rows to one value
> Most Common agggregation functions
		SUM()
		AVG()
		MIN()
		MAX()
		COUNT()
> Syntax:
		SELECT 
		COUNT(*)
		FROM payment
		
		NOTE : What we cant't do 
		SELECT
		SUM(amount)
		payment_id -- this can not do in aggregation
		FROM payment
*/

-- Example
SELECT 
COUNT(*)
FROM payment;

/*SELECT 
SUM(amount),
payment_id -- THIS IS NOT POSSIBLE LOGICALLY FOR AGGREGATION BUT POSSIBLE WITH GROUPING
FROM payment;*/

-- multiple aggregation is possible!
SELECT 
SUM(amount),
COUNT(*),
AVG(amount)
FROM payment;

SELECT 
ROUND(AVG(amount),2) -- allow only ytwo digit after decimal
FROM payment;

SELECT 
ROUND(AVG(amount),4) AS Agerage
FROM payment;

-- Challenge
/*
Your manager wants to get a better understanding of the films. 
That's why you are asked to write a query to see the
• Minimum
• Maximum
• Average (rounded)
• Sum
of the replacement cost of the films.
Write a SQL query to get the answers!
*/
SELECT 
MIN(replacement_cost),
MAX(replacement_cost),
ROUND(AVG(replacement_cost),2) AS Average,
SUM(replacement_cost)
FROM film;

/* 2. GROUP BY
 > Used to GROUP aggregations BY specific columns
 > GROUP BY can use always after FROM or WHERE clause
SYNTAX:
        SELECT
		customer_id,
		SUM(amount)
		FROM payment
		GROUP BY customer_id
*/

--Example
SELECT 
customer_id,
sum(amount)
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

SELECT 
customer_id,
sum(amount)
from payment
where customer_id > 3
group by customer_id
order by customer_id;

-- Every column in GROUP BY or in aggregate function
SELECT 
customer_id,
sum(amount),
MAX(AMOUNT)
from payment
group by customer_id
ORDER BY SUM(AMOUNT) DESC;

-- CHALLENGE
/*
1. Your manager wants to which of the two employees (staff_id) is responsible for more payments? 
Which of the two is responsible for a higher overall payment amount?
*/
SELECT
staff_id,
SUM(amount) AS total_amount,
COUNT(*) AS overall_payment_count
FROM payment
GROUP BY staff_id
ORDER BY total_amount DESC;


/*
2. How do these amounts change if we don't consider amounts equal to 0?
*/
SELECT 
staff_id,
SUM(AMOUNT) AS TOTAL_AMOUNT,
COUNT(*) AS TOTAL_AMOUNT_COUNT
FROM PAYMENT
WHERE AMOUNT != 0
GROUP BY STAFF_ID
ORDER BY TOTAL_AMOUNT DESC;

-- GROUP BY MUTIPLE COLUMNS
SELECT
staff_id,
customer_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY COUNT(*) DESC;

SELECT
staff_id,
rental_id,
SUM(amount),
COUNT(*)
FROM payment
GROUP BY staff_id, rental_id
ORDER BY COUNT(*) DESC;


-- Challange GROUP BY MULTIPLE COLUMNS
/*
There are two competitions between the two employees.

Which employee had the highest sales amount in a single day?

Which employee had the most sales in a single day (not 
counting payments with amount = 0?
*/
SELECT 
DATE(payment_date),
staff_id,
sum(amount) as sales_amount,
count(*)
from payment
where amount != 0
group by staff_id, DATE(payment_date)
order by sales_amount desc;

/* 3. HAVING
> Used to FILTER Groupings BY aggregations 
> Note!
HAVING an only be used 
with GROUP BY!

SYANTAX : 
		SELECT
		customer_id,
		SUM(amount)
		FROM payment
		GROUP BY customer_id
		HAVING SUM(amount)>200
*/
SELECT
customer_id,
SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount)>200;

--CHALLENGE
/*
In 2020, April 28, 29 and 30 were days with very high revenue.
That's why we want to focus in this task only on these days 
(filter accordingly).

Find out what is the average payment amount grouped by customer and day – consider only the days/customers with 
more than 1 payment (per customer and day). Order by the average amount in a descending order. 
*/
SELECT 
customer_id,
DATE(payment_date),
ROUND(AVG(amount),2) as avg_amount,
COUNT(*)
FROM payment
WHERE DATE(payment_date) IN ('2020-04-28', '2020-04-29', '2020-04-30')
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*)>1
ORDER BY avg_amount DESC




