{% macro bool_to_int(boolean_field) %}
  CASE
    WHEN {{ boolean_field }} = TRUE THEN 1
    WHEN {{ boolean_field }} = FALSE THEN 0
    ELSE NULL
  END
{% endmacro %}
