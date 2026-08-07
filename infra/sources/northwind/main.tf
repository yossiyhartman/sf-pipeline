
module "source_setup" {
  source = "../../modules/initialise-database"

  environment = var.environment

  source_name = "northwind"
  schemas     = ["LANDING", "STAGING", "INTERMEDIATE", "MARTS"]
}
