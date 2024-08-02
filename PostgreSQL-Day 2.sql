-- DAY 2 (Basic)

/* 1.WHERE 

> Used to FILTER the data in the output
> Always after FROM

Syntax: SELECT
		column_name1,
		column_name2
		FROM table_name
		WHERE condition
*/

-- To maintain accuracy while performing queries we are seting timestamp
ALTER DATABASE greencycles SET timezone TO 'Europe/Berlin';

SELECT 
* 
FROM payment
WHERE amount = 10.99;	

SELECT 
first_name,
last_name
FROM customer
WHERE first_name = 'ADAM';

-- CHALLANGE
-- 1. How many payment were made by the customer with customer_id = 100?
SELECT 
COUNT(*)
FROM payment
WHERE customer_id = 100;

-- 2. What is the last name of our customer with first name 'ERICA'?
SELECT 
last_name,
first_name
FROM customer
WHERE first_name = 'ERICA';

-- WHERE with operators (>, <, >=, <=, !=, =, is null , is not null)
SELECT
*
FROM payment
WHERE amount > 10.99;

SELECT
*
FROM payment
WHERE amount < 10.99;

SELECT
*
FROM payment
WHERE amount < 10.99
ORDER BY amount DESC;

SELECT
*
FROM payment
WHERE amount <= 10.99
ORDER BY amount DESC;

SELECT
*
FROM payment
WHERE amount >= 10.99
ORDER BY amount DESC;

SELECT
*
FROM payment
WHERE amount != 10.99;

SELECT
*
FROM payment
WHERE amount <> 10.99; -- SIMILLAR TO NOT EQUAL

SELECT
*
FROM payment
WHERE amount <= 10.99
ORDER BY amount DESC;

SELECT
first_name,
last_name
FROM customer
WHERE first_name is null;

SELECT
first_name,
last_name
FROM customer
WHERE first_name is not null;

select -- NOT CASE SENSITIVE
first_name,
last_name
FROM customer
WHERE first_name = 'ADAM'; -- CASE SENSITIVE

seLEcT -- NOT CASE SENSITIVE
first_name,
last_name
FROM customer
WHERE first_name = 'ADAM';

select
FIRst_nAme, -- NOT CASE SENSITIVE
last_name
FROM customer
WHERE first_name = 'ADAM';

select
"first_name", -- CASE SENSITIVE (allow "")
last_name
FROM customer
WHERE first_name = 'ADAM';

-- select
-- "First_name", -- CASE SENSITVE (F shound be f)
-- last_name
-- FROM customer
-- WHERE first_name = 'ADAM';

-- CHALLANGE
-- 1. The inventory manager asks you how rentals have not been returned yet (return_date is null).
SELECT 
COUNT(*)
FROM rental
where return_date is null;

-- 2. The sales manager asks you how for a list of all the payment_ids with an amount less than or equal to $2. Include payment_id and the amount
SELECT
payment_id,
amount
FROM payment
WHERE amount <=2
ORDER BY amount DESC;

/* WHERE With (AND/OR)
1. Used to connect two conditions

syntax: SELECT
		column_name1,
		column_name2
		FROM table_name
		WHERE condition1 
		AND condition2
		AND condition3
		
		NOTE: ALL conditions must be true!
*/

-- Example
SELECT
*
FROM payment
WHERE amount = 10.99
AND customer_id = 426;

SELECT
*
FROM payment
WHERE amount = 10.99
OR amount = 9.99;

-- SELECT
-- *
-- FROM payment
-- WHERE amount = 10.99 OR 9.99 -- Not Allowed

SELECT
*
FROM payment
WHERE amount = 10.99
OR amount = 9.99
AND customer_id = 426; -- not working well

SELECT
*
FROM payment
WHERE (amount = 10.99
OR amount = 9.99)
AND customer_id = 426;

SELECT
*
FROM payment
WHERE amount = 10.99
OR (amount = 9.99
AND customer_id = 426);

-- CHALLENGE
-- 1. The suppcity manager asks you about a list of all the payment of 
-- the customer 322, 346 and 354 where the amount is either less 
-- than $2 or greater than $10.
-- It should be ordered by the customer first (ascending) and then 
-- as second condition order by amount in a descending order
SELECT 
* 
FROM payment
WHERE 
(customer_id = 322 OR customer_id = 346 OR customer_id = 354)
AND 
(amount <2 OR amount >10)
ORDER BY customer_id ASC, amount DESC; 

-- 2. BETWEEN … AND …
-- Used to filter a range of values

SELECT
payment_id,
amount
FROM payment
WHERE amount NOT BETWEEN 1.99 AND 6.99;

SELECT
payment_id,
amount
FROM payment
WHERE amount BETWEEN 1.99 AND 6.99;

SELECT
payment_date,
payment_id,
amount
FROM payment
WHERE payment_date BETWEEN '2020-01-24' AND '2020-01-26';

SELECT
payment_date,
payment_id,
amount
FROM payment
WHERE payment_date BETWEEN '2020-01-24 0:00' AND '2020-01-26 0:00';

SELECT
payment_date,
payment_id,
amount
FROM payment
WHERE payment_date BETWEEN '2020-01-24 0:00' AND '2020-01-26 12:00';

