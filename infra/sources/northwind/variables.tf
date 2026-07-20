variable "environment" {
  description = "Environment short name: dev, staging, or prod. Drives naming for every database/role/warehouse — there are no Terraform workspaces, this is the only env switch."
  type        = string
}
