SELECT * FROM dcbank;


-- KPI 1 --

SELECT ROUND(SUM(amount), 2) AS total_credit_amount 
FROM dcbank 
WHERE transaction_type = 'Credit';


-- KPI 2 --

SELECT ROUND(SUM(amount), 2) AS total_credit_amount 
FROM dcbank 
WHERE transaction_type = 'Debit';


-- KPI 3 --

SELECT 
    concat(ROUND((SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) / 
           SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)) * 100, 2), "%")
    AS credit_to_debit_ratio
FROM dcbank;


-- KPI 4 --
SELECT 
    round((SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) -
    SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END)), 2)
    AS net_transaction_amount
FROM dcbank;


-- KPI 5 --

SELECT 
    concat(ROUND((Count(amount) / SUM(balance)) * 100, 5), "%")
    AS account_activity_ratio
FROM dcbank;


-- KPI 6 --

SELECT 
    transaction_date,
    weekofyear(transaction_date) AS weekly_transaction,
    monthname(transaction_date) AS monthly_transaction,
    COUNT(*) AS total_transactions
FROM dcbank
GROUP BY transaction_date, weekly_transaction, monthly_transaction
ORDER BY transaction_date;


-- KPI 7 --

SELECT 
    branch, 
    round(SUM(amount),2) AS total_transaction_amount
FROM dcbank
GROUP BY branch
ORDER BY total_transaction_amount DESC;


-- KPI 8 --

SELECT 
    Bank_Name, 
    round(SUM(amount),2) AS total_transaction_amount
FROM dcbank
GROUP BY Bank_Name
ORDER BY total_transaction_amount DESC;


-- KPI 9 --

SELECT 
    transaction_method,
    COUNT(*) AS transaction_count,
    concat((ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM dcbank), 2)),"%") AS transaction_percentage
FROM dcbank
GROUP BY transaction_method
ORDER BY transaction_percentage DESC;


-- KPI 10 --

WITH MonthlyTotals AS (
    SELECT 
        branch,
        YEAR(transaction_date) AS trans_year,
        MONTH(transaction_date) AS trans_month,
        SUM(amount) AS total_transaction_amount
    FROM dcbank
    GROUP BY branch, trans_year, trans_month
)
SELECT 
    branch,
    trans_year,
    trans_month,
    total_transaction_amount,
    LAG(total_transaction_amount) OVER (PARTITION BY branch ORDER BY trans_year, trans_month) AS previous_month_amount,
    ROUND(
        ((total_transaction_amount - LAG(total_transaction_amount) OVER (PARTITION BY branch ORDER BY trans_year, trans_month)) / 
        NULLIF(LAG(total_transaction_amount) OVER (PARTITION BY branch ORDER BY trans_year, trans_month), 0)) * 100, 
        2
    ) AS percentage_change
FROM MonthlyTotals
ORDER BY branch, trans_year, trans_month;


-- KPI 11 --

SELECT 
    branch,
    transaction_date,
    transaction_type,
    amount,
    CASE 
        WHEN amount > 4000.00 THEN 'High Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM dcbank;


-- KPI 12 --

SELECT 
    YEAR(transaction_date) AS trans_year,
    MONTH(transaction_date) AS trans_month,
    COUNT(*) AS high_risk_count
FROM dcbank
WHERE amount > 4000.00
GROUP BY trans_year, trans_month
ORDER BY trans_year, trans_month;














