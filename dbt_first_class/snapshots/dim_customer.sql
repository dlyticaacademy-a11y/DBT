{% snapshot dim_customer %}

{{
    config(
        target_schema='silver',
        unique_key='cust_id',
        strategy='check',
        check_cols='all',
    )
}}

WITH src AS (

    SELECT
        *
    FROM
        {{ source('banking', 'customer') }}

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
FROM
    src

{% endsnapshot %}
