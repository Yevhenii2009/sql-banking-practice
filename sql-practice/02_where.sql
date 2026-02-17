-- Chapter 2: WHERE (MySQL)

SELECT * FROM customer WHERE active = 1;

SELECT * FROM customer WHERE active = 0;

SELECT * FROM customer WHERE store_id = 1;

SELECT * FROM customer WHERE store_id = 1 AND active = 1;

SELECT * FROM customer WHERE store_id = 1 OR store_id = 2;

SELECT * FROM customer WHERE NOT active = 1;

SELECT * FROM payment WHERE amount > 5;

SELECT * FROM payment WHERE amount >= 5;

SELECT * FROM payment WHERE amount < 3;

SELECT * FROM payment WHERE amount <> 0;

SELECT * FROM payment WHERE amount BETWEEN 2 AND 5;

SELECT * FROM payment WHERE amount NOT BETWEEN 2 AND 5;

SELECT * FROM film WHERE rating IN ('PG', 'G');

SELECT * FROM film WHERE rating NOT IN ('R', 'NC-17');

SELECT * FROM customer WHERE first_name LIKE 'A%';

SELECT * FROM customer WHERE first_name LIKE '%a';

SELECT * FROM customer WHERE first_name LIKE '%an%';

SELECT * FROM customer WHERE first_name LIKE '_a%';

SELECT * FROM address WHERE address2 IS NULL;

SELECT * FROM address WHERE address2 IS NOT NULL;

SELECT * FROM customer 
WHERE (store_id = 1 AND active = 1)
   OR (store_id = 2 AND active = 0);

SELECT * FROM payment 
WHERE amount > 5 AND payment_date >= '2005-07-01';

SELECT * FROM payment 
WHERE DATE(payment_date) = '2005-07-05';

SELECT * FROM customer 
WHERE customer_id IN (
    SELECT customer_id 
    FROM rental
);

SELECT * FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
);

SELECT * FROM customer 
WHERE email LIKE '%@gmail.com';

SELECT * FROM customer 
WHERE LENGTH(first_name) > 5;
