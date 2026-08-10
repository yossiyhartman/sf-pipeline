output "database_name" {
  value = {
    name                 = snowflake_database.db.name
    fully_qualified_name = snowflake_database.db.fully_qualified_name
  }
}

output "schema_names" {
  description = "Map of schema key -> schema name."
  value       = { for k, s in snowflake_schema.schema : k => s.fully_qualified_name }
}
