WITH final AS (
    SELECT * FROM {{ ref('memberships') }}
)
SELECT
    *
FROM
    final