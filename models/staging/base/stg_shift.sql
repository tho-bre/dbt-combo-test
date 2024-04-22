WITH final AS (
    SELECT * FROM {{ ref('shifts') }}
)
SELECT
    *
FROM
    final