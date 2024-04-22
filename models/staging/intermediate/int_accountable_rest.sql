WITH rest AS (
    SELECT * FROM {{ ref('stg_rest') }}
),
user_contract AS (
    SELECT * FROM {{ ref('stg_user_contract') }}
),
date_range_rest AS (
  SELECT 
    id,
    GENERATE_DATE_ARRAY(CAST(starts_at AS DATE), CAST(ends_at AS DATE), INTERVAL 1 DAY) as date_array
  FROM 
    rest
),
date_unnested_rest AS (
    SELECT DISTINCT
        id,
        EXTRACT(YEAR FROM date) * 100 + EXTRACT(ISOWEEK FROM date) AS weekly_id
    FROM 
        date_range_rest,
        UNNEST(date_range_rest.date_array) as date
),
final AS (
    SELECT DISTINCT
        uc.membership_id,
        uc.location_id,
        dur.weekly_id
    FROM 
        date_unnested_rest AS dur
        INNER JOIN rest AS r ON
            dur.id = r.id
        INNER JOIN user_contract AS uc ON
            r.user_contract_id = uc.id
)
SELECT
    *
FROM
    final
    