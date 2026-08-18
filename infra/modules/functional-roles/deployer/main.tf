resource "snowflake_account_role" "deployer" {
  name = "${var.source_name}_DEPLOYER_${var.environment}"
}

resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = snowflake_account_role.deployer.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_project_schema_usage" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = var.dbt_project_schema
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_project_schema_ddl" {
  account_role_name = snowflake_account_role.deployer.name
  privileges        = ["CREATE DBT PROJECT"]

  on_schema {
    schema_name = dbt_project_schema
  }
}

resource "snowflake_grant_account_role" "warehouse_usage" {
  role_name        = var.warehouse_usage_role
  parent_role_name = snowflake_account_role.deployer.name
}

resource "snowflake_grant_account_role" "to_sysadmin" {
  role_name        = snowflake_account_role.deployer.name
  parent_role_name = "SYSADMIN"
}
