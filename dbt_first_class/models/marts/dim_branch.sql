{{ config(
    materialized = 'table'
) }}

SELECT
    branch_id,
    province,
    cluster_name,
    city_name,
    branch_name
FROM
    {{ ref('stg_branch') }}
