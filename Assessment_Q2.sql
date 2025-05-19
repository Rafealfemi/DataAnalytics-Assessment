-- This query helps to generate and categorize customers based on their average monthly transactions and put them in to different buckets

WITH transaction_counts AS (
    SELECT 
        a.id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(b.transaction_date), MAX(b.transaction_date)) + 1 AS months_active
    FROM users_customuser a
    JOIN savings_savingsaccount b ON a.id = b.owner_id
    GROUP BY a.id  -- This helps to count the Total transactions within the transaction periods
),
avg_monthly_freq AS (
    SELECT 
        id,
        total_transactions,
        months_active,
        CASE WHEN months_active > 0 
             THEN ROUND(total_transactions / months_active, 2)
             ELSE 0 
        END AS transactions_per_month
    FROM transaction_counts
) -- This helps to get the average transactions by Active months
SELECT 
    CASE 
        WHEN transactions_per_month >= 10 THEN 'High Frequency'
        WHEN transactions_per_month BETWEEN 3 AND 9.99 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(transactions_per_month), 2) AS avg_transactions_per_month
FROM avg_monthly_freq
GROUP BY frequency_category;	-- This helps to put the transaction frequency into different buckets