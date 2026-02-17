-- Chapter 5: GROUP BY & HAVING (firm database)

SELECT cust_type_cd, COUNT(*) AS total_customers
FROM customer
GROUP BY cust_type_cd;

SELECT state, COUNT(*) AS branches_in_state
FROM branch
GROUP BY state;

SELECT dept_id, COUNT(*) AS employees_count
FROM employee
GROUP BY dept_id;

SELECT assigned_branch_id, COUNT(*) AS employees_count
FROM employee
GROUP BY assigned_branch_id;

SELECT open_branch_id, COUNT(*) AS accounts_opened
FROM account
GROUP BY open_branch_id;

SELECT product_cd, COUNT(*) AS accounts_per_product
FROM account
GROUP BY product_cd
ORDER BY accounts_per_product DESC;

SELECT cust_id, SUM(avail_balance) AS total_balance
FROM account
GROUP BY cust_id
ORDER BY total_balance DESC;

SELECT open_emp_id, SUM(avail_balance) AS total_managed_balance
FROM account
GROUP BY open_emp_id
ORDER BY total_managed_balance DESC;

SELECT execution_branch_id, COUNT(*) AS total_transactions
FROM transaction
GROUP BY execution_branch_id;

SELECT account_id, SUM(amount) AS total_transaction_amount
FROM transaction
GROUP BY account_id
ORDER BY total_transaction_amount DESC;

SELECT product_cd, AVG(avail_balance) AS avg_balance
FROM account
GROUP BY product_cd;

SELECT status, COUNT(*) AS accounts_by_status
FROM account
GROUP BY status;

SELECT cust_id, COUNT(*) AS accounts_count
FROM account
GROUP BY cust_id
HAVING accounts_count > 1;

SELECT open_branch_id, SUM(avail_balance) AS branch_balance
FROM account
GROUP BY open_branch_id
HAVING branch_balance > 20000;

SELECT execution_branch_id, SUM(amount) AS branch_txn_volume
FROM transaction
GROUP BY execution_branch_id
HAVING branch_txn_volume > 10000;

SELECT dept_id, COUNT(*) AS emp_count
FROM employee
GROUP BY dept_id
HAVING emp_count >= 3;
