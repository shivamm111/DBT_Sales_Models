{%- set fruits = ["apple","banana","cherry","kiwi","mango"] -%}     

{% for fruit in fruits %}
   {% if fruit != "cherry" %}
        {{ fruit }}
    {% else %}
        i hate {{ fruit }}
    {% endif %}

{% endfor %}