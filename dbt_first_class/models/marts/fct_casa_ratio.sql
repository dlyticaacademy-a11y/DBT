{{ config(
    materialized = 'table'
) }}

-- Step 1: total balance of CASA accounts only (is_casa = TRUE means schm_type IN ('SA','CA'))
WITH casa_balance AS (

    SELECT
        SUM(account_balance) AS total_casa_balance
    FROM
        {{ ref('fact_account') }}
    WHERE
        is_casa = TRUE

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

-- Step 3: casa / deposit ratio
SELECT
    casa_balance.total_casa_balance,
    deposit_balance.total_deposit_balance,
    casa_balance.total_casa_balance / NULLIF(deposit_balance.total_deposit_balance, 0) AS casa_ratio
FROM
    casa_balance,
    deposit_balance
