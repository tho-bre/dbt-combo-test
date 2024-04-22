WITH final AS (
    SELECT * FROM {{ ref('locations') }}
)
SELECT
    *
FROM
    final