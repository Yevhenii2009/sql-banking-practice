-- Chapter 3 ORDER BY (MySQL)

SELECT  FROM film ORDER BY title;

SELECT  FROM film ORDER BY title ASC;

SELECT  FROM film ORDER BY title DESC;

SELECT  FROM film ORDER BY rental_rate;

SELECT  FROM film ORDER BY rental_rate DESC;

SELECT  FROM film ORDER BY rental_rate DESC, title ASC;

SELECT title, rental_rate 
FROM film
ORDER BY rental_rate DESC;

SELECT first_name, last_name
FROM customer
ORDER BY last_name, first_name;

SELECT first_name, LENGTH(first_name) AS name_length
FROM customer
ORDER BY name_length DESC;

SELECT title, rental_rate  1.2 AS new_rate
FROM film
ORDER BY new_rate DESC;

SELECT title, rental_rate
FROM film
ORDER BY 2 DESC;

SELECT 
FROM payment
ORDER BY payment_date DESC;

SELECT 
FROM payment
ORDER BY DATE(payment_date);

SELECT 
FROM customer
ORDER BY active DESC, store_id ASC;

SELECT 
FROM customer
ORDER BY last_name
LIMIT 10;

SELECT 
FROM customer
ORDER BY last_name
LIMIT 10 OFFSET 10;

SELECT DISTINCT rating
FROM film
ORDER BY rating;

SELECT title, release_year
FROM film
ORDER BY release_year DESC, title ASC;

SELECT 
FROM film
WHERE rental_rate  2
ORDER BY rental_rate DESC;

SELECT 
FROM film
ORDER BY RAND()
LIMIT 5;

SELECT 
FROM film
ORDER BY rental_rate IS NULL, rental_rate;

SELECT 
FROM customer
ORDER BY LENGTH(last_name), last_name;
