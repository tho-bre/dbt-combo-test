WITH accountable_rest AS (
    SELECT * FROM {{ ref('int_accountable_rest') }}
),
accountable_shift AS (
    SELECT * FROM {{ ref('int_accountable_shift') }}
),
final AS (
    SELECT
        membership_id,
        location_id,
        weekly_id
    FROM
        accountable_rest
    UNION ALL
    SELECT
        membership_id,
        location_id,
        weekly_id
    FROM
        accountable_shift
)
SELECT DISTINCT
    membership_id, 
    location_id,
    weekly_id
FROM
    final