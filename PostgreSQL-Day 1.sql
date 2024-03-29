-- Day 1

/* 1. SELECT 

1. Most Basic Statement SQL
2. Used to SELECT and Return Data

syntax:  SELECT 
		 column_name
		 FROM table_name
*/

-- Example single column
SELECT 
first_name
FROM actor

-- Example Multiple column
SELECT 
first_name,
last_name
FROM actor

-- All columns
SELECT 
*
FROM actor

-- while writing query Formatting doesn't matter!

-- Challenge 
/*Your first day as a Data Analyst has started!
The Marketing Manager asks you for a list of all customers. 
With first name, last name and the customer's email address.
*/
SELECT 
first_name,
last_name,
email
FROM customer

-- 2. ORDER BY 
/*
1.  Used to order results based on a column
2.  Alphabetically, numerically, chronologically etc

SYNTAX : SELECT
		 column_name1,
		 column_name2,
		 FROM table_name
		 ORDER BY column_name1
*/

-- Example 
SELECT 
first_name,
last_name
FROM actor
ORDER BY first_name

-- Example DESC/ASC
SELECT
first_name,
last_name
FROM actor
ORDER BY first_name DESC

SELECT
first_name,
last_name
FROM actor
ORDER BY first_name ASC

-- Multiple Columns
SELECT
first_name,
last_name
FROM actor
ORDER BY first_name, last_name

-- Multiple columns ASC/DESC
SELECT
first_name,
last_name
FROM actor
ORDER BY first_name DESC, last_name

/* 3. SELECT DISTINCT

1. Used to SELECT the DISTINCT values in a table

Syntax : SELECT DISTINCT
		 column_name
		 FROM table_name
*/

-- Example
SELECT DISTINCT
first_name
FROM actor

SELECT DISTINCT
first_name
FROM actor
ORDER BY first_name

-- Example Multiple columns
SELECT DISTINCT
first_name,
last_name
FROM actor
ORDER BY first_name

SELECT
first_name,
last_name
FROM actor
ORDER BY first_name, last_name

-- Challange
/*
A marketing team member asks you about the different prices that have been paid.
Write a SQL query to get the different prices! Result To make it easier for them order the prices from 
high to low.
*/
SELECT DISTINCT 
amount
FROM payment
ORDER BY amount DESC

/* 4.LIMIT

✓ Used to LIMIT the number of rows in the output
✓ Always at the very end of your query
✓ Can help to get a quick idea about a table

Syntax :    SELECT
			column_name1,
			column_name2
			FROM table_name
			LIMIT n
*/

-- Example 
SELECT
first_name
FROM actor
LIMIT 4

SELECT
first_name
FROM actor
ORDER BY first_name
LIMIT 4

-- Multiple columns
SELECT DISTINCT
first_name, -- Note: Distinct in terms of all selected columns!
last_name
FROM actor
ORDER BY first_name
LIMIT 9

/* 5. COUNT

✓ Used to COUNT the number of rows in a output
✓ Used often in combination with grouping & filtering

syntax : SELECT
		 COUNT(*)
		 FROM table_name
		 
		 SELECT
         COUNT(column_name)
         FROM table_name
		 
		 Note! Nulls will not be counted in that case!
*/

-- Example 
SELECT
COUNT(first_name)
FROM actor

SELECT
COUNT(*)
FROM actor

SELECT
COUNT(DISTINCT first_name)
FROM actor

-- Distinct in terms of all selected columns!
SELECT DISTINCT
first_name,
last_name
FROM actor
ORDER BY first_name

-- Challange for Today 
-- 1. Create a list of all the distinct districts customers are from.
SELECT DISTINCT 
district
FROM address

-- 2. What is the latest rental date?
SELECT
rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 1

-- 3. How many films does the company have?
SELECT
COUNT(*)
FROM film

-- 4. How many distinct last names of the customers are there?
SELECT 
COUNT(DISTINCT last_name)
FROM customer

/*5. You need to help the Marketing team to work more easily.
The Marketing Manager asks you to order the customer list 
by the last name.
The want to start from "Z" and work towards "A".
Write a SQL query to get that list!
In case of the same last name the order should be based on
the first name – also from "Z" to "A"*/
SELECT 
last_name,
first_name
FROM customer
ORDER BY last_name DESC, first_name
