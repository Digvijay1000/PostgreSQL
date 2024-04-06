-- DAY 6 (INTERMEDIATE) - 
/* -- JOINS --
> Joins : Combine information from multiple tables in one query
> Very important technique in SQL

> What are Joins
✓ How Joins work and how we use them practically
		INNER JOIN
		OUTER JOIN
		RIGHT JOIN
		LEFT JOIN
*/

-- 1. Inner Join
/* INNER JOIN
✓ Inner Join easiest join type.
✓ Inner Join combines the only rows appear in both table

Syntax : 
		SELECT * FROM tableA
		INNER JOIN tableB
		ON tableA.common_column = tableB.common_column
		.................................................
		Note: tableA at beginning or tableB at beggining doesn't matter result will be same,
		      because it is symmetrical opeartion
			  
	           or
			   
	    SELECT * FROM TableA AS A
		INNER JOIN TableB AS B
		ON A.employee = B.employee
		-------------------------------
		Aliases help with writing & reading the code more easily
		
		SELECT employee FROM TableA A
		INNER JOIN TableB B
		ON A.employee = B.employee
		
Always need a common column / reference
✓ INNER JOIN: Only rows where reference column value is in both tables
✓ Order of tables (A and B / B and A) does not matter 
✓ Repeated values in either table will also be repeated 

*/

--Example 
SELECT *
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT 
payment.*, 
first_name,
last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT 
payment_id,
payment.customer_id, -- common column need to define table name while displaying
amount,
first_name,
last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT 
payment.*, 
first_name,
last_name
FROM payment
INNER JOIN staff
ON staff.staff_id = payment.staff_id
WHERE staff.staff_id=1;

-- CHALLANGE
/*
The airline company wants to understand in which category they sell most 
tickets.

How many people choose seats in the category 
- Business 
- Economy or
- Comfort?

You need to work on the seats table and the boarding_passes table.
*/

SELECT 
fare_conditions,
COUNT(*)
FROM boarding_passes
INNER JOIN seats
ON boarding_passes.seat_no = seats.seat_no
GROUP BY fare_conditions;

-- THIS IS FOR INDIVIDUAL TABLE
SELECT 
fare_conditions,
COUNT(*)
FROM seats
GROUP BY fare_conditions;

/* 2. FULL OUTER JOIN
> JOINS THE TWO TABLES WITH ALL INFORMATION

> SYNTAX: 
        SELECT * FROM TableA
        FULL OUTER JOIN TableB
        ON TableA.employee = TableB.employee
*/
-- EXAMPLE
SELECT *
FROM boarding_passes b
FULL OUTER JOIN tickets t
ON b.ticket_no = t.ticket_no;

-- JOIN & WHERE
/*
Syntax:
		SELECT * FROM TableB
		FULL OUTER JOIN TableA
		ON TableA.employee = TableB.employee
		WHERE TableB.anycolumn IS null

*/
-- CHALLANGE 
-- Find the tickets that don't have a boarding pass realated to it
SELECT 
COUNT(*)
FROM boarding_passes b
FULL OUTER JOIN tickets t
ON b.ticket_no = t.ticket_no
WHERE 
b.ticket_no IS NULL;

SELECT 
COUNT(*)
FROM boarding_passes b
FULL OUTER JOIN tickets t
ON b.ticket_no = t.ticket_no
WHERE 
t.ticket_no IS NULL; -- just changed col a to col b

/* 3. LEFT OUTER JOIN (LEFT JOIN)
> JOINS THE TWO TABLE WITH ALL DATA FROM LEFT TABLE AND MATCHING DATA FROM RIGHT TABLE

> SYNTAX: 
        SELECT * FROM TableA
        LEFT OUTER JOIN TableB
        ON TableA.employee = TableB.employee
*/
-- EXAMPLE
SELECT * FROM aircrafts_data a
LEFT JOIN flights f
ON a.aircraft_code = f.aircraft_code;

-- find all aircrafts that have not been used in any flight
SELECT * FROM aircrafts_data a
LEFT JOIN flights f
ON a.aircraft_code = f.aircraft_code
WHERE f.flight_id is null;

-- CHALLANGE
/*
The flight company is trying to find out what their most popular seats are.

Try to find out which seat has been chosen most frequently.
Make sure all seats are included even if they have never been 
booked.

Are there seats that have never been booked?
*/
SELECT 
s.seat_no,
COUNT(*)
FROM seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
GROUP BY s.seat_no
ORDER BY COUNT(*) DESC;

-- Try to find out which line (A, B, …, H) has been chosen most frequently.
SELECT 
RIGHT(s.seat_no,1), -- RIGHT CHAR EXTRACTED
COUNT(*)
FROM seats s
LEFT JOIN boarding_passes b
ON s.seat_no = b.seat_no
GROUP BY RIGHT(s.seat_no,1)
ORDER BY COUNT(*) DESC;

