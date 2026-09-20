{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT *
    FROM {{ source('banking', 'card') }}
)

SELECT
    card_number,
    account_id,
    balance,
    card_type,
    closing_balance,
    card_expiry_date
FROM src
