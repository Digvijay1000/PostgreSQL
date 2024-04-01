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