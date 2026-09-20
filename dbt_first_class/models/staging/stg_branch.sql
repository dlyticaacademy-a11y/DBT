{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT *
    FROM {{ source('banking', 'branch') }}
)

SELECT
    branch_id,
    province,
    cluster_name,
    city_name,
    branch_name
FROM src
