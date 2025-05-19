-- This queries gives the customer's lifetime value based on account tenure and transaction volume

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,

    -- Estimate CLV: (monthly_tx_rate * 12 months * avg_tx_value * 0.001) / 100
    ROUND(
        (
            (COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) * 12
            * (AVG(s.confirmed_amount) * 0.001)
        ) / 100,
        2
    ) AS estimated_clv

FROM users_customuser u
LEFT JOIN savings_savingsaccount s 
    ON u.id = s.owner_id AND s.confirmed_amount > 0

-- Only include users with tenure > 0 months
WHERE TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) > 0

GROUP BY u.id, u.first_name, u.last_name, u.date_joined

ORDER BY estimated_clv DESC;
