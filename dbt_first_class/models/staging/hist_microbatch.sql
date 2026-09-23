{{ config(
    materialized       = 'incremental',
    incremental_strategy = 'microbatch',
    unique_key         = 'transaction_id',
    event_time         = 'tran_date',
    begin              = '2024-01-02',
    batch_size         = 'day'
) }}

with source as (

    select * from {{ source('banking', 'hist_transactional') }}

),

renamed as (

    select
        tran_id           as transaction_id,
        account_id,
        branch_id,
        tran_amount       as transaction_amount,
        tran_crncy        as transaction_currency,
        tran_date,
        tran_particular   as transaction_particular,
        tran_remarks      as transaction_remarks,
        created_date,
        modified_date
    from source

)

select * from renamed