-- Challange
/* There have been 6 complaints of customers about their payments!
customer_id: 12,25,67,93,124,234

The concerned payments are all the payments of these 
customers with amounts 4.99, 7.99 and 9.99 in January 2020.

Write a SQL query to get a list of the concerned payments! 
Result
It should be 7 
*/
SELECT 
*
FROM payment
WHERE 
(customer_id = 12 OR customer_id = 25 OR customer_id = 67 OR
customer_id = 93 OR customer_id = 124 OR customer_id = 234)
AND
(amount = 4.99 OR amount = 7.99 OR amount = 9.99)
AND
(payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59');


/*
There have been some faulty payments and you need to help to found out how many payments have been affected.
How many payments have been made on January 26th and 27th
2020 (including entire 27th) with an amount between 1.99 and 3.99? 

Write a SQL query to get the answers!
*/ 
SELECT * FROM PAYMENT;

SELECT
COUNT(*) 
FROM payment
WHERE 
(payment_date BETWEEN '2020-01-26' AND '2020-01-26 23:59')
AND
(amount BETWEEN 1.99 AND 3.99);

/* 3. IN Operator
1. Used to give long list of values/parameters
*/
SELECT * FROM customer
WHERE customer_id IN (123,212,323,243,353,432);

SELECT * FROM customer
WHERE first_name IN ('LYDIA', 'MATTHEW');

SELECT * FROM customer
WHERE first_name NOT IN ('LYDIA', 'MATTHEW');

-- Challange
/* There have been 6 complaints of customers about their payments!
customer_id: 12,25,67,93,124,234
The concerned payments are all the payments of these 
customers with amounts 4.99, 7.99 and 9.99 in January 2020.
Write a SQL query to get a list of the concerned payments! 
Result
It should be 7 
*/
SELECT 
*
FROM payment
WHERE 
customer_id IN (12,25,67,93,124,234)
AND
amount IN (4.99, 7.99, 9.99)
AND
payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59';


/* 4. LIKE Operator

✓ Used to filter by matching against a pattern
✓ Use wildcards: _ any single character
✓ Use wildcards: % any sequence of characters
*/

-- Example
SELECT 
* 
FROM actor
WHERE first_name LIKE 'A%'; -- CASE SENSITIVE

SELECT 
first_name
FROM actor
WHERE first_name LIKE 'a%';

SELECT 
first_name
FROM actor
WHERE first_name ILIKE 'a%'; -- ILKIE IS CASE INSENSITIVE

SELECT 
first_name
FROM actor
WHERE first_name LIKE '_A%';

SELECT
first_name
FROM actor
WHERE first_name LIKE 'A_'; -- >> AL

SELECT
first_name
FROM actor
WHERE first_name LIKE '__A%'; -- >> 3rd Character A

SELECT
first_name
FROM actor
WHERE first_name LIKE '%A%'; -- >> NO A appearing

SELECT
first_name
FROM actor
WHERE first_name NOT LIKE '%A%'; -- >> NO A appearing

SELECT *
FROM film
WHERE description LIKE '%Drama%';

SELECT *
FROM film
WHERE description LIKE '%Drama%'
AND
title LIKE 'T%';

-- CHALLENGE
/* You need to help the inventory manager to find out:
How many movies are there that contain the "Documentary" in 
the description?
Write a SQL query to get the answers! */
SELECT * FROM FILM;

SELECT COUNT(*) 
FROM FILM
WHERE DESCRIPTION LIKE '%Documentary%';

/*
How many customers are there with a first name that is 
3 letters long and either an 'X' or a 'Y' as the last letter in the last 
name?
*/
SELECT * FROM CUSTOMER;

SELECT COUNT(*)
FROM CUSTOMER
WHERE FIRST_NAME LIKE '___' 
AND 
(LAST_NAME LIKE '%X' OR LAST_NAME LIKE '%Y');


/* 5. Commenting & Aliases

1. Comment to make code more readable & understandable
2. Use -- Single line comment
3. Use /*[…]*/ Multiple lines comment

*/

-- EXAMPLE
-- 2020/07/01 by Nikolai
-- Query that filters amount
SELECT
*
FROM payment
WHERE amount = 10.99;

SELECT
*
FROM payment
WHERE amount = 10.99;
--AND customer_id = 426;

SELECT
*
FROM payment;
--WHERE amount = 10.99
--AND customer_id = 426;

SELECT
*
FROM payment;
/*WHERE amount = 10.99
AND customer_id = 426*/

-- CHALLANGE FOR TODAY
/* 
1.  How many movies are there that contain 'Saga' 
in the description and where the title starts either 
with 'A' or ends with 'R'?
Use the alias 'no_of_movies'
*/
SELECT * FROM film;

SELECT 
COUNT(*) as number_of_movies
FROM film 
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%'
OR title LIKE '%R');

/*
2.Create a list of all customers where the first name contains 
'ER' and has an 'A' as the second letter.
Order the results by the last name descendingly.  
*/
SELECT * FROM CUSTOMER;

SELECT 
* 
FROM CUSTOMER
WHERE (first_name LIKE '%ER%' AND first_name LIKE '_A%')
ORDER BY last_name DESC;
	   
/*
3.  How many payments are there where the amount is either 0 
or is between 3.99 and 7.99 and in the same time has 
happened on 2020-05-01.
*/
SELECT * FROM payment;

SELECT 
COUNT(*)
FROM payment
WHERE (amount = 0 
OR amount BETWEEN 3.99 AND 7.99)
AND payment_date BETWEEN  '2020-05-01' AND '2020-05-02';



/*
4. How many distinct last names of the 
customers are there?
*/
SELECT 
COUNT(DISTINCT last_name)
FROM customer;

