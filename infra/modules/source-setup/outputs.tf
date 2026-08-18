output "database_name" {
  value = {
    name                 = snowflake_database.db.name
    fully_qualified_name = snowflake_database.db.fully_qualified_name
  }
}

output "ingestion_schema_reference" {
  description = "Reference to the ingestion schema"
  value = {
    name                 = snowflake_schema.ingestion_schema.name
    fully_qualified_name = snowflake_schema.ingestion_schema.fully_qualified_name
  }
}

output "transformation_schemas_reference" {
  description = "Reference to the transformation schemas"
  value = { for k, s in snowflake_schema.transformation_schemas : k => {
    name                 = s.name
    fully_qualified_name = s.fully_qualified_name
  } }
}

output "target_schema_reference" {
  description = "Reference to the target schema"
  value = {
    name                 = snowflake_schema.target_schema.name
    fully_qualified_name = snowflake_schema.target_schema.fully_qualified_name
  }
}

output "dbt_project_schema_reference" {
  description = "Reference to the dbt project schema"
  value = {
    name                 = snowflake_schema.dbt_project_schema.name
    fully_qualified_name = snowflake_schema.dbt_project_schema.fully_qualified_name
  }
}

output "target_schema_reference" {
  description = "Reference to the target schema"
  value = {
    name                 = snowflake_schema.observability_schema.name
    fully_qualified_name = snowflake_schema.observability_schema.fully_qualified_name
  }
}
