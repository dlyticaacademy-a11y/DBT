{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT *
    FROM {{ source('banking', 'customer') }}
)

SELECT
    cust_id,
    name,
    address,
    phone_number,
    postal_code,
    country,
    email,
    father_name,
    mother_name,
    occupation,
    education,
    nationality
FROM src
