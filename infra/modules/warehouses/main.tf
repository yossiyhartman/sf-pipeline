resource "snowflake_warehouse" "this" {
  for_each = var.warehouses

  name                = "${upper(each.key)}_WH_${upper(var.environment)}"
  warehouse_size      = each.value.size
  auto_suspend        = each.value.auto_suspend
  auto_resume         = true
  initially_suspended = true
}

resource "snowflake_account_role" "usage" {
  for_each = var.warehouses

  name    = "AR_WH_${upper(each.key)}_${upper(var.environment)}_USAGE"
  comment = "Grants USAGE/OPERATE on ${snowflake_warehouse.this[each.key].name}."
}

resource "snowflake_grant_privileges_to_account_role" "usage" {
  for_each = var.warehouses

  account_role_name = snowflake_account_role.usage[each.key].name
  privileges        = ["USAGE", "OPERATE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this[each.key].name
  }
}

resource "snowflake_grant_account_role" "usage_to_sysadmin" {
  for_each = var.warehouses

  role_name        = snowflake_account_role.usage[each.key].name
  parent_role_name = "SYSADMIN"
}
