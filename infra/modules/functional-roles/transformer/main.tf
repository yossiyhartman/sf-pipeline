resource "snowflake_account_role" "transformer" {
  name = "${var.source_name}_TRANSFORMER_${var.environment}"
}

resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = var.database_name
  }
}

# Narrower than deployer on purpose: object-level create/materialize rights
# for routine dbt runs, but no CREATE SCHEMA / CREATE DBT PROJECT — a
# scheduled run can't take out a whole schema or the project definition.
resource "snowflake_grant_privileges_to_account_role" "transformation_schema_materialize" {
  for_each = toset(var.transformation_schemas)

  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["USAGE", "CREATE TABLE", "CREATE VIEW"]

  on_schema {
    schema_name = each.value
  }
}

# Execute whatever dbt project deployer creates/redeploys, including future ones.
resource "snowflake_grant_privileges_to_account_role" "transformation_schema_execute_dbt_project" {
  for_each = toset(var.transformation_schemas)

  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["USAGE"]

  on_schema_object {
    future {
      object_type_plural = "DBT PROJECTS"
      in_schema          = each.value
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "ingestion_schema_read" {
  for_each = toset(["TABLES", "VIEWS"])

  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = each.value
      in_schema          = var.ingestion_schema
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "ingestion_schema_read_existing" {
  for_each = toset(["TABLES", "VIEWS"])

  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["SELECT"]

  on_schema_object {
    all {
      object_type_plural = each.value
      in_schema          = var.ingestion_schema
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "ingestion_schema_usage" {
  account_role_name = snowflake_account_role.transformer.name
  privileges        = ["USAGE"]

  on_schema {
    schema_name = var.ingestion_schema
  }
}

resource "snowflake_grant_account_role" "warehouse_usage" {
  role_name        = var.warehouse_usage_role
  parent_role_name = snowflake_account_role.transformer.name
}

resource "snowflake_grant_account_role" "to_sysadmin" {
  role_name        = snowflake_account_role.transformer.name
  parent_role_name = "SYSADMIN"
}
