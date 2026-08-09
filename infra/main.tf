######
# Shared
######

module "warehouses" {
  source = "./modules/warehouses"

  environment = var.environment
  warehouses = {
    adhoc        = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    loading      = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    transforming = { size = "XSMALL", auto_suspend = 60 /* seconds */ }
    reporting    = { size = "XSMALL", auto_suspend = 60 /* seconds */ }

  }
}

#######
# Sources
#######

module "source_northwind" {
  source      = "./sources/northwind"
  environment = var.environment
}
