resource "snowflake_account_role" "analyst" {
  name = "${var.source_name}_ANALYST_${var.environment}"
}

resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "target_schema_usage" {
  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = var.target_schema
  }
}

resource "snowflake_grant_privileges_to_account_role" "target_schema_select_existing" {
  for_each = toset(["TABLES", "VIEWS"])

  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = each.value
      in_schema          = var.target_schema
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "target_schema_select_future" {
  for_each = toset(["TABLES", "VIEWS"])

  account_role_name = snowflake_account_role.analyst.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = each.value
      in_schema          = var.target_schema
    }
  }
}

resource "snowflake_grant_account_role" "warehouse_usage" {
  role_name        = var.warehouse_usage_role
  parent_role_name = snowflake_account_role.analyst.name
}

resource "snowflake_grant_account_role" "to_sysadmin" {
  role_name        = snowflake_account_role.analyst.name
  parent_role_name = "SYSADMIN"
}
