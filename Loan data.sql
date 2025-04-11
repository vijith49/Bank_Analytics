-- KPI 1--

SELECT CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_amount_funded
FROM loan_data;

-- KPI 2 --

SELECT COUNT(*) AS Total_loans
FROM loan_data;

-- KPI 3 --

SELECT concat(round((sum(total_rec_prncp) + sum(total_rrec_int))/ 1000000, 2), 'M') AS total_collection
FROM loan_data;

-- KPI 4 --

SELECT concat(round((SUM(total_rrec_int))/ 1000000, 2), 'M') AS total_interest
FROM loan_data;

-- KPI 5 --

SELECT 
    branch_name, 
    concat(round((sum(total_fees) + sum(total_rec_late_fee) + Sum(recoveries) 
    + Sum(collection_recovery_fee) + sum(total_rrec_int))/ 1000000, 2), 'M') AS total_revenue
FROM loan_data
GROUP BY branch_name
ORDER BY Branch_Name asc;

-- KPI 6 --

SELECT 
    state_name, 
    COUNT(*) AS total_loans
FROM loan_data
GROUP BY state_name
ORDER BY total_loans DESC;

-- KPI 7 --

SELECT 
    religion, 
    CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_amount
FROM loan_data
GROUP BY religion
ORDER BY SUM(funded_amount) DESC;

-- KPI 8 --

SELECT 
    purpose_category, 
    concat(round(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_amount
FROM loan_data
GROUP BY purpose_category
ORDER BY sum(Funded_Amount) desc;

-- KPI 9 --

SELECT 
    DATE_FORMAT(disbursement_date, '%Y-%m') AS year_months, 
    CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_disbursed
FROM loan_data	
GROUP BY year_months
ORDER BY year_months;

-- KPI 10 --

SELECT 
    grade, 
    CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_amount
FROM loan_data
GROUP BY grade
ORDER BY grade;

-- KPI 11 --

SELECT 
    COUNT(*) AS total_defaulted_loans
FROM loan_data
WHERE Is_Default_Loan = 'Y';

-- KPI 12 --

SELECT 
    COUNT(*) AS total_defaulted_loans
FROM loan_data
WHERE Is_Delinquent_Loan = 'Y';

-- KPI 13 --

SELECT 
   concat(ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM loan_data), 2), '%') AS delinquency_rate
FROM loan_data
WHERE is_delinquent_loan = 'Y';

-- KPI 14 --

SELECT 
   concat(ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM loan_data), 2), '%') AS default_rate
FROM loan_data
WHERE Is_Default_Loan = 'Y';

-- KPI 15 --

SELECT 
    loan_status, 
    COUNT(*) AS total_loans
FROM loan_data
GROUP BY loan_status
ORDER BY total_loans DESC;

-- KPI 16 --

SELECT 
    age, 
    CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_amount
FROM loan_data
GROUP BY age
ORDER BY SUM(Funded_Amount) DESC;

-- KPI 17 --

SELECT 
    COUNT(*) AS total_loans_not_verified
FROM loan_data
WHERE verification_status = 'Not Verified';

-- KPI 18 --

SELECT 
    Term_in_months, 
    CONCAT(ROUND(SUM(funded_amount) / 1000000, 2), 'M') AS total_loan_amount
FROM loan_data
GROUP BY Term_in_months
ORDER BY SUM(Funded_Amount) DESC;


