variable "environment" {
  type = string
}

variable "warehouse_usage_roles" {
  description = "Map of warehouse key (adhoc/loading/transforming/reporting/deploy) to its USAGE access role name, from modules/warehouses."
  type        = map(string)
}
