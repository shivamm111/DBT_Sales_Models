WITH sales AS (
    SELECT
        sales_id,
        product_sk,
        {{ multiply('unit_price', 'quantity') }} AS calculated_gross_amount,
        customer_sk,
        gross_amount,
        payment_method
    FROM
        {{ ref('bronze_sales') }}
),

products AS (
    SELECT
        product_sk,
        category
    FROM
        {{ ref('bronze_product') }}
),

customer AS (
    SELECT
        gender,
        customer_sk
    FROM
        {{ ref('bronze_customer') }}
),

joined_query AS (
SELECT
    s.sales_id,
    s.product_sk,
    s.calculated_gross_amount,
    s.customer_sk,
    s.gross_amount,
    s.payment_method,
    bp.category,
    c.gender
FROM
    sales s
JOIN
    products bp ON s.product_sk = bp.product_sk  
JOIN
    customer c ON s.customer_sk = c.customer_sk 
)

SELECT 
    category,
    gender,
    ROUND(SUM(calculated_gross_amount),2) AS total_calculated_gross_amount
FROM 
    joined_query
GROUP BY
    category,
    gender
ORDER BY
    total_calculated_gross_amount DESC