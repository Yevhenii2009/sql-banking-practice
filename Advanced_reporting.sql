-- Advanced Banking Analytics (firm database)
-- Complex reporting queries combining JOIN, GROUP BY, subqueries, CASE, and derived tables


-- 1 Full customer financial profile (individual + business unified)

SELECT 
    c.cust_id,
    CASE 
        WHEN c.cust_type_cd = 'I' THEN CONCAT(i.fname, ' ', i.lname)
        WHEN c.cust_type_cd = 'B' THEN b.name
    END AS customer_name,
    c.cust_type_cd,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.avail_balance) AS total_balance,
    SUM(a.pending_balance) AS total_pending,
    COUNT(t.txn_id) AS total_transactions,
    SUM(t.amount) AS total_transaction_volume
FROM customer c
LEFT JOIN individual i ON c.cust_id = i.cust_id
LEFT JOIN business b ON c.cust_id = b.cust_id
LEFT JOIN account a ON c.cust_id = a.cust_id
LEFT JOIN transaction t ON a.account_id = t.account_id
GROUP BY c.cust_id
ORDER BY total_balance DESC;


-- 2 Branch performance dashboard

SELECT 
    br.name AS branch_name,
    COUNT(DISTINCT e.emp_id) AS total_employees,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    SUM(a.avail_balance) AS total_balance,
    COUNT(DISTINCT t.txn_id) AS total_transactions,
    SUM(t.amount) AS transaction_volume
FROM branch br
LEFT JOIN employee e ON br.branch_id = e.assigned_branch_id
LEFT JOIN account a ON br.branch_id = a.open_branch_id
LEFT JOIN transaction t ON br.branch_id = t.execution_branch_id
GROUP BY br.branch_id
ORDER BY total_balance DESC;


-- 3 Employee productivity ranking

SELECT *
FROM (
    SELECT 
        e.emp_id,
        CONCAT(e.fname, ' ', e.lname) AS employee_name,
        d.name AS department,
        COUNT(a.account_id) AS accounts_opened,
        SUM(a.avail_balance) AS managed_balance,
        COUNT(t.txn_id) AS transactions_handled,
        SUM(t.amount) AS transaction_volume
    FROM employee e
    LEFT JOIN department d ON e.dept_id = d.dept_id
    LEFT JOIN account a ON e.emp_id = a.open_emp_id
    LEFT JOIN transaction t ON e.emp_id = t.teller_emp_id
    GROUP BY e.emp_id
) AS employee_stats
ORDER BY managed_balance DESC;


-- 4 Customers whose total balance is above branch average

SELECT *
FROM (
    SELECT 
        c.cust_id,
        SUM(a.avail_balance) AS total_balance,
        a.open_branch_id
    FROM customer c
    JOIN account a ON c.cust_id = a.cust_id
    GROUP BY c.cust_id, a.open_branch_id
) AS customer_totals
WHERE total_balance > (
    SELECT AVG(branch_total)
    FROM (
        SELECT open_branch_id, SUM(avail_balance) AS branch_total
        FROM account
        GROUP BY open_branch_id
    ) AS branch_avg
);


-- 5 Hierarchy analysis (manager → subordinate count)

SELECT 
    CONCAT(m.fname, ' ', m.lname) AS manager_name,
    COUNT(e.emp_id) AS subordinates
FROM employee m
JOIN employee e ON m.emp_id = e.superior_emp_id
GROUP BY m.emp_id
ORDER BY subordinates DESC;


-- 6 Product profitability overview

SELECT 
    p.name AS product_name,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.avail_balance) AS total_balance,
    SUM(t.amount) AS transaction_volume,
    CASE
        WHEN SUM(a.avail_balance) > 20000 THEN 'High Value'
        WHEN SUM(a.avail_balance) BETWEEN 5000 AND 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS product_category
FROM product p
LEFT JOIN account a ON p.product_cd = a.product_cd
LEFT JOIN transaction t ON a.account_id = t.account_id
GROUP BY p.product_cd
ORDER BY total_balance DESC;


-- 7 Risk analysis: frozen or inactive high-balance accounts

SELECT 
    a.account_id,
    a.status,
    a.avail_balance,
    c.cust_id,
    CASE
        WHEN a.status = 'FROZEN' THEN 'Operational Risk'
        WHEN a.status = 'CLOSED' AND a.avail_balance > 0 THEN 'Data Integrity Issue'
        ELSE 'Normal'
    END AS risk_flag
FROM account a
JOIN customer c ON a.cust_id = c.cust_id
WHERE a.status <> 'ACTIVE'
ORDER BY a.avail_balance DESC;


-- 8 Top 5 customers by transaction volume

SELECT *
FROM (
    SELECT 
        c.cust_id,
        SUM(t.amount) AS total_volume
    FROM customer c
    JOIN account a ON c.cust_id = a.cust_id
    JOIN transaction t ON a.account_id = t.account_id
    GROUP BY c.cust_id
) AS ranked_customers
ORDER BY total_volume DESC
LIMIT 5;
