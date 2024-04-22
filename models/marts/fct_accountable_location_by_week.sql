WITH accountable_membership_by_location AS (
    SELECT * FROM {{ ref('fct_accountable_membership_by_location') }}
),
location_not_archives AS (
    SELECT * FROM {{ ref('int_location_not_archives') }}
),
location_stat AS (
    SELECT
        lna.account_id,
        aml.location_id,
        aml.weekly_id,
        COUNT(aml.membership_id) AS nb_employees,
        GREATEST(COUNT(aml.membership_id) - 6, 0) AS nb_accountable_employees,
        CASE 
            WHEN COUNT(aml.membership_id) < 6 THEN 'micro_location'
            WHEN COUNT(aml.membership_id) < 40 THEN 'small_location'
            ELSE 'big_location'
        END AS location_type,
        CASE 
            WHEN COUNT(aml.membership_id) < 6 THEN 60
            WHEN COUNT(aml.membership_id) < 40 THEN 80
            ELSE 216
        END AS location_type_price
    FROM
        accountable_membership_by_location AS aml
        INNER JOIN location_not_archives AS lna ON aml.location_id = lna.id
    GROUP BY
        lna.account_id,
        aml.location_id,
        aml.weekly_id
),
final AS (
    SELECT
        account_id,
        location_id,
        weekly_id,
        nb_employees,
        nb_accountable_employees,
        location_type,
        location_type_price,
        location_type_price + nb_accountable_employees * 4 AS weekly_price
    FROM
        location_stat
)
SELECT
    *
FROM
    final
