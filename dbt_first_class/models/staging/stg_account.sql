{{ config(
    materialized = 'incremental',
    unique_key = 'foracid',
    incremental_strategy = 'merge'
) }}

-- update and insert (merge)
WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'account'
        ) }}

    {% if is_incremental() %}
    WHERE lchg_time > (SELECT MAX(lchg_time) FROM {{ this }})
    {% endif %}
),
FINAL AS (
    SELECT
        acid,
        foracid,
        cif_id,
        cust_id,
        sol_id,
        acct_name,
        acct_ownership,
        schm_type,
        schm_code,
        product_category,
        product_sub_category,
        gl_sub_head_code,
        acct_opn_date,
        acct_cls_flg,
        acct_cls_date,
        acct_status,
        acct_crncy_code,
        clr_bal_amt,
        sanct_lim,
        drwng_power,
        lien_amt,
        available_amount,
        interest_rate,
        last_tran_date,
        del_flg,
        entity_cre_flg,
        lchg_user_id,
        lchg_time
    FROM
        src
)
SELECT
    *
FROM
    FINAL
