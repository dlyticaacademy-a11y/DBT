{{ config(
    materialized = 'table'
) }}

WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'customer'
        ) }}
),
FINAL AS (
    SELECT
        cif_id,
        full_name,
        cust_first_name,
        cust_middle_name,
        cust_last_name,
        primary_sol_id,
        crncy_code,
        occupation,
        education,
        riskrating,
        pan,
        status,
        email,
        phone_home,
        constitution_code,
        segmentation_class,
        staffflag,
        blacklisted,
        seniorcitizen,
        relationshipopeningdate,
        bodatecreated
    FROM
        src
)
SELECT
    *
FROM
    FINAL
