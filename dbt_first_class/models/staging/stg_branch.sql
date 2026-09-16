{{ config(
    materialized = 'table'
) }}

WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'branch'
        ) }}
),
FINAL AS (
    SELECT
        branch_sol_id,
        branch_open_date,
        city_code,
        address1,
        address2,
        branch_code,
        branch_description,
        state_code,
        lchg_user_id,
        lchg_time
    FROM
        src
)
SELECT
    *
FROM
    FINAL
