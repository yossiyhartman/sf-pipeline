
module "source_setup" {
  source      = "../../modules/source_db_setup"
  source_name = "northwind"
  environment = var.environment
  schemas     = var.schemas
}
