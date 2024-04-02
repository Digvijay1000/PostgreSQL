-- DAY-4 (Intermdediate)
-- 1. Functions >> LENGTH, LOWER, UPPER
-- No need to remind all the functions just go to postgresql.org and search
SELECT 
UPPER(email) AS email_upper,
LOWER(email) AS email_lower,
LENGTH(email) AS email_length,
email -- will dispaly as original
FROM customer
WHERE LENGTH(email) < 30;

-- Challenge 
/*
In the email system there was a problem with names where either the first name 
or the last name is more than 10 characters long.
Find these customers and output the list of these first and last names in all lower case.
*/
SELECT
LOWER(first_name),
LOWER(last_name),
LOWER(email)
FROM customer
WHERE LENGTH(first_name)>10 OR LENGTH(last_name)>10
ORDER BY first_name, last_name;

-- 2. Functions >> LEFT & RIGHT
-- EXAMPLE
-- display last 2 letters
SELECT 
RIGHT(first_name,2),
first_name
FROM customer;

-- display first 2 letters
SELECT
LEFT(first_name,2),
first_name
FROM customer;

-- display second letter from left
SELECT
RIGHT(LEFT(first_name,2),1),
first_name
FROM customer;

-- display second last letter 
SELECT 
LEFT(RIGHT(first_name,2),1),
first_name
FROM customer;

-- CHALLENGE
/*
1. Extract the last 5 characters of the email address first. 
   The email address always ends with '.org'.

2. How can you extract just the dot '.' from the email address?
*/
-- Extract the last 5 characters of the email address first.
SELECT
email,
RIGHT(email,5) 
FROM CUSTOMER;

-- How can you extract just the dot '.' from the email address?
SELECT
LEFT(RIGHT(email,4),1)
FROM customer;

-- 3. Functions >> CONCATINATE
SELECT
first_name,
last_name,
LEFT(first_name,1) || '.' || LEFT(last_name,1)
FROM customer;

-- CHALLEGNE
/*
You need to create Anonymized version of email addresses,
It should be first character is followed by '***' and then the last part of string with "@"
"M***@sakilacustomer.org"
*/
SELECT 
email,
LEFT(email,1) || '***' || RIGHT(email,19)
FROM customer;


-- 4. Functions >> POSITION
-- find the position of "@" in every email
SELECT
POSITION('@' IN email),
email
FROM customer;

-- position function using as value in LEFT and RIGHT function
SELECT
email,
LEFT(email,POSITION('@' IN email))
FROM customer;

-- we can remove character by using position
SELECT
email,
LEFT(email,POSITION('@' IN email)-1)
FROM customer;

-- display first character of last name along with first name
SELECT
email,
LEFT(email, POSITION(last_name IN email))
FROM customer;

-- CHALLAENGE
/*
In this challenge you have only the email address and the last 
name of the customers.

You need to extract the first name from the email address and 
concatenate it with the last name. It should be in the form: 
"Last name, First name".
*/
SELECT
last_name || ', ' || LEFT(email,POSITION('.' IN email)-1) 
FROM customer;

/* 5. Function >> SUBSTRING
> Used to EXTRACT a SUBSTRING from a string

> syntax:
		SUBSTRING(string from start [for length])
		
		> string - column / string that we want to extract from
		> start - Position, Where to start from?
		> length - Length, How many characters?
*/

SELECT 
email,
SUBSTRING(email from 2 for 3)
from customer;

SELECT 
email,
SUBSTRING(email from position('.' in email)+1 for 3 )
FROM customer;

SELECT 
email,
SUBSTRING(email from position('.' in email)+1 for LENGTH(last_name) )
FROM customer;

-- LENTH >> POSITION('@' IN email)-POSITION('.' IN email)
SELECT 
email,
SUBSTRING(email from position('.' in email)+1 for POSITION('@' IN email)-POSITION('.' IN email)-1 )
FROM customer;

-- CHALLANGE 
/*
1, You need to create an anonymized form of the email addresses
in the following way: "M***.S***@sakilacustomer.org"
*/
SELECT
email,
LEFT(first_name,1) 
|| '***' 
|| SUBSTRING(email FROM POSITION('.' IN email) for 2) 
|| '***' 
|| SUBSTRING(email FROM POSITION('@' IN email))
FROM customer;

