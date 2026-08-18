variable "role_name" {
  description = "Name of the functional role (typically the ingestor role) to grant these privileges to."
  type        = string
}

variable "ingestion_schema" {
  description = "Fully qualified name of the landing schema this ingestion pattern operates in."
  type        = string
}