/* 4. RIGHT OUTER JOIN (RIGHT JOIN)
> JOINS THE TWO TABLE WITH ALL DATA FROM RIGHT TABLE AND MATCHING DATA FROM LEFT TABLE

> SYNTAX: 
        SELECT * FROM TableA
        RIGHT OUTER JOIN TableB
        ON TableA.employee = TableB.employee
*/
-- EXAMPLE
SELECT * FROM aircrafts_data a
RIGHT JOIN flights f
ON a.aircraft_code = f.aircraft_code;

-- find all aircrafts that have not been used in any flight
SELECT * FROM flights f 
RIGHT JOIN aircrafts_data a
ON a.aircraft_code = f.aircraft_code
WHERE f.flight_id is null;

-- CHALLANGE ON JOINS
/*
The company wants to run a phone call campaing on all customers in Texas (=district).
1. What are the customers (first_name, last_name, phone number and their district) from Texas?
2. Are there any (old) addresses that are not related to any customer?
*/
-- 1. What are the customers (first_name, last_name, phone number and their district) from Texas?
SELECT first_name, last_name, phone, district FROM customer c
LEFT JOIN address a
ON a.address_id = c.address_id
WHERE district = 'Texas';

-- 2. Are there any (old) addresses that are not related to any customer?
SELECT * FROM address a
LEFT JOIN customer c
ON a.address_id = c.address_id
WHERE c.customer_id IS null;

SELECT * FROM customer c
RIGHT JOIN address a
ON a.address_id = c.address_id
WHERE c.customer_id IS null;

-- MULTIPLE JOIN CONDITIONS --

/* 
> SYNTAX: 
        SELECT * FROM TableA a
		INNER JOIN TableB b
		ON a.first_name = b.first_name
		AND a.last_name = b.last_name
		
> Expert Tip :
        SELECT * FROM TableA a
		INNER JOIN TableB b
		ON a.first_name = b.first_name
		AND a.last_name = 'Jones'           -- More performance efficient than below
		
		       or
			   
		SELECT * FROM TableA a
		INNER JOIN TableB b
		ON a.first_name = b.first_name
		WHERE a.last_name = 'Jones'

*/
-- EXAMPLE
SELECT * FROM ticket_flights;
SELECT * FROM boarding_passes;

--Create Joins between the table and calculate average price for the different seat_no
SELECT seat_no, ROUND(AVG(amount),2) FROM boarding_passes b
LEFT JOIN ticket_flights t
ON b.ticket_no = t.ticket_no
AND b.flight_id = t.flight_id
GROUP BY seat_no
ORDER BY 2 DESC;

-- JOINING MULTIPLE TABLES

SELECT * FROM tickets; -- ticket_no, passenger_name
SELECT * FROM flights; -- ticket_no, flight_id, scheduled_arrival
SELECT * FROM ticket_flights, -- ticket_no, flight_id

-- we want ticket_no, passenger_name and scheduled_arrival
SELECT t.ticket_no, passenger_name,f.scheduled_arrival FROM tickets t
INNER JOIN ticket_flights tf
ON t.ticket_no = tf.ticket_no
INNER JOIN flights f
ON f.flight_id = tf.flight_id;

-- CHALLANGE ON MULTIPLE TABLE JOIN
/*
1. The company wants customize their campaigns to customers depending on the country they are from.

Which customers are from Brazil?

Write a query to get first_name, last_name, email and the country from all customers from Brazil.
*/
SELECT first_name, last_name, email,  con.country FROM address a
INNER JOIN customer c
ON a.address_id = c.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country con
ON ct.country_id = con.country_id
WHERE country = 'Brazil'

-- 2. Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?
-- Answer: ALEKSANDR IVANOV with 80964000.00
SELECT t.passenger_name, SUM(b.total_amount) FROM bookings b
INNER JOIN tickets t
ON b.book_ref = t.book_ref
GROUP BY t.passenger_name
ORDER BY SUM(b.total_amount) DESC
LIMIT 1;

-- 3. Which fare_condition has ALEKSANDR IVANOV used the most?
-- Answer: Economy 2131 times.
SELECT fare_conditions, COUNT(*) FROM ticket_flights tf
INNER JOIN tickets t
ON tf.ticket_no = t.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 4. Which title has GEORGE LINTON rented the most often?
-- Answer: CADDYSHACK JEDI - 3 times.
SELECT first_name, last_name, title, COUNT(*)
FROM customer cu
INNER JOIN rental re
ON cu.customer_id = re.customer_id
INNER JOIN inventory inv
ON inv.inventory_id=re.inventory_id
INNER JOIN film fi
ON fi.film_id = inv.film_id
WHERE first_name='GEORGE' and last_name='LINTON'
GROUP BY title, first_name, last_name
ORDER BY 4 DESC;





