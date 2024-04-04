-- DAY 5 (Intermediate) - CONDITIONAL EXPRESSIONS

/* 1. Mathematical functions and operators
> Refrence link : https://www.postgresql.org/docs/current/functions-math.html  

>	Operator	Description			Example 	Result
		+ 		addition 			4 + 3 		  7
		- 		subtraction 		5 - 3 		  2
		*       multiplication  	4 * 2         8
		/ 		division            8 / 4         2
				(integer division 
				truncates the 
				result) 
		%       modulo (remainder)  10 % 4        2
        ^       exponentiation      2 ^ 3         8

>  SYNTAX : 
    		SUM (replacement_cost) * 2
			SUM (replacement_cost) + 1
			SUM (replacement_cost) / SUM (rental_rate)*100

> 		Function 		Description 			Example 		Result
		abs(x) 			absolute value 			abs(-7)           7
		round(x,d) 		round x to d        	round(4.3543)     4.35
		            	decimal places
		ceiling(x) 		round up to integer 	ceiling(4.3543)   5
		floor(x) 		round down to integer 	floor(4.3543) 	  4

*/

-- Example
SELECT 
film_id,
rental_rate as old_rental_rate,
ROUND(rental_rate*1.1,2) as new_rental_rate
FROM film;

-- CHALLANGE
/*
Your manager is thinking about increasing the prices for films
that are more expensive to replace.

For that reason, you should create a list of the films including the 
relation of rental rate / replacement cost where the rental rate
is less than 4% of the replacement cost.

Create a list of that film_ids together with the percentage rounded
to 2 decimal places. For example 3.54 (=3.54%)
*/
SELECT * FROM FILM;

SELECT 
film_id,
ROUND(rental_rate/replacement_cost*100, 2) as percentage
FROM film
WHERE ROUND(rental_rate/replacement_cost*100, 2) < 4
ORDER BY percentage ASC;

/* 2. CASE WHEN 

Like IF/THEN statement: 
Goes through a set of conditions returns a value if a condition is met

> Syntax :
		  CASE
		  WHEN condition1 THEN result1
		  WHEN condition2 THEN result2
		  WHEN conditionN THEN resultN
		  ELSE result
		  END
		  .............................
		  CASE - start of CASE statement
		  END - End of CASE statement
*/
-- Example 
-- SELECT 
-- amount,
-- CASE
-- WHEN amount < 2 THEN 'low amount'
-- WHEN amount < 5 THEN 'medium amount'
-- ELSE 'high amount'
-- END
-- FROM payment;

-- Example
SELECT
TO_CHAR(book_date, 'dy'),
TO_CHAR(book_date, 'Mon'),
CASE
WHEN TO_CHAR(book_date,'Dy')='Mon'THEN 'Monday special'
WHEN TO_CHAR(book_date,'Mon')='Jul' THEN 'July special' 
-- No condition met => [null]
END
FROM bookings;

SELECT
TO_CHAR(book_date,'Dy'),
TO_CHAR(book_date,'Mon'),
CASE
WHEN TO_CHAR(book_date,'Dy')='Mon'THEN 'Monday special'
WHEN TO_CHAR(book_date,'Mon')='Jul' THEN 'July special'
ELSE 'no special'
END
FROM bookings;

SELECT
total_amount,
TO_CHAR(book_date,'Dy'),
CASE
WHEN TO_CHAR(book_date,'Dy')='Mon'THEN 'Monday special'
WHEN total_amount < 30000 THEN 'Special deal'
ELSE 'no special at all'
END
FROM bookings;

SELECT
total_amount,
TO_CHAR(book_date,'Dy'),
CASE
WHEN TO_CHAR(book_date,'Dy')='Mon'THEN 'Monday special'
WHEN total_amount*1.4 < 30000 THEN 'Special deal'
ELSE 'no special at all'
END
FROM bookings;

-- Example
SELECT
actual_departure-scheduled_departure,
CASE
	WHEN actual_departure-scheduled_departure is null THEN 'no departure time	'
 	WHEN actual_departure-scheduled_departure < '00:05' THEN 'on time'
	WHEN actual_departure-scheduled_departure < '01:00' THEN 'A little bit late'
	ELSE 'very late'
END
FROM flights;

-- Example
SELECT
COUNT(*) as flights,
CASE
	WHEN actual_departure is null THEN 'no departure time	'
 	WHEN actual_departure-scheduled_departure < '00:05' THEN 'on time'
	WHEN actual_departure-scheduled_departure < '01:00' THEN 'A little bit late'
	ELSE 'very late' 
END AS is_late
FROM flights
GROUP BY is_late
ORDER BY flights;

-- CHALLANGE
/*
1. You need to find out how many tickets you have sold in the following categories:
• Low price ticket: total_amount < 20,000
• Mid price ticket: total_amount between 20,000 and 150,000 
• High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?
*/
SELECT * FROM bookings;

