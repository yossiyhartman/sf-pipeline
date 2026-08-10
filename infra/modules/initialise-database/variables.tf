variable "environment" {
  description = "Environment short name: dev, staging, or prod. Drives naming for every database/role/warehouse — there are no Terraform workspaces, this is the only env switch."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "source_name" {
  description = "Short source identifier, e.g. \"northwind\". Used as the database name prefix."
  type        = string
}

variable "schemas" {
  description = "Schemas to create in this source's database. Must include \"LANDING\" — that's where the landing stage/file format are created."
  type        = list(string)
  default     = ["LANDING", "STAGING", "INTERMEDIATE", "MARTS"]

  validation {
    condition     = contains(var.schemas, "LANDING")
    error_message = "List of schemas must include a LANDING layer."
  }
}

variable "data_retention_time_in_days" {
  description = "Time Travel retention for this source's database."
  type        = number
  default     = 1
}
