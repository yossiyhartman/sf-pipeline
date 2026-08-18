variable "environment" {
  description = "Environment short name: dev, staging, or prod. Drives naming for every database/role/warehouse — there are no Terraform workspaces, this is the only env switch."
  type        = string
}

variable "source_name" {
  description = "Short source identifier, e.g. \"northwind\". Used as name prefix."
  type        = string
}

variable "database_name" {
  description = "Plain (unquoted) name of the source database, e.g. \"NORTHWIND_DEV\"."
  type        = string
}

variable "warehouse_usage_role" {
  description = "Name of the warehouse USAGE access role (from modules/warehouses) this role should use."
  type        = string
}
