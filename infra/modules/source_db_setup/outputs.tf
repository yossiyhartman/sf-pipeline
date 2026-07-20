output "database_name" {
  value = snowflake_database.this.name
}

output "schema_names" {
  description = "Map of schema key (e.g. \"RAW\") -> schema name."
  value       = { for k, s in snowflake_schema.this : k => s.name }
}
