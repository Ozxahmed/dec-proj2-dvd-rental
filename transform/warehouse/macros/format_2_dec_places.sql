{% macro format_2_dec_places(column_expression) %}
    (round({{ column_expression }}, 2))
{% endmacro %}
