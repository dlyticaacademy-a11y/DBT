{{ config(
    materialized = 'table'
) }}

SELECT
    product_id,
    schm_type,
    schm_code,
    product_desc,
    -- Loan vs deposit classification, used to compute the loan/deposit and
    -- CASA ratios in fact_balance_ratios: LD is the only loan scheme type,
    -- SA/CA/FD/RD are all deposit scheme types.
    CASE
        WHEN schm_type = 'LD' THEN 'Loan'
        ELSE 'Deposit'
    END AS product_category
FROM
    {{ ref('stg_product') }}
