{% set inc_flag = 1 %}
{% set lastload = 3 %}

{% set tab_col = ["sales_id","date_sk","gross_amount"] %}

SELECT
    {% for col in tab_col %}
        {{ col }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM
    {{ ref('bronze_sales') }} 

{% if inc_flag == 1 %}
   
   WHERE date_sk > {{ lastload }}

{% endif %}