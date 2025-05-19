-- This queries Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

WITH last_tx AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'nil'
        END AS plan_type, -- This helps get the customers with savings and investement plans
        (
            SELECT MAX(s.transaction_date)
            FROM savings_savingsaccount s
            WHERE s.owner_id = p.owner_id AND s.confirmed_amount > 0
        ) AS last_transaction_date
    FROM plans_plan p
    WHERE p.is_regular_savings = 1 -- This fetches the latest transaction date
)
SELECT 
    plan_id,
    owner_id,
    plan_type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM last_tx
WHERE last_transaction_date IS NOT NULL
  AND DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY inactivity_days DESC
LIMIT 50; -- This fetches the inactivie customers that have not transacted in the last 365 Days