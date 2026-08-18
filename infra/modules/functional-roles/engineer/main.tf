resource "snowflake_account_role" "engineer" {
  name = "${var.source_name}_ENGINEER_${var.environment}"
}

# Database-level only: engineer creates and owns its own ad hoc schemas
# (by naming convention, e.g. "ENG_*") for exploratory work. It never gets
# grants on the terraform-managed schemas (LANDING/STAGING/INTERMEDIATE/MARTS).
resource "snowflake_grant_privileges_to_account_role" "database_access" {
  account_role_name = snowflake_account_role.engineer.name
  privileges        = ["USAGE", "CREATE SCHEMA"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_account_role" "warehouse_usage" {
  role_name        = var.warehouse_usage_role
  parent_role_name = snowflake_account_role.engineer.name
}

resource "snowflake_grant_account_role" "to_sysadmin" {
  role_name        = snowflake_account_role.engineer.name
  parent_role_name = "SYSADMIN"
}
