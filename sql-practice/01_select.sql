-- Chapter 1: SELECT (firm database)

SELECT * FROM department;

SELECT dept_id, name FROM department;

SELECT branch_id, name, city, state FROM branch;

SELECT fname, lname, title FROM employee;

SELECT fname, lname, start_date FROM employee ORDER BY start_date;

SELECT product_cd, name FROM product;

SELECT cust_id, cust_type_cd, city FROM customer;

SELECT fname, lname, birth_date FROM individual;

SELECT name, state_id FROM business;

SELECT account_id, product_cd, avail_balance FROM account;

SELECT txn_id, txn_date, amount FROM transaction;

SELECT fname, lname, CONCAT(fname, ' ', lname) AS full_name
FROM employee;

SELECT avail_balance, avail_balance * 1.05 AS balance_with_bonus
FROM account;

SELECT DISTINCT city FROM branch;

SELECT DISTINCT cust_type_cd FROM customer;

SELECT COUNT(*) FROM employee;

SELECT COUNT(*) FROM account;

SELECT SUM(avail_balance) FROM account;

SELECT AVG(avail_balance) FROM account;

SELECT MIN(avail_balance), MAX(avail_balance) FROM account;

SELECT NOW();

SELECT DATABASE();
