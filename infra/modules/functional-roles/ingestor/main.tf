resource "snowflake_account_role" "ingestor" {
  name = "${var.source_name}_INGESTOR_${var.environment}"
}

# No schema-level grants here on purpose: what the ingestor is actually
# allowed to create in the landing schema depends on the ingestion pattern
# (batch/stage, snowpipe, ...) and is granted by the matching
# modules/ingestion-patterns/* module, passing this role's name as input.
resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = snowflake_account_role.ingestor.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_account_role" "warehouse_usage" {
  role_name        = var.warehouse_usage_role
  parent_role_name = snowflake_account_role.ingestor.name
}

resource "snowflake_grant_account_role" "to_sysadmin" {
  role_name        = snowflake_account_role.ingestor.name
  parent_role_name = "SYSADMIN"
}
