output "database_name" {
  value = {
    name                 = snowflake_database.db.name
    fully_qualified_name = snowflake_database.db.fully_qualified_name
  }
}

output "schema_names" {
  description = "Map of schema key -> schema name & fully qualified name"
  value = { for k, s in snowflake_schema.schema : k => {
    name                 = s.name
    fully_qualified_name = s.fully_qualified_name
  } }
}
