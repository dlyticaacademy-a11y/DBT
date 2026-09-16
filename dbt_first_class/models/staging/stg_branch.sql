WITH src AS (

    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'branches'
        ) }}
),
FINAL AS (
    SELECT
      branch_id,
      branch_name,
      city,
      manager_name
    FROM
        src
)
SELECT
    *
FROM
    FINAL