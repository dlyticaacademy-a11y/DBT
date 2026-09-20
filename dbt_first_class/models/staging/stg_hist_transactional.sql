{{ config(
    materialized = 'incremental',
    incremental_strategy = 'append'
) }}

with source as (

    select * from {{ source('banking', 'hist_transactional') }}

    {% if is_incremental() %}
    where modified_date > (select coalesce(max(modified_date), '1900-01-01') from {{ this }})
    {% endif %}

),

renamed as (

    select
        tran_id           as transaction_id,
        account_id,
        branch_id,
        tran_amount       as transaction_amount,
        tran_crncy        as transaction_currency,
        tran_date         as transaction_date,
        tran_particular   as transaction_particular,
        tran_remarks      as transaction_remarks,
        created_date,
        modified_date
    from source

)

select * from renamed
