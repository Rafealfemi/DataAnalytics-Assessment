-- This query identifies customers who have both a funded savings plan and a funded investment plan
-- It also calculates the total amount deposited by each customer (in Naira)

SELECT 
    u.id, 
    CONCAT(u.first_name, ' ', u.last_name) AS name,  -- This gives me Full name of the customer
  sp.savings_count,
  ip.investment_count,
ROUND(sd.total_deposits / 100, 2) AS total_deposits   -- This converts from kobo to naira and leaves in 2 decimal places
FROM users_customuser u
LEFT JOIN (
    SELECT 
        owner_id, 
        COUNT(DISTINCT id) AS savings_count
    FROM plans_plan
    WHERE is_regular_savings = 1 
    GROUP BY owner_id
) sp ON u.id = sp.owner_id   --  This Subquery counts savings plans per customer
LEFT JOIN (
    SELECT 
        owner_id, 
        COUNT(DISTINCT id) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1 
    GROUP BY owner_id
) ip ON u.id = ip.owner_id   -- This Subquery counts investment plans per customer
LEFT JOIN (
    SELECT 
        owner_id, 
        SUM(confirmed_amount) AS total_deposits
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
) sd ON u.id = sd.owner_id    -- This Subquery calculates total deposits per customer
WHERE sp.savings_count IS NOT NULL AND ip.investment_count IS NOT NULL
GROUP BY u.id, name
ORDER BY total_deposits DESC;
