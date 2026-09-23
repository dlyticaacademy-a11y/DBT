{{ config(
    materialized = 'table'
) }}

WITH casa_balance AS (

    SELECT
        SUM(account_balance) AS total_casa_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_casa = TRUE

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
    casa_balance.total_casa_balance,
    deposit_balance.total_deposit_balance,
    casa_balance.total_casa_balance / NULLIF(deposit_balance.total_deposit_balance, 0) AS casa_ratio
FROM
    casa_balance,
    deposit_balance
