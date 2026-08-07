
module "source_setup" {
  source      = "../../modules/initialise-database"
  source_name = "northwind"
  environment = var.environment
  schemas     = var.schemas
}
