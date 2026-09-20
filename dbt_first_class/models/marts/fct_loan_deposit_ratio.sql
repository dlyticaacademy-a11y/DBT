{{ config(
    materialized = 'table'
) }}

-- Step 1: total balance of loan accounts only (is_loan = TRUE means schm_type = 'LD')
WITH loan_balance AS (

    SELECT
        SUM(account_balance) AS total_loan_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_loan = TRUE

),

-- Step 2: total balance of deposit accounts (is_deposit = TRUE means schm_type IN ('SA','CA','FD','RD'))
deposit_balance AS (

    SELECT
        SUM(account_balance) AS total_deposit_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_deposit = TRUE

)

-- Step 3: loan / deposit ratio
SELECT
    loan_balance.total_loan_balance,
    deposit_balance.total_deposit_balance,
    loan_balance.total_loan_balance / NULLIF(deposit_balance.total_deposit_balance, 0) AS loan_deposit_ratio
FROM
    loan_balance,
    deposit_balance
