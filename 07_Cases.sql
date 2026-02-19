SELECT c.cust_id, c.fed_id,
CASE
WHEN c.cust_type_cd = 'I'
THEN CONCAT(i.fname, ' ', i.lname)
 WHEN c.cust_type_cd = 'B'
THEN b.name
ELSE 'Unknown'
END name
FROM customer c LEFT OUTER JOIN individual i
ON c.cust_id = i.cust_id
LEFT OUTER JOIN business b
ON c.cust_id = b.cust_id;


SELECT c.cust_id, c.fed_id,
CASE
WHEN c.cust_type_cd = 'I' THEN
(SELECT CONCAT(i.fname, ' ', i.lname)
FROM individual i
WHERE i.cust_id = c.cust_id)
WHEN c.cust_type_cd = 'B' THEN
(SELECT b.name
FROM business b
 WHERE b.cust_id = c.cust_id)
ELSE 'Unknown'
END name
FROM customer c;



SELECT c.cust_id, c.fed_id, c.cust_type_cd,
   CASE
WHEN EXISTS (SELECT 1 FROM account a
WHERE a.cust_id = c.cust_id
AND a.product_cd = 'CHK') THEN 'Y'
ELSE 'N'
END has_checking,
CASE
WHEN EXISTS (SELECT 1 FROM account a
WHERE a.cust_id = c.cust_id
AND a.product_cd = 'SAV') THEN 'Y'
ELSE 'N'
END has_savings
FROM customer c;



SELECT emp_id,
CASE
WHEN title IN ('President', 'Vice President', 'Treasurer', 'Loan Manager')
THEN 'Management'
WHEN title IN ('Operations Manager', 'Head Teller', 'Teller')
THEN 'Operations'
ELSE 'Unknown'
END AS department_group
FROM employee;


SELECT
COUNT(CASE WHEN open_branch_id = 1 THEN 1 END) AS branch_1,
COUNT(CASE WHEN open_branch_id = 2 THEN 1 END) AS branch_2,
COUNT(CASE WHEN open_branch_id = 3 THEN 1 END) AS branch_3,
COUNT(CASE WHEN open_branch_id = 4 THEN 1 END) AS branch_4
FROM account;
