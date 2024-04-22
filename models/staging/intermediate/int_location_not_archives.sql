WITH location AS (
    SELECT * FROM {{ ref('stg_location') }}
)
SELECT
    id, 
    name,
    account_id
FROM
    location
WHERE
    archived IS FALSE