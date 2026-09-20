{{ config(
    materialized = 'table'
) }}

-- Grain: one row per NON-CLOSED account (acct_cls_flg = 'N'), with its
-- transaction activity from hist_transactional. Closed accounts are
-- excluded entirely, per requirement.
WITH txn_agg AS (
    SELECT
        account_id,
        COUNT(*)                    AS transaction_count,
        SUM(transaction_amount)     AS total_transaction_amount,
        MIN(transaction_date)       AS first_transaction_date,
        MAX(transaction_date)       AS last_transaction_date
    FROM
        {{ ref('stg_hist_transactional') }}
    GROUP BY
        account_id
)

SELECT
    a.account_id,
    a.customer_id,
    a.branch_id,
    a.product_id,
    a.schm_type,
    a.acct_crncy_code,
    COALESCE(t.transaction_count, 0)        AS transaction_count,
    COALESCE(t.total_transaction_amount, 0) AS total_transaction_amount,
    t.first_transaction_date,
    t.last_transaction_date
FROM
    {{ ref('stg_account') }} a
LEFT JOIN txn_agg t
    ON t.account_id = a.account_id
WHERE
    a.acct_cls_flg = 'N'
