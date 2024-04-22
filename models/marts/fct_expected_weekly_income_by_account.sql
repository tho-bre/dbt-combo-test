WITH accountable_location_by_week AS (
    SELECT * FROM {{ ref('fct_accountable_location_by_week') }}
),
final AS (
    SELECT
        account_id,
        weekly_id,
        SUM(weekly_price) AS nb_accountable_employees
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