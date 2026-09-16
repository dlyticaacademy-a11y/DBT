WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'products'
        ) }}
),
FINAL AS (
    SELECT
      account_id,
      customer_id,
      account_type,
      balance,
      open_date,
      status
    FROM
        src
)
SELECT
    *
FROM
    FINAL