SELECT
COUNT(*),
CASE 
	WHEN total_amount < 20000 THEN 'Low price ticket'
	WHEN total_amount < 150000 THEN 'Mid price ticket'
	ELSE 'High price ticket'
END AS ticket_price
FROM bookings
GROUP BY ticket_price;

/*
2. You need to find out how many flights have departed in the following seasons:
• Winter: December, January, Februar
• Spring: March, April, May
• Summer: June, July, August
• Fall: September, October, November
*/
SELECT * FROM flights;

SELECT 
COUNT(*) as flights,
CASE
    WHEN EXTRACT (month from scheduled_departure) IN (12,1,2) THEN 'Winter'
    WHEN EXTRACT (month from scheduled_departure) <= 5 THEN 'Spring'
    WHEN EXTRACT (month from scheduled_departure) <= 8 THEN 'Summer'
    ELSE 'Fall' 
END as season
FROM flights
GROUP BY season;

/*
3. You want to create a tier list in the following way:

1. Rating is 'PG' or 'PG-13' or length is more then 210 min: 'Great rating or long (tier 1)'
2. Description contains 'Drama' and length is more than 90min: 'Long drama (tier 2)'
3. Description contains 'Drama' and length is not more than 90min: 'Shcity drama (tier 3)'
4. Rental_rate less than $1: 'Very cheap (tier 4)'

If one movie can be in multiple categories it gets the higher tier assigned.
How can you filter to only those movies that appear in one of these 4 tiers?
*/
SELECT * FROM film;

SELECT 
title,
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length > 90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Shcity drama (tier 3)'
	WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length > 90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Shcity drama (tier 3)'
	WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
END is not null;

-- /* 3. CASE WHEN & SUM */

SELECT 
rating,
CASE
	WHEN rating IN ('PG', 'G') THEN 1
	ELSE 0
END
FROM film;

SELECT 
SUM(CASE
		WHEN rating IN ('PG', 'G') THEN 1
		ELSE 0
	END) AS no_of_ratings_with_g_or_pg
FROM film;

SELECT 
rating,
COUNT(*)
FROM film
GROUP BY rating;

-- we want above example output rows into column
SELECT
SUM(CASE WHEN rating = 'PG' THEN 1 END) AS "PG",
SUM(CASE WHEN rating = 'R' THEN 1 END) AS "R",
SUM(CASE WHEN rating = 'NC-17' THEN 1 END) AS "NC-17",
SUM(CASE WHEN rating = 'PG-13' THEN 1 END) AS "PG-13",
SUM(CASE WHEN rating = 'G' THEN 1 END) AS "G"
FROM film;

/* 4. COALESCE

> Returns first value of a list of values which is not null

> Syntax : 
			COALESCE (actual_arrival, scheduled_arrival)
> note : both columns data type should be same other wise error
*/
SELECT 
actual_arrival-scheduled_arrival
FROM flights;

SELECT 
COALESCE(actual_arrival-scheduled_arrival, '0:00')
FROM flights;

SELECT
COALESCE(actual_arrival-scheduled_arrival, '1')
FROM flights;

/* 5. CAST

> Changes the data type of a value

> Syntax : 
		 CAST (value/column AS data type)
*/
-- Example
SELECT
COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR), 'Not Arrived')
FROM flights;

SELECT
LENGTH(CAST(actual_arrival AS VARCHAR))
FROM flights;

SELECT 
ticket_no as original_data_type,
CAST(ticket_no as bigint) as modified_data_type
FROM tickets;

SELECT
passenger_id -- CONTAIN WHITESPACE SO IT WILL NOT POSSIBLE IN CAST SO FOR THAT WE NEED TO REPLACE WHITESPACES AND THEN CAST
-- CAST(passenger_id, AS bigint)
FROM tickets;

-- CHALLANGE after COALESCE & CAST
/* FILL rental_date columns null with "no return"
			SELECT
			rental_date,
			return_date
			FROM rental
			ORDER BY rental_date DESC
*/
SELECT
rental_date,
COALESCE(CAST(return_date AS VARCHAR), 'not return')
FROM rental
ORDER BY rental_date DESC;


/* 6. REPLACE

> Replaces text from a string in a column with another text

> Syntax : 
		 REPLACE (column, old_text, new_text)
*/
-- Example
SELECT
* 
FROM tickets;

--Example: WHITEPACE replacement in passenger_id
SELECT
REPLACE(passenger_id, ' ', '')
FROM tickets;

-- Example : Now passenger_id data tye changed to bigint
SELECT
CAST(REPLACE(passenger_id, ' ', '') AS bigint)
FROM tickets;

-- Example: replace flight_noo with int
SELECT
flight_no
FROM flights;

SELECT
flight_no,
CAST(REPLACE(flight_no, 'PG', '' ) as int)
FROM flights;
