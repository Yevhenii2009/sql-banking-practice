/* 
   SOLUTIONS.SQL
   Database: Bank Example
   Chapters 3–11 Solutions
                           */


/*CHAPTER 3*/

/* 3.1 */
SELECT emp_id, fname, lname
FROM employee
ORDER BY lname, fname;

/* 3.2 */
SELECT account_id, cust_id, avail_balance
FROM account
WHERE status = 'ACTIVE'
  AND avail_balance > 2500;

/* 3.3 */
SELECT DISTINCT open_emp_id
FROM account;

/* 3.4 */
SELECT p.product_cd, a.cust_id, a.avail_balance
FROM product p
INNER JOIN account a
  ON p.product_cd = a.product_cd
WHERE p.product_type_cd = 'ACCOUNT';


/*CHAPTER 4*/

/* 4.1 */
SELECT txn_id
FROM transaction
WHERE txn_date < '2005-02-26'
  AND (txn_type_cd = 'DBT' OR amount > 100);

/* 4.2 */
SELECT txn_id
FROM transaction
WHERE account_id IN (101,103)
  AND NOT (txn_type_cd = 'DBT' OR amount > 100);

/* 4.3 */
SELECT account_id, open_date
FROM account
WHERE open_date BETWEEN '2002-01-01' AND '2002-12-31';

/* 4.4 */
SELECT cust_id, lname, fname
FROM individual
WHERE lname LIKE '_a%e%';


/*CHAPTER 5*/

/* 5.1 */
SELECT e.emp_id, e.fname, e.lname, b.name
FROM employee e
INNER JOIN branch b
  ON e.assigned_branch_id = b.branch_id;

/* 5.2 */
SELECT a.account_id, c.fed_id, p.name
FROM account a
INNER JOIN customer c
  ON a.cust_id = c.cust_id
INNER JOIN product p
  ON a.product_cd = p.product_cd
WHERE c.cust_type_cd = 'I';

/* 5.3 */
SELECT e.emp_id, e.fname, e.lname
FROM employee e
INNER JOIN employee mgr
  ON e.superior_emp_id = mgr.emp_id
WHERE e.dept_id <> mgr.dept_id;


/*CHAPTER 6*/

/* 6.2 */
SELECT fname, lname
FROM individual
UNION
SELECT fname, lname
FROM employee;

/* 6.3 */
SELECT fname, lname
FROM individual
UNION ALL
SELECT fname, lname
FROM employee
ORDER BY lname;


/*CHAPTER 7*/

/* 7.1 */
SELECT SUBSTRING('Please find the substring in this string',17,9);

/* 7.2 */
SELECT ABS(-25.76823),
       SIGN(-25.76823),
       ROUND(-25.76823, 2);

/* 7.3 */
SELECT EXTRACT(MONTH FROM CURRENT_DATE());


/*CHAPTER 8*/

/* 8.1 */
SELECT COUNT(*)
FROM account;

/* 8.2 */
SELECT cust_id, COUNT(*) AS account_count
FROM account
GROUP BY cust_id;

/* 8.3 */
SELECT cust_id, COUNT(*) AS account_count
FROM account
GROUP BY cust_id
HAVING COUNT(*) >= 2;

/* 8.4 */
SELECT product_cd,
       open_branch_id,
       SUM(avail_balance) AS total_balance
FROM account
GROUP BY product_cd, open_branch_id
HAVING COUNT(*) > 1
ORDER BY total_balance DESC;


/*CHAPTER 9*/

/* 9.1 — Uncorrelated Subquery */
SELECT account_id, product_cd, cust_id, avail_balance
FROM account
WHERE product_cd IN (
  SELECT product_cd
  FROM product
  WHERE product_type_cd = 'LOAN'
);

/* 9.2 — Correlated Subquery */
SELECT a.account_id, a.product_cd, a.cust_id, a.avail_balance
FROM account a
WHERE EXISTS (
  SELECT 1
  FROM product p
  WHERE p.product_cd = a.product_cd
    AND p.product_type_cd = 'LOAN'
);

/* 9.3 */
SELECT e.emp_id, e.fname, e.lname, levels.name
FROM employee e
INNER JOIN (
  SELECT 'trainee' name, '2004-01-01' start_dt, '2005-12-31' end_dt
  UNION ALL
  SELECT 'worker', '2002-01-01', '2003-12-31'
  UNION ALL
  SELECT 'mentor', '2000-01-01', '2001-12-31'
) levels
ON e.start_date BETWEEN levels.start_dt AND levels.end_dt;

/* 9.4 */
SELECT e.emp_id,
       e.fname,
       e.lname,
       (SELECT d.name
        FROM department d
        WHERE d.dept_id = e.dept_id) AS dept_name,
       (SELECT b.name
        FROM branch b
        WHERE b.branch_id = e.assigned_branch_id) AS branch_name
FROM employee e;


/*CHAPTER 10*/

/* 10.1 */
SELECT p.product_cd, a.account_id, a.cust_id, a.avail_balance
FROM product p
LEFT OUTER JOIN account a
  ON p.product_cd = a.product_cd;

/* 10.2 */
SELECT p.product_cd, a.account_id, a.cust_id, a.avail_balance
FROM account a
RIGHT OUTER JOIN product p
  ON p.product_cd = a.product_cd;

/* 10.3 */
SELECT a.account_id,
       a.product_cd,
       i.fname,
       i.lname,
       b.name
FROM account a
LEFT OUTER JOIN business b
  ON a.cust_id = b.cust_id
LEFT OUTER JOIN individual i
  ON a.cust_id = i.cust_id;

/* 10.4 */
SELECT ones.x + tens.x + 1 AS number
FROM
 (SELECT 0 x UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL
  SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL
  SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
  SELECT 9) ones
CROSS JOIN
 (SELECT 0 x UNION ALL SELECT 10 UNION ALL SELECT 20 UNION ALL
  SELECT 30 UNION ALL SELECT 40 UNION ALL SELECT 50 UNION ALL
  SELECT 60 UNION ALL SELECT 70 UNION ALL SELECT 80 UNION ALL
  SELECT 90) tens;


/* CHAPTER 11 */

/* 11.1 */
SELECT emp_id,
  CASE
    WHEN title LIKE '%President'
         OR title = 'Loan Manager'
         OR title = 'Treasurer'
      THEN 'Management'
    WHEN title LIKE '%Teller'
         OR title = 'Operations Manager'
      THEN 'Operations'
    ELSE 'Unknown'
  END AS category
FROM employee;

/* 11.2 */
SELECT
  SUM(CASE WHEN open_branch_id = 1 THEN 1 ELSE 0 END) AS branch_1,
  SUM(CASE WHEN open_branch_id = 2 THEN 1 ELSE 0 END) AS branch_2,
  SUM(CASE WHEN open_branch_id = 3 THEN 1 ELSE 0 END) AS branch_3,
  SUM(CASE WHEN open_branch_id = 4 THEN 1 ELSE 0 END) AS branch_4
FROM account;
