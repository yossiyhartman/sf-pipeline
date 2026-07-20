output "warehouse_names" {
  description = "Map of warehouse key -> fully-qualified warehouse name."
  value       = { for k, w in snowflake_warehouse.this : k => w.name }
}

output "usage_access_role_names" {
  description = "Map of warehouse key -> access role name granting USAGE/OPERATE on that warehouse. Feed this into every source's source_rbac module."
  value       = { for k, r in snowflake_account_role.usage : k => r.name }
}
