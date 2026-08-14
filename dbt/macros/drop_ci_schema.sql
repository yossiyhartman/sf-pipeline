{% macro drop_ci_schema() %}

    {%- if target.name != 'ci' -%}
        {{ exceptions.raise_compiler_error("drop_ci_schema can only run against the 'ci' target") }}
    {%- endif -%}

    {%- set custom_schemas = ['staging', 'intermediate', 'marts'] -%}
    {%- set schema_names = [target.schema] -%}
    {%- for custom_schema in custom_schemas -%}
        {%- do schema_names.append(target.schema ~ '_' ~ custom_schema) -%}
    {%- endfor -%}

    {%- for schema_name in schema_names -%}
        {%- set drop_sql = 'DROP SCHEMA IF EXISTS ' ~ target.database ~ '.' ~ schema_name -%}
        {{ log('Dropping CI schema: ' ~ schema_name, info=true) }}
        {% do run_query(drop_sql) %}
    {%- endfor -%}

{% endmacro %}
