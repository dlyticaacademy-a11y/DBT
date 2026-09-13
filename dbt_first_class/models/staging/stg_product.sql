{{ config(
    materialized = 'table'
) }}

WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'product'
        ) }}
),
FINAL AS (
    SELECT
        product_id,
        schm_type,
        schm_code,
        product_desc,
        created_date,
        modified_date
    FROM
        src
)
SELECT
    *
FROM
    FINAL
