{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if custom_schema_name is none -%}

        {{ target.schema }}

    {%- elif target.name == 'prod' -%}

        {# prod is the shared "general" target: bare layer schemas (STAGING, MARTS, ...), no per-run prefix. #}
        {{ custom_schema_name | trim }}

    {%- else -%}

        {# dev/ci: prefix with target.schema so personal runs and per-PR CI runs never collide with each other or with prod. #}
        {{ target.schema }}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}
