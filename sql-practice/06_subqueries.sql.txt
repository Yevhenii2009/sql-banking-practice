-- Chapter 6: Subqueries (firm database)

SELECT *
FROM account
WHERE avail_balance > (
    SELECT AVG(avail_balance)
    FROM account
);

SELECT *
FROM employee
WHERE start_date = (
    SELECT MIN(start_date)
    FROM employee
);

SELECT *
FROM branch
WHERE branch_id IN (
    SELECT open_branch_id
    FROM account
);

SELECT *
FROM customer
WHERE cust_id IN (
    SELECT cust_id
    FROM account
    GROUP BY cust_id
    HAVING SUM(avail_balance) > 5000
);

SELECT *
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM account a
    WHERE a.open_emp_id = e.emp_id
);

SELECT *
FROM employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM account a
    WHERE a.open_emp_id = e.emp_id
);

SELECT *
FROM account
WHERE avail_balance = (
    SELECT MAX(avail_balance)
    FROM account
);

SELECT *
FROM transaction
WHERE amount > (
    SELECT AVG(amount)
    FROM transaction
);

SELECT *
FROM account
WHERE cust_id = (
    SELECT cust_id
    FROM account
    GROUP BY cust_id
    ORDER BY SUM(avail_balance) DESC
    LIMIT 1
);

SELECT *
FROM (
    SELECT open_branch_id, SUM(avail_balance) AS total_balance
    FROM account
    GROUP BY open_branch_id
) AS branch_totals
WHERE total_balance > 20000;

SELECT *
FROM (
    SELECT open_emp_id, COUNT(*) AS accounts_opened
    FROM account
    GROUP BY open_emp_id
) AS emp_stats
WHERE accounts_opened > 2;
