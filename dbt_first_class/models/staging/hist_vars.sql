{{ config(
    materialized = 'incremental',
    incremental_strategy = 'append'
    
) }}

with source as (

    select * from {{ source('banking', 'hist_transactional') }}

      {% if is_incremental() %}
      where tran_date > (SELECT max(transaction_date) FROM {{ this }})
      {% endif %}

),

renamed as (

    select
        tran_id           as transaction_id,
        account_id,
        branch_id,
        tran_amount       as transaction_amount,
        tran_crncy        as transaction_currency,
        CASE 
          WHEN tran_crncy = 'USD' THEN   tran_amount * {{ var('USD') }}
          WHEN tran_crncy = 'AUD' THEN  tran_amount* {{var('AUD')}}
          WHEN tran_crncy = 'INR' THEN  tran_amount* {{var('INR')}}
        ELSE tran_amount
        END as converted_currency,
        tran_date         as transaction_date,
        tran_particular   as transaction_particular,
        tran_remarks      as transaction_remarks,
        created_date,
        modified_date
    from source

)

select * from renamed
