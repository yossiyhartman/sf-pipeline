variable "source_name" {
  description = "Short source identifier, e.g. \"northwind\". Used as the database name prefix."
  type        = string
}

variable "environment" {
  description = "Environment short name (e.g. dev, staging, prod)."
  type        = string
}

variable "schemas" {
  description = "Schemas to create in this source's database. Must include \"RAW\" — that's where the landing stage/file format are created."
  type        = list(string)
  default     = ["RAW", "STAGING", "INTERMEDIATE", "MARTS"]

  validation {
    condition     = contains(var.schemas, "RAW")
    error_message = "schemas must include \"RAW\" so raw data has somewhere to land."
  }
}

variable "data_retention_time_in_days" {
  description = "Time Travel retention for this source's database."
  type        = number
  default     = 1
}
