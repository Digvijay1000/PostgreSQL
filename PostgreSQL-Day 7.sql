-- DAY 7 (Adavnced) - UNION & Subqueries
/* 1. UNION
> Combining multiple select statements

> Syntax: 
		SELECT first_name, sales FROM vancouver
		UNION
		SELECT first_name, sales FROM delhi
		
> 3 Things to remember!
	    1. Columns are matched by order of columns & No. of columns must match
		2. Data Type must match
		3. Duplicates are decoupled/sepearete (If we want, we should use UNION ALL insted of UNION)
*/
-- Example
SELECT first_name FROM actor
UNION
SELECT first_name FROM customer
ORDER BY first_name;

-- duplicates are also present wih notation of table name
SELECT first_name, 'actor' FROM actor
UNION ALL
SELECT first_name, 'customer' FROM customer
ORDER BY first_name;

SELECT first_name, 'actor' as origin FROM actor
UNION 
SELECT first_name, 'customer' as test1 FROM customer
UNION
SELECT UPPER(first_name), 'staff' as staff FROM staff
ORDER BY 2 DESC;

/* 2. Subqueries in WHERE
> Subqueries always enclosed with parenthesis
*/
SELECT 
* 
FROM payment
WHERE amount > 4.2006673312979002; -- AVG(amount)

-- SO for avoiding the double work we use subqueries
SELECT 
* 
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);

-- findout specific customer details
SELECT 
* 
FROM payment
WHERE customer_id = (SELECT customer_id FROM customer
					WHERE first_name LIKE 'ADAM');
-- 
SELECT 
* 
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer
					WHERE first_name LIKE 'A%');	
					
-- CHALLANGE
-- 1. Select all of the films where length is longer than average of all films
SELECT 
film_id,
title
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 2. Return all the films that are available in the inventory in store 2 more than 3 times
SELECT film_id, title FROM film 
WHERE film_id 
IN
(SELECT film_id FROM inventory
WHERE store_id = 2
GROUP BY film_id
HAVING COUNT(*) > 3);

-- 3. Return ALL customers first names and last names that have made a payment on 2020-01-25
SELECT first_name, last_name 
FROM customer 
WHERE customer_id IN 
                 (SELECT customer_id 
				  FROM payment
                  WHERE TO_CHAR(payment_date,  'YYYY-MM-DD') = '2020-01-25');
				         -- DATE(payment_date)='2020-01-25'

-- 4. Return all customers first_names and email addresses that have spent a more than $30 
SELECT first_name, email 
FROM customer 
WHERE customer_id IN 
				(SELECT customer_id 
				 FROM payment 
				 GROUP BY customer_id
                 HAVING SUM(amount) > 30);

-- 5. Return all the customers first and last names that are from california and have spent more than 100 in total
SELECT first_name, last_name 
FROM customer 
WHERE customer_id IN 
				(SELECT customer_id 
				 FROM payment 
				 GROUP BY customer_id
                 HAVING SUM(amount) > 100)
AND customer_id IN (SELECT customer_id
				   FROM customer
				   INNER JOIN address
				   ON address.address_id = customer.address_id
				   WHERE district = 'California');		
		