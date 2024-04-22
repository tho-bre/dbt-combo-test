WITH final AS (
    SELECT * FROM {{ ref('rests') }}
)
SELECT
    *
FROM
    final