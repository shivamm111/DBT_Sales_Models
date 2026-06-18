WITH dedup_query AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY updateDate ORDER BY updateDate DESC) AS deduplicated_id
    FROM
        {{ source('source', 'items') }}

)

SELECT
    id,name,category,updateDate
FROM
    dedup_query
