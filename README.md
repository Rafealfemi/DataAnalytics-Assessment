# DataAnalytics-Assessment

This respository contains SQL solutions to the Data Analytics assessment questions.

## Question 1: High value Customer With Multiple Products
**APPROACH:** Identified customers with at least one funded savings and one funded investment plan. 
  Used subquery to counts investement plans per customer
  Used subsequery counts savings plans per customer
  Used  Subquery calculates total deposits per customer

**Challenge:**  
Avoiding double-counting and ensuring aggregation was done efficiently. 
Resolved using separate subqueries and filtered for customers having both product types.

## Question 2: Transaction Frequency Analysis 
**APPROACH:** Used CTE to get the Total number of transactions within transaction periods
              I used   Case when Months to get the When active Months_active greater than 0
              I used case when to classify into different High frequency,medium frequency,
              and low_frequency
 **CHALLENGE**   
           Doing between 3 to 9 will be short of some numbers so I had to do 3 to 9.99
           MYSQL Couldnt  run the initial codes using JOINS so I have to limit the number of joins 
           so as to optimise the query

  ## Question 3: Account Inactivity Alert  
**Approach:**  
Used a CTE to compute last transaction date per account. Filtered for accounts with no inflows in the last 365 days using `DATEDIFF()`.

**Challenge:**  
So as to ensure transaction timestamps align correctly with current date.  I Used `MAX(transaction_date)` to identify last activity.
And I had to reduce the number of joins becuase of optimization



## Question 4: Estimating Customer Lifetime Value (CLV)  
**Approach:**  
 I Calculated tenure in months, transaction volume, and average transaction value.I Used a formula to estimate CLV based on these metrics.

**Challenge:**  
Because of division by zero (tenure = 0) error.  I had to first Filtere such rows out using `WHERE tenure_months > 0`.



## Challenges Faced
- I had some  Queries  timeouts due to large joins ;I had to resolve it by using subqueries and selective joins.
- I was not sure of which name to use on the users_customuser table, I had to result to contatenating the first name and last name and aliased as name.


## CHEERS!
## FEMI OLAYEMI




           



