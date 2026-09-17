{{ config(
    materialized = 'incremental',
    unique_key = 'foracid',
    incremental_strategy = 'merge'
)
}}

WITH src AS (

    SELECT
     *
    FROM
        {{ source(
            'crmuser', 
            'transactions'
        ) }} 

    {% if is_incremental() %}

    WHERE 
        lchg_time >= (
            SELECT 
            MAX(lchg_time)
            FROM   
             {{ this }}
        )
    {% endif %}
)
    SELECT
    transaction_key ,
    tran_id ,
    part_tran_srl_num ,
    acid ,
    cust_id ,
    tran_date ,
    year ,
    month ,
    day ,
    tran_particular ,
    tran_rmks ,
    tran_type ,
    tran_sub_type ,
    part_tran_type,
    tr_status ,
    gl_sub_head_code ,
    ref_num ,
    acct_balance ,
    sol_id ,
    dth_init_sol_id ,
    tran_amt,
    tran_crncy_code ,
    ref_crncy_code ,
    tran_channel_type ,
    pstd_flg ,
    lchg_time 
    
    FROM src
