WITH final AS (
    SELECT * FROM {{ ref('user_contracts') }}
)
SELECT
    *
FROM
    final