/*
2. In a second query create an anonymized form of the email 
addresses in the following way:  "***Y.S***@sakilacustomer.org"
*/
SELECT
email, 
'***' 
|| SUBSTRING(email FROM POSITION('.' IN email)-1 FOR 3) 
|| '***' 
|| SUBSTRING(email FROM POSITION('@' IN email))
FROM customer;

/* 6. Function >> EXTRACT
> Used to EXTRACT parts of timestamp/date

> Date/time types
 1. date > Just date without time 
 		   example - '2022-11-28'
		   
 2. time (with/without time zone) > Just time without date 
 		   example - '01:02:03.678'
		   
 3. timestamp (with/without time zone) > Date and time 
           example - '2022-11-28 01:02:03.678+02'
		   
 4. intervals > Time interval 
 		   example - '3 days 01:02:03.678
		   
> Syntax : EXTRACT (field from date/time/interval)
   		  ..........................................
          field - Part of date/time
          date/time/interval - Date/time that we want to extract from
		  ...........................................................
		  
> 	Field - Extract from timestamp/date

	CENTURY - century
  * DAY  - day of month (1-31)
	DECADE - decade that is year divided by 10
  * DOW - day of week Sunday (0) to Saturday (6)
  * DOY - day of year that ranges from 1 to 366
	EPOCH - number of seconds since 1970-01-01 00:00:00 UTC
  * HOUR - hour (0-23)
	ISODOW - day of week based on ISO 8601 Monday (1) to Sunday (7)
	ISOYEAR  - ISO 8601 week number of year
	MICROSECONDS - seconds field, including fractional parts, multiplied by 1000000
	MILLENNIUM - millennium
	MILLISECONDS - seconds field, including fractional parts, multiplied by 1000
  * MINUTE  - minute (0-59)
  * MONTH - month (1-12)
  * QUARTER - quarter of year
  * SECOND - second
	TIMEZONE - timezone offset from UTC, measured in seconds
	TIMEZONE_HOUR - hour component of time zone offset
	TIMEZONE_MINUTE - minute component of time zone offset
  * WEEK - number of ISO 8601 week-numbering week of year
  * YEAR - year

*/

-- Example 
SELECT
rental_date,
EXTRACT(DAY FROM rental_date)
FROM rental;

SELECT 
-- rental_date,
EXTRACT(MONTH FROM rental_date)
FROM rental;

SELECT
EXTRACT(DAY FROM rental_date),
COUNT(*)
FROM rental
GROUP BY EXTRACT(DAY FROM rental_date)
ORDER BY COUNT(*) DESC;

-- CHALLENGE
/*
You need to analyze the payments and find out the following:
▪ What's the month with the highest total payment amount?
▪ What's the day of week with the highest total payment amount?
(0 is Sunday)
▪ What's the highest amount one customer has spent in a week?
*/
-- What's the month with the highest total payment amount?
SELECT * FROM payment;

SELECT
EXTRACT(month from payment_date) as month,
SUM(amount) AS total_payment_amount
FROM payment
GROUP BY month
ORDER BY total_payment_amount DESC;

-- What's the day of week with the highest total payment amount? 
-- (0 is Sunday)
SELECT * FROM payment;

SELECT
EXTRACT(DOW FROM payment_date) AS day_of_week,
SUM(amount) AS highest_total_payment
FROM payment
WHERE amount != 0 
GROUP BY day_of_week
ORDER BY highest_total_payment DESC;

-- What's the highest amount one customer has spent in a week?
SELECT
customer_id,
EXTRACT(WEEK FROM payment_date) as week,
SUM(amount) as total_payment_amount
FROM payment
GROUP BY week, customer_id
ORDER BY total_payment_amount DESC;

/* 7. Function >> TO_CHAR
> Used to get custom formats timestamp/date/numbers

> syntax:
		TO_CHAR (date/time/interval/number, format)
*/
-- EXAMPLE
SELECT * FROM rental;

SELECT
TO_CHAR(rental_date, 'MM-YYYY')
FROM rental;

SELECT
TO_CHAR(rental_date, 'MM-YYYY')
FROM rental;











