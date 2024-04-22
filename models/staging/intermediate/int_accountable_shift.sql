WITH shift AS (
    SELECT * FROM {{ ref('stg_shift') }}
),
user_contracts AS (
    SELECT * FROM {{ ref('stg_user_contract') }}
),
final AS (
    SELECT DISTINCT
        uc.membership_id,
        uc.location_id,
        EXTRACT(YEAR FROM s.starts_at) * 100 + EXTRACT(ISOWEEK FROM s.starts_at) AS weekly_id
    FROM
        shift AS s
        INNER JOIN user_contracts AS uc ON
            s.user_contract_id = uc.id
)
SELECT
    *
FROM
    final
