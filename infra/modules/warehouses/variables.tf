variable "environment" {
  description = "Environment short name (e.g. dev, staging, prod). Suffixed onto every warehouse/role name."
  type        = string
}

variable "warehouses" {
  description = "Map of warehouse key (e.g. \"loading\") to its config. Each entry produces one warehouse plus one usage access role."
  type = map(object({
    size         = string
    auto_suspend = number
  }))
}
