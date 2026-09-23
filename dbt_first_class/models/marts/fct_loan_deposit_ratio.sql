{{ config(
    materialized = 'table'
) }}

WITH loan_balance AS (

    SELECT
        SUM(account_balance) AS total_loan_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_loan = TRUE

),

deposit_balance AS (

    SELECT
        SUM(account_balance) AS total_deposit_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_deposit = TRUE

)

SELECT
    loan_balance.total_loan_balance,
    deposit_balance.total_deposit_balance,
    loan_balance.total_loan_balance / NULLIF(deposit_balance.total_deposit_balance, 0) AS loan_deposit_ratio
FROM
    loan_balance,
    deposit_balance
