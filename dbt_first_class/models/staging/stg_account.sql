{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'account_id',
    on_schema_change = 'sync_all_columns'
) }}

WITH src AS (

    SELECT
        *
    FROM
        {{ source('banking', 'account') }}

    {% if is_incremental() %}
    WHERE
        lchg_time > (SELECT MAX(lchg_time) FROM {{ this }})
    {% endif %}

)

SELECT
    account_id,
    customer_id,
    branch_id,
    account_balance,
    lien_amt,
    acct_cls_flg,
    product_id,
    schm_type,
    schm_code,
    acct_crncy_code,
    lchg_time
FROM
    src
