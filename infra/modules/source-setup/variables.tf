variable "environment" {
  description = "Environment short name: dev, staging, or prod. Drives naming for every database/role/warehouse — there are no Terraform workspaces, this is the only env switch."
  type        = string
}

variable "source_name" {
  description = "Short source identifier, e.g. \"northwind\". Used as the database name prefix."
  type        = string
}

variable "ingestion_schema" {
  description = "Name of the schema where the data should land"
  type        = string
  nullable    = true
}

variable "transformation_schemas" {
  description = "Name of the schemas where the data is transformed"
  type        = list(string)
  nullable    = true
}

variable "target_schema" {
  description = "Name of the schema where the data should be made public"
  type        = string
}

variable "dbt_project_schema" {
  description = "Name of the schema where dbt projects live"
  type        = string
}

variable "observability_schema" {
  description = "Name of the schema where observability logic lives"
  type        = string
}

variable "data_retention_time_in_days" {
  description = "Time Travel retention for this source's database."
  type        = number
  default     = 1
}
