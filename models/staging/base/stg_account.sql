WITH final AS (
    SELECT * FROM {{ ref('accounts') }}
)
SELECT
    *
FROM
    final