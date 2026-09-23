{{ config(
    materialized = 'table'
) }}

-- casa ratio = (current account + saving account )/total deposit (SA,CA,FD,RD)
SELECT
    account_id,
    customer_id,
    branch_id,
    product_id,
    schm_type,
    schm_code,
    account_balance,
    lien_amt,
    acct_cls_flg,
    CASE WHEN acct_cls_flg = 'Y' THEN TRUE ELSE FALSE END AS is_closed,
    acct_crncy_code,
    -- LD (loan) vs SA/CA/FD/RD (deposit) vs SA/CA (CASA, a subset of deposit)
    CASE WHEN schm_type = 'LD' THEN TRUE ELSE FALSE END AS is_loan,
    CASE WHEN schm_type IN ('SA', 'CA', 'FD', 'RD') THEN TRUE ELSE FALSE END AS is_deposit,
    CASE WHEN schm_type IN ('SA', 'CA') THEN TRUE ELSE FALSE END AS is_casa
FROM
    {{ ref('stg_account') }}
