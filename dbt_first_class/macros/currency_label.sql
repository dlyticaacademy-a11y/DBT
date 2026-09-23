{% macro currency_label(currency_column) %}
    case
        when {{ currency_column }} in ('USD', 'CAD')              then 'AMERICAN'
        when {{ currency_column }} in ('NPR', 'INR', 'SGD', 'JPY') then 'ASIAN'
        when {{ currency_column }} in ('EUR', 'GBP')              then 'EUROPEAN'
        when {{ currency_column }} in ('AED')                     then 'MIDDLE_EAST'
        when {{ currency_column }} in ('AUD')                     then 'OCEANIAN'
        else 'UNKNOWN'
    end
{% endmacro %}