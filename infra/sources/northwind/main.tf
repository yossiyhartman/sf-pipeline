module "source_setup" {
  source      = "../../database_scaffold"
  source_name = "northwind"
  environment = var.environment
  schemas     = var.schemas
}
