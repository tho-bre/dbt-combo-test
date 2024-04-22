WITH accountable_location_by_week AS (
    SELECT * FROM {{ ref('fct_accountable_location_by_week') }}
),
final AS (
    SELECT
        account_id,
        weekly_id,
        COUNT(*) AS nb_location,
        SUM(nb_accountable_employees) AS nb_accountable_employees
    FROM
        accountable_location_by_week
    GROUP BY
        account_id,
        weekly_id
)
SELECT
    *
FROM
    final