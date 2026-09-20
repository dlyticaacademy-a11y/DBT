{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT *
    FROM {{ source('banking', 'product') }}
)

SELECT
    product_id,
    schm_type,
    schm_code,
    product_desc
FROM src
